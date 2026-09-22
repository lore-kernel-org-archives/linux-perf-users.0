Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26003B7B7F
	for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096658; cv=pass; b=AHy7xDd0sfPfs9nGNxikS2iubZaRFaLa9F2Kjbl9B/L84Sw05cy62S5B7ljMblvZvw+BJs4U+8324x7GRsyNqmTQZR2rSa0Q0yH/L3Lr3rzG2ozfZeLvAQasmtdzctrAu+UhsyUdVJrOO8xt4UHeyynsftFoOZ3JDrtIn31v0yI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096658; c=relaxed/simple;
	bh=N+17ejK9dvQysXp+TSqhs1pxARNJ/m/mz+8XCJSK0qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGXHwIR30GgpQJpAowNXLvm6Ma6luBrTtHJQU03TQj61HGDjWfEmm9azW5oQ1L8I7mndzu2cVIYV8MGBF8rdLfM4GOtnyHVTTQUU2EM+Ibprs/yWKuWMtrpAh2UJ8fCtz0kFYidMyc/gv4Gh9jkSHfzE9ftX4HgyT7+LRx2v+Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sM16Gjb1; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sM16Gjb1"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so3918966b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 22 Sep 2026 10:04:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096655; cv=none;
        d=google.com; s=arc-20260327;
        b=bIonpFBtFDinJrSttwc2J580NtsS85+W58DvYorUnV//6fVsHGHMIM53PKGimouN24
         JRZim/bvCo8vp0mUR0mW7c7RD76Ct23LPOLgvtFiAZIzc0DkD4nRUSM4vOFlGZg7ky1V
         XDiKX6NCJ1umn96QNO5SaaL09fhpCFxEhKwqchrrPaVN05GRibIQiY9RqbvcK2aS1WFQ
         GYRsuX8cSCYPKsq4/ahu2WjKc3OIFRDx6obL86TF/3Byq4XtSxT6ExEla6ceH0nOHMQH
         L4XA6yhKnI8BLAJJENsejsDH4+JO3F+F1HqO4LlqJ8xjOthx4isgcHHXoEz2YZpsyJe7
         wtsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGbbuTvPUpYX589X/WoOVAkQ+2julwkRlp6p5cd8Vfk=;
        fh=OOYVqcZxxq3HRPsMOuJfDfDawwt6jagmaX39g7SQEEs=;
        b=IRT3A2RzykzfGodVhpBz3wlFr6oVvd+ysVCNmZ+ib4DM3fXN1HobGZv8QLCdfIEcyg
         kUp7N37HQjwxXO3Nfw0CaIuOc5Ui7s3No3mIaFBNyG02LBOg2KqChtYLTuyM6RIi+urs
         /DW9Wcws5xJ33Lps+JX2mo03MEhH1vtK1Pj3B2Fn/nk5sR85LomODR2dbkRX4hZ9tYav
         2ilt1avzwTHFdfN4GbTwrMj/ADFRX/4fhzTZ1rq2h/CcYi4nuGnI8qBZf9X8kt3c07Kr
         DdiMBwkCX6gQdgLmLCriyIckT8YafqvGlHPPfrmzIVjPH3HC4uXQFF2+j7frfBf1GCz+
         Tmcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790096655; x=1790701455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oGbbuTvPUpYX589X/WoOVAkQ+2julwkRlp6p5cd8Vfk=;
        b=sM16Gjb1e3nmHp7IskfEOeODGbUR+Y6v2azrZjXY3HMTjbSEHTnuVb07SRdy26HsPl
         z7cOZY2AMug14Eizx0fuIqNShMdQwcQ4pYXLSSq5zk9OoSSRBdRfSxUqsWxn8yycBA/5
         iwyxeFny7aSP/QrvsaFy6twfOzyQBxHSA7FM2tkwam3Dv8PxA01gGCuUL+wN1LI1ydD6
         d2/6BlXCjIczjckzDB7qF8Pr8sy9m1udCiYLp3bli7IoXsqUyYI3ytiBitRR8u4VNEPv
         Za+rKg/csx1ewWQ+UwZgnhVvq54wMrhF3Bnrp6RmRYeQKSsccZJXyjbqzXFH3eRC1uDd
         J6UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096655; x=1790701455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGbbuTvPUpYX589X/WoOVAkQ+2julwkRlp6p5cd8Vfk=;
        b=YafpOshoZgXlMAar9C7YsbKqNknukW8pQO4sGAGwvghFuUV9tLkfoW25s726W1hYj/
         HmN7LPyFtyGFT/D1A6cg7z4Kv3W9izC3/y96VAck1hO02wgKn3Sum0Zz9O4oIhDqoHhv
         a+b3MJs321dh4HYgwG4vT7IOCBuuPQHU5EAUE7L0Ew3ucGb6SE+RZtD5l9T///BmXymk
         nakgqoK+Od5udPLMk6mR/bzzv/LF15ViOVYsqAypF6io85jtsmg+c27DzXG2lHWUPkiF
         Rs83nl1vopH7cQ7+zewltblLfj9zIHp/I6V08/0/OL+3417ispFvbfLXc4W26vUlsS2o
         b/hw==
X-Forwarded-Encrypted: i=1; AKwUvBy/9JFa3w+BxxD4cm1wQZZLh4yPdx0GjN4qL4x0hiP/gGVxHwa7FJtoUEUykF5Qu34XUetnSZ1n9l/KKWp1oCSc@vger.kernel.org
X-Gm-Message-State: AFuF++nmfCnqskGJGsD/l+xjzE4V9DKtqiKvqMv8iYNCQL++Qo1dk2b6
	+kCGGX2ukD1q0MkfFSjydG4R067ecgbmOE7nuWOqXE8SPHDxe4X15s8UZsizM+qrDKH1XM9MK4L
	HuZHVWlKcI2JXzM+MXdtC5ST0r19q3/Q=
