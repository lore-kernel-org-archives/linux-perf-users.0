Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58D1C2305;
	Tue,  6 Aug 2024 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722941997; cv=none; b=moLQA571BNXOhKArxUcw5PSmUdetwMz5HBn1HQG5CjhdgDObZzg2qR54FxLpCjkg6j0aXDHk+EWzSs/pCorSwAEG6ugnDs3F8iEQvaWicurkF7frex1cclMtcp3m8og3FcCD/i1yxa7LmOmAXM+jRE+k49+dPefd4+/caq7KL6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722941997; c=relaxed/simple;
	bh=UE9CfY3BL7+FOuNznj22gUfDXffqPAM5cNoS37kH3xY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+nl8HVNkFInItNSPw6yrd9xkKAoEh+KObZAzLko/HVE+z35pd8luK+9mVtWgJ67BW9kwwQ1HjKOrwXGewP2desLq1mqJ324pHrSUV7EPKIf5RHcD2UHMSv0CAALgV3RDKzxew1HB816BmNZkWlDWLeCuVr6Z7eh5o2/1geuXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qP7y6aSH; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qP7y6aSH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LNEUfQTr0yN0Ra3a/xSbTjer6XMFV2nF/VaAnWGPJoc=; b=qP7y6aSHdOLpxqtjAYLKaJ3Pxk
	/Lej2fceXxtg4aS4wQEM1QQjA3C86DK/lNvKOP8F5rts84L9zBJ+uBpx3WrADqn/GQbCyykUF1rjP
	8tOZnXI1OlPz/eELJytg/jdHLDVZhzMSYfhBotbEPRAjO3qZUAljOMVFcnNCaS9ZXw217yiAD6eIw
	6IXAds9RAekk9hr/QIRqjaTtBoDCFK1cNHNoknY00ol5D/ykd0NBGv0wDelU7Nzs48wolCKr8C6OO
	7wloEq9oWrzgk/jE/QvCuX/3KbJrqlMLeJq0CHIRHZu6haUE1deZjX7Cldvp+AvmcJGwWEHcyXY4y
	+sNSzS2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sbHun-00000006R14-3PJI;
	Tue, 06 Aug 2024 10:59:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 21B1630049D; Tue,  6 Aug 2024 12:59:41 +0200 (CEST)
Date: Tue, 6 Aug 2024 12:59:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
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
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] perf: Avoid -Wflex-array-member-not-at-end warnings
Message-ID: <20240806105941.GV37996@noisy.programming.kicks-ass.net>
References: <ZrFVW+6OOJ2tX23N@cute>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrFVW+6OOJ2tX23N@cute>

On Mon, Aug 05, 2024 at 04:42:35PM -0600, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of multiple other structs, we use the `struct_group_tagged()`
> helper to create a new tagged `struct perf_branch_stack_hdr`.
> This structure groups together all the members of the flexible
> `struct perf_branch_stack` except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct members currently causing
> trouble from `struct perf_branch_stack` to `struct perf_branch_stack_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct perf_branch_stack_hdr`
> as a completely separate structure, thus preventing having to maintain
> two independent but basically identical structures, closing the door
> to potential bugs in the future.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which the flexible-array member can be
> accessed, if necessary.
> 
> So, with these changes, fix the following warnings:
> arch/x86/events/amd/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> arch/x86/events/intel/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> arch/x86/events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> arch/x86/events/zhaoxin/../perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> ./arch/x86/include/generated/../../events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> arch/x86/xen/../events/perf_event.h:289:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Urgh, this fugly.. And you're breaking coding style :-(

Let me see if this can't be done sanely...

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  arch/x86/events/amd/core.c   | 4 +++-
>  arch/x86/events/core.c       | 4 +++-
>  arch/x86/events/intel/ds.c   | 4 +++-
>  arch/x86/events/intel/lbr.c  | 8 ++++++--
>  arch/x86/events/perf_event.h | 2 +-
>  include/linux/perf_event.h   | 9 +++++++--
>  6 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
> index 920e3a640cad..37adf2fcf508 100644
> --- a/arch/x86/events/amd/core.c
> +++ b/arch/x86/events/amd/core.c
> @@ -1001,7 +1001,9 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
>  			continue;
>  
>  		if (has_branch_stack(event))
> -			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
> +			perf_sample_save_brstack(&data, event,
> +				container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
> +				NULL);
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> index 12f2a0c14d33..e7faf7eedfc4 100644
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -1704,7 +1704,9 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
>  		perf_sample_data_init(&data, 0, event->hw.last_period);
>  
>  		if (has_branch_stack(event))
> -			perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
> +			perf_sample_save_brstack(&data, event,
> +				container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
> +				NULL);
>  
>  		if (perf_event_overflow(event, &data, regs))
>  			x86_pmu_stop(event, 0);
> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index fa5ea65de0d0..d5c86edbeaa9 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1869,7 +1869,9 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
>  		setup_pebs_time(event, data, pebs->tsc);
>  
>  	if (has_branch_stack(event))
> -		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
> +		perf_sample_save_brstack(data, event,
> +			container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
> +			NULL);
>  }
>  
>  static void adaptive_pebs_save_regs(struct pt_regs *regs,
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index dc641b50814e..79ca1a2d6ff4 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -974,11 +974,15 @@ void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
>  {
>  	if (is_branch_counters_group(event)) {
>  		intel_pmu_lbr_counters_reorder(cpuc, event);
> -		perf_sample_save_brstack(data, event, &cpuc->lbr_stack, cpuc->lbr_counters);
> +		perf_sample_save_brstack(data, event,
> +			container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
> +			cpuc->lbr_counters);
>  		return;
>  	}
>  
> -	perf_sample_save_brstack(data, event, &cpuc->lbr_stack, NULL);
> +	perf_sample_save_brstack(data, event,
> +		container_of(&cpuc->lbr_stack, struct perf_branch_stack, hdr),
> +		NULL);
>  }
>  
>  static void intel_pmu_arch_lbr_read(struct cpu_hw_events *cpuc)
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index ac1182141bf6..bf05cdc3f22f 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -286,7 +286,7 @@ struct cpu_hw_events {
>  	 */
>  	int				lbr_users;
>  	int				lbr_pebs_users;
> -	struct perf_branch_stack	lbr_stack;
> +	struct perf_branch_stack_hdr	lbr_stack;
>  	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
>  	u64				lbr_counters[MAX_LBR_ENTRIES]; /* branch stack extra */
>  	union {
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 1a8942277dda..eb4413917b39 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -121,10 +121,15 @@ static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
>   * already stored in age order, the hw_idx should be 0.
>   */
>  struct perf_branch_stack {
> -	__u64				nr;
> -	__u64				hw_idx;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(perf_branch_stack_hdr, hdr,
> +		__u64				nr;
> +		__u64				hw_idx;
> +	);
>  	struct perf_branch_entry	entries[];
>  };
> +static_assert(offsetof(struct perf_branch_stack, entries) == sizeof(struct perf_branch_stack_hdr),
> +	      "struct member likely outside of struct_group_tagged()");
>  
>  struct task_struct;
>  
> -- 
> 2.34.1
> 
