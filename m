Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020087.outbound.protection.outlook.com [52.101.195.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383BF382388;
	Sat, 22 Aug 2026 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787434586; cv=fail; b=NLfvQARPAhYBaGYNp6fP4BWqcoRmvtX3RyTgz4skOhy1JsDxe7AcSyMWrMPVhr0AVpsGNU4BwT4OeOZhBqg9xZCbDB+/YseMQkn+bqhSCGLs7xRiucl22VGWC2M+FVTil/BzMqngZ18Za1kxWAj0yvirhUHfssjeVUb5+lPSf0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787434586; c=relaxed/simple;
	bh=/dT15EN5BtXqC/Kc+JIYw1DdFsMy6ur+RmiE+0tyCcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KXFi+wc7x3cNHcLc6sIZKG+MxyNpnzJtTHWVkhlNgWs/s6w1mEtfBodEslYAYJXMQJhoCTPkb2JWIrA4zW49UCqSQB7CMp8uKXOtd82rKKk4H9e+fvO+pyqoADkuWtkXkGGPfX4UQzoP5AGY55XNCO+pCeGFyQ8N29V1UVCCJWU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxpFNRqAH526Y4ToGY/14Gpjg1RbP5JiCFcNyL9Y8Nhwn4PLKeX23HjGKZKD2jXlCuxbZN3Z8snfwmU/jJNRKNW/LTH55VJvicyDdp9ugayya4oSgs4aW6RZc2K3p5rhgyeoGnZKfpCzzg3xiNjrsmlU3A8PlfihPssSSzIXz4ZvKBNF1hPVTF+PBQrpg8FDCZRWlaLXbhW0ZdD2P+Q3eKlJLrv8o6NNjzmpmRXuNbcSuuVvGnUJfqUs4UolUSphh+MGuGn89g4AJyfU2mqsvoGZaCX+moFv8MYs+IpC3I6ZL0jOXGuSL06I+HVDCrxEJZLjFY3O/FwQRtgq8UCj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=+LY40U8azJZOZVX5dkyDjbVu9cZgdNS5hWk4U+zDsEQ=;
 b=jytLPE2qwO6yT+4BGg2xtqLgt/vGTuJ4OyUhLTbB13yg5iErm2CB9s7LIr7qp9z1Fmo1vLUMtEwr7RBk8TF0R1PyaEsBNnqdOc0VNhpWqB4u1tfeQg2lgerrBqP1CDx1jod/j2vtlLn425lddyzqJYikEwK4tQMYraEh7I6fWhvs7SdBk9UxpRjoZlsvG28HKXQnbNJgzEc/Y0E+1Asu3Pe2ECBKSHeXwwo44rev5duQykBmog9IFV2dwubNg7aQ6OCfHCEf6DAmJcuu4jk6JeXfCTQ0ay1ejJw/d1pMflftyalBQw3BgfDEgnZdE6T5QKs93BmoR3TXxIG7YknGuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by LO3P123MB3193.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Sat, 22 Aug
 2026 21:36:19 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.010; Sat, 22 Aug 2026
 21:36:19 +0000
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
Subject: [PATCH perf-tools-next v5 1/4] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Sat, 22 Aug 2026 17:35:55 -0400
Message-ID: <20260822213558.704018-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822213558.704018-1-atomlin@atomlin.com>
References: <20260822213558.704018-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0429.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::20) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|LO3P123MB3193:EE_
X-MS-Office365-Filtering-Correlation-Id: c83c2c4d-2c1d-4ec8-1b27-08df00955c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hrWWgUnRPVabROlV12wMJOdFcKwrSMNwNOcO3UJ13/d7I6yTOKBONmXhhwwkMtt+HnwCAjp7yQ9p9MEOgrGGbPTWwXeHxF0QrMoz7y5QwsVK/gSKXozuHp+CgWYPOn0ecmHYJNi1s4/g8TipyqjYnAzKuZQ74GfCr1oI/v4bYMsEgOYdfqRIdH+DXbjR7JP8okehvB/2I/FyXhtx3cpADc8yXDeMGOVzxfj3q58VRsXHOjPmANEh+hQk6hGqsRAQ5Mz0wmG3CN7BTy2Jrg4ThFw7Wik7gZmSB129x+ktbwA3YNHegqMnmKsyM3A8JEyEkJEUmOnyC+UudDPeQcJNv0vMk47P4t0JSTyHixpninyk+SXBzr/t950h9DxNWGd7ylzle4hxSkcho0V0mQAmbSVsrISpMkoJUPN8sC0wYQaCmKk2uOvpycjLPjp4y95EjGPN0naBxLguywsNE1/1lhAY80rVRJ2bUjof+1+c8V7Q8jrxha8cF5b8/QJRZqp00yZGHJWplmHKoqYxTwN9cG0hQJKh/EWxY33PSiHDP/Jd3ADok9mqv3Qv1Y6I/9x/9reFO0uWcP48XY8lg4J1+g+iCsOD1n7/8ebnJgza6zOEKSiuhL2zkj5RPXJoLiH21UbpMNoqf98i9yr/v0WrlVgSvtK25XPBd8eKQN3sRfo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?as08O7bvpZGQ/A5bF6hhxmqNG8mMqr3Osy/rqMr72CicOGzwBpu+cMWn417g?=
 =?us-ascii?Q?AyRfPC8tRYsfAE/0A83mNHIEcUcxCP7ud0Yj64HT1poV46FM+pesilHiQtcF?=
 =?us-ascii?Q?KPXnY6L1FrGlgk+eFetYfBzSIW4+rUeN1MmXqKMztBnT2dl9WsceCV2FvQ+b?=
 =?us-ascii?Q?BymNtDmJCK7m2Lt9HpbP/iIs9ojHHWW5sgeHzzZR0Er6JUdYZVyqbBa3QNMx?=
 =?us-ascii?Q?C+a8qI81jqqW2AqHbhEiOqxFyu7S0CM3jOyFk1UYaOFP2K6JtUnEvMbhC2Ur?=
 =?us-ascii?Q?wBLz4I7KUt9YtgsAsYqI7F7QvURJeAsH4c/q0I5f0mdKli4v8ju3smKIx1Ty?=
 =?us-ascii?Q?/hYV8tKBvTuuta7QbwrDoqH4bJV/qGTacdKcUU3OLcFf3s/YvseYbrdW1xS0?=
 =?us-ascii?Q?vtcUw1ENR54cas9jVofULieZkFiBBAE07/OHeUk/4QVYDlWUJjRHgl8kl6/P?=
 =?us-ascii?Q?Ji48c7VL8M3CxgkywCj/q/o5Wgy94jjz3kpDIEg5jgVAVbyKBJ602TpoEe2d?=
 =?us-ascii?Q?Wd4Luf0pbD2mYQ9Z1/xGP+V+/i0TZHweXuWfRmRXeqSFMqBNMzIyin7FCGfd?=
 =?us-ascii?Q?mzgAHWcmWhHSkPPGrVBmUBhpS3sJORoETyKLY7hK+rrr9E2d81kjw+wGH164?=
 =?us-ascii?Q?ia48gIF1JQlT+DasIfABdOLThQ+da9VliccZSv+n3PhKGoHysffylfuzNHwQ?=
 =?us-ascii?Q?+MFSlOHQ6GQdsox1KG0S2JNxVqzvbK4FHyb5lE3gNydP2ihJLgg+t+verKQm?=
 =?us-ascii?Q?NnF/2OEYwRZgd/zCmT5s5DDre/5o+W7T38r3sjmI1Uvt9SJO65SSUsIgLg68?=
 =?us-ascii?Q?EIVli0NK73RDYjCCGVKNlgKhEW3AJxxDfYA4cg7Py73u6Ab7PN32fFWeDHvQ?=
 =?us-ascii?Q?LXe0zloPCvoXt0KA3aLRfHrCmZZVgH5A1othp7VtAmZgAofuaFI4wdIV+Tun?=
 =?us-ascii?Q?FK33PiY3zHHBLbVrylMB15WxQz5ZbM0NQbhbz9zTF0CHOvDTgicD7EJwELTv?=
 =?us-ascii?Q?arHq7CJCa5hJj6lrWilNSOO7z3s0147XmxmZOOv9klpjBsG2FvYCb43CEk56?=
 =?us-ascii?Q?TaDISQOM10Hjd3SqZzIp44xJXG/52bJsY5nGzlX4hAfFmWEGHZjPcwkTxv15?=
 =?us-ascii?Q?UXw06KcMwRnQLPX4vndKCm9bTskha0F8tusgFhnNWxjMMr/8TPvNBEBCnE8R?=
 =?us-ascii?Q?yUwjSLWS+gw0FpxLWE/XZoq6f/pk+4HH2ck8XP8B2BmN2zluRky8uszAuDlT?=
 =?us-ascii?Q?9J2aSH5XjHCVXIif5WCsudzpqaqSbbfTHosyt+JC+6LoZVvzG1cVgla4pqQE?=
 =?us-ascii?Q?Cv3yBMgP4vw0/sTG6GdhhanvU0+dFF9HVn6sBNafVV5dFmrc2sl939ohsdIL?=
 =?us-ascii?Q?2qEIZ+5U3KtTSVOlcBWeRpAPoZLqpe0jbt9lOj/W9baRX19807/RCpA2HEq1?=
 =?us-ascii?Q?LsHy32XERSIx0UO2EsxBEa65hh0LM6ftM2eF8uUMT0k65icrf5dTLAfcImKL?=
 =?us-ascii?Q?YDBsiLofoQsdHNaxg7WvCQiDFLBlwOpq8La8ikypiEgl0Xm/j1ONhu6NFA2m?=
 =?us-ascii?Q?B2YGMOntOLIqxcAC7FWfCCnKAtvLj+dzwr2aqc0nfpXhQCo8hazrKAxD9pwZ?=
 =?us-ascii?Q?9YGlcbW1YBigmZHVGKF/B+HaTrK91t4+8mmm5Xjbpu1X2JSEQZ9/HsmTTxxq?=
 =?us-ascii?Q?Mb36piR5yLaxJFv1KcBCn9m4b201HAiM4OP7mIGM8B1YRcsF?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c83c2c4d-2c1d-4ec8-1b27-08df00955c2f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2026 21:36:00.7793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cHI5LLjkwCTN/Q+YAOmdBgZMozP+soROl+AgpSJegRnMXat4veY0W6CfZl8Wx9O+60Wc1zAoyq8yolDUuzofYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P123MB3193

