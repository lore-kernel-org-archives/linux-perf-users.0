Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2101.outbound.protection.outlook.com [40.92.89.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD5A154455;
	Sat,  1 Jun 2024 16:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261018; cv=fail; b=K7vYrO43gvGab1FfHjEHzjVjS1Gi3iNh5IDh2wrOLg9FNCvi/Bs+JrhIgWuMBXO5xlvNXnM+UdYijf9FDR1ClfRyPWpMAO8GsHuoC9IosvfzXsR7V95hZ3INzkZMbdBM3FF+Vvkv1Js8knUegnAC+CJaHpn40FY+9B/9ZPfoaZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261018; c=relaxed/simple;
	bh=gOtst8h9RuljVsy21oj8WcjbC8wfPg/lGHLpU3534lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zy43gxvq/mYQMN97/NRBypzuddrqhmo3OFzOkqI/9qNoxI64zHNosm67pGjgZ4RMATww3unX9ffz6TKcE+LLUvJ1A2/hERZdL9b4dmwuDFONrtXssC88df/NTNRQ6m4Y7E6sfna5TKnTJ5BCU3mrNLYP4sqHXwrqUqK2ia38Ah4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lg0W9sSd; arc=fail smtp.client-ip=40.92.89.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lg0W9sSd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NczhW1JIaHQQ1n9RydYpOEcf60530rnMMovH80nQyPGhz7jqadKiv7JSdf+wjRjZ888inz0k05XFW4UptK4yOrLDAbqNsu6Cxf+857uyKgTsS8QuBK1UK1LHvvzJKn2DkDVSBZ4WPgLDLi8S9AZ4SAXqJLMevoAUaPSBeV5jsr/ziNNVA9ei+xR2AMW2psioIeDLn+BZMbSvCNnvRG5pvw62zYRFROKglJzQ0eEujYlPXk4DkcbFL7h5zJdogzk+zXEQjRT7juGrhDrobMSYuQdF7AIzqJdmsB5P8XbAVRxjslM4mEv80srg2X2kb9aa9H29u/qwmehsc8f143aevQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o0LRofeL7sn2e6PoBCwIy2JEjQsAf4pdnyi3QAUeokU=;
 b=F0LJ+UyZcRdUtDVMy5PBzNpIB2j6ww2dRDCH0aM6PWG+/lkwUTDHq2WEZJJAEfzDSwOBbWIUORN6ulB8ruAgh2d9UsDn4j0PLzQ59/dmVoWrtmfxhqanpdTEaUax5av1bifGHSLak75I94dlJzjNGXVWvEmT9yo4Tttvr2fe18rQ6dbFy9ie8oBOYYtOg5qbWlMEkC3cdQxH7wdRNew7x67fbXXUqH3J/aLdui6Ejo5iavGVcDRy7a2xusgNv2HmDskbidA7BDo/yuFHqc3GPrT0h4UQ9qV7mfxNA0/l6Yphd1Zugqhx2jw/qAKKhr0hAHw/0Re2WTmFPZIdVQEQ4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o0LRofeL7sn2e6PoBCwIy2JEjQsAf4pdnyi3QAUeokU=;
 b=lg0W9sSdxc/Tq3VPh1+gpWNV5HWYKjl6Qyu4J1FosrmgcJxVN1CWK7Q1rvSzLY0gfEfn24pea5Fn+bC8QZGt+ac/ZE4TDf2bzd4y9ooA1KVHERIu3VkBt3+HlNvisTMqd8NsjPOhIXovICuIiVF9soKGOBzLL1tcQWNFPr8mmPtFRyda2suWevrry5z15E727VhtQG2XSHQRJcQad95q7yJN8NlOW1rmhrHXwDaxneDX3LJZTkIHn2YRp1SA9K5R5TeNVxBe1XFPzrQ5e2QpnFjzq8cYrDjKIoFJJPO2KjdRdXp0aM6NXzwr0/C/DAhUDZW/uyfekMiBFUkgoNFgSA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB9373.eurprd02.prod.outlook.com (2603:10a6:150:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sat, 1 Jun
 2024 16:56:51 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 16:56:51 +0000
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
Subject: [PATCH v4 3/3] perf/ring_buffer: Prefer struct_size over open coded arithmetic
Date: Sat,  1 Jun 2024 18:56:18 +0200
Message-ID:
 <AS8PR02MB7237DCB69448D5BE9E0615888BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240601165618.10020-1-erick.archer@outlook.com>
References: <20240601165618.10020-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Cqac6udP/mVsrAgL9nOq8iGXfFGVlXqx]
X-ClientProxiedBy: MA2P292CA0022.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::11)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240601165618.10020-4-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f81c36-2bec-4744-8d4d-08dc825bd52a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	npApg7Iy88JN6VNfIRSeDn9zCfGdPflyt+yleOZjxP/GqbVa/GZPXjgD9886TpRUa4Xj/T1ELIfaCTpOlLc7/iRGlpOOgdpGN+5mfDCC32AlRybvyTf2OQCR2cWcd91U+T0/iFY8eVl8BRptWtzeW/AFckfuzf/5RXvWet4JYTGAoDucFSfvA4/JvBN4HWrigyklBcAnbkBUSziKu/h6a/63hoa7VFg20hvJ3EGd6khWp9/NFlv60LvMfC2J0Kcxo3LPh1AqlLn4KAIqAQn++QUPE4XQWfBez2IY+hpZHqh8ULovV1ai5/t9JiHKO432CZZ3wgxRHcaF4bpiLoyd6nO4UDRwCDfZNtYoaELDxKbdLWfTZiqOIX1TbWrvFv8AF/rbAXnWwH5rezOH+541/lCJeJOmBDaQVDPF4QS3eruE6XBiRzg2WGkhLnmO1hlOEvviR2tySaGJQ+IuZumJS4ZW2Pv9YbJ3+s4oq9eJEPsXhTm7T/0oksYQOHcqo/hvue97XIy62zuFr/6jFexvbChm5cmCp9gKOwad4nbQ0HlpamBgvMXvltQaIRJ9JagPw6S4b9WCC7Q0rCbadzfyANb95/bJ0VriCzQeJMyjS7XA7q/3bTRExmwhJqPZgTqJfA7TXfbbIRIyd8yr36wYavzI4mt0OsxEDPfM/RPkaGvPjJJU4CMuk1w8TPhHoBaC/sI2fKomJjJxlkCx1DRuWw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IN8FiE/QItlcjl0cHBadWUe4RhZkfrAFf5Xeo/TVdNAaDme1b5VJvl0zXeUg?=
 =?us-ascii?Q?9KKOMO1TCcvB+n/Q36wx8fBGjNBkwwqxZLZr28riT1+t/74Zc6SOOmr/1I+y?=
 =?us-ascii?Q?zTtfOpzL/P7hrPsIC1UXBfnnPx0VlGYqfTu1u2uJuHkIP1VjHFRSn+vZwrBY?=
 =?us-ascii?Q?3hCjTgaDn8HpPBpydn2lUl/qAjXzja9iOETsrfIwoVKnVTZdtysdL1YjSQjf?=
 =?us-ascii?Q?5YK2nTaSL6BnvBQj6nwogZRlhC71iN3cfBqhC3IZ5zcCjmFlcxM3iNtxZhKi?=
 =?us-ascii?Q?ucd6TIMncCiYr7EYynDVXU670HH/DvsrKgZixWKrURRwn6tU8UP3JEKrOUJc?=
 =?us-ascii?Q?zFMyL2ujtaVOx36r5a0bq4fJOOCEJE2BQB6tYdxH/KxoDaCnojZK0xWBWlzh?=
 =?us-ascii?Q?ibIp6imrbDRyTcZdggdrp1aQmpSKUz5U6adJ+vf9FgYx+UX8bjAWSAA7uHjL?=
 =?us-ascii?Q?ukpzdbsmOoCttXfe12XG5feNoG/revvFbftsbH+pNQ57U4tat732wzzWTUJE?=
 =?us-ascii?Q?KefHCATtfGs54PWF9JbyJk8qa0qkd/5uepDaJgWsFk78JUsFNkfTLxQLOkCz?=
 =?us-ascii?Q?qXA2NRWU9Wlmh0YTQHdlKndJ/KchfWQ8Ev5dWIRGIEvOImvMbGr0/4CyZ5Bh?=
 =?us-ascii?Q?BZsnH0Esi2bOI3GpAMS+XtBZbEqTV26AA/Hg+fxrQEH42zpbDW4O96Q9rj0O?=
 =?us-ascii?Q?sFzNmQ2/nBOLunQAJszdPkEuE2Ad+cLGdkIVnlar0+cVONMV7QAnVKoE6B4k?=
 =?us-ascii?Q?dZpmx+dX2FekUtQ6eCxGisy9x9QIMygJ3JzbUQPT742tEN91h8/g0V6Ekz7I?=
 =?us-ascii?Q?ctDzmD5iKYLBjIiXs2IDOe1My8aJCcRItrJjY7cUr8EonZclQjTlHmftFlrx?=
 =?us-ascii?Q?U+zykOXtAk5TA2sgrJc6zhiEyDwVXNbGgJs/rrWRNGO5v1IG2XVZ1d6dcaGS?=
 =?us-ascii?Q?trbfVPsHEE9JEOq53wBJ54chit8jrKtedblu0QJYrIiwkTdbKy9CiMl7AaNQ?=
 =?us-ascii?Q?i04H4EisVQyRQcb19R860i62rZVK0oY4adQXqXOQu7Tl57hfmtb0w0IEVIGx?=
 =?us-ascii?Q?3vk5JrmiPPsG36r4C4/h6p1gJiZWEtT8uMXfszguUDAxKwKjOoKXQjC6LWgo?=
 =?us-ascii?Q?WegnNXeXYpzfPtBB8BcEYLW08A79PyxWdxMn4jSgJk7Lu6PkZWvs6yboLtin?=
 =?us-ascii?Q?SeHB96yrVJpyFRJ8m2qsldHa5qT5b/cpgLcd2w15MJyG4N/o04Ub7now7UVM?=
 =?us-ascii?Q?peiSizDiXA88zoQpMSV/?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f81c36-2bec-4744-8d4d-08dc825bd52a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 16:56:51.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9373

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

In one case, it is only necessary to move the "nr_pages" assignment
before the array-writing loop while in the other case the access to the
flex array needs to be moved inside the if branch and after the
"nr_pages" assignment.

This way, the code is more safer.

This code was detected with the help of Coccinelle, and audited and
modified manually.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 kernel/events/internal.h    |  2 +-
 kernel/events/ring_buffer.c | 15 ++++-----------
 2 files changed, 5 insertions(+), 12 deletions(-)

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
index 4013408ce012..d123fa2096cf 100644
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
@@ -916,15 +913,11 @@ void rb_free(struct perf_buffer *rb)
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
 
@@ -935,9 +928,9 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 		goto fail_all_buf;
 
 	rb->user_page = all_buf;
-	rb->data_pages[0] = all_buf + PAGE_SIZE;
 	if (nr_pages) {
 		rb->nr_pages = 1;
+		rb->data_pages[0] = all_buf + PAGE_SIZE;
 		rb->page_order = ilog2(nr_pages);
 	}
 
-- 
2.25.1

