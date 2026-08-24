Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E846932D0F5;
	Mon, 24 Aug 2026 13:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578310; cv=fail; b=Jm3QP5tZKoY8IzSVJCb13hfBi4opSaY81IFoFHUprrivl2CM4WeOrnfzvoArPxBU7H6XSVans0PE7b/+2oqAh1jYIEPbos3CKxGYZzvNwBHRko7gRAURc0kt5bkaOE1Q/j4VMkIhq5AG5swq4kgFIg7XIxj8+0ho6r78caZlVJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578310; c=relaxed/simple;
	bh=QwZFUAFRL7Mh6DnXPYwthFfujT/FI2acRjj7v/1z0lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aNQjMFw4dfTb0zcjpkpCR5Yk7D7xuaAY4JInrpvUP4kqlXp63uYcBw34PsFj4UpoXLRj7l6QYKhgMIMWMnM17G94K8L42MRZfSwli62rWpCIqct2i65Ld3s/6+kkSzaA7FtV6Q/W7sRNJdD7RrzSr2VdKj5QLbhilNU3mGWoGno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pxq8EN8ZjsbThM7rwy3lAbFtKNtXuJMxha7xv29Rf0HvIUB8ht5mdknD7rsWfd+PS3SFZeD5z+6vLMGb8oGw3HygiDQpPbrggIhadsM9CMDzqIiJLJmw1uMTY9uohqK66TvbSW1L54CCHyMxFzgphsB1Lr0cbB7Z5p23hQpb2QRIx1FC/+OBs/nxg8zVAA93vJb378WxG5midsfYiwEtQo5IqzI9Znp8gef7cCNUlcHWoqtLUc3GIIQE4w9twNroyKXoWkLSMLBuI8KCDaOKKhszxh7jvJfWa9+pp0mOpC44Win50rPoDIDbIe080LsA3ci1cVz9R7WjPVW7AG5KIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gv7KmC83NV3VfdIm1XBSe72SBEBPShf9LSRZRdOZy6M=;
 b=HjsMfxENRqqJK0uUQ0n/PXZeEfIDaiqh+zRCozuk0XbiliS1N1tPKITexlSKN+QTcKH4dsKpK93cQPWt1d2BNqJduurEFRyaB5uoxfg3mZENuzwW0KiojATzn1nFBeuLYS84kYxcYG0RqQHUE0lafTJ1xU2gn6ykmPDP1YXfLmQEZjGtJ3pH2jGc3G7ZMclN1fOuwQRoGg/HPYr2kKOLjf5JkvwtNOhtYAJuiAzLfFeJPUr+ZcT0jr06OHkDNhXfZnPT40gCGGM9l3JNF9raN3AfQ7jJpDxbhOvWZZ5xxS0cNnjaOlvzjCBDOr9TEiOIAr71tyYyKqUIe2YVuR22Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8950.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:29 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:29 +0000
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
Subject: [PATCH perf-tools-next v6 4/5] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Mon, 24 Aug 2026 09:31:21 -0400
Message-ID: <20260824133122.751733-5-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824133122.751733-1-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0257.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::19) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efbee5a-0afc-44b7-f59e-08df01e4015f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sVOJAu5VwxZMnf1+R9VrFuY8RVEVg4rw4tu29dqPdhmlXJcRhi//LdZJ7vR8lhIdP11/ZXfQKf3vCMhmLWWOHLSriqy2X+CJ055yj14c36SngRhM48wRwC28pUsRqiazV0Hw+MwVhetJGVXaQCo52zaG/WF3mkF8otKuhv4Pcp6T+4L7bYAxJvCYZi+GHVQjN8qrffx4VEJdm3hfpNd/5FoQ9I51EMIyv8UlS4c43+29/N1aa1f4+N52sQXVItC8BF+BcO4Zya5+myM1geeu7RZmBfj0pBYpirmM5me4E4EjcoVfrSq21RfI+HoIaIBGNFNg2bCfwQQbhStz3nNSuxqNj6/53fiGT02K7kMGxkswuWdK+gCSwyWKOSq82fn0nl75K1fh0f5EaWA9kzsjUNBfukoMrlK4xr17sxkDakVK3hcuxX6zxKgDZ7pxqpc41b76P4gvOtPlFqO8pF7+IlvttHPXqhGEBkMNhxkkwitjaledK+A/OkFkW317+/l+qWvLS3HxYf5Nmj6iwYVFqKr84L39Rc2bZQGjzPtn1fSRQqmHhcV5omT56vxVjMD1V+3Vb8UM1+ACinv+N3gJPGcTLhdtCqxJQ3ikRYBaJgxWLPS0Lt67vqbXwLjWXEFWL1IxNSQgh86bunX9uv+KUbtRD7SLDDVuV6OYbEBBI6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cV4ddjFOJBhlo+4E8KmD4jatMhjulaJohK5MaQfaU6+O0l8xXEhD9+dnVneu?=
 =?us-ascii?Q?QzEg1sohP8xIw8OJfycYIqJYarHVg6czYb8pNgEgMxGd63m639MhSQ1YRsSG?=
 =?us-ascii?Q?uFDm7y00MjlSzG9Mbgkrd0sD7x67D9D5rF2X6rOJN3TEZJgHemW+XhM97JkJ?=
 =?us-ascii?Q?KcI6LdfHQdCit6fXII+7AdFCNPVEhpf6cnjpKJ9X4Mu9QcxYruxvzu7PpsML?=
 =?us-ascii?Q?r6YCNFqEbSuZ5RcTGta9F1y7pJUfYpdlDbh9W526tfP/uoTmBiTHehbmGAyo?=
 =?us-ascii?Q?7DSOWcgEBcLodQA6wBY6QpwkOlBb18iQeyW9qNQmdknjNb97SuYBQ9fbJHJ8?=
 =?us-ascii?Q?PercJg1eVLViVEkeGJs7qtx6TWz40ONrRcjwmWmarvbAmQUGwXSgda/vAr6+?=
 =?us-ascii?Q?jUk/aiYaLp4CB07ABmxucInmtWtYrpGnXHHAGiI1Sio+Gh+f59CHQQxRP0Gu?=
 =?us-ascii?Q?iB1butT6XUEicVLu3EvkZsIEeM0BK6YVH/1Z9Xw2H12ntaTuID7/vmWIcwGC?=
 =?us-ascii?Q?8+fV7wVHnZBsh0rCsPb3ZxaczBVHoXRji3jLQMSywl3+GLzDKYv7LJe5gWSb?=
 =?us-ascii?Q?aqAgWrNOSMnp3wHIq2qHXzN5wyzgu7OVpXWHwsU/ABREPOURB9cxOa28yNia?=
 =?us-ascii?Q?G6nnKvGx/Z5ltbOOh2EPawpn3j1AyoukRJjSUBb9ZT1vZOo+26jVgKP2e5r9?=
 =?us-ascii?Q?foPHaE905xLJdj0/Iy7KvlGVWj/ANE9oI6Va68MBujBB34TJ7W1/29Rq5Y8y?=
 =?us-ascii?Q?YDTg+pDl3AyH7/GHjWpEO6WI5HIUTl4rMSxDeNcCgHJ0efmnqbxqCXcGxl3M?=
 =?us-ascii?Q?2a/bfe2UT4schHFvU0oajAg4bXxGeWjgu4f9OFAbwePOelHhSKvynV5f4HUm?=
 =?us-ascii?Q?d5tZwEKNdSxa0kLmDugxH7IG5H24ZehxKcYMtw1p10JwAJGE+ldgSavrU2SZ?=
 =?us-ascii?Q?dj6PihVonXlXS4JdH9aS/ONXtxo942aIIhtNz2G2lkFoBcJ2xQDai0Q1Vkap?=
 =?us-ascii?Q?VwZki0mNw94v+xHzrapON5o6CwEyrra0uJEjjfkiwdalFLqVKoDJyMWMW+zB?=
 =?us-ascii?Q?AUfro+SKdhW5ftvy1lnHuPnQNZIf510OA6+uDjd2IMmPSMscSWMEuumKy1nA?=
 =?us-ascii?Q?uZ3L+TrGeBvluanwcZXu3Or0zykkQ5Fef2o584nm0KGTJIQrFNpndDiKc7kC?=
 =?us-ascii?Q?yi6Wi302eRcZcXCFMGwGfsEoSNOJpG2MwjXj/UpF7WKJg49vVhKF/H5JCo/Q?=
 =?us-ascii?Q?6A0gyYWDtEzTFJGuA7FfOUUugbywqDn8xMFIWL9vSY5j09Vwz7RAwM9cvL85?=
 =?us-ascii?Q?ILG8dYhEcYp/yFB0g+S/ntPA7f4lOZJEKLbWQvwAJSTgOVBFlmc4XNk+oaVA?=
 =?us-ascii?Q?iSrxBBC04516eucKAeNwSGGmb8xpD2VrtAj5L3ZP4oUdqNlVwgh1s3G+mvBQ?=
 =?us-ascii?Q?TLmnHb9hLhrozySHXANkZzR49yduAe2JnD0SjuxVk+CGwEJ1lRWD4qRQao8W?=
 =?us-ascii?Q?sNYIGdUpW3trc7t4Q0Mweyazp2vMtETKZnUXh/58eOMykyy/A2pF9bBx1OtA?=
 =?us-ascii?Q?SrCM2+uj1i3SFV6QUVJ40TINb4x3M5AVINbQmqd778qQnKJBn/VsAcM5RXnk?=
 =?us-ascii?Q?nkjBx6ZcpEvzDQm3N7HMZdz89GR/yXJoMATQA8I9OONAFoa4WqyE5kaWsrd6?=
 =?us-ascii?Q?NmF+gL2gRNQ9ZGXdusbMlOQzZqDa0HB0lUkngb5c4pkp5WCQ?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efbee5a-0afc-44b7-f59e-08df01e4015f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:29.8648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0759a8AYJy3bVOmYCPDn6edklkCY2HeGqQuQRbRoj/vWDss5avf3iOxRYQB3UVPN3z6hEKNxJFh/HMnnlMdc9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8950

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
 tools/perf/builtin-trace.c | 106 +++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 21 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f6ab7dabfa4c..d0089230dc5d 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -122,6 +122,7 @@ struct syscall_arg_fmt {
 #ifdef HAVE_LIBBPF_SUPPORT
 	const struct btf_type *type;
 	int	   type_id; /* used in btf_dump */
+	bool	   btf_type_cached;
 #endif
 };
 
