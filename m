Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2101.outbound.protection.outlook.com [40.92.89.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF86154431;
	Sat,  1 Jun 2024 16:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261016; cv=fail; b=elloCiq3aLWQAFvskhdCySsIsWB+L1srJoBjsGe5WXXWj/hIpeM8D0d0ajW/YgiaoiQsNQpX/3nFn3ZieKJu/rCdtU0w9m4UjvgFC+fx4IAydTpIX7aHj1yLzeFnl3qIInuc0XWS8Hv4BpKT0aKABra4u43aRHpHYlxd4S8u18E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261016; c=relaxed/simple;
	bh=aO8MR/KDAQKBHp0hJAX551MaLlnFDSkAq10aMt5WLis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J5zgZ+YZz8ggBnJ7reDEK79PRVJQH5e5yeKQWp58tJPmgU9Wb6e+OZNo5p2LPvBJoNxRhBnWsZZuDfuJYu5EjdafnXTi3oGEe0KuJ1pIq6nz3g1jbLNGHPZ+1XYhkqb/rb8naL//oawQ85qtesquO6me4LS/rMkzLZlCjMSp3Tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pxQOthYf; arc=fail smtp.client-ip=40.92.89.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pxQOthYf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHNy60TU0WKxkmTjQiDJdlxYdSKb2o3Ga/nozbkVBLePjTWTg0SOTXYU5f5HdHZI3NkeJqj1VbA9n9beFGTFjuhRzpQLbj9VC2yhNAtF4rKCep8TeRW6K2/w5E0B1wkGNH+jF4EOa0OD+CMrBYUfhpZK1peJm5vh4LMVAxFmmrTxgg5ekD+1aIirqDTUisNJB8sgKv/zeRHOtOvz6tizPXZ54AkFJ/dl3iOgK91Sj05k2UoKtDocwBBhBZXGmFAqAgpXDuK6V5lb6lxfbvqAW3NBS6ecsq8zHewjiTfgmiRG9AjzkPYL48h+tXVnMdv6ZCp+7njUzipTQekg6nvtug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ooalRmn3AeJ2A0MZTXg18zbF4oZYzV7yZ46QzQOYVgc=;
 b=OH+CsEWzaTjmW9vWpxE73vBhks83Hm5NULsVOB1sk1e+xI7ckwIDvQ33xosBWZBQvH27emyRRp6FLlPd7zwf0tm4oRIuGTBNfEoATeP2cirRH8F77NtZ8AxeBRRYSOy8zND7DnzGh38z6eXEF0y7L11OyUjUufmu0e2axd50qcKTGW7MMUYroz5XtvawzIaxtcMxVnldLdnx/Za1/V+orPIb219DCu1daH6V0Z3N9uDJaMnrAA9by754ZH81IB07lg0AJtWXZaql73MUt/O/izPrTY62XQRmicb6LbXuSkBh581ru9PJCE55b3uWc5J4fEf4ocAPl/IUcp3nn9dP8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooalRmn3AeJ2A0MZTXg18zbF4oZYzV7yZ46QzQOYVgc=;
 b=pxQOthYfL75n10sD2lWAAn+xD3mmMl8l7ZABVSa3//NqYg2bo+ADka2oZ1zL+o4LTi9AJkT36B3TTHfasuiNGFP5+QEOBEX5evThbCJ3wIMs2JTzSUhK2h7jfoGQSAIzg2B382tKfeUXCVNhaGyt4BRqdg4YeP2Vb4MYEuQh5Z5tnucWnhYzbSM9lxiaDGHg/3FjpTX3i8jS2EuA7qD8vTtuny5AhWGbQIbkkjW0WdiyAOzKJPdKveNWEdP7TUD9qGNyT9rchtKaZU9txzwqLP4oMQrB98KxzOOwKJM6QkHgvoqIQvmAxhgf4Yr2g7T5g6ga0WMphXZsY31Ws2gajA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB9373.eurprd02.prod.outlook.com (2603:10a6:150:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sat, 1 Jun
 2024 16:56:49 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 16:56:49 +0000
From: Erick Archer <erick.archer@outlook.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthew Wilcox <mawilcox@microsoft.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 2/3] perf/x86/intel/uncore: Prefer struct_size over open coded arithmetic
Date: Sat,  1 Jun 2024 18:56:17 +0200
Message-ID:
 <AS8PR02MB72374D446ECC6BD0711A51DC8BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240601165618.10020-1-erick.archer@outlook.com>
