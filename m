Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0418126C02
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Feb 2026 17:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965519; cv=none; b=GRJT1d1tsbsy/2/VG4/GxxnERTIUSrbld1H3Q9PE5dGnZfqpmVNp28/4w0wcoi56YHDxfBRlWu7EJdqhdwVRAkvmUVHuK6YLpXhERjGvKoVpFZ+P8/QWXY6ViLUmCkUGZeWTzCjnLpnwMDu6e6ZtjRJssHS7das4KAFx3sZfdD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965519; c=relaxed/simple;
	bh=wY+VyyPf+zeTCcAP7D/EEh4FjtCplLqeAmFbZzcG2tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uNUHjO4VU1nRqOIOy3Ceef4DMa3pXYWY2Ta33WYl4cAUFmvCp3mmsBvMZqeFOTILJytI2cfVdjrS+FN0PmzPQy470Q7CzwRKrkkxYEWEUeIhXD8CWaWDrUDlj2KzaG7pbKmRo0p5+cu/vI3r4iouIg5P6s4JiC8N5WhysscKFpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Fzj2chwY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Fzj2chwY"
Date: Mon, 2 Feb 2026 01:04:59 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769965505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0d8C18zxhPbKJRj/EyIvfZeIHT8AN8v0aXncDr3P8s=;
	b=Fzj2chwYYipbTCPPQ7JSl3OKSs+EwJyQyL4t7lRnDgnGr5IHiglASYTPTIQYTMk5zQlpEX
	/paxFKFA/Hw5OasG0G0Ybfy42dQx19odess3NrwFFnMXXubGjBUkCzsSV4xDEW7e8HJJwe
	/UAlcr9kthhIkdr+wEdyj8qhEWaoRvs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>,
	Mike Leach <mike.leach@linaro.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Shimin Guo <shimin.guo@skydio.com>, Yunseong Kim <ysk@kzalloc.com>,
	Athira Rajeev <atrajeev@linux.ibm.com>,
	Quan Zhou <zhouquan@iscas.ac.cn>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Thomas Falcon <thomas.falcon@intel.com>,
	Blake Jones <blakejones@google.com>,
	Swapnil Sapkal <swapnil.sapkal@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Howard Chu <howardchu95@gmail.com>,
	Anubhav Shelat <ashelat@redhat.com>,
	Aditya Bodkhe <aditya.b1@linux.ibm.com>,
	Chun-Tse Shao <ctshao@google.com>, Andi Kleen <ak@linux.intel.com>,
	Dmitry Vyukov <dvyukov@google.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] perf kvm stat: Remove use of the arch directory
Message-ID: <20260201170459.GA584@debian-dev>
References: <20260131200224.1296136-1-irogers@google.com>
 <20260131200224.1296136-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260131200224.1296136-3-irogers@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, Jan 31, 2026 at 12:02:20PM -0800, Ian Rogers wrote:

[...]

> @@ -1666,7 +1661,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
>  		return ret;
>  	}
>  
> -	for (events_tp = kvm_events_tp; *events_tp; events_tp++)
> +	for (events_tp = kvm_events_tp(); *events_tp; events_tp++)
>  		events_tp_size++;
>  
>  	rec_argc = ARRAY_SIZE(record_args) + argc + 2 +
> @@ -1681,7 +1676,7 @@ kvm_events_record(struct perf_kvm_stat *kvm, int argc, const char **argv)
>  
>  	for (j = 0; j < events_tp_size; j++) {
>  		rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
> -		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp[j]);
> +		rec_argv[i++] = STRDUP_FAIL_EXIT(kvm_events_tp()[j]);
>  	}

Nitpick: we can assign reuse events_tp throughout the
kvm_events_record().  Something like:

  events_tp = kvm_events_tp();
  for (j = 0; events_tp[j]; j++)
       events_tp_size++;

  ...

  for (j = 0; j < events_tp_size; j++) {
       rec_argv[i++] = STRDUP_FAIL_EXIT("-e");
       rec_argv[i++] = STRDUP_FAIL_EXIT(events_tp[j]);
  }

[...]

> +int setup_kvm_events_tp(struct perf_kvm_stat *kvm)
> +{
> +	switch (EM_HOST) {
> +	case EM_PPC:
> +	case EM_PPC64:
> +		return __setup_kvm_events_tp_powerpc(kvm);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
> +{
> +	switch (EM_HOST) {
> +	case EM_AARCH64:
> +		return __cpu_isa_init_arm64(kvm);
> +	case EM_LOONGARCH:
> +		return __cpu_isa_init_loongarch(kvm);
> +	case EM_PPC:
> +	case EM_PPC64:
> +		return __cpu_isa_init_powerpc(kvm);
> +	case EM_RISCV:
> +		return __cpu_isa_init_riscv(kvm);
> +	case EM_S390:
> +		return __cpu_isa_init_s390(kvm, cpuid);
> +	case EM_X86_64:
> +	case EM_386:
> +		return __cpu_isa_init_x86(kvm, cpuid);
> +	default:
> +		pr_err("Unsupported kvm-stat host %d\n", EM_HOST);
> +		return -1;
> +	}
> +}

For a general solution, I'd prefer to use "install" + callback methods
rather than the opened code.  E.g., each arch installs a structure
with callbacks:

  struct kvm_stat_arch kvm_stat_aarch64 {
      .setup_events_tp = NULL;
      .cpu_isa_init    = __cpu_isa_init_arm64;
      ...
  };

Then at the init phase, we can install arch's structure:

  switch (EM_HOST) {
  case EM_AARCH64:
      kvm_stat_arch_init(&kvm_stat_aarch64);
      break;
  ...
  }

Afterwards, it is no need to check EM_HOST anymore, it can simply
invoke the arch's callback:

  int cpu_isa_init(struct perf_kvm_stat *kvm, const char *cpuid)
  {
      if (!arch_kvm_stat || !arch_kvm_stat->cpu_isa_init)
          return -1;

      return arch_kvm_stat->cpu_isa_init(kvm, cpuid);
  }

As a result, we can avoid spreading "switch (EM_HOST)" everywhere.

Thanks,
Leo
