Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60753AAF53
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787007143; cv=pass; b=HZZ8rj3qklPD92jfnz1+Sz4yKtJHngHASny9BJ9vG/9CKyWYr8ZKx70KEtqcdeLjLTSak9c9Yu1Gx4RNyMlEIxjAqQTd8rd+6XBcaY4hMbTLn6GeQPgNaopdjrDA9Zb86WLW0DqdpJIkdjhsnpDYS2mlb6WEcBMWdtWPTU9grDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787007143; c=relaxed/simple;
	bh=IDN0RhmLfXL/NR+L3eTNp0ii/CI6L89Fx1IyU33CCVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9bSVgr5TvZt8upSzlFN3cm93KoKa1fdVVKXiHhlsjmm9jRxPfWAAqf0l9UWfOEd1gttuIcUI5kS02GFXB+XIjoLhsOyYR6GYWGQ8vlk/bxsmt+TDqC3ReiCGaRZEcl0A9oK6oExcerlZKIn7OqCJ+/RrbcwdFU5B7aKIDiAn6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QlrG1qOl; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QlrG1qOl"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51c01c79467so111131cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 15:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787007141; cv=none;
        d=google.com; s=arc-20260327;
        b=JMRVcm8DXgcgINM2Kn9H67+EXuZ+36hMy6D3vHT4PQ82/yPiwcLemkfLffvFI2mwUQ
         aFdyKhdw5+35lhXmW+tDw6VZwVEq18Ozuxheo0lfSxqCDeEER6B1hL/yWclnHUV10cY9
         cWpY32Nyv/yZrjezjn59HOFEOKWCJJJSPswufCcET9nZNZCdooek7yGVyZFU5rzKcx0i
         52kgQjEiBxst1xUrg7S6WVYsYNRK680xN8nhZwGr6FMaFFift7uGRESnCTUOTwN+rJ5b
         JKaMIpHw8Dk+MQTl21Q6NTMr234DjwPCv1IUhpbW4eodRpeEfWFxYZ/RpSkwdaUJAYv8
         VUKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1E2Di91Pd2dW0/CjgKKxHMB0TW7JiX2JxNLB5Qrq/SU=;
        fh=W6Ig3H/FaasXAgA6lMpXj1NJgW9fDmpf20Tcr3IBJxo=;
        b=i+qQ2HGTKLf9T2T9exlGduaY8l1X76dIID7xB1ZjyxH4m4M4qWq/nifKdWhWsk8NbU
         Co0zrvppRzkldzZO1Z6Z/2hBWTpG95xGcqePd/WerlGbfrcIhMHfcBVsoDUQHvrjRvEj
         kLuNpR6RZLcumWBWXd040PKaZXwAxld5NQs+aVWz2u/yHGlucrK6AyKs7UnjErytu0+3
         FQ1YFMVnqswctNXFo8OJdv2maBw5uEiR9bPT+9bC8VCZYaUjaemPk8Fc87j4IVcYaPax
         /cbWxkaGtBdTkV1sg40lk3TeYJCHo3ZNhxX+UjoyRQ9vzMG5QYb35C1wGpl4BNW4RP3E
         EHUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787007141; x=1787611941; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1E2Di91Pd2dW0/CjgKKxHMB0TW7JiX2JxNLB5Qrq/SU=;
        b=QlrG1qOlt+7x6zzgiofzid6852W+GW6XGEHEQyMVD7A1Ci4bRsrrOhQ97+FuuioDrH
         GTSz+mV5xzGJBdEUY3uoryogGHxgu3H0ClLr4zrmuXtcAA+ktlDbG5bFqGrKWhvPDGWq
         9N8CNQrk4TPghIrqUFtpZd+ZyuAxDdCeaUk+8FJJqo29tGENiMpNlMPhhoqDAEpoFz0n
         O9nDwEB309bqbtbLbgE0P0D/ZqmXpFOMTm2gd0iv3NPruXAjKYF5rAfZ2kSFx7CefmTJ
         gN4qf4eda3YmD9oE1MgUz6abGSTrVZ8vbDuq013s2kWlrBFBdaU5UGfKyPMtAXgkiiBP
         68PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787007141; x=1787611941;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1E2Di91Pd2dW0/CjgKKxHMB0TW7JiX2JxNLB5Qrq/SU=;
        b=kLT++DxHN6CfkJvRIIJ1ZiloBw2Vq2KjlgvIsG+lmiO9nvlnnP4utjPPAs6UVjCmGF
         fRavEthGuET/8rmCz9ht9a7V3RSjt89/LJUJnS+yneraxE1oFKe5zP6a3d5OLd2LzpnX
         Gbx4Te08/QbocFDc8zTG5b+OrJlCYK4lUAvRjgGCjX/JGNwvmKqn/c9cjVRea2EsgCq5
         U8RmBOQTJRNOHKFF7mfAuoV08TLm4WCC1b7t/HwaX6tAZxggzinT9xSqxhz57TETuQvQ
         me4jX9gUTjwIrd3kBrfLlZUJOKY+n8EWEMSbLgbyht59N46EsA728m+V5QXMzjtL5Ofc
         CsCw==
