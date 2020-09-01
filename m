From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH] perf c2c report: count remote loads correctly
Date: Tue, 1 Sep 2020 14:28:23 -0300
Message-ID: <20200901172823.GF1424523@kernel.org>
References: <6282053a-d813-8638-531d-56e852d582a2@foss.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <6282053a-d813-8638-531d-56e852d582a2@foss.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Al Grant <al.grant@foss.arm.com>, Jiri Olsa <jolsa@kernel.org>, Joe Mario <jmario@redhat.com>
Cc: David Ahern <dsahern@gmail.com>, Don Zickus <dzickus@redhat.com>, Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org, andi.kleen@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Aug 20, 2020 at 02:48:58PM +0100, Al Grant escreveu:
> "perf c2c report" can show load counts for cache lines, which don't match
> the actual number of load samples, e.g. as displayed by "perf script". This
> is specific to "Remote Any cache hit" loads. Firstly, these loads are
> counted twice, because if the "remote" flag is set, rmt_dram is always
> incremented, and then rmt_hitm or rmt_hit may also be incremented. These are
> then totalled in the overall load count, causing double-counting. "Remote
> Any cache hit" should not increment rmt_dram. Instead, use LVLNUM to
> discriminate between remote cache and remote DRAM. Also, non-HITM loads to
> remote cache are not being counted as hits (the last column in the cache
> line report is zero), when the SNOOP field is unset. This causes
> under-reporting of the load count. The code currently only increments
> counters if the SNOOP field is set to either HIT or HITM. Instead, for
> access to remote cache (as indicated by LVLNUM), increment rmt_hitm if
> SNOOP=HITM, increment rmt_hit otherwise.

Hi Joe, Jiri, can you please take a look and provide your Acked-by or
better, Reviewed-by?

- Arnaldo
 
> From: Al Grant <al.grant@arm.com>

Al, please provide Signed-off-by: lines for code your write,

Thanks,

- Arnaldo
 
>  tools/perf/util/mem-events.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
> index ea0af0bc4314..c6bb86fd4330 100644
> --- a/tools/perf/util/mem-events.c
> +++ b/tools/perf/util/mem-events.c
> @@ -332,11 +332,13 @@ int c2c_decode_stats(struct c2c_stats *stats, struct
> mem_info *mi)
>         u64 lvl    = data_src->mem_lvl;
>         u64 snoop  = data_src->mem_snoop;
>         u64 lock   = data_src->mem_lock;
> +       u64 lvlnum = data_src->mem_lvl_num;
>         /*
>          * Skylake might report unknown remote level via this
>          * bit, consider it when evaluating remote HITMs.
>          */
>         bool mrem  = data_src->mem_remote;
> +       bool mmem = (lvlnum == PERF_MEM_LVLNUM_RAM || lvlnum ==
> PERF_MEM_LVLNUM_PMEM);
>         int err = 0;
> 
>  #define HITM_INC(__f)          \
> @@ -383,7 +385,7 @@ do {                                \
> 
>                         if ((lvl & P(LVL, REM_RAM1)) ||
>                             (lvl & P(LVL, REM_RAM2)) ||
> -                            mrem) {
> +                            (mrem && mmem)) {
>                                 stats->rmt_dram++;
>                                 if (snoop & P(SNOOP, HIT))
>                                         stats->ld_shared++;
> @@ -394,11 +396,11 @@ do {                              \
> 
>                 if ((lvl & P(LVL, REM_CCE1)) ||
>                     (lvl & P(LVL, REM_CCE2)) ||
> -                    mrem) {
> -                       if (snoop & P(SNOOP, HIT))
> -                               stats->rmt_hit++;
> -                       else if (snoop & P(SNOOP, HITM))
> +                    (mrem && !mmem)) {
> +                       if (snoop & P(SNOOP, HITM))
>                                 HITM_INC(rmt_hitm);
> +                       else
> +                               stats->rmt_hit++;
>                 }
> 
>                 if ((lvl & P(LVL, MISS)))

-- 

- Arnaldo