Currently, when 'perf trace' formats tracepoint payloads or system call
arguments containing raw kernel virtual addresses (e.g., a work item
function pointer work_func_t in workqueue:workqueue_execute_start),
it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
This impairs readability when tracing kernel execution flows.

Introduce a dedicated kernel symbol beautifier,
syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
virtual addresses to human-readable symbol names and offsets
(e.g., "flush_to_ldisc").

The beautifier looks up the virtual address in the machine kernel maps via
machine__find_kernel_symbol(). If a valid kernel symbol is found, the
symbol name and offset are printed without requiring --libtraceevent; if
the address is zero, "NULL" is rendered; otherwise, it gracefully falls
back to hexadecimal formatting.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c       | 29 +++++++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 32 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..003048946503 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -750,6 +750,35 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg
 	return syscall_arg__scnprintf_hex(bf, size, arg);
 }
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->val == 0)
+		return scnprintf(bf, size, "NULL");
+
+	if (arg->trace && arg->trace->host) {
+		struct map *map = NULL;
+		struct symbol *sym = machine__find_kernel_symbol(arg->trace->host,
+								 arg->val, &map);
+
+		if (sym) {
+			u64 start = map__unmap_ip(map, sym->start);
+			u64 offset = arg->val - start;
+			size_t printed;
+
+			if (offset == 0)
+				printed = scnprintf(bf, size, "%s", sym->name);
+			else
+				printed = scnprintf(bf, size, "%s+0x%" PRIx64,
+						    sym->name, offset);
+			map__put(map);
+			return printed;
+		}
+		map__put(map);
+	}
+
+	return syscall_arg__scnprintf_hex(bf, size, arg);
+}
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg)
 {
 	return scnprintf(bf, size, "%d", arg->val);
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 58a3206481ae..0f4801c61a5b 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -160,6 +160,9 @@ size_t syscall_arg__scnprintf_hex(char *bf, size_t size, struct syscall_arg *arg
 size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_PTR syscall_arg__scnprintf_ptr
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg);
+#define SCA_KSYM syscall_arg__scnprintf_ksym
+
 size_t syscall_arg__scnprintf_int(char *bf, size_t size, struct syscall_arg *arg);
 #define SCA_INT syscall_arg__scnprintf_int
 
-- 
2.55.0

