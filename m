Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021113.outbound.protection.outlook.com [52.101.95.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3F235045;
	Sun, 16 Aug 2026 20:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786913979; cv=fail; b=obakLP6AY0EanA4+h1rlhKfF8D/kq/1uLGlRqtKEahtt3NN+y12SmaINpf3cZXo/ZkSIcvB8os91xmGPIJ759fTd64IXBY+VJBsVIunC/MMUxVf0CoZGpY2PyNqKQansCk6I0pmas2PZiDFp7mxHl7BNxpHSyuN6CnTPqC407SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786913979; c=relaxed/simple;
	bh=4Hdvcpdun9EYY3oc9wl1tVVQNL4LECzOuYhwZh0rwOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sob1eGGt6/oWNTFzEMm/C563toX0T5DTqSVGgCdlI7+kfhME5//bvWBXdAD0Sb+ij1scImIIwaAXaVhXuw6mi5ppbY3MDcZuTROUIpScVmacpW6NRqJwQodkuXseDQSSOtIi8oOwUTdkYybWv3FWhmlbfR50o6IW5fJS9v7lY+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yrvm1NB+tIrkrnLtMfxh/qS0fcApMZnoL3gW5RWNxhYv63ZI+mnBlo6hP9Kv+VxF4MP30O26jaapTYl096Nx7M1YrpRuMWOXfgSfOJDvTAFhseDFA8RcfHdtgL1KYUpB5CnPIU+VOxBa2soqDCpKnAb6+iXiLZuOqD6ZzLD2ckwcLK9mviCdkOzBV/ZqEgA5Ye7He56A69arvz4U3HhjDjWojTb9Ek755ca15CdnPmZGhgNEO9ZO135gYF7SZhacTG5MNr8iP2ptn1meVEgcew97yLjMOPr3zo2LNrnmnp9LGkUPhbI9AdhqBRVwPlsDWUBHfuUHEDa7O7nWY0F1cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=4iiFtoMCvoeSd5mCtPwkWXYH3kdHTLcRnIP8PTMn3/k=;
 b=t0Ye/4yEGI0JTdnvMaHW2mqzPBF+mthcCox38lZJ1vj7b+aj3NstcwxKo82BbzvVv9pRf+c/qIN7AbdfNsjcR1TjnBf5wsQgJmRMNx8yu7f2yqa+H+GofKq1ckHtLNRXQ6xkQpqHguWd8so8+47zEzuek/Aet86qFPgmDGmnr3CsbTtLD6RMpmkLRUz/wzGdLFH20tq/OUivgMpZXF/XRab5Y37w3IF8hJ3nTBi7XfzY+GfQBJdFRIFJAR8NHI9hfrlE8ZudjNG9OUGgpQOUtYKRcQXi2Z7fN3qE6qj256apj8yJQZVbftPuyDL4DiZjHEbT+rg8msiBJRVKQ6BNfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB2682.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Sun, 16 Aug
 2026 20:59:36 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sun, 16 Aug 2026
 20:59:36 +0000
From: Aaron Tomlin <atomlin@atomlin.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org
Cc: mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	howardchu95@gmail.com,
	atomlin@atomlin.com,
	neelx@suse.com,
	chjohnst@mail.com,
	sean@ashe.io,
	steve@abita.co,
	rishil1999@outlook.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH perf-tools-next v2 3/4] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Sun, 16 Aug 2026 16:59:20 -0400
