Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270352;
	b=vVohNnt5rgG+5K4T9zUHJs1siPySuFuA8eJIgTbSAZ/avEHQCDnQsy0AaeZq4GfkHNf5
	 FY3Fh6ktBAU25fYdF+X7Yf/Tn6hea0NCTKL0EVW+MD9ySIVxOtL/c2O9q1O9e7G9PLup3
	 Dh+Z/KagAeTWKT9ZpWnfSE7x2zMxSN+hRrQs9/vmRP93H9DBZ3CtkdInQfR8nU5fSbrXV
	 GFhHN7DWkvfA0YEwQFNAcxwF9IOXfrXMvcUPR7Idh01JZiByPze3kTkYL5O+o1nMlYoyR
	 WhwN2uPIA32VSbR1l+yEkSf+vaAnci+5znyaWqzCUyFtP5Ham6XgbVCvH9IjpHnkyvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270352;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2iBpIYvAQVfYbcHm8P5x3d3FwdMPuG4nUpVCtNrACCc=;
	b=1De4kDd6/UrpCpsPVQ7BT2MGrx3Lk3NJIBXthIapumYtd49tDoDoWFHIIPxQHOrk/lS4
	 WF0vQN73mkQaC1C67Hd2pk6NiQkeiZikHlXB4CuRt7rSoFmI880SBlshuREX4J5uRrMEI
	 73wu1f3tiV+q08KIWrzugdq43JcL5mmNrBuABqQAQS99dnowsdkZolXEszc/txIWBBPac
	 fFLPvcI45Q6Q3xLMn/AcpaxtVRfMWvHreYjXJHzIdHInMK9fArAEF63wM50Ud9NDh0ATh
	 1JJErXfN+v5rZ1mDfpKvXd3iyr0s5YcWEwa3NO/hxr0RkZhykCJUjS6W0BizxKp6LGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BwSXERQT;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE9E606A31C;
	Thu, 29 Oct 2026 10:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9CE9E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=BwSXERQT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2iBpIYvAQVfYbcHm8P5x3d3FwdMPuG4nUpVCtNrACCc=; b=BwSXERQT4xqnHuZU7jN1KYdtbp
	14xvO0Y4r3bgr2IkRqSKmNJW18K1U1HnxQYx3sTVdLX0pHhLXbfn0Xb0Gq0MNfMQOuIRF9IMWZ5Vs
	+0V1FNETJQw1rBtuX12KU50Vs7RRx11Re7iimQdauXYPNDE1r6jWq6PnQcfUrHauLXRxIT5NXGomm
	YTMQfi9vOqqz6m8j7qeoBM2UoLTbNEX5JslWq0NUHFqFNl74RgpxmYhujpACvdUnNsnWetqUa0qhH
	ti1g3E0BZ/+AB/MvTT9qqZsFgloNCliwDrrLYoT9n/+tJKWc5qgA67DXomn8ThzhCwUcU5tDl2Dfd
	4F0PFkzA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMNX9-0000000GsYl-3479;
	Thu, 29 Oct 2026 10:39:04 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AFB42300312; Thu, 29 Oct 2026 11:38:57 +0100 (CET)
Date: Thu, 29 Oct 2026 11:38:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andi Kleen <ak@linux.intel.com>,
	Eranian Stephane <eranian@google.com>,
	Sandipan Das <sandipan.das@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
	Ravi Bangoria <ravi.bangoria@amd.com>,
	Ananth Narayan <ananth.narayan@amd.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	bpf@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>,
	Zide Chen <zide.chen@intel.com>,
	Falcon Thomas <thomas.falcon@intel.com>,
	Xudong Hao <xudong.hao@intel.com>
Subject: Re: [Patch v5 10/18] perf/x86/intel: Allow LBR read helpers to
 operate on explicit stacks
Message-ID: <20261029103857.GL1779021@noisy.programming.kicks-ass.net>
References: <20261029043914.1395147-1-dapeng1.mi@linux.intel.com>
 <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029043914.1395147-11-dapeng1.mi@linux.intel.com>

On Thu, Oct 29, 2026 at 12:39:06PM +0800, Dapeng Mi wrote:
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index ee724b28d90c..63f0504f9d2a 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -105,7 +105,10 @@
>  
>  #define ARCH_LBR_CTL_MASK			0x7f000e
>  
> -static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc);
> +static void intel_pmu_lbr_filter(struct cpu_hw_events *cpuc,
> +				 struct perf_branch_stack *lbr_stack,
> +				 struct perf_branch_entry *lbr_entries,
> +				 u64 *lbr_counters);
>  
>  static __always_inline bool is_lbr_call_stack_bit_set(u64 config)
>  {
> @@ -741,10 +744,12 @@ void intel_pmu_lbr_disable_all(void)
>  	}
>  }
>  
> -void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
> +void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc,
> +			   struct perf_branch_stack *lbr_stack,
> +			   struct perf_branch_entry *lbr_entries)
>  {
>  	unsigned long mask = x86_pmu.lbr_nr - 1;
> -	struct perf_branch_entry *br = cpuc->lbr_entries;
> +	struct perf_branch_entry *br = lbr_entries;
>  	u64 tos = intel_pmu_lbr_tos();
>  	int i;
>  
> @@ -775,11 +780,13 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
>   * is the same as the linear address, allowing us to merge the LIP and EIP
>   * LBR formats.
>   */
> -void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
> +void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc,
> +			   struct perf_branch_stack *lbr_stack,
> +			   struct perf_branch_entry *lbr_entries)
>  {
>  	bool need_info = false, call_stack = false;
>  	unsigned long mask = x86_pmu.lbr_nr - 1;
> -	struct perf_branch_entry *br = cpuc->lbr_entries;
> +	struct perf_branch_entry *br = lbr_entries;
>  	u64 tos = intel_pmu_lbr_tos();
>  	int i;
>  	int out = 0;

This makes no sense; why do you keep passing lbr_entries around when we
have lbr_stack.entries[] ?
