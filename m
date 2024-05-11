Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2066.outbound.protection.outlook.com [40.92.75.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7BBC50A68;
	Sat, 11 May 2024 13:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.75.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715433930; cv=fail; b=D2Rg5ZTjvxkOvJr4kLqdDIFAS9hi7GauteE6ReTXJKNi9gk/LII+30EhIygAy7238xWytGuRuznSc9s7G9TDxgEvCozdSI/QR/gCEulzSy8DvO0qOoKGcYOG8tEY5BAibYgYC4KxqY8tfemY8n+/urMpP2Kh9L0qKa37S1DmTYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715433930; c=relaxed/simple;
	bh=4Rd7+VPUPRwSW59CQpS5OPxA5kQNQwIL7F0lI2iMF8k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=N5BJN5WSF6XKiuFNsT127tpp4Wsly+KUD2d+YAAuepd44ApWY/ddLt50omr4ZkBP95fZ9uqO5rHiHJMdNXHHDIuSveIGGd10550KeGEYZOwZfUi5IKN36UJ9O00maBuE3v4CjVbrTptloXZ1dA5SjvRRmxC1wbSBkD0Zgt2OeAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=sZLq5Qum; arc=fail smtp.client-ip=40.92.75.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="sZLq5Qum"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SvZFAVviFeuuE6vc/amYPPQkhM2cxUJPK6teoeQFm1YhS1WpLh27u4VEB5+nW3WyrG2Bi8T1Ks1L9y2sdHMMyvhIL8F2pTEFJRJtugIAEcHWtcADllyB4+Terqdrir8GaYNEqU0NO0RxFttS0TUkw4xRFTw9Upt4LwW0/cMBoyuFv2bgua8BJA+6faigVJPzrspcxdYgC+J3FpLtuztefHtS3hkFQ11iwEgi76EuondOlGQqfdlyrHaUlwluMI/6H6hMfS45hRcBS9NNX+Qvp8ZSmYJ1e32/LODoLWoyqXu3XOqlHGJOIP4JaF7s+luEJ92dulN7K4uqSXFVA4d37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTa6mF391ZVj1i3KJsZ6f78nRNAtEuPsXZ9F1PE8cZM=;
 b=ZsjcEyUE+C/t9ybTkRVRoXKEXO/S4aEItix2YYrJS63F3NMQ3IBGw7gosapNyYTNrlAcrClAF3GFOLfs9ioYeVvbZR2M80QBEpLc8kOB9THqTq6icN9Ym1rdoQNqZ50Scxw7ig70L0vfOqt4VWHnleFV2/dBl9o/6B0+mwNVRZJGo0hZy4R+mJi2Hp3Rjo14YjEoTHBov6w5epQFB5/8uxFD1o4s/x0l2Hj4vdLuz4/15JKluyzPFafGxS+IjhAD52YCS1sa+qnRxWIr6IYwzMCQGOXZsQKxg/Zu3cJ55jgrJ6JP2ylWJ36md6mvjBhDZUusld1m4Vyxxs3tfhkcWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTa6mF391ZVj1i3KJsZ6f78nRNAtEuPsXZ9F1PE8cZM=;
 b=sZLq5QumB9vXurVuZsJ3Q74xVgCnO3Uri8njFJdydh6SMHtTADe1Uc9/TSAyT/kTw0hC0cm0QcHdu9oQTCzqYR3tKH6rAtonHfPvJrxFUDJJECRcMg7TxjhtwroYZsOJdsI+vZ8IdHdMaTwHKv8XhOgLW78KXi2BnpKRfiF4U85V65g2m8qgqARH3Rh025iWwmto35Y7DBu9S3u8faCSB1QRda7nOSe0sTOi7LPOcBzR0bLR8UfBKCODisqpmkWCe6pyZVRy6eSXR3Ah0j6rEuAuwZfAJ/2CZ24tmeyVEjqsuCzdCYGdf/B2DCwFigiDhYnd1zt50yci1OqvToJXwA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB9PR02MB9993.eurprd02.prod.outlook.com (2603:10a6:10:45c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.54; Sat, 11 May
 2024 13:25:25 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 13:25:25 +0000
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
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v3] perf/ring_buffer: Prefer struct_size over open coded arithmetic
Date: Sat, 11 May 2024 15:24:37 +0200
Message-ID:
 <AS8PR02MB72379B4807F3951A1B926BA58BE02@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Zf4iJn2WoEzAGBfmCkfXO3/Orl8pYWdS]
