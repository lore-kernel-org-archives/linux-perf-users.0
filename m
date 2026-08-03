Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020091.outbound.protection.outlook.com [52.101.195.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849A83B47C4;
	Mon,  3 Aug 2026 21:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791355; cv=fail; b=cWiJTbHatHB09CfznCHgSeUWC8hmTR/L8PHtx7XdEwzwwfPFIcWIJEdiXX9cXr2Xlbfr7+dBiFdSRCoEt2vucVAHNK6yMyvb43jBNquDnk7S+8N8iZnmI+jak6XVGaA7JkBJEaqouqHHxgL7wh6LJs21O7pfVW5UpclzeK35AzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791355; c=relaxed/simple;
	bh=D6K1kJzEITrzI2FOALbxep9YZGcTL61/iE3vBc2RclI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbLtj25XsHEPW9fWB7B1CNenoY/NXN+DSVwFS4btTGimFXhdHiat8Bq7kruxeuAVoKIM/2yiW7REP61xeOPtRnAjWsqtXcEklThhJ7A8gYbNmDSJ5mgylLoOigKPscXVO8QHn31vw4ybwTtfY8kGYWh9I2Y08SNNHLKYy9MHEV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEFjcN8KrnS9UYMZhTmGPW9Mi1wwMZbfgQyUsyk8SAcFNBLGh+yM3p0kU7mrcZyY9XU70Uoj1oSaIdZJNfUGIDbWvWo6gzSzhf9+tTY4XCw5zlCfYsy/WxuOnmSwmbmMYJyrrIOtEJPwt2VvM9U1PUPZziSA4pR/S/GdwYIbUgF3Jm/vIbBgg6KJU0no0IWqljwdyjvTyFFHURY4TT/GDFTWNUUyYFwVjnLg50wanYZnMX73J82hdB5xfaxJfPSMcOzMw1NU8ESSKjFRZ6N2h9Xujd+nvTVLjYnX30WdQ8Cz4mkh5PtUkQtzRUalPX66hGNwfPXV8TU9Ano9CNV/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=m0X/886G+o/bPt5iffqDgCSgaurQZfng4Uoou8o3+Es=;
 b=BQmocMw3ZaUP8704hy3crZE01Kw8I5sOuRuxKENHINw3302KFB0e/buDPn1eLhlgwjbSPB1GkDgrLHxXItIO5lpZTU0ecg1bV2c0wlVT8ZSqk59iNQgXPbI5CxvxmX4qPWwfPCBS486jTXlebyVo+74/A/NTTo0y5/zIWnOih5o5n7n1u4HKyQRBkZabWT3iyIe+LikMK3J8LNyoeW6MDCeUtOD8JG628Yw7z9X4v/D+VdNvjKM84VX2+MS0VL5Gd5spTNTjmJs7dljhrePlsNXYPAS5w3ZutqvBYARWxo2KNxBhjd6oyiQ8ca5gAKvdIV8UvVaImRokqxMRHH3m7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8695.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 21:08:59 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 21:08:59 +0000
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
Subject: [PATCH 3/3] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Mon,  3 Aug 2026 17:08:42 -0400
Message-ID: <20260803210842.245789-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210842.245789-1-atomlin@atomlin.com>
References: <20260803210842.245789-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR05CA0052.namprd05.prod.outlook.com
 (2603:10b6:208:236::21) To LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2b2::11)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: ad149269-276a-45eb-a523-08def1a37002
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JoQhvi7lhRSgrcQDmpawq7vV7asyzQHUU6U4uhN+TkPftfiOtdyMbPRW2RCYIegKIRbkAch6BHpZLJUC5gqCpWLzNF7sc8qcB0PNHCooS/gOTMRbYzcs3Y4mIw97DthrQkZG9ef7bbG3ks6ExzT2qkGHc+Qn5x7Ute/S88OGtGkKtBIZc1JNgx0gWGecHYT7fAdpaFm+OUHu0MPcsU8IYEiAdK793W89nIRw4psDMHTnrz2vOY7Kl0D9TBX53mwblsjJ4QKuE4sRiIxXLJ/T0cI9iVflXXMrNHTlouw7MZ25n8+pRfQ4phVJEqiD+HYSFR37FEjWVrXkQUqVVqJRR7VEZTx448xzZeBOSuuUfmb9R87N08W1VvoUvYOPYwcpS64iONWshDJH0V15UUHY4tFUDhn0LFCWOlZGWYVqx0oxuQwrZsLzDARINra/j5pWKWCHoK78LcZNpf+QSZH0OU1Fd+7sRqoehALu2fyghRSzzwK2SWr00qhbOEEiMhwATTXRaWQSK/2ir2uhQbHx1nBWnu3NcHsGZPS5EDbJr5hqvonu/GnclIxnc+LF5Emjxu9sYoP3X3fiB7a9jzZn18BRsPcH6vqbJq5q6kdWej2y0Fxtk41rzhXFFS8QrOhpjtHGdcn1KV1ugGCqIwwhB0e6L1FoG1ogS8JF/Zthlwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cJ2R5sxio4B3a6Lo7JzgPaXc88XzZ8r68UR1sYe3ppqaFWg5XnhlW8VrLde/?=
 =?us-ascii?Q?Q2qcrUR8/fSvZmvTRGRQUrRTZfx6ABNsYMVuqXEKQwAkx+t0t14NrVHCV3KE?=
 =?us-ascii?Q?xrl9s0ZML11sxdSSaXuJJofG1EH+NPe5GG93FCfU1tJx/KETc9POLwjqSE23?=
 =?us-ascii?Q?MdPpw4p1m8pIgfsIE4cquoO4FDHY8oat1XQBiFcH31/fR0ZmAajMXPFaj1pq?=
 =?us-ascii?Q?WOK1KBDuLVtpxG+7gDieAgG7CfPiq5LcRoh4w2WoAYZ1LqLzmucIqPdvjeDQ?=
 =?us-ascii?Q?Co1qqy5ltQSDA4cglE3P8hkeGUH/8eMePufqSanvkhTfRRiNEyPWDNwLjnh5?=
 =?us-ascii?Q?W3hdi//3FMmyskWUsqM9t2VQXRtauvGPjWBDmpTR647qy/G4OjIIOnCXziVN?=
 =?us-ascii?Q?j0DSHTlO6VseIB2CtsvqFjuSe7iske3CTCqTdXWTY+hLra/k+uneA9mL/mrV?=
 =?us-ascii?Q?z0qBcTgH0l+wG/KrMd1e48wp/yhmYvzf3UAWWxcI9aIJ15Z8NG27Yc97r/wv?=
 =?us-ascii?Q?QfnH2htpuNsJUdMr2NnpSAGCOocgH0eMs1sikoFs9QrgOAHEwzJqql6e2w8r?=
 =?us-ascii?Q?PBRHAtLSjmxSyiHWFjRlkaWb93pyVK1/5wVlDCggBznFK+5a/6GPOhd2ya3U?=
 =?us-ascii?Q?/w+JOYpR5JB1iTv7YTHXWGhMP23EsEhtcW07CnYcl/YZ5Jmc/1Rz/+McxSP2?=
 =?us-ascii?Q?dAEC18o/ZOloA8GptM0Wb0V9VD+NWex1Y5fvL+5kTR9vDNlwQyze3x5462z4?=
 =?us-ascii?Q?n3Spjz6zXosIZxmrW/fpjWQhRQJTTNsjb9GFJtqZArfVupaRPukpEjr3tRGY?=
 =?us-ascii?Q?h5VWG9k9hV1lAVuak0Ts5vs5ON88JTYYvnGH5SJI/KUPvdzZUVwVcSad8W74?=
 =?us-ascii?Q?+K1B7PKwb+nD59dKcydWX3pEIojV6ZYEjH6o8lfGO1TaahcdTH637PGhAwo+?=
 =?us-ascii?Q?0WFIjErlQV/oyRogLpcz2FH803nRntpd36NjB+xUsFwGgS4WES2H7x+vSWl8?=
 =?us-ascii?Q?MWh1lof09NBE5fOlerEyTy56Q4fn64I74XAhkXrjeBaf6F63moIseH0y6fsb?=
 =?us-ascii?Q?E2XTzJ9d44EuGj8DGa2n/1ewYvDbnADR9tS4fbrdWkr/8PA5i/16ApYFRrZK?=
 =?us-ascii?Q?R2QxVpgFYXAtg+ZAloo6nno/7Vmi40pbFEQB1zSua3/3O5mvbcNyM/h0Ll3r?=
 =?us-ascii?Q?X7itfrcVuS83yqtnYN5+lx3Usb/1otDQO2XmXqNKwdZxqBsA1+vCeo4ZeG3z?=
 =?us-ascii?Q?xWUGVr7oivuqf8y/F/iXQA9CTcas4RF5sn7zEJMh7M53B4S2ktNje9loJF4r?=
 =?us-ascii?Q?C202HIEx+xCpK1pXt+nvsih/sAOd6jIW/X4BGzp55Fi1WePixun/qD24Dxl2?=
 =?us-ascii?Q?Ug+PGbBk8Husul2/6HXd/PQE2JQWjVvaBR7dWhNwWqy+Q2SzNqXwRdMx3ecc?=
 =?us-ascii?Q?uBKGGc9Jmf2rdagwMHMcduBa7HRmga6pTJ6FFJvJplUpy/8PUqZaPSpzYHxy?=
 =?us-ascii?Q?LeQubE9yzvS9+YtAS5UdCN44/GZimwz2ZGa4XseC40zvrct5Pa6h4vwNTA9R?=
 =?us-ascii?Q?lnKpcEC2et0qrPqtgcCcAcpZ3ga90VMcuAJyImWBvwLfuPf2VEc9JDVPXc+q?=
 =?us-ascii?Q?pYhxNVf8LMCHpVOPi7gVsNStbx5DmX57Ozla6t+QuMxKMCFLG09EzBAZbsW2?=
 =?us-ascii?Q?NoPqDT3PxSn1pB9qkn2LRGjYIHZ9MNjoWsqKzi4ZoQVPpuOHHw4N4XPXqcMO?=
 =?us-ascii?Q?RS/PVYJAng=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad149269-276a-45eb-a523-08def1a37002
