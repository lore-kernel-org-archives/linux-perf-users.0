Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518793019A6
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Dec 2025 06:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764657824; cv=none; b=KFb0ZQnLeplq28KTSua96yMhRS4RPFVt+W3Y2ah+TERj2a/7SDyUiNJeIB+6m7IIIJofsKFVYWZ5OvXszwVue+ostDpbZKM21CtqxJWxv6O3XGmDGbZwVpIDc/Z95mpmHkqVZF5kmimCSt/znXy6d8TtUJGedklTZ9Fi+EHfRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764657824; c=relaxed/simple;
	bh=Jf9gVgouUS6WA1WmAKl+iapmoVqz/JtN0fwXRs+b4qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWG03LQ+jT3A9+gQY9w181NT+pux021DfQmJH3hEj09zWYM2Ib0HRgtDlvRQ6/KYZUSNzqiUWNSToIaf7gj2Q93Ikcbxg7Izejf+5YAENobpZfJmv3lUO+mKLjSQp1tXC5LX+UfiBohmuRbynUHVCrs5KE4zBKDHYkcNP84nmRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cumvfgwy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cumvfgwy"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-297f35be2ffso77056345ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 22:43:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764657821; x=1765262621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=htyZzDjpItfBeC/qRXvnJ6nxzkqeSejC8MJ5WVXPcQY=;
        b=CumvfgwykknWCLlGYfxl+aWzXM+wsXYC464qBApiNydWyo/GCG1/7RTtXpXKc+dHrx
         991hAxia7u5AdoccVPsITEX81DXNJZiWLee1gga39SLmNdYh4wvcwVEe6YcYHtDNtmk/
         UhEl3Wa2dAa4we0KkOidLr8rkfrEcU/r/iLX3OS3+dXn4CjlZkw941vAi4dUsmagCMCC
         V3DpQQ/B5cYX8ef5Niy23jwcZGhwC+6mMHvo1IYQVKF8Rl7CqQpTtt5KZ+Ao0Nov0Pj/
         Z2Yd2aCcCtCkf3hZ7KuZbH8rzgvwo5tk8Q23Ip+T/rn6ftht8h1Qxp91cAuTVcu6RQJ8
         N6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764657821; x=1765262621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htyZzDjpItfBeC/qRXvnJ6nxzkqeSejC8MJ5WVXPcQY=;
        b=B//8HLJhsi4P2hpVmZ1iEgxnTdu6rFOrsf3k3BBrVMswL7pFWP8roiBvCrXVz8TGYs
         jzQCWTl6D1NAhshfzI0TH6B0srv7WExSsiNYoVqcB6X3RqvMOvInvZmAsJjmur5gb5O4
         P927OLq7D5dhub040OwfgJnZ/Oonfy7ViUcnuP34KQxWjLf8Y1Wz+sINhY+iHJclkxM9
         ja88qs4ZVJCqEqtYBPuqk9WOrkowoXu/tLNwu7BzL5FOPCLccgGI92HlGdU8eOVAvM86
         doQX1Wu8U+tUXaXE76yWLruRm/xVM5z1RFRQlpl+990yBNkP+TSUcU5A0wbOWAfda1Wp
         zgKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWBjyE5xj1yGspdZJQLdWIFHNXI4JbR+aC3gaVFz5jXtrdlvYSqEZyduR6cYmFtuJiTaz39ETOh8eX8mqwfI5t@vger.kernel.org
X-Gm-Message-State: AOJu0YyNB/VtDcfQRTrItqS49enC5rUn7Z9OTRCM8vgs9LQlY+QyDdwM
	lXvaTUH72qTEPyKbjFxWFBkZlrYmuhC4heZ1YE8QqJuDTlhoXhF+H+BdGZ44fTFs3fM=
