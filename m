Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FFB1591EA
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737735387; cv=none; b=XbO/M+QGTUdp2UmZiQhjzKEg2Bk3oJQoYCjSUGwY3g5OlsvIfbsQdwGsw+Op8JQGbthZVkMxmkz7fsfeV1WpQE2vXYsqc9sdD56dL3oTSkpvOxhHwoFFhQuV7dc55zYASfhfxsSz4+xJ6E9cNp/KB+Rvria3ReltS9+d5qb6ZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737735387; c=relaxed/simple;
	bh=qG7ZvWCP6mbYVi2UjSJKsJQvE7p6RUrflASGaVvrFF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W1pn1gZst1+QWDf3tc5QZQO695DfP2QO2Ppy5WiLJy0xj9spRoksDg4/+E0LW/rotaOvf2hD/DvIrK8CeZp6j+ZhrFxjwd0G7DgQAMCCOTGJRE1J2SeIFHY625puyIhlXX3YyhZBjajUY91yWp9Kg5ua1fOiPBny6pc+wFBCSbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HiI7IOx7; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HiI7IOx7"
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso126855ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jan 2025 08:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737735382; x=1738340182; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D63OI66Ed5yui1rWnRt3zejQPz7hHpSCSw88wHy0M8Y=;
        b=HiI7IOx7yd9yjGfNlep/durFLvQuQ+oekeU9NX0bNGqTnG2S1FbrD8x54+S8FjRI6W
         zPMt8lqyL+Mmit9myRGlma28VjbnjkHJgsAuGdC3SO63bJBd8bkZ0oLZ8aDWz/fmZeF0
         M2G2Za4Aofo0jPYxk3JNAWg2Qe+zZC6Pu9bCZQj1q9WRgWuE+59i1hpmTwr8i4Gg5HXE
         0PW3xKGNakZRBgsw4yZ42AR2D1Tsk8PQ15DTVG37Bm47AQ0Zj8jZPWs0TlxxdReUhTOh
         3AVM8FgQpcl0lK721hldqjYifqWWCjUC7o+lKOKPssnoFQdg9v+Fczji0rkN0sIfBFEw
         TiXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737735382; x=1738340182;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D63OI66Ed5yui1rWnRt3zejQPz7hHpSCSw88wHy0M8Y=;
        b=PJfbAHNT0CfkNkAM4t+Sq4UEKtN3kwKPUxdTF4NmNg7MafmE88S2FoRjz8DcakoTsY
         VZGIEet8lFQTttmYM9MW7JZ4GPJ02aKUEyjyRn7BGMn5Hb++tNPOt4BQ7R+1UbBTFBdm
         IBAKwNhB2rHlco4qIrzkoc1Mr7uBSeCnVMvPNshtShEtb0CD7ISx4QP/Df0c9/+mbwTk
         wd+4rDglmXmHlEdBLpEeKq5nQDANYnNMeRAnbpKW3lVIH/hhiGoT1UU7KwmLl81zplEI
         r7nWnoctYbgEe1w5osFmKnh3ssKtOCNqdBYuPwvC7adLrJ6ayqlvWz3pyKmykGJwl8Gc
         3Uzw==
X-Forwarded-Encrypted: i=1; AJvYcCVMW+85pfQEfeKFqrnm9oxNAxBLsZSF9WLC1JmyEYM0/z3f5M1BNlR1KFgwF/+Ybq6VLjn2q6Mtp3QMq0mRqP5d@vger.kernel.org
X-Gm-Message-State: AOJu0YxTlo4SgtJNqc+975rDot/79gfSQWbB2HCjshx739sWgQV3/Vmb
	jauoA3grgmrLtMlURrG847XR8HQUpL831/qtgWz15Jr4B0AJeCY7u7Wxx8CyDJQRw7meSuspVTi
	VjzUMwFnxhAzq6qXRqOzaF/HB1ChXR/faGgYS
X-Gm-Gg: ASbGncsD50ZK9hu58QDANoiwoyqdeHdO0WEmrJ+zh474j+T7MHPVXgrOZOY/USHKsyW
	Mi3tLpvA/HOGyWRq8rYh22b54Uz4NKIEt3LIzweafZPmrrrZY8KqbhEVaXIqUlj0=
X-Google-Smtp-Source: AGHT+IEVCMp+dIVTCj2HU/9cK7IJ9QdeR+QyO6bdo7UO1KQFbEbVgKXuU/rmsqWinsaEmfxkAe4kWVTeoo6gCoEbDi0=
X-Received: by 2002:a05:6e02:338d:b0:3ce:3873:48d4 with SMTP id
 e9e14a558f8ab-3cfbc8bd1a6mr7822885ab.4.1737735382090; Fri, 24 Jan 2025
 08:16:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250124060638.905-1-ravi.bangoria@amd.com>
In-Reply-To: <20250124060638.905-1-ravi.bangoria@amd.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Jan 2025 08:16:10 -0800
X-Gm-Features: AWEUYZlzVCgKEHjTqxi-aikJ-rq_unQ2-cg5HPl4d-_lvapUQyv1Ym_gakINwsA
Message-ID: <CAP-5=fW4Vzhs7BOeAhom5csRUk+UkCFdc1H9HT4AhMdei8FRKQ@mail.gmail.com>
Subject: Re: [RFC] perf script AMD/IBS: Add scripts to show
 function/instruction level granular profile
To: Ravi Bangoria <ravi.bangoria@amd.com>
Cc: acme@kernel.org, namhyung@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, eranian@google.com, kan.liang@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	bp@alien8.de, mark.rutland@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, santosh.shukla@amd.com, 
	ananth.narayan@amd.com, sandipan.das@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 10:07=E2=80=AFPM Ravi Bangoria <ravi.bangoria@amd.c=
om> wrote:
>
> AMD IBS (Instruction Based Sampling) PMUs provides various insights
> about instruction execution through front-end and back-end units.
> Various perf tools (e.g. precise-mode (:p), perf-mem, perf-c2c etc.)
> uses portion of these information but lot of other insightful data are
> still remains unused by perf. I could not think of any generic perf
> tool where I can consolidate and show all these data, so thought to
> add perf-python scripts.
>
> 1) amd-ibs-op-metrics.py: Print various back-end metric events at
>    function granularity using AMD IBS Op PMU.
> 2) amd-ibs-op-metrics-annotate.py: Print various back-end metric events
>    at instruction granularity using AMD IBS Op PMU.
> 3) amd-ibs-fetch-metrics.py: Print various front-end metric events at
>    function granularity using AMD IBS Fetch PMU.
>    (Annotate script can be added for Fetch PMU as well).
>
> This is still early prototype and thus lot of rough edges. Please feel
> free to report bugs/enhancements if you find these to be useful.
>
> Example usage:
>
> IBS Op:
>
>   # perf record -a -e ibs_op// -c 1000000 --raw-sample -- make
>   [ perf record: Woken up 91 times to write data ]
>   [ perf record: Captured and wrote 49.926 MB perf.data (386979 samples) =
]
>
>   # perf script -s amd-ibs-op-metrics.py -- --sort=3Ddc_miss,l2_miss | he=
ad -15
>   Sort Order: dc_miss,l2_miss
>   Percentages: Cache miss and TLB miss %es are wrt NrLdSt not NrSamples
>                                                |      Nr |      Nr       =
                                                   90th     Avg |  L1Dtlb  =
          L2Dtlb              90th     Avg |          Branch           |
>   function                                     | Samples |    LdSt  DcMis=
s       (%)  L2Miss       (%)  L3Miss       (%)  PctLat     Lat |    Miss  =
     (%)    Miss       (%)  PctLat     Lat |    Miss/Retired       (%) | ds=
