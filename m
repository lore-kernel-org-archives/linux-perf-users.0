From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 27/27] perf test: Fix subtest number when showing results
Date: Wed, 25 Jul 2018 15:00:01 -0300
Message-ID: <20180725180001.15108-28-acme@kernel.org>
References: <20180725180001.15108-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180725180001.15108-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Thomas Richter <tmricht@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Thomas Richter <tmricht@linux.ibm.com>

Perf test 40 for example has several subtests numbered 1-4 when
displaying the start of the subtest. When the subtest results
are displayed the subtests are numbered 0-3.

Use this command to generate trace output:

  [root@s35lp76 perf]# ./perf test -Fv 40 2>/tmp/bpf1

Fix this by adjusting the subtest number when show the
subtest result.

Output before:

  [root@s35lp76 perf]# egrep '(^40\.[0-4]| subtest [0-4]:)' /tmp/bpf1
  40.1: Basic BPF filtering                                 :
  BPF filter subtest 0: Ok
  40.2: BPF pinning                                         :
  BPF filter subtest 1: Ok
  40.3: BPF prologue generation                             :
  BPF filter subtest 2: Ok
  40.4: BPF relocation checker                              :
  BPF filter subtest 3: Ok
  [root@s35lp76 perf]#

Output after:

  root@s35lp76 ~]# egrep '(^40\.[0-4]| subtest [0-4]:)' /tmp/bpf1
  40.1: Basic BPF filtering                                 :
  BPF filter subtest 1: Ok
  40.2: BPF pinning                                         :
  BPF filter subtest 2: Ok
  40.3: BPF prologue generation                             :
  BPF filter subtest 3: Ok
  40.4: BPF relocation checker                              :
  BPF filter subtest 4: Ok
  [root@s35lp76 ~]#

Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Link: http://lkml.kernel.org/r/20180724134858.100644-1-tmricht@linux.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/builtin-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index dd850a26d579..4f5de8245b32 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -599,7 +599,7 @@ static int __cmd_test(int argc, const char *argv[], struct intlist *skiplist)
 			for (subi = 0; subi < subn; subi++) {
 				pr_info("%2d.%1d: %-*s:", i, subi + 1, subw,
 					t->subtest.get_desc(subi));
-				err = test_and_print(t, skip, subi);
+				err = test_and_print(t, skip, subi + 1);
 				if (err != TEST_OK && t->subtest.skip_if_fail)
 					skip = true;
 			}
-- 
2.14.4
