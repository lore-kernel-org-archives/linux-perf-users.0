Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B4B40DB5E
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 10:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785320467; cv=none; b=R0o69Gp+ZlibkYGcbVJDXjDtet2y4o3GW18XReoccsiMSMHR7dOcJ1ieWlnHnGumjnnOGlD5NDp2l8aoozDEbpjDMKKDZbXI64J1S4Y/RATwuTPgHD22SSphBaU65Ka4K0MWlB3JSTW4A6yuh1MR0Abh0DHzZHGZdqiVmUtYngI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785320467; c=relaxed/simple;
	bh=lm7HkwRtfaKPxRJmndAb593LB5pEPAaiQkeDKCHyS2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxHN4uBLHQ+LhtNLfAJMj3cqVG0yM05ITVnrGRT/rrCJSNtBHclBj2fXlYNtKngyA6xGluwcafITEhYQ6Cgt+KUGJG8T4ytV4vTld48zK1q71W9AynW8TK8X2+M/1k+5Z5G9ShEEeWpRtmt4nx71rYlvEsGPgSpmYvs8caEw12Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aid9Lx7K; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aid9Lx7K"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so1247103a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Jul 2026 03:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785320464; x=1785925264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=woyG06gmH+8jnzwxUeoujoEkRkTWjBa9EBmmYnPEOuc=;
        b=aid9Lx7Kqmr5giGIjdIKz0fxaEFNlfzJ2jbFSoRAzLLCh0enHmWSs5vBhDLURRd+O9
         UFhwcZ1Z2TFq6wG6yYOQz4XETfhdX3465CNi3vSh6JTKcwcoLH7vAByl9k7HbexC1ea1
         /5D0+50Xbji5+UsprF29HGOtedczS9207s0enUhugcSMTZ8BJtLURStT9ZJkKnBER1tn
         JStHvzIYZSFouMyAND19d9SUkI9MOGurgVjw6TYh/1T+U4m25XtRTLzBQVcDjTqDfumV
         UFdSi8IGU9DbNaCHpP6v4dC+Ib1fkzAcZaUevX7w919gyuXPBDKRsak1sIiFu/CNfSV9
         LOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785320464; x=1785925264;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=woyG06gmH+8jnzwxUeoujoEkRkTWjBa9EBmmYnPEOuc=;
        b=P3R1yz2E+9LKuAjd7pSh8C9l3fYGC6rmMTaeaNDOPkh7QA/XdvgDJHIpmo+zSbcjO2
         2r65jthaIErqYEEAC1RVzhX1dGrY3ywIrO2Fja4mIHxvsZef1XzI52Xrmk2c3jdn8Ega
         UeSLyXu5pFHVD3VMJQw380jpchIblkFwyRKOAcyu+s43FV47NPhdFHZc/fXu6bbsp1n/
         eSGNTZrCZwU+oK8YBdwtyRMbYDHWJXAWk8TBtU516OGTu2deWDlFLXNe80vyV2jzapnB
         JFApEcIuR6hx4guJVioF4h8inZtA5KQ/23zBPKdG2Ji45OuwrzV0hLjTpwZQMXKQYIWg
         oX3w==
X-Forwarded-Encrypted: i=1; AHgh+Rp0DluAg20DUkkJOkxvHJiAlX5tLgS171G16OQ+YB0VVWYwBl+gyDLnceCtZIjD8ZZlvdBCG/daMAM7WfnCnBNq@vger.kernel.org
X-Gm-Message-State: AOJu0YxhE2O2IyonTSed/MKITgDiP4ieaWeffYhsFW68L2rYNEmf2Glv
	rhsPPoebLgMb6xlvAPp06ts3Ftx1gacwr/2gB3YtjWvQ1NfJcRdXaA5o/H7yc1ZOCUk=
X-Gm-Gg: AR+sD13dM0OYtqgTXTI3P9HVS3A/lJ3xMI9eWDRlAI2pRLQJFjscJf0eh0/4YgInlJY
	zXfRxhjRoFHDaYWEqGpmY16roudBE8cKT/1/8kKO2KdPpgm6kMhfOXVXIAHrSze94vxUZB/odkD
	576t+eo11pyc2JNG/bBJ+TDPRZhnWBBRk2SMZ0nu87m6s2TiLW1Vh95sivCGoUD4X8WtUabZiP3
	NsbYBqMke2RsNOT10PYQxqNWOr/JlAQPi8R+WHYC5jNrjQbxhewPvPlr8TKpEiKSNUlraibemGv
	wCQYksNfQ+w7FzYLfs7idpd2zJ1vNnhCu9HVj8XI/mmnypFAE2b7/wWtC/mFntC7hxi1Y6rNTx3
	L0srVhDeqRL299cICwOWEPnyIRhyTX4XmoZCtOCXqd76prSl2aeIPqcPpwhXBhJiGcWc2uCekv4
	/Jz6AXPbxhg3XwzBTaISP1U8xkzcYV+ItzjTSBlKyiTSgIRJyED7KVxBExawVx7CAKsA==
