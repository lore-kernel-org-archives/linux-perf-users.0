Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020140.outbound.protection.outlook.com [52.101.195.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C9D35B63C;
	Fri, 21 Aug 2026 20:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345390; cv=fail; b=IrfbBvLpvEUzPzAlZpWC8/cRJS8gm15sKA1qe0tYvBbeg2D6QohtAr20dSOG9cQEvz/UV/5wj4OHTSpN/l0PvxMParSrL71iex1U6ciPNH1R/Qp1nrEEJvswCSaqmBnESew/ec6xvyoy7Y63QyMv1MN9JQjVTzIVxmkYZO66cro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345390; c=relaxed/simple;
	bh=8uIAm1LzpZN8dLHCT4WDGOZRUNZ94W4NDRqcsRzTXeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fGHUXIF6Ir1ibVJEEl+y4s4QdcuhIAtRiAM4U/dziJkbmzoPbH22GI/ZNEO7uevegDtDpXD5tfTJd0Qtwek3YSE+Ygh8i9E1/wjpIjupKCTPMk9zRRdGtnlNuiQj4zejjCEYUTqsOocRYpSprvIhJKf0nNKA+8q0OrsIulPYn5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ttn9FWMU6NVsrAuiGDiEUvVj3VEUrgHmQgtgFUcfuuK0yoVEmq8q19p1gEHgS5n4EdXE+AEmlleq+gJN+BlzzEQDxVEOeM91n9amVbyagkPW9NzxhCr8Z/o1+tzg3qySItC9fEulO87vlP3Ky25QXh+VuDlWxo9+XgBJN32nMHXB2g20OaahXR/Tnb/Lhzh9IcZPAAkKUfsUwIJta/968nd6NRYZpFMF6ELOthn3/Wu0c/Woo0NhZKEMzM4aGRXAx6KCORoGLsiTX9e7UzIYNrZ0UVrj2866FTVVAcUfIcnO/9gYr4GDqZdhHvxPbAqkTemnWvcfqC0zPtwvIM8Yng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=ma9hmAqw2nMZX34p9OgclZuvb3Y8EY2aa4p184hr2VI=;
 b=wBL/SvhgD7fTCSH/AQZ7FHIx6GrsrN+gYfz56bw8bxOxioPWgyn1UZW2bR16eEeCDSDEFmCfP1RCxMPCYdUxni0PbkWn4/OV5xGUGbVzAuNWyN45nufJEw9qLptP50OlvM0JdMqOFHkfqPNsVuEJBJUyjW8eSgdOyaS+Cn5qP8U+QByYzQvNNozEDtFFAgYKpBx1oBDT/D20hXSP6tsHoYTneZCTy8zoyOdpJ5D+p6bKudZShbGL9L1CAkLXIf8t4u2r5JHFtGTyBZ48Gzck+57OEKVhXhH1EjBlr+g5en7R4uXQRy4u444ZdHfeE/3Hm6gfE1adkcExN+YGQkblcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO2P123MB6104.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 20:49:46 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 20:49:46 +0000
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
Subject: [PATCH perf-tools-next v4 3/4] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Fri, 21 Aug 2026 16:49:29 -0400
Message-ID: <20260821204930.679027-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204930.679027-1-atomlin@atomlin.com>
References: <20260821204930.679027-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:408:e2::9) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO2P123MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f4ed5c2-ad4e-414e-0205-08deffc5bbe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|56012099006|10067099003|3023799007|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	g3uCyZlYDGFgv/Mr4uAEVnmtA5/R1iNkExKJ3va2eVZgagogWL/r1qOQgQrULmHxrkxnWvOSBUKLcCr6qeXl50TxQXOcT+rKorUY373JnIZtlZ4QyNj7lFsk4z5EF5uX+oUg5C8KC4k5+/LXofIQd+3q049PQmJCmquWQcQPNdFR1XmyS9f3dJSQmSPvmuQozyeGo6qX2sFBktpCuR2nMbBRljeZHxwjdT5RViFEfSbcbVUWlubI7DiXE85o0Lx4KXTlNef89nTg3TV0W+ZOuqwrYbfH4R+9CqPROGIpbMEfA6rQowtq9pTzHpQPcELZXK/pn4NyHSXcKuQv4gNkZEIigPrUN5Va/g7YngvWHmctleBDFNaAosnc4kz8GOOAGe6bHnHjLFfFWUOHimhbmZ08LWXwblHeCosOSnn/JB/DAcxGVu4kJl158A4NrZSS2dONnd7u/Tl/MeR91M57TSAVoV0dxpAkauqmnOngU3S1DbORDIJc3eD3XIBxDXU5RHMYJbt2o1FUKGW3bKZR09/gH0VQCe15g/kUwVkpN4WEusD13Mg5Ito+RBL99uy3P1cxsNuy2bD6SUY0wbP8Lh3uyKxHftuUyqq6W6y5lsFomH0X06I3Uj7pFABKJJfN7ZyVCqTCQPun6zSg1mHyWkcM5GgFW31IKCDX0A+TxB8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(56012099006)(10067099003)(3023799007)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zGeGLbO9rD3ZTcmUqgXJVrERt1gvgjg4C+t7i4ExjoVUHNz8HBNNVK8nYKL4?=
 =?us-ascii?Q?F1foWVlnlkTW6HA2H8q0P1kZZ4xeqgzHP7IefVxCBpmCliUpv46TFYPMNsmi?=
 =?us-ascii?Q?jUe4xNdDfIe7CetoCrG3BsUuOERt1k7qLhDQlM4g2YoU/AFSyxEpnMF+/kkK?=
 =?us-ascii?Q?DYV6FDX7lelMReqEE0Om+IpxDXIQtQ16FXa/HXiIun4z8rVRs4XKZfMXOUsb?=
 =?us-ascii?Q?zcnWKXzoeKIhA9fLbUorSPvSjlV7fAuqlvNc62ahS/UCSiZ7EHYGrwhDmBI/?=
 =?us-ascii?Q?zD26jvGeQxvSkdQCpsXkyNwThCNzxn+hKml4JQb8RL+G9EBy8DWn4i5fDRSI?=
 =?us-ascii?Q?NWmuqcqy62rqJkwKYkB4hsO0a199LF9wKpHpgxVsBMjaJppFdWSv58D7XxXM?=
 =?us-ascii?Q?P+os4ZoyVfI3Ap3jWuheNQLRhIw1U1GM+IY+T0U3s8zKnXKfFPLTgn0GEitD?=
 =?us-ascii?Q?ApI5IqTwTlMeTH+rFCWo26Mo2WCDh97FfBdmfYDKaqnBi0JjWdYxNzzhLBSb?=
 =?us-ascii?Q?9bpmL0eOdjbfBysgWSPjrISUXrDwG5RE/Nunc0ZgR5f9yufUJyaXkcZ9+17y?=
 =?us-ascii?Q?4CmijW1TIr4XpMl5MbG4hWMMleeKshGs57UuGNq5pBRseO0iRcg768uObVLu?=
 =?us-ascii?Q?QTnaOVgSovnZfDfYzpMVNVJeo61/jMFKeBIeLa9jhDaps769UNT6DFekEy51?=
 =?us-ascii?Q?IDiKM2aY72Z9a5yIQwY2RfvyGvV73kMyztZ1u7XW8tMP0epguSE5i/qFdGrm?=
 =?us-ascii?Q?eprl6iD7pFk2cgAXMk/VG+eJlqjrYe5N/w4pSEUpaJ5u0Fr0XjXHGKUZkLKR?=
 =?us-ascii?Q?bxC5eMlpca9lBH9mmbL6seclTPJuOyIesAUdAigFPoGswyS7gN0Z8tKu4JuO?=
 =?us-ascii?Q?rsoq4Hb5g+g7yCy0dydh/RvjQ+ocem95IgeYP9egQP0Dek5KxntDeugKMjUe?=
 =?us-ascii?Q?VLSKADo8iURh5WxhdnDtQxRTQ99IU+sfYZqDD3yK6UGatyKB1WPHkL1xbFc2?=
 =?us-ascii?Q?mKMJPbIlTkLNsSqHdWzHEHdGCBLD0xzrcsOjsukpn/L26FHQf751CGSq03bt?=
 =?us-ascii?Q?c5zsQlsHAgRVVuWpbncSbLdS32mZzn0v5K6F49zYkuNL9GzneDzoVtG1IKWq?=
 =?us-ascii?Q?oMhq9xMryhhz6YJZlmAl0N03T/ZHXOSGLzlkLnp1ikPWkLjWzQIVavjg1b1O?=
 =?us-ascii?Q?dzgdNCQtqIyX+oLvUNPT36ankqW7a4HeYAco4RXyl9wSDSOZiZ225O3WAElv?=
 =?us-ascii?Q?jRegnYK/245SpXnkMWylGg1Tv3IGYP+L/JdWpoWKW9ILLaMM1GP3NrUjVrYy?=
 =?us-ascii?Q?UJRndMiobZTu2G2bh1B7EbZyLceqSoSgtstLwI49l1x149PKfKTk0kvCHPER?=
 =?us-ascii?Q?xrTKc3Y65krIgxPdLMNAWk7vVxJvT+/wivH1/46pA78Vo7T9hqpXbjtp7EQI?=
 =?us-ascii?Q?bEJZJhyjQulUjQmVzTU5UgnMaITr0z51pRNHRyU15VZ2lmeEyVe8u3g3+9RC?=
 =?us-ascii?Q?rpQZ+wSyHL9JgQkRZokvbhRgqoR4mrWvxgY+SUSkZL17+RTwFqj3UyGxDFJh?=
 =?us-ascii?Q?y58sSIa0t2Mx+7PpOehrwdacCuQUUlBBLZvPVI72N5gXKdjXItdVXgcn54zh?=
 =?us-ascii?Q?Es1GUrud8+FLxP269f3I0NskU4Cs0YUzBKVXS0NYV/PV+AiH6ESYOR/kWa00?=
 =?us-ascii?Q?D2nYI1V00MLJnZoX9E8Pjax8QaN6LC3StgaaSvVH1Zu4aroWKBrJleI4qgk2?=
 =?us-ascii?Q?RCPOcG3Y7Q=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f4ed5c2-ad4e-414e-0205-08deffc5bbe7
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 20:49:46.0907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4jV4FIh6wGSMi5cfWR8Xr9ymB5MS7xnArIAdzy5epKluc185T827KLOZhRZqnEXYOYbF+DxTAgdvVyonb0Q7uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB6104

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
 tools/perf/builtin-trace.c | 100 ++++++++++++++++++++++++++++---------
 1 file changed, 77 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 0a12d7b37d8d..9f9494f9d9d8 100644
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
@@ -1077,14 +1119,19 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 		.bf   = bf,
 		.size = size,
 	};
