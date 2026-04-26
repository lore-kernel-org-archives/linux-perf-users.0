Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A913A1B5
	for <linux-perf-users@vger.kernel.org>; Sun, 26 Apr 2026 04:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777177835; cv=none; b=OROuiwYpwylz2Gk+du2qGlWUUrb5pw2Ue6tCq4DCy0SvxS97fpsevKWAimCQU4DSxfCKEAlXqEspENPo5TvprQw6Sk2VjGS7xhckl7j7RmAKKBZXx0abNEnFOTB0ttBrz/wffljRTjQ4syN3jvSPele8RhFgzv4VRlhOkM1PrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777177835; c=relaxed/simple;
	bh=Z6qr7QTrMHjfWCiwOFGLz5Rrx9TH/BBKC91KQx1WVD8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QpTKZwg/1Mp6AfeXnwqwGK+8KVb1tb8IJqWgZ+lD25NTxunZ2GI7f9XZXxKB8u6hrLfwy6IIGtBpPg/puiZWpGfWcj65y02Vu+9SjthrtsqBmkOLfD2fa++Fsm7hHY2+4tOYAslHeDPBUf1Uhf9RIFandvDH1SDIWLi3pkLKTo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=F6nXxNSl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="F6nXxNSl"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63Q3GNnc914057;
	Sun, 26 Apr 2026 04:30:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=UbpnkkD17mjRaoD/hBY4G1yToQSHbb1q74evgOmCH
	tc=; b=F6nXxNSlkl/OXVDMjOMjQS4lXCb9s3+febEB3V7NL9J5c07lXoxbVzCu+
	3rmsC/tR7XiRkaI5l0hDDAH+9Lex56rFMi/zx5giSmxTdDmJrwFF8wxahDLsyMP1
	fKdbOGGfYtrLKFxxZdPMcq2TxhfMr2nwb3Irbpjj5dK81FSDol4UA8xVt5+gm422
	LHUi2yfjxXV05yWZaNdhAlhsSlMJl8RL5lf4C5peQ2acvl7lwzVH/sBjuaI4p3Mr
	Rkzhi3qFNquS3PMczeNMKVitdmSJyD+IJAcwlN4lqJbNOKvgyAA085O4hMOBldzu
	lJP7n6Bg6qBPF0PYErZZsfuxuApYw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn44bfd8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 04:30:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63Q4NkY1024125;
	Sun, 26 Apr 2026 04:30:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh0a4u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Apr 2026 04:30:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63Q4UIxX51904986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 26 Apr 2026 04:30:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 863B72004B;
	Sun, 26 Apr 2026 04:30:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A12D20040;
	Sun, 26 Apr 2026 04:30:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.219.109])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 26 Apr 2026 04:30:13 +0000 (GMT)
From: Athira Rajeev <atrajeev@linux.ibm.com>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com,
        mpetlan@redhat.com, tmricht@linux.ibm.com, maddy@linux.ibm.com,
        irogers@google.com, namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        atrajeev@linux.ibm.com, hbathini@linux.vnet.ibm.com,
        Tejas.Manhas1@ibm.com, Tanushree.Shah@ibm.com, Shivani.Nittor@ibm.com