X-Received: by 2002:a05:6402:430b:b0:69f:4b71:41e7 with SMTP id 4fb4d7f45d1cf-6a0349eab87mr3375108a12.8.1785320464133;
        Wed, 29 Jul 2026 03:21:04 -0700 (PDT)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf21sm651510a12.21.2026.07.29.03.21.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 03:21:03 -0700 (PDT)
Message-ID: <7d980402-84d0-4cef-9bc2-af8fd5e13224@linaro.org>
Date: Wed, 29 Jul 2026 11:21:02 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] perf libdw: Fix outer-frame name resolution and
 spurious "(inlined)" tag
To: Michael Liang <mliang@purestorage.com>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>
References: <20260728204215.327318-1-mliang@purestorage.com>
 <20260728204215.327318-2-mliang@purestorage.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20260728204215.327318-2-mliang@purestorage.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 28/07/2026 9:42 pm, Michael Liang wrote:
> cu_walk_functions_at() calls libdw_a2l_cb() with the containing
> DW_TAG_subprogram DIE first, then each DW_TAG_inlined_subroutine
> nested inside.  The callback treated both the same way, causing two
> bugs:
> 
>    1) die_name() returns the unqualified DW_AT_name, so every C++
>       frame lost its namespace/class prefix (ns::Class::method
>       collapsed to method).
> 
>    2) new_inline_sym() re-uses base_sym only when funcname matches
>       base_sym->name exactly; otherwise it fabricates a fake symbol
>       tagged "(inlined)".  Any mismatch between the DWARF name and
>       the ELF symbol name mis-tags an outer, non-inline frame as
>       inlined.  This hits C++ (die_name()'s unqualified output never
>       matches the demangled ELF symbol) and it also hits C functions
>       that GCC IPA-cloned (foo vs foo.isra.0 / .constprop / .part /
>       .cold), since DW_AT_linkage_name doesn't reflect those renames.
> 
> Fix both:
> 
>    * Prefer die_get_linkage_name() (mangled, fully qualified),
>      falling back to die_name() when absent (C, extern "C").
>      new_inline_sym() already demangles via dso__demangle_sym().
> 
>    * For DW_TAG_subprogram DIEs, use base_sym directly -- the DIE
>      tag already tells us it is the outer function, sidestepping
>      the name comparison entirely for both C++ qualification and
>      GCC IPA-clone renames.
> 
> Fixes: 88c51002d06f9a68 ("perf addr2line: Add a libdw implementation")
> Signed-off-by: Michael Liang <mliang@purestorage.com>

Reviewed-by: James Clark <james.clark@linaro.org>

> ---
>   tools/perf/util/libdw.c | 34 ++++++++++++++++++++++++++++++----
>   1 file changed, 30 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/util/libdw.c b/tools/perf/util/libdw.c
> index d5d2958902c0..4ca7e7e4fbe9 100644
> --- a/tools/perf/util/libdw.c
> +++ b/tools/perf/util/libdw.c
> @@ -82,13 +82,39 @@ struct libdw_a2l_cb_args {
>   static int libdw_a2l_cb(Dwarf_Die *die, void *_args)
>   {
>   	struct libdw_a2l_cb_args *args  = _args;
> -	struct symbol *inline_sym = new_inline_sym(args->dso, args->sym, die_name(die));
>   	const char *call_fname = die_get_call_file(die);
>   	int call_lineno = die_get_call_lineno(die);
>   	char *call_srcline = srcline__unknown;
> -
> -	if (!inline_sym)
> -		goto abort_enomem;
> +	struct symbol *inline_sym;
> +
> +	if (dwarf_tag(die) == DW_TAG_subprogram && args->sym) {
> +		/*
> +		 * cu_walk_functions_at() opens the walk with the
> +		 * containing DW_TAG_subprogram DIE (the non-inlined outer
> +		 * function). That's just the base symbol -- use it
> +		 * directly. Avoids a fragile name-vs-name compare in
> +		 * new_inline_sym() that misfires when GCC IPA passes
> +		 * (.isra/.constprop/.part/.cold) rename the ELF symbol
> +		 * while DWARF keeps the pre-clone linkage name, which
> +		 * left the outer frame spuriously tagged "(inlined)".
> +		 */
> +		inline_sym = args->sym;
> +	} else {
> +		/*
> +		 * Prefer DW_AT_linkage_name so C++ inline frames keep
> +		 * their namespace/class qualification. new_inline_sym()
> +		 * runs the name through dso__demangle_sym(), so the
> +		 * mangled linkage name is turned back into
> +		 * "Namespace::Class::method". Fall back to DW_AT_name
> +		 * (unqualified) when no linkage name is present, e.g.
> +		 * for C code or extern "C" functions.
> +		 */
> +		const char *funcname = die_get_linkage_name(die) ?: die_name(die);
> +
> +		inline_sym = new_inline_sym(args->dso, args->sym, funcname);
> +		if (!inline_sym)
> +			goto abort_enomem;
> +	}
>   
>   	/* Assign caller information to the parent. */
>   	if (call_fname)

