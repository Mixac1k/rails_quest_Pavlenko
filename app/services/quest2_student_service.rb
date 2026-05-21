class Quest2StudentService
  class << self
    # @return [String]
    def all_agents
      Agent.order(:id).pluck(:codename).join("\n")
    end

    # @return [String]
    def all_missions
      Mission.order(:title).pluck(:title).join("\n")
    end

    # @return [String]
    def agents_with_missions
      Agent.order(:codename).map do |agent|
        missions = agent.missions.order(:title).pluck(:title)
        "#{agent.codename}: #{missions.join(', ')}"
      end.join("\n")
    end

    # @return [String]
    def agents_with_missions_sorted_by_mission_count
      Agent.left_joins(:missions)
       .group('agents.id')
       .select('agents.*, COUNT(missions.id) AS missions_count')
       .order('missions_count DESC, agents.codename ASC')
       .map do |agent|
         missions = agent.missions.order(:title).pluck(:title)
         "#{agent.codename} (#{agent.missions_count}): #{missions.join(', ')}"
       end.join("\n")
    end

    # @return [String]
    def agents_with_skills
      Agent.order(:codename).map do |agent|
        skills = agent.skills.order(:name).pluck(:name)
        "#{agent.codename}: #{skills.join(', ')}"
      end.join("\n")
    end

    # @return [String]
    def skills_by_agent_count
      Skill.left_joins(:agents)
       .group('skills.id')
       .select('skills.*, COUNT(agents.id) AS agent_count')
       .order('agent_count DESC, skills.name ASC')
       .map do |skill|
         agents = skill.agents.order(:codename).pluck(:codename)
         "#{skill.name} (#{skill.agent_count}): #{agents.join(', ')}"
       end.join("\n")
    end
  end
end
