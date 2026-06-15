Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC93A211A14
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515984; cv=none; b=o5Fxff/+EtweYBC1fqGgOUEcA05F3VxJwXeN3/LbmYcGaE6nZuyZ/0F6zBJ9CA684Tnyi4II2+b6w5kqJ3Y3mzoH1J1t7sgxcX4RID6bA5yoHdxv8oagMtEq/EC5vZw/eTbA0H/vEY3cTalFrI3EXV8KZyp8WEoeSQ2G39Wk3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515984; c=relaxed/simple;
	bh=6eFgUarl130hblAtHvXDY3WgBXBGJLDa8Qj7oPO1ow8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kh8kg2vryNABb2h0E0Pg1/A4cMJOm2cm76Qt2Y5aOQsfJOcUW7qsSN481j5jBejFwEI5xMcHK8uNqrTiK8l0sNzhKxeFLM1KStB0TMG6ziEOTiTKCIyykueBKBXDlCOph49eEVp5/qPiX+w5nR6ZshQoSEVBEWxAg+DKOcMsX4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yuWmEVSy; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yuWmEVSy"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so5961937a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jun 2026 02:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781515981; x=1782120781; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tngrBAF6XpDRoWtFVzMWX84OyA/6g4HK0wmr2yCm46w=;
        b=yuWmEVSy0Qlcd4Gm7iH9VHVAjRCdUvW5uUsIlEwGQjE451AeAZQ04lWDe/YebFx5ea
         NJ9Fi9REqMtjxzga1Ek6zjELvawQkpBwkmSkjcC7X40f/8rRBS+byRPwIwCimoa5RbRi
         zI2SYobXdgAW7PuvWRQ1Pf9MhtmunLrdR1xvdkm56sPEDPGKzea3n/QA5fbkknJ1spzM
         tLaTTK7j4BiFhvhFcxagMNo0atvcCmhMkBBpc37o3S1kxhQWEgNPEEn1x4LPK9JEgfnR
         M2hY+OVY8bykoym1j+ytHaLiwO+4A0FiINEzG/secFxU63U7NQGepckgpEcfToqWVyMU
         AZyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781515981; x=1782120781;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tngrBAF6XpDRoWtFVzMWX84OyA/6g4HK0wmr2yCm46w=;
        b=gAHaCsECD4HJmVFqjara8KsSdmUZcLmyr0VIwQugU2zwHWy9StIvK+K09Sy9imgZPF
         /U8B9q4kFNLfBc3h8n7zs+TV7B94soqKOoqBkNJD6WhRdwiqrKvC5yHFL/L/5PLRhHUO
         8rCr3w0oneLGW7ZuSX+m0T3jp9rpydrJYfQGCEQD7Bq9ymOJQxOlQUbtES/g0XkfTvSN
         xxIOo8KQA0DEFGdoTiiXFwxQOv91HCq3mSsF3bc3aoVVTHimEAsAse/FKJAC0kBSVO6z
         UK7aUU2OS2TUeQ3jlNNU/SvvMkSOtb8WIkdQtcRHQLylpVkViY9ri9ZH7LZ4E3hnyd61
         ooZA==
X-Forwarded-Encrypted: i=1; AFNElJ+5uPGFpSjDkFb6kYG5GffFcn9sh9R9p9kGxZI1VHktK0L80wpyhAA1vlri0tHDWnLWrN7O2soQ0LTuqji9yfQK@vger.kernel.org
X-Gm-Message-State: AOJu0YwVZKfz4pA7+cPz1AyV2+GUn1TyhnNz3sIqBUltJs+eauYXiC0/
	OfhGcFUXhv8ZQPm2beFjwYPZ42oWR2/CtiA/Ec9iRaREZT5ce2IOlsvM5kU4TChjs1o=
X-Gm-Gg: Acq92OEWyO5Ebt6LGuQPzzEtsS3329sSSM1NxzLOg66MW31uVxqCW+judeHJ4BWoyIj
	tEYWoOmU0dUKja/VrNdlJ71uyVnGu8pRA5WI7AVGIczVwktgnOh77nV1QiFvkQs7jpHdSHvMJNw
	cJisuRBBtR6c7ErSnoB9ahIbgt8e2FCioR7hYS8/WtdL9ow8cwMuAL93NP6J7g175T7QBRqE/SG
	TJkeEWGbmYv9w6onNF/MPgP3Q2R94D9+aiLZH9PUBkXDIwV/L1CKW+QMk024anok1til6dAt2oC
	1eMlUYHxx1BEOCrZibp7nM5vmSRsuOGcnA2ri9tJslC+SKvNPQrEwaxFEmQ6HovA28QQvyAlfKX
	J4f0oZf/dHwLqvYw3/Px7U4Y7d3s8IcvPk6zz6phM1l+3bE1qHfKLVyzmi/6FzZwhLM6y3ILlR2
	fj1LdOJ+aOC4V8Ty1S0Q56+lVXSTL5cl9RGHt988c=
