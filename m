Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2101.outbound.protection.outlook.com [40.92.89.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176591527A0;
	Sat,  1 Jun 2024 16:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261012; cv=fail; b=cPUBa5HTfdfzY6FvAVg0r3qmg2pqjFTbe7M6btRIHzJFDZ3CWjMEKbVmYj74EYzz8UXsEg/2Y2sqm202jeuHOCwbns1xw6qdWndKmLZBDK7hVvbXBJOoQh2pJdPNlsJNkDAouVz9kfc9hoYvw0ig4AxB5FLhqGJIbXLxsaPYPBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261012; c=relaxed/simple;
	bh=9yqc7Sr61aoqG/gjl22jVKNymim4qwOQ4zHhu8FoDAE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bwG802rSzw9+LlCCdydJ3eTh6oBbwCH9p//M6Z/3baLF5+jtBZG5g+eaesggm1fjowOJTIY1FbPccJAAiX8WjIUnLNQn3pZNB+I4LPvN2w5HeNDMoneGUOCIsO99b3kI6V7dwzslJkrvNE4FlpX/wUvBe6PBpUxKLJxhCP+HgyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hS0eKmzS; arc=fail smtp.client-ip=40.92.89.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hS0eKmzS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GS/Jv3urFklCXF7cWcTpE0RGSWcNzrhq5bE+5u91xS/4xkC7PG5j2Sy7Qns5QsaX6caaoNSMb6B3C2mEnddwingsTsWMlMDegVP6TJkWA+PNVXlV9xhQZNRLvyTMRCntLXdq0u3on18h2J0YdnRIXYeWfNrNa0/5vrY6eNijnFMq9MC541IKl9seQvSyaKVbd7pPvwFulFOQkUz1tnL3dFSTa1mxFfbyfCyULXjYAzSfvQGx87TYth/Hfv9TXHUA/EZXToB3Ujx2laTBcl6MNRM5lna5ci2azGWq9H6zK9HIfJr2k+Z23PGsbUMqlcr2p/izZi/Dmp5U+wU1Oy6d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmeITY2VHbKMC2hZHCEd45Qi16CFcFUJ+jKfKvcCGiE=;
 b=VEvxMKQgHod7MpMtstVgDfTgZDGfF79XLELDJBBSW+zPtRe8RX9YQ+RwLWXQAjVbHp2LPvuWuw6ZHODnSx5ca66xPc3MeOGwQgiXIHnfypNEiRhuSh05w+DYQ6TWnTnqDcyLinDKjjZ9y65pxmpoZQxo8IcviPRUjAik8tJaocrbB54hQsYqyJB2AAoUpFeUuyy1+EWwn9/TLURY1nuV7np+MG9rKYrPKbKiBu21FCHx5wwB6iTk0c9KV1kd3+eOkjwpbBU0iH3eBF4otu9BJccsJShKqSU+/P3ITicCMw72BfrbQU3DNA888jW7popccwGVS8n2hbvOPAUk2u42aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmeITY2VHbKMC2hZHCEd45Qi16CFcFUJ+jKfKvcCGiE=;
 b=hS0eKmzSvd+8uWAz8BFgy5CpU/f3Y8As/nSZPTltt4yyfFOnpEOSnYQikcPmRxKoJCzaqtImWdtcHzVyIr7jA12xU3v6hokSA20WG4xeSyS+POpc8lJCuLVEo2Vd/2p7i8r3Zjs8cPV6DURnI3eP4jXaSPvmuyMth6fYSl1cH5VxhIIjX6zwRsnieYQuPxNh1rYuZh/XcXmMQesBabQy/o3bfLzj4PKTPt+8WbwskpAdB/hNprXnAdKM+mma4iuq1wuS850nE5sH59shuWpPQkKz3UBiHUXNUnyrSvRnmhBUYP5STFnCYue+NtDhOgxiUUFtVnfAFuH7Df8RJaejUw==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by GV2PR02MB9373.eurprd02.prod.outlook.com (2603:10a6:150:d2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Sat, 1 Jun
 2024 16:56:46 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 16:56:46 +0000
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
Subject: [PATCH v4 0/3] Hardening perf subsystem
Date: Sat,  1 Jun 2024 18:56:15 +0200
Message-ID:
 <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [N3XsszNY1gtIpoqW4DTpzsSnJRizI6QZ]
X-ClientProxiedBy: MA2P292CA0022.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::11)
 To AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID:
 <20240601165618.10020-1-erick.archer@outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|GV2PR02MB9373:EE_
X-MS-Office365-Filtering-Correlation-Id: c96ecd84-5913-40c2-e294-08dc825bd28a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|3412199016|440099019|1602099003|1710799017;
X-Microsoft-Antispam-Message-Info:
	uLoRAOfo8CVsXgTabldDxLybMXy6jwo3XwqyI0G8oxnyXHmT740CtBNCv+DXybMCSl9cCz1IeqX5qKVpHCy/sURY2o94DyGDDPinlgwTgjvg2g5vHNCQug53HjEuljVSubtGpQ1SWMX3hhO6Ks/HfdyfHuxbM/dWTeSaCP9c+EE6qidQ4+CvlTo0Gj+828SaAafu3+x//m1Nvqgih6mhzLYkWzGsH9EAW1dM2wAR8BJql46ovL6b+5nYuMH53tfstgWRTdudLnnSqAAzaoqCEvUXeSDzKoCtJhJfMoJ14DpLBlt+pE4HU08kJmrYA6nas5K67jn2h3vP8hbz4EReeBt08859h5RbXJnt2SMN4VLuR9yM6fwIE6a9+8ybEtZqYIHKdmjQQXynWbBzuK1yAJIIzFo9ulSXBDKk3NU6D4HBaoxhCbcfeElKw4deAB1ilZCkPbGDIERDygoI/46WM6dlkrG0DjKOhmZnI9LzwyuvRc806wCQlX123BFofide3L5HWHrkH1+arccP7j981Wv4Qsw5poLAR4LURx12D2sefiM+k4yO9OHUK4eIIsyCJa+OOkM7SebMvecx5waJ2g3sKJCEv8YVrsU9GusRn0wg9v1DH9gaexA439GE0SkX512AXUh/OepGKehcMK83SP1ZvkiH82hYJWkzTklVdSPx2GBO3f1kwaui43OSH9PWYlBG6bny10QJkBnJiNzs/w==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OK8bbD2ctI+AxNn3tpDLG269ig/K4dPR2t45n4VMzkE8fjqQo3cR0RRYz/hl?=
 =?us-ascii?Q?ANCAP5skm5c7BipRCOH2fUF8/EDjwsaNfE+6CDu6drXmF7fQt5qFYdZ5MgIv?=
 =?us-ascii?Q?Qad54ufp7IM/vI/Zs+/MFxfBN25wsLSs/jgN46krp1WkMMkB9khno5FEdnr5?=
 =?us-ascii?Q?gGT5lkF0Clv+EY6goAA0RN3FHBZ18S2OmIou17ZpmQpXqaAlGrhHOWz2gP1G?=
 =?us-ascii?Q?O6hLsqo7Lscehi3WuelCOAmN8AnzB7X1KdDopDpwSQ5vlDq68VK7K+yxpgMi?=
 =?us-ascii?Q?lnPIPgF83otj1sf1RFeqHQnf/UGoqA7OW+pSRtLG3YI2n0gR6dNCg70LZ6Wd?=
 =?us-ascii?Q?F6Sz437/GYQAKAZEGqqJ/BYqpuTUjEaDqOXMVjs2OwSFPYxKLpTU67FrhzTg?=
 =?us-ascii?Q?ml/K+f3juC6y50kp3drGAGe0l2Qnjo8gNVP5mSBA8cYSeMJC7ggbHQpk1j/j?=
 =?us-ascii?Q?Q4O1w5TTUO7zgydZbLqAStnI/ZgdRwW5yMG6+eHPxzQ1L64JaAzSEd635jbE?=
 =?us-ascii?Q?Pu2DmbQbZp9Ikx+tTs6ZnGr3YofnsaH1gIHnWWNhsS7D9ZvMf/smPn16NfWI?=
 =?us-ascii?Q?SSNE4IKqMs8Q58uCllRtONT9uqtMHqgowCRnMO9qNRikeN8g0aMQc1NeMEWs?=
 =?us-ascii?Q?LnXb8caEAxpfeONuMOQiBkkGC+I/U7Thwi3m2+SIez2uRbUFAy1MdiRxCWoK?=
 =?us-ascii?Q?JtlOootjPEYpaFr9AStTohSyslBNltNBzIk5MJHfFKFH0JwRJXgZwCJRMLFN?=
 =?us-ascii?Q?37gcboHi8bMPaotn0cwPwP4j8BpXRHxifJ0LZiepETTWP7lYPEIi4Goj/6gR?=
 =?us-ascii?Q?7lPN8YQ30ZtfSudP/EdYemErrmD3rqm1f6YdV2QZ258mGlcPM1GUb0+DoFE/?=
 =?us-ascii?Q?1MY0IWXoTeGMGeKZZ562U9XN5sq30UyAtt/SjS7ehzy1j7d7mIojwCky/tdD?=
 =?us-ascii?Q?mSedno0L3fWuJ4ah1A38j/yPold/7hRqSc8bf/rYzZr2sBT8r/unMutAa6uq?=
 =?us-ascii?Q?ITbEY3qfX08YtCOH0ofvONKyoBfqgC/XN0/iTc7sNMb4WFPFo7LJDiC2xxUU?=
 =?us-ascii?Q?7TYZJSeswzGzNphwoS2qhXLpEo+Cg1NO9esGpkbdY+dRZgz6zzG/WmKaZ8Gz?=
 =?us-ascii?Q?rm3bNeZCVYOhGCBSmbn8/lqZQnA4jhE/dE6/WXKemaMfeVF0awVzpSBeSRP9?=
 =?us-ascii?Q?YV5Xe3kTeGoePf+tqd3lfzQ/x0zJ9t3BEgK4SO+WIV5WJlAw8zDNwxpeGVrm?=
 =?us-ascii?Q?Z6w0xdnBeD3YkzZvVWKx?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c96ecd84-5913-40c2-e294-08dc825bd28a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 16:56:46.7637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB9373

Hi everyone,

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1][2].

