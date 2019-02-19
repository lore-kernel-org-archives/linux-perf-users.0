From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
Subject: [PATCH 0/2] perf evsel: add support for inlined function in callchains
Date: Tue, 19 Feb 2019 19:38:08 +0100
Message-ID: <cover.1550600520.git.jonas.rabenstein@studium.uni-erlangen.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-perf-users@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Andi Kleen <ak@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, Stephane Eranian <eranian@google.com>, Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi,
sample__fprintf_callchain currently did not use the already available
code to get the symbols of an inlined function if such information is
available in a dso. This patchset adds the required logic to add
appropriate lines.

As I am quite new to the code base of perf I am not sure how to test
that changeset in a correct way. At least the codes builds and the tools
that make use of sample__fprintf_callchain (perf-script, perf-trace and
perf-sched as far as I can see) did not fail to run - also I did not get
into the details of perf-trace and perf-sched as I have never used them
before.

Another thing I am not sure how to deal with are some warnings of
checkpatch.pl due to the 80 character line limit. Due to the long
function names in use the current implementation already exceeded that
limit in the same spots by even more characters as I have taken the
inner loop and put it into a separate function.

I hope to expand my work to perf-report but thought it might be usefull
to get already early feedback on those patches.

Thank you,
 Jonas

Jonas Rabenstein (2):
  perf evsel: split sample__fprintf_callchain in output and iteration
  perf evsel: add inline functions to sample callchain output

 tools/perf/util/evsel_fprintf.c | 157 ++++++++++++++++++++++----------
 1 file changed, 109 insertions(+), 48 deletions(-)

-- 
2.19.2
