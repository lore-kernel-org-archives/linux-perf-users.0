Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021120.outbound.protection.outlook.com [52.101.100.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C53F3B4E88;
	Mon,  3 Aug 2026 21:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785791335; cv=fail; b=mXYayaIOjS7YD2Z00yn5f6Is+cadObU51lxN7cLZURPMvKtSXjcjIBIoh++JQu/7Bm5lu9utHn5qzYfEo0JBYzoa5Ws+rfJoF92RpHFqU8Iel/cdP4JWRAAMEOR49tHfO7IUiQUd0ISmZm/hKNV9JpRCuEairsYeHlREsHADwwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785791335; c=relaxed/simple;
	bh=5R3sqInSmYoUMc9fIZ+THe/4h2816lpjh6IXGR8m/fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pV+RkJExrguM/jkw2ygH73ioSITV+og4emR0H1hF/Z+aRPqVoWeBdzTZw93mTOa80CcdaOCaMYfi6XNCGeqJtzeglFv9i0fnC3ugNlJsBkKNKNnh6ql79RaTfi0CxHo/HPQGUKSVXy8Xal8FdMTwkQ4RHU8CkHP7IIY7KKr0VsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com; spf=pass smtp.mailfrom=atomlin.com; arc=fail smtp.client-ip=52.101.100.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atomlin.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNQsYjZflKrMprpEJZnYO2u2hZks+Y0zQenInGrkPuPDRGAcPHKBCluLLt09/lboY5H4AsQzUJ4Q1BEQU06QpObhGAHRThkf6hMjFSeGnDXXxsi1wU3D/QdvIyfpSJv/hriMou4jg8nFTDpoAS0wqthZ3khAXbESQ7U+m/s6xDlVI7tgjz5IdCZSRPAnvA28UJ2YvLlgQ8dIHpCqmyyzBv1JeYVfuAJgqHuVYxYud9bLatLE9PP8CZJpL/GevlGqnL7KzF7SKJGjx/3LFANCwkTNjqdf/yySJWBWBKklPwo8yqUA+MiRidKW+SlL7z0p20gUlauulCyPTc/1LgyLsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001; h=From:Date:Subject:Message-ID:MIME-Version;
 bh=6BZIuRyKvIj45vPXLbWBE69IsK96lxPqtYPNxi5Om1g=;
 b=WbUf2QiPJuTAZaDHyJoLf5IGpuuk75JWzgTx+xVOb1IAIbh8we0QHDWe4CuMILhtUzLYt0Uj81RdcbdiXZEpg3UW+5Q+v6tBkP1a0DkwtdukwUYlLkXs81xwSrZKvmrShJryghUgySD4kQlUsWZDc0Bnc+/X4lsEAoe1fIMBWMC9N8W/0uES9TencuHzBTCCrb9ayOVYp0yKF8uZ8yZuopWqWc7hSv4L1fd6XytBGRWFVp2CbK29ObjYScFVFzBOtD5P/Fhc8FU/H48A+RKdCjr19o6e2+KmzCOf217SxuUPPx+wR2Pve3ybg828ohqRkk12l74AFbvOdANM7tUeug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=atomlin.com; dmarc=pass action=none header.from=atomlin.com;
 dkim=pass header.d=atomlin.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=atomlin.com;
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:183::5)
 by CW1P123MB8695.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:274::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 21:08:50 +0000