In the first patch, the "struct amd_uncore_ctx" can be refactored to
use a flex array for the "events" member. This way, the allocation/
freeing of the memory can be simplified. Then, the struct_size()
helper can be used to do the arithmetic calculation for the memory
to be allocated.

In the second patch, as the "struct intel_uncore_box" ends in a
flexible array, the preferred way in the kernel is to use the
struct_size() helper to do the arithmetic instead of the calculation
"size + count * size" in the kzalloc_node() function.

In the third patch, as the "struct perf_buffer" also ends in a
flexible array, the preferred way in the kernel is to use the
struct_size() helper to do the arithmetic instead of the calculation
"size + count * size" in the kzalloc_node() functions. At the same
time, prepare for the coming implementation by GCC and Clang of the
__counted_by attribute.

This time, I have decided to send these three patches in the same serie
since all of them has been rejected by the maintainers. I have used
the v4 tag since it is the latest iteration in one of the patches.

The reason these patches were rejected is that Peter Zijlstra detest
the struct_size() helper [3][4]. However, Kees Cook and I consider that
the use of this helper improves readability. But we can all say that it
is a matter of preference.

Anyway, leaving aside personal preferences, these patches has the
following pros:

- Code robustness improvement (__counted_by coverage).
- Code robustness improvement (use of struct_size() to do calculations
  on memory allocator functions).
