Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C14B2E2679;
	Mon, 26 Jan 2026 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418263; cv=none; b=TZxsRgpXOr97aPwr4xAZQ4fWsWED4DOhebor8sXsrYpXWSD0K650K8UOHNrbOBghCpojFHxdIGIHZZ0gBdoVJ2eD5YbKnhX3wnz/cRmlsC2SHE1vUYvCW9oy6dqQqHsUFo6zyrMWegEn4yuiIGRfpk0SZTNZD7Vh3xhJowrvBdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418263; c=relaxed/simple;
	bh=Ja9EnYjXELWIal++1MKp1wFt/uLaYUu4n59sNt7QY/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qfI/7U+xwOHTAJN/23QNSrDcS5zGFa05Yd+rlfDuL5X3Oynly1dtJUdplj8uRiYP86dn4B/NiqtjJfgYPSOZmeazy3YOUX2oAlyOzI/l4b4C7FyDeby/8LEjxykqaF0mHMb7OtB1pMVyQEM3adpIb9kELz32I0llN0ywQViGEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIzQVx0w; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIzQVx0w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769418256; x=1800954256;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=Ja9EnYjXELWIal++1MKp1wFt/uLaYUu4n59sNt7QY/o=;
  b=HIzQVx0wDOVtblCI2fEb3zYZ30M6M/pYxINbDqEfYcfCTJEQmcd9CbO9
   SyduiC2QWqGbGGsGHHjIiyC2P+rlj9rUk7fS7NKvGU3euSrQCI3XDuD1T
   PKS15o1+EguZgwqJvOrFbZlmRZBBRZS0brk9QHbLt5TXlXSMGLTYCBpvU
   jr8Bb02fQilhhZ1M8ZRgTAQaVlUrygrwocK3aAFJGwkcNeY0jz06ImUCi
   D9zU3487+I/LTFUVbabIDXw3seHgx4XQ0YGmC+HZqAookelpBkA/REoS/
   hwAhsNR8h9dHQotuuF6tQr+mrFg3FmGlvfjbJJXLxjdERSwnPkvxO1dv5
   w==;
