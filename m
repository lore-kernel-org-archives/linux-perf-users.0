Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022129.outbound.protection.outlook.com [52.101.96.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BA036C0AB;
	Sat, 15 Aug 2026 23:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786837023; cv=fail; b=VJBCZ0Z2x72VNbjkyjZBMcoJfG/nGbJk7kxyomKO6GCndq2UZMF54PwFtZOhnMaoLyywLJ87w4Tj0PTHBqc+OOwMPaAgB3RmBcTvP3PWawpLmMzXuUajTqoxTuQxUOA+a/1Vl4zA0xqdWWqhO9gcIGN3a0GfxDkPnXO2af6d0wo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786837023; c=relaxed/simple;
	bh=V9q5cKNOt3eWuogL3KuWTidJpbZG/GH8apv1Khx970Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bzVcDGlo9Lp02YxsOfxEpT08F1+MEtTTLxGoMrg/FnKv+DVLNl85/Ndlk08eWUfpqNMRTh0PaU80QCMX53G2E4Gd+RQnLf0Bvp49nYViOVYokqI7tf3t+6/8AvDdkow+mB0/m1oHDRqnYPw5NS11lZT9bAI676rtuvIsBedCWYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.96.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpPwq15n7JTIUTWtaskUV93ZcPxEajTw+i/PYLKoQgCr/yKBTxsGhKXk/1BwwPj1VZs7tVFaJ46cQjW8fFYOabVLygOVDA5UIj+gKtNQT/W5O3Wn4IGmfnLMBaINLt5zr4Tye5BdCDZ4ZYYFax5PRydijQZoLd4BY08XlXWI5v/TL0BFXes2S0KQr4Rw8+dwgy32KPrm3YEjZCQaLGI0S5Xw99B6oIQ0latbcKN+Es45pvfAY7VDCZWyhqsc79yXejvsxtwcYRnDiUPux9UpFlYU12sS1/WBT6V4RasU8WPFKvbfqlAJ3OKBXvRO8PJi6t4fXlXjU7BcHMWQjVCOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=gbofgHhSjInxsUiAKVdiraVAnLJqiM0tNZi57hnR3s8=;
 b=lAoJqutlUF7QTC/0OwiBpjJR6UWsV/8+onSGGxRbW0fc1hhcwdz3w7l6Cuzvu/GAqNWPh6nARDYKuaWbwt1yyklRNsMRtQZBSr3w3SpjL/8YC0i7sKr0s/Wg+Qx7+V6ThUmdl2BOIdtC8LTnrvUWznb4DsJQ7U87tm1jCC/7TZ+YTi+USg14mHmd/DQ5Cz6SpyY5/qHJgJlMwDLnbK7ICh/1xvLSUvaiTn2SENL1qmsvat3hQ1fi6WXTorPcM/cDR8ibcyQ5xUKCXCaUvypW+Eow/BGvrmiACPUrhTcFcGMoyvRMuA7HBlGW2bFBDAv+8YG9BDvg57+hidf6Qygbow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CWXP123MB3254.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:33::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Sat, 15 Aug
 2026 23:36:58 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0315.016; Sat, 15 Aug 2026
 23:36:58 +0000
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
Subject: [PATCH perf-tools-next 1/3] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Sat, 15 Aug 2026 19:36:49 -0400
Message-ID: <20260815233651.527936-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260815233651.527936-1-atomlin@atomlin.com>
References: <20260815233651.527936-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN9PR03CA0682.namprd03.prod.outlook.com
 (2603:10b6:408:10e::27) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CWXP123MB3254:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de31886-c83b-4beb-7daf-08defb26196d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|7416014|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	oVaKPqVcp2KNS680scN1QrRA8XIoIe0tyv5yEO/CbVKNfxw1b5kl3t0cbFCr5IOnPK3MAP7A4Ua7d5a/fu4tzk5YWbIQVTAdWqqlghXZPUuSMWo8iz7lhjokhLubE5XB/9ROFWDf0LcMNbPoSGi3lINSBSnXGdi1j8X5fEdQAlljdSYHW1iUvZyKKsPw64NCAPZ8mD1ccnijPIZj5IwuVdTXiL1Y9R7aY5GEX5VGJpIJCAw1Lww9hV+Vl7c9u1zn+5tmrBK4pvqpv38r/Kciv070CjqGOAE+XLJkmBwSYAxxAhvKgmbek0nFexRKT33IeaXzFORmzeL+XIutwedl7H/CRY/KDvQ2I//M+EWam215lhiVqD5WMyeNEGdHSGFE5jQKdpdvolxQJf/TeUhAjKvQ+O8esvuS3D5y5LtwcVu77MdGWZS9u/k2KiMrT131x6rnx0lxotr3qnHLU2NcGpceeSuvlCfsK/eHxhyPvTk8j/lEBGJLHNfimfiCWLkOmmKg8aRj3zgveg0m8/othnb8/ze7E/pAZeLRX2n5UowaCmAe9L6+dzh4H6MG4v0RAPZG5T+YbHdtdz0Pz32ur9it0hceAytCKEE6S4h8QOt/YWlTzjdIQSl4yNPSXyCkXzF3vb4n8o+OqPdzCbl8lFy1RDrCiNUp0/AVtx+dQnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(7416014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kWi7w8cxiaT7qVt3gN/Awbim9vfZOIcP7TTkvkHYyyTBgpcEYrJNqh1vqWfm?=
 =?us-ascii?Q?E0PGp8cWTrscFzrNPt+DIUssIwSA3FyMv7hVMXfxRjdr1OMqWf/jDEvBTV2n?=
 =?us-ascii?Q?P08gQH5uoFNkjaiXa367GXejJZravO72jg6VhHklsjZLjd3CjVQBypqqrQFy?=
 =?us-ascii?Q?6+NeBoo5I6W4lIsH97g1XOgnLVJ1pcwdE0SchXtQo0tzKE0ont/CcYWFqwCh?=
 =?us-ascii?Q?il1zBkOy8INHAzCyf48CNUzsUT/2/ZfSEZHCeDZ31eDp4C+l/peFlpLvqxxB?=
 =?us-ascii?Q?tM627918aqIoKk9zoK7nh3bjcSiJOj0QWcP4bpGYfFRLBmWZE566ZJHzuMuF?=
 =?us-ascii?Q?nzYTOmnBRruyEdBAm0e2nM1DEtVeHk/nC+Wqp7nKeQ7NospI4xObdBCUkUbn?=
 =?us-ascii?Q?8U+sP3+eOGdfxEICePoT2ZbTA1UmtWH6Dj+TOkVlNI77oNq0206VTT40Jf8Q?=
 =?us-ascii?Q?Vt8HQ/btEFVKz+Cbl/2rNVrbcelLVQGAjh9wA9gd6R5eSFS8jFdidReKeXhk?=
 =?us-ascii?Q?BJNMbaYxG856s5U5+N5g5TYWtZ2rA9sPLbP3LA5/9xXC+s4G2Czxg8KEjjhv?=
 =?us-ascii?Q?yRQX/a3l4K+QDAhmOhWcP0zy61yu4IKbxu0vUuh8oCvLiWH9AYtUUSywNoFh?=
 =?us-ascii?Q?aZIsjQnRlmAa15NtOj3i1p2R4XIAjBx3kWEOBCIBWXddpGQXDaOtSsjBjHOk?=
 =?us-ascii?Q?U49o5nyFFMOuV9GSjiAvLHFR6QU214Xn46bhEuTKvHyB4jDSAMJ4F809BvVW?=
 =?us-ascii?Q?pbf7Ya9yXhEgk0jb5C6eIv1+nfwBd63U88JAW+MI5Jcq3Xb9JGMApX4Fs3l8?=
 =?us-ascii?Q?YQ+7YvxER2246B5cvy9DJnH4sTLwTUJNHAjNCZOU95YrooFp34ij+FAoQ158?=
 =?us-ascii?Q?CYWhJ023LtK2Cu398N31CG+rVJaZ4/IE85iBUdJMfukeHQbm1WlhtHuoGNUd?=
 =?us-ascii?Q?T3RF0zmM2KCfohl/26ZkEQzxJv8vCTnFF6aEOzi64QhYatOYYYC5+z+LaCJV?=
 =?us-ascii?Q?7Lt0AlRwj4d8VBr+iBXhXxRJxF3zrQ9iWMDKTS2t9kIXjnseLFV3zcdgEQ3a?=
 =?us-ascii?Q?jIkD6LdX0A4MywWkHE2hrRHaDwkBqmq6vMrs9fiqUrEYUGecFFdIjgQCbzL2?=
 =?us-ascii?Q?X18BSjjnWFM8zgzyVma04InbtU3P+wEncrm5JjZpLf2HYu0bjPKwyHa/64Ev?=
 =?us-ascii?Q?alqwksfUThxhO6GE2FlJ7h29jZFo72pOT87fzh97aEYu7cu27n97CLyOgBIK?=
 =?us-ascii?Q?QoGmHD2uzeG2+y7lJoJUgWmEWScgKaQLDjpcVv9YkuWWyUjmTP8dgPw5tEyz?=
 =?us-ascii?Q?dop13TOoOyGsmEeL8cVGLoOKm4saoKgOeTEAjZULkZxp9/6xsLXxr8xOm6FX?=
 =?us-ascii?Q?VWlF3QCdjGko+GFtXsvpxfq37nTrlpk1dNprp/kuE3qlHBRQQ4cJx1CUNUZ1?=
 =?us-ascii?Q?A4bVE/aaf/XUnoo9LbMBYDdSjof83HxDDQvPZugoNxsqWWf9FZGHnIo/48zm?=
 =?us-ascii?Q?h+Ar1qKpDw9h7XHb8veL3haNhclj6Cbv2pE3q89Y+FNKH5JWjIpLvlCbJLJx?=
 =?us-ascii?Q?R8QpWj8Z+tUaWdJ1g7EIHEffc1krBT8WFAmy1Oh7jA0yowLuzWbV9b3YX1Sr?=
 =?us-ascii?Q?37sP6cqxVtitt+N1XATz0UjVh4+rqgYf/UJ0Oqd0vuKVNSKlU6kBuCvroisE?=
 =?us-ascii?Q?Gb5vpQ4J5sr7triVBYuPsiizTZKD3cyQ1nogl7VSybFm41dbfzpFLP5iMDYI?=
 =?us-ascii?Q?rpivBTetsg=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de31886-c83b-4beb-7daf-08defb26196d
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2026 23:36:58.8399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k2PeJNqbrUfgmrSWIo6oL7mL6/fNnzfpVZzB9D0rFmch7hpiNEjhURGnTPVl7x+fHLQWwIdwtTp2eqnA6HVXRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3254

Currently, when perf trace formats tracepoint payloads or system call
arguments containing raw kernel virtual addresses (e.g., a work item
function pointer work_func_t in workqueue:workqueue_execute_start),
it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
This impairs readability when tracing kernel execution flows.

Introduce a dedicated kernel symbol beautifier,
syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
virtual addresses to human-readable symbol names and offsets
(e.g., flush_to_ldisc).

The beautifier looks up the virtual address in the machine kernel maps via
machine__find_kernel_symbol(). If a valid kernel symbol is found, the
symbol name and offset are printed without requiring --libtraceevent; if
the address is zero, "NULL" is rendered; otherwise, it gracefully falls
back to hexadecimal formatting.

Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
---
 tools/perf/builtin-trace.c       | 24 ++++++++++++++++++++++++
 tools/perf/trace/beauty/beauty.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index c3c7f1f85c53..102221b301a5 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -750,6 +750,30 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg
 	return syscall_arg__scnprintf_hex(bf, size, arg);
 }
 
+size_t syscall_arg__scnprintf_ksym(char *bf, size_t size, struct syscall_arg *arg)
+{
+	if (arg->val == 0)
+		return scnprintf(bf, size, "NULL");
+
+	if (arg->trace && arg->trace->host) {
+		struct map *map;
+		struct symbol *sym = machine__find_kernel_symbol(arg->trace->host,
+								 arg->val, &map);
+
+		if (sym) {
+			u64 start = map__unmap_ip(map, sym->start);
+			u64 offset = arg->val - start;
+
+			if (offset == 0)
+				return scnprintf(bf, size, "%s", sym->name);
+			return scnprintf(bf, size, "%s+0x%" PRIx64,
+					 sym->name, offset);
+		}
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