X-Forwarded-Encrypted: i=1; AHgh+RrAiY72skJASc8IXSPS8L7J/h0dvlYYUQfK1l80ffevBSz9F3AQ9SZYW1VDYzUWjUhG67qA6jF2S771dOYBgX+s@vger.kernel.org
X-Gm-Message-State: AOJu0YwbR99yJNdePChKlvVbM+AfgQAakcyrJsK0zpfCd38vu8v5K64X
	DHUyyhgITRBkMW5X1jgtdSW47A9ajCJkSe6WBRLjHNRwVjLKeTdBuvdTNVM/WIGBllvhy8y3DXk
	3JwNlkA0UggyEx3xipdXWJv8AG301Wp3YfNiEJp6l
X-Gm-Gg: AR+sD13Cy/z7+DbdFb600M9DU6265yWYU2zsHgiz2gTXUx3r6U1bKMIWXrey5OZ+Z4e
	wbTq6v2bOnjS2mcrTbhBT2ZIQsdnyhSzVt9ac/y8RrqrE3J5CC3VDw1jus+ynN4A0z69N+Axagl
	pNVjkhEXxsla2RXYozAd4nJOc8QS/pdu9WITF8brsh0il9AgKDwsdcp8eOGz7UKXxbK8hoWCwsW
	V1PWFdZK5GRNWYaIgVmdgBLa+fCZl1c98+rcxMYwETGSQyt0dA/eZb3IdfyakGYbKYEMHlEBgJm
	NaacuEPXb2QFSweNe0P9X18lpu1QOzU+5n8iq9j/hG4UdKGt7hetuTobgkAgI5KTtxZVmeXEekN
	NGoxg
X-Received: by 2002:a05:622a:4107:b0:52b:806e:2633 with SMTP id
 d75a77b69052e-52dc4707faamr263711cf.1.1787007140272; Mon, 17 Aug 2026
 15:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816205921.576365-1-atomlin@atomlin.com>
In-Reply-To: <20260816205921.576365-1-atomlin@atomlin.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 15:52:07 -0700
X-Gm-Features: AcwNN1XPogMSbX5fL3avec2lx8pEVTFSgCvAHF_elBNxkbBwuAHpkFEHUpHR_SQ
Message-ID: <CAP-5=fXfpP_GN=DqeOMrrLUyy6xJ6GEcVo0TVkej9f0KTPfK+Q@mail.gmail.com>
Subject: Re: [PATCH perf-tools-next v2 0/4] perf trace: Symbolise kernel
 virtual addresses and function pointers
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	howardchu95@gmail.com, neelx@suse.com, chjohnst@mail.com, sean@ashe.io, 
	steve@abita.co, rishil1999@outlook.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 1:59=E2=80=AFPM Aaron Tomlin <atomlin@atomlin.com> =
