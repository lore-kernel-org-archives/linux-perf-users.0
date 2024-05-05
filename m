Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2048.outbound.protection.outlook.com [40.92.75.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DB4208CA;
	Sun,  5 May 2024 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714918576; cv=fail; b=nHYjKY/fbzUkm78gVw6xFvtfjvOFw1NG66bv/kL9F2ZYchPEn/Rgzv6+1XQStTmyO8G/gE7W+7T3nPZc12KEBEVjPiJtgqn8v0ekxEoDObZL2CvQm3MQe7O89HevGKJJPy13Wdb02tqDOk9zN0w7np5SGm+4pGcq5ZHpztyALxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714918576; c=relaxed/simple;
	bh=Rq03aMB0ZF1s4d8P71rdrOD9Hw1HRSrazVwdc6RiUxw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aISIw3OPrJ2d/4/d8vVLW2cBV5/RaeJA2ojPnWjZ01m3sKvkao0dLQVrP+Qy006K44EwaOiKLApoQz+q4D1OpifSHtiBnZc6p0e1sTHHddFbVjKzasi0R6vPDEcQ/X/bSR6KYlKOjt55MQKecyo68RjJ1HjAi7339dKk/av5lYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=mj17Zf9B; arc=fail smtp.client-ip=40.92.75.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="mj17Zf9B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HR2JZT4q0ECeomnA2L6rKLDDrzejLUlfZvLIoKHfdB6/udF0xp6w0d897Gp1hekLD7C9IJ+AAb9L0fAUNV3GtIymo5cYHEeQ06HbjCOsyAwYzqZtIWAQTtGF4U2hJFr8iLhMHHk9EaUikD+mTUV1OEmFv+jCUfEt1r3sfGHCqp5AiIdL6wZ6ek48okYF5uIEPNzEMFiEQGYCQuZfAR/AKvV1YfSFHFpr3XGm671RBm0Zym9xTh1/92XbsgoTpRhG8LsBwJ0IhMrGq1llA/6VSMmz8IEhjDgsOqU+ugRTEBRzBxzRjxZ0kUlxXPTunGM77yHsDFPTdBgEa57J/hztAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIi5Dj8newoAsX2e0SmyQqcOFSFVvNz56kOOQPl3FH0=;
 b=DSyDNXpUTBf2LpdAnF9PpCaiTk+d9xLgy2cd+s4v9TWBnMm8vak6833ZepKnMtO2rCTBJCA/3oYbW757TelllpbCyxMCpSUBjAyhnLQlvbkivoOLQAtv7nzXZ63NVBUqyvL63tle2ShzT4ZPf2ToRaEPEiM1Y0vXGCgMkdYu7B1VCjFBl7i+D/in2U+ScWeVqFijqXG4eZ0xtuO0OmpKc8Gcyi2p1RagBbDsI+bbV5QqzQNG0nXa+fWCNpW9YBonIPY104zwwoZeTn6MJorz55ieSa4NhsbwObVinFSs5VYFSsatsZh9EkT92vmJbfdK+Ykr/h851m9bhWtE2dnyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIi5Dj8newoAsX2e0SmyQqcOFSFVvNz56kOOQPl3FH0=;
 b=mj17Zf9BxrrFLKl1FlU5XqMrzN5vHN7Uh7gLFaDkKPz5smcDjHGT/vcp6X+Ii8XPM3DDWFiCWHt0/YdqEojWeVMRxuVJDU9bKr0aTIThHIQpl9iYUEYIiYyy+oDi2eM95S1n7pDbqLF3uM+5tGJNegqy1UprISq9BVy4S/q0ctlAWTWBCrrFBjf9G/duEWHedF/uMJfoOfB8PnrPQ3VYhK+1D+1UqCSVwDwAEOOHBJP8jIAaU/NSm5mWLHk11islv9DBH5aXoKv2W1GY2BkqOdwPX0DNoUGbrPR/tGdcoc9+3N2Dy/+wq6sb1nMVsgzn5eUyZQ9knRUTNzXI4+0b9Q==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by PAVPR02MB9746.eurprd02.prod.outlook.com (2603:10a6:102:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.39; Sun, 5 May
 2024 14:16:11 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.036; Sun, 5 May 2024
 14:16:11 +0000
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
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Erick Archer <erick.archer@outlook.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v2] perf/ring_buffer: Prefer struct_size over open coded arithmetic
Date: Sun,  5 May 2024 16:15:53 +0200
Message-ID:
 <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [8tXJnD8xcTHch++rYm9YlvPNNCIcNidI]
X-ClientProxiedBy: MA2P292CA0001.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::17) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240505141553.14446-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|PAVPR02MB9746:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0305b9-2309-4e11-0749-08dc6d0de9f6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|3412199016|440099019|1710799017;
X-Microsoft-Antispam-Message-Info:
	QUchWPzsDXYy99HgrdJOy77tj0E/vU+OwOVSrhcEUF4EtMDQ/W+02ReIrClDrMWcghIEXcDn8+EIh36os3QTt6XLkIcoklpTDmQBNFJrJJnBGHGez7zDxj8Srhzp4aA1hS1nexrxz+NyPq4lbOk59f0X3vmTO9CYPn1nkKyyPkxDE+8zKxOOcxlHBVh6lyF3r0VWy+Kl9XaR2NWM0hCFrWv+VREs8aldyzZjs3uJ1tebgQJgaZ4aqiTA0lJ1raTG19g6+v5egxoO0AeAmkYwfAHwYw6LmiSQNQlpX1EDrTQ/54qnb++V1/NsvRT/8oFgl3ThlhisbOG7LpjSmxz8WMKzcnpkJVOAG4BAu6JOPQ3n63yDiNe4x9lx+tSF6QmeXexTLdjmjtoA0J6ZauT8FMg9JZkGCwRTriJ5YY0wC3bn12VWkPoW28Xn9TvHFcOuO/Wwz4Qqk2zCvr2AP47wcAk4EWS0I3kPDulm0uB03hHOKrBWAYcYUaPcOHdZAucJuClpnhiVAnKVG4e1UxQNhZUSf3FA048zhAGcGhfWAu4q5xMnuv9ppf7frjRp3ESseLUF6694doaxicj/wDhsALGH11A+sEY/qC/LwgkPtSEsssfsSxxuneB45e7APjzC5/gkBLrspZPmZa3yG1koOF3EZLpbF+dYzyrjOFtMxRUuOyMGHPcVrakTtrhxnsEnNUg35wMb7NuAd5SF2YsR3w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fC6LUwK82FmpjXxq5BHpmS+TWW7yQiK8/AEMwUalQJAqVuF6zKtyYdu5NQt1?=
 =?us-ascii?Q?7qW5s3iCZNMRMEX0620Ad4sY9WnBaFLI6fGpINGG6x3fqGFdiNb3BSPrVKEh?=
 =?us-ascii?Q?qg5+FC6SUot30aap1HzgCHM9RlEGIFMi7MDR6C8PUnXFnGradfSH1+Th7Mg1?=
 =?us-ascii?Q?20X413bo6WRHNL+z6HC4+J6L3boiCC4yuRDFlVeLBqoWMflhlbljsp3FN9Ea?=
 =?us-ascii?Q?k8mSUFztUeUfK1vTAaYFCzyurN/CKA+2yBC3nDvCb8IQsvn7AfZwxuLHdMYP?=
 =?us-ascii?Q?sxffa8USWBjfOtvdsNtI9VO0ExJVFVflEHmDNAq46Se+vMFVmuU4E69ut+19?=
 =?us-ascii?Q?hF/JeadYnLyPvn/gDJYMtpjXh3E9VHUGCqXAM/yVEnJN4Ij5RNWRxAQL/HQj?=
 =?us-ascii?Q?DKBhnztg5at0iPvHDsG8XSqBJyQq4RdgdwGtUQqKvjxxJq7y8n7ozktf3n2Z?=
 =?us-ascii?Q?gh5RJQHIdFYDecX74Num/z+B5KNC0dujOpoKQzPnzyLvGazrqLeVpWb6zN7b?=
 =?us-ascii?Q?mVhZ/sO0Yre8LZAb9UMMTh2NOQ6Xt4vjQ8HFGbCgb9syErUJVaRjOIZqvf2l?=
 =?us-ascii?Q?rcMbNKsWcHlYm6mDD0eeS8zlRYJg7VjYoxqSqOt5xCCMT69NEJGltKRaGD+2?=
 =?us-ascii?Q?Lt7U9ELvcDj/EupuyMKPZla2BI2bG/eBwZRosXSO1CHLvYUt28wtVUw5Vk5c?=
 =?us-ascii?Q?cjH8MMO1c9UuK2Na+CoANpeIsynisDbKYegUBwkf009NC0bFdHdNApJ9Q//l?=
 =?us-ascii?Q?5xUvzrkUWEJqUAwOs02P/foozhufnLrZwh9wEDGhL+TsjvCakX9g7wOZx5GU?=
 =?us-ascii?Q?CoeakGXtcsSS6WqmiU/UCnetdgBtL8ceNMgCY2YHBWs20ZiUdr2M+l303dlp?=
 =?us-ascii?Q?LDhdYwuFEkwMYqJtAcZSmoRl4Z8gcMZL+TwGtKYyufs2tG/nnhwJK7qjXMqM?=
 =?us-ascii?Q?a7ogUzMQBbl8DHTaXIe0bFfJX9z5/O5MAZ3CM9pxaEDnUR4puNzb3ILzJ7lL?=
 =?us-ascii?Q?HuX9O1Tc5LfkEx4FVMnDic3H9yePwO0ur1m4SlzZOsl45ZsY2x2qHS+FdeiP?=
 =?us-ascii?Q?Y22nyk5Q4pQs0rmVqZabutVJGxAmA8KzDLf/1piCUUDvGHUQ2ZKwQ1xVDnNw?=
 =?us-ascii?Q?WXR0wbBPmvyAax6XHefE/4a/3V7Z0glVjaYkon0wtWzV4kS0xRKNeZY0kQv4?=
 =?us-ascii?Q?KhQP/JmzGJ/L25sMB1ydwtk0X8x0cljprDYvOCHq3Uf2M99QpMcCuTiA1vzZ?=
 =?us-ascii?Q?POezy8UtpO1I9tFupXEu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0305b9-2309-4e11-0749-08dc6d0de9f6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 14:16:11.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9746

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

