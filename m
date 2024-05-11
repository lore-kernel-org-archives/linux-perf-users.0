Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02olkn2026.outbound.protection.outlook.com [40.92.48.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F22050A68;
	Sat, 11 May 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.48.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715439136; cv=fail; b=Vh2kcoqF9l119omyUsVFymOfMBtFlstfWHwhIW6JkYvkb4cLcGeeS5tO/DWKLxuk36fbThjGtUrvSpg/lSOtH2FcN0RBC3U6RkEASeJnzAYSRAC7b56uOhgZM8fWrSTy7+wK9qs+V0DpOcJ5lHyqpNlMt1A7+3l6uzAmTxr2lio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715439136; c=relaxed/simple;
	bh=SN3T4T0caFeW402zWhSmcjAf7NlBzSTTi3NW89rnW9s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=UBPqkuMew59/1CKKNXxXs+3nV3l3X4CqzMLieDxms7LM5ZxwP43K44yhn4NCsD3/+iw/yQccuS1oouSAkzrDteduotmvu+4n9oZCYOTqwC/8JK4yhMrDvIEVGH9//xCFCJNlBBEFD/XaeI6nzZ4klECnZAhsWmlbq1UzJPNckw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=J3GzT5vy; arc=fail smtp.client-ip=40.92.48.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="J3GzT5vy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBHAqDIPPNdkczuxHYSF8EgyRPn5ME0QfG4dfAOtgehOlydLJYJ9Q84FHtlxNwiXelqt5/gmDHS5jyxFCTUpFHnYjZJeesAwcjDFI0hzus3B6kYjahmGI4dyxPXy3dLpTOIbkoBZJGgtoCgIrU8kbVsry6Mh2waRR+dorU3CA8PbAf6pKozPG5ZL2GTJAIyipE7nQa35k88CLycl3zVkCpr+5dn0T6zs53pwL1aOSNgtDejrts4zJW3bWiKMyQZaxbvhCrgdNApU9XIDGNNVY9/6ykj3506Q1Y9CHqWvUDavko9vjTW+CAvmvHLPpjNCvd4+Eu0jaqbsDbZzxshfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrZpZ1fYFANKmQCWtkstnCxOn3bnHU21Do2y9XvfVvg=;
 b=AaA/Qw01AEQmhP2rc/VhUSlTZS1xzyHGCqVlmhl5jk/fzIVbus5kxXfD5JjOmc/qS2N1w51Xw7lEEljnYfB4Yp/RsNug36c9i1JMvqsg8J/TJ82Pwc0lQPmOW1VnNeTKflOK2ZBedHyuwRwSRBVTrC5OEYpPqjyQRuSHdmCj4ZeH81Aa71tY4w/RQpWZ76yRexC9jwJyMrfmv0MM1M3UjoQrmBmXBy75XozZ7VzymohPlKSwQi2eUIXDzIYObU4CZlngDT3Qgpaen5Bh8MLDBYCjwrldz2xAphmxfeTaekMjIiRuNEabdA/WLFRDkGCa9KwkzWxpyo6ys2QjzXotrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrZpZ1fYFANKmQCWtkstnCxOn3bnHU21Do2y9XvfVvg=;
 b=J3GzT5vyTZ1mU4I0/U/LKrAP9jCc+fiavPwURaXO8BKf9lXZB/Va+Uz2L2ZpciSyX5aQe8pCg2xuI2zUu1w3QPIOTeuvm7e83ru5J+ujsCHVd6zjj2qaVQXFIq2NQpTKBLVA67RTIX5htH2fnP6oDciRQR2LWlUQ+UiSP2IGop4uVGkarbmrVD+OTrF0Z/4TGjQTTKYK3AFF6h054iSkKh4vFGozZeTT8xF2l9Nvh3g7YXq7IE5028R/bJgrRtqhTozOlxrJNzq3Nk4/uGlbsVKtCOBVK+pHJyNQe8gQpeELb4pd4RFM3ZfBxSnRRKIf89JG92DXcBahnTRzewhyfQ==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AS2PR02MB9216.eurprd02.prod.outlook.com (2603:10a6:20b:5fc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sat, 11 May
 2024 14:52:11 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 14:52:11 +0000
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	x86@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] perf/x86/amd/uncore: Add flex array to struct amd_uncore_ctx
Date: Sat, 11 May 2024 16:51:54 +0200
Message-ID:
 <AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [oNeQ0oIf+esMuvLu/3LnB09rFacA5a27]
X-ClientProxiedBy: MA3P292CA0003.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::20) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240511145154.17823-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AS2PR02MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: 71c90ae3-c638-4b41-5cdf-08dc71c9f011
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	4hk6hCO50O4/jGMzNHARC8WyD1PkFp8bHGRpzKpdp+7Cpc9OataewU8WIQzkqobGJhxewExKTSD40ldzxAWcr62jOzX1KVqKdN+2EdAMFRCu9MKtoqqVjSjrb2sEy1UgCxe5w7woupmPfUPqPHAbPpCV9xoyPC54YjPdfySyFmTuQQfsEI0VXBh33y9oRFP7CmiTwoMIiRgLI2RULkidMKFQUxuNUlc3wVNgsygDW1KDCIPYVLJ3kRUzWKkdndECZInEHncjWfPanictBDLR9CMutYeieHUeDwOJwfXvDAz/6Wkh+Rr1z3E16OcSlGSuTWzPUCFfBry5hAgFTsowGbXaN+BUIXxoGCEKUibyEugLsS2Qpqz6+gB4MmZLgBJFWt3oQsPTMGlMoaYiCsmBRhAzD9qjHHyuaN0kHKHwyRW0/RtC+IzkBfEletYiP+AppvWpsodRfJkRYK3DlUSWYpuxaNKCMdJtNpKVYa9N8Zyuum8spXxxOVH45389LsIrnqJPWQ50bqjlyDKGhRBG0SvuXe6u6E3YtBTns5cikOdYi+ue/KLn9BqZHHNEVJIqHIFbL+dbrupNW4q+tEmy+2Cj2FKf/yxt/cnxdV6LLWEHO/KkKHWZHyn8hjZ+V18nkMS03SRee52EC0oOadk3n/hd4yTkvXIO7xrN26X0aHNbyCsuGG27rSUN6P/ysspXY8kxToht5sgBMIoM/kDdsw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Nofz3u7urAOOypXDmlO1T/q//eBnbFvHZeFiZVkxXdd/B5Jiw6vMKhWPjxhN?=
 =?us-ascii?Q?gNmVaLrSHXZJBDL0ohPDgj99jA/Ka3aps17xPsv4E6sD5vUoKvzZU+7RK/DQ?=
 =?us-ascii?Q?uXwUEr+Ly6cVBF6Z34MKtzUmr9PBwXanT3ZVmkrA3MY31eRugiMbIY//QYyb?=
 =?us-ascii?Q?b3UQIKga7OSwSnofuwHoNpCoO1dfxdh6hGYzM5zV5mV/k39eXN48EiOlgi/d?=
 =?us-ascii?Q?BKPw8DAzt7NVnj/Vcp2dItLDF48CvSW7wEjlrgo3zaZm5IJQ5NPoMgUkn32p?=
 =?us-ascii?Q?LjFDSitcGmXVRaPEykF0gAi9S0fVr3tHZZOWHYWO9HwFXd/GZuS5FghOodZz?=
 =?us-ascii?Q?L4UzQHUmD9ZXV1e4Pgengd6F8uZqJL69+BAu4sjp/VHFTHxRzV8cnUkdLmu0?=
 =?us-ascii?Q?IB9YjIsP7JjWCezsRPFk0DCfLWow0+LS8U6bZez8zd3hZmn2u334HclVvTeu?=
 =?us-ascii?Q?AQE1+lmJS0DjkY4RYgAF11dg35FFGD+TDkYt2qA+ixsGQ+MwVSJ+XNyp2sg8?=
 =?us-ascii?Q?WL4qa/aYsghiHpP+84f4tKklZXnmX//f28jM2kiKlWdvOZxSgRv14pPFiAvR?=
 =?us-ascii?Q?P+qjVsUbPTVhxLIKQVVKsG3tDbkrDjf7tkxfc+b9gcM36EeKzmyqMDtwkU4r?=
 =?us-ascii?Q?V7hPYnyLPNXDSnjil15R1aECkhcogqXrtlXeRTLrCqfkuiuq3wPaUveOdNXv?=
 =?us-ascii?Q?Ci8zinXnSdtjNwq9u2igViCbIgY6O7wxMSLhK/8jZmL1MJ7jkXOl3yEHl7KE?=
 =?us-ascii?Q?6DD3r4cQA6/YTff2kblL2mX8KQzIXb5HsVv6HPdEQHmnyKeGO0IZZq5m/lnh?=
 =?us-ascii?Q?ubhMRNUH7V0sy6zUGS4O41Qw7KfpTyaQz82IjhXaHSy+MlgzYF0avvQVqYzM?=
 =?us-ascii?Q?1ApMb6qCrvQG1MA7L+HiPS4IavDyV4vbb8fKFTxv3Apx0P7P6JBHrByXYzT3?=
 =?us-ascii?Q?tj8zBZfSAZe/EpgaIzsAfqXMLGKVhPnD1jmO6p49LZ0GYp6H/ryfW/vbYxE4?=
 =?us-ascii?Q?msmIhrWbPanxw91FMNzdLGejxHAJJvQChrJd3Itr62MRVzjdJEgVuzpuHsVz?=
 =?us-ascii?Q?EWDnvvfooAyYq8ZyIN4oGQ7/wlA6HduFhBiEbGTHAfcuhPFuJQ//LkvmNU12?=
 =?us-ascii?Q?Aby8hCpyzKHHJB/yJXC3dqcb2laMwdpb10HB2W1uXNGDU5+CHsMNe1dYFz4r?=
 =?us-ascii?Q?TE6qTbrhx7mmTKzRZBkEaDLI3wlizwrH032z9+J9D0FRUC/KnjSPEM7zqbuV?=
 =?us-ascii?Q?/ivnX7RL3YwtpVu5NuYd?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71c90ae3-c638-4b41-5cdf-08dc71c9f011
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 14:52:11.2434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9216

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