Message-ID: <20260816205921.576365-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260816205921.576365-1-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR12CA0005.namprd12.prod.outlook.com
 (2603:10b6:408:e1::10) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB2682:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac71ad2-f68c-4fc8-e3a0-08defbd94794
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|6133799003|3023799007|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gwWl9u6pTrxUehzopkEysMHfISWWHEDQWYwglcruA+vV7NcTuNs6nftGEUqmZYF12PiFVhZfyEexWcX3sbObNUmruVnPco3tt3QEqeqmLfCUeYRj4PXk+v3UTjW/j/1JdHjdoV4VA3zSxV0CM3N38gBO9Y42NlBp1EwKNvf43KWy85n1EHqjVYHjXNGAIYMeKMgnuTtOh7H4ibKtXmCyLxmuKPWsABJFU9t+X5Mhab7kM7js2NqW2UUn/cdOww8WV6wXOnErrdQ6XAOPCA4vZlndz6Pn/99qG4ztkxnGeJM88JkmCaSdTYWIUr0Etsf0tBDPhosRifxQOs97ETtfOKecyfo1N3hPb3OjNjvAryMZ+Xa8bmRBmVesn4tU54z9QFzd0Da2XsY4QI1Sj06T5c1UulXHiljzstk9vZm31YRINldLTBX3PYyzQmpF86SYs7kw2w/XCezBdA4mi45k4iWnG05lWp7yJOnLZQ4iqpWBQZgTUKna+CyRWHYwDotCfiSLz8GhfDx9tttVXAPrPO+1ZXAdiM7AuW1SUjF9O7cyifqSUEs/C88qYJmgPuAMMdtgPYZVblhFz0hLKiLk3hfTnPmharM1gjwC7+YIbRJOIsMSpaKRGCPLP1PI+nFRlJ0b5ES7a0fFvf2jAUxm11o2zGJouKZ2I84Gf5AHcYk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SjODELoKMmioc5ZUpa7D2VSNjG0ji3M+B7ceyzfG0Lhv3Bp5YBzzdwEo1o4J?=
 =?us-ascii?Q?Phk39NMHqH/2y6KyGjiwSE2EHxdUih2M8mcFMGH64NNaD2u6MKwOlZpeLcyJ?=
 =?us-ascii?Q?GAeCPyPd2zEt+qYhEkaYiItHF9Vh/Diyw1FOhuMH8q4HBHlVfoYTAmX9u74U?=
 =?us-ascii?Q?khsfx9NiN9waTSgd5nNWUKAc89C0+s6nVffcLNS17XXzJPCx1zIjP1+uxBGP?=
 =?us-ascii?Q?rRjRBB+c6/dZDkF7+sBSn0jYkVWK4CgWnPVQSvVE5hEnjWcaAlEUPxl7DMUy?=
 =?us-ascii?Q?o1OC56Mka6+lGnMdn3s2ltweeCSwQW/KrZ/gcU82vLqOubNhb2gCOplPF8Ky?=
 =?us-ascii?Q?W6vU73WvVBW1Qf9uNvI0SUVSHgzeqQV3NaHu30mLoS8iJJ0f1/+e+z79mAxG?=
 =?us-ascii?Q?BwzP3XuZ9yUa5+7GK4oOtTG6t/AMXm6V0F9UgHq+3TlOd4pFDKJ0CQu9ZWW9?=
 =?us-ascii?Q?lRqCMIVD6lHJJXCKF+xGJYjOoh+xrDFyrRltGjykrO0VCv6zeU1kFY/VUTwy?=
 =?us-ascii?Q?69HGpJFEHax8oqASgVhfhzzP6SiA1Oj4TvvvxOGiZ41pQ1xHMgVR2fWJR3dk?=
 =?us-ascii?Q?/ZY1HoLr08vlHpSPir1mkItWTQyoDZ4y6fcvIupWKyd0M0tjPGasgvxDDMF/?=
 =?us-ascii?Q?88UOTNamCNS+lGZtDe7j12Hxm8aFfXFJX7s5XWCDy42cMBkyWyZrD7IV7zZj?=
 =?us-ascii?Q?OHfEvfAb80C3IBuWek4mn2NOlVM7JBsMHzThjNqje8i1xxwmTOieTP5iLTTe?=
 =?us-ascii?Q?raRHpegA6NmqykFTdH4f0hEwURgQdxoIXCM5XQogvg33xEIHKxurWMZw6hn3?=
 =?us-ascii?Q?7nxDB8dlBchhUXsPSR8rDzFYAqQq4kaUS0xFp3kdvH54ULmqDKGkcr/+yf7m?=
 =?us-ascii?Q?jQ/yZtQqdHlvRYYLbwnwoXhhW8DnrNYf3RJVTkOxrlTomapZJfRBh6DFuY2U?=
 =?us-ascii?Q?2oMlxzis+CAf4Bw+ka/04XG5HRvN7TLEW0iag0aBjXGPCFlGDI5nzINwOy1B?=
 =?us-ascii?Q?h77F4Fy6kPeXmdqpczMrJyl/T88cJsM+64EkkPfBGk5YHq5uYBAk4Xp7uHi6?=
 =?us-ascii?Q?jji9RQNYNzursnyg+EkTx2+voY5dF0otvaikc6gQGKMo9jB/GWQuSdB4Gn5l?=
 =?us-ascii?Q?/PfXpZbJPlFlMryZTzlhE22xq4qcUNyH02vD46CvpWyhh8REn2MTx71qiC8Q?=
 =?us-ascii?Q?lYpHhLYRvoF0KMbHAcsI+2YFUqe4F5PlRC547xpreFRBkOaMtMp1lsVn0pSd?=
 =?us-ascii?Q?j5iX8ReuTU7gKepSJDKGkAlvTaK3l/qoKba652cBDtmyTN2AyLM6AbccJSQi?=
 =?us-ascii?Q?ElAU3IaRR0Drv077TcXSolT3VuHIfgGkN+gAioIxTTdzVg94HoY9PIT5fNFY?=
 =?us-ascii?Q?0dlv9Dh863Cid+kJDlSZM09A5ItmGVyR1PGH4aHNyeQ5IUAby7BrA2IRqnYN?=
 =?us-ascii?Q?gAYIbT4aq0RhBGXu7yJ23epx4d5ikE4tI457EivFiBn+JpFssLujl40tDOsS?=
 =?us-ascii?Q?BFBqFXqLzsYCcEkB2xqic8FcjQsJG+JF00K+OFbUOy/aBTFdosCsVnbvUXCx?=
 =?us-ascii?Q?U16PVwFUFzUE5FiUSHUEzRJN72EYpKk+Jiy9Cl242jHvXcjqkieV55w5FUF1?=
 =?us-ascii?Q?35+ViZkyUCw3kkjk3783+UFsGzyQOOTpB12e3Xs7nPbMVT54DKvoP5hxPzD9?=
 =?us-ascii?Q?Vb1GPlKVqTrqdKKwnzq3TLfKdWlzPa2Rt2hzsDCGEPja4+opQPW4koNf64mQ?=
 =?us-ascii?Q?pCd9Vw4jMA=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac71ad2-f68c-4fc8-e3a0-08defbd94794
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2026 20:59:36.2422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5KXlYtejTfIcwD3l6BQBwNU04XYA012Gp40aMht7GJfNOZlGWK5ojxeq9fUHSPP7kTyveNsawRVqDJLbOeRPBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB2682