As the "rb" variable is a pointer to "struct perf_buffer" and this
structure ends in a flexible array:

struct perf_buffer {
	[...]
	void	*data_pages[];
};

the preferred way in the kernel is to use the struct_size() helper to
do the arithmetic instead of the calculation "size + count * size" in
the kzalloc_node() functions.

In the "rb_alloc" function defined in the else branch of the macro

 #ifndef CONFIG_PERF_USE_VMALLOC

the count in the struct_size helper is the literal "1" since only one
pointer to void is allocated. Also, remove the "size" variable as it
is no longer needed.

At the same time, prepare for the coming implementation by GCC and Clang
of the __counted_by attribute. Flexible array members annotated with
__counted_by can have their accesses bounds-checked at run-time via
CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
strcpy/memcpy-family functions). In this case, it is important to note
that the logic needs a little refactoring to ensure that the "nr_pages"
member is initialized before the first access to the flex array.

In one case, it is only necessary to move the assignment before the
array-writing loop while in the other case the assignment needs to be
added.

This way, the code is more safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v2:
- Annotate "struct perf_buffer" with __counted_by() attribute (Kees Cook).
- Refactor the logic to gain __counted_by() coverage (Kees Cook).

Previous versions:
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com/

Hi Peter,

I know that you detest the struct_size() helper, however, as Kees
explained in v1, this change improves the robustness of the code.
Also, we will gain __counted_by() coverage.

