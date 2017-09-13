From: Thomas Richter <tmricht@linux.vnet.ibm.com>
Subject: [PATCH 1/2] perf test attr: fix python error on empty result
Date: Wed, 13 Sep 2017 10:12:08 +0200
Message-ID: <20170913081209.39570-1-tmricht@linux.vnet.ibm.com>
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43840 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750737AbdIMIM0 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 13 Sep 2017 04:12:26 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v8D88gxm069131
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2017 04:12:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2cxswxys4h-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Sep 2017 04:12:25 -0400
Received: from localhost
        by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-perf-users@vger.kernel.org> from <tmricht@linux.vnet.ibm.com>;
        Wed, 13 Sep 2017 09:12:23 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org, acme@kernel.org, jolsa@redhat.com, brueckner@linux.vnet.ibm.com
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Thomas Richter <tmricht@linux.vnet.ibm.com>

Commit d78ada4a767 ("perf tests attr: Do not store failed events")
does not create an event file in the /tmp directory when the
perf_open_event() system call failed.
This can lead to a situation where not /tmp/event-xx-yy-zz result
file exists at all (for example on a s390x virtual machine environment)
where no CPUMF hardware is available.

The following command then fails with a python call back chain
instead of printing failure:
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

This patch catches this pitfall and prints an error message
instead:
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

Signed-off-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 tools/perf/tests/attr.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/attr.py b/tools/perf/tests/attr.py
index 6bb50e8..a13cd78 100644
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
2.9.3