X-Gm-Gg: AYBFou2ZQ+v1INZL478cDr+tRKAKiSL1aQb9ZlPP/aVffkrCvZodFYFfFB3E2iBZpjB
	Vx/i34NbBzyhouui6ldSLafX+TJsLc90CXT/Ir0b3ys7kAB7O9c3XJm6u4oByP6F7FsfcR0r0Pw
	zaSR32ErpcmzdWGyijNBSDuZCpZOlvk1KMqeWIdz5OAkAiJhY0tMF5lLELo0MR050UY9f8aampJ
	rx3V9/i30+vRjsZLbT1k2ck9fYmAktL9Gv0btcD8cUxhb/H2y6VSgMFMlqkRWuw2XQmufs7rjoe
	k5ivFqczUFFc7JPelMu1UsPsN7SPzXQbIJ1mOaTApEuTTxFLUdOozRSC7OWyIghKSt+X6HGFXGr
	CUA96p8hTwFX1VVDEhm+MkVV5ERxul37+0ugKrRr+
X-Received: by 2002:a17:906:794f:b0:c24:87e3:b8b8 with SMTP id
 a640c23a62f3a-c2a1569a558mr1259266366b.17.1790096653404; Tue, 22 Sep 2026
 10:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922135653.1622301-1-stian@itx.no>
In-Reply-To: <20260922135653.1622301-1-stian@itx.no>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 22 Sep 2026 19:04:01 +0200
X-Gm-Features: AclHuK_CUEgpakuA9mXaxlN0HtfMc5v_kwsh8oph45ybTZCltYVIkWHGrzXcUdc
Message-ID: <CA+=Fv5RnsBXnxb2JHfZ2kXkYB7fz3KLS3+oHtx==z9W93WRANA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] perf: user stack dump on sparc64 needs an arch hook
To: Stian Halseth <stian@itx.no>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stian,

On Tue, Sep 22, 2026 at 4:38=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
> I am adding HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP to sparc64, so
> that perf record --call-graph dwarf and elfutils' eu-stackprof work
> there. The sparc side (patch 2) is straightforward and follows parisc.
> One thing does not fit in arch code, and I would like to get the shape
> of that agreed before sending the rest.
>
> The user stack dump copies the stack as it is in memory and assumes the
> call chain is there. On sparc it may not be: the sampled register
> window's %l/%i registers, which hold the frame pointer and return
> address the unwinder starts from (the CFI after `save` defines the CFA
> in terms of %i6), stay in the register file until a window spills. The
> kernel already deals with this wherever it exposes user stack memory:
> perf_callchain_user() on sparc calls flushw_user() before walking the
> chain, and ptrace does the same. The stack dump has no arch entry
> point where that could happen.
>
> I looked for a sparc-only way and did not find a correct one:
>
> - flushing in the sparc PMU interrupt handler misses software events
>   (cpu-clock, tracepoints), which reach perf_event_overflow() without
>   passing through it;
> - perf_user_stack_pointer() is private to kernel/events/internal.h, so
>   the arch cannot override it;
> - perf_reg_abi() is called at the right time but is a query, and a
>   flush as a side effect of it would be wrong.
>
> So patch 1 adds a no-op hook in the style of perf_arch_misc_flags():
> perf_arch_prepare_ustack(), called from perf_prepare_sample() when
> PERF_SAMPLE_STACK_USER is requested and user regs exist. Patch 2 is the
> sparc64 implementation and its user. Happy to take a different name or
> placement.
>
> Tested on an UltraSPARC T4-1 on 7.3-rc4 with a perf tool taught the
> sparc registers (that patch, and the matching elfutils backend, follow
> once the hook is settled): register values check out against known
> contents, and --call-graph dwarf unwinds correctly for both cycles and
> cpu-clock. perf stat/record/record -g are unchanged.
>
> Link: https://github.com/sparclinux/issues/issues/99
>
> Stian Halseth (2):
>   perf/core: Let an arch prepare the user stack before it is dumped
>   sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
>
>  arch/sparc/Kconfig                      |  2 +
>  arch/sparc/include/asm/perf_event.h     |  3 ++
>  arch/sparc/include/uapi/asm/perf_regs.h | 33 +++++++++++++
>  arch/sparc/kernel/Makefile              |  2 +-
>  arch/sparc/kernel/perf_regs.c           | 65 +++++++++++++++++++++++++
>  include/linux/perf_event.h              |  7 +++
>  kernel/events/core.c                    |  2 +
>  7 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/sparc/kernel/perf_regs.c
>
> --
> 2.55.0
>


Very nice series, thanks for working on this!

I built and booted the series on a sparc64 box and haven't
noticed any regressions so far.

I also smoke-tested the new interfaces from 64-bit userspace with a
small standalone C program using perf_event_open() and software
cpu-clock events. The register-only, stack-only, and combined
register/stack tests all passed. The test does not use tools/perf or
request PERF_SAMPLE_CALLCHAIN. I haven't tested end-to-end DWARF
unwinding yet.

I see that you plan to post the userspace changes once the hook is
settled. Could you include the tools/perf support in the next revision,
or post it as a follow-up or linked companion series? Having that
available, along with a link to the matching elfutils changes, would
make testing easier and let us exercise the intended DWARF unwinding
use case directly.

Also, could you update the sparc entries from TODO to ok in:

  Documentation/features/perf/perf-regs/arch-support.txt
  Documentation/features/perf/perf-stackdump/arch-support.txt

Those updates would fit naturally in patch 2 alongside the
HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP selections.

Thanks,
Magnus