When BTF (BPF Type Format) metadata is loaded from vmlinux, 'perf trace'
can inspect the precise C types of tracepoint and system call parameters.
However, function pointer arguments are currently not recognised during
BTF pretty-printing and default to hexadecimal output.

Introduce btf_is_func_ptr() to inspect BTF type hierarchies
(i.e., traversing pointers, typedefs, and type modifiers) to determine
whether a parameter resolves to a function prototype
(BTF_KIND_FUNC_PROTO).

Generalise BTF type caching via syscall_arg_fmt__cache_btf_type() to
handle structs, unions, enums, and function pointers alike. When a field
is identified as a kernel function pointer, trace__btf_scnprintf()
routes its value to syscall_arg__scnprintf_ksym(), enabling automatic
zero-config symbolisation of kernel function pointers whenever BTF is
available.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c                  | 65 +++++++++++++++++----
 tools/perf/tests/shell/trace_btf_general.sh |  2 +-
 2 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 85abae09d328..cb3cb877a22e 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -979,21 +979,61 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
 #ifdef HAVE_LIBBPF_SUPPORT
-static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type *type)
 {
+	bool has_ptr = false;
+
+	while (type) {
+		if (btf_is_ptr(type)) {
+			has_ptr = true;
+			type = btf__type_by_id(btf, type->type);
+		} else if (btf_is_typedef(type) || btf_is_mod(type)) {
+			type = btf__type_by_id(btf, type->type);
+		} else {
+			break;
+		}
+	}
+	return has_ptr && type && btf_is_func_proto(type);
+}
+
+static void syscall_arg_fmt__cache_btf_type(struct syscall_arg_fmt *arg_fmt,
+					    struct btf *btf, const char *type)
+{
+	char name[128];
+	const char *pos;
+	size_t len = 0;
 	int id;
 
-	type = strstr(type, "enum ");
 	if (type == NULL)
 		return;
 
-	type += 5; // skip "enum " to get the enumeration name
+	if ((pos = strstr(type, "enum ")) != NULL)
+		pos += 5;
+	else if ((pos = strstr(type, "struct ")) != NULL)
+		pos += 7;
+	else if ((pos = strstr(type, "union ")) != NULL)
+		pos += 6;
+	else
+		pos = type;
+
+	while (isspace(*pos))
+		pos++;
+
+	while ((isalnum(pos[len]) || pos[len] == '_') && len < sizeof(name) - 1) {
+		name[len] = pos[len];
+		len++;
+	}
+	name[len] = '\0';
 
-	id = btf__find_by_name(btf, type);
+	if (len == 0)
+		return;
+
+	id = btf__find_by_name(btf, name);
 	if (id < 0)
 		return;
 
 	arg_fmt->type = btf__type_by_id(btf, id);
+	arg_fmt->type_id = id;
 }
 
 static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