The "struct amd_uncore_ctx" can be refactored to use a flex array for
the "events" member. This way, the allocation/freeing of the memory can
be simplified.

Specifically, as the "curr" variable is a pointer to the amd_uncore_ctx
structure and it now ends up in a flexible array:

struct amd_uncore_ctx {
        [...]
        struct perf_event *events[];
};

the two-step allocation can be simplifief by using just one kzalloc_node
function and the struct_size() helper to do the arithmetic calculation
for the memory to be allocated.

This way, the code is more readable and safer.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Hi,

This patch can be considered v4 of this other one [1]. However, since
the patch has completely changed due to the addition of the flex array,
I have decided to make a new series and remove the "Reviewed-by:" tag
by Gustavo A. R. Silva and Kees cook.

[1] https://lore.kernel.org/linux-hardening/PAXPR02MB7248F46DEFA47E79677481B18B152@PAXPR02MB7248.eurprd02.prod.outlook.com/

Thanks,
Erick
---
 arch/x86/events/amd/uncore.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4ccb8fa483e6..86755d16a3b2 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -37,8 +37,8 @@ static int pmu_version;
 struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
-	struct perf_event **events;
 	struct hlist_node node;
+	struct perf_event *events[];
 };
 
 struct amd_uncore_pmu {
@@ -426,10 +426,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
 		if (cpu == ctx->cpu)
 			cpumask_clear_cpu(cpu, &pmu->active_mask);
 
-		if (!--ctx->refcnt) {
-			kfree(ctx->events);
+		if (!--ctx->refcnt)
 			kfree(ctx);
-		}
 
 		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
 	}
@@ -474,19 +472,13 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 		/* Allocate context if sibling does not exist */
 		if (!curr) {
 			node = cpu_to_node(cpu);
-			curr = kzalloc_node(sizeof(*curr), GFP_KERNEL, node);
+			curr = kzalloc_node(struct_size(curr, events,
+							pmu->num_counters),
+					    GFP_KERNEL, node);
 			if (!curr)
 				goto fail;
 
 			curr->cpu = cpu;
-			curr->events = kzalloc_node(sizeof(*curr->events) *
-						    pmu->num_counters,
-						    GFP_KERNEL, node);
-			if (!curr->events) {
-				kfree(curr);
-				goto fail;
-			}
-
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}
 
-- 
2.25.1