@@ -979,21 +980,68 @@ static size_t syscall_arg__scnprintf_getrandom_flags(char *bf, size_t size,
 #define SCA_GETRANDOM_FLAGS syscall_arg__scnprintf_getrandom_flags
 
 #ifdef HAVE_LIBBPF_SUPPORT
-static void syscall_arg_fmt__cache_btf_enum(struct syscall_arg_fmt *arg_fmt, struct btf *btf, char *type)
+static bool btf_is_func_ptr(const struct btf *btf, const struct btf_type *type)
 {
+	int nr_ptrs = 0;
+
+	while (type) {
+		if (btf_is_ptr(type)) {
+			if (++nr_ptrs > 1)
+				return false;
+			type = btf__type_by_id(btf, type->type);
+		} else if (btf_is_typedef(type) || btf_is_mod(type)) {
+			type = btf__type_by_id(btf, type->type);
+		} else {
+			break;
+		}
+	}
+	return nr_ptrs == 1 && type && btf_is_func_proto(type);
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
+
+	if (len == 0)
+		return;
 
-	id = btf__find_by_name(btf, type);
+	id = btf__find_by_name(btf, name);
 	if (id < 0)
 		return;
 
 	arg_fmt->type = btf__type_by_id(btf, id);
+	arg_fmt->type_id = id;
 }
 
 static bool syscall_arg__strtoul_btf_enum(char *bf, size_t size, struct syscall_arg *arg, u64 *val)
@@ -1027,10 +1075,8 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
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
@@ -1038,19 +1084,22 @@ static bool syscall_arg__strtoul_btf_type(char *bf, size_t size, struct syscall_
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
@@ -1077,14 +1126,19 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
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
@@ -1097,8 +1151,10 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
 	/* pretty print the struct data here */
 	if (btf_dump__dump_type_data(btf_dump, type_id,
 				     arg->augmented.args->value,
-				     type->size, &dump_data_opts) <= 0)
+				     type->size, &dump_data_opts) <= 0) {
+		btf_dump__free(btf_dump);
 		return 0;
+	}
 
 	consumed = sizeof(*augmented_arg) + augmented_arg->size;
 	arg->augmented.args = ((void *)arg->augmented.args) + consumed;
@@ -1110,33 +1166,40 @@ static size_t btf_struct_scnprintf(const struct btf_type *type, struct btf *btf,
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
 
+	if (type && strchr(type, '*')) {
+		if (btf_is_enum(arg_fmt->type) || btf_is_func_ptr(trace->btf, arg_fmt->type))
+			return 0;
+	}
+
 	if (btf_is_enum(arg_fmt->type))
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
@@ -2606,7 +2669,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf || default_scnprintf == NULL ||
+			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
-- 
2.55.0