wrote:
>
> When inspecting kernel execution flows using perf trace (e.g., when
> monitoring workqueues delayed work items, timer callbacks, etc.),
> tracepoint payload arguments containing raw kernel virtual addresses are
> currently rendered as hexadecimal values (e.g., 0xffffffff81234567).
>
> This requires manual symbol lookups against /proc/kallsyms or vmlinux to
> identify the underlying kernel function being executed.
>
> This patch series enhances perf trace by introducing kernel virtual
> address and function pointer symbolisation using perfs native symbol
> engine (i.e., machine__find_kernel_symbol()).
>
>     Before:
>       workqueue:workqueue_execute_end(work: 0xffffffffab2f1420, function:=
 0xffffffffa8046b50)
>
>     After:
>       workqueue:workqueue_execute_end(work: 0xffff8ac2c420f270, function:=
 wb_update_bandwidth_workfn)

This looks great and a test! I noticed Sashiko feedback on patches 2,
3 and 4. It looked appropriate and actionable. I'm looking forward to
the next version and testing!

Thanks,
Ian

> Patch 1 introduces the syscall_arg__scnprintf_ksym() (SCA_KSYM) beautifie=
r,
> which resolves virtual addresses via machine__find_kernel_symbol(),
> formatting them as symbol_name+offset (or "NULL", with a graceful
> hexadecimal fallback upon lookup failure).
>
> Patch 2 updates event format initialisation in
> syscall_arg_fmt__init_array() to automatically assign SCA_KSYM to
> tracepoint fields typed as function pointers (such as typedefs ending in
> "_func_t" or "_fn", or function prototypes matching "(*)"), as well as
> pointer or 64-bit address fields named "fn", "function", "callsite", or
> "call_site".
>
> Patch 3 extends BTF pretty-printing in trace__btf_scnprintf() with
> btf_is_func_ptr() to automatically traverse BTF type hierarchies (includi=
ng
> nested typedefs and qualifiers) and route kernel function pointer argumen=
ts
> to SCA_KSYM when BTF metadata is available.
>
> Patch 4 adds an automated regression test script, trace_ksym_beautifier.s=
h,
> under tools/perf/tests/shell/ to verify symbolisation across both default
> kallsyms and BTF routing paths.
>
> Changes since v1:
>
>  - Fixed reference leak of struct map in syscall_arg__scnprintf_ksym() by
>    calling map__put() prior to returning Removed unreachable and erroneou=
s
>    entries ("action", "callsite", "call_site", "fn", "function", "work")
>    from syscall_arg_fmts__by_name[]
>
>  - Restricted name-based SCA_KSYM auto-assignment in
>    syscall_arg_fmt__init_array() to pointer or 64-bit address fields,
>    preventing misclassification of non-pointer integer fields
>
>  - Updated btf_is_func_ptr() to fully unwrap typedefs and type modifiers
>    below pointer targets
>
>  - Fixed BTF type name matching in syscall_arg_fmt__cache_btf_type() to
>    handle leading modifiers and strip trailing pointer asterisks before
>    lookup
>
>  - Synchronised arg->val with val in trace__btf_scnprintf() and widened v=
al
>    to unsigned long, fixing erroneous "NULL" output
>
>  - Added shell test script,
>    tools/perf/tests/shell/trace_ksym_beautifier.sh, to verify kernel symb=
ol
>    beautification for both default kallsyms and BTF routing
>
>  - Link to v1: https://lore.kernel.org/lkml/20260815233651.527936-1-atoml=
in@atomlin.com/
>
> Aaron Tomlin (4):
>   perf trace: Introduce kernel symbol beautifier for virtual addresses
>   perf trace: Auto-assign kernel symbol beautifier to function pointer
>     fields
>   perf trace: Enhance BTF type formatting to symbolise kernel function
>     pointers
>   perf tests: Add shell test for kernel symbol beautifier
>
>  tools/perf/builtin-trace.c                    | 103 ++++++++++++++++--
>  tools/perf/tests/shell/trace_btf_general.sh   |   2 +-
>  .../perf/tests/shell/trace_ksym_beautifier.sh |  52 +++++++++
>  tools/perf/trace/beauty/beauty.h              |   3 +
>  4 files changed, 148 insertions(+), 12 deletions(-)
>  create mode 100755 tools/perf/tests/shell/trace_ksym_beautifier.sh
>
> --
> 2.55.0
>
