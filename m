Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4811431E11C
	for <linux-perf-users@vger.kernel.org>; Fri,  9 Jan 2026 23:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001835; cv=pass; b=bf3E8N9JbWzxdrPydroxmMCiG9dx4aDdMcsLcUgfQ3eA3dZbscdZOkLop7vRBsDf9frG5wYMBw9Agcdq2G6BqX+j4rE8MpaOMdT4d34IU1wruAo2xhA6lvTvGBQA/9KjjPYSDeTRCA9TBa8mXXdfsfvcP8DyFge1HeR273Ce1kI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001835; c=relaxed/simple;
	bh=MbkTNvotDzpb2HDOhcxbXQEnvbWlJaUrO3i7Hf1kiAs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H1gT2jXEEvY53ipxIhZzFxXqN8zXn5La1zLL8AnqDvf1a52Z6q4swIrGlkqGmsMJyQQ8mBymNoCJRMDIFV5UDiQYfoU6/ZNPdN7JomcdF2m9M0RkPw7Fv44VmiVfrBuADEra+Ip236bWVKmiY+1fMoBUnPuTsmKa9uugopyk2WY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3bhSCpAe; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3bhSCpAe"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d06cfa93so16725ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 09 Jan 2026 15:37:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768001833; cv=none;
        d=google.com; s=arc-20240605;
        b=GAh3qfSiaODgVvcE2RZa5uJ/yPIW9ea/FvRwst0KIEFiF0Zod6TG9izDo3tMBXEQD0
         zz1SW/krgXGwEQB/lbZZ7eLHYH6WUGO5U644ZjRLHPZRiaX48uxMz9beG2NCmwavUqxb
         75NW7E1or/fUEqY3p/xyS0J4aGt2OSeJiTzNbpMR39CS64nruzO6I17/CVrIdEY1m0/N
         Tm5KElarLEADUqifHflP7uYeJAcwqfNBYoChJhmBw9Z5PDLPYRWkmtLzM8UVGGfFbSTf
         K692voHkF+1EicP3EjSYfyetqNIUqI4Jyj9gQeTX/IIZcZApNYZW1wPyXQWG4E7UJ1Bf
         Nv2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q9laz19ys4LoGN5SaMhT9EoVkcpTKXfPtANlj4F2CH8=;
        fh=Q3EKZjMmWTFAXht8Rj6m2y9l7r5kTvT7mOe+8krk8N8=;
        b=V0A32atcAISrDBT41QzHuGWoXfXWkbbws0I+S1ygHfiWF+HjiGgsryYrao8u4A9/eK
         42oHrVfcSYeKMwcXvEKr00GKxuNlkJpkmTTgOQg4fKzob4y6Kcv1zbTu7soYzgkZh1Iq
         RbF+u+twUxaAVzFayiAMWoa/X9pC94nzd2rcbZXH/g1kRDH7V6TIV1qtWRAMEJheEXYB
         Vv9BEpXYd7cCqcWMfujTWZsSpyQqsk2dWYtXqur6OXTFNXgxrwIScoNUuwfDqG9f+fyP
         0XaQnpxgBcg8GdC9trwPquLL4oO/R+0GXEVRGyBBkHqWiufNH2c6HNHvbrQX9yIb281j
         7mSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768001833; x=1768606633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q9laz19ys4LoGN5SaMhT9EoVkcpTKXfPtANlj4F2CH8=;
        b=3bhSCpAeC3zwUl6i8xe4IObu2RgZoM9hGRBhHUComeQ8hhJqXY6WRk9555Q+e9RQWk
         B/H1Dmz6OKeLLMediQH3f0gbhzmXRSelHaazjHN5Qh7K/833SNbNIMcMUo/vtxwTw5S8
         ckQgHnG48l6f8W07RX4O81DSiwSrxMmM4euMqkEsO0MqTdImk6jOyLl8WzKH/pggvQGe
         VTFtF1ssqrJC77AarS75c72ckOXF/xvSs54oUwgT/nhtHO2Kf4upOub7K+W5lw+9LGx5
         v/nOnpFh3pwcOj6Exhr52uiX3/dX7hbZv96lG8PO8HG08etvHE3DdtJxMrW5+PL4tVpI
         e3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001833; x=1768606633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q9laz19ys4LoGN5SaMhT9EoVkcpTKXfPtANlj4F2CH8=;
        b=hA4KtxQBfBYHOuFT/r/4nnxR7fzbU4yQrim82EqA+TOHtjDpqEw7AQ6oProGGpXxcu
         uJnH0bMAw63g0i0w550uKobWylQOZkAAskZQy+w+b9PbFAp0cUwKsuUb8zpoAVFnMKCR
         GdI5pNM2jts1Pjt4KwgCf/xN1L9oz1lQgTT4gWz2XzM6Fe2K90O5jkUyomhS8g1Z8cHi
         Rdv7TLcvrbVfdJoryZKdc4bzcs4q2ppdJU2mop8IIWBeth1EF+ZvoEDWVruPLNk/i9Sf
         nGAznPW/OyvZ1gTGXkCV50bFiCJwvpbRjhrzwvTUnsFzdHnyis3kS1SFuVxbOEPdtBAO
         HUCA==