X-ClientProxiedBy: MA2P292CA0011.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:1::15) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240511132437.14587-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB9PR02MB9993:EE_
X-MS-Office365-Filtering-Correlation-Id: ebdc26e9-f838-48e0-552d-08dc71bdd11d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|440099019|3412199016|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	1KbvCqvxrRGSaGucqwbM1nNudVLBjCB3/rKFg9KcroWr1nQ0axUJ8TLnPKa6fEwNZygaBaiO/NQRRxZZzjH0etfBi8l2pnFjDcd3f/6QBvTd4yGRoIDl43gG6CBmWIc62q4yHCN0owxF3e/QYf0iE5rJplxS3jxNtHpFIfB53fN/w5Ey6cJq93pTXvR1Bsbe/qFse/inTQrVFmGdTMj4LtT/pt2dexRPL1d5eHdLhye3Bj6RYzZ0VrOX6CXqH5OfiFd708Y49WR8aKXIyVoqqPCfTD1Wm3HuHCjfeOpIZniW0vDtPiU8UNwUlR8IBGu+BJalbUnsKWzRCdqiaO+yHVYfzFhV0zOLPGqyl2eQWlU5uEhZiOdfZ04+Z/GwyqExGOOWay7cc+V6l3fOGFp+jiyj0CUwoZhAob3VccGUCyDb5LWDW4HigB7ge3G+OeJO7+y8vszY5NO12OEohu9PlyJEkXe/GOOGISgwiPm8f8Btlgl5SmkrxNfx/m/8+5krzVzqEdFj9PMVap+v+Y7vx/my+etCX5vLUZESZ6SqwP7T55tjIuKSGEI9wiPVQ87wzOB9tjuuOVWCE+8XUNEggL9ZNPe7ZGK/7MlRyrDrNH0lTILCOq/Ax51OmNZybjGb1HwqhWlmMCcyY7GA7JWRgdyaAnhnn6qBTNl5RMqzYl3f15P8uxz3OBYtPBfvt+uckneWfEyEDM/SUMQKSgWPlQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9qOaJMFQ0xlfhfHy3g+w80gcpzKgqtTV8Fr/uJzKzt7JV/LP4xpIByiknST?=
 =?us-ascii?Q?XIo7xk/WJ5o5ug0zKMN32X8BAjZc9KcrvNRa8YRLyZZKKr+9atslZcTRhY6u?=
 =?us-ascii?Q?5iLw6/33UbGEirHIQZ0ZXb+RNFcJq+QxAYfHve4dDlftAetDUOg7Is7Y4l+y?=
 =?us-ascii?Q?fssib4G9+8/xHkt9A1PeBOTV7P856iUFH8fyVT0E6mwbdWKTtaW3LfhDyuwQ?=
 =?us-ascii?Q?g45Ds84VOvavRXRMWx857GVbCbCVRGUVl2HR1y/pDg+m2aGDcaKTUsdKN6S+?=
 =?us-ascii?Q?9cHyjNf6furdiZeoy2N5ippbFUIpJDgaZy0cCMYFbEkEYB7NAxf99/1kMluB?=
 =?us-ascii?Q?PFRXKQEvkYU5STXB9IANF1Ml4iIOqIdluAlGNJQpHr1eRoZaKqza1yhKeXIX?=
 =?us-ascii?Q?N+7yt4ha56+2E3bHVO3X6tAJJ7oeYayChUH16PCDYKiusFJsXwFyOECKUoyq?=
 =?us-ascii?Q?Cstl/2uy70DfyU6dMei7lKKRfL3P+Tkb3pAzD4ZHcYGymSfGgvIVXzmWbTNm?=
 =?us-ascii?Q?rBhB4AStFNbt8AiOmhOncgnu1FKyAqdimH1RELRtlFccKZ3nQbBspEMMdQFT?=
 =?us-ascii?Q?ute+NRWWCSX2sboZY2KQqJj2KnImMi1YZg7dNIoRhx8j9iN2Zv/CLDUpLKg+?=
 =?us-ascii?Q?DBqUP07g4+P14KRilnnsBakYO+al4CzicKHWEwbBnx1fuxXcTfewX37mtaja?=
 =?us-ascii?Q?BOEEJStVtovChjgXmruW1njujg85x23WW1veDI4x+CBJRwms44n7jjUNrCPy?=
 =?us-ascii?Q?MUClUratFzaW7fR+124eNnJkQGuvH54x1stEeQ4BViYaF1OoQlRY/YsMNfRg?=
 =?us-ascii?Q?mvZ+2AgAimEHQX2oJh01HQCP0gANPxYfTepzhRcOm7nXwmSnYhGsRGK5yeaX?=
 =?us-ascii?Q?pX6T6cgTAKQCdJUoNU27ZMYfIEXS0yCOPI+fwaU0lFfeaU6XSx/wiwJzP0OQ?=
 =?us-ascii?Q?RFyWTW8XR24gNratfF9y4TBZRyM9fVN3QNE/h+AUNr++KMuOaU/1L/Fjj7qm?=
 =?us-ascii?Q?O2/m5CYautf/meF8nfkEFHdJv1G7zrg7Wzr7g3ZjLAn5rNPa6/peE1ct5ufT?=
 =?us-ascii?Q?CWC2NgUsDyP50mx2rY4N9xjJuG3VJOmC4W48Z0X2KyMiWVxKrP8jq2rJOXPp?=
 =?us-ascii?Q?YVtOe8c6W8yPtejlnQVY5Cxm9Ab9EHclaSN9SASbOPOWeq3fG6I+clAW7f3o?=
 =?us-ascii?Q?GOQuB2DPSiOPYNR9fhXyxI4r18Xid/g5gDfQUjd6uEVibAHMQB3V9kzqeq6C?=
 =?us-ascii?Q?YmOEDSnoKoDa/g5s2SF6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebdc26e9-f838-48e0-552d-08dc71bdd11d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 13:25:25.2777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB9993

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
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
Changes in v3:
- Refactor the logic, compared to the previous version, of the second
  rb_alloc() function to gain __counted_by() coverage (Kees Cook and
  Christophe JAILLET).

Changes in v2:
- Annotate "struct perf_buffer" with __counted_by() attribute (Kees Cook).
- Refactor the logic to gain __counted_by() coverage (Kees Cook).

Previous versions:
v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com/
v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com/
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

