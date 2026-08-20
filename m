Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021140.outbound.protection.outlook.com [52.101.95.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10AE480DC0;
	Thu, 20 Aug 2026 21:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260278; cv=fail; b=S8CEDu3NHLKwyB2W6djOz6UPxb0RmTJ/+mmn/1T3yD2YUiQNoknntaI3Awe33/cgCcdc6/GzGm8IiAJ9L1i63f+4F9wwedQq/IH6SZqcd8V3kCAs5au4vfTgI2H0WsyTtCi5zNEMGjoMWR9ax0SAejjZPAH/0IL8NDHyPFRKKNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260278; c=relaxed/simple;
	bh=ii77AeT6m0X2UvU/nzwocbrlY5Lyo4Ow0u+o0h9HOH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUyPvANR8KXmk0qwFAxaWgmp4HL7z2PgsFhX/n6oXjjH30w6gQMUWK1DPMEuGe8HmZPqbOhJwl22Isjk0Iyba7M39o+opS3Yf/wRvhZQ2PWRTy6Vm6uHXSq+7i2uLrDHF+YEdVkJuSKM2RbZWGxylGbeADpNbkjbuIIzo+H7TGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.95.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c34PQ63fvQ/ITbeiuoDphWhWZEF3cqVHfPVBosM3s+oNaD7kLqyMA0H9qv6iZe+iAEYda+jo8luejhOpeHNgoSw4diiC/0qFsPp4UmbHQOVgoMciELhD5Bbjdy00EAlGcJ7ePAK2+kPB31NRHsCq4pgdK5Gd+9W3Rq7G5sQgUlfNEZjpO6/XptHzv9fzuZEYJ1Z5Y4Oy2QOjFHmv/d+Hfn+eCJ5hhInE5Z7tjqqCoRXNYoEsIBr2ToaTDHDPT2eal1PZqQDu6Vuvv8056PiVvMSw98Kpjn9ANHf2pL69imxM+SsEPNdySVHquM0vy44NlDeUfYfgeLqht9SzhoO99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=IP+BfKsbnmazkXAfqpmSc//26rL2Y8B9m1qHD2Mhp3g=;
 b=N+O3cVnEjMFqj8Vwn1Y4FP5P/mqhjnGQKqL8SckJDW+Sg2oFKChN/yMOZt2KzT1PkxdeLApQ9n1rRfQY77LRPYLa6X0I/LdsIC1Sjbc07SK5E5/nnw2PLDRuhvDhQMMMUUsTuig74p2An4uK7jWxMWvKdpoE24WDZPyWKN+EO9d8gMzvItHxqCVEDRruAhe+NGh9KfgtZBBBurqfxLEFT2bYFT2ItrEeLUUWWSj50JEyuyVSQZFFD6gMmF+lythkDJMaFPR2rUDoc3dFhHwygV6N5QuOsi1YobsAa468lqs+MC9J9H8/ayfho6HzhXLmckk1g6m+7bGjBwHDpwurog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LOBP123MB9004.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:4c0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 21:11:14 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 21:11:14 +0000
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
Subject: [PATCH perf-tools-next v3 3/4] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Thu, 20 Aug 2026 17:10:59 -0400
Message-ID: <20260820211100.649142-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820211100.649142-1-atomlin@atomlin.com>
References: <20260820211100.649142-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0782.namprd03.prod.outlook.com
 (2603:10b6:408:13f::7) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LOBP123MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: f41b27ce-7fc2-4c1f-f588-08defeff9151
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	LztfRybjuUkTc7J8klVRYN/popB7xaWbJefZBRWO+xnoJFPaWUQqbI+hOBTd6dnrLScakmdXdFB+eKU+Tn27k7l/+XqQNicUZRTKob7mbZwRQLxrT0/dUjS1os/lK+ursxU1LuMKehJ717uWSjtMOfWIeHdyWLKUNnrFz/EpmI6b9qdL1xzx0un6219IN8nzUUzW4JRvzVyD82BlrVZvUrHAMQlV+F8wD5l+TKaVcxf9z8B6jZICf0hU8J1BtON76z/cjaT5ebbvWIWu4u17z5Soduav/Q9h/rbtUBXJ495L8ShTA8FTWkTWRou5nyhG6MZwPjLEob7A1DQeLfzJ/HkksQXtmfBCKvz1dnF9R81BVvYHKplHemRt9sz2xMz4+qNlOsz6XXrlnUC83Kb0q2ew32YfQihBSDZ3n2IhvjKGhUWJAuTDgjVTSznQLxXosteotrvqFALgv24NaAUaG5pBKdTXBbFQIni532X9AuRsP4mNbCQjadko8qXFAFkEYWKpKkWLXiizWx74CLMWnP3Q0OnuUZrRS+4raZ1pTq0zQ/8dx6J1cji/ZTO6ZXnjx2gHG/3CgSZpUGD/jOk/xS1Q91dlDa0JZJ4IxTJgmkvtXaFC76deV06B9HJOoxikuh2GueXutbNQzlkcAvn2NQTZrjMr3Y7u3gJDoXROpwc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/fC7Emr4igAAG6I3T+avDREY5cXB1bahnbIcO141Q2UcwbJc3++LjlRSiblk?=
 =?us-ascii?Q?e09MMKclMUV0PRNRT1pzlW1buW73zkNpSLtcNvwlHWmSVmqe/tJpKoNV3GoJ?=
 =?us-ascii?Q?sVEvjVfHEslv3WxqdHDD0WwPW4BV893yE2nem6C5Sgi4l/r5lRQtkYv3Z71C?=
 =?us-ascii?Q?XI1jTQI3Yh178wnT/Oo79AM+ghbJeMG6pWBDga8gpYdisGAgwXrRle0D1T1S?=
 =?us-ascii?Q?8r0nP1wLXT8IKZB4RrkYl9m2THZxd2KGqesozVX8w20w0s0izjXTF/POmOTN?=
 =?us-ascii?Q?T4oPrafDAqp+XkHzT4GJ+qsLsubvVV2YV68ciIsr+fqqkArJqLSht7OwXuqu?=
 =?us-ascii?Q?Lex6AXrcB/J2kfx2i+l2wcq25ldwwbjiwwKO7ALupFpSB2+jWYyllMuQwLQ8?=
 =?us-ascii?Q?vqHRAh5YZRVOTHpuVTc6ZcPG4UYiEeZxo5LHgRtTnUnhHcYasVg/RTTLmXDJ?=
 =?us-ascii?Q?z9VHvjVDA7gKRSDBsfHOAYsVyZVM6BWXzil1LDYXVQe3+DKT2Y/r2T2Wf0CU?=
 =?us-ascii?Q?ctmyi7Z38OVqEjqVQ/LfxuUQ2/AAymEC82F7xduODQBByDsFFdfzPpUyqYCu?=
 =?us-ascii?Q?wszyI3iQ03euBO3xVW/Ie/5lTIB27ZDzZDxjVA0rOVLLrKa592WvGPzGikJR?=
 =?us-ascii?Q?posWhq9iWjK9U+KmpjtTfK4cFWAl0c1keRYcOzNhcBpEYdlmD4sZYAd5tlo0?=
 =?us-ascii?Q?Unz9b7eGV8TZipaq/nsUsYb9rHkQan59Acy4jF65cN+qdX0vv4L7JoDFE1U2?=
 =?us-ascii?Q?sYn/cefJiale/KCem0BiZzNBBZpHkcXZBDhRxwezr+V0jQjSTC9aZl4xOchk?=
 =?us-ascii?Q?+irYFCg7rMTAuCypeZ4mfuGtc0rjsIGWL0MEQe6ATewVI7YeVdJKMFXbnwkG?=
 =?us-ascii?Q?0TyXaY8MJrI3IsudSoZ7tkAR7XHM1mMD9HfPS/skUm1YyKjsP3GZqbBE5ACU?=
 =?us-ascii?Q?8FPOVLPg02gxGV4eKt1qSh3Id2hdHybDK0C/UuEwqQkTgNDvFStJXJakSy+k?=
 =?us-ascii?Q?52WxDpMtaslyhChhTRroJdUMAB8Y4pTGTNLYDynRK4r0ndcTqjBtZg0TdmBc?=
 =?us-ascii?Q?QbMceg+sqBGKvWQzWvMsloRmD0WI2HLJDlPyfktcLRzVRxxe7s2wlP75kg0z?=
 =?us-ascii?Q?PORb6MNCcEwEo54mVmjwk22EI944Px0prq0wJZymGo4ZcVBnt2tkPZaur914?=
 =?us-ascii?Q?9HYb5il5oADEkV61Ef3pnf3OGoEK1PIZxPpwa2tvoBMkkoB+eiP9QSvyb5Fc?=
 =?us-ascii?Q?TakEuhSOraB53ksMGYOkOBRLytvcLFLycbV2aHdrubcOX9jjyWhcWhabf3+N?=
 =?us-ascii?Q?gtoCMGVnwHNmXrBc6mSrt1pB1j+ql3aj839iiaRsGTR+ofnIetGGfrPX7d5H?=
 =?us-ascii?Q?ZqeXrh7WgjS+ZuPh54oLSk4PQqz6cSaSWpL78eqPvcUW7Ld+VsqcMJITzfUc?=
 =?us-ascii?Q?mODz3ZP0Y9SBDkwav2blR9duyM6UtkGDfbN8iBN8yZVkap6ymvJUWhqIGY/F?=
 =?us-ascii?Q?TnprINwND3WgjjCrHPAAe5OwxMnk3N2Lg/HQ5gEXNTCTIkMx8NHB0CqVwVIG?=
 =?us-ascii?Q?Nv5yoAItla9HMKlXE1e4KGQTMl+bACkW81kRpG2XOIVclA3TAnRF1KxSpNNl?=
 =?us-ascii?Q?hnotZy94r76fsXO4zlN2qiqEo+KKXyNUYHzw9hntEgsLj91qZSbE5Fbn9Vsb?=
 =?us-ascii?Q?P/4ENa85XQSHhYnGNG+36HTqpkZ5aT2SRmhf7rdqy4mglHbOqQK0iS7b3T80?=
 =?us-ascii?Q?IBy5+6woUQ=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f41b27ce-7fc2-4c1f-f588-08defeff9151
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 21:11:14.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9wIE9Wz+RBFlcFcXOkLJhVI4df9P4FwhqZMQA9GI2NbDS/Tn4mshmp6TVnGA1zfQBgZAWDeS+d1MT+fcLEg+3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP123MB9004

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
 tools/perf/builtin-trace.c                  | 87 ++++++++++++++++-----
 tools/perf/tests/shell/trace_btf_general.sh |  2 +-
 2 files changed, 68 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index bb8f4fd9ba24..4182906449a9 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -122,6 +122,7 @@ struct syscall_arg_fmt {
 #ifdef HAVE_LIBBPF_SUPPORT
 	const struct btf_type *type;
 	int	   type_id; /* used in btf_dump */
+	bool	   btf_type_cached;
 #endif
 };
 
@@ -979,21 +980,61 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
 #ifdef HAVE_LIBBPF_SUPPORT
-static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type *type)
 {
+	while (type) {
+		if (btf_is_ptr(type) || btf_is_typedef(type) || btf_is_mod(type))
+			type = btf__type_by_id(btf, type->type);
+		else
+			break;
+	}
+	return type && btf_is_func_proto(type);
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
+	arg_fmt->btf_type_cached = true;
+
 	if (type == NULL)
 		return;
 
-	type += 5; // skip "enum " to get the enumeration name
+	/* Pointers to enums are memory addresses, not scalar enums */
+	if (strstr(type, "enum ") && strchr(type, '*'))
+		return;
+
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
 
-	id = btf__find_by_name(btf, type);
+	while ((isalnum(pos[len]) || pos[len] == '_') && len < sizeof(name) - 1) {
+		name[len] = pos[len];
+		len++;
+	}
+	name[len] = '\0';
+
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
@@ -1027,10 +1068,8 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 	if (btf == NULL)
 		return false;
 
-	if (arg->fmt->type == NULL) {
-		// See if this is an enum
-		syscall_arg_fmt__cache_btf_enum(arg->fmt, btf, type);
-	}
+	if (!arg->fmt->btf_type_cached)
+		syscall_arg_fmt__cache_btf_type(arg->fmt, btf, type);
 
 	// Now let's see if we have a BTF type resolved
 	bt = arg->fmt->type;
@@ -1038,19 +1077,22 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
 		return false;
 
 	// If it is an enum:
-	if (btf_is_enum(arg->fmt->type))
+	if (btf_is_enum(arg->fmt->type)) {
+		if (type && strchr(type, '*'))
+			return false;
 		return syscall_arg__strtoul_btf_enum(bf, size, arg, val);
+	}
 
 	return false;
 }
 