X-Forwarded-Encrypted: i=1; AJvYcCVOzbwhnBAMBVxOWVlRm8JHgeTqKbNG4d2hXFKXw6LjZxgruufHqZ3maalMljDMisMP3iS7frKZHx6nY2C9cgPT@vger.kernel.org
X-Gm-Message-State: AOJu0YzkZfLAx+qXi+mbDsFDaz9fIQzdydZ+vwvxfPwalVdrgfrJPmEO
	2VJWp2xbK3VR9c27pJE7BZsqYnjVxmW8muqy40ySVNljmqjpAfNJ5dzVG8GQnR58oqfkXPmSZGp
	Je/3059sRVO6aZSsh7IGEvVyZQ0Hdna7t1WEp3b8I
X-Gm-Gg: AY/fxX4bE/OXV28P29p0E3M2/bRdsGOH9mT01ymga7SVhTvRmzbk0rAFfgtkDyO2cdR
	ksK4p+I5RgKxH4zCp3AhPaPrpEAlOpUDrMbXTWE02ImnbKGydB28s3ANbaHNC1jS9wcermJ5bhR
	WbNsm0t9rXU9oV1ltoFzWBnAka7yxN3nuBVjZqlq6wlV8eN790nFLWtJlWJ4VoInWWoAj25uls/
	EEJzuabeuAJcq977ePEgrLo9BrMB/ICsIgDiyOlnXvq4wxmnmN/u4rPQf/b9ahhDdgHidXoUtSZ
	sMHj9fOfQK/E4C80IcHECIODxg==
X-Received: by 2002:a17:903:1670:b0:2a1:3cdc:7720 with SMTP id
 d9443c01a7336-2a415608f55mr586685ad.21.1768001832260; Fri, 09 Jan 2026
 15:37:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219011820.2505506-1-namhyung@kernel.org> <20251219011820.2505506-3-namhyung@kernel.org>
In-Reply-To: <20251219011820.2505506-3-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 9 Jan 2026 15:37:01 -0800
X-Gm-Features: AQt7F2rBKaqsDJzQs3So9nsgZCNYiYJT-1W2X8EDyg6aNRKhH43NOgX1nkf5RkA
Message-ID: <CAP-5=fVDYu+GLspYQNEHk7_X8-FE-OaEF0OaG+vfWrrYH9ZcoQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] perf test: Do not skip when some metrics tests succeeded
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 5:18=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> I think the return value of SKIP (2) should be used when it skipped the
> entire test suite rather than a few of them.  While the FAIL should be
> reserved if any of test failed.

This doesn't make sense to me. The current behavior is to set err to 0
(success):
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=3Dperf-tools-next#n18
If a failure condition occurs then err is set to 1 (fail)
unconditionally as you can't be more failing than failing, like:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=3Dperf-tools-next#n38
If a skip condition is encountered then we set err to 2 (skip)
conditional on the err state only being currently 0 (success) - ie
don't turn a fail into a skip:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=3Dperf-tools-next#n45