-	struct augmented_arg *augmented_arg = arg->augmented.args;
+	struct augmented_arg *augmented_arg;
 	int type_id = arg->fmt->type_id, consumed;
 	struct btf_dump *btf_dump;
 
 	LIBBPF_OPTS(btf_dump_opts, dump_opts);
 	LIBBPF_OPTS(btf_dump_type_data_opts, dump_data_opts);
 
-	if (arg == NULL || arg->augmented.args == NULL)
+	if (arg == NULL || arg->augmented.args == NULL || arg->augmented.size <= 0 ||
+	    arg->fmt == NULL || !arg->fmt->from_user)
+		return 0;
+
+	augmented_arg = arg->augmented.args;
+	if (augmented_arg->size <= 0)
 		return 0;
 
 	dump_data_opts.compact	  = true;
@@ -1095,8 +1142,10 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 		return 0;
 
 	/* pretty print the struct data here */
-	if (btf_dump__dump_type_data(btf_dump, type_id, arg->augmented.args->value, type->size, &dump_data_opts) == 0)
+	if (btf_dump__dump_type_data(btf_dump, type_id, augmented_arg->value, type->size, &dump_data_opts) == 0) {
+		btf_dump__free(btf_dump);
 		return 0;
+	}
 
 	consumed = sizeof(*augmented_arg) + augmented_arg->size;
 	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
@@ -1108,33 +1157,37 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
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
@@ -2579,7 +2632,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf || default_scnprintf == NULL ||
+			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
-- 
2.55.0

