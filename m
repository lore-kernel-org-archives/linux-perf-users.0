Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2100.outbound.protection.outlook.com [40.92.64.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E75C8D7;
	Sat,  8 Jun 2024 08:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717836663; cv=fail; b=ep5K5vsWkhDCauyTpDo5a2Ps7VbFCN79pPWGvLdJGZU3nwIXpaZ4zx0cwupkj+QDYCwEVdFXqUOsLBBmYIm5xalinwQ2SGhZ7LD/WCJaBu+k6khdpMx+Rilme+KJQ7W/8pE22nT+0JHXqDiPmjHqRb3jpWHkwzCiIw1MXmgV3HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717836663; c=relaxed/simple;
	bh=mKEl+NeS5AKe13mSVsSlvNgDfTFc9+P0v993kwqOi0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XplOESC/G5TZ30FfFoGPFROLVpiGqvYFBRlfNxg1/x5JiV27YL8DDpP76lhuWPTklvOfTrzdZFQ0JKzgfTMTRq+wXNPbtGGRImS3qCDRNWSBYaCzuoNEcQJyZorlMitnT89YV/wZURuT1fq06/xINU+ab+MAKgRGrT9/1dhmiNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kf7Zwz4z; arc=fail smtp.client-ip=40.92.64.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kf7Zwz4z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m21/fk+3sdB0qdxlS2QCk1ez8ZUAEJ3is9vEfjgSIWiy1fJ54nv7Rh+ktxbh7cdbq5NQ/3Ho3By7VPMEHIn3jXuDfGN0i/K1dVqT+yOMRiNulDSYe+sJJ3T8m3teE5o3jyNwGB7pvHtn9uwi0F9FMxhS+OAK009QVzZXuebQUWG1JgAaVvEQUp/Q1emsa0SVXK7OvEBF0VB3Ih1tlppIWFDEWGu3+rLKMYoeLIHxyNeX7ubstTSm63I0Bptv76ltB55467tOlyu9hnfGIVi9pZ3g5UpVcFfUOvb8WSK6/Q2PjkSZCLHNEGZyldo8AbvKGMV6JjwHygxwwY975cwb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kI1ICNmQqtTPFjpmowBY+8Q+MJkKL0kbms6qTYDFwfA=;
 b=jFDG8ySF0VFU3locfjl8kZaJB6mzJrr5UXVwlOzJRtIvu2F3DmbLGf85Nn7v1uTHonJb2xJhTpp1yd8hrbLsuU4EgxdAG2gP8T1cB36/rfH9bDVpSOJ1031CRoBOm5+F0SoYb+S+IWn3h/n3KYdz4KF1ZdxHLrZfOWTsu1GiPwneHfh+JkQUvqHnFR5/l848z6OWpQFFP866hoxyLu6Zb1Q3gGGcWgIKQ1fUu+q1UXDQ3Nlf9Ejg9Eu7FaqGTZCKFneDiMhZf0ScjBMTceuMHbfFqoTWUmVGwvINJHyd/OMn5G+KGuTLwVCbOeQ6rBjexVfUC/TZdjhEETQ6kSWFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kI1ICNmQqtTPFjpmowBY+8Q+MJkKL0kbms6qTYDFwfA=;
 b=kf7Zwz4zL+7Nu/VFzubT0m3DfF9BBi4nBPcXsMG4EN6GAoxMCj0JhFoRmixqZlGHhjSUeDln94zsQaMbUDeaZ0haDzt0Ej6qmhSeyW9TfTXJ9tJs3xvbJ2Gq3pvScrrzPFwGR/8LhCQvScTFyDdwnV6xZmX3rAK0MzSUqf/IlglcouUoqZjgnP5jjLDQbVPTpcUqyQz6u4E7paAEynmczAsgb81kAfAGInlo06btOuYBTNCgTjU7k4GG3e3GU7PnQrtH7wul1OZ0UA2/g+0kliIJ0qUiW1JNrdWxF5aDO8tIeQCUJBI3HOlg40jYwsJS7GJiH1xAhuaAwSCz3imW3w==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by AM7PR02MB6372.eurprd02.prod.outlook.com (2603:10a6:20b:1c0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Sat, 8 Jun
 2024 08:50:57 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::409b:1407:979b:f658%5]) with mapi id 15.20.7633.036; Sat, 8 Jun 2024
 08:50:55 +0000