Subject: [PATCH V2] tools/perf: Fix the check for parameterized field in event term
Date: Sun, 26 Apr 2026 10:00:06 +0530
Message-Id: <20260426043006.48113-1-atrajeev@linux.ibm.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qXGTHI65qyGxKZWnTTR4wM6lfjFZt84Z
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69ed94e0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=KlCRr-_lrQmZq1rU:21 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=MfJl6_LkDses9f4lsXYA:9
X-Proofpoint-GUID: Mkut2OD8pt8J4TwjODCmICOj1IDEMz7y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI2MDA0MSBTYWx0ZWRfX5LwI0sjURNYf
 iBO8r66/cfwkG09UmCxmG5mbXEOohGNXO05oLiOiy9C8KEI6a7nEbCzUHfiKh/KePcjHnRlI05r
 7eA0frEaTZl+OYCj7wQGwen7B7p44ZUzRAxsE717Z3K4pOnEMlUqSjSOSKDffnWqGmChzxqtx1r
 1abRkY1FbQY62+HvtnT2RVV5Lsr2OgsAXFKc/kZlgnAl33Kx7LAosNNSb6w3AL4X6OccGlHA/rb
 YdG0S1wl6Myaws8GhaffMbDM8gTPFYT1t+vT4XqtWIl8QVQQ3O80mQUZhlhT7K3sh6KlkYQE0GG
 jnGrvQ65h4FfJrrUZiN0sk0QlL1j7pBAcueaFpWCVUWsabeDKX9tfrvwk5Hoj1eGgBd8Uw/6XJk
 dx0OlYz6Dk9RmwdqwfftOiy+OJ/djNZx/3itbt6tRcxFbJ3DsjZkUc4W4t8euKyVeUczPcsEMYx
 4RK24GljN0oB6Y4ExRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-26_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604260041

The format_alias() function in util/pmu.c has a check to
detect whether the event has parameterized field ( =? ).
The string alias->terms contains the event and if the event
has user configurable parameter, there will be presence of
sub string "=?" in the alias->terms.

Snippet of code:

 /* Paramemterized events have the parameters shown. */
       if (strstr(alias->terms, "=?")) {
               /* No parameters. */
               snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);

if "strstr" contains the substring, it returns a pointer
and hence enters the above check which is not the expected
check. And hence "perf list" doesn't have the parameterized
fields in the result.

Fix this check to use:

if (str_ends_with(alias->terms, "=?")) {

With this change, perf list shows the events correctly with
the strings showing parameters.

Other changes in this patch:
- Replace snprintf with scnprintf in buffer offset calculations to
ensure the 'used' count will not exceed the "len"
- If a parameterized event uses a built-in perf keyword for its
parameter name (eg, config=?), the lexer parses it as a predefined
term token, which sets term->config to NULL. Add check to use
parse_events__term_type_str() if term->config is NULL

Signed-off-by: Athira Rajeev <atrajeev@linux.ibm.com>
---
Changelog:
v1 -> v2:
After review from Sashiko, added below changes:
Replace snprintf with scnprintf in buffer offset calculations to
ensure the 'used' count will not exceed the "len"
- If a parameterized event uses a built-in perf keyword for its
parameter name (eg, config=?), the lexer parses it as a predefined
term token, which sets term->config to NULL. Add check to use
parse_events__term_type_str() if term->config is NULL

 tools/perf/util/pmu.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 23337d2fa281..fad7ef4c8e5d 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2117,7 +2117,7 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 						   skip_duplicate_pmus);
 
 	/* Paramemterized events have the parameters shown. */
-	if (strstr(alias->terms, "=?")) {
+	if (!strstr(alias->terms, "=?")) {
 		/* No parameters. */
 		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
@@ -2129,15 +2129,19 @@ static char *format_alias(char *buf, int len, const struct perf_pmu *pmu,
 		pr_err("Failure to parse '%s' terms '%s': %d\n",
 			alias->name, alias->terms, ret);
 		parse_events_terms__exit(&terms);
-		snprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
+		scnprintf(buf, len, "%.*s/%s/", (int)pmu_name_len, pmu->name, alias->name);
 		return buf;
 	}
-	used = snprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
+	used = scnprintf(buf, len, "%.*s/%s", (int)pmu_name_len, pmu->name, alias->name);
 
 	list_for_each_entry(term, &terms.terms, list) {
+		const char *name = term->config;
+
+		if (!name)
+			name = parse_events__term_type_str(term->type_term);
 		if (term->type_val == PARSE_EVENTS__TERM_TYPE_STR)
-			used += snprintf(buf + used, sub_non_neg(len, used),
-					",%s=%s", term->config,
+			used += scnprintf(buf + used, sub_non_neg(len, used),
+					",%s=%s", name,
 					term->val.str);
 	}
 	parse_events_terms__exit(&terms);
-- 
2.47.3