o
>   -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------------=
---------------
>   clear_page_erms [K]                          |    6704 |    6059    476=
7 ( 78.68%)    4085 ( 67.42%)    4027 ( 66.46%)       0       0 |      13 (=
  0.21%)       4 (  0.07%)      76      80 |       0/5       (  0.00%) | [k=
ernel.kallsyms]
>   __memmove_avx512_unaligned_erms [U]          |    6274 |    2461    129=
8 ( 52.74%)    1099 ( 44.66%)     725 ( 29.46%)     465     265 |     996 (=
 40.47%)     668 ( 27.14%)     137      88 |      53/2032    (  2.61%) | /u=
sr/lib/x86_64-linux-gnu/libc.so.6
>   __memset_avx512_unaligned_erms [U]           |    2759 |    1343     66=
4 ( 49.44%)     345 ( 25.69%)     143 ( 10.65%)       0       0 |     122 (=
  9.08%)      20 (  1.49%)      94      44 |      20/317     (  6.31%) | /u=
sr/lib/x86_64-linux-gnu/libc.so.6
>   _copy_to_iter [K]                            |     918 |     640     35=
1 ( 54.84%)     231 ( 36.09%)     163 ( 25.47%)    1341     391 |      13 (=
  2.03%)       5 (  0.78%)    1567     369 |       0/3       (  0.00%) | [k=
ernel.kallsyms]
>   pop_scope [U]                                |    1648 |     960     30=
2 ( 31.46%)     258 ( 26.88%)     224 ( 23.33%)    1515     493 |      59 (=
  6.15%)      15 (  1.56%)     782     205 |       6/534     (  1.12%) | /u=
sr/libexec/gcc/x86_64-linux-gnu/13/cc1
>   memset [K]                                   |     776 |     505     18=
5 ( 36.63%)      61 ( 12.08%)      46 (  9.11%)       0       0 |       3 (=
  0.59%)       2 (  0.40%)    4985    2200 |       0/9       (  0.00%) | [k=
ernel.kallsyms]
>   _int_malloc [U]                              |    4534 |    1523     17=
8 ( 11.69%)      43 (  2.82%)       6 (  0.39%)      40      25 |      88 (=
  5.78%)      12 (  0.79%)      84      42 |     103/1141    (  9.03%) | /u=
sr/lib/x86_64-linux-gnu/libc.so.6
>   ggc_internal_alloc [U]                       |    2891 |    1254     13=
8 ( 11.00%)      78 (  6.22%)      45 (  3.59%)     905     267 |      80 (=
  6.38%)       1 (  0.08%)      10      17 |      16/448     (  3.57%) | /u=
sr/libexec/gcc/x86_64-linux-gnu/13/cc1
>   native_queued_spin_lock_slowpath [K]         |   36544 |   17736     12=
5 (  0.70%)     124 (  0.70%)     115 (  0.65%)     695     390 |       0 (=
  0.00%)       0 (  0.00%)       0       0 |      18/17327   (  0.10%) | [k=
ernel.kallsyms]
>   get_mem_cgroup_from_mm [K]                   |     985 |     341     12=
2 ( 35.78%)       9 (  2.64%)       1 (  0.29%)      23      19 |      74 (=
 21.70%)       0 (  0.00%)       7       7 |       0/297     (  0.00%) | [k=
ernel.kallsyms]
>
>   o Default sort order is Nr Samples.
>   o Cache misses and TLB misses percentages are wrt Nr LdSt. Branch
>     miss percentages are wrt branches retired.
>   o Use --help for more detail.
>
> IBS Op Annotate:
>
>   # perf script -s amd-ibs-op-metrics-annotate.py -- --dso=3D/home/ravi/l=
inux/vmlinux --symbol=3Dclear_page_erms
>                                                    |      Nr |           =
                                                       90th     Avg |  L1Dt=
lb            L2Dtlb              90th     Avg |          Branch
>   Disassembly                                      | Samples |    LdSt  D=
cMiss       (%)  L2Miss       (%)  L3Miss       (%)  PctLat     Lat |    Mi=
ss       (%)    Miss       (%)  PctLat     Lat |    Miss/Retired       (%)
>   -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
>   ffffffff821d3e10: mov    $0x1000,%ecx            |       6 |       0   =
    0 (  0.00%)       0 (  0.00%)       0 (  0.00%)       0       0 |      =
 0 (  0.00%)       0 (  0.00%)       0       0 |       0/0       (  0.00%)
>   ffffffff821d3e15: xor    %eax,%eax               |       4 |       0   =
    0 (  0.00%)       0 (  0.00%)       0 (  0.00%)       0       0 |      =
 0 (  0.00%)       0 (  0.00%)       0       0 |       0/0       (  0.00%)
>   ffffffff821d3e17: rep stos %al,%es:(%rdi)        |    6687 |    6059   =
 4767 ( 78.68%)    4085 ( 67.42%)    4027 ( 66.46%)       0       0 |      =
13 (  0.21%)       4 (  0.07%)      76      80 |       0/0       (  0.00%)
>   ffffffff821d3e19: jmp    ffffffff821f27a0        |       7 |       0   =
    0 (  0.00%)       0 (  0.00%)       0 (  0.00%)       0       0 |      =
 0 (  0.00%)       0 (  0.00%)       0       0 |       0/5       (  0.00%)
>   Percentages: Cache miss and TLB miss %es are wrt NrLdSt not NrSamples
>   -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
>
>   o Actual disassembly of the function, so data are not sorted.
>   o Cache misses and TLB misses percentages are wrt Nr LdSt. Branch
>     miss percentages are wrt branches retired.
>
> IBS Fetch:
>
>   # perf record -a -e ibs_fetch// -c 1000000 --raw-sample -- make
>   [ perf record: Woken up 4 times to write data ]
>   [ perf record: Captured and wrote 15.051 MB perf.data (112595 samples) =
]
>
>   # perf script -s amd-ibs-fetch-metrics.py -- --sort=3Dic_miss | head -1=
5
>   Sort Order: ic_miss
>                                                |      Nr |               =
                                                             90th     Avg |=
   Fetch           |  L1Itlb            L2Itlb           |
>   function                                     | Samples |  OcMiss       =
(%)  IcMiss       (%)  L2Miss       (%)  L3Miss       (%)  PctLat     Lat |=
   Abort       (%) |    Miss       (%)    Miss       (%) | dso
>   -----------------------------------------------------------------------=
---------------------------------------------------------------------------=
--------------------------------------------------------------------------
>   _int_malloc [U]                              |    1379 |     407 ( 29.5=
1%)     130 (  9.43%)       1 (  0.07%)       0 (  0.00%)      20      14 |=
       0 (  0.00%) |      11 (  0.80%)       5 (  0.36%) | /usr/lib/x86_64-=
linux-gnu/libc.so.6
>   _cpp_lex_direct [U]                          |    1621 |     133 (  8.2=
0%)      35 (  2.16%)       1 (  0.06%)       0 (  0.00%)      26      16 |=
       0 (  0.00%) |       1 (  0.06%)       1 (  0.06%) | /usr/libexec/gcc=
/x86_64-linux-gnu/13/cc1
>   mas_walk [K]                                 |     115 |      75 ( 65.2=
2%)      33 ( 28.70%)       0 (  0.00%)       0 (  0.00%)      20      14 |=
       0 (  0.00%) |       0 (  0.00%)       0 (  0.00%) | [kernel.kallsyms=
]
>   _int_free [U]                                |     598 |      83 ( 13.8=
8%)      32 (  5.35%)       0 (  0.00%)       0 (  0.00%)      17      13 |=
       0 (  0.00%) |       5 (  0.84%)       3 (  0.50%) | /usr/lib/x86_64-=
linux-gnu/libc.so.6
>   __libc_calloc [U]                            |     202 |      72 ( 35.6=
4%)      31 ( 15.35%)       0 (  0.00%)       0 (  0.00%)      24      27 |=
       0 (  0.00%) |      10 (  4.95%)       6 (  2.97%) | /usr/lib/x86_64-=