@@ -1028,8 +1068,7 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 		return false;
 
 	if (arg->fmt->type == NULL) {
-		// See if this is an enum
-		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
+		syscall_arg_fmt__cache_btf_type(arg->fmt, btf, type);
 	}
 
 	// Now let's see if we have a BTF type resolved
@@ -1108,7 +1147,7 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 }
 
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
-				   size_t size, int val, char *type)
+				   size_t size, unsigned long val, char *type)
 {
 	struct syscall_arg_fmt *arg_fmt = arg->fmt;
 
@@ -1116,8 +1155,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 		return 0;
 
 	if (arg_fmt->type == NULL) {
-		// Check if this is an enum and if we have the BTF type for it.
-		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
+		syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
 	}
 
 	// Did we manage to find a BTF type for the syscall/tracepoint argument?
@@ -1128,13 +1166,17 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
 	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
 		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
+	else if (btf_is_func_ptr(trace->btf, arg_fmt->type)) {
+		arg->val = val;
+		return syscall_arg__scnprintf_ksym(bf, size, arg);
+	}
 
 	return 0;
 }
 
 #else // HAVE_LIBBPF_SUPPORT
 static size_t trace__btf_scnprintf(struct trace *trace __maybe_unused, struct syscall_arg *arg __maybe_unused,
-				   char *bf __maybe_unused, size_t size __maybe_unused, int val __maybe_unused,
+				   char *bf __maybe_unused, size_t size __maybe_unused, unsigned long val __maybe_unused,
 				   char *type __maybe_unused)
 {
 	return 0;
@@ -2567,7 +2609,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf || default_scnprintf == NULL ||
+			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 7a94a5743924..255468eff128 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -49,7 +49,7 @@ trace_test_buffer() {
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
   output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
-  if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,.*\}, 0x[0-9a-f]+\) += +[0-9]+$"
+  if ! echo "$output" | grep -q -E "sleep/[0-9]+ clock_nanosleep\(.*(struct __kernel_timespec|\{1,).*\) = [0-9]+"
   then
 	printf "BTF struct augmentation test failed, output:\n$output\n"
     err=1
-- 
2.55.0