I hope this patch can be applied this time.

Regards,
Erick
---
 kernel/events/internal.h    |  2 +-
 kernel/events/ring_buffer.c | 14 ++++----------
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index 5150d5f84c03..dc8d39b01adb 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -55,7 +55,7 @@ struct perf_buffer {
 	void				*aux_priv;
 
 	struct perf_event_mmap_page	*user_page;
-	void				*data_pages[];
+	void				*data_pages[] __counted_by(nr_pages);
 };
 
 extern void rb_free(struct perf_buffer *rb);
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index 4013408ce012..080537eff69f 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	unsigned long size;
 	int i, node;
 
-	size = sizeof(struct perf_buffer);
-	size += nr_pages * sizeof(void *);
-
+	size = struct_size(rb, data_pages, nr_pages);
 	if (order_base_2(size) > PAGE_SHIFT+MAX_PAGE_ORDER)
 		goto fail;
 
@@ -833,6 +831,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (!rb)
 		goto fail;
 
+	rb->nr_pages = nr_pages;
 	rb->user_page = perf_mmap_alloc_page(cpu);
 	if (!rb->user_page)
 		goto fail_user_page;
@@ -843,8 +842,6 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 			goto fail_data_pages;
 	}
 
-	rb->nr_pages = nr_pages;
-
 	ring_buffer_init(rb, watermark, flags);
 
 	return rb;
@@ -916,18 +913,15 @@ void rb_free(struct perf_buffer *rb)
 struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
 	struct perf_buffer *rb;
-	unsigned long size;
 	void *all_buf;
 	int node;
 
-	size = sizeof(struct perf_buffer);
-	size += sizeof(void *);
-
 	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
-	rb = kzalloc_node(size, GFP_KERNEL, node);
+	rb = kzalloc_node(struct_size(rb, data_pages, 1), GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
+	rb->nr_pages = nr_pages;
 	INIT_WORK(&rb->work, rb_free_work);
 
 	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
-- 
2.25.1