linux-gnu/libc.so.6
>   ggc_internal_alloc [U]                       |     516 |     102 ( 19.7=
7%)      29 (  5.62%)       0 (  0.00%)       0 (  0.00%)      19      14 |=
       0 (  0.00%) |       6 (  1.16%)       4 (  0.78%) | /usr/libexec/gcc=
/x86_64-linux-gnu/13/cc1
>   _int_free_merge_chunk [U]                    |     219 |      58 ( 26.4=
8%)      29 ( 13.24%)       0 (  0.00%)       0 (  0.00%)      18      14 |=
       0 (  0.00%) |       4 (  1.83%)       0 (  0.00%) | /usr/lib/x86_64-=
linux-gnu/libc.so.6
>   get_page_from_freelist [K]                   |      68 |      45 ( 66.1=
8%)      28 ( 41.18%)       1 (  1.47%)       0 (  0.00%)      27      23 |=
       0 (  0.00%) |       0 (  0.00%)       0 (  0.00%) | [kernel.kallsyms=
]
>   __handle_mm_fault [K]                        |      70 |      43 ( 61.4=
3%)      26 ( 37.14%)       2 (  2.86%)       0 (  0.00%)      17      15 |=
       0 (  0.00%) |       0 (  0.00%)       0 (  0.00%) | [kernel.kallsyms=
]
>   operand_compare::operand_equal_p [U]         |     364 |      82 ( 22.5=
3%)      26 (  7.14%)       1 (  0.27%)       0 (  0.00%)      18      14 |=
       0 (  0.00%) |       8 (  2.20%)       6 (  1.65%) | /usr/libexec/gcc=
/x86_64-linux-gnu/13/cc1
>   bitmap_set_bit [U]                           |    1917 |      81 (  4.2=
3%)      25 (  1.30%)       0 (  0.00%)       0 (  0.00%)      23      15 |=
       0 (  0.00%) |      10 (  0.52%)       8 (  0.42%) | /usr/libexec/gcc=
/x86_64-linux-gnu/13/cc1
>
>   o Default sort order is Nr Samples.
>   o All percentages are wrt Nr Samples.
>   o Use --help for more detail.

Really nice!

> Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
> ---
>  .../scripts/python/amd-ibs-fetch-metrics.py   | 219 +++++++++++
>  .../python/amd-ibs-op-metrics-annotate.py     | 342 ++++++++++++++++++
>  .../perf/scripts/python/amd-ibs-op-metrics.py | 285 +++++++++++++++
>  3 files changed, 846 insertions(+)
>  create mode 100644 tools/perf/scripts/python/amd-ibs-fetch-metrics.py
>  create mode 100644 tools/perf/scripts/python/amd-ibs-op-metrics-annotate=
.py
>  create mode 100644 tools/perf/scripts/python/amd-ibs-op-metrics.py
>
> diff --git a/tools/perf/scripts/python/amd-ibs-fetch-metrics.py b/tools/p=
erf/scripts/python/amd-ibs-fetch-metrics.py
> new file mode 100644
> index 000000000000..63a91843585f
> --- /dev/null
> +++ b/tools/perf/scripts/python/amd-ibs-fetch-metrics.py
> @@ -0,0 +1,219 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2025 Advanced Micro Devices, Inc.
> +#
> +# Print various metric events at function granularity using AMD IBS Fetc=
h PMU.
> +
> +from __future__ import print_function

I think at some future point we should go through the perf python code
and strip out python2-isms like this. There's no need to add more as
python2 doesn't exist any more.

> +
> +import os
> +import sys

Quick check and these imports didn't appear used.

