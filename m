Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022120.outbound.protection.outlook.com [52.101.96.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4223932CA;
	Sat, 15 Aug 2026 23:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837030; cv=fail; b=hQkJ7rb5aMlJER8S74vwWNCN9PY+CFHzzfA0bPEFdmSvmRNXKqPTJIwo2nOM6AOE+LrKChFqFcdqfHdQeD66+DjhuHwKEneirOG11BrtfomwNIssSqvagU94PcAKNvpfLzLkCiE1XraZHYJwwXiKXx8Yb3CPcO+QAMFKR+hjMws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837030; c=relaxed/simple;
	bh=nR7ODsrnUCC02POAi1NrUml+dGrMn2sv4rvmFLfR6S4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ER94kDdGfVH580SlXD2GPyOFsc5by+8lioXkBsBRRYJm2wv32XzNRXkIUoaNamNgfUkBL5qieCTXKAQ+SRY8wk8Elo+z64/s3Dpk8FrhgbgeFoxl1YBZ15v6WhB17q3laT0ntehI6uIQ6xBNUtw/a+i9Hp/DcY+1ZWu1QgU2HoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YXhQuLfu947GhPpfgWKDRo1V+lZ2Wa17byIdmf014w1jPmjEB5c2qkfbJ+/WH24niM9nb+KkXP8i0hzo38+saWMqBFWG9/ToDaLBQLHYMvMICLkHnR1dlvcsT3rHTc9etu/COAOhEVHjNMpnPKXFf06qInSs0LgRlnxkdU96q1gwC5F9uo8X2Q+bCUeGA+8jAgspBmWVeMlvqttR/y++SGh+BPEPgIuLXrwtrDdPevhuz0oViGWF1/xu71OqLVRcATyFnkZrJrGNIKKcoVJK9vaNZmFDXPUfVkCqRMfDouQ6eeNIncIsLOaeadBYNo8tt3P8RvveQ3Mj46Gtfpw+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=R2ZEgx+jYwGfIy5nrPMjpjbsD/gmDyZCXfK51N4Kj78=;
 b=pSU1naiYhHshia4f+0CryxZxfodIHIy+RvvdF8VFsT60L+j86XMgRvZtK4SCoOZt+CkFGmppbhFjfQLWUoHN0qXh8u8GlTLHM2zHV8maocMR68tuNpX1TB5N+hME3weAu/nlAdjbNxMsU46hBQVDd80U0yHeRAlMmamfz3lE75wANJ+F+gSlZJZx5BvRDdp0aBwqjXCFT0OeLI8iEOEFRwSVjNRLCl6mv6tIzwbm79lWoMgSA9RReBfeBsEoleYpOC9yyQWz7wLVLQ2H7HdWY+6VDxIHSQhQE//yq4hk1FrweK+1mZSXQ/eK4RlYJD0MoBrYWSPGqAJ5y4XE3NopMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3254.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sat, 15 Aug
 2026 23:37:06 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sat, 15 Aug 2026
 23:37:06 +0000
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
Subject: [PATCH perf-tools-next 3/3] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Sat, 15 Aug 2026 19:36:51 -0400
Message-ID: <20260815233651.527936-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815233651.527936-1-atomlin@atomlin.com>
References: <20260815233651.527936-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0402.namprd03.prod.outlook.com
 (2603:10b6:408:111::17) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: d6a7679a-a4ad-4214-2961-08defb261df2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	S7z3QX8jrtsW8n9izS0YIMgdoFKcp425PW3w7pJE3eo36Ed/P2nGJBOs1eu4Xd7PM/34I7V6ZVworViKko2Q4vFsUNg5EL1FfRQPHhA9JMNWlPW9LzTcAdNaUqBBfwNt4cATDPpw0/VsgbrOdozIj9FRi8EpsrueK2sdM782xQcqhfos291QBOxEnw/9xFwoo0eCVi5G8j5t7a0HXFd2QSfxmrWW1KTn3kaNZyRG5DTF4jmBewNj79IztmnY+kDeGqiCdSuMxJGNReKtTBahBksPf5Ar64e7kIPzEa04exaI+QtKxdu5oBiZ8qwYDio9TZkE6RAXMrqV6glluxw6AMyoJUPdnGuj+ZXejf5qPmuxcZB76bdsZq61nKCqXV6n3+Sic+lv62ZvCEHLN3W6c9KyUdLhp1sDFqkUVNBydDJpfL08T/mtCrd3pXoka/KzBzGAZ+IEHujN+2I+yEd7rzKjqqIflo+EkhbEFm3x4XJOw/LbQslOd4pyR9Qa649rSTd7JQLe337Al4h6REw4/Xt0+Cp+kjWQxITTw9CzAnZ9YoMMQLv5wNFrrnfITC6XlTUnT/2pqOnTRPmXdX00K95/XMRK2kt+VR+UUY+0Po/PLNU123G5ZiWHmf6Cm4dQHoWC9lRplPUoHhjpb6i2eiRQ0aMpnVnUoLVxzLQqyzc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2HniyDdXIlnpk0xzZsajMZlxdFe8y8jgSk3Eoqbyf3eLT8kPHynS3pSW1HF4?=
 =?us-ascii?Q?qBEvQ++hOwJZTeCry4sVME4qDjPzLFWGwUhXWIvsMKfcPZrZB9l3Z6CP9xln?=
 =?us-ascii?Q?EJFDoubkbYHs3wTy1USo/T4vOvSnGJREeoj+x8XhHz5Q8f8yFtr+MS3q+XUf?=
 =?us-ascii?Q?CwmXvgpX5SfTcIfPRjY0yE/f67dE11vRUux5CPudyFCgLGKpOIU9uHQoGbul?=
 =?us-ascii?Q?Rlyxg30rLDNUCpsO5m5/UmTDaWjAI9TBhXgi4Rtlta9l4RW9Bw2EEW8kAAOe?=
 =?us-ascii?Q?+eTDX4JlP+KjKZfAA0Q/SGQhFlugIQeP8riuii8lxe6fenxXb3KPqj5CJExc?=
 =?us-ascii?Q?U/vTNDUvCGAEv9TxubxQf+v6Qf+GPR8IOCzipKsPADi+bA/Wtc1PWuoP5Jbb?=
 =?us-ascii?Q?3G080VYjeF7QX0KqJtDgO85aXj6ZG4Cv7CMEXX53PFF8S4ykintkSnZpY+4k?=
 =?us-ascii?Q?0EOIEp886L6l6JHBIlA7tKWFdgbzOu0tHk90M/TyinZNCuWi1PIgj3c+OpSu?=
 =?us-ascii?Q?K4AGx079rhJTtzAtdFeJ4qIk2I9v/axQejfIkZg8qeK6CuOdwWEnaxJ7X7x+?=
 =?us-ascii?Q?DzVebKX/ypuL6mYamf4VHBS+ewNcBXSQA6EYT7mvcwSbjcZk6Bfx7CKeNfvz?=
 =?us-ascii?Q?rMjPGHkQJ7/w7A9NT5/m6qUHFVxoKNR8gDHC9Ys6aY02NWCIIN6/bD7hNdin?=
 =?us-ascii?Q?aQYW4yEP/GDA7q0tl1F21fQzuAO7831ZZ8ZPmqqYVqg+b9iO68An9xQqs+xR?=
 =?us-ascii?Q?+8c3gZQTXqDnJp3stR8FIOWkIj3ZEci1w6eSljBXxtIfUQjWnNZzHHeib9gQ?=
 =?us-ascii?Q?j4FuuYeTsqeqfQYx5w/iZlwUBW1P+Tz5plItqqP+KBcqZfiayShlN1VAfvAn?=
 =?us-ascii?Q?XQEJ8cB+gxSXPvooEFuFa5xCZExH+aNKDxZ4GhE/jNpToJ/2lJO2DB9oWDf4?=
 =?us-ascii?Q?hcIRBbpJknLiAxTQnNh2ldmtTpVDD1c+Z7D45zl+ck2inF70AmoEq44GfOpG?=
 =?us-ascii?Q?Z2FIuC/LAkH+dQ+LW3neEGsmLcI1qdoq7g7AL5yudigU4oFbjSHH1EHXZoak?=
 =?us-ascii?Q?dhsB8GAsPilg5BnODF4GhFhuKI8VvD+xe7AXj5wTSvwNV9RvkT22k2t3w80C?=
 =?us-ascii?Q?AtuhdWF8RlSIJbhDyzEJuO3g4vlKyMgo2BuykCAtTPT7EeFb7ImSzQC+dvqe?=
 =?us-ascii?Q?b4xEpWwXYXkogQ+F6++R7PPRUo+1w5YWSw79ygicjB2TDIw7Uhl38ze3t8Pu?=
 =?us-ascii?Q?4BQVd17wQNbc3bXRxBPQi/QFx2mcA2x9rePefQxVErG64K/gzgPhIhy0x/iZ?=
 =?us-ascii?Q?zN+UPEqM/OmZ8tSg7/9ylXYuXUcoByfW/QXLzCk3yl6IlnrTHbEGkQCj/ivv?=
 =?us-ascii?Q?oanBObmQv/GUPf46fb3olhFTTWYrziFNNI738lrHv/PueyLPoHPozNmpdw3f?=
 =?us-ascii?Q?DASPo9wdYd+K9AuSziModPgGXTtu7YdvxlHTtIA/AmbWzeOcylgGHthebEXk?=
 =?us-ascii?Q?grza/4rw5v3EVZHrz84B9XrjNKZ688yOSCMUPPq0calrbXJ8yXpaHvQh5WTh?=
 =?us-ascii?Q?NYpgKGEF1dYJKpnyJyjiaylOhbEl67tZSi7ZdoqCPFQSxDFeUplpmry35dcj?=
 =?us-ascii?Q?u87M/MrtG4qb7BcyvMez/mSTRsz5L/aG0qquwjsRprdQSxJCOcGk5y6cSsOd?=
 =?us-ascii?Q?xhBKve34czN++fgeZeNK01zdqucLBHOsBJC9zDKOKn9VVdF03RqOdMh5D33U?=
 =?us-ascii?Q?qX4ni8VCpw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a7679a-a4ad-4214-2961-08defb261df2
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 23:37:06.4830
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YbNwkjZ/+LHS6lpPwZNjWioA+RErZQvmY/Y3t38/TIYivgjUhYVyCscfEGcc/7MIvABhODbS9bhXQOIxVcZ9zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3254

When BTF (BPF Type Format) metadata is loaded from vmlinux, perf trace can
inspect the precise C types of tracepoint and system call parameters.
However, function pointer arguments are currently not recognised during BTF
pretty-printing and default to hexadecimal output.

Introduce btf_is_func_ptr() to inspect BTF type hierarchies
(i.e., traversing pointers, typedefs, and type modifiers) to determine
whether a parameter resolves to a function prototype (BTF_KIND_FUNC_PROTO).

Generalise BTF type caching via syscall_arg_fmt__cache_btf_type() to handle
structs, unions, enums, and function pointers alike. When a field is
identified as a kernel function pointer, trace__btf_scnprintf() routes its
value to syscall_arg__scnprintf_ksym(), enabling automatic zero-config
symbolisation of kernel function pointers whenever BTF is available.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 825b16581581..94dc720a2b3a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -974,21 +974,43 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
 #ifdef HAVE_LIBBPF_SUPPORT
-static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type *type)
+{
+	while (type) {
+		if (btf_is_ptr(type)) {
+			type = btf__type_by_id(btf, type->type);
+			return type && btf_is_func_proto(type);
+		}
+		if (btf_is_typedef(type) || btf_is_mod(type)) {
+			type = btf__type_by_id(btf, type->type);
+		} else {
+			break;
+		}
+	}
+	return false;
+}
+
+static void syscall_arg_fmt__cache_btf_type(struct syscall_arg_fmt *arg_fmt,
+					    struct btf *btf, char *type)
 {
 	int id;
 
-	type = strstr(type, "enum ");
 	if (type == NULL)
 		return;
 
-	type += 5; // skip "enum " to get the enumeration name
+	if (strstarts(type, "enum "))
+		type += 5;
+	else if (strstarts(type, "struct "))
+		type += 7;
+	else if (strstarts(type, "union "))
+		type += 6;
 
 	id = btf__find_by_name(btf, type);
 	if (id < 0)
 		return;
 
 	arg_fmt->type = btf__type_by_id(btf, id);
+	arg_fmt->type_id = id;
 }
 
 static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
@@ -1023,8 +1045,7 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 		return false;
 
 	if (arg->fmt->type == NULL) {
-		// See if this is an enum
-		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
+		syscall_arg_fmt__cache_btf_type(arg->fmt, btf, type);
 	}
 
 	// Now let's see if we have a BTF type resolved
@@ -1111,8 +1132,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 		return 0;
 
 	if (arg_fmt->type == NULL) {
-		// Check if this is an enum and if we have the BTF type for it.
-		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
+		syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
 	}
 
 	// Did we manage to find a BTF type for the syscall/tracepoint argument?
@@ -1123,6 +1143,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
 	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
 		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
+	else if (btf_is_func_ptr(trace->btf, arg_fmt->type))
+		return syscall_arg__scnprintf_ksym(bf, size, arg);
 
 	return 0;
 }
@@ -2566,7 +2588,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf || default_scnprintf == NULL ||
+			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
-- 
2.55.0