X-Gm-Gg: ASbGncvKMpVbfKfCNJky7K9lP4a19hhkmxMu4QbBWQznjwSRczEJgPo1FnNr3Q87HcX
	YjKkjWh0A6YgamRPYx5KbpDPI/CuiXJAJ0pzr3lNLdLuiCuIBlVlKhpvgEcCXw27mK1zQJs7sAw
	yqDMK9I42itF20w195DIij0u5oGfB8GrWPUZp45LO9EIhXGSov2IDaoVsArDH27gd8kP7gvYjJi
	61HKOC+OFoqIxDrHq8U/IJEaqNXdM2OTz5T+SNEQjyHxYt14Y1E1atleH/I7avq5kOGgaw83y/I
	6I9xYHDBL+Hj5r6O6ZBvgrpEGvY7hKtoVxbQxi95EBEDFJ2mfmat3n0CO3Ikr/lIcF3t5WpRVtV
	VEJoWWpIwn76mhx/d/dYNW8wEtyrYiH2j0XT0nk9GeyRFsO4kcb9ew8AbXEJlgH5RRIRPrLrLQa
	McI+lHMxb4oJUQPlNPSarOvw==
X-Google-Smtp-Source: AGHT+IElB/55iOL3pFkt4jDnVftx8SMwzLAFev+IFE16AlTrASn4wJp/yshPqxy/pYWD5aWdbmoY1g==
X-Received: by 2002:a17:903:2b0f:b0:297:e66a:2065 with SMTP id d9443c01a7336-29b6c6d0d46mr435400315ad.56.1764657821143;
        Mon, 01 Dec 2025 22:43:41 -0800 (PST)
Received: from localhost ([122.172.86.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bce4418c4sm139899275ad.24.2025.12.01.22.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 22:43:40 -0800 (PST)
Date: Tue, 2 Dec 2025 12:13:37 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Samuel Wu <wusamuel@google.com>
Cc: Huang Rui <ray.huang@amd.com>, 
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
	Perry Yuan <perry.yuan@amd.com>, Jonathan Corbet <corbet@lwn.net>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, christian.loehle@arm.com, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Replace trace_cpu_frequency with
 trace_policy_frequency
Message-ID: <inifvm4pxifvdazsfyi2ppzfwum6ukzujx5sfiux4s2iv55z4p@otoaj35vr47c>
References: <20251201202437.3750901-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201202437.3750901-1-wusamuel@google.com>

On 01-12-25, 12:24, Samuel Wu wrote:
> This series replaces the cpu_frequency trace event with a new trace event,
> policy_frequency. Since by definition all CPUs in a policy are of the same
> frequency, we can emit a frequency change per policy instead of per CPU.
> This saves some compute and memory from the kernel side, while simplifying
> analysis from the post-processing of the trace log side.
> 
> Any process that relied on cpu_frequency trace event needs to switch to the
> new policy_frequency trace event in order to maintain functionality. The
> decision of replacing instead of adding the trace event is intentional. Since
> emitting once per policy instead of once per CPU is anyways a semantics change
> that would require a tooling update, the trace event was also appropriately
> renamed. The presence of the policy_frequency event in a trace log is a clear
> and obvious signal for tooling to determine kernel version and which trace
> event to parse.
> 
> 1/2: Replaces trace_cpu_frequency with trace_policy_frequency
> 2/2: Corresponding documentation patch that updates references to
>      cpu_frequency with policy_frequency
> 
> Changes in v3:
> - Resending v2 properly (accidentally ommited cover letter in v2)
> 
> Changes in v2:
> - Replaced trace_cpu_frequency with trace_policy_frequency (per Christian
>   and Viresh)
> - Updated references to cpu_frequency in documentation with
>   policy_frequency
> - v1 link: https://lore.kernel.org/all/20251112235154.2974902-1-wusamuel@google.com
> 
> Samuel Wu (2):
>   cpufreq: Replace trace_cpu_frequency with trace_policy_frequency
>   cpufreq: Documentation update for trace_policy_frequency
> 
>  Documentation/admin-guide/pm/amd-pstate.rst   | 10 ++++----
>  Documentation/admin-guide/pm/intel_pstate.rst | 14 +++++------
>  Documentation/trace/events-power.rst          |  2 +-
>  drivers/cpufreq/cpufreq.c                     | 14 ++---------
>  drivers/cpufreq/intel_pstate.c                |  6 +++--
>  include/trace/events/power.h                  | 24 ++++++++++++++++---
>  kernel/trace/power-traces.c                   |  2 +-
>  samples/bpf/cpustat_kern.c                    |  8 +++----
>  samples/bpf/cpustat_user.c                    |  6 ++---
>  tools/perf/builtin-timechart.c                | 12 +++++-----
>  10 files changed, 54 insertions(+), 44 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
