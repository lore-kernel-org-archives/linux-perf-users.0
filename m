Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7120A376BE5;
	Tue,  3 Mar 2026 03:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507239; cv=none; b=urB64GpQDtG2/my2N8Nw/n0HyarH46dvmwM/7RSo7zZq2uNLI4YjLFmuV/d4i+IjHnBpodgN9isWJ+aS0SChICrBoyqP3fREOV+/1zhCTcX0hJzqNLHnQ6tlLP+cQMLwk2TMwLtEn9yMkxgOchcC0scJx7U71K7LHqkRkF4hAmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507239; c=relaxed/simple;
	bh=F9tCD9K+9cUsy0283ltecD6jja8rhhPTYEdi9O1f5Ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lINY33aEHhvdlTbEpLUk0Pz2mV9yg4XSgHkJZTL4yqo6JanTEOA1TFoTYpn2kjjcImYaTr5kPhR5quOR6Ia/b9EkLl0kemKEc3gNegV87sT1MnXHSeFGrV3vFGkOnHyfHvZV83KrJJg7bfieA1hKzvIyeyCfL0T+Nm4Zsaml72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dl3mu+Lj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dl3mu+Lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D828C2BC9E;
	Tue,  3 Mar 2026 03:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772507239;
	bh=F9tCD9K+9cUsy0283ltecD6jja8rhhPTYEdi9O1f5Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dl3mu+Lj/H5w4df7sW6vMuBSPitsD1rp+tb85ARYcizwXShFs6pMub5gmT8JCc2G6
	 5r9IzFVbY20b85XoAHETG3NWN9H7so7N+9U4rRtiUUHBIPA56sL9uRg3f8D4djp3pa
	 aL62OvVyrbvZyinem2XLR4/4UyF9m1N+KOmwZ0EIvzuSmMQ1/DhJ0NAiMfbUbbqucA
	 fWDmR3XPafSQNCBscGurz4ipstcxdDcjZKmUVOoGzJW4bmsEk/kqWMEZQMOozfx3tH
	 j78E/MrLydgZI4mx0WlbV4vgpNjbtqucWV5LTo397bmKwXhVFFXfVXpPsvg+4cJVoN
	 nVAXHd0cncU1A==
Date: Mon, 2 Mar 2026 19:07:16 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Leo Yan <leo.yan@arm.com>, Tianyou Li <tianyou.li@intel.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Derek Foreman <derek.foreman@collabora.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>, Andi Kleen <ak@linux.intel.com>,
	tanze <tanze@kylinos.cn>,
	Hrishikesh Suresh <hrishikesh123s@gmail.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Krzysztof =?utf-8?Q?=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
	Chun-Tse Shao <ctshao@google.com>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Chen Ni <nichen@iscas.ac.cn>, Blake Jones <blakejones@google.com>,
	Yujie Liu <yujie.liu@intel.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 01/25] perf sample: Document struct perf_sample
Message-ID: <aaZQZI2ElVhblz-t@google.com>
References: <20260209174032.4142096-1-irogers@google.com>
 <20260209174032.4142096-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260209174032.4142096-2-irogers@google.com>

On Mon, Feb 09, 2026 at 09:40:08AM -0800, Ian Rogers wrote:
> Add kernel-doc for struct perf_sample capturing the somewhat unusual
> population of fields and lifetime relationships.

Thanks for doing this.

> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/util/sample.h | 90 ++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 87 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index 3cce8dd202aa..3fd2a5e01308 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -81,47 +81,131 @@ struct simd_flags {
>  #define SIMD_OP_FLAGS_PRED_PARTIAL	0x01	/* partial predicate */
>  #define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
>  
> +/**
> + * struct perf_sample
> + *
> + * A sample is generally filled in by evlist__parse_sample/evsel__parse_sample
> + * which fills in the variables from a "union perf_event *event" which is data
> + * from a perf ring buffer or perf.data file. The "event" sample is variable in
> + * length as determined by the perf_event_attr (in the evsel) and details within
> + * the sample event itself. A struct perf_sample avoids needing to care about
> + * the variable length nature of the original event.
> + *
> + * To avoid being excessively large parts of the struct perf_sample are pointers
> + * into the original sample event. In general the lifetime of a struct
> + * perf_sample needs to be less than the "union perf_event *event" it was
> + * derived from.
> + *
> + * The struct regs_dump user_regs and intr_regs are lazily allocated again for
> + * size reasons, due to them holding a cache of looked up registers. The
> + * function pair of perf_sample__init and perf_sample__exit correctly initialize
> + * and clean up these values.
> + */
>  struct perf_sample {
> +	/** @ip: The sample event PERF_SAMPLE_IP value. */
>  	u64 ip;
> -	u32 pid, tid;
> +	/** @pid: The sample event PERF_SAMPLE_TID pid value. */
> +	u32 pid;
> +	/** @tid: The sample event PERF_SAMPLE_TID tid value. */
> +	u32 tid;
> +	/** @time: The sample event PERF_SAMPLE_TIME value. */
>  	u64 time;
> +	/** @addr: The sample event PERF_SAMPLE_ADDR value. */
>  	u64 addr;
> +	/** @id: The sample event PERF_SAMPLE_ID value. */
>  	u64 id;
> +	/** @stream_id: The sample event PERF_SAMPLE_STREAM_ID value. */
>  	u64 stream_id;
> +	/** @period: The sample event PERF_SAMPLE_PERIOD value. */
>  	u64 period;
> +	/** @weight: Data determined by PERF_SAMPLE_WEIGHT or PERF_SAMPLE_WEIGHT_STRUCT. */
>  	u64 weight;
> +	/** @transaction: The sample event PERF_SAMPLE_TRANSACTION value. */
>  	u64 transaction;
> +	/** @insn_cnt: Filled in and used by intel-pt. */
>  	u64 insn_cnt;
> +	/** @cyc_cnt: Filled in and used by intel-pt. */
>  	u64 cyc_cnt;
> +	/** @cpu: The sample event PERF_SAMPLE_CPU value. */
>  	u32 cpu;
> +	/**
> +	 * @raw_size: The size in bytes of raw data from PERF_SAMPLE_RAW. For
> +	 *            alignment reasons this should always be a multiple of
> +	 *            sizeof(u64) + sizeof(u32).
> +	 */
>  	u32 raw_size;
> +	/** @data_src: The sample event PERF_SAMPLE_DATA_SRC value. */
>  	u64 data_src;
> +	/** @phys_addr: The sample event PERF_SAMPLE_PHYS_ADDR value. */
>  	u64 phys_addr;
> +	/** @data_page_size: The sample event PERF_SAMPLE_DATA_PAGE_SIZE value. */
>  	u64 data_page_size;
> +	/** @code_page_size: The sample event PERF_SAMPLE_CODE_PAGE_SIZE value. */
>  	u64 code_page_size;
> +	/** @cgroup: The sample event PERF_SAMPLE_CGROUP value. */
>  	u64 cgroup;
> +	/** @flags: Extra flag data from auxiliary events like intel-pt. */
>  	u32 flags;
> +	/** @machine_pid: The guest machine pid derived from the sample id. */
>  	u32 machine_pid;
> +	/** @vcpu: The guest machine vcpu derived from the sample id. */
>  	u32 vcpu;
> +	/** @insn_len: Instruction length from auxiliary events like intel-pt. */
>  	u16 insn_len;

Does it control the insn array later?


> +	/**
> +	 * @cpumode: The cpumode from struct perf_event_header misc variable
> +	 *           masked with CPUMODE_MASK. Gives user, kernel and hypervisor
> +	 *           information.
> +	 */
>  	u8  cpumode;
> +	/** @misc: The entire struct perf_event_header misc variable. */
>  	u16 misc;
> +	/** @ins_lat: Instruction latency information from auxiliary events like intel-pt. */
>  	u16 ins_lat;

I think this is weight2 coming from PERF_SAMPLE_WEIGHT_STRUCT.


>  	/** @weight3: On x86 holds retire_lat, on powerpc holds p_stage_cyc. */
>  	u16 weight3;

You may also want to mention it's from WEIGHT_STRUCT.


> -	bool no_hw_idx;		/* No hw_idx collected in branch_stack */
> -	bool deferred_callchain;	/* Has deferred user callchains */
> +	/**
> +	 * @no_hw_idx: For PERF_SAMPLE_BRANCH_STACK, true when
> +	 *             PERF_SAMPLE_BRANCH_HW_INDEX isn't set.
> +	 */
> +	bool no_hw_idx;
> +	/**
> +	 * @deferred_callchain: When processing PERF_SAMPLE_CALLCHAIN a deferred
> +	 *                      user callchain marker was encountered.
> +	 */
> +	bool deferred_callchain;

If this is set, then callchain entry is allocated for deferred
callchains.


> +	/**
> +	 * @deferred_cookie: Identifier of the deferred callchain in the later
> +	 *                   PERF_RECORD_CALLCHAIN_DEFERRED event.
> +	 */
>  	u64 deferred_cookie;
> +	/** @insn: A copy of the sampled instruction filled in by perf_sample__fetch_insn. */
>  	char insn[MAX_INSN];
> +	/** @raw_data: Byte aligned pointer into the original event for PERF_SAMPLE_RAW data. */

I think it's 32-bit aligned (or shifted) as it comes right after the
raw_size (32-bit).  As other fields in the event are 64-bit aligned this
caused some troubles like in perf trace when you access the pointer
directly and assume it's naturally aligned.


>  	void *raw_data;
> +	/** @callchain: Pointer into the original event for PERF_SAMPLE_CALLCHAIN data. */
>  	struct ip_callchain *callchain;

If deferred_callchain is not set, it just points to data in the mmap
buffer and it should not be freed.


> +	/** @branch_stack: Pointer into the original event for PERF_SAMPLE_BRANCH_STACK data. */
>  	struct branch_stack *branch_stack;
> +	/**
> +	 * @branch_stack_cntr: Pointer into the original event for
> +	 *                     PERF_SAMPLE_BRANCH_COUNTERS data.
> +	 */
>  	u64 *branch_stack_cntr;
> +	/** @user_regs: Values and pointers into the sample for PERF_SAMPLE_REGS_USER. */
>  	struct regs_dump  *user_regs;
> +	/** @intr_regs: Values and pointers into the sample for PERF_SAMPLE_REGS_INTR. */
>  	struct regs_dump  *intr_regs;
> +	/** @user_stack: Size and pointer into the sample for PERF_SAMPLE_STACK_USER. */
>  	struct stack_dump user_stack;
> +	/** @read: The sample event PERF_SAMPLE_READ counter values. */

The actual format depends on read_format in the event attribute.

Thanks,
Namhyung


>  	struct sample_read read;
> +	/**
> +	 * @aux_sample: Similar to raw data but with a 64-bit size and
> +	 *              alignment, PERF_SAMPLE_AUX data.
> +	 */
>  	struct aux_sample aux_sample;
> +	/** @simd_flags: SIMD flag information from ARM SPE auxiliary events. */
>  	struct simd_flags simd_flags;
>  };
>  
> -- 
> 2.53.0.239.g8d8fc8a987-goog
> 