Date: Sat, 8 Jun 2024 10:50:44 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Matthew Wilcox <mawilcox@microsoft.com>,
	Erick Archer <erick.archer@outlook.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 0/3] Hardening perf subsystem
Message-ID:
 <AS8PR02MB72373C2D08910FBE5FA27BE48BC42@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB7237F5BFDAA793E15692B3998BFD2@AS8PR02MB7237.eurprd02.prod.outlook.com>
X-TMN: [LSpfF23JzW9R2DatHm6jWU/BML/DrECK]
X-ClientProxiedBy: MA3P292CA0007.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2c::13) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240608085044.GA2542@titan>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|AM7PR02MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0fc95f-0bfd-47cf-c395-08dc87981beb
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199019|1602099003|440099019|3412199016|1710799017;
X-Microsoft-Antispam-Message-Info:
	nam4ECmSO6OPv0fgbkMYWkkt1QYWoU2UHWDxWdcrUtSmPYeLbiBStktbYPTUx7FFa6pvogENZRmMO6rztmnJa8UHGx4mTxk2wwSQZW/R5RMpGqm1gvNIb1MYxV4vd8vEUzOujTKX8JhT2+uUzKy3ZKZZ03BiNuBVzJ58VU/7moxgfU3LQ2uzaLXuiwF/GYU8X+cvklK7TI2O11zUtAcGjr+A14VBTpxiBanXcTv99PHa7NkPQj5F788A7e0aQtA2bZETVUHya0C4M3fMEeeVAyGdT97/lHBMvo5I/8DG//hsCZy34KCsDCHE9L5jIfq6uGRAnTZ0lNoFETmV+MibPXcbQLFaXc9yMFaM/d3+JCRY9WVB1GpfujqQQYfLVbMxt7ikLsyw4xSH0+4CIB52QZgIXjyg76Vmm2lPDeT5ZVKGYFgQ3Lg+VOAw+GTIfzNZYG92b+VbUHWZtACDrwsxFTCxv8WFQlG3QMRGhE/KSdbs5hh5MlltSvtUo9zFYq/j2D80aZMU2tF87Ehnuh+kPZjgLvee9NXSoQ0jYmW/a/KQSLLMebgMv6y5aLSgIaAc+0PPxFxk1uyD28F0OA28VYxWX0F40eFkVlklWdcFnO192IpqSrJ80L87UBhIER39sCfiMyfYm59YV80KpA+c5aExCJHH/bZVFQPiWDgVlQuNysIiJgZTGBk/JKxA9m6RcVs7be1KbCVB45zdljsrWA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zygDKOgShVw8o0YQ0WEw4TfeXutsmw34KMugEPU0hOK/N5z3Hsaj8/EEAasA?=
 =?us-ascii?Q?VkfmNsI2qXx7IBbUV4pfGxQMc8a1+roZAbZzdiVzUJfGaDNEM2wn13Be5shD?=
 =?us-ascii?Q?6YJ7weQu22paM3sNsV1n6sAzgBjAV115RQcjDkDf7a1lrJHb0PTfHxWUupM0?=
 =?us-ascii?Q?sEAiRj7/BoW2HZXPgaa/3E6PT9jSH0egMhpRhnVy/iTnhjd82do8DDgc/p8v?=
 =?us-ascii?Q?DJY9YYig2XIaG3kWHt6aVLq5vitFJvtTzdlTdHc3w1PiiASsDOoBjvb2O+O+?=
 =?us-ascii?Q?H6n0c5UjGEqMJ63/jgjBwLco+2oKvI4RDdFoOHFtOFXiFDTQbm30i1Y+3MLB?=
 =?us-ascii?Q?rD+AbJVYh5pLWPbUEvD1nNmKjGkOW/8QLPPlBvXCZGhs7YB8DcPgxZq89SHg?=
 =?us-ascii?Q?Cm3oerqhA9mdh5gYVGLQEC0ewWZIIYGTc84l47pj9NmxdPaGgf0JJreUiW6C?=
 =?us-ascii?Q?lBytUQBBRGppT/khCDAER0kKdoyxHLjnST2ghOhntjKqpQ9WfIDUwtwyO3F+?=
 =?us-ascii?Q?fKGqx5ImZBgGxLdX5H0iwnwZN6u8JoT38KZMSdAbH3ornh5bPIo5w/ZG1qDR?=
 =?us-ascii?Q?P7ZuamusWtYo0l7LTlqorOYRHV8iTh2Vs7U7FGCurQqcLkaOuidKWEcgo1gu?=
 =?us-ascii?Q?bUTBDIW8eI6p029ZfyWYJqGdkEcWadgwh9uFOuUG6Bb1myc25Z+Zi2Gu+0tS?=
 =?us-ascii?Q?b/mEZ4UuQ5f6hueOMxo0r4vorLWm4JAj8/UAu5p7Wc83+yzg3SRp+Xa+lUlS?=
 =?us-ascii?Q?+EaZMU/AP66ZaXFX0YnLxZWEm6hCUBzp1XeRyXVddT1PdCffBYB865LvgEIy?=
 =?us-ascii?Q?doHO1zUrx4uWOM7ecTHOf/vKCj6emeoqD3d9h/w9ci1SE+2thH47yNWrgNzK?=
 =?us-ascii?Q?1q4uQMbYmD8LGDWcl5QfHvD6+g2/GZTkrRjQfD1MkSIZchjpjj4YcDUYyQqA?=
 =?us-ascii?Q?ZoU3K1gXAzt1YELeXoVt2l70USb5KaFhFDwJeo+R/OXBP9nxeo8NbBb1EXYU?=
 =?us-ascii?Q?BxFatZgiJ19JvWKmrn+Rk72BTFDlutzByTffVw+4IjYRI6MnjcoyZQ+2eYgy?=
 =?us-ascii?Q?aBCKs6+BxgLcS4nGOI6JMsgTAwIG+0QbPvCOBFozPjWLjq1OJxKHrld161so?=
 =?us-ascii?Q?3W981HrbxhIzXj7G0oOSa9WgEwuNyTqqxk7ECFpZw7GbU04R/nQLohKZ4Gou?=
 =?us-ascii?Q?3e4WXogh7NFZQM/bREHi4q1yFNYmvhuos5z47lOKy0fZcNKjP5QgC26W5YHl?=
 =?us-ascii?Q?hdwytO/xibBYAMNMd7DB?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0fc95f-0bfd-47cf-c395-08dc87981beb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2024 08:50:55.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6372