-static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, int val)
+static size_t btf_enum_scnprintf(const struct btf_type *type, struct btf *btf, char *bf, size_t size, unsigned long val)
 {
 	struct btf_enum *be = btf_enum(type);
 	const unsigned int nr_entries = btf_vlen(type);
 
 	for (unsigned int i = 0; i < nr_entries; ++i, ++be) {
-		if (be->val == val) {
+		if ((unsigned long)(__u32)be->val == val || (unsigned long)be->val == val) {
 			return scnprintf(bf, size, "%s",
 					 btf__name_by_offset(btf, be->name_off));
 		}
@@ -1108,33 +1150,37 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 }
 
 static size_t trace__btf_scnprintf(struct trace *trace, struct syscall_arg *arg, char *bf,
-				   size_t size, int val, char *type)
+				   size_t size, unsigned long val, char *type)
 {
 	struct syscall_arg_fmt *arg_fmt = arg->fmt;
 
 	if (trace->btf == NULL)
 		return 0;
 
-	if (arg_fmt->type == NULL) {
-		// Check if this is an enum and if we have the BTF type for it.
-		syscall_arg_fmt__cache_btf_enum(arg_fmt, trace->btf, type);
-	}
+	if (!arg_fmt->btf_type_cached)
+		syscall_arg_fmt__cache_btf_type(arg_fmt, trace->btf, type);
 
 	// Did we manage to find a BTF type for the syscall/tracepoint argument?
 	if (arg_fmt->type == NULL)
 		return 0;
 
-	if (btf_is_enum(arg_fmt->type))
+	if (btf_is_enum(arg_fmt->type)) {
+		if (type && strchr(type, '*'))
+			return 0;
 		return btf_enum_scnprintf(arg_fmt->type, trace->btf, bf, size, val);
-	else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
+	} else if (btf_is_struct(arg_fmt->type) || btf_is_union(arg_fmt->type))
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
@@ -2566,7 +2612,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
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