> +import re
> +import numpy as np
> +from optparse import OptionParser, make_option
> +
> +# To avoid BrokenPipeError when redirecting output to head/less etc.
> +from signal import signal, SIGPIPE, SIG_DFL
> +signal(SIGPIPE,SIG_DFL)
> +
> +# IBS FETCH CTL bit positions
> +IBS_FETCH_CTL_FETCH_LAT_SHIFT       =3D 32
> +IBS_FETCH_CTL_IC_MISS_SHIFT         =3D 51
> +IBS_FETCH_CTL_L1_ITLB_MISS_SHIFT    =3D 55
> +IBS_FETCH_CTL_L2_ITLB_MISS_SHIFT    =3D 56
> +IBS_FETCH_CTL_L2_MISS_SHIFT         =3D 58
> +IBS_FETCH_CTL_OC_MISS_SHIFT         =3D 60
> +IBS_FETCH_CTL_L3_MISS_SHIFT         =3D 61
> +IBS_FETCH_CTL_FETCH_COMP            =3D 50
> +
> +allowed_sort_keys =3D ("nr_samples", "oc_miss", "ic_miss", "l2_miss", "l=
3_miss", "abort", "l1_itlb_miss", "l2_itlb_miss")
> +default_sort_order =3D ("nr_samples",) # Trailing comman is needed for s=
ingle member tuple

Given these are lists of strings, I'm not sure why you're trying to use tup=
les?

> +sort_order =3D default_sort_order
> +options =3D None
> +
> +def parse_cmdline_options():
> +    global sort_order
> +    global options
> +
> +    option_list =3D [
> +        make_option("-s", "--sort", dest=3D"sort",
> +                    help=3D"Comma separated custom sort order. Allowed v=
alues: " +
> +                         ", ".join(allowed_sort_keys))
> +    ]
> +
> +    parser =3D OptionParser(option_list=3Doption_list)
> +    (options, args) =3D parser.parse_args()
> +
> +    if (options.sort):
> +        sort_err =3D 0
> +        temp =3D []
> +        for sort_option in options.sort.split(","):
> +            if sort_option not in allowed_sort_keys:
> +                print("ERROR: Invalid sort option: %s" % sort_option)
> +                print("       Falling back to default sort order.")
> +                sort_err =3D 1
> +                break
> +            else:
> +                temp.append(sort_option)
> +
> +        if (sort_err =3D=3D 0):
> +            sort_order =3D tuple(temp)
> +
> +parse_cmdline_options()
> +
> +data =3D {};
> +
> +def init_data_element(symbol, cpumode, dso):

Consider types and using mypy? Fwiw, I sent this (reviewed but not merged):
https://lore.kernel.org/lkml/20241025172303.77538-1-irogers@google.com/
which adds build support for mypy and pylint, although not enabled by
default given the number of errors.

> +    # XXX: Should the key be dso:symbol ?
> +    data[symbol] =3D {
> +        'nr_samples': 0,
> +        'cpumode': cpumode,
> +
> +        'oc_miss': 0,
> +        'ic_miss': 0,
> +        'l2_miss': 0,
> +        'l3_miss': 0,
> +        'lat': [],
> +
> +        'abort': 0,
> +
> +        'l1_itlb_miss': 0,
> +        'l2_itlb_miss': 0,
> +
> +        # Misc data
> +        'dso': dso,
> +    }
> +
> +def get_cpumode(cpumode):
> +    if (cpumode =3D=3D 1):
> +        return 'K'
> +    if (cpumode =3D=3D 2):
> +        return 'U'
> +    if (cpumode =3D=3D 3):
> +        return 'H'
> +    if (cpumode =3D=3D 4):
> +        return 'GK'
> +    if (cpumode =3D=3D 5):
> +        return 'GU'
> +    return '?'

Perhaps use a dictionary? Something like:
```
def get_cpumode(cpumode: int)- > str:
    modes =3D {
         1: 'K',
         2: 'U',
         3: 'H',
         4: 'GK',
         5: 'GU',
     }
     return modes[cpumode] if cpumode in modes else '?'
```

> +
> +def is_oc_miss(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_OC_MISS_SHIFT) & 0x1
> +
> +def is_ic_miss(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_IC_MISS_SHIFT) & 0x1
> +
> +def is_l2_miss(fetch_ctl):
> +    return ((fetch_ctl >> IBS_FETCH_CTL_L2_MISS_SHIFT) & 0x1 and
> +            (fetch_ctl >> IBS_FETCH_CTL_FETCH_COMP) & 0x1)
> +
> +def is_l3_miss(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_L3_MISS_SHIFT) & 0x1
> +
> +def get_fetch_lat(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_FETCH_LAT_SHIFT) & 0xffff
> +
> +def is_l1_itlb_miss(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_L1_ITLB_MISS_SHIFT) & 0x1
> +
> +def is_l2_itlb_miss(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_L2_ITLB_MISS_SHIFT) & 0x1
> +
> +def is_comp(fetch_ctl):
> +    return (fetch_ctl >> IBS_FETCH_CTL_FETCH_COMP) & 0x1
> +
> +def process_event(param_dict):
> +    raw_buf =3D param_dict['raw_buf']
> +    fetch_ctl =3D int.from_bytes(raw_buf[4:12], "little")
> +
> +    if ('symbol' in param_dict):
> +        symbol =3D param_dict['symbol']
> +        symbol =3D re.sub(r'\(.*\)', '', symbol)
> +    else:
> +        symbol =3D hex(param_dict['sample']['ip'])
> +
> +    if (symbol not in data):
> +        init_data_element(symbol, get_cpumode(param_dict['sample']['cpum=
ode']),
> +                          param_dict['dso'] if 'dso' in param_dict else =
"")
> +
> +    data[symbol]['nr_samples'] +=3D 1
> +
> +    if (is_oc_miss(fetch_ctl)):
> +        data[symbol]['oc_miss'] +=3D 1
> +        if (is_ic_miss(fetch_ctl)):
> +            data[symbol]['ic_miss'] +=3D 1
> +            latency =3D get_fetch_lat(fetch_ctl)
> +            data[symbol]['lat'].append(latency)
> +            if (is_l2_miss(fetch_ctl)):
> +                data[symbol]['l2_miss'] +=3D 1
> +                if (is_l3_miss(fetch_ctl)):
> +                    data[symbol]['l3_miss'] +=3D 1
> +
> +    if (is_l1_itlb_miss(fetch_ctl)):
> +        data[symbol]['l1_itlb_miss'] +=3D 1
> +        if (is_l2_itlb_miss(fetch_ctl)):
> +            data[symbol]['l2_itlb_miss'] +=3D 1
> +
> +    if (is_comp(fetch_ctl) =3D=3D 0):
> +        data[symbol]['abort'] +=3D 1
> +
> +def print_sort_order():
> +    global sort_order
> +    print("Sort Order: " + ",".join(sort_order))
> +
> +def print_header():
> +    print_sort_order()
> +    print("%-45s| %7s | %7s %9s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9=
s | %7s %9s %7s %9s | %s" %
> +          ("","Nr", "", "", "", "", "", "", "", "", "90th", "Avg", "Fetc=
h", "", "L1Itlb", "", "L2Itlb", "", ""))
> +    print("%-45s| %7s | %7s %9s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9=
s | %7s %9s %7s %9s | %s" %
> +          ("function", "Samples", "OcMiss", "(%)", "IcMiss", "(%)", "L2M=
iss", "(%)",
> +           "L3Miss", "(%)", "PctLat", "Lat", "Abort", "(%)", "Miss", "(%=
)", "Miss", "(%)", "dso"))

I believe the more pythonic way these days is to use f-strings:
```
print(f"{'':-45s}| {'Nr':7s} | {'':7s} {'':9s} {'':7s} {'':9s} {'':7s}
{'':9s} {'':7s} {'':9s} {'90th':7s} {'Avg':7s} | {'Fetch':7s} {'':9s}
| {'L1Itlb':7s} {'':9s} {'L2Itlb':7s} {'':9s} |")
print(f"{'function':-45s}| {'Samples':7s} | {'OcMiss':7s} {'(%)':9s}
{'IcMiss':7s} {'(%)':9s} {'L2Miss':7s} {'(%)':9s} {'L3Miss':7s}
{'(%)':9s} {'PctLat':7s} {'Lat':7s} | {'Abort':7s} {'(%)':9s} |
{'Miss':7s} {'(%)':9s} {'Miss':7s} {'(%)':9s} | {'dso':s}")
```
but this all feels a bit error prone. Perhaps add a helper function
with named arguments and let that call print.

> +    print("-------------------------------------------------------------=
----------------"
> +          "-------------------------------------------------------------=
----------------"
> +          "-------------------------------------------------------------=
-----")
> +
> +def print_footer():
> +    print("-------------------------------------------------------------=
----------------"
> +          "-------------------------------------------------------------=
----------------"
> +          "-------------------------------------------------------------=
-----")
> +    print()
> +
> +def sort_fun(item):
> +    global sort_order
> +
> +    temp =3D []
> +    for sort_option in sort_order:
> +        temp.append(item[1][sort_option])
> +    return tuple(temp)
> +
> +def trace_end():
> +    sorted_data =3D sorted(data.items(), key =3D sort_fun, reverse =3D T=
rue)
> +
> +    print_header()
> +
> +    for d in sorted_data:
> +        symbol_cpumode =3D d[0] + " [" + d[1]['cpumode'] + "]"
> +
> +        oc_miss_perc =3D (d[1]['oc_miss'] * 100) / float(d[1]['nr_sample=
s'])
> +        ic_miss_perc =3D (d[1]['ic_miss'] * 100) / float(d[1]['nr_sample=
s'])
> +        l2_miss_perc =3D (d[1]['l2_miss'] * 100) / float(d[1]['nr_sample=
s'])
> +        l3_miss_perc =3D (d[1]['l3_miss'] * 100) / float(d[1]['nr_sample=
s'])
> +        abort_perc =3D (d[1]['abort'] * 100) / float(d[1]['nr_samples'])
> +        l1_itlb_miss_perc =3D (d[1]['l1_itlb_miss'] * 100) / float(d[1][=
'nr_samples'])
> +        l2_itlb_miss_perc =3D (d[1]['l2_itlb_miss'] * 100) / float(d[1][=
'nr_samples'])
> +
> +        avg_lat =3D 0
> +        pct_lat =3D 0
> +        if (d[1]['lat']):
> +            avg_lat =3D sum(d[1]['lat']) / float(len(d[1]['lat']))
> +            pct_lat =3D np.percentile(d[1]['lat'], 90)
> +
> +        print("%-45s| %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%) %7=
d (%6.2f%%)"
> +              " %7d %7d | %7d (%6.2f%%) | %7d (%6.2f%%) %7d (%6.2f%%) | =
%s" %
> +              (symbol_cpumode, d[1]['nr_samples'], d[1]['oc_miss'], oc_m=
iss_perc,
> +               d[1]['ic_miss'], ic_miss_perc, d[1]['l2_miss'], l2_miss_p=
erc,
> +               d[1]['l3_miss'], l3_miss_perc, pct_lat, avg_lat, d[1]['ab=
ort'],
> +               abort_perc, d[1]['l1_itlb_miss'], l1_itlb_miss_perc,
> +               d[1]['l2_itlb_miss'], l2_itlb_miss_perc, d[1]['dso']))

Fwiw, I'm letting gemini convert these to f-strings. If I trust AI this bec=
omes:
```
print(f"{symbol_cpumode:<45s}| {d[1]['nr_samples']:7d} |
{d[1]['oc_miss']:7d} ({oc_miss_perc:6.2f}%) {d[1]['ic_miss']:7d}
({ic_miss_perc:6.2f}%) {d[1]['l2_miss']:7d} ({l2_miss_perc:6.2f}%)
{d[1]['l3_miss']:7d} ({l3_miss_perc:6.2f}%) {pct_lat:7d} {avg_lat:7d}
| {d[1]['abort']:7d} ({abort_perc:6.2f}%) | {d[1]['l1_itlb_miss']:7d}
({l1_itlb_miss_perc:6.2f}%) {d[1]['l2_itlb_miss']:7d}
({l2_itlb_miss_perc:6.2f}%) | {d[1]['dso']:s}")
```
But given that keeping all these prints in sync is error prone, I
think a helper function is the way to go.

> +
> +    print_footer()
> diff --git a/tools/perf/scripts/python/amd-ibs-op-metrics-annotate.py b/t=
ools/perf/scripts/python/amd-ibs-op-metrics-annotate.py
> new file mode 100644
> index 000000000000..beef6a302258
> --- /dev/null
> +++ b/tools/perf/scripts/python/amd-ibs-op-metrics-annotate.py
> @@ -0,0 +1,342 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2025 Advanced Micro Devices, Inc.
> +#
> +# Print various metric events at instruction granularity using AMD IBS O=
p PMU.
> +
> +from __future__ import print_function

Feedback here generally matches that above.

> +import os
> +import sys
> +import re
> +import numpy as np
> +from optparse import OptionParser, make_option
> +import subprocess
> +
> +# To avoid BrokenPipeError when redirecting output to head/less etc.
> +from signal import signal, SIGPIPE, SIG_DFL
> +signal(SIGPIPE,SIG_DFL)
> +
> +# IBS OP DATA bit positions
> +IBS_OPDATA_BR_TAKEN_SHIFT       =3D 35
> +IBS_OPDATA_BR_MISS_SHIFT        =3D 36
> +IBS_OPDATA_BR_RET_SHIFT         =3D 37
> +
> +# IBS OP DATA2 bit positions
> +IBS_OPDATA2_DATA_SRC_LOW_SHIFT  =3D 0
> +IBS_OPDATA2_DATA_SRC_HIGH_SHIFT =3D 6
> +
> +# IBS OP DATA3 bit positions
> +IBS_OPDATA3_LDOP_SHIFT          =3D 0
> +IBS_OPDATA3_STOP_SHIFT          =3D 1
> +IBS_OPDATA3_L1_DTLB_MISS_SHIFT  =3D 2
> +IBS_OPDATA3_L2_DTLB_MISS_SHIFT  =3D 3
> +IBS_OPDATA3_DC_MISS_SHIFT       =3D 7
> +IBS_OPDATA3_L2_MISS_SHIFT       =3D 20
> +IBS_OPDATA3_DC_MISS_LAT_SHIFT   =3D 32
> +IBS_OPDATA3_PHYADDR_VAL_SHIFT   =3D 18
> +IBS_OPDATA3_DTLB_MISS_LAT_SHIFT =3D 48
> +
> +INSN_SIZE_INVAL =3D -1
> +
> +annotate_symbol =3D None
> +annodate_dso =3D None

annotate_dso?

> +
> +#total_samples =3D 0
> +data =3D []
> +
> +def parse_cmdline_options():
> +    global annotate_symbol
> +    global annodate_dso
> +    global sort_order
> +    global options
> +
> +    option_list =3D [
> +        make_option("-d", "--dso", dest=3D"dso",
> +                    help=3D"Path of binary or a library the symbol belon=
gs to"),
> +        make_option("-s", "--symbol", dest=3D"symbol",
> +                    help=3D"Symbol name")
> +    ]
> +
> +    parser =3D OptionParser(option_list=3Doption_list)
> +    (options, args) =3D parser.parse_args()
> +
> +    if (options.dso):
> +        annodate_dso =3D options.dso
> +    else:
> +        print("Error: Invalid dso path.\n")
> +        exit()
> +
> +    if (options.symbol):
> +        annotate_symbol =3D options.symbol
> +    else:
> +        print("Error: Invalid symbol.\n")
> +        exit()
> +
> +def disassemble_symbol(symbol, dso):
> +    global data
> +
> +    readelf =3D subprocess.Popen(["readelf", "-WsC", "--sym-base=3D16", =
dso],
> +                               stdout=3Dsubprocess.PIPE, text=3DTrue)
> +    grep =3D subprocess.Popen(["grep", "-w", symbol], stdin=3Dreadelf.st=
dout,
> +                            stdout=3Dsubprocess.PIPE, text=3DTrue)
> +    output, error =3D grep.communicate()

Perhaps the pyelftools would be better here?
https://eli.thegreenplace.net/2012/01/06/pyelftools-python-library-for-pars=
ing-elf-and-dwarf

> +
> +    if (error !=3D None):
> +        print("Error reading symbol table data for '%s'" % (symbol))
> +        exit()
> +
> +    match =3D re.search(r'([^\s]+):\s([^\s]+)\s([^\s]+)\s([^\s]+)\s+([^\=
s]+)\s([^\s]+)\s+([^\s]+)\s([^\s]+)', output)
> +    if (match =3D=3D None):
> +        print("Can not find start address / size of '%s'" % (symbol))
> +        exit()
> +
> +    start_addr =3D int(match.group(2), 16)
> +    size =3D int(match.group(3), 16)
> +    stop_addr =3D start_addr + size
> +
> +    objdump =3D subprocess.run(["objdump", "-d", "-C", "--no-show-raw-in=
sn",
> +                              "--start-address", hex(start_addr), "--sto=
p-address",
> +                              hex(stop_addr), dso], capture_output =3D T=
rue, text =3D True)
> +    if (objdump.returncode =3D=3D 1):
> +        print("Error dissassembling '%s'" % (symbol))
> +        exit()
> +
> +    disasm =3D objdump.stdout.split("\n")
> +
> +    header_lines =3D 1
> +    # hex(<number>) will convert <number> to hex with 0x prefix. But obj=
dump
> +    # addresses skips 0x, so use alternative format(<number>, 'x') which
> +    # converts <number> to hex without 0x prefix.
> +    start_addr_regex =3D r"^\s*" + format(start_addr, 'x') + r":"
> +    idx =3D 0;
> +    for line in disasm:
> +        if (header_lines and (not re.match(start_addr_regex, line))):
> +            continue
> +        header_lines =3D 0
> +
> +        match =3D re.search(r'\s*([^:]+):[\t\s]+(.*)', line)
> +        if (match =3D=3D None):
> +            continue
> +
> +        addr =3D int(match.group(1), 16)
> +        offset =3D addr - start_addr
> +        insn =3D re.sub(r'(<.*>)|(\s+#.*)|(\s+$)', '', match.group(2))
> +
> +        data.append({
> +            'addr': addr,
> +            'insn_size': INSN_SIZE_INVAL,
> +            'symoff': offset,
> +            'insn': insn,
> +
> +            'nr_samples': 0,
> +
> +            # Branch data
> +            'br_ret': 0,
> +            'br_miss': 0,
> +            'br_taken': 0,
> +            'br_fallth': 0,
> +
> +            # Load / Store data
> +            'ld_cnt': 0, # LdOp=3D1 && StOp=3D1 are only added int ld_cn=
t
> +            'st_cnt': 0,
> +            'dc_miss': 0,
> +            'l2_miss': 0,
> +            'l3_miss': 0,
> +            # XXX: Breakdown beyond L3 ?
> +            'dc_miss_lat': [],
> +
> +            'l1_dtlb_miss': 0,
> +            'l2_dtlb_miss': 0,
> +            'dtlb_miss_lat': [],
> +        })
> +
> +        if (idx > 0):
> +            data[idx - 1]['insn_size'] =3D (data[idx]['addr'] -
> +                                          data[idx - 1]['addr']);
> +        idx +=3D 1
> +
> +parse_cmdline_options()
> +disassemble_symbol(annotate_symbol, annodate_dso)
> +
> +def get_cpumode(cpumode):
> +    if (cpumode =3D=3D 1):
> +        return 'K'
> +    if (cpumode =3D=3D 2):
> +        return 'U'
> +    if (cpumode =3D=3D 3):
> +        return 'H'
> +    if (cpumode =3D=3D 4):
> +        return 'GK'
> +    if (cpumode =3D=3D 5):
> +        return 'GU'
> +    return '?'
> +
> +def is_br_ret(op_data):
> +    return (op_data >> IBS_OPDATA_BR_RET_SHIFT) & 0x1
> +
> +def is_br_miss(op_data):
> +    return (op_data >> IBS_OPDATA_BR_MISS_SHIFT) & 0x1
> +
> +def is_br_taken(op_data):
> +    return (op_data >> IBS_OPDATA_BR_TAKEN_SHIFT) & 0x1
> +
> +def is_ld_op(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_LDOP_SHIFT) & 0x1
> +
> +def is_st_op(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_STOP_SHIFT) & 0x1
> +
> +def is_dc_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_DC_MISS_SHIFT) & 0x1
> +
> +def get_dc_miss_lat(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_DC_MISS_LAT_SHIFT) & 0xffff
> +
> +def is_l2_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_L2_MISS_SHIFT) & 0x1
> +
> +def get_data_src(op_data2):
> +    data_src_high =3D (op_data2 >> IBS_OPDATA2_DATA_SRC_HIGH_SHIFT) & 0x=
3
> +    data_src_low =3D (op_data2 >> IBS_OPDATA2_DATA_SRC_LOW_SHIFT) & 0x7
> +    return (data_src_high << 3) | data_src_low
> +
> +def is_phy_addr_val(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_PHYADDR_VAL_SHIFT) & 0x1
> +
> +def is_l1_dtlb_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_L1_DTLB_MISS_SHIFT) & 0x1
> +
> +def get_dtlb_miss_lat(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_DTLB_MISS_LAT_SHIFT) & 0xffff
> +
> +def is_l2_dtlb_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_L2_DTLB_MISS_SHIFT) & 0x1
> +
> +def process_event(param_dict):
> +    global data
> +
> +    raw_buf =3D param_dict['raw_buf']
> +    op_data =3D int.from_bytes(raw_buf[20:28], "little")
> +    op_data2 =3D int.from_bytes(raw_buf[28:36], "little")
> +    op_data3 =3D int.from_bytes(raw_buf[36:44], "little")
> +
> +    if ('symbol' not in param_dict):
> +        return
> +
> +    symbol =3D param_dict['symbol']
> +    symbol =3D re.sub(r'\(.*\)', '', symbol)
> +
> +    if (symbol !=3D annotate_symbol):
> +        return
> +
> +    symoff =3D 0
> +    if ('symoff' in param_dict):
> +        symoff =3D param_dict['symoff']
> +
> +    idx =3D 0
> +    for d in data:
> +        if (d['symoff'] <=3D symoff and
> +            (d['insn_size'] =3D=3D INSN_SIZE_INVAL or
> +             d['symoff'] + d['insn_size'] > symoff)):
> +            break
> +        else:
> +            idx +=3D 1
> +
> +    d =3D data[idx]
> +
> +    d['nr_samples'] +=3D 1
> +    #total_samples +=3D 1
> +
> +    if (is_br_ret(op_data)):
> +        d['br_ret'] +=3D 1
> +        if (is_br_miss(op_data)):
> +            d['br_miss'] +=3D 1
> +        if (is_br_taken(op_data)):
> +            d['br_taken'] +=3D 1
> +
> +    ld_st =3D 0
> +    if (is_ld_op(op_data3)):
> +        d['ld_cnt'] +=3D 1
> +        ld_st =3D 1
> +    elif (is_st_op(op_data3)):
> +        d['st_cnt'] +=3D 1
> +        ld_st =3D 1
> +
> +    if (ld_st =3D=3D 1):
> +        if (is_dc_miss(op_data3)):
> +            d['dc_miss'] +=3D 1
> +            dc_miss_lat =3D get_dc_miss_lat(op_data3)
> +            d['dc_miss_lat'].append(dc_miss_lat)
> +            if (is_l2_miss(op_data3)):
> +                d['l2_miss'] +=3D 1
> +                if (get_data_src(op_data2) > 1):
> +                    d['l3_miss'] +=3D 1
> +        if (is_phy_addr_val(op_data3)):
> +            if (is_l1_dtlb_miss(op_data3)):
> +                d['l1_dtlb_miss'] +=3D 1
> +                dtlb_miss_lat =3D get_dtlb_miss_lat(op_data3)
> +                d['dtlb_miss_lat'].append(dtlb_miss_lat)
> +                if (is_l2_dtlb_miss(op_data3)):
> +                    d['l2_dtlb_miss'] +=3D 1
> +
> +def print_header():
> +    addr_width =3D len(format(data[0]['addr'], 'x')) + 32
> +    pattern =3D ("%-" + str(addr_width) + "s | %7s | %7s %7s %9s %7s %9s=
 %7s %9s %7s"
> +               " %7s | %7s %9s %7s %9s %7s %7s | %15s %9s")
> +    print(pattern % ("", "Nr", "", "", "", "", "", "", "", "90th", "Avg"=
, "L1Dtlb", "",
> +                    "L2Dtlb", "", "90th", "Avg", "Branch", ""))
> +    print(pattern % ("Disassembly", "Samples", "LdSt", "DcMiss", "(%)", =
"L2Miss", "(%)",
> +                     "L3Miss", "(%)", "PctLat", "Lat", "Miss", "(%)", "M=
iss", "(%)",
> +                     "PctLat", "Lat", "Miss/Retired", "(%)"))
> +    print("-------------------------------------------------------------=
-------------------------"
> +          "-------------------------------------------------------------=
-------------------------"
> +          "------------------------------------------------")
> +
> +def print_footer():
> +    print("Percentages: Cache miss and TLB miss %es are wrt NrLdSt not N=
rSamples")
> +    print("-------------------------------------------------------------=
-------------------------"
> +          "-------------------------------------------------------------=
-------------------------"
> +          "------------------------------------------------")
> +def trace_end():
> +    global data
> +
> +    print_header()
> +
> +    for d in data:
> +        dc_miss_perc =3D 0
> +        l2_miss_perc =3D 0
> +        l3_miss_perc =3D 0
> +        l1_dtlb_miss_perc =3D 0
> +        l2_dtlb_miss_perc =3D 0
> +        avg_dc_miss_lat =3D 0
> +        pct_dc_miss_lat =3D 0
> +        avg_dtlb_miss_lat =3D 0
> +        pct_dtlb_miss_lat =3D 0
> +        if (d['ld_cnt'] or d['st_cnt']):
> +            dc_miss_perc =3D (d['dc_miss'] * 100) / float(d['ld_cnt'] + =
d['st_cnt'])
> +            l2_miss_perc =3D (d['l2_miss'] * 100) / float(d['ld_cnt'] + =
d['st_cnt'])
> +            l3_miss_perc =3D (d['l3_miss'] * 100) / float(d['ld_cnt'] + =
d['st_cnt'])
> +            l1_dtlb_miss_perc =3D (d['l1_dtlb_miss'] * 100) / float(d['l=
d_cnt'] + d['st_cnt'])
> +            l2_dtlb_miss_perc =3D (d['l2_dtlb_miss'] * 100) / float(d['l=
d_cnt'] + d['st_cnt'])
> +            if (d['dc_miss_lat']):
> +                avg_dc_miss_lat =3D sum(d['dc_miss_lat']) / float(len(d[=
'dc_miss_lat']))
> +                pct_dc_miss_lat =3D np.percentile(d['dc_miss_lat'], 90)
> +            if (d['dtlb_miss_lat']):
> +                avg_dtlb_miss_lat =3D sum(d['dtlb_miss_lat']) / float(le=
n(d['dtlb_miss_lat']))
> +                pct_dtlb_miss_lat =3D np.percentile(d['dtlb_miss_lat'], =
90)
> +
> +        br_miss_perc =3D 0
> +        if (d['br_ret']):
> +            br_miss_perc =3D (d['br_miss'] * 100) / float(d['br_ret'])
> +
> +        print("%x: %-30s | %7d | %7d %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6=
.2f%%)"
> +              " %7d %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d %7d | %7d/%-7d=
 (%6.2f%%)" %
> +              (d['addr'], d['insn'], d['nr_samples'], d['ld_cnt'] + d['s=
t_cnt'],
> +               d['dc_miss'], dc_miss_perc, d['l2_miss'], l2_miss_perc,
> +               d['l3_miss'], l3_miss_perc, pct_dc_miss_lat, avg_dc_miss_=
lat,
> +               d['l1_dtlb_miss'], l1_dtlb_miss_perc, d['l2_dtlb_miss'],
> +               l2_dtlb_miss_perc, pct_dtlb_miss_lat, avg_dtlb_miss_lat,
> +               d['br_miss'], d['br_ret'], br_miss_perc))
> +
> +    print_footer()
> diff --git a/tools/perf/scripts/python/amd-ibs-op-metrics.py b/tools/perf=
/scripts/python/amd-ibs-op-metrics.py
> new file mode 100644
> index 000000000000..67c0b2f9d79a
> --- /dev/null
> +++ b/tools/perf/scripts/python/amd-ibs-op-metrics.py
> @@ -0,0 +1,285 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2025 Advanced Micro Devices, Inc.
> +#
> +# Print various metric events at function granularity using AMD IBS Op P=
MU.
> +
> +from __future__ import print_function

Again similar feedback to the other files.

Thanks,
Ian

> +
> +import os
> +import sys
> +import re
> +import numpy as np
> +from optparse import OptionParser, make_option
> +
> +# To avoid BrokenPipeError when redirecting output to head/less etc.
> +from signal import signal, SIGPIPE, SIG_DFL
> +signal(SIGPIPE,SIG_DFL)
> +
> +# IBS OP DATA bit positions
> +IBS_OPDATA_BR_TAKEN_SHIFT       =3D 35
> +IBS_OPDATA_BR_MISS_SHIFT        =3D 36
> +IBS_OPDATA_BR_RET_SHIFT         =3D 37
> +
> +# IBS OP DATA2 bit positions
> +IBS_OPDATA2_DATA_SRC_LOW_SHIFT  =3D 0
> +IBS_OPDATA2_DATA_SRC_HIGH_SHIFT =3D 6
> +
> +# IBS OP DATA3 bit positions
> +IBS_OPDATA3_LDOP_SHIFT          =3D 0
> +IBS_OPDATA3_STOP_SHIFT          =3D 1
> +IBS_OPDATA3_L1_DTLB_MISS_SHIFT  =3D 2
> +IBS_OPDATA3_L2_DTLB_MISS_SHIFT  =3D 3
> +IBS_OPDATA3_DC_MISS_SHIFT       =3D 7
> +IBS_OPDATA3_L2_MISS_SHIFT       =3D 20
> +IBS_OPDATA3_DC_MISS_LAT_SHIFT   =3D 32
> +IBS_OPDATA3_PHYADDR_VAL_SHIFT   =3D 18
> +IBS_OPDATA3_DTLB_MISS_LAT_SHIFT =3D 48
> +
> +allowed_sort_keys =3D ("nr_samples", "dc_miss", "l2_miss", "l3_miss", "l=
1_dtlb_miss", "l2_dtlb_miss", "br_miss")
> +default_sort_order =3D ("nr_samples",) # Trailing comman is needed for s=
ingle member tuple
> +sort_order =3D default_sort_order
> +options =3D None
> +
> +def parse_cmdline_options():
> +    global sort_order
> +    global options
> +
> +    option_list =3D [
> +        make_option("-s", "--sort", dest=3D"sort",
> +                    help=3D"Comma separated custom sort order. Allowed v=
alues: " +
> +                         ", ".join(allowed_sort_keys))
> +    ]
> +
> +    parser =3D OptionParser(option_list=3Doption_list)
> +    (options, args) =3D parser.parse_args()
> +
> +    if (options.sort):
> +        sort_err =3D 0
> +        temp =3D []
> +        for sort_option in options.sort.split(","):
> +            if sort_option not in allowed_sort_keys:
> +                print("ERROR: Invalid sort option: %s" % sort_option)
> +                print("       Falling back to default sort order.")
> +                sort_err =3D 1
> +                break
> +            else:
> +                temp.append(sort_option)
> +
> +        if (sort_err =3D=3D 0):
> +            sort_order =3D tuple(temp)
> +
> +parse_cmdline_options()
> +
> +# Final data
> +data =3D {}
> +
> +def init_data_element(symbol, cpumode, dso):
> +    # XXX: Should the key be dso:symbol ?
> +    data[symbol] =3D {
> +        'nr_samples': 0,
> +        'cpumode': cpumode,
> +
> +        # Branch data
> +        'br_ret': 0,
> +        'br_miss': 0,
> +        'br_taken': 0,
> +        'br_fallth': 0,
> +
> +        # Load / Store data
> +        'ld_cnt': 0, # LdOp=3D1 && StOp=3D1 are only added int ld_cnt
> +        'st_cnt': 0,
> +        'dc_miss': 0,
> +        'l2_miss': 0,
> +        'l3_miss': 0,
> +        # XXX: Breakdown beyond L3 ?
> +        'dc_miss_lat': [],
> +
> +        'l1_dtlb_miss': 0,
> +        'l2_dtlb_miss': 0,
> +        'dtlb_miss_lat': [],
> +
> +        # Misc data
> +        'dso': dso,
> +    }
> +
> +def get_cpumode(cpumode):
> +    if (cpumode =3D=3D 1):
> +        return 'K'
> +    if (cpumode =3D=3D 2):
> +        return 'U'
> +    if (cpumode =3D=3D 3):
> +        return 'H'
> +    if (cpumode =3D=3D 4):
> +        return 'GK'
> +    if (cpumode =3D=3D 5):
> +        return 'GU'
> +    return '?'
> +
> +def is_br_ret(op_data):
> +    return (op_data >> IBS_OPDATA_BR_RET_SHIFT) & 0x1
> +
> +def is_br_miss(op_data):
> +    return (op_data >> IBS_OPDATA_BR_MISS_SHIFT) & 0x1
> +
> +def is_br_taken(op_data):
> +    return (op_data >> IBS_OPDATA_BR_TAKEN_SHIFT) & 0x1
> +
> +def is_ld_op(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_LDOP_SHIFT) & 0x1
> +
> +def is_st_op(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_STOP_SHIFT) & 0x1
> +
> +def is_dc_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_DC_MISS_SHIFT) & 0x1
> +
> +def get_dc_miss_lat(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_DC_MISS_LAT_SHIFT) & 0xffff
> +
> +def is_l2_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_L2_MISS_SHIFT) & 0x1
> +
> +def get_data_src(op_data2):
> +    data_src_high =3D (op_data2 >> IBS_OPDATA2_DATA_SRC_HIGH_SHIFT) & 0x=
3
> +    data_src_low =3D (op_data2 >> IBS_OPDATA2_DATA_SRC_LOW_SHIFT) & 0x7
> +    return (data_src_high << 3) | data_src_low
> +
> +def is_phy_addr_val(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_PHYADDR_VAL_SHIFT) & 0x1
> +
> +def is_l1_dtlb_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_L1_DTLB_MISS_SHIFT) & 0x1
> +
> +def get_dtlb_miss_lat(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_DTLB_MISS_LAT_SHIFT) & 0xffff
> +
> +def is_l2_dtlb_miss(op_data3):
> +    return (op_data3 >> IBS_OPDATA3_L2_DTLB_MISS_SHIFT) & 0x1
> +
> +def process_event(param_dict):
> +    raw_buf =3D param_dict['raw_buf']
> +    op_data =3D int.from_bytes(raw_buf[20:28], "little")
> +    op_data2 =3D int.from_bytes(raw_buf[28:36], "little")
> +    op_data3 =3D int.from_bytes(raw_buf[36:44], "little")
> +
> +    if ('symbol' in param_dict):
> +        symbol =3D param_dict['symbol']
> +        symbol =3D re.sub(r'\(.*\)', '', symbol)
> +    else:
> +        symbol =3D hex(param_dict['sample']['ip'])
> +
> +    if (symbol not in data):
> +        init_data_element(symbol, get_cpumode(param_dict['sample']['cpum=
ode']),
> +                          param_dict['dso'] if 'dso' in param_dict else =
"")
> +
> +    data[symbol]['nr_samples'] +=3D 1
> +
> +    if (is_br_ret(op_data)):
> +        data[symbol]['br_ret'] +=3D 1
> +        if (is_br_miss(op_data)):
> +            data[symbol]['br_miss'] +=3D 1
> +        if (is_br_taken(op_data)):
> +            data[symbol]['br_taken'] +=3D 1
> +
> +    ld_st =3D 0
> +    if (is_ld_op(op_data3)):
> +        data[symbol]['ld_cnt'] +=3D 1
> +        ld_st =3D 1
> +    elif (is_st_op(op_data3)):
> +        data[symbol]['st_cnt'] +=3D 1
> +        ld_st =3D 1
> +
> +    if (ld_st =3D=3D 1):
> +        if (is_dc_miss(op_data3)):
> +            data[symbol]['dc_miss'] +=3D 1
> +            dc_miss_lat =3D get_dc_miss_lat(op_data3)
> +            data[symbol]['dc_miss_lat'].append(dc_miss_lat)
> +            if (is_l2_miss(op_data3)):
> +                data[symbol]['l2_miss'] +=3D 1
> +                if (get_data_src(op_data2) > 1):
> +                    data[symbol]['l3_miss'] +=3D 1
> +        if (is_phy_addr_val(op_data3)):
> +            if (is_l1_dtlb_miss(op_data3)):
> +                data[symbol]['l1_dtlb_miss'] +=3D 1
> +                dtlb_miss_lat =3D get_dtlb_miss_lat(op_data3)
> +                data[symbol]['dtlb_miss_lat'].append(dtlb_miss_lat)
> +                if (is_l2_dtlb_miss(op_data3)):
> +                    data[symbol]['l2_dtlb_miss'] +=3D 1
> +
> +def print_sort_order():
> +    global sort_order
> +    print("Sort Order: " + ",".join(sort_order))
> +
> +def print_header():
> +    print_sort_order()
> +    print("Percentages: Cache miss and TLB miss %es are wrt NrLdSt not N=
rSamples")
> +    print("%-45s| %7s | %7s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9s %7=
s %9s %7s %7s | %15s %9s | %s" %
> +          ("","Nr", "Nr", "", "", "", "", "", "", "90th", "Avg", "L1Dtlb=
", "", "L2Dtlb", "", "90th",
> +           "Avg", "Branch", "", ""))
> +    print("%-45s| %7s | %7s %7s %9s %7s %9s %7s %9s %7s %7s | %7s %9s %7=
s %9s %7s %7s | %15s %9s | %s" %
> +          ("function","Samples", "LdSt", "DcMiss", "(%)", "L2Miss", "(%)=
", "L3Miss", "(%)",
> +           "PctLat", "Lat", "Miss", "(%)", "Miss", "(%)", "PctLat", "Lat=
", "Miss/Retired", "(%)", "dso"))
> +    print("-------------------------------------------------------------=
-------------------------"
> +          "-------------------------------------------------------------=
-------------------------"
> +          "-------------------------------------------------------------=
---")
> +
> +def print_footer():
> +    print("-------------------------------------------------------------=
-------------------------"
> +          "-------------------------------------------------------------=
-------------------------"
> +          "-------------------------------------------------------------=
---")
> +    print()
> +
> +def sort_fun(item):
> +    global sort_order
> +
> +    temp =3D []
> +    for sort_option in sort_order:
> +        temp.append(item[1][sort_option])
> +    return tuple(temp)
> +
> +def trace_end():
> +    sorted_data =3D sorted(data.items(), key =3D sort_fun, reverse =3D T=
rue)
> +
> +    print_header()
> +
> +    for d in sorted_data:
> +        symbol_cpumode =3D d[0] + " [" + d[1]['cpumode'] + "]"
> +
> +        dc_miss_perc =3D 0
> +        l2_miss_perc =3D 0
> +        l3_miss_perc =3D 0
> +        l1_dtlb_miss_perc =3D 0
> +        l2_dtlb_miss_perc =3D 0
> +        avg_dc_miss_lat =3D 0
> +        pct_dc_miss_lat =3D 0
> +        avg_dtlb_miss_lat =3D 0
> +        pct_dtlb_miss_lat =3D 0
> +        if (d[1]['ld_cnt'] or d[1]['st_cnt']):
> +            dc_miss_perc =3D (d[1]['dc_miss'] * 100) / float(d[1]['ld_cn=
t'] + d[1]['st_cnt'])
> +            l2_miss_perc =3D (d[1]['l2_miss'] * 100) / float(d[1]['ld_cn=
t'] + d[1]['st_cnt'])
> +            l3_miss_perc =3D (d[1]['l3_miss'] * 100) / float(d[1]['ld_cn=
t'] + d[1]['st_cnt'])
> +            l1_dtlb_miss_perc =3D (d[1]['l1_dtlb_miss'] * 100) / float(d=
[1]['ld_cnt'] + d[1]['st_cnt'])
> +            l2_dtlb_miss_perc =3D (d[1]['l2_dtlb_miss'] * 100) / float(d=
[1]['ld_cnt'] + d[1]['st_cnt'])
> +            if (d[1]['dc_miss_lat']):
> +                avg_dc_miss_lat =3D sum(d[1]['dc_miss_lat']) / float(len=
(d[1]['dc_miss_lat']))
> +                pct_dc_miss_lat =3D np.percentile(d[1]['dc_miss_lat'], 9=
0)
> +            if (d[1]['dtlb_miss_lat']):
> +                avg_dtlb_miss_lat =3D sum(d[1]['dtlb_miss_lat']) / float=
(len(d[1]['dtlb_miss_lat']))
> +                pct_dtlb_miss_lat =3D np.percentile(d[1]['dtlb_miss_lat'=
], 90)
> +
> +        br_miss_perc =3D 0
> +        if (d[1]['br_ret']):
> +            br_miss_perc =3D (d[1]['br_miss'] * 100) / float(d[1]['br_re=
t'])
> +
> +        print("%-45s| %7d | %7d %7d (%6.2f%%) %7d (%6.2f%%) %7d (%6.2f%%=
)"
> +              " %7d %7d | %7d (%6.2f%%) %7d (%6.2f%%) %7d %7d | %7d/%-7d=
 (%6.2f%%) | %s" %
> +              (symbol_cpumode, d[1]['nr_samples'],
> +              d[1]['ld_cnt'] + d[1]['st_cnt'], d[1]['dc_miss'], dc_miss_=
perc,
> +              d[1]['l2_miss'], l2_miss_perc, d[1]['l3_miss'], l3_miss_pe=
rc,
> +              pct_dc_miss_lat, avg_dc_miss_lat, d[1]['l1_dtlb_miss'],
> +              l1_dtlb_miss_perc, d[1]['l2_dtlb_miss'], l2_dtlb_miss_perc=
,
> +              pct_dtlb_miss_lat, avg_dtlb_miss_lat,
> +              d[1]['br_miss'], d[1]['br_ret'], br_miss_perc, d[1]['dso']=
))
> +
> +    print_footer()
> --
> 2.43.0
>