X-CSE-ConnectionGUID: wLKF9NlGTz21jPEID8DpHw==
X-CSE-MsgGUID: S624XhXmT+SKAPKqSbW04Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="70636399"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="70636399"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:04:12 -0800
X-CSE-ConnectionGUID: DAI1NKblRwCjh5HQh27eoQ==
X-CSE-MsgGUID: vO2dCppOTiiHjhtY1YqlwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="245242100"
Received: from dapengmi-mobl1.ccr.corp.intel.com (HELO [10.124.240.14]) ([10.124.240.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2026 01:04:01 -0800
Message-ID: <363a4dd6-25c1-4bb4-8b53-64e00baa1a9a@linux.intel.com>
Date: Mon, 26 Jan 2026 17:03:58 +0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] perf sample: Add evsel to sample and avoid passing
 as a pair
To: Ian Rogers <irogers@google.com>, John Garry <john.g.garry@oracle.com>,
 Will Deacon <will@kernel.org>, James Clark <james.clark@linaro.org>,
 Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Andrew Jones <ajones@ventanamicro.com>, Quan Zhou <zhouquan@iscas.ac.cn>,
 Anup Patel <anup@brainfault.org>, Tianyou Li <tianyou.li@intel.com>,
 Athira Rajeev <atrajeev@linux.ibm.com>,
 Derek Foreman <derek.foreman@collabora.com>,
 Aditya Bodkhe <aditya.b1@linux.ibm.com>,
 Kan Liang <kan.liang@linux.intel.com>, Howard Chu <howardchu95@gmail.com>,
 Thomas Falcon <thomas.falcon@intel.com>, Dmitry Vyukov <dvyukov@google.com>,
 Andi Kleen <ak@linux.intel.com>, tanze <tanze@kylinos.cn>,
 Hrishikesh Suresh <hrishikesh123s@gmail.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 =?UTF-8?Q?Krzysztof_=C5=81opatowski?= <krzysztof.m.lopatowski@gmail.com>,
 Chun-Tse Shao <ctshao@google.com>, Swapnil Sapkal <swapnil.sapkal@amd.com>,
 Blake Jones <blakejones@google.com>, Yujie Liu <yujie.liu@intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20260126071822.447368-1-irogers@google.com>
Content-Language: en-US
From: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
In-Reply-To: <20260126071822.447368-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 1/26/2026 3:18 PM, Ian Rogers wrote:
> The perf_sample and evsel are typically passed as a pair. This creates
> 2 arguments for the price of 1. It is also inconvenient if you wish to
> rewrite a sample, as the evsel will need updating in all cases,
> something similar to this currently happens for off-cpu output. Avoid
> passing the evsel by adding it into the sample. So that two evsels
> aren't being passed around, fix up functions taking a sample and an
> evsel argument to only take a sample, the evsel now being able to be
> read from the sample.
>
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
> This is a fairly large and invasive change but doing something some
> what mundane. Sending out as an RFC for early feedback.

Nice cleanup. Better split this huge patch into several patches in the
formal patch-set. Thanks.


> ---
>  tools/perf/arch/arm64/util/kvm-stat.c         |  21 +-
>  tools/perf/arch/loongarch/util/kvm-stat.c     |  17 +-
>  tools/perf/arch/powerpc/util/kvm-stat.c       |  16 +-
>  tools/perf/arch/riscv/util/kvm-stat.c         |  18 +-
>  tools/perf/arch/s390/util/kvm-stat.c          |  20 +-
>  tools/perf/arch/x86/util/kvm-stat.c           |  67 +++---
>  tools/perf/builtin-annotate.c                 |  22 +-
>  tools/perf/builtin-c2c.c                      |   6 +-
>  tools/perf/builtin-diff.c                     |   5 +-
>  tools/perf/builtin-inject.c                   |  17 +-
>  tools/perf/builtin-kmem.c                     |  55 +++--
>  tools/perf/builtin-kvm.c                      |  22 +-
>  tools/perf/builtin-kwork.c                    | 111 ++++------
>  tools/perf/builtin-lock.c                     | 118 +++++------
>  tools/perf/builtin-mem.c                      |   1 -
>  tools/perf/builtin-record.c                   |   3 +-
>  tools/perf/builtin-report.c                   |  32 ++-
>  tools/perf/builtin-sched.c                    | 190 ++++++++----------
>  tools/perf/builtin-script.c                   |  53 ++---
>  tools/perf/builtin-timechart.c                |  77 +++----
>  tools/perf/builtin-top.c                      |  10 +-
>  tools/perf/builtin-trace.c                    |  97 ++++-----
>  tools/perf/tests/hists_cumulate.c             |   3 +-
>  tools/perf/tests/hists_filter.c               |   2 +-
>  tools/perf/tests/hists_output.c               |   3 +-
>  tools/perf/tests/openat-syscall-tp-fields.c   |   2 +-
>  tools/perf/tests/switch-tracking.c            |   4 +-
>  tools/perf/util/annotate.c                    |  13 +-
>  tools/perf/util/annotate.h                    |   6 +-
>  tools/perf/util/build-id.c                    |   3 +-
>  tools/perf/util/build-id.h                    |   5 +-
>  tools/perf/util/callchain.c                   |   8 +-
>  tools/perf/util/callchain.h                   |   4 +-
>  tools/perf/util/data-convert-bt.c             |   2 +-
>  tools/perf/util/data-convert-json.c           |   5 +-
>  tools/perf/util/db-export.c                   |  16 +-
>  tools/perf/util/db-export.h                   |   3 +-
>  tools/perf/util/evsel.c                       |  37 +++-
>  tools/perf/util/evsel.h                       |  12 +-
>  tools/perf/util/hist.c                        |  31 +--
>  tools/perf/util/hist.h                        |   3 +-
>  tools/perf/util/intel-pt.c                    |   5 +-
>  tools/perf/util/intel-tpebs.c                 |   3 +-
>  tools/perf/util/jitdump.c                     |   2 +-
>  tools/perf/util/kvm-stat.c                    |  17 +-
>  tools/perf/util/kvm-stat.h                    |  18 +-
>  tools/perf/util/kwork.h                       |   9 +-
>  tools/perf/util/machine.c                     |  14 +-
>  tools/perf/util/machine.h                     |   3 -
>  tools/perf/util/sample.h                      |   1 +
>  .../util/scripting-engines/trace-event-perl.c |  23 +--
>  .../scripting-engines/trace-event-python.c    |  34 ++--
>  tools/perf/util/session.c                     |  63 +++---
>  tools/perf/util/tool.c                        |   4 +-
>  tools/perf/util/tool.h                        |   4 +-
>  tools/perf/util/trace-event-scripting.c       |   5 +-
>  tools/perf/util/trace-event.h                 |   3 -
>  57 files changed, 599 insertions(+), 749 deletions(-)
>
> diff --git a/tools/perf/arch/arm64/util/kvm-stat.c b/tools/perf/arch/arm64/util/kvm-stat.c
> index 6611aa21cba9..14b191410cc9 100644
> --- a/tools/perf/arch/arm64/util/kvm-stat.c
> +++ b/tools/perf/arch/arm64/util/kvm-stat.c
> @@ -21,12 +21,11 @@ const char *kvm_events_tp[] = {
>  	NULL,
>  };
>  
> -static void event_get_key(struct evsel *evsel,
> -			  struct perf_sample *sample,
> +static void event_get_key(struct perf_sample *sample,
>  			  struct event_key *key)
>  {
>  	key->info = 0;
> -	key->key = evsel__intval(evsel, sample, kvm_exit_reason);
> +	key->key = evsel__intval(sample, kvm_exit_reason);
>  	key->exit_reasons = arm64_exit_reasons;
>  
>  	/*
> @@ -35,24 +34,20 @@ static void event_get_key(struct evsel *evsel,
>  	 * properly decode event's est_ec.
>  	 */
>  	if (key->key == ARM_EXCEPTION_TRAP) {
> -		key->key = evsel__intval(evsel, sample, kvm_trap_exit_reason);
> +		key->key = evsel__intval(sample, kvm_trap_exit_reason);
>  		key->exit_reasons = arm64_trap_exit_reasons;
>  	}
>  }
>  
> -static bool event_begin(struct evsel *evsel,
> -			struct perf_sample *sample __maybe_unused,
> -			struct event_key *key __maybe_unused)
> +static bool event_begin(struct perf_sample *sample, struct event_key *key __maybe_unused)
>  {
> -	return evsel__name_is(evsel, kvm_entry_trace);
> +	return evsel__name_is(sample->evsel, kvm_entry_trace);
>  }
>  
> -static bool event_end(struct evsel *evsel,
> -		      struct perf_sample *sample,
> -		      struct event_key *key)
> +static bool event_end(struct perf_sample *sample, struct event_key *key)
>  {
> -	if (evsel__name_is(evsel, kvm_exit_trace)) {
> -		event_get_key(evsel, sample, key);
> +	if (evsel__name_is(sample->evsel, kvm_exit_trace)) {
> +		event_get_key(sample, key);
>  		return true;
>  	}
>  	return false;
> diff --git a/tools/perf/arch/loongarch/util/kvm-stat.c b/tools/perf/arch/loongarch/util/kvm-stat.c
> index a7859a3a9a51..2d2bf9c41acd 100644
> --- a/tools/perf/arch/loongarch/util/kvm-stat.c
> +++ b/tools/perf/arch/loongarch/util/kvm-stat.c
> @@ -56,15 +56,12 @@ const char *kvm_events_tp[] = {
>  	NULL,
>  };
>  
> -static bool event_begin(struct evsel *evsel,
> -			struct perf_sample *sample, struct event_key *key)
> +static bool event_begin(struct perf_sample *sample, struct event_key *key)
>  {
> -	return exit_event_begin(evsel, sample, key);
> +	return exit_event_begin(sample, key);
>  }
>  
> -static bool event_end(struct evsel *evsel,
> -		      struct perf_sample *sample __maybe_unused,
> -		      struct event_key *key __maybe_unused)
> +static bool event_end(struct perf_sample *sample, struct event_key *key __maybe_unused)
>  {
>  	/*
>  	 * LoongArch kvm is different with other architectures
> @@ -74,16 +71,16 @@ static bool event_end(struct evsel *evsel,
>  	 *   kvm:kvm_enter   means returning to vmm and then to guest
>  	 *   kvm:kvm_reenter means returning to guest immediately
>  	 */
> -	return evsel__name_is(evsel, kvm_entry_trace) || evsel__name_is(evsel, kvm_reenter_trace);
> +	return evsel__name_is(sample->evsel, kvm_entry_trace) ||
> +	       evsel__name_is(sample->evsel, kvm_reenter_trace);
>  }
>  
> -static void event_gspr_get_key(struct evsel *evsel,
> -			       struct perf_sample *sample, struct event_key *key)
> +static void event_gspr_get_key(struct perf_sample *sample, struct event_key *key)
>  {
>  	unsigned int insn;
>  
>  	key->key = LOONGARCH_EXCEPTION_OTHERS;
> -	insn = evsel__intval(evsel, sample, "inst_word");
> +	insn = evsel__intval(sample, "inst_word");
>  
>  	switch (insn >> 24) {
>  	case 0:
> diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
> index c8357b571ccf..52a56df3bffa 100644
> --- a/tools/perf/arch/powerpc/util/kvm-stat.c
> +++ b/tools/perf/arch/powerpc/util/kvm-stat.c
> @@ -33,12 +33,11 @@ const char *ppc_book3s_hv_kvm_tp[] = {
>  const char *kvm_events_tp[NR_TPS + 1];
>  const char *kvm_exit_reason;
>  
> -static void hcall_event_get_key(struct evsel *evsel,
> -				struct perf_sample *sample,
> +static void hcall_event_get_key(struct perf_sample *sample,
>  				struct event_key *key)
>  {
>  	key->info = 0;
> -	key->key = evsel__intval(evsel, sample, "req");
> +	key->key = evsel__intval(sample, "req");
>  }
>  
>  static const char *get_hcall_exit_reason(u64 exit_code)
> @@ -56,17 +55,14 @@ static const char *get_hcall_exit_reason(u64 exit_code)
>  	return "UNKNOWN";
>  }
>  
> -static bool hcall_event_end(struct evsel *evsel,
> -			    struct perf_sample *sample __maybe_unused,
> -			    struct event_key *key __maybe_unused)
> +static bool hcall_event_end(struct perf_sample *sample, struct event_key *key __maybe_unused)
>  {
> -	return (evsel__name_is(evsel, kvm_events_tp[3]));
> +	return evsel__name_is(sample->evsel, kvm_events_tp[3]);
>  }
>  
> -static bool hcall_event_begin(struct evsel *evsel,
> -			      struct perf_sample *sample, struct event_key *key)
> +static bool hcall_event_begin(struct perf_sample *sample, struct event_key *key)
>  {
> -	if (evsel__name_is(evsel, kvm_events_tp[2])) {
> +	if (evsel__name_is(sample->evsel, kvm_events_tp[2])) {
>  		hcall_event_get_key(evsel, sample, key);
>  		return true;
>  	}
> diff --git a/tools/perf/arch/riscv/util/kvm-stat.c b/tools/perf/arch/riscv/util/kvm-stat.c
> index 3ea7acb5e159..e6107048a669 100644
> --- a/tools/perf/arch/riscv/util/kvm-stat.c
> +++ b/tools/perf/arch/riscv/util/kvm-stat.c
> @@ -25,28 +25,24 @@ const char *kvm_events_tp[] = {
>  	NULL,
>  };
>  
> -static void event_get_key(struct evsel *evsel,
> -			  struct perf_sample *sample,
> +static void event_get_key(struct perf_sample *sample,
>  			  struct event_key *key)
>  {
>  	key->info = 0;
> -	key->key = evsel__intval(evsel, sample, kvm_exit_reason) & ~CAUSE_IRQ_FLAG;
> +	key->key = evsel__intval(sample, kvm_exit_reason) & ~CAUSE_IRQ_FLAG;
>  	key->exit_reasons = riscv_exit_reasons;
>  }
>  
> -static bool event_begin(struct evsel *evsel,
> -			struct perf_sample *sample __maybe_unused,
> -			struct event_key *key __maybe_unused)
> +static bool event_begin(struct perf_sample *sample, struct event_key *key __maybe_unused)
>  {
> -	return evsel__name_is(evsel, kvm_entry_trace);
> +	return evsel__name_is(sample->evsel, kvm_entry_trace);
>  }
>  
> -static bool event_end(struct evsel *evsel,
> -		      struct perf_sample *sample,
> +static bool event_end(struct perf_sample *sample,
>  		      struct event_key *key)
>  {
> -	if (evsel__name_is(evsel, kvm_exit_trace)) {
> -		event_get_key(evsel, sample, key);
> +	if (evsel__name_is(sample->evsel, kvm_exit_trace)) {
> +		event_get_key(sample, key);
>  		return true;
>  	}
>  	return false;
> diff --git a/tools/perf/arch/s390/util/kvm-stat.c b/tools/perf/arch/s390/util/kvm-stat.c
> index 0aed92df51ba..6d2471672640 100644
> --- a/tools/perf/arch/s390/util/kvm-stat.c
> +++ b/tools/perf/arch/s390/util/kvm-stat.c
> @@ -23,38 +23,34 @@ const char *kvm_exit_reason = "icptcode";
>  const char *kvm_entry_trace = "kvm:kvm_s390_sie_enter";
>  const char *kvm_exit_trace = "kvm:kvm_s390_sie_exit";
>  
> -static void event_icpt_insn_get_key(struct evsel *evsel,
> -				    struct perf_sample *sample,
> +static void event_icpt_insn_get_key(struct perf_sample *sample,
>  				    struct event_key *key)
>  {
>  	unsigned long insn;
>  
> -	insn = evsel__intval(evsel, sample, "instruction");
> +	insn = evsel__intval(sample, "instruction");
>  	key->key = icpt_insn_decoder(insn);
>  	key->exit_reasons = sie_icpt_insn_codes;
>  }
>  
> -static void event_sigp_get_key(struct evsel *evsel,
> -			       struct perf_sample *sample,
> +static void event_sigp_get_key(struct perf_sample *sample,
>  			       struct event_key *key)
>  {
> -	key->key = evsel__intval(evsel, sample, "order_code");
> +	key->key = evsel__intval(sample, "order_code");
>  	key->exit_reasons = sie_sigp_order_codes;
>  }
>  
> -static void event_diag_get_key(struct evsel *evsel,
> -			       struct perf_sample *sample,
> +static void event_diag_get_key(struct perf_sample *sample,
>  			       struct event_key *key)
>  {
> -	key->key = evsel__intval(evsel, sample, "code");
> +	key->key = evsel__intval(sample, "code");
>  	key->exit_reasons = sie_diagnose_codes;
>  }
>  
> -static void event_icpt_prog_get_key(struct evsel *evsel,
> -				    struct perf_sample *sample,
> +static void event_icpt_prog_get_key(struct perf_sample *sample,
>  				    struct event_key *key)
>  {
> -	key->key = evsel__intval(evsel, sample, "code");
> +	key->key = evsel__intval(sample, "code");
>  	key->exit_reasons = sie_icpt_prog_codes;
>  }
>  
> diff --git a/tools/perf/arch/x86/util/kvm-stat.c b/tools/perf/arch/x86/util/kvm-stat.c
> index bff36f9345ea..d271d393cdaa 100644
> --- a/tools/perf/arch/x86/util/kvm-stat.c
> +++ b/tools/perf/arch/x86/util/kvm-stat.c
> @@ -29,45 +29,46 @@ const char *kvm_exit_trace = "kvm:kvm_exit";
>   * the time of MMIO write: kvm_mmio(KVM_TRACE_MMIO_WRITE...) -> kvm_entry
>   * the time of MMIO read: kvm_exit -> kvm_mmio(KVM_TRACE_MMIO_READ...).
>   */
> -static void mmio_event_get_key(struct evsel *evsel, struct perf_sample *sample,
> -			       struct event_key *key)
> +static void mmio_event_get_key(struct perf_sample *sample, struct event_key *key)
>  {
> -	key->key  = evsel__intval(evsel, sample, "gpa");
> -	key->info = evsel__intval(evsel, sample, "type");
> +	key->key  = evsel__intval(sample, "gpa");
> +	key->info = evsel__intval(sample, "type");
>  }
>  
>  #define KVM_TRACE_MMIO_READ_UNSATISFIED 0
>  #define KVM_TRACE_MMIO_READ 1
>  #define KVM_TRACE_MMIO_WRITE 2
>  
> -static bool mmio_event_begin(struct evsel *evsel,
> -			     struct perf_sample *sample, struct event_key *key)
> +static bool mmio_event_begin(struct perf_sample *sample, struct event_key *key)
>  {
> +	struct evsel *evsel = sample->evsel;
> +
>  	/* MMIO read begin event in kernel. */
>  	if (kvm_exit_event(evsel))
>  		return true;
>  
>  	/* MMIO write begin event in kernel. */
>  	if (evsel__name_is(evsel, "kvm:kvm_mmio") &&
> -	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_WRITE) {
> -		mmio_event_get_key(evsel, sample, key);
> +	    evsel__intval(sample, "type") == KVM_TRACE_MMIO_WRITE) {
> +		mmio_event_get_key(sample, key);
>  		return true;
>  	}
>  
>  	return false;
>  }
>  
> -static bool mmio_event_end(struct evsel *evsel, struct perf_sample *sample,
> -			   struct event_key *key)
> +static bool mmio_event_end(struct perf_sample *sample, struct event_key *key)
>  {
> +	struct evsel *evsel = sample->evsel;
> +
>  	/* MMIO write end event in kernel. */
>  	if (kvm_entry_event(evsel))
>  		return true;
>  
>  	/* MMIO read end event in kernel.*/
>  	if (evsel__name_is(evsel, "kvm:kvm_mmio") &&
> -	    evsel__intval(evsel, sample, "type") == KVM_TRACE_MMIO_READ) {
> -		mmio_event_get_key(evsel, sample, key);
> +	    evsel__intval(sample, "type") == KVM_TRACE_MMIO_READ) {
> +		mmio_event_get_key(sample, key);
>  		return true;
>  	}
>  
> @@ -91,31 +92,27 @@ static struct kvm_events_ops mmio_events = {
>  };
>  
>   /* The time of emulation pio access is from kvm_pio to kvm_entry. */
> -static void ioport_event_get_key(struct evsel *evsel,
> -				 struct perf_sample *sample,
> +static void ioport_event_get_key(struct perf_sample *sample,
>  				 struct event_key *key)
>  {
> -	key->key  = evsel__intval(evsel, sample, "port");
> -	key->info = evsel__intval(evsel, sample, "rw");
> +	key->key  = evsel__intval(sample, "port");
> +	key->info = evsel__intval(sample, "rw");
>  }
>  
> -static bool ioport_event_begin(struct evsel *evsel,
> -			       struct perf_sample *sample,
> +static bool ioport_event_begin(struct perf_sample *sample,
>  			       struct event_key *key)
>  {
> -	if (evsel__name_is(evsel, "kvm:kvm_pio")) {
> -		ioport_event_get_key(evsel, sample, key);
> +	if (evsel__name_is(sample->evsel, "kvm:kvm_pio")) {
> +		ioport_event_get_key(sample, key);
>  		return true;
>  	}
>  
>  	return false;
>  }
>  
> -static bool ioport_event_end(struct evsel *evsel,
> -			     struct perf_sample *sample __maybe_unused,
> -			     struct event_key *key __maybe_unused)
> +static bool ioport_event_end(struct perf_sample *sample, struct event_key *key __maybe_unused)
>  {
> -	return kvm_entry_event(evsel);
> +	return kvm_entry_event(sample->evsel);
>  }
>  
>  static void ioport_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
> @@ -135,31 +132,25 @@ static struct kvm_events_ops ioport_events = {
>  };
>  
>   /* The time of emulation msr is from kvm_msr to kvm_entry. */
> -static void msr_event_get_key(struct evsel *evsel,
> -				 struct perf_sample *sample,
> -				 struct event_key *key)
> +static void msr_event_get_key(struct perf_sample *sample, struct event_key *key)
>  {
> -	key->key  = evsel__intval(evsel, sample, "ecx");
> -	key->info = evsel__intval(evsel, sample, "write");
> +	key->key  = evsel__intval(sample, "ecx");
> +	key->info = evsel__intval(sample, "write");
>  }
>  
> -static bool msr_event_begin(struct evsel *evsel,
> -			       struct perf_sample *sample,
> -			       struct event_key *key)
> +static bool msr_event_begin(struct perf_sample *sample, struct event_key *key)
>  {
> -	if (evsel__name_is(evsel, "kvm:kvm_msr")) {
> -		msr_event_get_key(evsel, sample, key);
> +	if (evsel__name_is(sample->evsel, "kvm:kvm_msr")) {
> +		msr_event_get_key(sample, key);
>  		return true;
>  	}
>  
>  	return false;
>  }
>  
> -static bool msr_event_end(struct evsel *evsel,
> -			     struct perf_sample *sample __maybe_unused,
> -			     struct event_key *key __maybe_unused)
> +static bool msr_event_end(struct perf_sample *sample, struct event_key *key __maybe_unused)
>  {
> -	return kvm_entry_event(evsel);
> +	return kvm_entry_event(sample->evsel);
>  }
>  
>  static void msr_event_decode_key(struct perf_kvm_stat *kvm __maybe_unused,
> diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
> index 9c27bb30b708..cd3ff5530be1 100644
> --- a/tools/perf/builtin-annotate.c
> +++ b/tools/perf/builtin-annotate.c
> @@ -177,29 +177,26 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>  	struct hist_entry *he = iter->he;
>  	struct branch_info *bi;
>  	struct perf_sample *sample = iter->sample;
> -	struct evsel *evsel = iter->evsel;
>  	int err;
>  
>  	bi = he->branch_info;
> -	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
> +	err = addr_map_symbol__inc_samples(&bi->from, sample);
>  
>  	if (err)
>  		goto out;
>  
> -	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
> +	err = addr_map_symbol__inc_samples(&bi->to, sample);
>  
>  out:
>  	return err;
>  }
>  
> -static int process_branch_callback(struct evsel *evsel,
> -				   struct perf_sample *sample,
> +static int process_branch_callback(struct perf_sample *sample,
>  				   struct addr_location *al,
>  				   struct perf_annotate *ann,
>  				   struct machine *machine)
>  {
>  	struct hist_entry_iter iter = {
> -		.evsel		= evsel,
>  		.sample		= sample,
>  		.add_entry_cb	= hist_iter__branch_callback,
>  		.hide_unresolved	= symbol_conf.hide_unresolved,
> @@ -222,8 +219,7 @@ static int process_branch_callback(struct evsel *evsel,
>  	if (a.map != NULL)
>  		dso__set_hit(map__dso(a.map));
>  
> -	hist__account_cycles(sample->branch_stack, al, sample, false,
> -			     NULL, evsel);
> +	hist__account_cycles(sample->branch_stack, al, sample, false, NULL);
>  
>  	ret = hist_entry_iter__add(&iter, &a, PERF_MAX_STACK_DEPTH, ann);
>  out:
> @@ -270,13 +266,14 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
>  	process_branch_stack(sample->branch_stack, al, sample);
>  
>  	if (ann->has_br_stack && has_annotation(ann))
> -		return process_branch_callback(evsel, sample, al, ann, machine);
> +		return process_branch_callback(sample, al, ann, machine);
>  
> -	he = hists__add_entry(hists, al, NULL, NULL, NULL, NULL, sample, true);
> +	he = hists__add_entry(hists, al, /*parent=*/NULL, /*bi=*/NULL, /*mi=*/NULL,
> +			      /*ki=*/NULL, sample, /*sample_self=*/true);
>  	if (he == NULL)
>  		return -ENOMEM;
>  
> -	ret = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
> +	ret = hist_entry__inc_addr_samples(he, sample, al->addr);
>  	hists__inc_nr_samples(hists, true);
>  	return ret;
>  }
> @@ -284,7 +281,6 @@ static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	struct perf_annotate *ann = container_of(tool, struct perf_annotate, tool);
> @@ -303,7 +299,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  		goto out_put;
>  
>  	if (!al.filtered &&
> -	    evsel__add_sample(evsel, sample, &al, ann, machine)) {
> +	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
>  		pr_warning("problem incrementing symbol count, "
>  			   "skipping event\n");
>  		ret = -1;
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index d390ae4e3ec8..908a34bbec02 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -314,7 +314,6 @@ static void perf_c2c__evsel_hists_inc_stats(struct evsel *evsel,
>  static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	struct c2c_hists *c2c_hists = &c2c.hists;
> @@ -324,6 +323,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  	struct addr_location al;
>  	struct mem_info *mi = NULL;
>  	struct callchain_cursor *cursor;
> +	struct evsel *evsel = sample->evsel;
>  	int ret;
>  
>  	addr_location__init(&al);
> @@ -339,7 +339,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  	cursor = get_tls_callchain_cursor();
>  	ret = sample__resolve_callchain(sample, cursor, NULL,
> -					evsel, &al, sysctl_perf_event_max_stack);
> +					&al, sysctl_perf_event_max_stack);
>  	if (ret)
>  		goto out;
>  
> @@ -371,7 +371,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  	if (perf_c2c__has_annotation(NULL)) {
>  		perf_c2c__evsel_hists_inc_stats(evsel, he, sample);
> -		addr_map_symbol__inc_samples(mem_info__iaddr(mi), sample, evsel);
> +		addr_map_symbol__inc_samples(mem_info__iaddr(mi), sample);
>  	}
>  
>  	ret = hist_entry__append_callchain(he, sample);
> diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
> index 59bf1f72d12e..57b2fa0e9f8f 100644
> --- a/tools/perf/builtin-diff.c
> +++ b/tools/perf/builtin-diff.c
> @@ -390,14 +390,13 @@ struct hist_entry_ops block_hist_ops = {
>  static int diff__process_sample_event(const struct perf_tool *tool,
>  				      union perf_event *event,
>  				      struct perf_sample *sample,
> -				      struct evsel *evsel,
>  				      struct machine *machine)
>  {
>  	struct perf_diff *pdiff = container_of(tool, struct perf_diff, tool);
>  	struct addr_location al;
> +	struct evsel *evsel = sample->evsel;
>  	struct hists *hists = evsel__hists(evsel);
>  	struct hist_entry_iter iter = {
> -		.evsel	= evsel,
>  		.sample	= sample,
>  		.ops	= &hist_iter_normal,
>  	};
> @@ -431,7 +430,7 @@ static int diff__process_sample_event(const struct perf_tool *tool,
>  		}
>  
>  		hist__account_cycles(sample->branch_stack, &al, sample,
> -				     false, NULL, evsel);
> +				     /*noany_branch_mode=*/false, /*total_cycles=*/NULL);
>  		break;
>  
>  	case COMPUTE_STREAM:
> diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
> index 5b29f4296861..4ac21329d179 100644
> --- a/tools/perf/builtin-inject.c
> +++ b/tools/perf/builtin-inject.c
> @@ -363,18 +363,18 @@ typedef int (*inject_handler)(const struct perf_tool *tool,
>  static int perf_event__repipe_sample(const struct perf_tool *tool,
>  				     union perf_event *event,
>  				     struct perf_sample *sample,
> -				     struct evsel *evsel,
>  				     struct machine *machine)
>  {
>  	struct perf_inject *inject = container_of(tool, struct perf_inject,
>  						  tool);
> +	struct evsel *evsel = sample->evsel;
>  
>  	if (evsel && evsel->handler) {
>  		inject_handler f = evsel->handler;
>  		return f(tool, event, sample, evsel, machine);
>  	}
>  
> -	build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> +	build_id__mark_dso_hit(tool, event, sample, machine);
>  
>  	if (inject->itrace_synth_opts.set && sample->aux_sample.size) {
>  		event = perf_inject__cut_auxtrace_sample(inject, event, sample);
> @@ -388,7 +388,6 @@ static int perf_event__repipe_sample(const struct perf_tool *tool,
>  static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>  						union perf_event *event,
>  						struct perf_sample *sample,
> -						struct evsel *evsel,
>  						struct machine *machine)
>  {
>  	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> @@ -396,6 +395,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>  	union perf_event *event_copy = (void *)inject->event_copy;
>  	struct callchain_cursor_node *node;
>  	struct thread *thread;
> +	struct evsel *evsel = sample->evsel;
>  	u64 sample_type = evsel->core.attr.sample_type;
>  	u32 sample_size = event->header.size;
>  	u64 i, k;
> @@ -419,7 +419,7 @@ static int perf_event__convert_sample_callchain(const struct perf_tool *tool,
>  		goto out;
>  
>  	/* this will parse DWARF using stack and register data */
> -	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> +	ret = thread__resolve_callchain(thread, cursor, sample,
>  					/*parent=*/NULL, /*root_al=*/NULL,
>  					PERF_MAX_STACK_DEPTH);
>  	thread__put(thread);
> @@ -990,7 +990,6 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data)
>  
>  int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
>  			       struct perf_sample *sample,
> -			       struct evsel *evsel __maybe_unused,
>  			       struct machine *machine)
>  {
>  	struct addr_location al;
> @@ -1021,7 +1020,7 @@ int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *e
>  			     /*sample_in_dso=*/true);
>  	}
>  
> -	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
> +	sample__for_each_callchain_node(thread, sample, PERF_MAX_STACK_DEPTH,
>  					/*symbols=*/false, mark_dso_hit_callback, &args);
>  
>  	thread__put(thread);
> @@ -1079,14 +1078,14 @@ static int perf_inject__sched_switch(const struct perf_tool *tool,
>  static int perf_inject__sched_stat(const struct perf_tool *tool,
>  				   union perf_event *event __maybe_unused,
>  				   struct perf_sample *sample,
> -				   struct evsel *evsel,
>  				   struct machine *machine)
>  {
>  	struct event_entry *ent;
>  	union perf_event *event_sw;
>  	struct perf_sample sample_sw;
>  	struct perf_inject *inject = container_of(tool, struct perf_inject, tool);
> -	u32 pid = evsel__intval(evsel, sample, "pid");
> +	struct evsel *evsel = sample->evsel;
> +	u32 pid = evsel__intval(sample, "pid");
>  
>  	list_for_each_entry(ent, &inject->samples, node) {
>  		if (pid == ent->tid)
> @@ -1102,7 +1101,7 @@ static int perf_inject__sched_stat(const struct perf_tool *tool,
>  	sample_sw.time	 = sample->time;
>  	perf_event__synthesize_sample(event_sw, evsel->core.attr.sample_type,
>  				      evsel->core.attr.read_format, &sample_sw);
> -	build_id__mark_dso_hit(tool, event_sw, &sample_sw, evsel, machine);
> +	build_id__mark_dso_hit(tool, event_sw, &sample_sw, machine);
>  	return perf_event__repipe(tool, event_sw, &sample_sw, machine);
>  }
>  #endif
> diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
> index 7929a5fa5f46..89ee13c3a996 100644
> --- a/tools/perf/builtin-kmem.c
> +++ b/tools/perf/builtin-kmem.c
> @@ -173,10 +173,10 @@ static int insert_caller_stat(unsigned long call_site,
>  
>  static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *sample)
>  {
> -	unsigned long ptr = evsel__intval(evsel, sample, "ptr"),
> -		      call_site = evsel__intval(evsel, sample, "call_site");
> -	int bytes_req = evsel__intval(evsel, sample, "bytes_req"),
> -	    bytes_alloc = evsel__intval(evsel, sample, "bytes_alloc");
> +	unsigned long ptr = evsel__intval(sample, "ptr"),
> +		      call_site = evsel__intval(sample, "call_site");
> +	int bytes_req = evsel__intval(sample, "bytes_req"),
> +	    bytes_alloc = evsel__intval(sample, "bytes_alloc");
>  
>  	if (insert_alloc_stat(call_site, ptr, bytes_req, bytes_alloc, sample->cpu) ||
>  	    insert_caller_stat(call_site, bytes_req, bytes_alloc))
> @@ -202,7 +202,7 @@ static int evsel__process_alloc_event(struct evsel *evsel, struct perf_sample *s
>  		int node1, node2;
>  
>  		node1 = cpu__get_node((struct perf_cpu){.cpu = sample->cpu});
> -		node2 = evsel__intval(evsel, sample, "node");
> +		node2 = evsel__intval(sample, "node");
>  
>  		/*
>  		 * If the field "node" is NUMA_NO_NODE (-1), we don't take it
> @@ -243,9 +243,9 @@ static struct alloc_stat *search_alloc_stat(unsigned long ptr,
>  	return NULL;
>  }
>  
> -static int evsel__process_free_event(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_free_event(struct perf_sample *sample)
>  {
> -	unsigned long ptr = evsel__intval(evsel, sample, "ptr");
> +	unsigned long ptr = evsel__intval(sample, "ptr");
>  	struct alloc_stat *s_alloc, *s_caller;
>  
>  	s_alloc = search_alloc_stat(ptr, 0, &root_alloc_stat, ptr_cmp);
> @@ -394,7 +394,7 @@ static int build_alloc_func_list(void)
>   * Find first non-memory allocation function from callchain.
>   * The allocation functions are in the 'alloc_func_list'.
>   */
> -static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
> +static u64 find_callsite(struct perf_sample *sample)
>  {
>  	struct addr_location al;
>  	struct machine *machine = &kmem_session->machines.host;
> @@ -414,7 +414,7 @@ static u64 find_callsite(struct evsel *evsel, struct perf_sample *sample)
>  	if (cursor == NULL)
>  		goto out;
>  
> -	sample__resolve_callchain(sample, cursor, NULL, evsel, &al, 16);
> +	sample__resolve_callchain(sample, cursor, /*parent=*/NULL, &al, 16);
>  
>  	callchain_cursor_commit(cursor);
>  	while (true) {
> @@ -751,8 +751,7 @@ static char *compact_gfp_string(unsigned long gfp_flags)
>  	return NULL;
>  }
>  
> -static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
> -			   unsigned int gfp_flags)
> +static int parse_gfp_flags(struct perf_sample *sample, unsigned int gfp_flags)
>  {
>  	struct tep_record record = {
>  		.cpu = sample->cpu,
> @@ -773,7 +772,7 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
>  	}
>  
>  	trace_seq_init(&seq);
> -	tp_format = evsel__tp_format(evsel);
> +	tp_format = evsel__tp_format(sample->evsel);
>  	if (tp_format)
>  		tep_print_event(tp_format->tep, &seq, &record, "%s", TEP_PRINT_INFO);
>  
> @@ -805,13 +804,12 @@ static int parse_gfp_flags(struct evsel *evsel, struct perf_sample *sample,
>  	return 0;
>  }
>  
> -static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_page_alloc_event(struct perf_sample *sample)
>  {
>  	u64 page;
> -	unsigned int order = evsel__intval(evsel, sample, "order");
> -	unsigned int gfp_flags = evsel__intval(evsel, sample, "gfp_flags");
> -	unsigned int migrate_type = evsel__intval(evsel, sample,
> -						       "migratetype");
> +	unsigned int order = evsel__intval(sample, "order");
> +	unsigned int gfp_flags = evsel__intval(sample, "gfp_flags");
> +	unsigned int migrate_type = evsel__intval(sample, "migratetype");
>  	u64 bytes = kmem_page_size << order;
>  	u64 callsite;
>  	struct page_stat *pstat;
> @@ -822,9 +820,9 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
>  	};
>  
>  	if (use_pfn)
> -		page = evsel__intval(evsel, sample, "pfn");
> +		page = evsel__intval(sample, "pfn");
>  	else
> -		page = evsel__intval(evsel, sample, "page");
> +		page = evsel__intval(sample, "page");
>  
>  	nr_page_allocs++;
>  	total_page_alloc_bytes += bytes;
> @@ -836,10 +834,10 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
>  		return 0;
>  	}
>  
> -	if (parse_gfp_flags(evsel, sample, gfp_flags) < 0)
> +	if (parse_gfp_flags(sample, gfp_flags) < 0)
>  		return -1;
>  
> -	callsite = find_callsite(evsel, sample);
> +	callsite = find_callsite(sample);
>  
>  	/*
>  	 * This is to find the current page (with correct gfp flags and
> @@ -877,10 +875,10 @@ static int evsel__process_page_alloc_event(struct evsel *evsel, struct perf_samp
>  	return 0;
>  }
>  
> -static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_page_free_event(struct perf_sample *sample)
>  {
>  	u64 page;
> -	unsigned int order = evsel__intval(evsel, sample, "order");
> +	unsigned int order = evsel__intval(sample, "order");
>  	u64 bytes = kmem_page_size << order;
>  	struct page_stat *pstat;
>  	struct page_stat this = {
> @@ -888,9 +886,9 @@ static int evsel__process_page_free_event(struct evsel *evsel, struct perf_sampl
>  	};
>  
>  	if (use_pfn)
> -		page = evsel__intval(evsel, sample, "pfn");
> +		page = evsel__intval(sample, "pfn");
>  	else
> -		page = evsel__intval(evsel, sample, "page");
> +		page = evsel__intval(sample, "page");
>  
>  	nr_page_frees++;
>  	total_page_free_bytes += bytes;
> @@ -954,16 +952,15 @@ static bool perf_kmem__skip_sample(struct perf_sample *sample)
>  	return false;
>  }
>  
> -typedef int (*tracepoint_handler)(struct evsel *evsel,
> -				  struct perf_sample *sample);
> +typedef int (*tracepoint_handler)(struct perf_sample *sample);
>  
>  static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	int err = 0;
> +	struct evsel *evsel = sample->evsel;
>  	struct thread *thread = machine__findnew_thread(machine, sample->pid,
>  							sample->tid);
>  
> @@ -980,7 +977,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> -		err = f(evsel, sample);
> +		err = f(sample);
>  	}
>  
>  	thread__put(thread);
> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
> index c61369d54dd9..e9ba93098797 100644
> --- a/tools/perf/builtin-kvm.c
> +++ b/tools/perf/builtin-kvm.c
> @@ -805,7 +805,6 @@ static bool update_kvm_event(struct perf_kvm_stat *kvm,
>  }
>  
>  static bool is_child_event(struct perf_kvm_stat *kvm,
> -			   struct evsel *evsel,
>  			   struct perf_sample *sample,
>  			   struct event_key *key)
>  {
> @@ -817,8 +816,8 @@ static bool is_child_event(struct perf_kvm_stat *kvm,
>  		return false;
>  
>  	for (; child_ops->name; child_ops++) {
> -		if (evsel__name_is(evsel, child_ops->name)) {
> -			child_ops->get_key(evsel, sample, key);
> +		if (evsel__name_is(sample->evsel, child_ops->name)) {
> +			child_ops->get_key(sample, key);
>  			return true;
>  		}
>  	}
> @@ -915,11 +914,10 @@ static bool handle_end_event(struct perf_kvm_stat *kvm,
>  
>  static
>  struct vcpu_event_record *per_vcpu_record(struct thread *thread,
> -					  struct evsel *evsel,
>  					  struct perf_sample *sample)
>  {
>  	/* Only kvm_entry records vcpu id. */
> -	if (!thread__priv(thread) && kvm_entry_event(evsel)) {
> +	if (!thread__priv(thread) && kvm_entry_event(sample->evsel)) {
>  		struct vcpu_event_record *vcpu_record;
>  
>  		vcpu_record = zalloc(sizeof(*vcpu_record));
> @@ -928,7 +926,7 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
>  			return NULL;
>  		}
>  
> -		vcpu_record->vcpu_id = evsel__intval(evsel, sample, vcpu_id_str);
> +		vcpu_record->vcpu_id = evsel__intval(sample, vcpu_id_str);
>  		thread__set_priv(thread, vcpu_record);
>  	}
>  
> @@ -937,14 +935,13 @@ struct vcpu_event_record *per_vcpu_record(struct thread *thread,
>  
>  static bool handle_kvm_event(struct perf_kvm_stat *kvm,
>  			     struct thread *thread,
> -			     struct evsel *evsel,
>  			     struct perf_sample *sample)
>  {
>  	struct vcpu_event_record *vcpu_record;
>  	struct event_key key = { .key = INVALID_KEY,
>  				 .exit_reasons = kvm->exit_reasons };
>  
> -	vcpu_record = per_vcpu_record(thread, evsel, sample);
> +	vcpu_record = per_vcpu_record(thread, sample);
>  	if (!vcpu_record)
>  		return true;
>  
> @@ -953,13 +950,13 @@ static bool handle_kvm_event(struct perf_kvm_stat *kvm,
>  	    (kvm->trace_vcpu != vcpu_record->vcpu_id))
>  		return true;
>  
> -	if (kvm->events_ops->is_begin_event(evsel, sample, &key))
> +	if (kvm->events_ops->is_begin_event(sample, &key))
>  		return handle_begin_event(kvm, vcpu_record, &key, sample);
>  
> -	if (is_child_event(kvm, evsel, sample, &key))
> +	if (is_child_event(kvm, sample, &key))
>  		return handle_child_event(kvm, vcpu_record, &key, sample);
>  
> -	if (kvm->events_ops->is_end_event(evsel, sample, &key))
> +	if (kvm->events_ops->is_end_event(sample, &key))
>  		return handle_end_event(kvm, vcpu_record, &key, sample);
>  
>  	return true;
> @@ -1129,7 +1126,6 @@ static bool skip_sample(struct perf_kvm_stat *kvm,
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	int err = 0;
> @@ -1152,7 +1148,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  		return -1;
>  	}
>  
> -	if (!handle_kvm_event(kvm, thread, evsel, sample))
> +	if (!handle_kvm_event(kvm, thread, sample))
>  		err = -1;
>  
>  	thread__put(thread);
> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index 7f3068264568..8ebce99f9acf 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -448,7 +448,6 @@ static int work_push_atom(struct perf_kwork *kwork,
>  			  struct kwork_class *class,
>  			  enum kwork_trace_type src_type,
>  			  enum kwork_trace_type dst_type,
> -			  struct evsel *evsel,
>  			  struct perf_sample *sample,
>  			  struct machine *machine,
>  			  struct kwork_work **ret_work,
> @@ -458,7 +457,7 @@ static int work_push_atom(struct perf_kwork *kwork,
>  	struct kwork_work *work, key;
>  
>  	BUG_ON(class->work_init == NULL);
> -	class->work_init(kwork, class, &key, src_type, evsel, sample, machine);
> +	class->work_init(kwork, class, &key, src_type, sample, machine);
>  
>  	atom = atom_new(kwork, sample);
>  	if (atom == NULL)
> @@ -507,7 +506,6 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
>  					struct kwork_class *class,
>  					enum kwork_trace_type src_type,
>  					enum kwork_trace_type dst_type,
> -					struct evsel *evsel,
>  					struct perf_sample *sample,
>  					struct machine *machine,
>  					struct kwork_work **ret_work)
> @@ -516,7 +514,7 @@ static struct kwork_atom *work_pop_atom(struct perf_kwork *kwork,
>  	struct kwork_work *work, key;
>  
>  	BUG_ON(class->work_init == NULL);
> -	class->work_init(kwork, class, &key, src_type, evsel, sample, machine);
> +	class->work_init(kwork, class, &key, src_type, sample, machine);
>  
>  	work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
>  	if (ret_work != NULL)
> @@ -599,18 +597,16 @@ static void report_update_exit_event(struct kwork_work *work,
>  
>  static int report_entry_event(struct perf_kwork *kwork,
>  			      struct kwork_class *class,
> -			      struct evsel *evsel,
>  			      struct perf_sample *sample,
>  			      struct machine *machine)
>  {
>  	return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
> -			      KWORK_TRACE_MAX, evsel, sample,
> +			      KWORK_TRACE_MAX, sample,
>  			      machine, NULL, true);
>  }
>  
>  static int report_exit_event(struct perf_kwork *kwork,
>  			     struct kwork_class *class,
> -			     struct evsel *evsel,
>  			     struct perf_sample *sample,
>  			     struct machine *machine)
>  {
> @@ -618,7 +614,7 @@ static int report_exit_event(struct perf_kwork *kwork,
>  	struct kwork_work *work = NULL;
>  
>  	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
> -			     KWORK_TRACE_ENTRY, evsel, sample,
> +			     KWORK_TRACE_ENTRY, sample,
>  			     machine, &work);
>  	if (work == NULL)
>  		return -1;
> @@ -654,18 +650,16 @@ static void latency_update_entry_event(struct kwork_work *work,
>  
>  static int latency_raise_event(struct perf_kwork *kwork,
>  			       struct kwork_class *class,
> -			       struct evsel *evsel,
>  			       struct perf_sample *sample,
>  			       struct machine *machine)
>  {
>  	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
> -			      KWORK_TRACE_MAX, evsel, sample,
> +			      KWORK_TRACE_MAX, sample,
>  			      machine, NULL, true);
>  }
>  
>  static int latency_entry_event(struct perf_kwork *kwork,
>  			       struct kwork_class *class,
> -			       struct evsel *evsel,
>  			       struct perf_sample *sample,
>  			       struct machine *machine)
>  {
> @@ -673,7 +667,7 @@ static int latency_entry_event(struct perf_kwork *kwork,
>  	struct kwork_work *work = NULL;
>  
>  	atom = work_pop_atom(kwork, class, KWORK_TRACE_ENTRY,
> -			     KWORK_TRACE_RAISE, evsel, sample,
> +			     KWORK_TRACE_RAISE, sample,
>  			     machine, &work);
>  	if (work == NULL)
>  		return -1;
> @@ -688,7 +682,6 @@ static int latency_entry_event(struct perf_kwork *kwork,
>  
>  static void timehist_save_callchain(struct perf_kwork *kwork,
>  				    struct perf_sample *sample,
> -				    struct evsel *evsel,
>  				    struct machine *machine)
>  {
>  	struct symbol *sym;
> @@ -708,8 +701,9 @@ static void timehist_save_callchain(struct perf_kwork *kwork,
>  
>  	cursor = get_tls_callchain_cursor();
>  
> -	if (thread__resolve_callchain(thread, cursor, evsel, sample,
> -				      NULL, NULL, kwork->max_stack + 2) != 0) {
> +	if (thread__resolve_callchain(thread, cursor, sample,
> +				      /*parent=*/NULL, /*root_al=*/NULL,
> +				      kwork->max_stack + 2) != 0) {
>  		pr_debug("Failed to resolve callchain, skipping\n");
>  		goto out_put;
>  	}
> @@ -813,18 +807,16 @@ static void timehist_print_event(struct perf_kwork *kwork,
>  
>  static int timehist_raise_event(struct perf_kwork *kwork,
>  				struct kwork_class *class,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct machine *machine)
>  {
>  	return work_push_atom(kwork, class, KWORK_TRACE_RAISE,
> -			      KWORK_TRACE_MAX, evsel, sample,
> +			      KWORK_TRACE_MAX, sample,
>  			      machine, NULL, true);
>  }
>  
>  static int timehist_entry_event(struct perf_kwork *kwork,
>  				struct kwork_class *class,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct machine *machine)
>  {
> @@ -832,20 +824,19 @@ static int timehist_entry_event(struct perf_kwork *kwork,
>  	struct kwork_work *work = NULL;
>  
>  	ret = work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
> -			     KWORK_TRACE_RAISE, evsel, sample,
> +			     KWORK_TRACE_RAISE, sample,
>  			     machine, &work, true);
>  	if (ret)
>  		return ret;
>  
>  	if (work != NULL)
> -		timehist_save_callchain(kwork, sample, evsel, machine);
> +		timehist_save_callchain(kwork, sample, machine);
>  
>  	return 0;
>  }
>  
>  static int timehist_exit_event(struct perf_kwork *kwork,
>  			       struct kwork_class *class,
> -			       struct evsel *evsel,
>  			       struct perf_sample *sample,
>  			       struct machine *machine)
>  {
> @@ -862,7 +853,7 @@ static int timehist_exit_event(struct perf_kwork *kwork,
>  	}
>  
>  	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
> -			     KWORK_TRACE_ENTRY, evsel, sample,
> +			     KWORK_TRACE_ENTRY, sample,
>  			     machine, &work);
>  	if (work == NULL) {
>  		ret = -1;
> @@ -896,18 +887,16 @@ static void top_update_runtime(struct kwork_work *work,
>  
>  static int top_entry_event(struct perf_kwork *kwork,
>  			   struct kwork_class *class,
> -			   struct evsel *evsel,
>  			   struct perf_sample *sample,
>  			   struct machine *machine)
>  {
>  	return work_push_atom(kwork, class, KWORK_TRACE_ENTRY,
> -			      KWORK_TRACE_MAX, evsel, sample,
> +			      KWORK_TRACE_MAX, sample,
>  			      machine, NULL, true);
>  }
>  
>  static int top_exit_event(struct perf_kwork *kwork,
>  			  struct kwork_class *class,
> -			  struct evsel *evsel,
>  			  struct perf_sample *sample,
>  			  struct machine *machine)
>  {
> @@ -916,7 +905,7 @@ static int top_exit_event(struct perf_kwork *kwork,
>  	struct kwork_atom *atom;
>  
>  	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
> -			     KWORK_TRACE_ENTRY, evsel, sample,
> +			     KWORK_TRACE_ENTRY, sample,
>  			     machine, &work);
>  	if (!work)
>  		return -1;
> @@ -937,7 +926,6 @@ static int top_exit_event(struct perf_kwork *kwork,
>  
>  static int top_sched_switch_event(struct perf_kwork *kwork,
>  				  struct kwork_class *class,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  struct machine *machine)
>  {
> @@ -945,7 +933,7 @@ static int top_sched_switch_event(struct perf_kwork *kwork,
>  	struct kwork_work *work;
>  
>  	atom = work_pop_atom(kwork, class, KWORK_TRACE_EXIT,
> -			     KWORK_TRACE_ENTRY, evsel, sample,
> +			     KWORK_TRACE_ENTRY, sample,
>  			     machine, &work);
>  	if (!work)
>  		return -1;
> @@ -955,12 +943,11 @@ static int top_sched_switch_event(struct perf_kwork *kwork,
>  		atom_del(atom);
>  	}
>  
> -	return top_entry_event(kwork, class, evsel, sample, machine);
> +	return top_entry_event(kwork, class, sample, machine);
>  }
>  
>  static struct kwork_class kwork_irq;
>  static int process_irq_handler_entry_event(const struct perf_tool *tool,
> -					   struct evsel *evsel,
>  					   struct perf_sample *sample,
>  					   struct machine *machine)
>  {
> @@ -968,12 +955,11 @@ static int process_irq_handler_entry_event(const struct perf_tool *tool,
>  
>  	if (kwork->tp_handler->entry_event)
>  		return kwork->tp_handler->entry_event(kwork, &kwork_irq,
> -						      evsel, sample, machine);
> +						      sample, machine);
>  	return 0;
>  }
>  
>  static int process_irq_handler_exit_event(const struct perf_tool *tool,
> -					  struct evsel *evsel,
>  					  struct perf_sample *sample,
>  					  struct machine *machine)
>  {
> @@ -981,7 +967,7 @@ static int process_irq_handler_exit_event(const struct perf_tool *tool,
>  
>  	if (kwork->tp_handler->exit_event)
>  		return kwork->tp_handler->exit_event(kwork, &kwork_irq,
> -						     evsel, sample, machine);
> +						     sample, machine);
>  	return 0;
>  }
>  
> @@ -1006,7 +992,6 @@ static void irq_work_init(struct perf_kwork *kwork,
>  			  struct kwork_class *class,
>  			  struct kwork_work *work,
>  			  enum kwork_trace_type src_type __maybe_unused,
> -			  struct evsel *evsel,
>  			  struct perf_sample *sample,
>  			  struct machine *machine __maybe_unused)
>  {
> @@ -1014,11 +999,11 @@ static void irq_work_init(struct perf_kwork *kwork,
>  	work->cpu = sample->cpu;
>  
>  	if (kwork->report == KWORK_REPORT_TOP) {
> -		work->id = evsel__intval_common(evsel, sample, "common_pid");
> +		work->id = evsel__intval_common(sample, "common_pid");
>  		work->name = NULL;
>  	} else {
> -		work->id = evsel__intval(evsel, sample, "irq");
> -		work->name = evsel__strval(evsel, sample, "name");
> +		work->id = evsel__intval(sample, "irq");
> +		work->name = evsel__strval(sample, "name");
>  	}
>  }
>  
> @@ -1039,7 +1024,6 @@ static struct kwork_class kwork_irq = {
>  
>  static struct kwork_class kwork_softirq;
>  static int process_softirq_raise_event(const struct perf_tool *tool,
> -				       struct evsel *evsel,
>  				       struct perf_sample *sample,
>  				       struct machine *machine)
>  {
> @@ -1047,13 +1031,12 @@ static int process_softirq_raise_event(const struct perf_tool *tool,
>  
>  	if (kwork->tp_handler->raise_event)
>  		return kwork->tp_handler->raise_event(kwork, &kwork_softirq,
> -						      evsel, sample, machine);
> +						      sample, machine);
>  
>  	return 0;
>  }
>  
>  static int process_softirq_entry_event(const struct perf_tool *tool,
> -				       struct evsel *evsel,
>  				       struct perf_sample *sample,
>  				       struct machine *machine)
>  {
> @@ -1061,13 +1044,12 @@ static int process_softirq_entry_event(const struct perf_tool *tool,
>  
>  	if (kwork->tp_handler->entry_event)
>  		return kwork->tp_handler->entry_event(kwork, &kwork_softirq,
> -						      evsel, sample, machine);
> +						      sample, machine);
>  
>  	return 0;
>  }
>  
>  static int process_softirq_exit_event(const struct perf_tool *tool,
> -				      struct evsel *evsel,
>  				      struct perf_sample *sample,
>  				      struct machine *machine)
>  {
> @@ -1075,7 +1057,7 @@ static int process_softirq_exit_event(const struct perf_tool *tool,
>  
>  	if (kwork->tp_handler->exit_event)
>  		return kwork->tp_handler->exit_event(kwork, &kwork_softirq,
> -						     evsel, sample, machine);
> +						     sample, machine);
>  
>  	return 0;
>  }
> @@ -1134,7 +1116,6 @@ static void softirq_work_init(struct perf_kwork *kwork,
>  			      struct kwork_class *class,
>  			      struct kwork_work *work,
>  			      enum kwork_trace_type src_type __maybe_unused,
> -			      struct evsel *evsel,
>  			      struct perf_sample *sample,
>  			      struct machine *machine __maybe_unused)
>  {
> @@ -1144,12 +1125,12 @@ static void softirq_work_init(struct perf_kwork *kwork,
>  	work->cpu = sample->cpu;
>  
>  	if (kwork->report == KWORK_REPORT_TOP) {
> -		work->id = evsel__intval_common(evsel, sample, "common_pid");
> +		work->id = evsel__intval_common(sample, "common_pid");
>  		work->name = NULL;
>  	} else {
> -		num = evsel__intval(evsel, sample, "vec");
> +		num = evsel__intval(sample, "vec");
>  		work->id = num;
> -		work->name = evsel__softirq_name(evsel, num);
> +		work->name = evsel__softirq_name(sample->evsel, num);
>  	}
>  }
>  
> @@ -1170,43 +1151,37 @@ static struct kwork_class kwork_softirq = {
>  
>  static struct kwork_class kwork_workqueue;
>  static int process_workqueue_activate_work_event(const struct perf_tool *tool,
> -						 struct evsel *evsel,
>  						 struct perf_sample *sample,
>  						 struct machine *machine)
>  {
>  	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
>  
>  	if (kwork->tp_handler->raise_event)
> -		return kwork->tp_handler->raise_event(kwork, &kwork_workqueue,
> -						    evsel, sample, machine);
> +		return kwork->tp_handler->raise_event(kwork, &kwork_workqueue, sample, machine);
>  
>  	return 0;
>  }
>  
>  static int process_workqueue_execute_start_event(const struct perf_tool *tool,
> -						 struct evsel *evsel,
>  						 struct perf_sample *sample,
>  						 struct machine *machine)
>  {
>  	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
>  
>  	if (kwork->tp_handler->entry_event)
> -		return kwork->tp_handler->entry_event(kwork, &kwork_workqueue,
> -						    evsel, sample, machine);
> +		return kwork->tp_handler->entry_event(kwork, &kwork_workqueue, sample, machine);
>  
>  	return 0;
>  }
>  
>  static int process_workqueue_execute_end_event(const struct perf_tool *tool,
> -					       struct evsel *evsel,
>  					       struct perf_sample *sample,
>  					       struct machine *machine)
>  {
>  	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
>  
>  	if (kwork->tp_handler->exit_event)
> -		return kwork->tp_handler->exit_event(kwork, &kwork_workqueue,
> -						   evsel, sample, machine);
> +		return kwork->tp_handler->exit_event(kwork, &kwork_workqueue, sample, machine);
>  
>  	return 0;
>  }
> @@ -1234,17 +1209,15 @@ static void workqueue_work_init(struct perf_kwork *kwork __maybe_unused,
>  				struct kwork_class *class,
>  				struct kwork_work *work,
>  				enum kwork_trace_type src_type __maybe_unused,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct machine *machine)
>  {
>  	char *modp = NULL;
> -	unsigned long long function_addr = evsel__intval(evsel,
> -							 sample, "function");
> +	unsigned long long function_addr = evsel__intval(sample, "function");
>  
>  	work->class = class;
>  	work->cpu = sample->cpu;
> -	work->id = evsel__intval(evsel, sample, "work");
> +	work->id = evsel__intval(sample, "work");
>  	work->name = function_addr == 0 ? NULL :
>  		machine__resolve_kernel_addr(machine, &function_addr, &modp);
>  }
> @@ -1269,15 +1242,13 @@ static struct kwork_class kwork_workqueue = {
>  
>  static struct kwork_class kwork_sched;
>  static int process_sched_switch_event(const struct perf_tool *tool,
> -				      struct evsel *evsel,
>  				      struct perf_sample *sample,
>  				      struct machine *machine)
>  {
>  	struct perf_kwork *kwork = container_of(tool, struct perf_kwork, tool);
>  
>  	if (kwork->tp_handler->sched_switch_event)
> -		return kwork->tp_handler->sched_switch_event(kwork, &kwork_sched,
> -							     evsel, sample, machine);
> +		return kwork->tp_handler->sched_switch_event(kwork, &kwork_sched, sample, machine);
>  	return 0;
>  }
>  
> @@ -1302,7 +1273,6 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
>  			    struct kwork_class *class,
>  			    struct kwork_work *work,
>  			    enum kwork_trace_type src_type,
> -			    struct evsel *evsel,
>  			    struct perf_sample *sample,
>  			    struct machine *machine __maybe_unused)
>  {
> @@ -1310,11 +1280,11 @@ static void sched_work_init(struct perf_kwork *kwork __maybe_unused,
>  	work->cpu = sample->cpu;
>  
>  	if (src_type == KWORK_TRACE_EXIT) {
> -		work->id = evsel__intval(evsel, sample, "prev_pid");
> -		work->name = strdup(evsel__strval(evsel, sample, "prev_comm"));
> +		work->id = evsel__intval(sample, "prev_pid");
> +		work->name = strdup(evsel__strval(sample, "prev_comm"));
>  	} else if (src_type == KWORK_TRACE_ENTRY) {
> -		work->id = evsel__intval(evsel, sample, "next_pid");
> -		work->name = strdup(evsel__strval(evsel, sample, "next_comm"));
> +		work->id = evsel__intval(sample, "next_pid");
> +		work->name = strdup(evsel__strval(sample, "next_comm"));
>  	}
>  }
>  
> @@ -1948,22 +1918,21 @@ static int perf_kwork__report(struct perf_kwork *kwork)
>  }
>  
>  typedef int (*tracepoint_handler)(const struct perf_tool *tool,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  struct machine *machine);
>  
>  static int perf_kwork__process_tracepoint_sample(const struct perf_tool *tool,
>  						 union perf_event *event __maybe_unused,
>  						 struct perf_sample *sample,
> -						 struct evsel *evsel,
>  						 struct machine *machine)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	int err = 0;
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
>  
> -		err = f(tool, evsel, sample, machine);
> +		err = f(tool, sample, machine);
>  	}
>  
>  	return err;
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index e8962c985d34..5ccf0fef14a6 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -473,28 +473,22 @@ static struct lock_stat *pop_from_result(void)
>  
>  struct trace_lock_handler {
>  	/* it's used on CONFIG_LOCKDEP */
> -	int (*acquire_event)(struct evsel *evsel,
> -			     struct perf_sample *sample);
> +	int (*acquire_event)(struct perf_sample *sample);
>  
>  	/* it's used on CONFIG_LOCKDEP && CONFIG_LOCK_STAT */
> -	int (*acquired_event)(struct evsel *evsel,
> -			      struct perf_sample *sample);
> +	int (*acquired_event)(struct perf_sample *sample);
>  
>  	/* it's used on CONFIG_LOCKDEP && CONFIG_LOCK_STAT */
> -	int (*contended_event)(struct evsel *evsel,
> -			       struct perf_sample *sample);
> +	int (*contended_event)(struct perf_sample *sample);
>  
>  	/* it's used on CONFIG_LOCKDEP */
> -	int (*release_event)(struct evsel *evsel,
> -			     struct perf_sample *sample);
> +	int (*release_event)(struct perf_sample *sample);
>  
>  	/* it's used when CONFIG_LOCKDEP is off */
> -	int (*contention_begin_event)(struct evsel *evsel,
> -				      struct perf_sample *sample);
> +	int (*contention_begin_event)(struct perf_sample *sample);
>  
>  	/* it's used when CONFIG_LOCKDEP is off */
> -	int (*contention_end_event)(struct evsel *evsel,
> -				    struct perf_sample *sample);
> +	int (*contention_end_event)(struct perf_sample *sample);
>  };
>  
>  static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
> @@ -551,27 +545,25 @@ static int get_key_by_aggr_mode_simple(u64 *key, u64 addr, u32 tid)
>  	return 0;
>  }
>  
> -static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample);
> +static u64 callchain_id(struct perf_sample *sample);
>  
> -static int get_key_by_aggr_mode(u64 *key, u64 addr, struct evsel *evsel,
> -				 struct perf_sample *sample)
> +static int get_key_by_aggr_mode(u64 *key, u64 addr, struct perf_sample *sample)
>  {
>  	if (aggr_mode == LOCK_AGGR_CALLER) {
> -		*key = callchain_id(evsel, sample);
> +		*key = callchain_id(sample);
>  		return 0;
>  	}
>  	return get_key_by_aggr_mode_simple(key, addr, sample->tid);
>  }
>  
> -static int report_lock_acquire_event(struct evsel *evsel,
> -				     struct perf_sample *sample)
> +static int report_lock_acquire_event(struct perf_sample *sample)
>  {
>  	struct lock_stat *ls;
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
> -	const char *name = evsel__strval(evsel, sample, "name");
> -	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> -	int flag = evsel__intval(evsel, sample, "flags");
> +	const char *name = evsel__strval(sample, "name");
> +	u64 addr = evsel__intval(sample, "lockdep_addr");
> +	int flag = evsel__intval(sample, "flags");
>  	u64 key;
>  	int ret;
>  
> @@ -638,15 +630,14 @@ static int report_lock_acquire_event(struct evsel *evsel,
>  	return 0;
>  }
>  
> -static int report_lock_acquired_event(struct evsel *evsel,
> -				      struct perf_sample *sample)
> +static int report_lock_acquired_event(struct perf_sample *sample)
>  {
>  	struct lock_stat *ls;
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
>  	u64 contended_term;
> -	const char *name = evsel__strval(evsel, sample, "name");
> -	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> +	const char *name = evsel__strval(sample, "name");
> +	u64 addr = evsel__intval(sample, "lockdep_addr");
>  	u64 key;
>  	int ret;
>  
> @@ -704,14 +695,13 @@ static int report_lock_acquired_event(struct evsel *evsel,
>  	return 0;
>  }
>  
> -static int report_lock_contended_event(struct evsel *evsel,
> -				       struct perf_sample *sample)
> +static int report_lock_contended_event(struct perf_sample *sample)
>  {
>  	struct lock_stat *ls;
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
> -	const char *name = evsel__strval(evsel, sample, "name");
> -	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> +	const char *name = evsel__strval(sample, "name");
> +	u64 addr = evsel__intval(sample, "lockdep_addr");
>  	u64 key;
>  	int ret;
>  
> @@ -762,14 +752,13 @@ static int report_lock_contended_event(struct evsel *evsel,
>  	return 0;
>  }
>  
> -static int report_lock_release_event(struct evsel *evsel,
> -				     struct perf_sample *sample)
> +static int report_lock_release_event(struct perf_sample *sample)
>  {
>  	struct lock_stat *ls;
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
> -	const char *name = evsel__strval(evsel, sample, "name");
> -	u64 addr = evsel__intval(evsel, sample, "lockdep_addr");
> +	const char *name = evsel__strval(sample, "name");
> +	u64 addr = evsel__intval(sample, "lockdep_addr");
>  	u64 key;
>  	int ret;
>  
> @@ -841,7 +830,7 @@ static int get_symbol_name_offset(struct map *map, struct symbol *sym, u64 ip,
>  	else
>  		return strlcpy(buf, sym->name, size);
>  }
> -static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sample,
> +static int lock_contention_caller(struct perf_sample *sample,
>  				  char *buf, int size)
>  {
>  	struct thread *thread;
> @@ -862,8 +851,9 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
>  	cursor = get_tls_callchain_cursor();
>  
>  	/* use caller function name from the callchain */
> -	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> -					NULL, NULL, max_stack_depth);
> +	ret = thread__resolve_callchain(thread, cursor, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					max_stack_depth);
>  	if (ret != 0) {
>  		thread__put(thread);
>  		return -1;
> @@ -896,7 +886,7 @@ static int lock_contention_caller(struct evsel *evsel, struct perf_sample *sampl
>  	return -1;
>  }
>  
> -static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
> +static u64 callchain_id(struct perf_sample *sample)
>  {
>  	struct callchain_cursor *cursor;
>  	struct machine *machine = &session->machines.host;
> @@ -911,8 +901,9 @@ static u64 callchain_id(struct evsel *evsel, struct perf_sample *sample)
>  
>  	cursor = get_tls_callchain_cursor();
>  	/* use caller function name from the callchain */
> -	ret = thread__resolve_callchain(thread, cursor, evsel, sample,
> -					NULL, NULL, max_stack_depth);
> +	ret = thread__resolve_callchain(thread, cursor, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					max_stack_depth);
>  	thread__put(thread);
>  
>  	if (ret != 0)
> @@ -963,14 +954,13 @@ static u64 *get_callstack(struct perf_sample *sample, int max_stack)
>  	return callstack;
>  }
>  
> -static int report_lock_contention_begin_event(struct evsel *evsel,
> -					      struct perf_sample *sample)
> +static int report_lock_contention_begin_event(struct perf_sample *sample)
>  {
>  	struct lock_stat *ls;
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
> -	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> -	unsigned int flags = evsel__intval(evsel, sample, "flags");
> +	u64 addr = evsel__intval(sample, "lock_addr");
> +	unsigned int flags = evsel__intval(sample, "flags");
>  	u64 key;
>  	int i, ret;
>  	static bool kmap_loaded;
> @@ -978,7 +968,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  	struct map *kmap;
>  	struct symbol *sym;
>  
> -	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
> +	ret = get_key_by_aggr_mode(&key, addr, sample);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1025,7 +1015,7 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  			break;
>  		case LOCK_AGGR_CALLER:
>  			name = buf;
> -			if (lock_contention_caller(evsel, sample, buf, sizeof(buf)) < 0)
> +			if (lock_contention_caller(sample, buf, sizeof(buf)) < 0)
>  				name = "Unknown";
>  			break;
>  		case LOCK_AGGR_CGROUP:
> @@ -1127,18 +1117,17 @@ static int report_lock_contention_begin_event(struct evsel *evsel,
>  	return 0;
>  }
>  
> -static int report_lock_contention_end_event(struct evsel *evsel,
> -					    struct perf_sample *sample)
> +static int report_lock_contention_end_event(struct perf_sample *sample)
>  {
>  	struct lock_stat *ls;
>  	struct thread_stat *ts;
>  	struct lock_seq_stat *seq;
>  	u64 contended_term;
> -	u64 addr = evsel__intval(evsel, sample, "lock_addr");
> +	u64 addr = evsel__intval(sample, "lock_addr");
>  	u64 key;
>  	int ret;
>  
> -	ret = get_key_by_aggr_mode(&key, addr, evsel, sample);
> +	ret = get_key_by_aggr_mode(&key, addr, sample);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1208,45 +1197,45 @@ static struct trace_lock_handler contention_lock_ops  = {
>  
>  static struct trace_lock_handler *trace_handler;
>  
> -static int evsel__process_lock_acquire(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_lock_acquire(struct perf_sample *sample)
>  {
>  	if (trace_handler->acquire_event)
> -		return trace_handler->acquire_event(evsel, sample);
> +		return trace_handler->acquire_event(sample);
>  	return 0;
>  }
>  
> -static int evsel__process_lock_acquired(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_lock_acquired(struct perf_sample *sample)
>  {
>  	if (trace_handler->acquired_event)
> -		return trace_handler->acquired_event(evsel, sample);
> +		return trace_handler->acquired_event(sample);
>  	return 0;
>  }
>  
> -static int evsel__process_lock_contended(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_lock_contended(struct perf_sample *sample)
>  {
>  	if (trace_handler->contended_event)
> -		return trace_handler->contended_event(evsel, sample);
> +		return trace_handler->contended_event(sample);
>  	return 0;
>  }
>  
> -static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_lock_release(struct perf_sample *sample)
>  {
>  	if (trace_handler->release_event)
> -		return trace_handler->release_event(evsel, sample);
> +		return trace_handler->release_event(sample);
>  	return 0;
>  }
>  
> -static int evsel__process_contention_begin(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_contention_begin(struct perf_sample *sample)
>  {
>  	if (trace_handler->contention_begin_event)
> -		return trace_handler->contention_begin_event(evsel, sample);
> +		return trace_handler->contention_begin_event(sample);
>  	return 0;
>  }
>  
> -static int evsel__process_contention_end(struct evsel *evsel, struct perf_sample *sample)
> +static int evsel__process_contention_end(struct perf_sample *sample)
>  {
>  	if (trace_handler->contention_end_event)
> -		return trace_handler->contention_end_event(evsel, sample);
> +		return trace_handler->contention_end_event(sample);
>  	return 0;
>  }
>  
> @@ -1424,16 +1413,15 @@ static int process_event_update(const struct perf_tool *tool,
>  	return 0;
>  }
>  
> -typedef int (*tracepoint_handler)(struct evsel *evsel,
> -				  struct perf_sample *sample);
> +typedef int (*tracepoint_handler)(struct perf_sample *sample);
>  
>  static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	int err = 0;
> +	struct evsel *evsel = sample->evsel;
>  	struct thread *thread = machine__findnew_thread(machine, sample->pid,
>  							sample->tid);
>  
> @@ -1445,7 +1433,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> -		err = f(evsel, sample);
> +		err = f(sample);
>  	}
>  
>  	thread__put(thread);
> diff --git a/tools/perf/builtin-mem.c b/tools/perf/builtin-mem.c
> index d43500b92a7b..6101a26b3a78 100644
> --- a/tools/perf/builtin-mem.c
> +++ b/tools/perf/builtin-mem.c
> @@ -255,7 +255,6 @@ dump_raw_samples(const struct perf_tool *tool,
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel __maybe_unused,
>  				struct machine *machine)
>  {
>  	return dump_raw_samples(tool, event, sample, machine);
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 663ca3a03396..f3cf0c20077b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1488,7 +1488,6 @@ static void set_timestamp_boundary(struct record *rec, u64 sample_time)
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	struct record *rec = container_of(tool, struct record, tool);
> @@ -1499,7 +1498,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  		return 0;
>  
>  	rec->samples++;
> -	return build_id__mark_dso_hit(tool, event, sample, evsel, machine);
> +	return build_id__mark_dso_hit(tool, event, sample, machine);
>  }
>  
>  static int process_buildids(struct record *rec)
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 2e936928e8c0..2ac2c5afd824 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -170,7 +170,6 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
>  	int err = 0;
>  	struct report *rep = arg;
>  	struct hist_entry *he = iter->he;
> -	struct evsel *evsel = iter->evsel;
>  	struct perf_sample *sample = iter->sample;
>  	struct mem_info *mi;
>  	struct branch_info *bi;
> @@ -180,25 +179,25 @@ static int hist_iter__report_callback(struct hist_entry_iter *iter,
>  
>  	if (sort__mode == SORT_MODE__BRANCH) {
>  		bi = he->branch_info;
> -		err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
> +		err = addr_map_symbol__inc_samples(&bi->from, sample);
>  		if (err)
>  			goto out;
>  
> -		err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
> +		err = addr_map_symbol__inc_samples(&bi->to, sample);
>  
>  	} else if (rep->mem_mode) {
>  		mi = he->mem_info;
> -		err = addr_map_symbol__inc_samples(mem_info__daddr(mi), sample, evsel);
> +		err = addr_map_symbol__inc_samples(mem_info__daddr(mi), sample);
>  		if (err)
>  			goto out;
>  
> -		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
> +		err = hist_entry__inc_addr_samples(he, sample, al->addr);
>  
>  	} else if (symbol_conf.cumulate_callchain) {
>  		if (single)
> -			err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
> +			err = hist_entry__inc_addr_samples(he, sample, al->addr);
>  	} else {
> -		err = hist_entry__inc_addr_samples(he, sample, evsel, al->addr);
> +		err = hist_entry__inc_addr_samples(he, sample, al->addr);
>  	}
>  
>  out:
> @@ -214,7 +213,6 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>  	struct report *rep = arg;
>  	struct branch_info *bi = he->branch_info;
>  	struct perf_sample *sample = iter->sample;
> -	struct evsel *evsel = iter->evsel;
>  	int err;
>  
>  	branch_type_count(&rep->brtype_stat, &bi->flags,
> @@ -223,11 +221,11 @@ static int hist_iter__branch_callback(struct hist_entry_iter *iter,
>  	if (!ui__has_annotation() && !rep->symbol_ipc)
>  		return 0;
>  
> -	err = addr_map_symbol__inc_samples(&bi->from, sample, evsel);
> +	err = addr_map_symbol__inc_samples(&bi->from, sample);
>  	if (err)
>  		goto out;
>  
> -	err = addr_map_symbol__inc_samples(&bi->to, sample, evsel);
> +	err = addr_map_symbol__inc_samples(&bi->to, sample);
>  
>  out:
>  	return err;
> @@ -269,13 +267,12 @@ static int process_feature_event(const struct perf_tool *tool,
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	struct report *rep = container_of(tool, struct report, tool);
> +	struct evsel *evsel = sample->evsel;
>  	struct addr_location al;
>  	struct hist_entry_iter iter = {
> -		.evsel 			= evsel,
>  		.sample 		= sample,
>  		.hide_unresolved 	= symbol_conf.hide_unresolved,
>  		.add_entry_cb 		= hist_iter__report_callback,
> @@ -331,7 +328,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  	if (ui__has_annotation() || rep->symbol_ipc || rep->total_cycles_mode) {
>  		hist__account_cycles(sample->branch_stack, &al, sample,
>  				     rep->nonany_branch_mode,
> -				     &rep->total_cycles, evsel);
> +				     &rep->total_cycles);
>  	}
>  
>  	rep->total_samples++;
> @@ -348,8 +345,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  
>  static int process_read_event(const struct perf_tool *tool,
>  			      union perf_event *event,
> -			      struct perf_sample *sample __maybe_unused,
> -			      struct evsel *evsel,
> +			      struct perf_sample *sample,
>  			      struct machine *machine __maybe_unused)
>  {
>  	struct report *rep = container_of(tool, struct report, tool);
> @@ -357,7 +353,7 @@ static int process_read_event(const struct perf_tool *tool,
>  	if (rep->show_threads) {
>  		int err = perf_read_values_add_value(&rep->show_threads_values,
>  					   event->read.pid, event->read.tid,
> -					   evsel,
> +					   sample->evsel,
>  					   event->read.value);
>  
>  		if (err)
> @@ -783,10 +779,10 @@ static void report__output_resort(struct report *rep)
>  
>  static int count_sample_event(const struct perf_tool *tool __maybe_unused,
>  			      union perf_event *event __maybe_unused,
> -			      struct perf_sample *sample __maybe_unused,
> -			      struct evsel *evsel,
> +			      struct perf_sample *sample,
>  			      struct machine *machine __maybe_unused)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct hists *hists = evsel__hists(evsel);
>  
>  	hists__inc_nr_events(hists);
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index b190e928117c..ac3e19ec7b95 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -128,21 +128,20 @@ typedef int (*sort_fn_t)(struct work_atoms *, struct work_atoms *);
>  struct perf_sched;
>  
>  struct trace_sched_handler {
> -	int (*switch_event)(struct perf_sched *sched, struct evsel *evsel,
> -			    struct perf_sample *sample, struct machine *machine);
> +	int (*switch_event)(struct perf_sched *sched, struct perf_sample *sample,
> +			    struct machine *machine);
>  
> -	int (*runtime_event)(struct perf_sched *sched, struct evsel *evsel,
> -			     struct perf_sample *sample, struct machine *machine);
> +	int (*runtime_event)(struct perf_sched *sched, struct perf_sample *sample,
> +			     struct machine *machine);
>  
> -	int (*wakeup_event)(struct perf_sched *sched, struct evsel *evsel,
> -			    struct perf_sample *sample, struct machine *machine);
> +	int (*wakeup_event)(struct perf_sched *sched, struct perf_sample *sample,
> +			    struct machine *machine);
>  
>  	/* PERF_RECORD_FORK event, not sched_process_fork tracepoint */
>  	int (*fork_event)(struct perf_sched *sched, union perf_event *event,
>  			  struct machine *machine);
>  
>  	int (*migrate_task_event)(struct perf_sched *sched,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  struct machine *machine);
>  };
> @@ -825,15 +824,15 @@ static void test_calibrations(struct perf_sched *sched)
>  
>  static int
>  replay_wakeup_event(struct perf_sched *sched,
> -		    struct evsel *evsel, struct perf_sample *sample,
> +		    struct perf_sample *sample,
>  		    struct machine *machine __maybe_unused)
>  {
> -	const char *comm = evsel__strval(evsel, sample, "comm");
> -	const u32 pid	 = evsel__intval(evsel, sample, "pid");
> +	const char *comm = evsel__strval(sample, "comm");
> +	const u32 pid	 = evsel__intval(sample, "pid");
>  	struct task_desc *waker, *wakee;
>  
>  	if (verbose > 0) {
> -		printf("sched_wakeup event %p\n", evsel);
> +		printf("sched_wakeup event %p\n", sample->evsel);
>  
>  		printf(" ... pid %d woke up %s/%d\n", sample->tid, comm, pid);
>  	}
> @@ -846,21 +845,20 @@ replay_wakeup_event(struct perf_sched *sched,
>  }
>  
>  static int replay_switch_event(struct perf_sched *sched,
> -			       struct evsel *evsel,
>  			       struct perf_sample *sample,
>  			       struct machine *machine __maybe_unused)
>  {
> -	const char *prev_comm  = evsel__strval(evsel, sample, "prev_comm"),
> -		   *next_comm  = evsel__strval(evsel, sample, "next_comm");
> -	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
> -		  next_pid = evsel__intval(evsel, sample, "next_pid");
> +	const char *prev_comm  = evsel__strval(sample, "prev_comm"),
> +		   *next_comm  = evsel__strval(sample, "next_comm");
> +	const u32 prev_pid = evsel__intval(sample, "prev_pid"),
> +		  next_pid = evsel__intval(sample, "next_pid");
>  	struct task_desc *prev, __maybe_unused *next;
>  	u64 timestamp0, timestamp = sample->time;
>  	int cpu = sample->cpu;
>  	s64 delta;
>  
>  	if (verbose > 0)
> -		printf("sched_switch event %p\n", evsel);
> +		printf("sched_switch event %p\n", sample->evsel);
>  
>  	if (cpu >= MAX_CPUS || cpu < 0)
>  		return 0;
> @@ -1133,13 +1131,12 @@ static void free_work_atoms(struct work_atoms *atoms)
>  }
>  
>  static int latency_switch_event(struct perf_sched *sched,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct machine *machine)
>  {
> -	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
> -		  next_pid = evsel__intval(evsel, sample, "next_pid");
> -	const char prev_state = evsel__taskstate(evsel, sample, "prev_state");
> +	const u32 prev_pid = evsel__intval(sample, "prev_pid"),
> +		  next_pid = evsel__intval(sample, "next_pid");
> +	const char prev_state = evsel__taskstate(sample, "prev_state");
>  	struct work_atoms *out_events, *in_events;
>  	struct thread *sched_out, *sched_in;
>  	u64 timestamp0, timestamp = sample->time;
> @@ -1203,12 +1200,11 @@ static int latency_switch_event(struct perf_sched *sched,
>  }
>  
>  static int latency_runtime_event(struct perf_sched *sched,
> -				 struct evsel *evsel,
>  				 struct perf_sample *sample,
>  				 struct machine *machine)
>  {
> -	const u32 pid	   = evsel__intval(evsel, sample, "pid");
> -	const u64 runtime  = evsel__intval(evsel, sample, "runtime");
> +	const u32 pid	   = evsel__intval(sample, "pid");
> +	const u64 runtime  = evsel__intval(sample, "runtime");
>  	struct thread *thread = machine__findnew_thread(machine, -1, pid);
>  	struct work_atoms *atoms = thread_atoms_search(&sched->atom_root, thread, &sched->cmp_pid);
>  	u64 timestamp = sample->time;
> @@ -1238,11 +1234,10 @@ static int latency_runtime_event(struct perf_sched *sched,
>  }
>  
>  static int latency_wakeup_event(struct perf_sched *sched,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct machine *machine)
>  {
> -	const u32 pid	  = evsel__intval(evsel, sample, "pid");
> +	const u32 pid	  = evsel__intval(sample, "pid");
>  	struct work_atoms *atoms;
>  	struct work_atom *atom;
>  	struct thread *wakee;
> @@ -1299,11 +1294,10 @@ static int latency_wakeup_event(struct perf_sched *sched,
>  }
>  
>  static int latency_migrate_task_event(struct perf_sched *sched,
> -				      struct evsel *evsel,
>  				      struct perf_sample *sample,
>  				      struct machine *machine)
>  {
> -	const u32 pid = evsel__intval(evsel, sample, "pid");
> +	const u32 pid = evsel__intval(sample, "pid");
>  	u64 timestamp = sample->time;
>  	struct work_atoms *atoms;
>  	struct work_atom *atom;
> @@ -1518,20 +1512,18 @@ static void perf_sched__sort_lat(struct perf_sched *sched)
>  }
>  
>  static int process_sched_wakeup_event(const struct perf_tool *tool,
> -				      struct evsel *evsel,
>  				      struct perf_sample *sample,
>  				      struct machine *machine)
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  
>  	if (sched->tp_handler->wakeup_event)
> -		return sched->tp_handler->wakeup_event(sched, evsel, sample, machine);
> +		return sched->tp_handler->wakeup_event(sched, sample, machine);
>  
>  	return 0;
>  }
>  
>  static int process_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
> -				      struct evsel *evsel __maybe_unused,
>  				      struct perf_sample *sample __maybe_unused,
>  				      struct machine *machine __maybe_unused)
>  {
> @@ -1625,11 +1617,11 @@ static void print_sched_map(struct perf_sched *sched, struct perf_cpu this_cpu,
>  	}
>  }
>  
> -static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
> -			    struct perf_sample *sample, struct machine *machine)
> +static int map_switch_event(struct perf_sched *sched, struct perf_sample *sample,
> +			    struct machine *machine)
>  {
> -	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
> -	const u32 prev_pid = evsel__intval(evsel, sample, "prev_pid");
> +	const u32 next_pid = evsel__intval(sample, "next_pid");
> +	const u32 prev_pid = evsel__intval(sample, "prev_pid");
>  	struct thread *sched_in, *sched_out;
>  	struct thread_runtime *tr;
>  	int new_shortname;
> @@ -1790,14 +1782,13 @@ static int map_switch_event(struct perf_sched *sched, struct evsel *evsel,
>  }
>  
>  static int process_sched_switch_event(const struct perf_tool *tool,
> -				      struct evsel *evsel,
>  				      struct perf_sample *sample,
>  				      struct machine *machine)
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  	int this_cpu = sample->cpu, err = 0;
> -	u32 prev_pid = evsel__intval(evsel, sample, "prev_pid"),
> -	    next_pid = evsel__intval(evsel, sample, "next_pid");
> +	u32 prev_pid = evsel__intval(sample, "prev_pid"),
> +	    next_pid = evsel__intval(sample, "next_pid");
>  
>  	if (sched->curr_pid[this_cpu] != (u32)-1) {
>  		/*
> @@ -1809,21 +1800,20 @@ static int process_sched_switch_event(const struct perf_tool *tool,
>  	}
>  
>  	if (sched->tp_handler->switch_event)
> -		err = sched->tp_handler->switch_event(sched, evsel, sample, machine);
> +		err = sched->tp_handler->switch_event(sched, sample, machine);
>  
>  	sched->curr_pid[this_cpu] = next_pid;
>  	return err;
>  }
>  
>  static int process_sched_runtime_event(const struct perf_tool *tool,
> -				       struct evsel *evsel,
>  				       struct perf_sample *sample,
>  				       struct machine *machine)
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  
>  	if (sched->tp_handler->runtime_event)
> -		return sched->tp_handler->runtime_event(sched, evsel, sample, machine);
> +		return sched->tp_handler->runtime_event(sched, sample, machine);
>  
>  	return 0;
>  }
> @@ -1846,34 +1836,32 @@ static int perf_sched__process_fork_event(const struct perf_tool *tool,
>  }
>  
>  static int process_sched_migrate_task_event(const struct perf_tool *tool,
> -					    struct evsel *evsel,
>  					    struct perf_sample *sample,
>  					    struct machine *machine)
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
>  
>  	if (sched->tp_handler->migrate_task_event)
> -		return sched->tp_handler->migrate_task_event(sched, evsel, sample, machine);
> +		return sched->tp_handler->migrate_task_event(sched, sample, machine);
>  
>  	return 0;
>  }
>  
>  typedef int (*tracepoint_handler)(const struct perf_tool *tool,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  struct machine *machine);
>  
>  static int perf_sched__process_tracepoint_sample(const struct perf_tool *tool __maybe_unused,
>  						 union perf_event *event __maybe_unused,
>  						 struct perf_sample *sample,
> -						 struct evsel *evsel,
>  						 struct machine *machine)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	int err = 0;
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> -		err = f(tool, evsel, sample, machine);
> +		err = f(tool, sample, machine);
>  	}
>  
>  	return err;
> @@ -2067,12 +2055,11 @@ static char *timehist_get_commstr(struct thread *thread)
>  
>  /* prio field format: xxx or xxx->yyy */
>  #define MAX_PRIO_STR_LEN 8
> -static char *timehist_get_priostr(struct evsel *evsel,
> -				  struct thread *thread,
> +static char *timehist_get_priostr(struct thread *thread,
>  				  struct perf_sample *sample)
>  {
>  	static char prio_str[16];
> -	int prev_prio = (int)evsel__intval(evsel, sample, "prev_prio");
> +	int prev_prio = (int)evsel__intval(sample, "prev_prio");
>  	struct thread_runtime *tr = thread__priv(thread);
>  
>  	if (tr->prio != prev_prio && tr->prio != -1)
> @@ -2160,15 +2147,14 @@ static void timehist_header(struct perf_sched *sched)
>  }
>  
>  static void timehist_print_sample(struct perf_sched *sched,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  struct addr_location *al,
>  				  struct thread *thread,
>  				  u64 t, const char state)
>  {
>  	struct thread_runtime *tr = thread__priv(thread);
> -	const char *next_comm = evsel__strval(evsel, sample, "next_comm");
> -	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
> +	const char *next_comm = evsel__strval(sample, "next_comm");
> +	const u32 next_pid = evsel__intval(sample, "next_pid");
>  	u32 max_cpus = sched->max_cpu.cpu + 1;
>  	char tstr[64];
>  	char nstr[30];
> @@ -2197,14 +2183,15 @@ static void timehist_print_sample(struct perf_sched *sched,
>  	}
>  
>  	if (!thread__comm_set(thread)) {
> -                const char *prev_comm = evsel__strval(evsel, sample, "prev_comm");
> -                thread__set_comm(thread, prev_comm, sample->time);
> +		const char *prev_comm = evsel__strval(sample, "prev_comm");
> +
> +		thread__set_comm(thread, prev_comm, sample->time);
>          }
>  
>  	printf(" %-*s ", comm_width, timehist_get_commstr(thread));
>  
>  	if (sched->show_prio)
> -		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(evsel, thread, sample));
> +		printf(" %-*s ", MAX_PRIO_STR_LEN, timehist_get_priostr(thread, sample));
>  
>  	wait_time = tr->dt_sleep + tr->dt_iowait + tr->dt_preempt;
>  	print_sched_time(wait_time, 6);
> @@ -2313,19 +2300,17 @@ static void timehist_update_runtime_stats(struct thread_runtime *r,
>  	r->total_pre_mig_time += r->dt_pre_mig;
>  }
>  
> -static bool is_idle_sample(struct perf_sample *sample,
> -			   struct evsel *evsel)
> +static bool is_idle_sample(struct perf_sample *sample)
>  {
>  	/* pid 0 == swapper == idle task */
> -	if (evsel__name_is(evsel, "sched:sched_switch"))
> -		return evsel__intval(evsel, sample, "prev_pid") == 0;
> +	if (evsel__name_is(sample->evsel, "sched:sched_switch"))
> +		return evsel__intval(sample, "prev_pid") == 0;
>  
>  	return sample->pid == 0;
>  }
>  
>  static void save_task_callchain(struct perf_sched *sched,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	struct callchain_cursor *cursor;
> @@ -2345,8 +2330,9 @@ static void save_task_callchain(struct perf_sched *sched,
>  
>  	cursor = get_tls_callchain_cursor();
>  
> -	if (thread__resolve_callchain(thread, cursor, evsel, sample,
> -				      NULL, NULL, sched->max_stack + 2) != 0) {
> +	if (thread__resolve_callchain(thread, cursor, sample,
> +				      /*parent=*/NULL, /*root_al=*/NULL,
> +				      sched->max_stack + 2) != 0) {
>  		if (verbose > 0)
>  			pr_err("Failed to resolve callchain. Skipping\n");
>  
> @@ -2500,12 +2486,11 @@ static void save_idle_callchain(struct perf_sched *sched,
>  
>  static struct thread *timehist_get_thread(struct perf_sched *sched,
>  					  struct perf_sample *sample,
> -					  struct machine *machine,
> -					  struct evsel *evsel)
> +					  struct machine *machine)
>  {
>  	struct thread *thread;
>  
> -	if (is_idle_sample(sample, evsel)) {
> +	if (is_idle_sample(sample)) {
>  		thread = get_idle_thread(sample->cpu);
>  		if (thread == NULL)
>  			pr_err("Failed to get idle thread for cpu %d.\n", sample->cpu);
> @@ -2519,7 +2504,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
>  				 sample->tid);
>  		}
>  
> -		save_task_callchain(sched, sample, evsel, machine);
> +		save_task_callchain(sched, sample, machine);
>  		if (sched->idle_hist) {
>  			struct thread *idle;
>  			struct idle_thread_runtime *itr;
> @@ -2538,7 +2523,7 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
>  			itr->last_thread = thread__get(thread);
>  
>  			/* copy task callchain when entering to idle */
> -			if (evsel__intval(evsel, sample, "next_pid") == 0)
> +			if (evsel__intval(sample, "next_pid") == 0)
>  				save_idle_callchain(sched, itr, sample);
>  		}
>  	}
> @@ -2548,7 +2533,6 @@ static struct thread *timehist_get_thread(struct perf_sched *sched,
>  
>  static bool timehist_skip_sample(struct perf_sched *sched,
>  				 struct thread *thread,
> -				 struct evsel *evsel,
>  				 struct perf_sample *sample)
>  {
>  	bool rc = false;
> @@ -2570,8 +2554,8 @@ static bool timehist_skip_sample(struct perf_sched *sched,
>  		tr = thread__get_runtime(thread);
>  		if (tr && tr->prio != -1)
>  			prio = tr->prio;
> -		else if (evsel__name_is(evsel, "sched:sched_switch"))
> -			prio = evsel__intval(evsel, sample, "prev_prio");
> +		else if (evsel__name_is(sample->evsel, "sched:sched_switch"))
> +			prio = evsel__intval(sample, "prev_prio");
>  
>  		if (prio != -1 && !test_bit(prio, sched->prio_bitmap)) {
>  			rc = true;
> @@ -2580,10 +2564,10 @@ static bool timehist_skip_sample(struct perf_sched *sched,
>  	}
>  
>  	if (sched->idle_hist) {
> -		if (!evsel__name_is(evsel, "sched:sched_switch"))
> +		if (!evsel__name_is(sample->evsel, "sched:sched_switch"))
>  			rc = true;
> -		else if (evsel__intval(evsel, sample, "prev_pid") != 0 &&
> -			 evsel__intval(evsel, sample, "next_pid") != 0)
> +		else if (evsel__intval(sample, "prev_pid") != 0 &&
> +			 evsel__intval(sample, "next_pid") != 0)
>  			rc = true;
>  	}
>  
> @@ -2591,7 +2575,6 @@ static bool timehist_skip_sample(struct perf_sched *sched,
>  }
>  
>  static void timehist_print_wakeup_event(struct perf_sched *sched,
> -					struct evsel *evsel,
>  					struct perf_sample *sample,
>  					struct machine *machine,
>  					struct thread *awakened)
> @@ -2604,8 +2587,8 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
>  		return;
>  
>  	/* show wakeup unless both awakee and awaker are filtered */
> -	if (timehist_skip_sample(sched, thread, evsel, sample) &&
> -	    timehist_skip_sample(sched, awakened, evsel, sample)) {
> +	if (timehist_skip_sample(sched, thread, sample) &&
> +	    timehist_skip_sample(sched, awakened, sample)) {
>  		thread__put(thread);
>  		return;
>  	}
> @@ -2629,7 +2612,6 @@ static void timehist_print_wakeup_event(struct perf_sched *sched,
>  
>  static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unused,
>  					union perf_event *event __maybe_unused,
> -					struct evsel *evsel __maybe_unused,
>  					struct perf_sample *sample __maybe_unused,
>  					struct machine *machine __maybe_unused)
>  {
> @@ -2638,7 +2620,6 @@ static int timehist_sched_wakeup_ignore(const struct perf_tool *tool __maybe_unu
>  
>  static int timehist_sched_wakeup_event(const struct perf_tool *tool,
>  				       union perf_event *event __maybe_unused,
> -				       struct evsel *evsel,
>  				       struct perf_sample *sample,
>  				       struct machine *machine)
>  {
> @@ -2646,7 +2627,7 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
>  	struct thread *thread;
>  	struct thread_runtime *tr = NULL;
>  	/* want pid of awakened task not pid in sample */
> -	const u32 pid = evsel__intval(evsel, sample, "pid");
> +	const u32 pid = evsel__intval(sample, "pid");
>  
>  	thread = machine__findnew_thread(machine, 0, pid);
>  	if (thread == NULL)
> @@ -2664,14 +2645,13 @@ static int timehist_sched_wakeup_event(const struct perf_tool *tool,
>  	/* show wakeups if requested */
>  	if (sched->show_wakeups &&
>  	    !perf_time__skip_sample(&sched->ptime, sample->time))
> -		timehist_print_wakeup_event(sched, evsel, sample, machine, thread);
> +		timehist_print_wakeup_event(sched, sample, machine, thread);
>  
>  	thread__put(thread);
>  	return 0;
>  }
>  
>  static void timehist_print_migration_event(struct perf_sched *sched,
> -					struct evsel *evsel,
>  					struct perf_sample *sample,
>  					struct machine *machine,
>  					struct thread *migrated)
> @@ -2685,15 +2665,15 @@ static void timehist_print_migration_event(struct perf_sched *sched,
>  		return;
>  
>  	max_cpus = sched->max_cpu.cpu + 1;
> -	ocpu = evsel__intval(evsel, sample, "orig_cpu");
> -	dcpu = evsel__intval(evsel, sample, "dest_cpu");
> +	ocpu = evsel__intval(sample, "orig_cpu");
> +	dcpu = evsel__intval(sample, "dest_cpu");
>  
>  	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
>  	if (thread == NULL)
>  		return;
>  
> -	if (timehist_skip_sample(sched, thread, evsel, sample) &&
> -	    timehist_skip_sample(sched, migrated, evsel, sample)) {
> +	if (timehist_skip_sample(sched, thread, sample) &&
> +	    timehist_skip_sample(sched, migrated, sample)) {
>  		thread__put(thread);
>  		return;
>  	}
> @@ -2727,7 +2707,6 @@ static void timehist_print_migration_event(struct perf_sched *sched,
>  
>  static int timehist_migrate_task_event(const struct perf_tool *tool,
>  				       union perf_event *event __maybe_unused,
> -				       struct evsel *evsel,
>  				       struct perf_sample *sample,
>  				       struct machine *machine)
>  {
> @@ -2735,7 +2714,7 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
>  	struct thread *thread;
>  	struct thread_runtime *tr = NULL;
>  	/* want pid of migrated task not pid in sample */
> -	const u32 pid = evsel__intval(evsel, sample, "pid");
> +	const u32 pid = evsel__intval(sample, "pid");
>  
>  	thread = machine__findnew_thread(machine, 0, pid);
>  	if (thread == NULL)
> @@ -2751,23 +2730,21 @@ static int timehist_migrate_task_event(const struct perf_tool *tool,
>  	tr->migrated = sample->time;
>  
>  	/* show migrations if requested */
> -	if (sched->show_migrations) {
> -		timehist_print_migration_event(sched, evsel, sample,
> -							machine, thread);
> -	}
> +	if (sched->show_migrations)
> +		timehist_print_migration_event(sched, sample, machine, thread);
> +
>  	thread__put(thread);
>  
>  	return 0;
>  }
>  
> -static void timehist_update_task_prio(struct evsel *evsel,
> -				      struct perf_sample *sample,
> +static void timehist_update_task_prio(struct perf_sample *sample,
>  				      struct machine *machine)
>  {
>  	struct thread *thread;
>  	struct thread_runtime *tr = NULL;
> -	const u32 next_pid = evsel__intval(evsel, sample, "next_pid");
> -	const u32 next_prio = evsel__intval(evsel, sample, "next_prio");
> +	const u32 next_pid = evsel__intval(sample, "next_pid");
> +	const u32 next_prio = evsel__intval(sample, "next_prio");
>  
>  	if (next_pid == 0)
>  		thread = get_idle_thread(sample->cpu);
> @@ -2786,7 +2763,6 @@ static void timehist_update_task_prio(struct evsel *evsel,
>  
>  static int timehist_sched_change_event(const struct perf_tool *tool,
>  				       union perf_event *event,
> -				       struct evsel *evsel,
>  				       struct perf_sample *sample,
>  				       struct machine *machine)
>  {
> @@ -2797,7 +2773,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  	struct thread_runtime *tr = NULL;
>  	u64 tprev, t = sample->time;
>  	int rc = 0;
> -	const char state = evsel__taskstate(evsel, sample, "prev_state");
> +	const char state = evsel__taskstate(sample, "prev_state");
>  
>  	addr_location__init(&al);
>  	if (machine__resolve(machine, &al, sample) < 0) {
> @@ -2808,15 +2784,15 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  	}
>  
>  	if (sched->show_prio || sched->prio_str)
> -		timehist_update_task_prio(evsel, sample, machine);
> +		timehist_update_task_prio(sample, machine);
>  
> -	thread = timehist_get_thread(sched, sample, machine, evsel);
> +	thread = timehist_get_thread(sched, sample, machine);
>  	if (thread == NULL) {
>  		rc = -1;
>  		goto out;
>  	}
>  
> -	if (timehist_skip_sample(sched, thread, evsel, sample))
> +	if (timehist_skip_sample(sched, thread, sample))
>  		goto out;
>  
>  	tr = thread__get_runtime(thread);
> @@ -2825,7 +2801,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  		goto out;
>  	}
>  
> -	tprev = evsel__get_time(evsel, sample->cpu);
> +	tprev = evsel__get_time(sample->evsel, sample->cpu);
>  
>  	/*
>  	 * If start time given:
> @@ -2890,7 +2866,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  		}
>  
>  		if (!sched->summary_only)
> -			timehist_print_sample(sched, evsel, sample, &al, thread, t, state);
> +			timehist_print_sample(sched, sample, &al, thread, t, state);
>  	}
>  
>  out:
> @@ -2915,7 +2891,7 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  		tr->migrated = 0;
>  	}
>  
> -	evsel__save_time(evsel, sample->time, sample->cpu);
> +	evsel__save_time(sample->evsel, sample->time, sample->cpu);
>  
>  	thread__put(thread);
>  	addr_location__exit(&al);
> @@ -2924,11 +2900,10 @@ static int timehist_sched_change_event(const struct perf_tool *tool,
>  
>  static int timehist_sched_switch_event(const struct perf_tool *tool,
>  			     union perf_event *event,
> -			     struct evsel *evsel,
>  			     struct perf_sample *sample,
>  			     struct machine *machine __maybe_unused)
>  {
> -	return timehist_sched_change_event(tool, event, evsel, sample, machine);
> +	return timehist_sched_change_event(tool, event, sample, machine);
>  }
>  
>  static int process_lost(const struct perf_tool *tool __maybe_unused,
> @@ -3176,17 +3151,16 @@ static void timehist_print_summary(struct perf_sched *sched,
>  
>  typedef int (*sched_handler)(const struct perf_tool *tool,
>  			  union perf_event *event,
> -			  struct evsel *evsel,
>  			  struct perf_sample *sample,
>  			  struct machine *machine);
>  
>  static int perf_timehist__process_sample(const struct perf_tool *tool,
>  					 union perf_event *event,
>  					 struct perf_sample *sample,
> -					 struct evsel *evsel,
>  					 struct machine *machine)
>  {
>  	struct perf_sched *sched = container_of(tool, struct perf_sched, tool);
> +	struct evsel *evsel = sample->evsel;
>  	int err = 0;
>  	struct perf_cpu this_cpu = {
>  		.cpu = sample->cpu,
> @@ -3198,7 +3172,7 @@ static int perf_timehist__process_sample(const struct perf_tool *tool,
>  	if (evsel->handler != NULL) {
>  		sched_handler f = evsel->handler;
>  
> -		err = f(tool, event, evsel, sample, machine);
> +		err = f(tool, event, sample, machine);
>  	}
>  
>  	return err;
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 372bede30230..e636a57012fe 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -809,9 +809,9 @@ static int perf_sample__fprintf_uregs(struct perf_sample *sample,
>  static int perf_sample__fprintf_start(struct perf_script *script,
>  				      struct perf_sample *sample,
>  				      struct thread *thread,
> -				      struct evsel *evsel,
>  				      u32 type, FILE *fp)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	unsigned long secs;
>  	unsigned long long nsecs;
>  	int printed = 0;
> @@ -1531,7 +1531,6 @@ static int perf_sample__fprintf_addr(struct perf_sample *sample,
>  }
>  
>  static const char *resolve_branch_sym(struct perf_sample *sample,
> -				      struct evsel *evsel,
>  				      struct thread *thread,
>  				      struct addr_location *al,
>  				      struct addr_location *addr_al,
> @@ -1540,7 +1539,7 @@ static const char *resolve_branch_sym(struct perf_sample *sample,
>  	const char *name = NULL;
>  
>  	if (sample->flags & (PERF_IP_FLAG_CALL | PERF_IP_FLAG_TRACE_BEGIN)) {
> -		if (sample_addr_correlates_sym(&evsel->core.attr)) {
> +		if (sample_addr_correlates_sym(&sample->evsel->core.attr)) {
>  			if (!addr_al->thread)
>  				thread__resolve(thread, addr_al, sample);
>  			if (addr_al->sym)
> @@ -1580,7 +1579,7 @@ static int perf_sample__fprintf_callindent(struct perf_sample *sample,
>  	if (thread__ts(thread) && sample->flags & PERF_IP_FLAG_RETURN)
>  		depth += 1;
>  
> -	name = resolve_branch_sym(sample, evsel, thread, al, addr_al, &ip);
> +	name = resolve_branch_sym(sample, thread, al, addr_al, &ip);
>  
>  	if (PRINT_FIELD(DSO) && !(PRINT_FIELD(IP) || PRINT_FIELD(ADDR))) {
>  		dlen += fprintf(fp, "(");
> @@ -1672,8 +1671,8 @@ static int perf_sample__fprintf_bts(struct perf_sample *sample,
>  
>  		if (symbol_conf.use_callchain && sample->callchain) {
>  			cursor = get_tls_callchain_cursor();
> -			if (thread__resolve_callchain(al->thread, cursor, evsel,
> -						      sample, NULL, NULL,
> +			if (thread__resolve_callchain(al->thread, cursor, sample,
> +						      /*parent=*/NULL, /*root_al=*/NULL,
>  						      scripting_max_stack))
>  				cursor = NULL;
>  		}
> @@ -2084,7 +2083,6 @@ static int data_src__fprintf(u64 data_src, FILE *fp)
>  struct metric_ctx {
>  	struct perf_sample	*sample;
>  	struct thread		*thread;
> -	struct evsel	*evsel;
>  	FILE 			*fp;
>  };
>  
> @@ -2097,7 +2095,7 @@ static void script_print_metric(struct perf_stat_config *config __maybe_unused,
>  
>  	if (!fmt)
>  		return;
> -	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
> +	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread,
>  				   PERF_RECORD_SAMPLE, mctx->fp);
>  	fputs("\tmetric: ", mctx->fp);
>  	if (color)
> @@ -2112,7 +2110,7 @@ static void script_new_line(struct perf_stat_config *config __maybe_unused,
>  {
>  	struct metric_ctx *mctx = ctx;
>  
> -	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread, mctx->evsel,
> +	perf_sample__fprintf_start(NULL, mctx->sample, mctx->thread,
>  				   PERF_RECORD_SAMPLE, mctx->fp);
>  	fputs("\tmetric: ", mctx->fp);
>  }
> @@ -2278,7 +2276,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
>  		.ctx = &(struct metric_ctx) {
>  				.sample = sample,
>  				.thread = thread,
> -				.evsel  = evsel,
>  				.fp     = fp,
>  			 },
>  		.force_header = false,
> @@ -2365,7 +2362,6 @@ static void perf_sample__fprint_metric(struct thread *thread,
>  }
>  
>  static bool show_event(struct perf_sample *sample,
> -		       struct evsel *evsel,
>  		       struct thread *thread,
>  		       struct addr_location *al,
>  		       struct addr_location *addr_al)
> @@ -2384,7 +2380,7 @@ static bool show_event(struct perf_sample *sample,
>  	} else {
>  		const char *s = symbol_conf.graph_function;
>  		u64 ip;
> -		const char *name = resolve_branch_sym(sample, evsel, thread, al, addr_al,
> +		const char *name = resolve_branch_sym(sample, thread, al, addr_al,
>  				&ip);
>  		unsigned nlen;
>  
> @@ -2407,12 +2403,13 @@ static bool show_event(struct perf_sample *sample,
>  }
>  
>  static void process_event(struct perf_script *script,
> -			  struct perf_sample *sample, struct evsel *evsel,
> +			  struct perf_sample *sample,
>  			  struct addr_location *al,
>  			  struct addr_location *addr_al,
>  			  struct machine *machine)
>  {
>  	struct thread *thread = al->thread;
> +	struct evsel *evsel = sample->evsel;
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  	unsigned int type = evsel__output_type(evsel);
>  	struct evsel_script *es = evsel->priv;
> @@ -2424,7 +2421,7 @@ static void process_event(struct perf_script *script,
>  
>  	++es->samples;
>  
> -	perf_sample__fprintf_start(script, sample, thread, evsel,
> +	perf_sample__fprintf_start(script, sample, thread,
>  				   PERF_RECORD_SAMPLE, fp);
>  
>  	if (PRINT_FIELD(PERIOD))
> @@ -2494,8 +2491,8 @@ static void process_event(struct perf_script *script,
>  
>  		if (symbol_conf.use_callchain && sample->callchain) {
>  			cursor = get_tls_callchain_cursor();
> -			if (thread__resolve_callchain(al->thread, cursor, evsel,
> -						      sample, NULL, NULL,
> +			if (thread__resolve_callchain(al->thread, cursor, sample,
> +						      /*parent=*/NULL, /*root_al=*/NULL,
>  						      scripting_max_stack))
>  				cursor = NULL;
>  		}
> @@ -2624,12 +2621,12 @@ static bool filter_cpu(struct perf_sample *sample)
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
>  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
>  	struct addr_location al;
>  	struct addr_location addr_al;
> +	struct evsel *evsel = sample->evsel;
>  	int ret = 0;
>  
>  	/* Set thread to NULL to indicate addr_al and al are not initialized */
> @@ -2672,7 +2669,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  	if (al.filtered)
>  		goto out_put;
>  
> -	if (!show_event(sample, evsel, al.thread, &al, &addr_al))
> +	if (!show_event(sample, al.thread, &al, &addr_al))
>  		goto out_put;
>  
>  	if (evswitch__discard(&scr->evswitch, evsel))
> @@ -2694,9 +2691,9 @@ static int process_sample_event(const struct perf_tool *tool,
>  				thread__resolve(al.thread, &addr_al, sample);
>  			addr_al_ptr = &addr_al;
>  		}
> -		scripting_ops->process_event(event, sample, evsel, &al, addr_al_ptr);
> +		scripting_ops->process_event(event, sample, &al, addr_al_ptr);
>  	} else {
> -		process_event(scr, sample, evsel, &al, &addr_al, machine);
> +		process_event(scr, sample, &al, &addr_al, machine);
>  	}
>  
>  out_put:
> @@ -2708,10 +2705,10 @@ static int process_sample_event(const struct perf_tool *tool,
>  static int process_deferred_sample_event(const struct perf_tool *tool,
>  					 union perf_event *event,
>  					 struct perf_sample *sample,
> -					 struct evsel *evsel,
>  					 struct machine *machine)
>  {
>  	struct perf_script *scr = container_of(tool, struct perf_script, tool);
> +	struct evsel *evsel = sample->evsel;
>  	struct perf_event_attr *attr = &evsel->core.attr;
>  	struct evsel_script *es = evsel->priv;
>  	unsigned int type = output_type(attr->type);
> @@ -2754,13 +2751,13 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
>  	if (al.filtered)
>  		goto out_put;
>  
> -	if (!show_event(sample, evsel, al.thread, &al, NULL))
> +	if (!show_event(sample, al.thread, &al, NULL))
>  		goto out_put;
>  
>  	if (evswitch__discard(&scr->evswitch, evsel))
>  		goto out_put;
>  
> -	perf_sample__fprintf_start(scr, sample, al.thread, evsel,
> +	perf_sample__fprintf_start(scr, sample, al.thread,
>  				   PERF_RECORD_CALLCHAIN_DEFERRED, fp);
>  	fprintf(fp, "DEFERRED CALLCHAIN [cookie: %llx]",
>  		(unsigned long long)event->callchain_deferred.cookie);
> @@ -2770,8 +2767,8 @@ static int process_deferred_sample_event(const struct perf_tool *tool,
>  
>  		if (symbol_conf.use_callchain && sample->callchain) {
>  			cursor = get_tls_callchain_cursor();
> -			if (thread__resolve_callchain(al.thread, cursor, evsel,
> -						      sample, NULL, NULL,
> +			if (thread__resolve_callchain(al.thread, cursor, sample,
> +						      /*parent=*/NULL, /*root_al=*/NULL,
>  						      scripting_max_stack)) {
>  				pr_info("cannot resolve deferred callchains\n");
>  				cursor = NULL;
> @@ -2887,8 +2884,12 @@ static int print_event_with_time(const struct perf_tool *tool,
>  		thread = machine__findnew_thread(machine, pid, tid);
>  
>  	if (evsel) {
> -		perf_sample__fprintf_start(script, sample, thread, evsel,
> +		struct evsel *saved_evsel = sample->evsel;
> +
> +		sample->evsel = evsel;
> +		perf_sample__fprintf_start(script, sample, thread,
>  					   event->header.type, stdout);
> +		sample->evsel = saved_evsel;
>  	}
>  
>  	perf_event__fprintf(event, machine, stdout);
> diff --git a/tools/perf/builtin-timechart.c b/tools/perf/builtin-timechart.c
> index f8b49d69e9a5..fc182950c463 100644
> --- a/tools/perf/builtin-timechart.c
> +++ b/tools/perf/builtin-timechart.c
> @@ -567,16 +567,15 @@ static const char *cat_backtrace(union perf_event *event,
>  }
>  
>  typedef int (*tracepoint_handler)(struct timechart *tchart,
> -				  struct evsel *evsel,
>  				  struct perf_sample *sample,
>  				  const char *backtrace);
>  
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct timechart *tchart = container_of(tool, struct timechart, tool);
>  
>  	if (evsel->core.attr.sample_type & PERF_SAMPLE_TIME) {
> @@ -588,8 +587,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  
>  	if (evsel->handler != NULL) {
>  		tracepoint_handler f = evsel->handler;
> -		return f(tchart, evsel, sample,
> -			 cat_backtrace(event, sample, machine));
> +		return f(tchart, sample, cat_backtrace(event, sample, machine));
>  	}
>  
>  	return 0;
> @@ -597,12 +595,11 @@ static int process_sample_event(const struct perf_tool *tool,
>  
>  static int
>  process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
> -			struct evsel *evsel,
>  			struct perf_sample *sample,
>  			const char *backtrace __maybe_unused)
>  {
> -	u32 state  = evsel__intval(evsel, sample, "state");
> -	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
> +	u32 state  = evsel__intval(sample, "state");
> +	u32 cpu_id = evsel__intval(sample, "cpu_id");
>  
>  	if (state == (u32)PWR_EVENT_EXIT)
>  		c_state_end(tchart, cpu_id, sample->time);
> @@ -613,12 +610,11 @@ process_sample_cpu_idle(struct timechart *tchart __maybe_unused,
>  
>  static int
>  process_sample_cpu_frequency(struct timechart *tchart,
> -			     struct evsel *evsel,
>  			     struct perf_sample *sample,
>  			     const char *backtrace __maybe_unused)
>  {
> -	u32 state  = evsel__intval(evsel, sample, "state");
> -	u32 cpu_id = evsel__intval(evsel, sample, "cpu_id");
> +	u32 state  = evsel__intval(sample, "state");
> +	u32 cpu_id = evsel__intval(sample, "cpu_id");
>  
>  	p_state_change(tchart, cpu_id, sample->time, state);
>  	return 0;
> @@ -626,13 +622,12 @@ process_sample_cpu_frequency(struct timechart *tchart,
>  
>  static int
>  process_sample_sched_wakeup(struct timechart *tchart,
> -			    struct evsel *evsel,
>  			    struct perf_sample *sample,
>  			    const char *backtrace)
>  {
> -	u8 flags  = evsel__intval(evsel, sample, "common_flags");
> -	int waker = evsel__intval(evsel, sample, "common_pid");
> -	int wakee = evsel__intval(evsel, sample, "pid");
> +	u8 flags  = evsel__intval(sample, "common_flags");
> +	int waker = evsel__intval(sample, "common_pid");
> +	int wakee = evsel__intval(sample, "pid");
>  
>  	sched_wakeup(tchart, sample->cpu, sample->time, waker, wakee, flags, backtrace);
>  	return 0;
> @@ -640,13 +635,12 @@ process_sample_sched_wakeup(struct timechart *tchart,
>  
>  static int
>  process_sample_sched_switch(struct timechart *tchart,
> -			    struct evsel *evsel,
>  			    struct perf_sample *sample,
>  			    const char *backtrace)
>  {
> -	int prev_pid   = evsel__intval(evsel, sample, "prev_pid");
> -	int next_pid   = evsel__intval(evsel, sample, "next_pid");
> -	u64 prev_state = evsel__intval(evsel, sample, "prev_state");
> +	int prev_pid   = evsel__intval(sample, "prev_pid");
> +	int next_pid   = evsel__intval(sample, "next_pid");
> +	u64 prev_state = evsel__intval(sample, "prev_state");
>  
>  	sched_switch(tchart, sample->cpu, sample->time, prev_pid, next_pid,
>  		     prev_state, backtrace);
> @@ -656,12 +650,11 @@ process_sample_sched_switch(struct timechart *tchart,
>  #ifdef SUPPORT_OLD_POWER_EVENTS
>  static int
>  process_sample_power_start(struct timechart *tchart __maybe_unused,
> -			   struct evsel *evsel,
>  			   struct perf_sample *sample,
>  			   const char *backtrace __maybe_unused)
>  {
> -	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
> -	u64 value  = evsel__intval(evsel, sample, "value");
> +	u64 cpu_id = evsel__intval(sample, "cpu_id");
> +	u64 value  = evsel__intval(sample, "value");
>  
>  	c_state_start(cpu_id, sample->time, value);
>  	return 0;
> @@ -669,7 +662,6 @@ process_sample_power_start(struct timechart *tchart __maybe_unused,
>  
>  static int
>  process_sample_power_end(struct timechart *tchart,
> -			 struct evsel *evsel __maybe_unused,
>  			 struct perf_sample *sample,
>  			 const char *backtrace __maybe_unused)
>  {
> @@ -679,12 +671,11 @@ process_sample_power_end(struct timechart *tchart,
>  
>  static int
>  process_sample_power_frequency(struct timechart *tchart,
> -			       struct evsel *evsel,
>  			       struct perf_sample *sample,
>  			       const char *backtrace __maybe_unused)
>  {
> -	u64 cpu_id = evsel__intval(evsel, sample, "cpu_id");
> -	u64 value  = evsel__intval(evsel, sample, "value");
> +	u64 cpu_id = evsel__intval(sample, "cpu_id");
> +	u64 value  = evsel__intval(sample, "value");
>  
>  	p_state_change(tchart, cpu_id, sample->time, value);
>  	return 0;
> @@ -849,120 +840,108 @@ static int pid_end_io_sample(struct timechart *tchart, int pid, int type,
>  
>  static int
>  process_enter_read(struct timechart *tchart,
> -		   struct evsel *evsel,
>  		   struct perf_sample *sample)
>  {
> -	long fd = evsel__intval(evsel, sample, "fd");
> +	long fd = evsel__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_READ,
>  				   sample->time, fd);
>  }
>  
>  static int
>  process_exit_read(struct timechart *tchart,
> -		  struct evsel *evsel,
>  		  struct perf_sample *sample)
>  {
> -	long ret = evsel__intval(evsel, sample, "ret");
> +	long ret = evsel__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_READ,
>  				 sample->time, ret);
>  }
>  
>  static int
>  process_enter_write(struct timechart *tchart,
> -		    struct evsel *evsel,
>  		    struct perf_sample *sample)
>  {
> -	long fd = evsel__intval(evsel, sample, "fd");
> +	long fd = evsel__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_WRITE,
>  				   sample->time, fd);
>  }
>  
>  static int
>  process_exit_write(struct timechart *tchart,
> -		   struct evsel *evsel,
>  		   struct perf_sample *sample)
>  {
> -	long ret = evsel__intval(evsel, sample, "ret");
> +	long ret = evsel__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_WRITE,
>  				 sample->time, ret);
>  }
>  
>  static int
>  process_enter_sync(struct timechart *tchart,
> -		   struct evsel *evsel,
>  		   struct perf_sample *sample)
>  {
> -	long fd = evsel__intval(evsel, sample, "fd");
> +	long fd = evsel__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_SYNC,
>  				   sample->time, fd);
>  }
>  
>  static int
>  process_exit_sync(struct timechart *tchart,
> -		  struct evsel *evsel,
>  		  struct perf_sample *sample)
>  {
> -	long ret = evsel__intval(evsel, sample, "ret");
> +	long ret = evsel__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_SYNC,
>  				 sample->time, ret);
>  }
>  
>  static int
>  process_enter_tx(struct timechart *tchart,
> -		 struct evsel *evsel,
>  		 struct perf_sample *sample)
>  {
> -	long fd = evsel__intval(evsel, sample, "fd");
> +	long fd = evsel__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_TX,
>  				   sample->time, fd);
>  }
>  
>  static int
>  process_exit_tx(struct timechart *tchart,
> -		struct evsel *evsel,
>  		struct perf_sample *sample)
>  {
> -	long ret = evsel__intval(evsel, sample, "ret");
> +	long ret = evsel__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_TX,
>  				 sample->time, ret);
>  }
>  
>  static int
>  process_enter_rx(struct timechart *tchart,
> -		 struct evsel *evsel,
>  		 struct perf_sample *sample)
>  {
> -	long fd = evsel__intval(evsel, sample, "fd");
> +	long fd = evsel__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_RX,
>  				   sample->time, fd);
>  }
>  
>  static int
>  process_exit_rx(struct timechart *tchart,
> -		struct evsel *evsel,
>  		struct perf_sample *sample)
>  {
> -	long ret = evsel__intval(evsel, sample, "ret");
> +	long ret = evsel__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_RX,
>  				 sample->time, ret);
>  }
>  
>  static int
>  process_enter_poll(struct timechart *tchart,
> -		   struct evsel *evsel,
>  		   struct perf_sample *sample)
>  {
> -	long fd = evsel__intval(evsel, sample, "fd");
> +	long fd = evsel__intval(sample, "fd");
>  	return pid_begin_io_sample(tchart, sample->tid, IOTYPE_POLL,
>  				   sample->time, fd);
>  }
>  
>  static int
>  process_exit_poll(struct timechart *tchart,
> -		  struct evsel *evsel,
>  		  struct perf_sample *sample)
>  {
> -	long ret = evsel__intval(evsel, sample, "ret");
> +	long ret = evsel__intval(sample, "ret");
>  	return pid_end_io_sample(tchart, sample->tid, IOTYPE_POLL,
>  				 sample->time, ret);
>  }
> diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
> index 710604c4f6f6..55526b4022ba 100644
> --- a/tools/perf/builtin-top.c
> +++ b/tools/perf/builtin-top.c
> @@ -198,7 +198,7 @@ static void ui__warn_map_erange(struct map *map, struct symbol *sym, u64 ip)
>  static void perf_top__record_precise_ip(struct perf_top *top,
>  					struct hist_entry *he,
>  					struct perf_sample *sample,
> -					struct evsel *evsel, u64 ip)
> +					u64 ip)
>  	EXCLUSIVE_LOCKS_REQUIRED(he->hists->lock)
>  {
>  	struct annotation *notes;
> @@ -215,7 +215,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
>  	if (!annotation__trylock(notes))
>  		return;
>  
> -	err = hist_entry__inc_addr_samples(he, sample, evsel, ip);
> +	err = hist_entry__inc_addr_samples(he, sample, ip);
>  
>  	annotation__unlock(notes);
>  
> @@ -731,14 +731,13 @@ static int hist_iter__top_callback(struct hist_entry_iter *iter,
>  	EXCLUSIVE_LOCKS_REQUIRED(iter->he->hists->lock)
>  {
>  	struct perf_top *top = arg;
> -	struct evsel *evsel = iter->evsel;
>  
>  	if (perf_hpp_list.sym && single)
> -		perf_top__record_precise_ip(top, iter->he, iter->sample, evsel, al->addr);
> +		perf_top__record_precise_ip(top, iter->he, iter->sample, al->addr);
>  
>  	hist__account_cycles(iter->sample->branch_stack, al, iter->sample,
>  			     !(top->record_opts.branch_stack & PERF_SAMPLE_BRANCH_ANY),
> -			     NULL, evsel);
> +			     /*total_cycles=*/NULL);
>  	return 0;
>  }
>  
> @@ -832,7 +831,6 @@ static void perf_event__process_sample(const struct perf_tool *tool,
>  	if (al.sym == NULL || !al.sym->idle) {
>  		struct hists *hists = evsel__hists(evsel);
>  		struct hist_entry_iter iter = {
> -			.evsel		= evsel,
>  			.sample 	= sample,
>  			.add_entry_cb 	= hist_iter__top_callback,
>  		};
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 8df5ca44e4f9..df2ed601eda2 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -536,12 +536,12 @@ static struct evsel *perf_evsel__raw_syscall_newtp(const char *direction, void *
>  	return NULL;
>  }
>  
> -#define perf_evsel__sc_tp_uint(evsel, name, sample) \
> -	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
> +#define perf_evsel__sc_tp_uint(name, sample) \
> +	({ struct syscall_tp *fields = __evsel__syscall_tp(sample->evsel); \
>  	   fields->name.integer(&fields->name, sample); })
>  
> -#define perf_evsel__sc_tp_ptr(evsel, name, sample) \
> -	({ struct syscall_tp *fields = __evsel__syscall_tp(evsel); \
> +#define perf_evsel__sc_tp_ptr(name, sample) \
> +	({ struct syscall_tp *fields = __evsel__syscall_tp(sample->evsel); \
>  	   fields->name.pointer(&fields->name, sample); })
>  
>  size_t strarray__scnprintf_suffix(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_suffix, int val)
> @@ -2579,7 +2579,7 @@ static struct syscall *trace__find_syscall(struct trace *trace, int e_machine, i
>  	return sc;
>  }
>  
> -typedef int (*tracepoint_handler)(struct trace *trace, struct evsel *evsel,
> +typedef int (*tracepoint_handler)(struct trace *trace,
>  				  union perf_event *event,
>  				  struct perf_sample *sample);
>  
> @@ -2718,8 +2718,8 @@ static int trace__printf_interrupted_entry(struct trace *trace)
>  	return printed;
>  }
>  
> -static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
> -				 struct perf_sample *sample, struct thread *thread)
> +static int trace__fprintf_sample(struct trace *trace, struct perf_sample *sample,
> +				 struct thread *thread)
>  {
>  	int printed = 0;
>  
> @@ -2727,7 +2727,7 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
>  		double ts = (double)sample->time / NSEC_PER_MSEC;
>  
>  		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
> -				   evsel__name(evsel), ts,
> +				   evsel__name(sample->evsel), ts,
>  				   thread__comm_str(thread),
>  				   sample->pid, sample->tid, sample->cpu);
>  	}
> @@ -2774,7 +2774,7 @@ static void *syscall__augmented_args(struct syscall *sc, struct perf_sample *sam
>  	return NULL;
>  }
>  
> -static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
> +static int trace__sys_enter(struct trace *trace,
>  			    union perf_event *event __maybe_unused,
>  			    struct perf_sample *sample)
>  {
> @@ -2782,7 +2782,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  	void *args;
>  	int printed = 0;
>  	struct thread *thread;
> -	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
> +	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
>  	int augmented_args_size = 0, e_machine;
>  	void *augmented_args = NULL;
>  	struct syscall *sc;
> @@ -2790,16 +2790,16 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  
>  	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
>  	e_machine = thread__e_machine(thread, trace->host);
> -	sc = trace__syscall_info(trace, evsel, e_machine, id);
> +	sc = trace__syscall_info(trace, sample->evsel, e_machine, id);
>  	if (sc == NULL)
>  		goto out_put;
>  	ttrace = thread__trace(thread, trace);
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> -	trace__fprintf_sample(trace, evsel, sample, thread);
> +	trace__fprintf_sample(trace, sample, thread);
>  
> -	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
> +	args = perf_evsel__sc_tp_ptr(args, sample);
>  
>  	if (ttrace->entry_str == NULL) {
>  		ttrace->entry_str = malloc(trace__entry_str_size);
> @@ -2819,7 +2819,7 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  	 * thinking that the extra 2 u64 args are the augmented filename, so just check
>  	 * here and avoid using augmented syscalls when the evsel is the raw_syscalls one.
>  	 */
> -	if (evsel != trace->syscalls.events.sys_enter)
> +	if (sample->evsel != trace->syscalls.events.sys_enter)
>  		augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
>  	ttrace->entry_time = sample->time;
>  	msg = ttrace->entry_str;
> @@ -2854,12 +2854,11 @@ static int trace__sys_enter(struct trace *trace, struct evsel *evsel,
>  	return err;
>  }
>  
> -static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
> -				    struct perf_sample *sample)
> +static int trace__fprintf_sys_enter(struct trace *trace, struct perf_sample *sample)
>  {
>  	struct thread_trace *ttrace;
>  	struct thread *thread;
> -	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1;
> +	int id = perf_evsel__sc_tp_uint(id, sample), err = -1;
>  	struct syscall *sc;
>  	char msg[1024];
>  	void *args, *augmented_args = NULL;
> @@ -2869,7 +2868,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
>  
>  	thread = machine__findnew_thread(trace->host, sample->pid, sample->tid);
>  	e_machine = thread__e_machine(thread, trace->host);
> -	sc = trace__syscall_info(trace, evsel, e_machine, id);
> +	sc = trace__syscall_info(trace, sample->evsel, e_machine, id);
>  	if (sc == NULL)
>  		goto out_put;
>  	ttrace = thread__trace(thread, trace);
> @@ -2880,7 +2879,7 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> -	args = perf_evsel__sc_tp_ptr(evsel, args, sample);
> +	args = perf_evsel__sc_tp_ptr(args, sample);
>  	augmented_args = syscall__augmented_args(sc, sample, &augmented_args_size, trace->raw_augmented_syscalls_args_size);
>  	printed += syscall__scnprintf_args(sc, msg, sizeof(msg), args, augmented_args, augmented_args_size, trace, thread);
>  	fprintf(trace->output, "%.*s", (int)printed, msg);
> @@ -2890,10 +2889,11 @@ static int trace__fprintf_sys_enter(struct trace *trace, struct evsel *evsel,
>  	return err;
>  }
>  
> -static int trace__resolve_callchain(struct trace *trace, struct evsel *evsel,
> +static int trace__resolve_callchain(struct trace *trace,
>  				    struct perf_sample *sample,
>  				    struct callchain_cursor *cursor)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct addr_location al;
>  	int max_stack = evsel->core.attr.sample_max_stack ?
>  			evsel->core.attr.sample_max_stack :
> @@ -2904,7 +2904,9 @@ static int trace__resolve_callchain(struct trace *trace, struct evsel *evsel,
>  	if (machine__resolve(trace->host, &al, sample) < 0)
>  		goto out;
>  
> -	err = thread__resolve_callchain(al.thread, cursor, evsel, sample, NULL, NULL, max_stack);
> +	err = thread__resolve_callchain(al.thread, cursor, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					max_stack);
>  out:
>  	addr_location__exit(&al);
>  	return err;
> @@ -2920,7 +2922,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
>  	return sample__fprintf_callchain(sample, 38, print_opts, get_tls_callchain_cursor(), symbol_conf.bt_stop_list, trace->output);
>  }
>  
> -static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
> +static int trace__sys_exit(struct trace *trace,
>  			   union perf_event *event __maybe_unused,
>  			   struct perf_sample *sample)
>  {
> @@ -2928,7 +2930,8 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  	u64 duration = 0;
>  	bool duration_calculated = false;
>  	struct thread *thread;
> -	int id = perf_evsel__sc_tp_uint(evsel, id, sample), err = -1, callchain_ret = 0, printed = 0;
> +	struct evsel *evsel = sample->evsel;
> +	int id = perf_evsel__sc_tp_uint(id, sample), err = -1, callchain_ret = 0, printed = 0;
>  	int alignment = trace->args_alignment, e_machine;
>  	struct syscall *sc;
>  	struct thread_trace *ttrace;
> @@ -2942,9 +2945,9 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  	if (ttrace == NULL)
>  		goto out_put;
>  
> -	trace__fprintf_sample(trace, evsel, sample, thread);
> +	trace__fprintf_sample(trace, sample, thread);
>  
> -	ret = perf_evsel__sc_tp_uint(evsel, ret, sample);
> +	ret = perf_evsel__sc_tp_uint(ret, sample);
>  
>  	if (trace->summary)
>  		thread__update_stats(thread, ttrace, id, sample, ret, trace);
> @@ -2966,7 +2969,7 @@ static int trace__sys_exit(struct trace *trace, struct evsel *evsel,
>  	if (sample->callchain) {
>  		struct callchain_cursor *cursor = get_tls_callchain_cursor();
>  
> -		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
> +		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
>  		if (callchain_ret == 0) {
>  			if (cursor->nr < trace->min_stack)
>  				goto out;
> @@ -3058,7 +3061,7 @@ errno_print: {
>  	return err;
>  }
>  
> -static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
> +static int trace__vfs_getname(struct trace *trace,
>  			      union perf_event *event __maybe_unused,
>  			      struct perf_sample *sample)
>  {
> @@ -3067,7 +3070,7 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
>  	size_t filename_len, entry_str_len, to_move;
>  	ssize_t remaining_space;
>  	char *pos;
> -	const char *filename = evsel__rawptr(evsel, sample, "pathname");
> +	const char *filename = evsel__rawptr(sample, "pathname");
>  
>  	if (!thread)
>  		goto out;
> @@ -3119,11 +3122,11 @@ static int trace__vfs_getname(struct trace *trace, struct evsel *evsel,
>  	return 0;
>  }
>  
> -static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
> +static int trace__sched_stat_runtime(struct trace *trace,
>  				     union perf_event *event __maybe_unused,
>  				     struct perf_sample *sample)
>  {
> -        u64 runtime = evsel__intval(evsel, sample, "runtime");
> +	u64 runtime = evsel__intval(sample, "runtime");
>  	double runtime_ms = (double)runtime / NSEC_PER_MSEC;
>  	struct thread *thread = machine__findnew_thread(trace->host,
>  							sample->pid,
> @@ -3141,11 +3144,11 @@ static int trace__sched_stat_runtime(struct trace *trace, struct evsel *evsel,
>  
>  out_dump:
>  	fprintf(trace->output, "%s: comm=%s,pid=%u,runtime=%" PRIu64 ",vruntime=%" PRIu64 ")\n",
> -	       evsel->name,
> -	       evsel__strval(evsel, sample, "comm"),
> -	       (pid_t)evsel__intval(evsel, sample, "pid"),
> +		evsel__name(sample->evsel),
> +		evsel__strval(sample, "comm"),
> +	       (pid_t)evsel__intval(sample, "pid"),
>  	       runtime,
> -	       evsel__intval(evsel, sample, "vruntime"));
> +	       evsel__intval(sample, "vruntime"));
>  	goto out_put;
>  }
>  
> @@ -3251,10 +3254,11 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>  	return fprintf(trace->output, "%.*s", (int)printed, bf);
>  }
>  
> -static int trace__event_handler(struct trace *trace, struct evsel *evsel,
> +static int trace__event_handler(struct trace *trace,
>  				union perf_event *event __maybe_unused,
>  				struct perf_sample *sample)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct thread *thread;
>  	int callchain_ret = 0;
>  
> @@ -3266,7 +3270,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
>  	if (sample->callchain) {
>  		struct callchain_cursor *cursor = get_tls_callchain_cursor();
>  
> -		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
> +		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
>  		if (callchain_ret == 0) {
>  			if (cursor->nr < trace->min_stack)
>  				goto out;
> @@ -3284,13 +3288,13 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
>  		trace__fprintf_comm_tid(trace, thread, trace->output);
>  
>  	if (evsel == trace->syscalls.events.bpf_output) {
> -		int id = perf_evsel__sc_tp_uint(evsel, id, sample);
> +		int id = perf_evsel__sc_tp_uint(id, sample);
>  		int e_machine = thread ? thread__e_machine(thread, trace->host) : EM_HOST;
>  		struct syscall *sc = trace__syscall_info(trace, evsel, e_machine, id);
>  
>  		if (sc) {
>  			fprintf(trace->output, "%s(", sc->name);
> -			trace__fprintf_sys_enter(trace, evsel, sample);
> +			trace__fprintf_sys_enter(trace, sample);
>  			fputc(')', trace->output);
>  			goto newline;
>  		}
> @@ -3310,7 +3314,7 @@ static int trace__event_handler(struct trace *trace, struct evsel *evsel,
>  		const struct tep_event *tp_format = evsel__tp_format(evsel);
>  
>  		if (tp_format && (strncmp(tp_format->name, "sys_enter_", 10) ||
> -				  trace__fprintf_sys_enter(trace, evsel, sample))) {
> +				  trace__fprintf_sys_enter(trace, sample))) {
>  			if (trace->libtraceevent_print) {
>  				event_format__fprintf(tp_format, sample->cpu,
>  						      sample->raw_data, sample->raw_size,
> @@ -3375,7 +3379,7 @@ static int trace__pgfault(struct trace *trace,
>  	if (sample->callchain) {
>  		struct callchain_cursor *cursor = get_tls_callchain_cursor();
>  
> -		callchain_ret = trace__resolve_callchain(trace, evsel, sample, cursor);
> +		callchain_ret = trace__resolve_callchain(trace, sample, cursor);
>  		if (callchain_ret == 0) {
>  			if (cursor->nr < trace->min_stack)
>  				goto out_put;
> @@ -3440,7 +3444,6 @@ static int trace__pgfault(struct trace *trace,
>  }
>  
>  static void trace__set_base_time(struct trace *trace,
> -				 struct evsel *evsel,
>  				 struct perf_sample *sample)
>  {
>  	/*
> @@ -3452,17 +3455,17 @@ static void trace__set_base_time(struct trace *trace,
>  	 * appears in our event stream (vfs_getname comes to mind).
>  	 */
>  	if (trace->base_time == 0 && !trace->full_time &&
> -	    (evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
> +	    (sample->evsel->core.attr.sample_type & PERF_SAMPLE_TIME))
>  		trace->base_time = sample->time;
>  }
>  
>  static int trace__process_sample(const struct perf_tool *tool,
>  				 union perf_event *event,
>  				 struct perf_sample *sample,
> -				 struct evsel *evsel,
>  				 struct machine *machine __maybe_unused)
>  {
>  	struct trace *trace = container_of(tool, struct trace, tool);
> +	struct evsel *evsel = sample->evsel;
>  	struct thread *thread;
>  	int err = 0;
>  
> @@ -3472,11 +3475,11 @@ static int trace__process_sample(const struct perf_tool *tool,
>  	if (thread && thread__is_filtered(thread))
>  		goto out;
>  
> -	trace__set_base_time(trace, evsel, sample);
> +	trace__set_base_time(trace, sample);
>  
>  	if (handler) {
>  		++trace->nr_events;
> -		handler(trace, evsel, event, sample);
> +		handler(trace, event, sample);
>  	}
>  out:
>  	thread__put(thread);
> @@ -3634,7 +3637,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
>  	if (evswitch__discard(&trace->evswitch, evsel))
>  		return;
>  
> -	trace__set_base_time(trace, evsel, sample);
> +	trace__set_base_time(trace, sample);
>  
>  	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
>  	    sample->raw_data == NULL) {
> @@ -3643,7 +3646,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
>  		       sample->cpu, sample->raw_size);
>  	} else {
>  		tracepoint_handler handler = evsel->handler;
> -		handler(trace, evsel, event, sample);
> +		handler(trace, event, sample);
>  	}
>  
>  	if (trace->nr_events_printed >= trace->max_events && trace->max_events != ULONG_MAX)
> diff --git a/tools/perf/tests/hists_cumulate.c b/tools/perf/tests/hists_cumulate.c
> index 3eb9ef8d7ec6..267cbc24691a 100644
> --- a/tools/perf/tests/hists_cumulate.c
> +++ b/tools/perf/tests/hists_cumulate.c
> @@ -81,13 +81,12 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
>  {
>  	struct addr_location al;
>  	struct evsel *evsel = hists_to_evsel(hists);
> -	struct perf_sample sample = { .period = 1000, };
> +	struct perf_sample sample = { .evsel = evsel, .period = 1000, };
>  	size_t i;
>  
>  	addr_location__init(&al);
>  	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
>  		struct hist_entry_iter iter = {
> -			.evsel = evsel,
>  			.sample	= &sample,
>  			.hide_unresolved = false,
>  		};
> diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
> index 1cebd20cc91c..002e3a4c1ca5 100644
> --- a/tools/perf/tests/hists_filter.c
> +++ b/tools/perf/tests/hists_filter.c
> @@ -63,13 +63,13 @@ static int add_hist_entries(struct evlist *evlist,
>  	evlist__for_each_entry(evlist, evsel) {
>  		for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
>  			struct hist_entry_iter iter = {
> -				.evsel = evsel,
>  				.sample = &sample,
>  				.ops = &hist_iter_normal,
>  				.hide_unresolved = false,
>  			};
>  			struct hists *hists = evsel__hists(evsel);
>  
> +			sample.evsel = evsel;
>  			/* make sure it has no filter at first */
>  			hists->thread_filter = NULL;
>  			hists->dso_filter = NULL;
> diff --git a/tools/perf/tests/hists_output.c b/tools/perf/tests/hists_output.c
> index ee5ec8bda60e..fa683fd7b1e5 100644
> --- a/tools/perf/tests/hists_output.c
> +++ b/tools/perf/tests/hists_output.c
> @@ -51,13 +51,12 @@ static int add_hist_entries(struct hists *hists, struct machine *machine)
>  {
>  	struct addr_location al;
>  	struct evsel *evsel = hists_to_evsel(hists);
> -	struct perf_sample sample = { .period = 100, };
> +	struct perf_sample sample = { .evsel = evsel, .period = 100, };
>  	size_t i;
>  
>  	addr_location__init(&al);
>  	for (i = 0; i < ARRAY_SIZE(fake_samples); i++) {
>  		struct hist_entry_iter iter = {
> -			.evsel = evsel,
>  			.sample = &sample,
>  			.ops = &hist_iter_normal,
>  			.hide_unresolved = false,
> diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
> index 2a139d2781a8..65f42b81ae19 100644
> --- a/tools/perf/tests/openat-syscall-tp-fields.c
> +++ b/tools/perf/tests/openat-syscall-tp-fields.c
> @@ -118,7 +118,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
>  					goto out_delete_evlist;
>  				}
>  
> -				tp_flags = evsel__intval(evsel, &sample, "flags");
> +				tp_flags = evsel__intval(&sample, "flags");
>  				perf_sample__exit(&sample);
>  				if (flags != tp_flags) {
>  					pr_debug("%s: Expected flags=%#x, got %#x\n",
> diff --git a/tools/perf/tests/switch-tracking.c b/tools/perf/tests/switch-tracking.c
> index 15791fcb76b2..d20ee8bc33e8 100644
> --- a/tools/perf/tests/switch-tracking.c
> +++ b/tools/perf/tests/switch-tracking.c
> @@ -140,8 +140,8 @@ static int process_sample_event(struct evlist *evlist,
>  
>  	evsel = evlist__id2evsel(evlist, sample.id);
>  	if (evsel == switch_tracking->switch_evsel) {
> -		next_tid = evsel__intval(evsel, &sample, "next_pid");
> -		prev_tid = evsel__intval(evsel, &sample, "prev_pid");
> +		next_tid = evsel__intval(&sample, "next_pid");
> +		prev_tid = evsel__intval(&sample, "prev_pid");
>  		cpu = sample.cpu;
>  		pr_debug3("sched_switch: cpu: %d prev_tid %d next_tid %d\n",
>  			  cpu, prev_tid, next_tid);
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index c16c6dfaa959..b93bd6eb4fb4 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -316,9 +316,10 @@ struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists)
>  }
>  
>  static int symbol__inc_addr_samples(struct map_symbol *ms,
> -				    struct evsel *evsel, u64 addr,
> +				    u64 addr,
>  				    struct perf_sample *sample)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct symbol *sym = ms->sym;
>  	struct annotated_source *src;
>  
> @@ -579,16 +580,14 @@ static int annotation__compute_ipc(struct annotation *notes, size_t size,
>  	return 0;
>  }
>  
> -int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
> -				 struct evsel *evsel)
> +int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample)
>  {
> -	return symbol__inc_addr_samples(&ams->ms, evsel, ams->al_addr, sample);
> +	return symbol__inc_addr_samples(&ams->ms, ams->al_addr, sample);
>  }
>  
> -int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
> -				 struct evsel *evsel, u64 ip)
> +int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample, u64 ip)
>  {
> -	return symbol__inc_addr_samples(&he->ms, evsel, ip, sample);
> +	return symbol__inc_addr_samples(&he->ms, ip, sample);
>  }
>  
>  
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 696e36dbf013..1aa6df7d1618 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -422,8 +422,7 @@ static inline struct annotation *symbol__annotation(struct symbol *sym)
>  	return (void *)sym - symbol_conf.priv_size;
>  }
>  
> -int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample,
> -				 struct evsel *evsel);
> +int addr_map_symbol__inc_samples(struct addr_map_symbol *ams, struct perf_sample *sample);
>  
>  struct annotated_branch *annotation__get_branch(struct annotation *notes);
>  
> @@ -433,8 +432,7 @@ int addr_map_symbol__account_cycles(struct addr_map_symbol *ams,
>  				    struct evsel *evsel,
>  				    u64 br_cntr);
>  
> -int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample,
> -				 struct evsel *evsel, u64 addr);
> +int hist_entry__inc_addr_samples(struct hist_entry *he, struct perf_sample *sample, u64 addr);
>  
>  struct annotated_source *symbol__hists(struct symbol *sym, int nr_hists);
>  void symbol__annotate_zero_histograms(struct symbol *sym);
> diff --git a/tools/perf/util/build-id.c b/tools/perf/util/build-id.c
> index fdb35133fde4..af4d874f1381 100644
> --- a/tools/perf/util/build-id.c
> +++ b/tools/perf/util/build-id.c
> @@ -55,7 +55,6 @@ static int mark_dso_hit_callback(struct callchain_cursor_node *node, void *data
>  int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
>  			   union perf_event *event,
>  			   struct perf_sample *sample,
> -			   struct evsel *evsel,
>  			   struct machine *machine)
>  {
>  	struct addr_location al;
> @@ -74,7 +73,7 @@ int build_id__mark_dso_hit(const struct perf_tool *tool __maybe_unused,
>  
>  	addr_location__exit(&al);
>  
> -	sample__for_each_callchain_node(thread, evsel, sample, PERF_MAX_STACK_DEPTH,
> +	sample__for_each_callchain_node(thread, sample, PERF_MAX_STACK_DEPTH,
>  					/*symbols=*/false, mark_dso_hit_callback, /*data=*/NULL);
>  
>  
> diff --git a/tools/perf/util/build-id.h b/tools/perf/util/build-id.h
> index 47e621cebe1b..41c16cc8e79b 100644
> --- a/tools/perf/util/build-id.h
> +++ b/tools/perf/util/build-id.h
> @@ -34,11 +34,10 @@ char *__dso__build_id_filename(const struct dso *dso, char *bf, size_t size,
>  			       bool is_debug, bool is_kallsyms);
>  
>  int build_id__mark_dso_hit(const struct perf_tool *tool, union perf_event *event,
> -			   struct perf_sample *sample, struct evsel *evsel,
> -			   struct machine *machine);
> +			   struct perf_sample *sample, struct machine *machine);
>  
>  int perf_event__inject_buildid(const struct perf_tool *tool, union perf_event *event,
> -			       struct perf_sample *sample, struct evsel *evsel,
> +			       struct perf_sample *sample,
>  			       struct machine *machine);
>  
>  bool perf_session__read_build_ids(struct perf_session *session, bool with_hits);
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 515bb8b5da01..f4275a08bd75 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1123,7 +1123,7 @@ int callchain_cursor_append(struct callchain_cursor *cursor,
>  
>  int sample__resolve_callchain(struct perf_sample *sample,
>  			      struct callchain_cursor *cursor, struct symbol **parent,
> -			      struct evsel *evsel, struct addr_location *al,
> +			      struct addr_location *al,
>  			      int max_stack)
>  {
>  	if (sample->callchain == NULL && !symbol_conf.show_branchflag_count)
> @@ -1131,7 +1131,7 @@ int sample__resolve_callchain(struct perf_sample *sample,
>  
>  	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain ||
>  	    perf_hpp_list.parent || symbol_conf.show_branchflag_count) {
> -		return thread__resolve_callchain(al->thread, cursor, evsel, sample,
> +		return thread__resolve_callchain(al->thread, cursor, sample,
>  						 parent, al, max_stack);
>  	}
>  	return 0;
> @@ -1806,7 +1806,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode)
>  	return cycles;
>  }
>  
> -int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
> +int sample__for_each_callchain_node(struct thread *thread,
>  				    struct perf_sample *sample, int max_stack,
>  				    bool symbols, callchain_iter_fn cb, void *data)
>  {
> @@ -1817,7 +1817,7 @@ int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
>  		return -ENOMEM;
>  
>  	/* Fill in the callchain. */
> -	ret = __thread__resolve_callchain(thread, cursor, evsel, sample,
> +	ret = __thread__resolve_callchain(thread, cursor, sample,
>  					  /*parent=*/NULL, /*root_al=*/NULL,
>  					  max_stack, symbols);
>  	if (ret)
> diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
> index 2a52af8c80ac..dd67dce168fe 100644
> --- a/tools/perf/util/callchain.h
> +++ b/tools/perf/util/callchain.h
> @@ -251,7 +251,7 @@ int record_opts__parse_callchain(struct record_opts *record,
>  
>  int sample__resolve_callchain(struct perf_sample *sample,
>  			      struct callchain_cursor *cursor, struct symbol **parent,
> -			      struct evsel *evsel, struct addr_location *al,
> +			      struct addr_location *al,
>  			      int max_stack);
>  int hist_entry__append_callchain(struct hist_entry *he, struct perf_sample *sample);
>  int fill_callchain_info(struct addr_location *al, struct callchain_cursor_node *node,
> @@ -314,7 +314,7 @@ s64 callchain_avg_cycles(struct callchain_node *cnode);
>  
>  typedef int (*callchain_iter_fn)(struct callchain_cursor_node *node, void *data);
>  
> -int sample__for_each_callchain_node(struct thread *thread, struct evsel *evsel,
> +int sample__for_each_callchain_node(struct thread *thread,
>  				    struct perf_sample *sample, int max_stack,
>  				    bool symbols, callchain_iter_fn cb, void *data);
>  
> diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
> index a22e9049ff30..c4b12b33d060 100644
> --- a/tools/perf/util/data-convert-bt.c
> +++ b/tools/perf/util/data-convert-bt.c
> @@ -802,10 +802,10 @@ static bool is_flush_needed(struct ctf_stream *cs)
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *_event,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine __maybe_unused)
>  {
>  	struct convert *c = container_of(tool, struct convert, tool);
> +	struct evsel *evsel = sample->evsel;
>  	struct evsel_priv *priv = evsel->priv;
>  	struct ctf_writer *cw = &c->writer;
>  	struct ctf_stream *cs;
> diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
> index eefa3a94c813..f42de990a709 100644
> --- a/tools/perf/util/data-convert-json.c
> +++ b/tools/perf/util/data-convert-json.c
> @@ -155,13 +155,12 @@ static void output_sample_callchain_entry(const struct perf_tool *tool,
>  static int process_sample_event(const struct perf_tool *tool,
>  				union perf_event *event __maybe_unused,
>  				struct perf_sample *sample,
> -				struct evsel *evsel __maybe_unused,
>  				struct machine *machine)
>  {
>  	struct convert_json *c = container_of(tool, struct convert_json, tool);
>  	FILE *out = c->out;
>  	struct addr_location al;
> -	u64 sample_type = __evlist__combined_sample_type(evsel->evlist);
> +	u64 sample_type = __evlist__combined_sample_type(sample->evsel->evlist);
>  	u8 cpumode = PERF_RECORD_MISC_USER;
>  
>  	addr_location__init(&al);
> @@ -241,7 +240,7 @@ static int process_sample_event(const struct perf_tool *tool,
>  
>  #ifdef HAVE_LIBTRACEEVENT
>  	if (sample->raw_data) {
> -		struct tep_event *tp_format = evsel__tp_format(evsel);
> +		struct tep_event *tp_format = evsel__tp_format(sample->evsel);
>  		struct tep_format_field **fields = tp_format ? tep_event_fields(tp_format) : NULL;
>  
>  		if (fields) {
> diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
> index ae9a9065aab7..4f4f1772feb1 100644
> --- a/tools/perf/util/db-export.c
> +++ b/tools/perf/util/db-export.c
> @@ -209,8 +209,7 @@ static int db_ids_from_al(struct db_export *dbe, struct addr_location *al,
>  static struct call_path *call_path_from_sample(struct db_export *dbe,
>  					       struct machine *machine,
>  					       struct thread *thread,
> -					       struct perf_sample *sample,
> -					       struct evsel *evsel)
> +					       struct perf_sample *sample)
>  {
>  	u64 kernel_start = machine__kernel_start(machine);
>  	struct call_path *current = &dbe->cpr->call_path;
> @@ -228,8 +227,9 @@ static struct call_path *call_path_from_sample(struct db_export *dbe,
>  	 */
>  	callchain_param.order = ORDER_CALLER;
>  	cursor = get_tls_callchain_cursor();
> -	err = thread__resolve_callchain(thread, cursor, evsel,
> -					sample, NULL, NULL, PERF_MAX_STACK_DEPTH);
> +	err = thread__resolve_callchain(thread, cursor, sample,
> +					/*parent=*/NULL, /*root_al=*/NULL,
> +					PERF_MAX_STACK_DEPTH);
>  	if (err) {
>  		callchain_param.order = saved_order;
>  		return NULL;
> @@ -346,14 +346,13 @@ static int db_export__threads(struct db_export *dbe, struct thread *thread,
>  }
>  
>  int db_export__sample(struct db_export *dbe, union perf_event *event,
> -		      struct perf_sample *sample, struct evsel *evsel,
> +		      struct perf_sample *sample,
>  		      struct addr_location *al, struct addr_location *addr_al)
>  {
>  	struct thread *thread = al->thread;
>  	struct export_sample es = {
>  		.event = event,
>  		.sample = sample,
> -		.evsel = evsel,
>  		.al = al,
>  	};
>  	struct thread *main_thread;
> @@ -366,7 +365,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>  	if (!machine)
>  		return -1;
>  
> -	err = db_export__evsel(dbe, evsel);
> +	err = db_export__evsel(dbe, sample->evsel);
>  	if (err)
>  		return err;
>  
> @@ -391,8 +390,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
>  
>  	if (dbe->cpr) {
>  		struct call_path *cp = call_path_from_sample(dbe, machine,
> -							     thread, sample,
> -							     evsel);
> +							     thread, sample);
>  		if (cp) {
>  			db_export__call_path(dbe, cp);
>  			es.call_path_id = cp->db_id;
> diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
> index 23983cb35706..1abbfd398e3a 100644
> --- a/tools/perf/util/db-export.h
> +++ b/tools/perf/util/db-export.h
> @@ -25,7 +25,6 @@ struct call_return;
>  struct export_sample {
>  	union perf_event	*event;
>  	struct perf_sample	*sample;
> -	struct evsel		*evsel;
>  	struct addr_location	*al;
>  	u64			db_id;
>  	u64			comm_db_id;
> @@ -96,7 +95,7 @@ int db_export__symbol(struct db_export *dbe, struct symbol *sym,
>  int db_export__branch_type(struct db_export *dbe, u32 branch_type,
>  			   const char *name);
>  int db_export__sample(struct db_export *dbe, union perf_event *event,
> -		      struct perf_sample *sample, struct evsel *evsel,
> +		      struct perf_sample *sample,
>  		      struct addr_location *al, struct addr_location *addr_al);
>  
>  int db_export__branch_types(struct db_export *dbe);
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 5ac1a05601b1..c9cc308fe29d 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -3218,6 +3218,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
>  	union u64_swap u;
>  
>  	memset(data, 0, sizeof(*data));
> +	data->evsel = evsel;
>  	data->cpu = data->pid = data->tid = -1;
>  	data->stream_id = data->id = data->time = -1ULL;
>  	data->period = evsel->core.attr.sample_period;
> @@ -3672,11 +3673,16 @@ struct tep_format_field *evsel__common_field(struct evsel *evsel, const char *na
>  	return tp_format ? tep_find_common_field(tp_format, name) : NULL;
>  }
>  
> -void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name)
> +void *evsel__rawptr(struct perf_sample *sample, const char *name)
>  {
> -	struct tep_format_field *field = evsel__field(evsel, name);
> +	struct evsel *evsel = sample->evsel;
> +	struct tep_format_field *field;
>  	int offset;
>  
> +	if (!evsel)
> +		return NULL;
> +
> +	field = evsel__field(evsel, name);
>  	if (!field)
>  		return NULL;
>  
> @@ -3731,31 +3737,44 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
>  	return 0;
>  }
>  
> -u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name)
> +u64 evsel__intval(struct perf_sample *sample, const char *name)
>  {
> -	struct tep_format_field *field = evsel__field(evsel, name);
> +	struct evsel *evsel = sample->evsel;
> +	struct tep_format_field *field;
> +
> +	if (!evsel)
> +		return 0;
>  
> +	field = evsel__field(evsel, name);
>  	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
>  }
>  
> -u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name)
> +u64 evsel__intval_common(struct perf_sample *sample, const char *name)
>  {
> -	struct tep_format_field *field = evsel__common_field(evsel, name);
> +	struct evsel *evsel = sample->evsel;
> +	struct tep_format_field *field;
> +
> +	if (!evsel)
> +		return 0;
>  
> +	field = evsel__common_field(evsel, name);
>  	return field ? format_field__intval(field, sample, evsel->needs_swap) : 0;
>  }
>  
> -char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name)
> +char evsel__taskstate(struct perf_sample *sample, const char *name)
>  {
>  	static struct tep_format_field *prev_state_field;
>  	static const char *states;
> +	struct evsel *evsel = sample->evsel;
>  	struct tep_format_field *field;
>  	unsigned long long val;
>  	unsigned int bit;
>  	char state = '?'; /* '?' denotes unknown task state */
>  
> -	field = evsel__field(evsel, name);
> +	if (!evsel)
> +		return state;
>  
> +	field = evsel__field(evsel, name);
>  	if (!field)
>  		return state;
>  
> @@ -3773,7 +3792,7 @@ char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const cha
>  	 *
>  	 * We can change this if we have a good reason in the future.
>  	 */
> -	val = evsel__intval(evsel, sample, name);
> +	val = evsel__intval(sample, name);
>  	bit = val ? ffs(val) : 0;
>  	state = (!bit || bit > strlen(states)) ? 'R' : states[bit-1];
>  	return state;
> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> index 95c4bd0f0f2e..a79c473ca610 100644
> --- a/tools/perf/util/evsel.h
> +++ b/tools/perf/util/evsel.h
> @@ -369,14 +369,14 @@ bool evsel__precise_ip_fallback(struct evsel *evsel);
>  struct perf_sample;
>  
>  #ifdef HAVE_LIBTRACEEVENT
> -void *evsel__rawptr(struct evsel *evsel, struct perf_sample *sample, const char *name);
> -u64 evsel__intval(struct evsel *evsel, struct perf_sample *sample, const char *name);
> -u64 evsel__intval_common(struct evsel *evsel, struct perf_sample *sample, const char *name);
> -char evsel__taskstate(struct evsel *evsel, struct perf_sample *sample, const char *name);
> +void *evsel__rawptr(struct perf_sample *sample, const char *name);
> +u64 evsel__intval(struct perf_sample *sample, const char *name);
> +u64 evsel__intval_common(struct perf_sample *sample, const char *name);
> +char evsel__taskstate(struct perf_sample *sample, const char *name);
>  
> -static inline char *evsel__strval(struct evsel *evsel, struct perf_sample *sample, const char *name)
> +static inline char *evsel__strval(struct perf_sample *sample, const char *name)
>  {
> -	return evsel__rawptr(evsel, sample, name);
> +	return evsel__rawptr(sample, name);
>  }
>  #endif
>  
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 7ffaa3d9851b..75dc3f3482d6 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -932,8 +932,9 @@ iter_add_single_mem_entry(struct hist_entry_iter *iter, struct addr_location *al
>  {
>  	u64 cost;
>  	struct mem_info *mi = iter->mi;
> -	struct hists *hists = evsel__hists(iter->evsel);
>  	struct perf_sample *sample = iter->sample;
> +	struct evsel *evsel = sample->evsel;
> +	struct hists *hists = evsel__hists(evsel);
>  	struct hist_entry *he;
>  
>  	if (mi == NULL)
> @@ -965,7 +966,7 @@ static int
>  iter_finish_mem_entry(struct hist_entry_iter *iter,
>  		      struct addr_location *al __maybe_unused)
>  {
> -	struct evsel *evsel = iter->evsel;
> +	struct evsel *evsel = iter->sample->evsel;
>  	struct hists *hists = evsel__hists(evsel);
>  	struct hist_entry *he = iter->he;
>  	int err = -EINVAL;
> @@ -1033,9 +1034,9 @@ static int
>  iter_add_next_branch_entry(struct hist_entry_iter *iter, struct addr_location *al)
>  {
>  	struct branch_info *bi;
> -	struct evsel *evsel = iter->evsel;
> -	struct hists *hists = evsel__hists(evsel);
>  	struct perf_sample *sample = iter->sample;
> +	struct evsel *evsel = sample->evsel;
> +	struct hists *hists = evsel__hists(evsel);
>  	struct hist_entry *he = NULL;
>  	int i = iter->curr;
>  	int err = 0;
> @@ -1075,7 +1076,7 @@ static int
>  iter_finish_branch_entry(struct hist_entry_iter *iter,
>  			 struct addr_location *al __maybe_unused)
>  {
> -	struct evsel *evsel = iter->evsel;
> +	struct evsel *evsel = iter->sample->evsel;
>  	struct hists *hists = evsel__hists(evsel);
>  
>  	for (int i = 0; i < iter->total; i++)
> @@ -1100,12 +1101,12 @@ iter_prepare_normal_entry(struct hist_entry_iter *iter __maybe_unused,
>  static int
>  iter_add_single_normal_entry(struct hist_entry_iter *iter, struct addr_location *al)
>  {
> -	struct evsel *evsel = iter->evsel;
>  	struct perf_sample *sample = iter->sample;
> +	struct evsel *evsel = sample->evsel;
>  	struct hist_entry *he;
>  
> -	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, NULL, NULL,
> -			      NULL, sample, true);
> +	he = hists__add_entry(evsel__hists(evsel), al, iter->parent, /*bi=*/NULL, /*mi=*/NULL,
> +			      /*ki=*/NULL, sample, true);
>  	if (he == NULL)
>  		return -ENOMEM;
>  
> @@ -1118,8 +1119,8 @@ iter_finish_normal_entry(struct hist_entry_iter *iter,
>  			 struct addr_location *al __maybe_unused)
>  {
>  	struct hist_entry *he = iter->he;
> -	struct evsel *evsel = iter->evsel;
>  	struct perf_sample *sample = iter->sample;
> +	struct evsel *evsel = sample->evsel;
>  
>  	if (he == NULL)
>  		return 0;
> @@ -1162,9 +1163,9 @@ static int
>  iter_add_single_cumulative_entry(struct hist_entry_iter *iter,
>  				 struct addr_location *al)
>  {
> -	struct evsel *evsel = iter->evsel;
> -	struct hists *hists = evsel__hists(evsel);
>  	struct perf_sample *sample = iter->sample;
> +	struct evsel *evsel = sample->evsel;
> +	struct hists *hists = evsel__hists(evsel);
>  	struct hist_entry **he_cache = iter->he_cache;
>  	struct hist_entry *he;
>  	int err = 0;
> @@ -1221,8 +1222,8 @@ static int
>  iter_add_next_cumulative_entry(struct hist_entry_iter *iter,
>  			       struct addr_location *al)
>  {
> -	struct evsel *evsel = iter->evsel;
>  	struct perf_sample *sample = iter->sample;
> +	struct evsel *evsel = sample->evsel;
>  	struct hist_entry **he_cache = iter->he_cache;
>  	struct hist_entry *he;
>  	struct hist_entry he_tmp = {
> @@ -1339,7 +1340,7 @@ int hist_entry_iter__add(struct hist_entry_iter *iter, struct addr_location *al,
>  		alm = map__get(al->map);
>  
>  	err = sample__resolve_callchain(iter->sample, get_tls_callchain_cursor(), &iter->parent,
> -					iter->evsel, al, max_stack_depth);
> +					al, max_stack_depth);
>  	if (err) {
>  		map__put(alm);
>  		return err;
> @@ -2823,7 +2824,7 @@ int hists__unlink(struct hists *hists)
>  
>  void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>  			  struct perf_sample *sample, bool nonany_branch_mode,
> -			  u64 *total_cycles, struct evsel *evsel)
> +			  u64 *total_cycles)
>  {
>  	struct branch_info *bi;
>  	struct branch_entry *entries = perf_sample__branch_entries(sample);
> @@ -2847,7 +2848,7 @@ void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>  			for (int i = bs->nr - 1; i >= 0; i--) {
>  				addr_map_symbol__account_cycles(&bi[i].from,
>  					nonany_branch_mode ? NULL : prev,
> -					bi[i].flags.cycles, evsel,
> +					bi[i].flags.cycles, sample->evsel,
>  					bi[i].branch_stack_cntr);
>  				prev = &bi[i].to;
>  
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 1d5ea632ca4e..ee92fffc53a9 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -155,7 +155,6 @@ struct hist_entry_iter {
>  	int total;
>  	int curr;
>  
> -	struct evsel *evsel;
>  	struct perf_sample *sample;
>  	struct hist_entry *he;
>  	struct symbol *parent;
> @@ -797,7 +796,7 @@ unsigned int hists__overhead_width(struct hists *hists);
>  
>  void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
>  			  struct perf_sample *sample, bool nonany_branch_mode,
> -			  u64 *total_cycles, struct evsel *evsel);
> +			  u64 *total_cycles);
>  
>  struct option;
>  int parse_filter_percentage(const struct option *opt, const char *arg, int unset);
> diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
> index fc9eec8b54b8..99ea98eccfb9 100644
> --- a/tools/perf/util/intel-pt.c
> +++ b/tools/perf/util/intel-pt.c
> @@ -3421,12 +3421,11 @@ static int intel_pt_process_switch(struct intel_pt *pt,
>  {
>  	pid_t tid;
>  	int cpu, ret;
> -	struct evsel *evsel = evlist__id2evsel(pt->session->evlist, sample->id);
>  
> -	if (evsel != pt->switch_evsel)
> +	if (sample->evsel != pt->switch_evsel)
>  		return 0;
>  
> -	tid = evsel__intval(evsel, sample, "next_pid");
> +	tid = evsel__intval(sample, "next_pid");
>  	cpu = sample->cpu;
>  
>  	intel_pt_log("sched_switch: cpu %d tid %d time %"PRIu64" tsc %#"PRIx64"\n",
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.c
> index 3c958d738ca6..21a672813099 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -186,7 +186,6 @@ static bool should_ignore_sample(const struct perf_sample *sample, const struct
>  static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  				union perf_event *event __maybe_unused,
>  				struct perf_sample *sample,
> -				struct evsel *evsel,
>  				struct machine *machine __maybe_unused)
>  {
>  	struct tpebs_retire_lat *t;
> @@ -197,7 +196,7 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
>  		mutex_unlock(tpebs_mtx_get());
>  		return 0;
>  	}
> -	t = tpebs_retire_lat__find(evsel);
> +	t = tpebs_retire_lat__find(sample->evsel);
>  	if (!t) {
>  		mutex_unlock(tpebs_mtx_get());
>  		return -EINVAL;
> diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
> index d4fe35f9d9a5..470b3b9f4812 100644
> --- a/tools/perf/util/jitdump.c
> +++ b/tools/perf/util/jitdump.c
> @@ -642,7 +642,7 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
>  
>  	ret = jit_inject_event(jd, event);
>  	if (!ret)
> -		build_id__mark_dso_hit(tool, event, &sample, NULL, jd->machine);
> +		build_id__mark_dso_hit(tool, event, &sample, jd->machine);
>  out:
>  	perf_sample__exit(&sample);
>  	return ret;
> diff --git a/tools/perf/util/kvm-stat.c b/tools/perf/util/kvm-stat.c
> index 38ace736db5c..0eaeb453e6b6 100644
> --- a/tools/perf/util/kvm-stat.c
> +++ b/tools/perf/util/kvm-stat.c
> @@ -10,20 +10,18 @@ bool kvm_exit_event(struct evsel *evsel)
>  	return evsel__name_is(evsel, kvm_exit_trace);
>  }
>  
> -void exit_event_get_key(struct evsel *evsel,
> -			struct perf_sample *sample,
> +void exit_event_get_key(struct perf_sample *sample,
>  			struct event_key *key)
>  {
>  	key->info = 0;
> -	key->key  = evsel__intval(evsel, sample, kvm_exit_reason);
> +	key->key  = evsel__intval(sample, kvm_exit_reason);
>  }
>  
>  
> -bool exit_event_begin(struct evsel *evsel,
> -		      struct perf_sample *sample, struct event_key *key)
> +bool exit_event_begin(struct perf_sample *sample, struct event_key *key)
>  {
> -	if (kvm_exit_event(evsel)) {
> -		exit_event_get_key(evsel, sample, key);
> +	if (kvm_exit_event(sample->evsel)) {
> +		exit_event_get_key(sample, key);
>  		return true;
>  	}
>  
> @@ -35,11 +33,10 @@ bool kvm_entry_event(struct evsel *evsel)
>  	return evsel__name_is(evsel, kvm_entry_trace);
>  }
>  
> -bool exit_event_end(struct evsel *evsel,
> -		    struct perf_sample *sample __maybe_unused,
> +bool exit_event_end(struct perf_sample *sample,
>  		    struct event_key *key __maybe_unused)
>  {
> -	return kvm_entry_event(evsel);
> +	return kvm_entry_event(sample->evsel);
>  }
>  
>  static const char *get_exit_reason(struct perf_kvm_stat *kvm,
> diff --git a/tools/perf/util/kvm-stat.h b/tools/perf/util/kvm-stat.h
> index a356b839c2ee..7bbfe9d1b7ea 100644
> --- a/tools/perf/util/kvm-stat.h
> +++ b/tools/perf/util/kvm-stat.h
> @@ -55,18 +55,15 @@ struct kvm_event {
>  };
>  
>  struct child_event_ops {
> -	void (*get_key)(struct evsel *evsel,
> -			struct perf_sample *sample,
> +	void (*get_key)(struct perf_sample *sample,
>  			struct event_key *key);
>  	const char *name;
>  };
>  
>  struct kvm_events_ops {
> -	bool (*is_begin_event)(struct evsel *evsel,
> -			       struct perf_sample *sample,
> +	bool (*is_begin_event)(struct perf_sample *sample,
>  			       struct event_key *key);
> -	bool (*is_end_event)(struct evsel *evsel,
> -			     struct perf_sample *sample, struct event_key *key);
> +	bool (*is_end_event)(struct perf_sample *sample, struct event_key *key);
>  	struct child_event_ops *child_ops;
>  	void (*decode_key)(struct perf_kvm_stat *kvm, struct event_key *key,
>  			   char *decode);
> @@ -118,14 +115,11 @@ struct kvm_reg_events_ops {
>  
>  #if defined(HAVE_KVM_STAT_SUPPORT) && defined(HAVE_LIBTRACEEVENT)
>  
> -void exit_event_get_key(struct evsel *evsel,
> -			struct perf_sample *sample,
> +void exit_event_get_key(struct perf_sample *sample,
>  			struct event_key *key);
> -bool exit_event_begin(struct evsel *evsel,
> -		      struct perf_sample *sample,
> +bool exit_event_begin(struct perf_sample *sample,
>  		      struct event_key *key);
> -bool exit_event_end(struct evsel *evsel,
> -		    struct perf_sample *sample,
> +bool exit_event_end(struct perf_sample *sample,
>  		    struct event_key *key);
>  void exit_event_decode_key(struct perf_kvm_stat *kvm,
>  			   struct event_key *key,
> diff --git a/tools/perf/util/kwork.h b/tools/perf/util/kwork.h
> index db00269b73f2..abf637d44794 100644
> --- a/tools/perf/util/kwork.h
> +++ b/tools/perf/util/kwork.h
> @@ -157,7 +157,6 @@ struct kwork_class {
>  			  struct kwork_class *class,
>  			  struct kwork_work *work,
>  			  enum kwork_trace_type src_type,
> -			  struct evsel *evsel,
>  			  struct perf_sample *sample,
>  			  struct machine *machine);
>  
> @@ -167,19 +166,19 @@ struct kwork_class {
>  
>  struct trace_kwork_handler {
>  	int (*raise_event)(struct perf_kwork *kwork,
> -			   struct kwork_class *class, struct evsel *evsel,
> +			   struct kwork_class *class,
>  			   struct perf_sample *sample, struct machine *machine);
>  
>  	int (*entry_event)(struct perf_kwork *kwork,
> -			   struct kwork_class *class, struct evsel *evsel,
> +			   struct kwork_class *class,
>  			   struct perf_sample *sample, struct machine *machine);
>  
>  	int (*exit_event)(struct perf_kwork *kwork,
> -			  struct kwork_class *class, struct evsel *evsel,
> +			  struct kwork_class *class,
>  			  struct perf_sample *sample, struct machine *machine);
>  
>  	int (*sched_switch_event)(struct perf_kwork *kwork,
> -				  struct kwork_class *class, struct evsel *evsel,
> +				  struct kwork_class *class,
>  				  struct perf_sample *sample, struct machine *machine);
>  };
>  
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 5b0f5a48ffd4..b41401423968 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -2766,13 +2766,13 @@ static u64 get_leaf_frame_caller(struct perf_sample *sample,
>  
>  static int thread__resolve_callchain_sample(struct thread *thread,
>  					    struct callchain_cursor *cursor,
> -					    struct evsel *evsel,
>  					    struct perf_sample *sample,
>  					    struct symbol **parent,
>  					    struct addr_location *root_al,
>  					    int max_stack,
>  					    bool symbols)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct branch_stack *branch = sample->branch_stack;
>  	struct branch_entry *entries = perf_sample__branch_entries(sample);
>  	struct ip_callchain *chain = sample->callchain;
> @@ -2974,10 +2974,11 @@ static int unwind_entry(struct unwind_entry *entry, void *arg)
>  
>  static int thread__resolve_callchain_unwind(struct thread *thread,
>  					    struct callchain_cursor *cursor,
> -					    struct evsel *evsel,
>  					    struct perf_sample *sample,
>  					    int max_stack, bool symbols)
>  {
> +	struct evsel *evsel = sample->evsel;
> +
>  	/* Can we do dwarf post unwind? */
>  	if (!((evsel->core.attr.sample_type & PERF_SAMPLE_REGS_USER) &&
>  	      (evsel->core.attr.sample_type & PERF_SAMPLE_STACK_USER)))
> @@ -2997,7 +2998,6 @@ static int thread__resolve_callchain_unwind(struct thread *thread,
>  
>  int __thread__resolve_callchain(struct thread *thread,
>  				struct callchain_cursor *cursor,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct symbol **parent,
>  				struct addr_location *root_al,
> @@ -3013,22 +3013,22 @@ int __thread__resolve_callchain(struct thread *thread,
>  
>  	if (callchain_param.order == ORDER_CALLEE) {
>  		ret = thread__resolve_callchain_sample(thread, cursor,
> -						       evsel, sample,
> +						       sample,
>  						       parent, root_al,
>  						       max_stack, symbols);
>  		if (ret)
>  			return ret;
>  		ret = thread__resolve_callchain_unwind(thread, cursor,
> -						       evsel, sample,
> +						       sample,
>  						       max_stack, symbols);
>  	} else {
>  		ret = thread__resolve_callchain_unwind(thread, cursor,
> -						       evsel, sample,
> +						       sample,
>  						       max_stack, symbols);
>  		if (ret)
>  			return ret;
>  		ret = thread__resolve_callchain_sample(thread, cursor,
> -						       evsel, sample,
> +						       sample,
>  						       parent, root_al,
>  						       max_stack, symbols);
>  	}
> diff --git a/tools/perf/util/machine.h b/tools/perf/util/machine.h
> index 22a42c5825fa..048b24e9bd38 100644
> --- a/tools/perf/util/machine.h
> +++ b/tools/perf/util/machine.h
> @@ -187,7 +187,6 @@ struct callchain_cursor;
>  
>  int __thread__resolve_callchain(struct thread *thread,
>  				struct callchain_cursor *cursor,
> -				struct evsel *evsel,
>  				struct perf_sample *sample,
>  				struct symbol **parent,
>  				struct addr_location *root_al,
> @@ -196,7 +195,6 @@ int __thread__resolve_callchain(struct thread *thread,
>  
>  static inline int thread__resolve_callchain(struct thread *thread,
>  					    struct callchain_cursor *cursor,
> -					    struct evsel *evsel,
>  					    struct perf_sample *sample,
>  					    struct symbol **parent,
>  					    struct addr_location *root_al,
> @@ -204,7 +202,6 @@ static inline int thread__resolve_callchain(struct thread *thread,
>  {
>  	return __thread__resolve_callchain(thread,
>  					   cursor,
> -					   evsel,
>  					   sample,
>  					   parent,
>  					   root_al,
> diff --git a/tools/perf/util/sample.h b/tools/perf/util/sample.h
> index a8307b20a9ea..112980ff851c 100644
> --- a/tools/perf/util/sample.h
> +++ b/tools/perf/util/sample.h
> @@ -79,6 +79,7 @@ struct simd_flags {
>  #define SIMD_OP_FLAGS_PRED_EMPTY	0x02	/* empty predicate */
>  
>  struct perf_sample {
> +	struct evsel *evsel;
>  	u64 ip;
>  	u32 pid, tid;
>  	u64 time;
> diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> index e261a57b87d4..61454073db1c 100644
> --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> @@ -257,7 +257,6 @@ static void define_event_symbols(struct tep_event *event,
>  }
>  
>  static SV *perl_process_callchain(struct perf_sample *sample,
> -				  struct evsel *evsel,
>  				  struct addr_location *al)
>  {
>  	struct callchain_cursor *cursor;
> @@ -272,8 +271,9 @@ static SV *perl_process_callchain(struct perf_sample *sample,
>  
>  	cursor = get_tls_callchain_cursor();
>  
> -	if (thread__resolve_callchain(al->thread, cursor, evsel,
> -				      sample, NULL, NULL, scripting_max_stack) != 0) {
> +	if (thread__resolve_callchain(al->thread, cursor, sample,
> +				      /*parent=*/NULL, /*root_al=*/NULL,
> +				      scripting_max_stack) != 0) {
>  		pr_err("Failed to resolve callchain. Skipping\n");
>  		goto exit;
>  	}
> @@ -340,9 +340,9 @@ static SV *perl_process_callchain(struct perf_sample *sample,
>  }
>  
>  static void perl_process_tracepoint(struct perf_sample *sample,
> -				    struct evsel *evsel,
>  				    struct addr_location *al)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct thread *thread = al->thread;
>  	struct tep_event *event;
>  	struct tep_format_field *field;
> @@ -389,7 +389,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
>  	XPUSHs(sv_2mortal(newSVuv(ns)));
>  	XPUSHs(sv_2mortal(newSViv(pid)));
>  	XPUSHs(sv_2mortal(newSVpv(comm, 0)));
> -	XPUSHs(sv_2mortal(perl_process_callchain(sample, evsel, al)));
> +	XPUSHs(sv_2mortal(perl_process_callchain(sample, al)));
>  
>  	/* common fields other than pid can be accessed via xsub fns */
>  
> @@ -426,7 +426,7 @@ static void perl_process_tracepoint(struct perf_sample *sample,
>  		XPUSHs(sv_2mortal(newSVuv(nsecs)));
>  		XPUSHs(sv_2mortal(newSViv(pid)));
>  		XPUSHs(sv_2mortal(newSVpv(comm, 0)));
> -		XPUSHs(sv_2mortal(perl_process_callchain(sample, evsel, al)));
> +		XPUSHs(sv_2mortal(perl_process_callchain(sample, al)));
>  		call_pv("main::trace_unhandled", G_SCALAR);
>  	}
>  	SPAGAIN;
> @@ -436,9 +436,9 @@ static void perl_process_tracepoint(struct perf_sample *sample,
>  }
>  
>  static void perl_process_event_generic(union perf_event *event,
> -				       struct perf_sample *sample,
> -				       struct evsel *evsel)
> +				       struct perf_sample *sample)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	dSP;
>  
>  	if (!get_cv("process_event", 0))
> @@ -461,13 +461,12 @@ static void perl_process_event_generic(union perf_event *event,
>  
>  static void perl_process_event(union perf_event *event,
>  			       struct perf_sample *sample,
> -			       struct evsel *evsel,
>  			       struct addr_location *al,
>  			       struct addr_location *addr_al)
>  {
> -	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
> -	perl_process_tracepoint(sample, evsel, al);
> -	perl_process_event_generic(event, sample, evsel);
> +	scripting_context__update(scripting_context, event, sample, al, addr_al);
> +	perl_process_tracepoint(sample, al);
> +	perl_process_event_generic(event, sample);
>  }
>  
>  static void run_start_sub(void)
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index b90edc147796..e55cbe779f6e 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -390,7 +390,6 @@ static unsigned long get_offset(struct symbol *sym, struct addr_location *al)
>  }
>  
>  static PyObject *python_process_callchain(struct perf_sample *sample,
> -					 struct evsel *evsel,
>  					 struct addr_location *al)
>  {
>  	PyObject *pylist;
> @@ -404,7 +403,7 @@ static PyObject *python_process_callchain(struct perf_sample *sample,
>  		goto exit;
>  
>  	cursor = get_tls_callchain_cursor();
> -	if (thread__resolve_callchain(al->thread, cursor, evsel,
> +	if (thread__resolve_callchain(al->thread, cursor,
>  				      sample, NULL, NULL,
>  				      scripting_max_stack) != 0) {
>  		pr_err("Failed to resolve callchain. Skipping\n");
> @@ -829,11 +828,11 @@ static void python_process_sample_flags(struct perf_sample *sample, PyObject *di
>  }
>  
>  static PyObject *get_perf_sample_dict(struct perf_sample *sample,
> -					 struct evsel *evsel,
>  					 struct addr_location *al,
>  					 struct addr_location *addr_al,
>  					 PyObject *callchain)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	PyObject *dict, *dict_sample, *brstack, *brstacksym;
>  	struct machine *machine;
>  	uint16_t e_machine = EM_HOST;
> @@ -935,10 +934,10 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
>  
>  #ifdef HAVE_LIBTRACEEVENT
>  static void python_process_tracepoint(struct perf_sample *sample,
> -				      struct evsel *evsel,
>  				      struct addr_location *al,
>  				      struct addr_location *addr_al)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	struct tep_event *event;
>  	PyObject *handler, *context, *t, *obj = NULL, *callchain;
>  	PyObject *dict = NULL, *all_entries_dict = NULL;
> @@ -994,7 +993,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  	PyTuple_SetItem(t, n++, context);
>  
>  	/* ip unwinding */
> -	callchain = python_process_callchain(sample, evsel, al);
> +	callchain = python_process_callchain(sample, al);
>  	/* Need an additional reference for the perf_sample dict */
>  	Py_INCREF(callchain);
>  
> @@ -1050,7 +1049,7 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  		PyTuple_SetItem(t, n++, dict);
>  
>  	if (get_argument_count(handler) == (int) n + 1) {
> -		all_entries_dict = get_perf_sample_dict(sample, evsel, al, addr_al,
> +		all_entries_dict = get_perf_sample_dict(sample, al, addr_al,
>  			callchain);
>  		PyTuple_SetItem(t, n++,	all_entries_dict);
>  	} else {
> @@ -1069,7 +1068,6 @@ static void python_process_tracepoint(struct perf_sample *sample,
>  }
>  #else
>  static void python_process_tracepoint(struct perf_sample *sample __maybe_unused,
> -				      struct evsel *evsel __maybe_unused,
>  				      struct addr_location *al __maybe_unused,
>  				      struct addr_location *addr_al __maybe_unused)
>  {
> @@ -1311,7 +1309,7 @@ static void python_export_sample_table(struct db_export *dbe,
>  	t = tuple_new(28);
>  
>  	tuple_set_d64(t, 0, es->db_id);
> -	tuple_set_d64(t, 1, es->evsel->db_id);
> +	tuple_set_d64(t, 1, es->sample->evsel->db_id);
>  	tuple_set_d64(t, 2, maps__machine(thread__maps(es->al->thread))->db_id);
>  	tuple_set_d64(t, 3, thread__db_id(es->al->thread));
>  	tuple_set_d64(t, 4, es->comm_db_id);
> @@ -1352,7 +1350,7 @@ static void python_export_synth(struct db_export *dbe, struct export_sample *es)
>  	t = tuple_new(3);
>  
>  	tuple_set_d64(t, 0, es->db_id);
> -	tuple_set_d64(t, 1, es->evsel->core.attr.config);
> +	tuple_set_d64(t, 1, es->sample->evsel->core.attr.config);
>  	tuple_set_bytes(t, 2, es->sample->raw_data, es->sample->raw_size);
>  
>  	call_object(tables->synth_handler, t, "synth_data");
> @@ -1367,7 +1365,7 @@ static int python_export_sample(struct db_export *dbe,
>  
>  	python_export_sample_table(dbe, es);
>  
> -	if (es->evsel->core.attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
> +	if (es->sample->evsel->core.attr.type == PERF_TYPE_SYNTH && tables->synth_handler)
>  		python_export_synth(dbe, es);
>  
>  	return 0;
> @@ -1464,7 +1462,6 @@ static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
>  }
>  
>  static void python_process_general_event(struct perf_sample *sample,
> -					 struct evsel *evsel,
>  					 struct addr_location *al,
>  					 struct addr_location *addr_al)
>  {
> @@ -1487,8 +1484,8 @@ static void python_process_general_event(struct perf_sample *sample,
>  		Py_FatalError("couldn't create Python tuple");
>  
>  	/* ip unwinding */
> -	callchain = python_process_callchain(sample, evsel, al);
> -	dict = get_perf_sample_dict(sample, evsel, al, addr_al, callchain);
> +	callchain = python_process_callchain(sample, al);
> +	dict = get_perf_sample_dict(sample, al, addr_al, callchain);
>  
>  	PyTuple_SetItem(t, n++, dict);
>  	if (_PyTuple_Resize(&t, n) == -1)
> @@ -1501,24 +1498,23 @@ static void python_process_general_event(struct perf_sample *sample,
>  
>  static void python_process_event(union perf_event *event,
>  				 struct perf_sample *sample,
> -				 struct evsel *evsel,
>  				 struct addr_location *al,
>  				 struct addr_location *addr_al)
>  {
>  	struct tables *tables = &tables_global;
>  
> -	scripting_context__update(scripting_context, event, sample, evsel, al, addr_al);
> +	scripting_context__update(scripting_context, event, sample, al, addr_al);
>  
> -	switch (evsel->core.attr.type) {
> +	switch (sample->evsel->core.attr.type) {
>  	case PERF_TYPE_TRACEPOINT:
> -		python_process_tracepoint(sample, evsel, al, addr_al);
> +		python_process_tracepoint(sample, al, addr_al);
>  		break;
>  	/* Reserve for future process_hw/sw/raw APIs */
>  	default:
>  		if (tables->db_export_mode)
> -			db_export__sample(&tables->dbe, event, sample, evsel, al, addr_al);
> +			db_export__sample(&tables->dbe, event, sample, al, addr_al);
>  		else
> -			python_process_general_event(sample, evsel, al, addr_al);
> +			python_process_general_event(sample, al, addr_al);
>  	}
>  }
>  
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index c0231bc000e7..577d03c2cb88 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1109,9 +1109,10 @@ char *get_page_size_name(u64 size, char *str)
>  	return str;
>  }
>  
> -static void dump_sample(struct machine *machine, struct evsel *evsel, union perf_event *event,
> +static void dump_sample(struct machine *machine, union perf_event *event,
>  			struct perf_sample *sample)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	u64 sample_type;
>  	char str[PAGE_SIZE_NAME_LEN];
>  	uint16_t e_machine = EM_NONE;
> @@ -1174,8 +1175,7 @@ static void dump_sample(struct machine *machine, struct evsel *evsel, union perf
>  		sample_read__printf(sample, evsel->core.attr.read_format);
>  }
>  
> -static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event,
> -				    struct perf_sample *sample)
> +static void dump_deferred_callchain(union perf_event *event, struct perf_sample *sample)
>  {
>  	if (!dump_trace)
>  		return;
> @@ -1183,8 +1183,8 @@ static void dump_deferred_callchain(struct evsel *evsel, union perf_event *event
>  	printf("(IP, 0x%x): %d/%d: %#" PRIx64 "\n",
>  	       event->header.misc, sample->pid, sample->tid, sample->deferred_cookie);
>  
> -	if (evsel__has_callchain(evsel))
> -		callchain__printf(evsel, sample);
> +	if (evsel__has_callchain(sample->evsel))
> +		callchain__printf(sample->evsel, sample);
>  }
>  
>  static void dump_read(struct evsel *evsel, union perf_event *event)
> @@ -1255,8 +1255,9 @@ static int deliver_sample_value(struct evlist *evlist,
>  				bool per_thread)
>  {
>  	struct perf_sample_id *sid = evlist__id2sid(evlist, v->id);
> -	struct evsel *evsel;
> +	struct evsel *saved_evsel = sample->evsel;
>  	u64 *storage = NULL;
> +	int ret;
>  
>  	if (sid) {
>  		storage = perf_sample_id__get_period_storage(sid, sample->tid, per_thread);
> @@ -1280,8 +1281,10 @@ static int deliver_sample_value(struct evlist *evlist,
>  	if (!sample->period)
>  		return 0;
>  
> -	evsel = container_of(sid->evsel, struct evsel, core);
> -	return tool->sample(tool, event, sample, evsel, machine);
> +	sample->evsel = container_of(sid->evsel, struct evsel, core);
> +	ret = tool->sample(tool, event, sample, machine);
> +	sample->evsel = saved_evsel;
> +	return ret;
>  }
>  
>  static int deliver_sample_group(struct evlist *evlist,
> @@ -1311,8 +1314,9 @@ static int deliver_sample_group(struct evlist *evlist,
>  
>  static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool *tool,
>  				  union  perf_event *event, struct perf_sample *sample,
> -				  struct evsel *evsel, struct machine *machine)
> +				  struct machine *machine)
>  {
> +	struct evsel *evsel = sample->evsel;
>  	/* We know evsel != NULL. */
>  	u64 sample_type = evsel->core.attr.sample_type;
>  	u64 read_format = evsel->core.attr.read_format;
> @@ -1320,7 +1324,7 @@ static int evlist__deliver_sample(struct evlist *evlist, const struct perf_tool
>  
>  	/* Standard sample delivery. */
>  	if (!(sample_type & PERF_SAMPLE_READ))
> -		return tool->sample(tool, event, sample, evsel, machine);
> +		return tool->sample(tool, event, sample, machine);
>  
>  	/* For PERF_SAMPLE_READ we have either single or group mode. */
>  	if (read_format & PERF_FORMAT_GROUP)
> @@ -1353,13 +1357,15 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
>  					      struct machine *machine)
>  {
>  	struct deferred_event *de, *tmp;
> -	struct evsel *evsel;
>  	int ret = 0;
>  
>  	if (!tool->merge_deferred_callchains) {
> -		evsel = evlist__id2evsel(evlist, sample->id);
> -		return tool->callchain_deferred(tool, event, sample,
> -						evsel, machine);
> +		struct evsel *saved_evsel = sample->evsel;
> +
> +		sample->evsel = evlist__id2evsel(evlist, sample->id);
> +		ret = tool->callchain_deferred(tool, event, sample, machine);
> +		sample->evsel = saved_evsel;
> +		return ret;
>  	}
>  
>  	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> @@ -1379,9 +1385,9 @@ static int evlist__deliver_deferred_callchain(struct evlist *evlist,
>  		else
>  			orig_sample.deferred_callchain = false;
>  
> -		evsel = evlist__id2evsel(evlist, orig_sample.id);
> +		orig_sample.evsel = evlist__id2evsel(evlist, orig_sample.id);
>  		ret = evlist__deliver_sample(evlist, tool, de->event,
> -					     &orig_sample, evsel, machine);
> +					     &orig_sample, machine);
>  
>  		if (orig_sample.deferred_callchain)
>  			free(orig_sample.callchain);
> @@ -1406,7 +1412,6 @@ static int session__flush_deferred_samples(struct perf_session *session,
>  	struct evlist *evlist = session->evlist;
>  	struct machine *machine = &session->machines.host;
>  	struct deferred_event *de, *tmp;
> -	struct evsel *evsel;
>  	int ret = 0;
>  
>  	list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list) {
> @@ -1418,9 +1423,9 @@ static int session__flush_deferred_samples(struct perf_session *session,
>  			break;
>  		}
>  
> -		evsel = evlist__id2evsel(evlist, sample.id);
> +		sample.evsel = evlist__id2evsel(evlist, sample.id);
>  		ret = evlist__deliver_sample(evlist, tool, de->event,
> -					     &sample, evsel, machine);
> +					     &sample, machine);
>  
>  		list_del(&de->list);
>  		free(de->event);
> @@ -1439,27 +1444,29 @@ static int machines__deliver_event(struct machines *machines,
>  				   const struct perf_tool *tool, u64 file_offset,
>  				   const char *file_path)
>  {
> -	struct evsel *evsel;
>  	struct machine *machine;
>  
>  	dump_event(evlist, event, file_offset, sample, file_path);
>  
> -	evsel = evlist__id2evsel(evlist, sample->id);
> +	if (!sample->evsel)
> +		sample->evsel = evlist__id2evsel(evlist, sample->id);
> +	else
> +		assert(sample->evsel == evlist__id2evsel(evlist, sample->id));
>  
>  	machine = machines__find_for_cpumode(machines, event, sample);
>  
>  	switch (event->header.type) {
>  	case PERF_RECORD_SAMPLE:
> -		if (evsel == NULL) {
> +		if (sample->evsel == NULL) {
>  			++evlist->stats.nr_unknown_id;
>  			return 0;
>  		}
>  		if (machine == NULL) {
>  			++evlist->stats.nr_unprocessable_samples;
> -			dump_sample(machine, evsel, event, sample);
> +			dump_sample(machine, event, sample);
>  			return 0;
>  		}
> -		dump_sample(machine, evsel, event, sample);
> +		dump_sample(machine, event, sample);
>  		if (sample->deferred_callchain && tool->merge_deferred_callchains) {
>  			struct deferred_event *de = malloc(sizeof(*de));
>  			size_t sz = event->header.size;
> @@ -1476,7 +1483,7 @@ static int machines__deliver_event(struct machines *machines,
>  			list_add_tail(&de->list, &evlist->deferred_samples);
>  			return 0;
>  		}
> -		return evlist__deliver_sample(evlist, tool, event, sample, evsel, machine);
> +		return evlist__deliver_sample(evlist, tool, event, sample, machine);
>  	case PERF_RECORD_MMAP:
>  		return tool->mmap(tool, event, sample, machine);
>  	case PERF_RECORD_MMAP2:
> @@ -1504,8 +1511,8 @@ static int machines__deliver_event(struct machines *machines,
>  			evlist->stats.total_lost_samples += event->lost_samples.lost;
>  		return tool->lost_samples(tool, event, sample, machine);
>  	case PERF_RECORD_READ:
> -		dump_read(evsel, event);
> -		return tool->read(tool, event, sample, evsel, machine);
> +		dump_read(sample->evsel, event);
> +		return tool->read(tool, event, sample, machine);
>  	case PERF_RECORD_THROTTLE:
>  		return tool->throttle(tool, event, sample, machine);
>  	case PERF_RECORD_UNTHROTTLE:
> @@ -1534,7 +1541,7 @@ static int machines__deliver_event(struct machines *machines,
>  	case PERF_RECORD_AUX_OUTPUT_HW_ID:
>  		return tool->aux_output_hw_id(tool, event, sample, machine);
>  	case PERF_RECORD_CALLCHAIN_DEFERRED:
> -		dump_deferred_callchain(evsel, event, sample);
> +		dump_deferred_callchain(event, sample);
>  		return evlist__deliver_deferred_callchain(evlist, tool, event,
>  							  sample, machine);
>  	default:
> diff --git a/tools/perf/util/tool.c b/tools/perf/util/tool.c
> index 013c7839e2cf..0f285a2574c8 100644
> --- a/tools/perf/util/tool.c
> +++ b/tools/perf/util/tool.c
> @@ -110,7 +110,6 @@ static int process_event_synth_event_update_stub(const struct perf_tool *tool __
>  int process_event_sample_stub(const struct perf_tool *tool __maybe_unused,
>  			      union perf_event *event __maybe_unused,
>  			      struct perf_sample *sample __maybe_unused,
> -			      struct evsel *evsel __maybe_unused,
>  			      struct machine *machine __maybe_unused)
>  {
>  	dump_printf(": unhandled!\n");
> @@ -348,12 +347,11 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool)
>  	static int delegate_ ## name(const struct perf_tool *tool, \
>  				     union perf_event *event, \
>  				     struct perf_sample *sample, \
> -				     struct evsel *evsel, \
>  				     struct machine *machine) \
>  	{								\
>  		struct delegate_tool *del_tool = container_of(tool, struct delegate_tool, tool); \
>  		struct perf_tool *delegate = del_tool->delegate;		\
> -		return delegate->name(delegate, event, sample, evsel, machine);	\
> +		return delegate->name(delegate, event, sample, machine);	\
>  	}
>  CREATE_DELEGATE_SAMPLE(read);
>  CREATE_DELEGATE_SAMPLE(sample);
> diff --git a/tools/perf/util/tool.h b/tools/perf/util/tool.h
> index 2d9a4b1ca9d0..2a4f124ffd8d 100644
> --- a/tools/perf/util/tool.h
> +++ b/tools/perf/util/tool.h
> @@ -9,7 +9,6 @@
>  struct perf_session;
>  union perf_event;
>  struct evlist;
> -struct evsel;
>  struct perf_sample;
>  struct perf_tool;
>  struct machine;
> @@ -17,7 +16,7 @@ struct ordered_events;
>  
>  typedef int (*event_sample)(const struct perf_tool *tool, union perf_event *event,
>  			    struct perf_sample *sample,
> -			    struct evsel *evsel, struct machine *machine);
> +			    struct machine *machine);
>  
>  typedef int (*event_op)(const struct perf_tool *tool, union perf_event *event,
>  			struct perf_sample *sample, struct machine *machine);
> @@ -103,7 +102,6 @@ bool perf_tool__compressed_is_stub(const struct perf_tool *tool);
>  int process_event_sample_stub(const struct perf_tool *tool,
>  			      union perf_event *event,
>  			      struct perf_sample *sample,
> -			      struct evsel *evsel,
>  			      struct machine *machine);
>  
>  struct delegate_tool {
> diff --git a/tools/perf/util/trace-event-scripting.c b/tools/perf/util/trace-event-scripting.c
> index 72abb28b7b5a..2dbb1a402be7 100644
> --- a/tools/perf/util/trace-event-scripting.c
> +++ b/tools/perf/util/trace-event-scripting.c
> @@ -104,12 +104,11 @@ int script_spec__for_each(int (*cb)(struct scripting_ops *ops, const char *spec)
>  void scripting_context__update(struct scripting_context *c,
>  			       union perf_event *event,
>  			       struct perf_sample *sample,
> -			       struct evsel *evsel,
>  			       struct addr_location *al,
>  			       struct addr_location *addr_al)
>  {
>  #ifdef HAVE_LIBTRACEEVENT
> -	const struct tep_event *tp_format = evsel__tp_format(evsel);
> +	const struct tep_event *tp_format = evsel__tp_format(sample->evsel);
>  
>  	c->pevent = tp_format ? tp_format->tep : NULL;
>  #else
> @@ -118,7 +117,6 @@ void scripting_context__update(struct scripting_context *c,
>  	c->event_data = sample->raw_data;
>  	c->event = event;
>  	c->sample = sample;
> -	c->evsel = evsel;
>  	c->al = al;
>  	c->addr_al = addr_al;
>  }
> @@ -135,7 +133,6 @@ static int stop_script_unsupported(void)
>  
>  static void process_event_unsupported(union perf_event *event __maybe_unused,
>  				      struct perf_sample *sample __maybe_unused,
> -				      struct evsel *evsel __maybe_unused,
>  				      struct addr_location *al __maybe_unused,
>  				      struct addr_location *addr_al __maybe_unused)
>  {
> diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
> index 71e680bc3d4b..909c0e016e5a 100644
> --- a/tools/perf/util/trace-event.h
> +++ b/tools/perf/util/trace-event.h
> @@ -94,7 +94,6 @@ struct scripting_ops {
>  	int (*stop_script) (void);
>  	void (*process_event) (union perf_event *event,
>  			       struct perf_sample *sample,
> -			       struct evsel *evsel,
>  			       struct addr_location *al,
>  			       struct addr_location *addr_al);
>  	void (*process_switch)(union perf_event *event,
> @@ -127,7 +126,6 @@ struct scripting_context {
>  	void *event_data;
>  	union perf_event *event;
>  	struct perf_sample *sample;
> -	struct evsel *evsel;
>  	struct addr_location *al;
>  	struct addr_location *addr_al;
>  	struct perf_session *session;
> @@ -136,7 +134,6 @@ struct scripting_context {
>  void scripting_context__update(struct scripting_context *scripting_context,
>  			       union perf_event *event,
>  			       struct perf_sample *sample,
> -			       struct evsel *evsel,
>  			       struct addr_location *al,
>  			       struct addr_location *addr_al);
>  