References: <20240601165618.10020-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [ev/iZ1o+Q9rUBbIisNPY6HmHQ1mxNtmm]
X-ClientProxiedBy: MA2P292CA0022.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::11)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240601165618.10020-3-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: 06e3cf8f-f815-4923-d50d-08dc825bd450
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	YuYgWqoh+Seb/cgJb4cNATq3of1/0TqV2kAuRO9e3o6BgzAgNhC768tgSO2s99/OMr1B/SDcc2kdXyTd2/m9TYCSijShDJEKkTB9BYZbY7NO+R445Mi/IqiQl5gGLQ6IqNvVO9dCEc1P0To1YphL3APKGV9F40d4tv59+4SiaojVs35kGm7tJeJFGDd/XfQv7bKnxusJ8/6CFY8WcK1qM1Q2pPvGWSujAhz350n9dE8Pyu+4gp+qmSEqY+/1ii7i3VCX2RrNPh+365L0OFRF3v3kVHZiu7utjUpy+cR+YqrIUQAq7c37urxGvylx2wPO1/X8H1BEMSm4KEFcpQ3wmZFaEb+ZepsUuGDT3v96t1g0pzRcjvOkfag/iNQErwqpjSxpa/eSRHjQHeZsyd9486FwvLMFBQ3PXw9fm9HNXmPUygDZr7vAdwyLws/IHoOoH2AXHS7tgRpDR9CReN1iIVEP01DWmBXG6KRErZrTqHZn5V8BOe+VXgLIXoic5JQSck3Snl3rPrIEJmm4GKhfu8MLetBkvlzOjaF5tMMyEI3GB2YYeGwoK3wlARIWtcVKbo+n/v5tlEiUeHzIbQy1706HSUumvo8ulTCVbSrV5DpPaMXkbN87b3H+TFkfYJaVwzkFpPBIfIwx7unWhbJp9bbUThQZeYaBSVIgOHkoyGalpijHWBLnYa7NTRbOqwgnEsTWW494940cYnfn44Gi7w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hs9pUZrkFjYMwtxcE4frcGDFtBXbenxyXdce7NRIk4Ya1i0FxP8yQYO1bsdZ?=
 =?us-ascii?Q?2CUymScDNiXPeHmajRuF4MiZGJq4qnH0VeYFE8HgnjeQ2Hx6sWK8+MU/Ith4?=
 =?us-ascii?Q?fsaKmxZhEarDrVqlkIed3dETGGLt+ktHCqB6APBIFu0WVKFlq04fLOE1gqGB?=
 =?us-ascii?Q?L+O85FvPsmPUjDUrQQaH5cjI+JNTwBViBrz2BX6VNuewpzu3HZ1H/TpTj3Mr?=
 =?us-ascii?Q?i3UOAWY+t7VH9pAqWmFZUmWP/cV5i8CavktbOZt2oRJMAGDjYATqiszsriTF?=
 =?us-ascii?Q?LNOSWc/WQULE6LGfHkWHorjHClH2M40mA3XZajOkrgpALocMlyjBVqTCzYxm?=
 =?us-ascii?Q?Tmel+nLqEmAu6gKoL47bBcGFa5LxuVCFxPJGwzVv/qesDKsIqIvFMJNt+6/J?=
 =?us-ascii?Q?0Su5QOvzmnvRGiRhA0WjchWpPdvUtYtgZbAvvbd5Vv67sSsbelmZ++mFy8mz?=
 =?us-ascii?Q?jW1FtPOe7YHh/T9I8afSxDxbIxLK3SPU2XdjOrS6KMOLnz3oBtYrP3g/Ei75?=
 =?us-ascii?Q?sp9fYzccTFJi6AZ5mv/EvT+g0dk6z2dyZ5R8rtNm9ypimm5enIm9tROjl5gK?=
 =?us-ascii?Q?Xo0EqeElrbjRo7KUMSSUYrBrNhUp0fQOg3UQ0QT90Ew8bO0bZJrc5RQ3VIZN?=
 =?us-ascii?Q?cNasMj/JYP8exztEGc0l3epIO462VWyQS06yXc7QEgLirxCDT+ckOVO33Xmn?=
 =?us-ascii?Q?CphAQ8rDh3T8xxE0O/j245r3ojvtusOCW3s84oxKV1SdPzrYOr4Rg2r0xJq+?=
 =?us-ascii?Q?ThRla+d/8lX1nJL1yu9suR8oBHUYIq5UH66yqBzeC4qr1jUWSOgchpgjTicp?=
 =?us-ascii?Q?g+/QEwcjBwnj1gLlpnBos7RdPvA/OFBVYCYeFi0taQ8gszXyGBMDrjaaKm3j?=
 =?us-ascii?Q?Fwdh2c+C6E5u3yr4NtNdh1jLqS1Y/ksioNW9fZxe4T21psZE/Ux/hv1FwIJE?=
 =?us-ascii?Q?fzudJ/Q9fuGhxjQw7qGDPQvww27EJKnsL+XzsBfHjNP1fcDF9ZIsMzV59u6B?=
 =?us-ascii?Q?YhvWbRaMBgj2QV5PmusUIPyc98LSOE+uotTI1m/8uhwRG6w9Qsads/xjW+Nd?=
 =?us-ascii?Q?9W3ugevX+hn1RJBdPr8hP2bVTHzSjOKtGXwGmKZZQ7gbGdUMwj2LH5veLJCh?=
 =?us-ascii?Q?hi6tbcHJfm4qNuGDUyORhVDKGNlBY6mAxaPP2pRmu/8AZtYH6PYWo9IkrWaT?=
 =?us-ascii?Q?/H00Yok0lmPk2n595ex+B8f8lFB3tj2vCcsQDET3fiwUFyIeH5Pz9rp/EOX6?=
 =?us-ascii?Q?6XWGYJ6pMK7DJfHCHFeF?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e3cf8f-f815-4923-d50d-08dc825bd450
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 16:56:49.6741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9373

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "box" variable is a pointer to "struct intel_uncore_box" and
this structure ends in a flexible array:

struct intel_uncore_box {
	[...]
	struct intel_uncore_extra_reg shared_regs[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc_node() function.

This way, the code is more readable and safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 arch/x86/events/intel/uncore.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 419c517b8594..b0d518d752aa 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -350,12 +350,11 @@ static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,
 						 int node)
 {
-	int i, size, numshared = type->num_shared_regs ;
+	int i, numshared = type->num_shared_regs;
 	struct intel_uncore_box *box;
 
-	size = sizeof(*box) + numshared * sizeof(struct intel_uncore_extra_reg);
-
-	box = kzalloc_node(size, GFP_KERNEL, node);
+	box = kzalloc_node(struct_size(box, shared_regs, numshared), GFP_KERNEL,
+			   node);
 	if (!box)
 		return NULL;
 
-- 
2.25.1