X-MS-Exchange-CrossTenant-AuthSource: LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 21:08:59.7228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9n10oGLMV6XrJrPpvc+X5nas5KlQVVnnOdvVXlPhQYSuuBZIf65fJgilOM/LWmd83FMfKgmCCwB+K2TUH9N5aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8695

When BTF (BPF Type Format) metadata is loaded from vmlinux, 'perf trace'
can inspect the precise C types of tracepoint and system call parameters.
However, function pointer arguments are currently not recognised during
BTF pretty-printing and default to hexadecimal output.

Introduce btf_is_func_ptr() to inspect BTF type hierarchies
(i.e., traversing pointers, typedefs, and type modifiers) to determine
whether a parameter resolves to a function prototype
('BTF_KIND_FUNC_PROTO').

Generalise BTF type caching via syscall_arg_fmt__cache_btf_type() to
handle structs, unions, enums, and function pointers alike. When a field
is identified as a kernel function pointer, trace__btf_scnprintf()
routes its value to syscall_arg__scnprintf_ksym(), enabling automatic
zero-config symbolisation of kernel function pointers whenever BTF is
available.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c | 39 ++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index d3401b64340a..60dddcf93ed0 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -973,21 +973,43 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
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
@@ -1022,8 +1044,7 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 		return false;
 
 	if (arg->fmt->type == NULL) {
-		// See if this is an enum
-		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
+		syscall_arg_fmt__cache_btf_type(arg->fmt, btf, type);
 	}
 
 	// Now let's see if we have a BTF type resolved
@@ -1110,8 +1131,7 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 		return 0;
 
 	if (arg_fmt->type == NULL) {
-		// Check if this is an enum and if we have the BTF type for it.
-		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
+		syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
 	}
 
 	// Did we manage to find a BTF type for the syscall/tracepoint argument?
@@ -1122,6 +1142,8 @@ static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg,
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
 	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
 		return btf_struct_scnprintf(arg_fmt->type, trace->btf, bf, size, arg);
+	else if (btf_is_func_ptr(trace->btf, arg_fmt->type))
+		return syscall_arg__scnprintf_ksym(bf, size, arg);
 
 	return 0;
 }
@@ -2565,7 +2587,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf || default_scnprintf == NULL ||
+			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
-- 
2.55.0

