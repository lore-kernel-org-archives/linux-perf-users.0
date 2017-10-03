From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/8] perf test attr: Fix python error on empty result
Date: Tue,  3 Oct 2017 09:55:34 -0300
Message-ID: <20171003125540.331-3-acme@kernel.org>
References: <20171003125540.331-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171003125540.331-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.vnet.ibm.com>

Commit d78ada4a767 ("perf tests attr: Do not store failed events") does
not create an event file in the /tmp directory when the
perf_open_event() system call failed.

This can lead to a situation where not /tmp/event-xx-yy-zz result file
exists at all (for example on a s390x virtual machine environment) where
no CPUMF hardware is available.

The following command then fails with a python call back chain instead
of printing failure:

  [root@s8360046 perf]# /usr/bin/python2 ./tests/attr.py -d ./tests/attr/ \
      -p ./perf -v -ttest-stat-basic
  running './tests/attr//test-stat-basic'
  Traceback (most recent call last):
    File "./tests/attr.py", line 379, in <module>
      main()
    File "./tests/attr.py", line 370, in main
      run_tests(options)
    File "./tests/attr.py", line 311, in run_tests
      Test(f, options).run()
    File "./tests/attr.py", line 300, in run
      self.compare(self.expect, self.result)
    File "./tests/attr.py", line 248, in compare
      exp_event.diff(res_event)
  UnboundLocalError: local variable 'res_event' referenced before assignment
  [root@s8360046 perf]#

This patch catches this pitfall and prints an error message instead:

  [root@s8360047 perf]# /usr/bin/python2 ./tests/attr.py -d ./tests/attr/ \
       -p ./perf  -vvv -ttest-stat-basic
  running './tests/attr//test-stat-basic'
    loading expected events
      Event event:base-stat
        fd = 1
        group_fd = -1
        flags = 0|8
        [....]
        sample_regs_user = 0
        sample_stack_user = 0
    'PERF_TEST_ATTR=/tmp/tmpJbMQMP ./perf stat -o /tmp/tmpJbMQMP/perf.data -e cycles kill >/dev/null 2>&1' ret '1', expected '1'
    loading result events
    compare
      matching [event:base-stat]
      match: [event:base-stat] matches []
      res_event is empty
  FAILED './tests/attr//test-stat-basic' - match failure
  [root@s8360047 perf]#

Signed-off-by: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>
LPU-Reference: 20170913081209.39570-1-tmricht@linux.vnet.ibm.com
Link: http://lkml.kernel.org/n/tip-04d63nn7svfgxdhi60gq2mlm@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/attr.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 6bb50e82a3e3..a13cd780148e 100644
--- a/tools/perf/tests/attr.py
+++ b/tools/perf/tests/attr.py
@@ -237,6 +237,7 @@ class Test(object):
         # events in result. Fail if there's not any.
         for exp_name, exp_event in expect.items():
             exp_list = []
+            res_event = {}
             log.debug("    matching [%s]" % exp_name)
             for res_name, res_event in result.items():
                 log.debug("      to [%s]" % res_name)
@@ -253,7 +254,10 @@ class Test(object):
                 if exp_event.optional():
                     log.debug("    %s does not match, but is optional" % exp_name)
                 else:
-                    exp_event.diff(res_event)
+                    if not res_event:
+                        log.debug("    res_event is empty");
+                    else:
+                        exp_event.diff(res_event)
                     raise Fail(self, 'match failure');
 
             match[exp_name] = exp_list
-- 
2.13.6
