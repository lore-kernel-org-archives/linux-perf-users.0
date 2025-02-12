Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40D25EF81
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 18:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386516; cv=none; b=MLOa7kUnWyHQkSwy4Oicv4U7xG3Fw3XVDjuQ8W8sl27MVpdI+xeBhYTwjS83vjEOM+K27Vo5JFCaxT5pAqBOrMIoM5m/jl00JvfAaSTSWJnVNltUewlvqK+4gdbjiv8pTLr6sFbsEfnAmz4gK4OCBNUdYDqG9djUziA64JOaj2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386516; c=relaxed/simple;
	bh=FAUccaaJyMVVcj/Z6D4oVe+lH12VYK8xJUR3YK7D/5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPTx3JZgD7KcrsRu4QpfpbtmJHXCoF1axxoU+gqTq/W/SKINuNpHpqki9NOfXYwYqbOk7HBtOMEv/QM18bDI5c6xaveK5YoDkg9kQiXuG8YfL94KeQ6tegSHbRY0z7HjbP3HBCKg9WuhQ70ppAzGRGfSRlOyXu8wUJcyLaO8OpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dSfP+bxc; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dSfP+bxc"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CEMDgP013592;
	Wed, 12 Feb 2025 18:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=hNaASAwSyMz0cHnAmOfiK5nkgAILPIlea5cj1Lx13
	Hg=; b=dSfP+bxcj9wck3KYOw1Yk1FMUUrLhZ+xZ8WeLoZ39GfXUYTsUZdaiwvt/
	/7cZTWzjn4ZRIR31eqlQjEwQHs08i7xpdDiNucvn95Pl1jZz6KwcfvcQlRLC6t+h
	W6dESTryqER6tfnWFR07jGKOftpouNNRmxncZw4RESAqbFPQ7bqypLAyyydbQ14g
	3QX47tPog6fotohrxtXcgDUSUIVG4MUiFjr9HOy2RMQhPM+JR9lSl5Sr6geB2Osp
	mCpUf5Mwv3Fhoaa+gIPZZQAKp7e78gToBW5cQtzaOuARe8iOFXfX0QsS/F5TYZrq
	TM1LHBnZUP4vyKpFjY4J0X9Jgdvog==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa5fd0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 18:54:55 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51CIqHm5023406;
	Wed, 12 Feb 2025 18:54:54 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rfpa5fcy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 18:54:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CIct3g028217;
	Wed, 12 Feb 2025 18:54:53 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyjgmu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 18:54:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CIsnui32637450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 18:54:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 72DE420043;
	Wed, 12 Feb 2025 18:54:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5F23120040;
	Wed, 12 Feb 2025 18:54:43 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.242.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 18:54:42 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        maddy@linux.ibm.com, atrajeev@linux.vnet.ibm.com, kjain@linux.ibm.com,
        disgoel@linux.vnet.ibm.com, hbathini@linux.vnet.ibm.com,
        Aditya.Bodkhe1@ibm.com
Subject: [PATCH] tools/perf: Add check to tool pmu tests to ensure if the event is valid
Date: Thu, 13 Feb 2025 00:24:38 +0530
Message-Id: <20250212185438.15251-1-atrajeev@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: laO6AjK1xfUch_gsKFzKR8x3u91gWI5W
X-Proofpoint-ORIG-GUID: p5ML_pkDheJMdUFJNed9q1JBWNEyZGZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 mlxlogscore=999 clxscore=1015 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502120134

"Tool PMU" tests fails on powerpc as below:

   12.1: Parsing without PMU name:
   --- start ---
   test child forked, pid 48492
   Using CPUID 0x00800200
   Attempt to add: tool/duration_time/
   ..after resolving event: tool/config=0x1/
   duration_time -> tool/duration_time/
   Attempt to add: tool/user_time/
   ..after resolving event: tool/config=0x2/
   user_time -> tool/user_time/
   Attempt to add: tool/system_time/
   ..after resolving event: tool/config=0x3/
   system_time -> tool/system_time/
   Attempt to add: tool/has_pmem/
   ..after resolving event: tool/config=0x4/
   has_pmem -> tool/has_pmem/
   Attempt to add: tool/num_cores/
   ..after resolving event: tool/config=0x5/
   num_cores -> tool/num_cores/
   Attempt to add: tool/num_cpus/
   ..after resolving event: tool/config=0x6/
   num_cpus -> tool/num_cpus/
   Attempt to add: tool/num_cpus_online/
   ..after resolving event: tool/config=0x7/
   num_cpus_online -> tool/num_cpus_online/
   Attempt to add: tool/num_dies/
   ..after resolving event: tool/config=0x8/
   num_dies -> tool/num_dies/
   Attempt to add: tool/num_packages/
   ..after resolving event: tool/config=0x9/
   num_packages -> tool/num_packages/

   ---- unexpected signal (11) ----
   12.1: Parsing without PMU name                                      : FAILED!