All metrics are always tested by test, so I'm not sure what "entire
test suite" means. The test should report success if nothing skips or
fails, skip if something skips and there are no failures, and
otherwise failure.

I can see the test being simplified by having a failure flag and a
skip flag, then determining the 0, 1 or 2 value from these two flags.
It would be avoiding testing the err value when setting it to 2
(skip), but the change here isn't doing that. The change introduces a
new value of 3, which seems more complex, and the skip flag is set
depending on the global err value rather than just being a sticky flag
showing a metric failed.

Thanks,
Ian

>   $ perf test -vv 110
>   110: perf all metrics test:
>   --- start ---
>   test child forked, pid 2496399
>   Testing tma_core_bound
>   Testing tma_info_core_ilp
>   Testing tma_info_memory_l2mpki
>   Testing tma_memory_bound
>   Testing tma_bottleneck_irregular_overhead
>   Testing tma_bottleneck_mispredictions
>   Testing tma_info_bad_spec_branch_misprediction_cost
>   Testing tma_info_bad_spec_ipmisp_cond_ntaken
>   Testing tma_info_bad_spec_ipmisp_cond_taken
>   Testing tma_info_bad_spec_ipmisp_indirect
>   Testing tma_info_bad_spec_ipmisp_ret
>   Testing tma_info_bad_spec_ipmispredict
>   Testing tma_info_branches_callret
>   Testing tma_info_branches_cond_nt
>   Testing tma_info_branches_cond_tk
>   Testing tma_info_branches_jump
>   Testing tma_info_branches_other_branches
>   Testing tma_branch_mispredicts
>   Testing tma_clears_resteers
>   Testing tma_machine_clears
>   Testing tma_mispredicts_resteers
>   Testing tma_bottleneck_big_code
>   Testing tma_icache_misses
>   Testing tma_itlb_misses
>   Testing tma_unknown_branches
>   Testing tma_info_bad_spec_spec_clears_ratio
>   Testing tma_other_mispredicts
>   Testing tma_branch_instructions
>   Testing tma_info_frontend_tbpc
>   Testing tma_info_inst_mix_bptkbranch
>   Testing tma_info_inst_mix_ipbranch
>   Testing tma_info_inst_mix_ipcall
>   Testing tma_info_inst_mix_iptb
>   Testing tma_info_system_ipfarbranch
>   Testing tma_info_thread_uptb
>   Testing tma_bottleneck_branching_overhead
>   Testing tma_nop_instructions
>   Testing tma_bottleneck_compute_bound_est
>   Testing tma_divider
>   Testing tma_ports_utilized_3m
>   Testing tma_bottleneck_instruction_fetch_bw
>   Testing tma_frontend_bound
>   Testing tma_assists
>   Testing tma_other_nukes
>   Testing tma_serializing_operation
>   Testing tma_bottleneck_data_cache_memory_bandwidth
>   Testing tma_fb_full
>   Testing tma_mem_bandwidth
>   Testing tma_sq_full
>   Testing tma_bottleneck_data_cache_memory_latency
>   Testing tma_l1_latency_dependency
>   Testing tma_l2_bound
>   Testing tma_l3_hit_latency
>   Testing tma_mem_latency
>   Testing tma_store_latency
>   Testing tma_bottleneck_memory_synchronization
>   Testing tma_contested_accesses
>   Testing tma_data_sharing
>   Testing tma_false_sharing
>   Testing tma_bottleneck_memory_data_tlbs
>   Testing tma_dtlb_load
>   Testing tma_dtlb_store
>   Testing tma_backend_bound
>   Testing tma_bottleneck_other_bottlenecks
>   Testing tma_bottleneck_useful_work
>   Testing tma_retiring
>   Testing tma_info_memory_fb_hpki
>   Testing tma_info_memory_l1mpki
>   Testing tma_info_memory_l1mpki_load
>   Testing tma_info_memory_l2hpki_all
>   Testing tma_info_memory_l2hpki_load
>   Testing tma_info_memory_l2mpki_all
>   Testing tma_info_memory_l2mpki_load
>   Testing tma_l1_bound
>   Testing tma_l3_bound
>   Testing tma_info_memory_l2mpki_rfo
>   Testing tma_fp_scalar
>   Testing tma_fp_vector
>   Testing tma_fp_vector_128b
>   Testing tma_fp_vector_256b
>   Testing tma_fp_vector_512b
>   Testing tma_port_0
>   Testing tma_x87_use
>   Testing tma_info_botlnk_l0_core_bound_likely
>   Testing tma_info_core_fp_arith_utilization
>   Testing tma_info_pipeline_execute
>   Testing tma_info_system_gflops
>   Testing tma_info_thread_execute_per_issue
>   Testing tma_dsb
>   Testing tma_info_botlnk_l2_dsb_bandwidth
>   Testing tma_info_frontend_dsb_coverage
>   Testing tma_decoder0_alone
>   Testing tma_dsb_switches
>   Testing tma_info_botlnk_l2_dsb_misses
>   Testing tma_info_frontend_dsb_switch_cost
>   Testing tma_info_frontend_ipdsb_miss_ret
>   Testing tma_mite
>   Testing tma_mite_4wide
>   Testing CPUs_utilized
>   Testing backend_cycles_idle
>   [Ignored backend_cycles_idle] failed but as a Default metric this can b=
e expected
>   Performance counter stats for 'perf test -w noploop': <not counted> cpu=
-cycles:u <not supported> stalled-cycles-backend:u 1.014051473 seconds time=
 elapsed 1.005718000 seconds user 0.008013000 seconds sys
