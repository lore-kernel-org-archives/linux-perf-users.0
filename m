Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2008F4A
	for <linux-perf-users@vger.kernel.org>; Fri, 29 Sep 2023 06:49:35 +0000 (UTC)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDB1B0
	for <linux-perf-users@vger.kernel.org>; Thu, 28 Sep 2023 23:49:33 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T6cY9Q021179;
	Fri, 29 Sep 2023 06:49:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KH8PlRenTtNX+JIRcQjU2ssuXbVpPOcTprrV/Sy6JhU=;
 b=fATQLnplnQbupXRgND3VOEkBM1hTtMAbgKoUgJDEb4VAwnElybp6UPF+RGHHrxtsha8U
 wPSsNKVsAbNsKMW5PJ61ZhNxSG4NESJigbP6Lxbf1yS0UBVIAqxy3ciZ0j8yl/8zwL/D
 aK0xq3K5smb+6o59MJfZW4oEeN2FaT4+zjDDIJo1LILCPRWm/XPe/bS9BgO9nkycVZeK
 Qz9rEOsZi6oorjCk2i84THt5Eo13XAVQGOeTHnYJxylCIYmoI7733C424oqP8F6ss1XK
 ngSaM78mWor3+t53PmK2V/OxIkJaa8DSdjDX/Gt/NlH3OHOga9yrswGwmljEGvun7MEn 1A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tds73rm4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Sep 2023 06:49:22 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 38T6T9K4016832;
	Fri, 29 Sep 2023 06:49:22 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tds73rm4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Sep 2023 06:49:22 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 38T6YG3D011019;
	Fri, 29 Sep 2023 06:49:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3tabum2k7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Sep 2023 06:49:20 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 38T6nHDJ28574278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Sep 2023 06:49:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7659220040;
	Fri, 29 Sep 2023 06:49:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FF5220043;
	Fri, 29 Sep 2023 06:49:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.43.86.96])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Sep 2023 06:49:15 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com
Subject: [PATCH V2] tools/perf: Add perf binary dependent rule for shellcheck log in Makefile.perf
Date: Fri, 29 Sep 2023 12:19:09 +0530
Message-Id: <20230929064909.1152-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FszEnu_qeMw2trl0ZklG4767vdVDvFTN
X-Proofpoint-GUID: B7-_9QCzdVnmUzyWRES4kvig6bNBX_aN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_04,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290055
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add rule in new Makefile "tests/Makefile.tests" for running
shellcheck on shell test scripts. This automates below shellcheck
into the build.

	$ for F in $(find tests/shell/ -perm -o=x -name '*.sh'); do shellcheck -S warning $F; done

Condition for shellcheck is added in Makefile.perf to avoid build
breakage in the absence of shellcheck binary. Update Makefile.perf
to contain new rule for "SHELLCHECK_TEST" which is for making
shellcheck test as a dependency on perf binary. Added
"tests/Makefile.tests" to run shellcheck on shellscripts in
tests/shell. The make rule "SHLLCHECK_RUN" ensures that, every
time during make, shellcheck will be run only on modified files
during subsequent invocations. By this, if any newly added shell
scripts or fixes in existing scripts breaks coding/formatting
style, it will get captured during the perf build.

Example build failure with present scripts in tests/shell:

	INSTALL libsubcmd_headers
	INSTALL libperf_headers
	INSTALL libapi_headers
	INSTALL libsymbol_headers
	INSTALL libbpf_headers
	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/record_sideband.dep] Error 1
	make[3]: *** Waiting for unfinished jobs....
	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/test_arm_coresight.dep] Error 1
	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/lock_contention.dep] Error 1
	make[2]: *** [Makefile.perf:675: SHELLCHECK_TEST] Error 2
	make[1]: *** [Makefile.perf:238: sub-make] Error 2
	make: *** [Makefile:70: all] Error 2

After this, for testing, changed "tests/shell/record.sh" to
break shellcheck format. In the next make run, it is
also captured:

	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/record_sideband.dep] Error 1
	make[3]: *** Waiting for unfinished jobs....
	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/record.dep] Error 1
	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/test_arm_coresight.dep] Error 1
	make[3]: *** [/root/athira/namhyung/perf-tools-next/tools/perf/tests/Makefile.tests:17: output/tests/shell/lock_contention.dep] Error 1
	make[2]: *** [Makefile.perf:675: SHELLCHECK_TEST] Error 2
	make[1]: *** [Makefile.perf:238: sub-make] Error 2
	make: *** [Makefile:70: all] Error 2

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
Changelog:
 v1 -> v2:
 Version1 had shellcheck in feature check which is not
 required since shellcheck is already a binary. Presence
 of binary can be checked using:
 $(shell command -v shellcheck)
 Addressed these changes as suggested by Namhyung in V2
 Feature test logic is removed in V2. Also added example
 for build breakage when shellcheck fails in commit message

 tools/perf/Makefile.perf        | 14 +++++++++++++-
 tools/perf/tests/Makefile.tests | 24 ++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/Makefile.tests

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 98604e396ac3..56a66ca253ab 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -667,7 +667,18 @@ $(PERF_IN): prepare FORCE
 $(PMU_EVENTS_IN): FORCE prepare
 	$(Q)$(MAKE) -f $(srctree)/tools/build/Makefile.build dir=pmu-events obj=pmu-events
 
-$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN)
+# Runs shellcheck on perf test shell scripts
+
+SHELLCHECK := $(shell command -v shellcheck)
+ifneq ($(SHELLCHECK),)
+SHELLCHECK_TEST: FORCE prepare
+	$(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests
+else
+SHELLCHECK_TEST:
+	@:
+endif
+
+$(OUTPUT)perf: $(PERFLIBS) $(PERF_IN) $(PMU_EVENTS_IN) SHELLCHECK_TEST
 	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) \
 		$(PERF_IN) $(PMU_EVENTS_IN) $(LIBS) -o $@
 
@@ -1130,6 +1141,7 @@ bpf-skel-clean:
 	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
+	$(Q)$(MAKE) -f $(srctree)/tools/perf/tests/Makefile.tests clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
 	$(Q)find $(or $(OUTPUT),.) -name '*.o' -delete -o -name '\.*.cmd' -delete -o -name '\.*.d' -delete
 	$(Q)$(RM) $(OUTPUT).config-detected
diff --git a/tools/perf/tests/Makefile.tests b/tools/perf/tests/Makefile.tests
new file mode 100644
index 000000000000..8011e99768a3
--- /dev/null
+++ b/tools/perf/tests/Makefile.tests
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+# Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 2023
+
+PROGS = $(subst ./,,$(shell find tests/shell -perm -o=x -type f -name '*.sh'))
+DEPS = $(addprefix output/,$(addsuffix .dep,$(basename $(PROGS))))
+DIRS = $(shell echo $(dir $(DEPS)) | xargs -n1 | sort -u | xargs)
+
+.PHONY: all
+all: SHELLCHECK_RUN
+	@:
+
+SHELLCHECK_RUN: $(DEPS) $(DIRS)
+
+output/%.dep: %.sh | $(DIRS)
+	$(call rule_mkdir)
+	$(eval input_file := $(subst output/,./,$(patsubst %.dep, %.sh, $@)))
+	$(Q)$(call frecho-cmd,test)@shellcheck -S warning ${input_file} 1> $@.log && ([[ ! -s $@.log ]])
+	$(Q)$(call frecho-cmd,test)@touch $@
+	$(Q)$(call frecho-cmd,test)@rm -rf $@.log
+$(DIRS):
+	@mkdir -p $@
+
+clean:
+	@rm -rf output
-- 
2.31.1

