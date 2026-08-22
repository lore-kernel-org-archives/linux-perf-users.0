Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412838C415;
	Sat, 22 Aug 2026 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434600; cv=fail; b=bs3zKNcN09PLl3+nHnoznl29E8stzxjf+4ZdJXylV6FeCPXgjTT0SH4+/K10Tqu2MJh2UTs/DH4X6CSpNGuOe4QAzGkZr7eXmjPiZyMcD8L7bq6iUeMEuRDRE1RBGXTkffg9p4dwI5sD7pIMzqmMRykDS/wFwwdhRE+IzYZOY4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434600; c=relaxed/simple;
	bh=i3dUeFKUx27ZzHVZGCcXxUF22XdcC42+MULZmE7szj8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pkcvpjhZJeeCABAEjZ/1y1qd/MFMQLJRj4RXcoFH726H1u4YRsEDFViXr/L3gtHGn1VVee83ZWTi6mAaWoVty/QU7uALZWA+CNsVNgGDnlE2p5lb8JKPBNqGuak8D7ZU2xPqrxJCUU+2gqccZjuntytYwK59F53Fps3E4yWvUBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUOANEh37tkL/CdsARicq8Rox1evLQNDx9/zWZl0+sNImURDhyl/AXb+TD+94vAo11zYLjIp3pEQIXoIAMplXCe2iBrFgDkR+KoOoGXjP9RIbNJ67xUXqyEGQgO34AhFIUYZv13qPUGcqBrGrbIxVzxnnSY7LXFj0xWhkhOCqIh4xoo1M0ukWnhYcr7FWkWn6TbEju/tL5TIxm5OZI8gUxwq4q8jUvBPdHYkwQ9hnJXFywsbSFBwHawFbMM2dhLhVI4bPg7evw/NhLyPqP3W+xmITcbgbhpYsFDv/EIMTTVV6qKNr2T1sfFoJLTnO1YWzJBAWej/9HBSy9qC8GJl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=rc68OcPxRhWbgsooDpavXl3EkIoH04Hgui9LN5IkiaA=;
 b=f51mNcko7n2HTsLci+mJEp6eL8noY3HXpGc+Yi/22oGBLLKNE3hVOKh58c0s/q/TmH8G3y8hEhEFWlj5SbyqGqSOKPUnXD/jdQbIj6ibtBIpvJcsYamZAbD7wc1EYkw+kBVmNdgwswjMy0ZVnPNxkucDE+4qLlqOTvmSiNKorl0eKPWntLBAM9DUBhXcWcnHbjgeDQqGiN/RCpsnujFnttgfrHf86OoT+it+UouVYTpH8b3DTSnTvWGihRgdMBKDk72jPj7OOOhk+baf8QdfnJigHkfVZYHwYN0dGusTs8vd4JlTQZRzENlab5X23GyxkH46Uz9OlEUSVfx4AOKwog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 21:36:20 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 21:36:20 +0000
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
Subject: [PATCH perf-tools-next v5 3/4] perf trace: Enhance BTF type formatting to symbolise kernel function pointers
Date: Sat, 22 Aug 2026 17:35:57 -0400
Message-ID: <20260822213558.704018-4-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213558.704018-1-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0432.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::23) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: 99015d41-38b3-4980-7f59-08df00955dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|3023799007|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iDkEMp7awh+pBcScT85UbiaPz39aewOR9iHOP3SHMc5I8sWXqtT/4WggrOkwbRA/1kM7qWaW4rV35bJFEczJOs4JSOeR8Fq9EcCRRWRH+2Fu8X2Opik2NLXIe4RxMg77WCtbvzgOKu5pDYRMU+jaL499DTtTJC5t56D5TxBEfWSU2q83r37UjahaLVDwBAR8u9OC/mpyaR388tYal7gUOYvAshAtqbKshOa4L+skvmkA/cxhIFFiddjnU4oFZZlVY0FLCiR8x7fuAE2TtzQBg5114U+KIZfMzB1AfVOoML2E7799XDA4FsIaARsHk9jDnDG4mpTs5wTAC5nqE4E2agldTLmbe6qvIaDNO2ep84m7hceTHafq41HvacNxdG+HZRRdlD6dWoe7CUL7ZPS+MLCybpE7ZaCRyPTXTrpi5dgLUtUgZR8GuJ4hFxFGBCpRPezGg+XlCStC5cuK2+mmLwxKtQFNanB9HNn+qmZRrYEi8TexlzXjC4jwgiyr3AAXo6Y45bpPgPpGHjOl+H52BvUv5QJdfE8brvQnJutKo6it2DONHPHLt4RY9+9uK6z9IlzHna5yHraZ4dvwv6/v2+lNi4hw6uZjgS4BYUuUTbAGVTgxRfedcO5GHDC8kUfIUG1Dd/qzeNWL9eAGSSl9PVvPlFuDGAlbNnj4l0SyneE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ic7gjYw4Rt2gh/y73u7TvTLLCHbwbyNx7utF7XFpWNATWgaZImvjwBfdNNLD?=
 =?us-ascii?Q?RtA1HWcbMaedbZa9zPY8VJiYu5vWRxqm0O1oIlSQKhBjfSZbK2iZdUUeVZ9Z?=
 =?us-ascii?Q?au2SQx7KWtyAKnzHOFI+bdP+dtDuuV4z4hwkf4JLu2vtZqSwY3LKxxOXq4hk?=
 =?us-ascii?Q?J2zujJBuSZFci+x9EvyLzHkxFFHAMqQF2TEm+M/zI4oU2fZ9uRrdQDDao6GU?=
 =?us-ascii?Q?Oiw+lMixHa0efJ6K0ZE+61bueALagPO1WxnxiaT7/+lQHOYmKGvu43Kf47GF?=
 =?us-ascii?Q?pkB+fIaYmd61/rvtCW4YRT6IAFJpWYXviS3ac6bDAmE/jj01gF5+ntibZYub?=
 =?us-ascii?Q?s7OPhjnLWxtI7l0J1QLHCL33IpRPxxqXtg0uni6DtlLpM0MoDfi+Zo46rxNF?=
 =?us-ascii?Q?vdIpG5mhH+EGtE1g6URMjUXln/eCmMCJL+aQ3Fwbtfzo9kMBY1CkU1zVEqDc?=
 =?us-ascii?Q?GYOj6/wALyosFYV++Z2AsR7PuBI1PvwiQbM30DTk/tq2jwzK1BvqMlPaARnU?=
 =?us-ascii?Q?bXcfmuv3QDFA6tghpW12uO+obipMLfh7kg+pxFPoDXdif2O81oX3cVXh2/kP?=
 =?us-ascii?Q?pdKzY3W8mtN63t7dSTr4yI/uRrhXqHW7UNmN1a4IWYS1NRaUs/e+jecYo9HT?=
 =?us-ascii?Q?yanWMULn7cPgfaYMPrAoOsyIEae3dA5kvhIh+SkmaEXOeaRHrxyrP2svTk15?=
 =?us-ascii?Q?f32Vv3erfw74DlDXHqnEYYahxT1pVbj27hLH7ZYrij2tk9e+QgHaq4G9gjiP?=
 =?us-ascii?Q?gbRyNnIQs6UQGXA/t90CkAu10UsmnrC1HV4ENJX0b6BmCHhpzBy1FwMmAOiE?=
 =?us-ascii?Q?xVPO6RYUGOaMB8SQGtMY3KpmK1hOXjbNi7XBf7xPCgxjKVH75oqUnWrd5nVh?=
 =?us-ascii?Q?Nyi/tY0p+2wjzILkvS5W61BznDut4P3LQuK6MuyFyRdMt7eS+Ac7BSqGwnKk?=
 =?us-ascii?Q?Ot9M7cQNFMhCeCEf1X0woTNerPRPMUnCQES6zSBdJpUnAzMtNJMk9Xhzl181?=
 =?us-ascii?Q?oG6M0TUzzt5UKZ25uXCB32ZMfLAf0cYDVtWE2O6s/3gDuoNREd7w/iGwDOs2?=
 =?us-ascii?Q?e75/lbgOfuYo5BM6Qy5n5sEiIOoQhxQNCGIpoWtcVy2HVhfnQlOc/L71erW8?=
 =?us-ascii?Q?R4SFslx3zqDrGlOHpnCTZ/phMKFsS0d03L+FKDc2K/6rTblaAIYErpljy8FC?=
 =?us-ascii?Q?g8yoTJNRJtZhQiY544juxHpO5aW7MicV+XK+V03IyoQhaaGuPGHrislFOXwH?=
 =?us-ascii?Q?p86g3TI0zLGsNYvIPoSXVb55inhgZ9OiBgyk/lFyfQ7clOSWKeAv2G5Nc/Qw?=
 =?us-ascii?Q?TooNtbnE9FrZdflIYhqExnyiqQePUwYWmix96bvIgK142OOpkfUhz9LR5g+V?=
 =?us-ascii?Q?X1ZhHZybgZm+z4O3OGfrvIyMV8Q8vMJwhf+5u1YaYc/2eWR9+W8Zopi+LkCD?=
 =?us-ascii?Q?/0F9Y8ka/ZavGIp5aUMhIk92Kq0QGgKsNRJKuG3zeUQx5QXn+PiJGnanrq+r?=
 =?us-ascii?Q?EW3xnViSKOsnayv6wjFG3tFRTpXVyyLLwh3Ap0AhCApUENEAMVQdydEuHiHq?=
 =?us-ascii?Q?jlnsfY5FjsQ1ZrAKWkiODh50U2PnXqDAWLKhFjRn/wUlGlLRoHRCRNyJcFvs?=
 =?us-ascii?Q?E75nJIkSVBHAEA6WcAWqcUhcH81Y2XmNj8MPPe+j2G1FMLzHFyuN+68gYUrz?=
 =?us-ascii?Q?e3zACwoKcOcubEdfa6Zp7GPK0727q1k+tmMp8FElDShuabcq?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99015d41-38b3-4980-7f59-08df00955dcf
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 21:36:03.4970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HASDI+IVNOzzf/8xJcwRWoC5LItNeFhEg3abYpdXqOjCigkwx4s0DWQYERILEE6oybruq6l1fYUsxWFA8+yWgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3193

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
index 10fbea7ed4db..4f8b4f2cf677 100644
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
@@ -2584,7 +2637,8 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
 
 			default_scnprintf = sc->arg_fmt[arg.idx].scnprintf;
 
-			if (trace->force_btf || default_scnprintf == NULL || default_scnprintf == SCA_PTR) {
+			if (trace->force_btf || default_scnprintf == NULL ||
+			    default_scnprintf == SCA_PTR || default_scnprintf == SCA_KSYM) {
 				btf_printed = trace__btf_scnprintf(trace, &arg, bf + printed,
 								   size - printed, val, field->type);
 				if (btf_printed) {
-- 
2.55.0

