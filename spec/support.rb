# frozen_string_literal: true

module FixtureSupport
  def perfect_score_response
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nCarl\nPinfalls"\
    "\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\t\tX\tX\tX\tX\nScore\t\t30\t\t60"\
    "\t\t90\t\t120\t\t150\t\t180\t\t210\t\t240\t\t270\t\t300\n"
  end

  def all_rolls_zero_response
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nJonathan\n"\
    "Pinfalls\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0\t0"\
    "\nScore\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\nMartin\n"\
    "Pinfalls\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF\tF"\
    "\nScore\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\t\t0\n"
  end

  def regular_score_response
    "Frame\t\t1\t\t2\t\t3\t\t4\t\t5\t\t6\t\t7\t\t8\t\t9\t\t10\nJeff\nPinfalls"\
    "\t\tX\t7\t/\t9\t0\t\tX\t0\t8\t8\t/\tF\t6\t\tX\t\tX\tX\t8\t1\nScore\t\t20"\
    "\t\t39\t\t48\t\t66\t\t74\t\t84\t\t90\t\t120\t\t148\t\t167\nJohn\nPinfalls"\
    "\t3\t/\t6\t3\t\tX\t8\t1\t\tX\t\tX\t9\t0\t7\t/\t4\t4\tX\t9\t0\nScore\t\t16"\
    "\t\t25\t\t44\t\t53\t\t82\t\t101\t\t110\t\t124\t\t132\t\t151\n"
  end
end