Same fail is observed for "Parsing with PMU name" as well.

The testcase loops through events in tool_pmu__for_each_event()
and access event name using "tool_pmu__event_to_str()".
Here tool_pmu__event_to_str returns null for "slots" event
and "system_tsc_freq" event. These two events are only applicable
for arm64 and x86 respectively. So the function tool_pmu__event_to_str()
skips for unsupported events and returns null. This null value is
causing testcase fail.

To address this in "Tool PMU" testcase, add a helper function
tool_pmu__all_event_to_str() which returns the name for all
events mapping to the tool_pmu_event index including the
skipped ones. So that even if its a skipped event, the
helper function helps to resolve the tool_pmu_event index to
its mapping event name. Update the testcase to check for null event
names before proceeding the test.

Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
---
 tools/perf/tests/tool_pmu.c | 12 ++++++++++++
 tools/perf/util/tool_pmu.c  | 17 +++++++++++++++++
 tools/perf/util/tool_pmu.h  |  1 +
 3 files changed, 30 insertions(+)

diff --git a/tools/perf/tests/tool_pmu.c b/tools/perf/tests/tool_pmu.c
index 187942b749b7..e468e5fb3c73 100644
--- a/tools/perf/tests/tool_pmu.c
+++ b/tools/perf/tests/tool_pmu.c
@@ -19,6 +19,18 @@ static int do_test(enum tool_pmu_event ev, bool with_pmu)
 		return TEST_FAIL;
 	}
 
+	/*
+	 * if tool_pmu__event_to_str returns NULL, Check if the event is
+	 * valid for the platform.
+	 * Example:
+	 * slots event is only on arm64.
+	 * system_tsc_freq event is only on x86.
+	 */
+	if (!tool_pmu__event_to_str(ev) && tool_pmu__skip_event(tool_pmu__all_event_to_str(ev))) {
+		ret = TEST_OK;
+		goto out;
+	}
+
 	if (with_pmu)
 		snprintf(str, sizeof(str), "tool/%s/", tool_pmu__event_to_str(ev));
 	else
diff --git a/tools/perf/util/tool_pmu.c b/tools/perf/util/tool_pmu.c
index 3a68debe7143..572422797f6e 100644
--- a/tools/perf/util/tool_pmu.c
+++ b/tools/perf/util/tool_pmu.c
@@ -60,6 +60,15 @@ int tool_pmu__num_skip_events(void)
 	return num;
 }
 
+/*
+ * tool_pmu__event_to_str returns only supported event names.
+ * For events which are supposed to be skipped in the platform,
+ * return NULL
+ *
+ * tool_pmu__all_event_to_str returns the name for all
+ * events mapping to the tool_pmu_event index including the
+ * skipped ones.
+ */
 const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
 {
 	if ((ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX) &&
@@ -69,6 +78,14 @@ const char *tool_pmu__event_to_str(enum tool_pmu_event ev)
 	return NULL;
 }
 
+const char *tool_pmu__all_event_to_str(enum tool_pmu_event ev)
+{
+	if (ev > TOOL_PMU__EVENT_NONE && ev < TOOL_PMU__EVENT_MAX)
+		return tool_pmu__event_names[ev];
+
+	return NULL;
+}
+
 enum tool_pmu_event tool_pmu__str_to_event(const char *str)
 {
 	int i;
diff --git a/tools/perf/util/tool_pmu.h b/tools/perf/util/tool_pmu.h
index a60184859080..da76808ae71e 100644
--- a/tools/perf/util/tool_pmu.h
+++ b/tools/perf/util/tool_pmu.h
@@ -30,6 +30,7 @@ enum tool_pmu_event {
 	for ((ev) = TOOL_PMU__EVENT_DURATION_TIME; (ev) < TOOL_PMU__EVENT_MAX; ev++)
 
 const char *tool_pmu__event_to_str(enum tool_pmu_event ev);
+const char *tool_pmu__all_event_to_str(enum tool_pmu_event ev);
 enum tool_pmu_event tool_pmu__str_to_event(const char *str);
 bool tool_pmu__skip_event(const char *name);
 int tool_pmu__num_skip_events(void);
-- 
2.43.5