Received: from CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230]) by CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 ([fe80::cec4:77ab:262e:d230%4]) with mapi id 15.21.0270.017; Mon, 3 Aug 2026
 21:08:50 +0000
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
Subject: [PATCH 1/3] perf trace: Introduce kernel symbol beautifier for virtual addresses
Date: Mon,  3 Aug 2026 17:08:40 -0400
Message-ID: <20260803210842.245789-2-atomlin@atomlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260803210842.245789-1-atomlin@atomlin.com>
References: <20260803210842.245789-1-atomlin@atomlin.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0027.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::32) To CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:183::5)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP123MB6607:EE_|CW1P123MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: ac4079c2-667e-45c1-9113-08def1a36a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|23010399003|366016|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	53orEZ71V/Zfxt+16yzHwXlcjdnrsVqUF4JZkZs7YMj2GX+FFXapTqdKS5kljh1inWb25ePC4Bvtqen5V5Um61W2DH4+oszBTbWDY4svjyI5TGFsLreWjD5K6zMcDzVQBf4qmv2UYHZr0rMDYg9NIumvfWkFWFAkN3aMIngyq15BEPdM4PIExO/vA6rzLu/FIyPowwyAPKHJxebnznynzRHqgvEuPJhknlb1/cKSc3h2E43Ze7ZQDGeMA+0B2Z2PxK51aiA/U+iu/6uy9+ivM8+89AZPrUm/NPgqGk4kiu5uG4chPCwE7/aED+jemttdVQaEwNlLXMl4OZO7GVG5EIQNEFjlN9eNOwOSmM/3ZJXg/uyiR+uwaor5xIrq4Z8SqYtwSLBjNugMbCpktyAd8Rdpwh3IGKMj45RpCZmRY1Jb+HIrKwZzSM6Z+RMPc0QlInIoBcYOrRV4JE7gFXQSu2upgEPNo56SHEbmwpD9SCkZzA7GsD4jS2bJvMK15qc321fOMm25rw7EBtCYrLBG9p4pdixHta6/cObw2vSbUcy7080uBCFL91zHmHXybyEZHPZlVHK2BFYo8Aeqq+1QQME5TKkqA4fM+2l8P4iL8yyoNam5Gdxwy7DFGwJX4iPmXeqjFF0YrPF3ybzyTs7zBUJcPiEnKSXhfncEB7N3dyE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ec9hKLhY1Za/5qYTHZ1GCHx/jLzTQa2MLUD0NxxVJq9CDhNpUsZsdrnVEUZG?=
 =?us-ascii?Q?RuDo0DMVTbWDWtUUtqZWRRM7nBMEzQhTLg3GgVB/nnT6S0fWPQIMb+acZ1se?=
 =?us-ascii?Q?IVE0gd2GqIg8T7jDn3VlLw29uwwB4F7nklpD0hgSUIBghUEnN00i+64MccL5?=
 =?us-ascii?Q?pov/qDoSx1DtFQszL3ZlELXYC+j2DWloswq3RtmHTT6dX9xCegQDEjPfv8wQ?=
 =?us-ascii?Q?vN4yPvT2jpvqAi2s21ED8eQtooLoOarnMVjlHgjU2XCefXgThnWcX/DirnIp?=
 =?us-ascii?Q?8WRGZwmmgpm9YZN5t7Xy1si8WbFQ//U2Au3ceTTroqWVZ8mWyRbBunWVSYWA?=
 =?us-ascii?Q?1iPqrveumu10Ew6xViShZSPwc3b5JENY1fD9lyAC0jw+Nxw5RttZIYwBBc6K?=
 =?us-ascii?Q?ZUZbL215qmK6L7ZA2IGZMIE6EssKo5IR5NiAe8wvMjLsO5aMYOKp63TZ8gS+?=
 =?us-ascii?Q?2QULDsmAP7QNhJsbzfeshRzpCwvXbW1SZhVag4R4r+d+WAurCKg15Ygjoy7R?=
 =?us-ascii?Q?q1mPCZeZesSpbwrfFNuISv74KZzKeUCr9DaM0Uk47mzoa/UN95kh22CIVgzp?=
 =?us-ascii?Q?vrZyVsSUKdttk5KCnw9EM0vdtLn/BMz0QZJ1eO9HHH8bB/t/Do15T26NEviY?=
 =?us-ascii?Q?HoTiN1bO2QTIITemXMDYTz6yE/zPAFILAudmjAPFxALi/C1jkO4Htkx8go0N?=
 =?us-ascii?Q?wRlxmYU/1Ebi/gaY++Xe/L/CtobCu6SEU7Whl0kWHPOE5LY1s6tL3ukP7sPd?=
 =?us-ascii?Q?oRSdj89TyQX49fZEOiyiTkT/EVPUxzgiwgwFnjKIpwjxKHRvh9Bv0zfj6l5Y?=
 =?us-ascii?Q?WAh/JbBX6/Lp90EklTy+C2233WPQCsH+x0wAMtwpLmA/wQDaeN4rR71JY4Mp?=
 =?us-ascii?Q?3epZLU2+PJYBTNg2FcjVprzbtfxeDXDjN8fBnnh7mx8dwE4RtRK54EHQIIpr?=
 =?us-ascii?Q?wFrJnVtUkPxPyno/8M9fiEWq9XGAetgSi9N2a7DFI3Ew85D6N32x7T+vXveT?=
 =?us-ascii?Q?IE+ae+hGqk6CfENaiCJmAL4Zr06xOKxLvTkHRVnJtk9SRlUnXhOfTXFtbXwA?=
 =?us-ascii?Q?zWHq4HJX+/+jEYj8gx7A1/t6MyKn+3tCYiMX0PZHQNnLKK8XqdoHWCqpsuMU?=
 =?us-ascii?Q?uDuEBGiv6YexmalA08QCe+QomStSwypKA3a2A0AjoXTkS3E1eok15H0sqYJs?=
 =?us-ascii?Q?sI8RDG5qBdzuMJ3MVhmy6rqHd11MybPyNF15Mxd4Iq5/nP3/80bMy7OTuykB?=
 =?us-ascii?Q?c6W1zSiLodV3wqXkefFLobcGeBDopl1uvxJua51lodxFloA756lHY0k7oJFL?=
 =?us-ascii?Q?RjZ6BgNbKB5g7YTtSXpEF/ATVKqjf3ZhawiQifFDPFkSZThuF2pnMk3bFqIW?=
 =?us-ascii?Q?OTtH3RpsMhlB5zfi63YDE7iD9hpBkdJIcHy6+mDqKMsid2mF9AWL8VlifxEz?=
 =?us-ascii?Q?b6v6vlQ+8yGzl18xJ3a61tn6YcDApJ6YtJ5bXkH8FqoJ6MtWTmXjwlQU/Scs?=
 =?us-ascii?Q?eDq1DLV26sqIUpiqBA7Rw2vh9ObvKZTqLSAeIE59zFEXJKAlvyHdWrfSsHlR?=
 =?us-ascii?Q?EDBm+jtDYm5suSSl5pnNNOLRu7XS7pNlW3OB/7TMIIb5HCCCyzIz1xCNqsmF?=
 =?us-ascii?Q?n+ESyYA8ZK5mkEbGtq8kMomr4cZSP1wOixx7Ts7bpeBwlxSTbVUP04yOZb6K?=
 =?us-ascii?Q?XnXuMUixDrTzM+eJJ85qp69btwxfcMcxn4K5LqAsqohj9HDR9X3OmrCxO7+i?=
 =?us-ascii?Q?ZBdhkVRkWw=3D=3D?=
X-OriginatorOrg: atomlin.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac4079c2-667e-45c1-9113-08def1a36a6f
X-MS-Exchange-CrossTenant-AuthSource: CWLP123MB6607.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 21:08:50.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e6a32402-7d7b-4830-9a2b-76945bbbcb57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqcSgVbYs7pCFeTiVLcdwEfF8pTjsAzvprtOiTZ+B4XqomFeB/qwgx4q+BzBw4zyOy6RzRrOggbYZ6DLEdT7Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB8695

Currently, when 'perf trace' formats tracepoint payloads or system call
arguments containing raw kernel virtual addresses (e.g., a work item
function pointer 'work_func_t' in 'workqueue:workqueue_execute_start'),
it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
This impairs readability when tracing kernel execution flows.

Introduce a dedicated kernel symbol beautifier,
'syscall_arg__scnprintf_ksym' (i.e., SCA_KSYM), to resolve kernel
virtual addresses to human-readable symbol names and offsets
(e.g., 'flush_to_ldisc').

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
index 5a3e043b5b72..cbc5bdc0cc12 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -749,6 +749,30 @@ size_t syscall_arg__scnprintf_ptr(char *bf, size_t size, struct syscall_arg *arg
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

