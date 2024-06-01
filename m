Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2101.outbound.protection.outlook.com [40.92.89.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FDE153BF3;
	Sat,  1 Jun 2024 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261014; cv=fail; b=bTun9TpzWq2sGYGKv93hiyYxkWmf2XKaSnyH3sRZtpd5sVof/KC8EVaYi4PJOvl6QFyKV6/ZyQIpQMQsfwqUWRBv3aIHlEYFsZjuNk5415swCS6I5JD37S3t4PL5sfrXycUsycGAQk1K0s/Qz+atZdnYPoi9/DNLrmG4+CmtVqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261014; c=relaxed/simple;
	bh=h7kkD7qwDYExse+DmBsFiFlScC1HUR2YMmPYX4hZypE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rSGaJxWi8qnsALTG6re6fJmYd0CzV0sLIr/bOe3+OfHum7jSHqz1Fmb/choSxiuKxI/XmEvv2wRzItYcydL1u5CY3YslW0RnnQvHzidh02Vncu9ArfsWvrfhsUajHLjlzHFLw9aNw8DdorBZOu+EI9O1SXnOTKkLiTsKbZRbUGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=es3c5fym; arc=fail smtp.client-ip=40.92.89.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="es3c5fym"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyttXt64af9sRzXwQmVAroePGnOL5Zb3IhwL0yoX4LIT1lyh+5b03OUE6+VTO2JkI7YTC5sPMdLBa7r40VQwVEWO6bc3Fkh8FOUISJwnwYL95wnkNfOSAMI07DeGG0dCBTd8T/Nd8NVUQFrxPs7lRuPvUaQcrq8DQJ1CvirW4hzVBpZDdUzSy370eaSTS4xSfEa05Ei0ykDSBKWZoH71v7oE109vSTSruPxWl1nGZAAFJ7PbNSr2S/t5MAnqwDiIoTSkF1TpKrfEdfmGMii9pPu97CAZ9IHujQDXkH7Hpb4xUNzbPLa1/GuQO7mnLKuqr/V5woSCSL5LKTqrlytDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cdB4GW5zXXUBcRZ7W70LZgkxQ7agBowrJVl9zTX93Bo=;
 b=Sxja4aPgAAo3qer7F1w7BI4YzNTYaRxsA4KchEzsDoVKnC/zXHK3ENVZnzdBvScq2y2YwNLWUayR4HmDyeoEjKumQkKGZniyJ/h2OpHgvbb+cFSTRffASMeyCevtj0NHGquX7iqhPrG6dwAl3f+dOyTR0zIX/rh+i5uaKA3LrMiB0R3RMGZOVCvh9qLmw1s2EJ/oa1wLl+RbC80KimUNRfjsPfHAHzEDebbhIYu4qQ5jl7EESaj0k5nzxf3zUazSgpYfLN0doKw27SmKhF5MZzByz+uQ80RZKXqp8yc9E1lQgMPU1ZPXrp8R8pv01UhQjr5xkkNZqrChxFet9FflEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cdB4GW5zXXUBcRZ7W70LZgkxQ7agBowrJVl9zTX93Bo=;
 b=es3c5fymx+5LZy+2VgzNjcTPfgiRS7Bbj8TPM7XzH4XVUjyWJ/YGa21/LFleueP1rUJeLwrxpZ6JlylnZVxc0KK286RyM/hNRq+GOPanB6t0x3YRJsWRnnOr+odqnE+2Av3xSpjU6a+Um3G3L7w0nuFWOeUdi62xQk7bU+Pg3VWD5Po2p+bR+iJa8uUjdgKQb0A5/spZeb6OkPJF7lKABVbU9VNvgylDgMrF2+ZLB4n3MR5lRaMpMki4eJ13Y2aM4JoIuLOskPjOtXh3K5SlioKpve4XpvSfp64qGUL96aQ//NnEX5n2mL9Smcws5MiLFQXRjfMV3nbIac6i2CDJXg==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB9373.eurprd02.prod.outlook.com (2603:10a6:150:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sat, 1 Jun
 2024 16:56:48 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 16:56:48 +0000
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
Subject: [PATCH v4 1/3] perf/x86/amd/uncore: Add flex array to struct amd_uncore_ctx
Date: Sat,  1 Jun 2024 18:56:16 +0200
Message-ID:
 <AS8PR02MB723778DEAB8E5C9F976953B18BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240601165618.10020-1-erick.archer@outlook.com>
References: <20240601165618.10020-1-erick.archer@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [i94Mbi7ElxHnp5a41LsmNLJifsZHa14I]
X-ClientProxiedBy: MA2P292CA0022.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::11)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240601165618.10020-2-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: b0eabea1-9349-4c30-4724-08dc825bd371
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	G3rmGR/fozQ+WJVS+RM+1dfhwgnuPDhZxK5Bhizaca91ZCGv/gbajd6P0lAKFVcEf0jCLaudbhEyYXNxzZZwtBY7X/Cr0Sy8LWp7ntDZ0GBEfPmLGvjqRDUVNC9vv5ED7tVtHGLeZEwZFUeL4VqWWDJBTplCZlB45WO4veF6du9jSehAj5SI/RY9OQax+SG1VLhFkq/biIXTz9+fgbEd44BDgVuG/JtE+NGUGe2Zwia2/RtX18tiKGEcbp7vDRb4F8PIJgRrBZc0xGu/HzkhgqA/aaMzGLx8jgPrtJAn5e+tsZklrxKKinhPItFBoL3vui0VOpQZdNU1m8pS8ciw0CBftQ5n2yDX7PvHj8RO9Ic0FYMxKvtE3+gOnZzKF/1EFmzoft5idZYdggYw4bKZFHvjkP0ryq3XMvhk0BcBTO5n9cnTFswRsPD8Bp+8aJCr7Q++fee/idvzRlFiXDgtyzWUbbhkdoLKoLGydG9NDhj1P/naQaCSY1JOCw0Gdb58cWPBn1L4CN2HI7iSGVUC9e5QD9pYMeGOt2SsWRg4gOyAuXhq54bRHKD6Sl9pK1FeXmHbBbrAagmooWaN544tjI4Vs8MK83Z5KrmGQ/29jedC+VVad2wj/SZVSFfuY69QGusVteKG7dAfz2zZeXAw9f043y11W2rxhG9jNuaYRt3fWbyS7Z63X10DHoqyyFfDygdAVnQaTaGvAE44nMbvGQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f0icmLVKzTWn2hHw9W4mXJCbRsDWNf9K5jqfE5MqVVJcpGCY8fHPLR5A59sY?=
 =?us-ascii?Q?Od8nJ0XUF/rxf9kXr92XsX+pAl4ES3KLiNQgVJm3U7QroALqSAOWH50ZKgb+?=
 =?us-ascii?Q?wNWP2zZ7WiXHmU0EK0O9lGffwrrXbbOHumEJgIrJXp5LyshBfntLl4WWLKPO?=
 =?us-ascii?Q?6AqB6uopPxHhOxVobytbcFbIQPoYSozQX0KBYkccGUZUbwQ7+nbUysTf0w11?=
 =?us-ascii?Q?kPd1lBzTdFe7+rJqSTzVHtIwxJ4J1VkY93+SXXb/cY+jx9aLfHH+oAskzDSo?=
 =?us-ascii?Q?IO6rr4yE9S7GcWpfp9ezE+x7ifBn4HhcViUF8M8Za8qg20N//mT66n8Nc/5G?=
 =?us-ascii?Q?lkbfUdr2+rhptxl7oHihGsqbQrYPG2v7RkwlEOQXmX+IZYK4wN68cxdORaJk?=
 =?us-ascii?Q?1gMQdxH9zvdVYmsspXl3lPv6p0nMJ8P7XPxiEepl+opcIQZJ4NCKfIGhIZLz?=
 =?us-ascii?Q?+sd3zCkZNiO3Cxd/KTrXdxiuZEhPQcQq/sDHYpf+a9+wfNbHcTmnzeKWgHGe?=
 =?us-ascii?Q?JkI5FmAykzG1szqw71JlR70ssJ1FYZTQspLDnPO4W8yF6OvL/yfeKMoDCH/o?=
 =?us-ascii?Q?EVfUqZybGY8db4xPG9XGH581qFJkeIa5tBU2jet7j8NW6JkdH1Z9i2tCEBLW?=
 =?us-ascii?Q?bKyM81xUNQk2hHYNFlTbIk9bjAi3TnpPG6hXm+aO71jmW360bIw8URaOCJqF?=
 =?us-ascii?Q?Sy6fi1uU+BqMksj5DvvNMPoP2rYpxPXz5Q2ZiODHSbpszQ9W9ghE/pqgxe4A?=
 =?us-ascii?Q?W5+1XGanV+ZtD5chMk/b23bdBmqFwMGaTSpw2DTia3ka8P7kcDkZRx9wyyIm?=
 =?us-ascii?Q?ASPLhH6PKExkLxU+yu49PZtYMMhzH3KrPZDkuz7+RH/Cs19LjtCXBfylARoR?=
 =?us-ascii?Q?kqN1/VEn3uYisaJ0+FwqkhFNrViXzFz6i0Xgez8EoXUN6p1VFDidBKll1kLs?=
 =?us-ascii?Q?9v7ivRV23N2eogLuxRuYOG076aSUt2ChivB3eErbE+efOlxQ3lOSBDZ15oFH?=
 =?us-ascii?Q?E9pUF5yS+spNgRK5LtMwBOJKfLXZ74gukiEyNmtB6v9OI7sYMhzd6AwQYBAR?=
 =?us-ascii?Q?KnwRcvUuv4r/LEBJTY04Pi6aqYbRucVSWyQjqgEjUKFAvHb1gXuNLHwSaOiO?=
 =?us-ascii?Q?UPp/AuCqG0anMasoqQgQyjoG3zonSDwUd0D67TVlowVzgQZfekwBeST+bVYH?=
 =?us-ascii?Q?p1x7FxeEs9aBUoMxiGI9qeeqDOK2KIO7xbEP9PtaBFDRSupZEfXcYfVJuxMa?=
 =?us-ascii?Q?PVmzA5p1bCMC0SxC0sOW?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0eabea1-9349-4c30-4724-08dc825bd371
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 16:56:48.2130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9373

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
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Erick Archer <erick.archer@outlook.com>
---
 arch/x86/events/amd/uncore.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0fafe233bba4..9d43048bfdab 100644
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
@@ -430,10 +430,8 @@ static void amd_uncore_ctx_free(struct amd_uncore *uncore, unsigned int cpu)
 		if (cpu == ctx->cpu)
 			cpumask_clear_cpu(cpu, &pmu->active_mask);
 
-		if (!--ctx->refcnt) {
-			kfree(ctx->events);
+		if (!--ctx->refcnt)
 			kfree(ctx);
-		}
 
 		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
 	}
@@ -478,19 +476,13 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
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