Hi Andrew,

On Sat, Jun 01, 2024 at 06:56:15PM +0200, Erick Archer wrote:
> Hi everyone,
> 
> This is an effort to get rid of all multiplications from allocation
> functions in order to prevent integer overflows [1][2].
> 
> In the first patch, the "struct amd_uncore_ctx" can be refactored to
> use a flex array for the "events" member. This way, the allocation/
> freeing of the memory can be simplified. Then, the struct_size()
> helper can be used to do the arithmetic calculation for the memory
> to be allocated.
> 
> In the second patch, as the "struct intel_uncore_box" ends in a
> flexible array, the preferred way in the kernel is to use the
> struct_size() helper to do the arithmetic instead of the calculation
> "size + count * size" in the kzalloc_node() function.
> 
> In the third patch, as the "struct perf_buffer" also ends in a
> flexible array, the preferred way in the kernel is to use the
> struct_size() helper to do the arithmetic instead of the calculation
> "size + count * size" in the kzalloc_node() functions. At the same
> time, prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute.
> 
> This time, I have decided to send these three patches in the same serie
> since all of them has been rejected by the maintainers. I have used
> the v4 tag since it is the latest iteration in one of the patches.
> 
> The reason these patches were rejected is that Peter Zijlstra detest
> the struct_size() helper [3][4]. However, Kees Cook and I consider that
> the use of this helper improves readability. But we can all say that it
> is a matter of preference.
> 
> Anyway, leaving aside personal preferences, these patches has the
> following pros:
> 
> - Code robustness improvement (__counted_by coverage).
> - Code robustness improvement (use of struct_size() to do calculations
>   on memory allocator functions).
> - Fewer lines of code.
> - Follow the recommendations made in "Deprecated Interfaces, Language
>   Features, Attributes, and Conventions" [5] as the preferred method
>   of doing things in the kernel.
> - Widely used in the kernel.
> - Widely accepted in the kernel.
> 
> There are also patches in this subsystem that use the struct_size()
> helper:
> 
> 6566f907bf31 ("Convert intel uncore to struct_size") by Matthew Wilcox
> dfbc411e0a5e ("perf/x86/rapl: Prefer struct_size() over open coded arithmetic") by me
> 
> Therefore, I would like these patches to be applied this time.