>   Testing branch_frequency
>   Testing branch_miss_rate
>   Testing cs_per_second
>   Testing cycles_frequency
>   Testing frontend_cycles_idle
>   [Ignored frontend_cycles_idle] failed but as a Default metric this can =
be expected
>   Performance counter stats for 'perf test -w noploop': <not counted> cpu=
-cycles:u <not supported> stalled-cycles-frontend:u 1.012813656 seconds tim=
e elapsed 1.004603000 seconds user 0.008004000 seconds sys
>   Testing insn_per_cycle
>   Testing migrations_per_second
>   Testing page_faults_per_second
>   Testing stalled_cycles_per_instruction
>   [Ignored stalled_cycles_per_instruction] failed but as a Default metric=
 this can be expected
>   Error: No supported events found. The stalled-cycles-backend:u event is=
 not supported.
>   Testing tma_bad_speculation
>   Testing l1d_miss_rate
>   Testing llc_miss_rate
>   Testing dtlb_miss_rate
>   Testing itlb_miss_rate
>   [Ignored itlb_miss_rate] failed but as a Default metric this can be exp=
ected
>   Performance counter stats for 'perf test -w noploop': <not supported> i=
TLB-loads:u 3,097 iTLB-load-misses:u 1.012766732 seconds time elapsed 1.004=
318000 seconds user 0.008002000 seconds sys
>   Testing l1i_miss_rate
>   [Ignored l1i_miss_rate] failed but as a Default metric this can be expe=
cted
>   Performance counter stats for 'perf test -w noploop': <not counted> L1-=
icache-load-misses:u <not supported> L1-icache-loads:u 1.013606395 seconds =
time elapsed 1.001371000 seconds user 0.011968000 seconds sys
>   Testing l1_prefetch_miss_rate
>   [Ignored l1_prefetch_miss_rate] failed but as a Default metric this can=
 be expected
