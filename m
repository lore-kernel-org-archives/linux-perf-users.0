Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020115.outbound.protection.outlook.com [52.101.195.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DC7081E;
	Mon, 24 Aug 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787578302; cv=fail; b=QWCEiw9C4Thv5OKBBtLiFCQUNZ0+m8G4m3mL/KwZJb8r0IzcHZ4ntpCMZesJDOtMhtEIq+FgwKit8y3CpOkk9lawPU18HFUQlvifp9QyDs8VJH8DwGIfETd1C9QWf6Zh+4TtPYQ35SWN+ro1fVmEWPQtmwLZGd8NUwj+huTKtec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787578302; c=relaxed/simple;
	bh=QI9xbZAKrWDfa2xA7jqTXB5Gthz028Vr71Y+Gs7xAJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AzCpJ+dvJ2YL1if8Q0VaUl24sCUtZ1C3sNuGmUHRtdw6K+kC0XLhKxEHOTD05Is12JzEIj4jaPay/GUkqG7zkyvR3j9ddSiYQx+VGSp7AlPE9MtNNsIpS3xLFRSE56Ee/OnGdquHtT+4tC0mR1S1+I02J9xiQO6TfM0831R/qoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.195.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ua09bbTdBNfaU8cHHdH7yQnf+dTosg/XmSzfkM/XHG3gQMREj0AjqZulJu+aLICNY8bXZgXXp8fNcFrOcIM+bN1Ry1UpAUV0JT4VkhgO43SeNPAq0DcT+clMXAc/m7ktDKrDMC5Kba3o5wbaa+fOr//TMECVp/UexaB9qGEfeSzVm9/S4yGcyyF7yZiXU2Nmd6pa/HslxLRGMOXM9NdNTQa/3gtRL5UAUVF55auXM578N2ALiNLHE0mxreF3A37kDUUHGq+39TW7LL0Wv/xxc15J7NMVwFQwsfc/23RDeUTJeWa3IvKCDXIaZMyaScfWn2odIxDRbeHcZqmjckLymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=m+MqZmM1QMRaxVlfZ5F22MuZJi94epzCAceQi+fKUBc=;
 b=Dt0XNneWfysHIq2yCDPNEXM+yzh/vnViLPIaUlJibsk34z6agxr7rthLcXXZ0/SM7za4QMr4Lvt2bdz4IhhYDeGf4APxOkqIOQSJ3maVOwl/1UUYmyDo6FlipHjYKNkgMD9j4zU+2rAhH8nel5yRJzfR6gXPnAXeuQ7LSJa3AjCLwRCYMFPgR/ZJAIjESRPfuTNhBSAmUeSUccQSnaNgTvrsHQmigbJ2rS7kmAgFD9L7t2gvTdU4r82STTeXrJq9PQw4jcti25eppQOpoFbmDH+hhyX0XVaPr31x96/v9GdrSK92LylIC589wJNrBixXg90BGrZdXWM1hldkg6o35A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8950.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:271::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 13:31:27 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 13:31:27 +0000
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
Subject: [PATCH perf-tools-next v6 2/5] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Mon, 24 Aug 2026 09:31:19 -0400
Message-ID: <20260824133122.751733-3-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824133122.751733-1-atomlin@atomlin.com>
References: <20260824133122.751733-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0260.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37c::11) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: abb5fc98-578b-4e55-0f21-08df01e3ffa9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|7416014|376014|56012099006|10067099003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	oSmT+icKwZonM3q3HdSM1cDwssqPsSzbbcCfHwjUr+l4gBZcjy3rEtST5hBV/fXIorCWmcC1kfhkBHW/TV2/AnhGGxL9VSwB4BBVVfxKXr7Wx8IHKKzmATcMYOjiprOxPiFVQUGZ4uVfWO39lEnR+/e9XX442OqjbA++N2gEhey/WdK2GON5ODf4LQ96S0I9p7FiReulJJissTRKAg0QnzzrZx0ooJPdCp7gCVRyodgufG1NzwzW3TngXorCAaExaU/MlvXHqB6deyu5A7P/UOynsYES5uibxDNnxSDd7yncDzTTyYTDI2yw2pDhy2UxqliLIEYr2Pb/bqzGv1bWsQmXy1cDQ3sxSjSHzayUbHd43XTRlkPZxXPUfkgNJb7QYZ52tYFZeukkmuWgHua5lD/uYuatuxG1mkgj1+6Akqb8FpS9a1oewZSojef10g1CqM12LaUIz9GBBggakqRFo2imSkX31+AxQIhOWjfp+By+N6QUBAw2bJXLVffMgAkThDtuSj0xob3Q97NJhWXiKluvZNsaTIF8pa0Fi4V4bjHqyM2/JFqtLNHeER0G2hA5jWMJlGRtZ+Kx+cK878u/yGlfDkpCQQBBPFO89fB3wxw0zpnRDrC09yWtpS7WtOFn59orpAHmdGUd20C/1TJ/zATNYCjy8YUygV/rndNI/rc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(56012099006)(10067099003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QYf++A9sh99DD03jdodgpTbrVw23Xs3hWgH/Eg218RvGuY966vdvqzRVuRU6?=
 =?us-ascii?Q?OPWeY07tmUkRAv1NcBNNCAbbhCzVjn9UzWE9uFvOfj+LiSKLAp/22DItj4aK?=
 =?us-ascii?Q?0QvEcAIWJK+gxBiGSQMqiU9NEEEJb0bPvnVd8RcDDrIqKPM7HoK6LRsa2Dlv?=
 =?us-ascii?Q?PzSIUHKZDPmoqdCMIwL4+UwRRH7+cMwBARLhutLGTqa0k/EfSMX47SXOeuhz?=
 =?us-ascii?Q?FUZs5wR/tFUlzTyNYrtwtoHNF6NZmJ0iDI9uYTsmLzfK9mmsEvlR6LKHHZhS?=
 =?us-ascii?Q?9gCsy7KuWW02UGGShLoTO+PQC1q6AjxIxf8hEbGadyfDjQqG2FiSFzvp5ejd?=
 =?us-ascii?Q?5QS9wThvq+AYTVEkrJXkhcuG7/HO+m4x02gomPnjRFICZPmXcnz0RF+8wUa8?=
 =?us-ascii?Q?aV3OcPl2ptpmKwViMpP6qLlDuuVxFrEGYt/d8ByeivNNQ8tSlbEJEhc1R8GP?=
 =?us-ascii?Q?LdjvQWz37gCRhHE0Bnu7l9aFt7oyeg6S/5esgq/G+FYdV6ufkAaUvesfJmpp?=
 =?us-ascii?Q?gYIhxFC974ziMmJ77T+gO3dBWuCMX5Zh6WbgMbkNhs8RxEdPTzumduD/bUUx?=
 =?us-ascii?Q?AYzKFwAAyF285y5m8AvJnP+kq2iVujlqrjNsR/p7hBsD1vGC/ZJNriOjqgrP?=
 =?us-ascii?Q?GzgRbDKinlQb66mqBGsUsycs4xYrAHUCMx2I89KdHN6RN9Zh4bZknWx067Tp?=
 =?us-ascii?Q?BKWz65SCgZCOgZCOukidVY5/xjMEym5WpThlroKosmCMcbnN/VORJvqoofKg?=
 =?us-ascii?Q?H8nj1IeU3jnFbW2HSiVc/ZbELjvgHgJr8iM2FPTbkLFLlLB/x/TlNoVrPTX9?=
 =?us-ascii?Q?bptTjMClUKVNc5WYgm1EEtYh491tS5EHRnURwSFGnOsuDl2TlqcnM/QU7XHu?=
 =?us-ascii?Q?fkDS12ME22Hl4nnQ24+9OYL/UOi9ZPvTjJiKd019qEcvHEMESP5dvICwjTfM?=
 =?us-ascii?Q?wHH/Ymbex9RLCemDlDz0nfBKpQAi3EaZt35tG2ZzIGjoXQeAKOTVJ7muvMdX?=
 =?us-ascii?Q?/Edk0zoKF68J7ZvZ5ZkT8PjrNIOUaFJku/p9TKGOwrtTx3Q8gUhixnTUvzM5?=
 =?us-ascii?Q?IjLA38D3zL+ED9TU4BcFepNtxpzfRNhfIHHIUeWcmrk2dK2O3zQz1nFSSl5T?=
 =?us-ascii?Q?P/HPACFi4BFUKn5U34+4w2GGq7CQGGdsUEDfAq0IAgCp9Mhy9NgG7n7UGSWn?=
 =?us-ascii?Q?tnZIq6b22sojwTUdJ+8z0pT0NtRes5VLCixtOXK1pYffKbcSOMbEmxqDcXiw?=
 =?us-ascii?Q?WusvJFa7ZnMrIFjskDH054Fkiscx8dJ+IAGp/CE5g2BN5PeRmx5+vbplkmpu?=
 =?us-ascii?Q?QxzI7qW8b67UY7Xih1HzUSpQVtq/X1IS/IZmFX7mn6cYeXBjfXnstqA8mX7g?=
 =?us-ascii?Q?u/fhAC/BGT8NZPD2hIGbpPvlxW39sTjxENpQolisC75CE8c2PRnRCZhDlzOH?=
 =?us-ascii?Q?fQJyBA4nGuV3y79Xk5vzpfPl3T+mWkxAWXUdXu+hYRYSrrH4PvwdSweF9N1h?=
 =?us-ascii?Q?uqDLrawoTeqN5hCki6K8ezCQ27B7rU0DyZEACPmQuEkfXnU0mM7ewkAQhCn3?=
 =?us-ascii?Q?gKSM2Cnsb6jC7qf0EuzsWOGEdDfe0UM9c40tTeNPxV0eaw5p0v9AxFzrQ+JM?=
 =?us-ascii?Q?xDkt15nkmy3AGc/r4KbvvTo+u06qQMApAoKqSqKd8g93wtKCJxR4oyNjeHye?=
 =?us-ascii?Q?qNCKY1l1NWWL2NfDKH2Q+RdTp5Ra1ro7jICBwLIysmOA2HxI?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abb5fc98-578b-4e55-0f21-08df01e3ffa9
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 13:31:27.0034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YAyqSGtEmQyDw8QkufeIG5OBZEjbjuyD4+6mTTURHNBYQoz07qnYTrWvXjrLA196FlwXKrIq/TeIPGqMx/2LFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8950

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
index 1bc39f674f11..effb00117bff 100644
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