This is my last attemp to get these patches applied. I have decided to
send this mail to try to unjam this situation. I have folowed all the
reviewers comments and have no response from the maintainers other than
"I detest the struct_size() helper".

Therefore, I would like to know your opinion and that of other people
about these patches. If the final consensus is that the code has no real
benefit, I will stop insisting on it ;)

Regards,
Erick
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/160 [2]
> Link: https://lore.kernel.org/linux-hardening/20240430091833.GD40213@noisy.programming.kicks-ass.net [3]
> Link: https://lore.kernel.org/linux-hardening/20240430091504.GC40213@noisy.programming.kicks-ass.net [4]
> Link: https://docs.kernel.org/process/deprecated.html [5]
> ---
> Changes in v4:
> 
> - Add the "Reviewed-by:" tag to the three patches.
> - Rebase against linux next (tag next-20240531).
> 
> Previous versions:
> 
> perf/x86/amd/uncore: Add flex array to struct amd_uncore_ctx
>   v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237E4848B44A5226BD3551C8BE02@AS8PR02MB7237.eurprd02.prod.outlook.com/
> 
> perf/x86/intel/uncore: Prefer struct_size over open coded arithmetic
>   v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237F4D39BF6AA0FF40E91638B392@AS8PR02MB7237.eurprd02.prod.outlook.com/
> 
> perf/ring_buffer: Prefer struct_size over open coded arithmetic
>   v3 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72379B4807F3951A1B926BA58BE02@AS8PR02MB7237.eurprd02.prod.outlook.com/
>   v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com/
>   v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB72372AB065EA8340D960CCC48B1B2@AS8PR02MB7237.eurprd02.prod.outlook.com/
> 
>   Changes in v3:
>   - Refactor the logic, compared to the previous version, of the second
>     rb_alloc() function to gain __counted_by() coverage (Kees Cook and
>     Christophe JAILLET).
> 
>   Changes in v2:
>   - Annotate "struct perf_buffer" with __counted_by() attribute (Kees Cook).
>   - Refactor the logic to gain __counted_by() coverage (Kees Cook).
> ---
> Erick Archer (3):
>   perf/x86/amd/uncore: Add flex array to struct amd_uncore_ctx
>   perf/x86/intel/uncore: Prefer struct_size over open coded arithmetic
>   perf/ring_buffer: Prefer struct_size over open coded arithmetic
> 
>  arch/x86/events/amd/uncore.c   | 18 +++++-------------
>  arch/x86/events/intel/uncore.c |  7 +++----
>  kernel/events/internal.h       |  2 +-
>  kernel/events/ring_buffer.c    | 15 ++++-----------
>  4 files changed, 13 insertions(+), 29 deletions(-)
> 
> -- 
> 2.25.1
> 