>   Error: No supported events found. The L1-dcache-prefetches:u event is n=
ot supported.
>   Testing tma_info_botlnk_l2_ic_misses
>   Testing tma_info_frontend_fetch_upc
>   Testing tma_info_frontend_icache_miss_latency
>   Testing tma_info_frontend_ipunknown_branch
>   Testing tma_info_frontend_lsd_coverage
>   Testing tma_info_memory_tlb_code_stlb_mpki
>   Testing tma_info_pipeline_fetch_dsb
>   Testing tma_info_pipeline_fetch_lsd
>   Testing tma_info_pipeline_fetch_mite
>   Testing tma_info_pipeline_fetch_ms
>   Testing tma_fetch_bandwidth
>   Testing tma_lsd
>   Testing tma_branch_resteers
>   Testing tma_code_l2_hit
>   Testing tma_code_l2_miss
>   Testing tma_code_stlb_hit
>   Testing tma_code_stlb_miss
>   Testing tma_code_stlb_miss_2m
>   Testing tma_code_stlb_miss_4k
>   Testing tma_lcp
>   Testing tma_ms_switches
>   Testing tma_info_core_flopc
>   Testing tma_info_inst_mix_iparith
>   Testing tma_info_inst_mix_iparith_avx128
>   Testing tma_info_inst_mix_iparith_avx256
>   Testing tma_info_inst_mix_iparith_avx512
>   Testing tma_info_inst_mix_iparith_scalar_dp
>   Testing tma_info_inst_mix_iparith_scalar_sp
>   Testing tma_info_inst_mix_ipflop
>   Testing tma_info_inst_mix_ippause
>   Testing tma_fetch_latency
>   Testing tma_fp_arith
>   Testing tma_fp_assists
>   Testing tma_info_system_cpu_utilization
>   Testing tma_info_system_dram_bw_use
>   [Skipped tma_info_system_dram_bw_use] Not supported events
>   Performance counter stats for 'perf test -w noploop': <not supported> U=
NC_ARB_TRK_REQUESTS.ALL:u <not supported> UNC_ARB_COH_TRK_REQUESTS.ALL:u 1,=
013,554,749 duration_time 1.013527265 seconds time elapsed 1.005417000 seco=
nds user 0.008011000 seconds sys
>   Testing tma_info_frontend_l2mpki_code
>   Testing tma_info_frontend_l2mpki_code_all
>   Testing tma_info_inst_mix_ipload
>   Testing tma_info_inst_mix_ipstore
>   Testing tma_info_memory_latency_load_l2_miss_latency
>   Testing tma_lock_latency
>   Testing tma_info_memory_core_l1d_cache_fill_bw_2t
>   Testing tma_info_memory_core_l2_cache_fill_bw_2t
>   Testing tma_info_memory_core_l3_cache_access_bw_2t
>   Testing tma_info_memory_core_l3_cache_fill_bw_2t
>   Testing tma_info_memory_l1d_cache_fill_bw
>   Testing tma_info_memory_l2_cache_fill_bw
>   Testing tma_info_memory_l3_cache_access_bw
>   Testing tma_info_memory_l3_cache_fill_bw
>   Testing tma_info_memory_l3mpki
>   Testing tma_info_memory_load_miss_real_latency
>   Testing tma_info_memory_mix_bus_lock_pki
>   Testing tma_info_memory_mix_uc_load_pki
>   Testing tma_info_memory_mlp
>   Testing tma_info_memory_tlb_load_stlb_mpki
>   Testing tma_info_memory_tlb_page_walks_utilization
>   Testing tma_info_memory_tlb_store_stlb_mpki
>   Testing tma_info_system_mem_parallel_reads
>   [Skipped tma_info_system_mem_parallel_reads] Not supported events
>   Performance counter stats for 'perf test -w noploop': <not supported> U=
NC_ARB_DAT_OCCUPANCY.RD:u <not counted> UNC_ARB_DAT_OCCUPANCY.RD/cmask=3D1/=
 1.013354884 seconds time elapsed 1.009239000 seconds user 0.004004000 seco=