X-Received: by 2002:a17:907:e143:b0:bfe:7f45:44d7 with SMTP id a640c23a62f3a-bfe7f454612mr318576466b.47.1781515981249;
        Mon, 15 Jun 2026 02:33:01 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.77.170])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8b24457sm423422966b.54.2026.06.15.02.33.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2026 02:33:00 -0700 (PDT)
Message-ID: <78d7e5c8-9f00-47a1-972b-33b42c5dfd99@linaro.org>
Date: Mon, 15 Jun 2026 10:32:59 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf trace: Fix noise and signed formatting of
 __probe_ip in bare dynamic probes
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
 jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
 howardchu95@gmail.com, neelx@suse.com, sean@ashe.io,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org
References: <20260612225610.1326644-1-atomlin@atomlin.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260612225610.1326644-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 12/06/2026 11:56 pm, Aaron Tomlin wrote:
> When a dynamic probe is created without explicitly requested arguments
> via perf probe --add, the Ftrace subsystem automatically appends
> "__probe_ip" to the tracepoint format to record the instruction pointer.
> 
> Currently, perf trace prints this implicit field by default.
> Furthermore, because the formatting logic defaults to a standard signed
> integer representation, the kernel space memory address is erroneously
> displayed as a meaningless negative integer.
> 
>      ❯ sudo ./perf trace --event probe:proc_sys_open --max-events 1
>           0.000 ps/1316543 probe:proc_sys_open(__probe_ip: -1406056956)
> 
> This patch addresses the user experience by combining two refinements:
>      1. "__probe_ip" is now hidden from the standard output, as its
>         presence adds no contextual value for a bare probe.
> 
>      2. If the user explicitly requests verbose output (--verbose),
>         "__probe_ip" is intercepted and properly formatted as a hexadecimal
>         kernel address, restoring its utility for debugging inline
>         function hits.
> 
>      ❯ sudo ./perf trace --event probe:proc_sys_open --max-events 1
>           0.000 ps/1314074 probe:proc_sys_open()
> 
>      ❯ sudo ./perf trace --verbose --event probe:proc_sys_open --max-events 1
>      Using CPUID GenuineIntel-6-8E-C
>      mmap size 528384B
>           0.000 ps/1314366 probe:proc_sys_open(__probe_ip: 0xffffffffac314604)
> 
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>
> ---
> Changes since v1:
> 
>   - Fixed a bug where the hardcoded format string for "__probe_ip"
>     bypassed the trace->show_arg_names configuration. The formatting
>     logic is now properly decoupled to respect trace.show_arg_names when
>     verbose mode is enabled.
> 
>   - Linked to v1: https://lore.kernel.org/lkml/20260612220843.1320348-1-atomlin@atomlin.com/
> ---
>   tools/perf/builtin-trace.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index 48615ddccd93..ac15b5588a27 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -3234,6 +3234,27 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
>   		if (val == 0 && !trace->show_zeros && !arg->show_zero && arg->strtoul != STUL_BTF_TYPE)
>   			continue;
>   
> +		/*
> +		 * __probe_ip is implicitly added to bare dynamic probes.
> +		 * Suppress it by default to avoid cluttering the output.
> +		 * If verbose mode is enabled, ensure it is formatted as a
> +		 * hexadecimal memory address rather than a signed integer.
> +		 */
> +		if (!strcmp(field->name, "__probe_ip")) {

I checked to see if it was possible to include the #define for this 
constant (FIELD_STRING_IP) in the tools folder, but there wasn't 
anything existing in include/ that fits nicely. Either way:

Reviewed-by: James Clark <james.clark@linaro.org>

> +			if (!verbose)
> +				continue;
> +
> +			printed += scnprintf(bf + printed, size - printed,
> +					     "%s", printed ? ", " : "");
> +			if (trace->show_arg_names)
> +				printed += scnprintf(bf + printed, size - printed,
> +						     "%s: ", field->name);
> +
> +			printed += scnprintf(bf + printed, size - printed, "%#016llx",
> +					     (unsigned long long)val);
> +			continue;
> +		}
> +
>   		printed += scnprintf(bf + printed, size - printed, "%s", printed ? ", " : "");
>   
>   		if (trace->show_arg_names)