- Fewer lines of code.
- Follow the recommendations made in "Deprecated Interfaces, Language
  Features, Attributes, and Conventions" [5] as the preferred method
  of doing things in the kernel.
- Widely used in the kernel.
- Widely accepted in the kernel.

There are also patches in this subsystem that use the struct_size()
helper:

6566f907bf31 ("Convert intel uncore to struct_size") by Matthew Wilcox
dfbc411e0a5e ("perf/x86/rapl: Prefer struct_size() over open coded arithmetic") by me

Therefore, I would like these patches to be applied this time.

Best regards,
Erick

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
Link: https://github.com/KSPP/linux/issues/160 [2]
Link: https://lore.kernel.org/linux-hardening/20240430091833.GD40213@noisy.programming.kicks-ass.net [3]
Link: https://lore.kernel.org/linux-hardening/20240430091504.GC40213@noisy.programming.kicks-ass.net [4]
Link: https://docs.kernel.org/process/deprecated.html [5]
---
Changes in v4:

- Add the "Reviewed-by:" tag to the three patches.
- Rebase against linux next (tag next-20240531).

Previous versions:

perf/x86/amd/uncore: Add flex array to struct amd_uncore_ctx
  v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com/

perf/x86/intel/uncore: Prefer struct_size over open coded arithmetic
  v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com/

perf/ring_buffer: Prefer struct_size over open coded arithmetic
  v3 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72379B4807F3951A1B926BA58BE02@AS8PR02MB7237.eurprd02.prod.outlook.com/
  v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com/
  v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com/

  Changes in v3:
  - Refactor the logic, compared to the previous version, of the second
    rb_alloc() function to gain __counted_by() coverage (Kees Cook and
    Christophe JAILLET).

  Changes in v2:
  - Annotate "struct perf_buffer" with __counted_by() attribute (Kees Cook).
  - Refactor the logic to gain __counted_by() coverage (Kees Cook).
---
Erick Archer (3):
  perf/x86/amd/uncore: Add flex array to struct amd_uncore_ctx
  perf/x86/intel/uncore: Prefer struct_size over open coded arithmetic
  perf/ring_buffer: Prefer struct_size over open coded arithmetic

 arch/x86/events/amd/uncore.c   | 18 +++++-------------
 arch/x86/events/intel/uncore.c |  7 +++----
 kernel/events/internal.h       |  2 +-
 kernel/events/ring_buffer.c    | 15 ++++-----------
 4 files changed, 13 insertions(+), 29 deletions(-)

-- 
2.25.1