nds sys
>   Testing tma_info_system_mem_read_latency
>   [Skipped tma_info_system_mem_read_latency] Not supported events
>   Performance counter stats for 'perf test -w noploop': <not supported> U=
NC_ARB_DAT_OCCUPANCY.RD:u <not counted> UNC_ARB_TRK_OCCUPANCY.RD <not count=
ed> UNC_ARB_TRK_REQUESTS.RD 1.012882143 seconds time elapsed 1.004600000 se=
conds user 0.008036000 seconds sys
>   Testing tma_info_thread_cpi
>   Testing tma_streaming_stores
>   Testing tma_dram_bound
>   Testing tma_store_bound
>   Testing tma_l2_hit_latency
>   Testing tma_load_stlb_hit
>   Testing tma_load_stlb_miss
>   Testing tma_load_stlb_miss_1g
>   Testing tma_load_stlb_miss_2m
>   Testing tma_load_stlb_miss_4k
>   Testing tma_store_stlb_hit
>   Testing tma_store_stlb_miss
>   Testing tma_store_stlb_miss_1g
>   Testing tma_store_stlb_miss_2m
>   Testing tma_store_stlb_miss_4k
>   Testing tma_info_memory_latency_data_l2_mlp
>   Testing tma_info_memory_latency_load_l2_mlp
>   Testing tma_info_pipeline_ipassist
>   Testing tma_microcode_sequencer
>   Testing tma_ms
>   Testing tma_info_system_kernel_cpi
>   [Failed tma_info_system_kernel_cpi] Metric contains missing events
>   Error: No supported events found. Access to performance monitoring and =
observability operations is limited. Consider adjusting /proc/sys/kernel/pe=
rf_event_paranoid setting to open access to performance monitoring and obse=
rvability operations for processes without CAP_PERFMON, CAP_SYS_PTRACE or C=
AP_SYS_ADMIN Linux capability. More information can be found at 'Perf event=
s and tool security' document: https://www.kernel.org/doc/html/latest/admin=
-guide/perf-security.html perf_event_paranoid setting is 2: -1: Allow use o=
f (almost) all events by all users Ignore mlock limit after perf_event_mloc=
k_kb without CAP_IPC_LOCK >=3D 0: Disallow raw and ftrace function tracepoi=
nt access >=3D 1: Disallow CPU event access >=3D 2: Disallow kernel profili=
ng To make the adjusted perf_event_paranoid setting permanent preserve it i=
n /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
>   Testing tma_info_system_kernel_utilization
>   [Failed tma_info_system_kernel_utilization] Metric contains missing eve=
nts
>   Error: No supported events found. Access to performance monitoring and =
observability operations is limited. Consider adjusting /proc/sys/kernel/pe=
rf_event_paranoid setting to open access to performance monitoring and obse=
rvability operations for processes without CAP_PERFMON, CAP_SYS_PTRACE or C=
AP_SYS_ADMIN Linux capability. More information can be found at 'Perf event=
s and tool security' document: https://www.kernel.org/doc/html/latest/admin=
-guide/perf-security.html perf_event_paranoid setting is 2: -1: Allow use o=
f (almost) all events by all users Ignore mlock limit after perf_event_mloc=
k_kb without CAP_IPC_LOCK >=3D 0: Disallow raw and ftrace function tracepoi=
nt access >=3D 1: Disallow CPU event access >=3D 2: Disallow kernel profili=
ng To make the adjusted perf_event_paranoid setting permanent preserve it i=
n /etc/sysctl.conf (e.g. kernel.perf_event_paranoid =3D <setting>)
>   Testing tma_info_pipeline_retire
>   Testing tma_info_thread_clks
>   Testing tma_info_thread_uoppi
>   Testing tma_memory_operations
>   Testing tma_other_light_ops
>   Testing tma_ports_utilization
>   Testing tma_ports_utilized_0
>   Testing tma_ports_utilized_1
>   Testing tma_ports_utilized_2
>   Testing C10_Pkg_Residency
>   [Failed C10_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_pkg/c10-re=
sidency/, msr/tsc/ } Error: No supported events found. Invalid event (cstat=
e_pkg/c10-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C2_Pkg_Residency
>   [Failed C2_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_pkg/c2-res=
idency/, msr/tsc/ } Error: No supported events found. Invalid event (cstate=
_pkg/c2-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C3_Pkg_Residency
>   [Failed C3_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { msr/tsc/, cstate_=
pkg/c3-residency/ } Error: No supported events found. Invalid event (msr/ts=
c/u) in per-thread mode, enable system wide with '-a'.
>   Testing C6_Core_Residency
>   [Failed C6_Core_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_core/c6-re=
sidency/, msr/tsc/ } Error: No supported events found. Invalid event (cstat=
e_core/c6-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C6_Pkg_Residency
>   [Failed C6_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_pkg/c6-res=
idency/, msr/tsc/ } Error: No supported events found. Invalid event (cstate=
_pkg/c6-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C7_Core_Residency
>   [Failed C7_Core_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_core/c7-re=
sidency/, msr/tsc/ } Error: No supported events found. Invalid event (cstat=
e_core/c7-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C7_Pkg_Residency
>   [Failed C7_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_pkg/c7-res=
idency/, msr/tsc/ } Error: No supported events found. Invalid event (cstate=
_pkg/c7-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C8_Pkg_Residency
>   [Failed C8_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_pkg/c8-res=
idency/, msr/tsc/ } Error: No supported events found. Invalid event (cstate=
_pkg/c8-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing C9_Pkg_Residency
>   [Failed C9_Pkg_Residency] Metric contains missing events
>   WARNING: grouped events cpus do not match. Events with CPUs not matchin=
g the leader will be removed from the group. anon group { cstate_pkg/c9-res=
idency/, msr/tsc/ } Error: No supported events found. Invalid event (cstate=
_pkg/c9-residency/u) in per-thread mode, enable system wide with '-a'.
>   Testing tma_info_core_epc
>   Testing tma_info_system_core_frequency
>   Testing tma_info_system_power
>   [Skipped tma_info_system_power] Not supported events
>   Performance counter stats for 'perf test -w noploop': <not supported> J=
oules power/energy-pkg/u 1,013,238,256 duration_time 1.013223072 seconds ti=
me elapsed 0.995924000 seconds user 0.011903000 seconds sys
>   Testing tma_info_system_power_license0_utilization
>   Testing tma_info_system_power_license1_utilization
>   Testing tma_info_system_power_license2_utilization
>   Testing tma_info_system_turbo_utilization
>   Testing tma_info_inst_mix_ipswpf
>   Testing tma_info_memory_prefetches_useless_hwpf
>   Testing tma_info_core_coreipc
>   Testing tma_info_thread_ipc
>   Testing tma_heavy_operations
>   Testing tma_light_operations
>   Testing tma_info_core_core_clks
>   Testing tma_info_system_smt_2t_utilization
>   Testing tma_info_thread_slots_utilization
>   Testing UNCORE_FREQ
>   [Skipped UNCORE_FREQ] Not supported events
>   Performance counter stats for 'perf test -w noploop': <not supported> U=
NC_CLOCK.SOCKET:u 1,015,993,466 duration_time 1.015949387 seconds time elap=
sed 1.007676000 seconds user 0.008029000 seconds sys
>   Testing tma_info_system_socket_clks
>   [Failed tma_info_system_socket_clks] Metric contains missing events
>   Error: No supported events found. Invalid event (UNC_CLOCK.SOCKET:u) in=
 per-thread mode, enable system wide with '-a'.
>   Testing tma_info_inst_mix_instructions
>   Testing tma_info_system_cpus_utilized
>   Testing tma_info_system_mux
>   Testing tma_info_system_time
>   Testing tma_info_thread_slots
>   Testing tma_few_uops_instructions
>   Testing tma_4k_aliasing
>   Testing tma_cisc
>   Testing tma_fp_divider
>   Testing tma_int_divider
>   Testing tma_slow_pause
>   Testing tma_split_loads
>   Testing tma_split_stores
>   Testing tma_store_fwd_blk
>   Testing tma_alu_op_utilization
>   Testing tma_load_op_utilization
>   Testing tma_mixing_vectors
>   Testing tma_store_op_utilization
>   Testing tma_port_1
>   Testing tma_port_5
>   Testing tma_port_6
>   Testing smi_cycles
>   [Skipped smi_cycles] Not supported events
>   Performance counter stats for 'perf test -w noploop': <not supported> m=
sr/smi/u <not supported> msr/aperf/u 3,965,789,327 cycles:u 1.012779591 sec=
onds time elapsed 1.004579000 seconds user 0.007972000 seconds sys
>   Testing smi_num
>   [Failed smi_num] Metric contains missing events
>   Error: No supported events found. Invalid event (msr/smi/u) in per-thre=
ad mode, enable system wide with '-a'.
>   Testing tsx_aborted_cycles
>   Testing tsx_cycles_per_elision
>   Testing tsx_cycles_per_transaction
>   Testing tsx_transactional_cycles
>   ---- end(-1) ----
>   110: perf all metrics test                                           : =
FAILED!
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/tests/shell/stat_all_metrics.sh | 29 ++++++++++++++++------
>  1 file changed, 22 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/tests/shell/stat_all_metrics.sh b/tools/perf/test=
s/shell/stat_all_metrics.sh
> index 3dabb39c7cc8c46a..b582d23f28c9e8e2 100755
> --- a/tools/perf/tests/shell/stat_all_metrics.sh
> +++ b/tools/perf/tests/shell/stat_all_metrics.sh
> @@ -15,7 +15,8 @@ then
>    test_prog=3D"perf test -w noploop"
>  fi
>
> -err=3D0
> +skip=3D0
> +err=3D3
>  for m in $(perf list --raw-dump metrics); do
>    echo "Testing $m"
>    result=3D$(perf stat -M "$m" $system_wide_flag -- $test_prog 2>&1)
> @@ -23,6 +24,10 @@ for m in $(perf list --raw-dump metrics); do
>    if [[ $result_err -eq 0 && "$result" =3D~ ${m:0:50} ]]
>    then
>      # No error result and metric shown.
> +    if [[ "$err" -ne 1 ]]
> +    then
> +      err=3D0
> +    fi
>      continue
>    fi
>    if [[ "$result" =3D~ "Cannot resolve IDs for" || "$result" =3D~ "No su=
pported events found" ]]
> @@ -44,7 +49,7 @@ for m in $(perf list --raw-dump metrics); do
>      echo $result
>      if [[ $err -eq 0 ]]
>      then
> -      err=3D2 # Skip
> +      skip=3D1
>      fi
>      continue
>    elif [[ "$result" =3D~ "in per-thread mode, enable system wide" ]]
> @@ -53,7 +58,7 @@ for m in $(perf list --raw-dump metrics); do
>      echo $result
>      if [[ $err -eq 0 ]]
>      then
> -      err=3D2 # Skip
> +      skip=3D1
>      fi
>      continue
>    elif [[ "$result" =3D~ "<not supported>" ]]
> @@ -68,7 +73,7 @@ for m in $(perf list --raw-dump metrics); do
>      echo $result
>      if [[ $err -eq 0 ]]
>      then
> -      err=3D2 # Skip
> +      skip=3D1
>      fi
>      continue
>    elif [[ "$result" =3D~ "<not counted>" ]]
> @@ -77,7 +82,7 @@ for m in $(perf list --raw-dump metrics); do
>      echo $result
>      if [[ $err -eq 0 ]]
>      then
> -      err=3D2 # Skip
> +      skip=3D1
>      fi
>      continue
>    elif [[ "$result" =3D~ "FP_ARITH" || "$result" =3D~ "AMX" ]]
> @@ -86,7 +91,7 @@ for m in $(perf list --raw-dump metrics); do
>      echo $result
>      if [[ $err -eq 0 ]]
>      then
> -      err=3D2 # Skip
> +      skip=3D1
>      fi
>      continue
>    elif [[ "$result" =3D~ "PMM" ]]
> @@ -95,7 +100,7 @@ for m in $(perf list --raw-dump metrics); do
>      echo $result
>      if [[ $err -eq 0 ]]
>      then
> -      err=3D2 # Skip
> +      skip=3D1
>      fi
>      continue
>    fi
> @@ -106,6 +111,10 @@ for m in $(perf list --raw-dump metrics); do
>    if [[ $result_err -eq 0 && "$result" =3D~ ${m:0:50} ]]
>    then
>      # No error result and metric shown.
> +    if [[ "$err" -ne 1 ]]
> +    then
> +      err=3D0
> +    fi
>      continue
>    fi
>    echo "[Failed $m] has non-zero error '$result_err' or not printed in:"
> @@ -113,4 +122,10 @@ for m in $(perf list --raw-dump metrics); do
>    err=3D1
>  done
>
> +# return SKIP only if no success returned
> +if [[ "$err" -eq 3 && "$skip" -eq 1 ]]
> +then
> +  err=3D2
> +fi
> +
>  exit "$err"
> --
> 2.52.0.322.g1dd061c0dc-goog
>
