Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FA1305685
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 15:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561201; cv=pass; b=oe3QAO8WoqrH7awRLRHIypnH5qUkqFf1DUCz4996pEjqTS/gvX5ZPYsfzRUfVs5150/KPnxnCKopNygVPlLO5emoa22X/5hZRIywphESiSd6JxgU5H5jvAfMNZWBa4RZlqHqfjs2Qw+36jPQ2mbyhDi7H/JhkYS7UuCaUc4znH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561201; c=relaxed/simple;
	bh=wIOvE9E0izI9cWeOHA+3iIQfg+0GMdGrx8Op9HFx2UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awZJ7GAYD5A6cuWzJqQ7w5lJkBr7hejasScyKen3utzm7bn++O94/ml0bo4T3covC9tB9KLBKdBv6J1VOv7XVlOMpMCZLGYy6W750ur9A441P+RztM3gzfkKv6NLnkQkq+lc3nenRe4w/+XKZik/MoAMJVCHJvPEW74F+0zsFr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ba4Ml1me; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ba4Ml1me"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38511175ad3so8404314a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 08:26:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784561199; cv=none;
        d=google.com; s=arc-20260327;
        b=N0arxmBRpr1UE2YVaER/F/jrJeyekTAH5q0UPePX/T1fslBLN+/rmr2dTTGiMolwEr
         lBq0BERa8rDnPJu6X+udvTbQQepzJg4BJ/duz+jiznLnjew1vHiyXy6rvWhl/hWf/y9U
         vwgGnlCWlRagFpuJBVWNkZBALW7RcQZfnCL95oR0lfR/eNQ/LevIuUw0YeW+DpJV8XgL
         ZOFQWfK/mA33+jHwkRm6xxeFqASD/JPl7efXNGSfB2CaEOGuXYWIN0J2ftNBeFsJSr9i
         lV16BGli4Tq1Sa7cmZCgxvCCfarJY7DIKyVZ/kMCUunlfzs6fd9Bn8h+Xb/ambPcPMnS
         HeJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ppRDMOFJLBPX6KQmdpRBZE7SlCyjKiRE9PJURFV6vac=;
        fh=g0Q/r7UQO/q3ab3RNiKZgnsLkg3H3WzQyR1Qn65iMm0=;
        b=fsoq7IWIP3IMqOfGqoLXNwXqAbrMmPCNR31V8steKK/H3PAuw6Wk5RQu8nmOslTCz6
         F5HzKZGJuw3yPG8rV1vN/KgILBZTt6sZWi78E4dHKmPPf4aOErW/NRcnEQ+1irTSi4Y2
         lOxUINyYDiUvBeeEk553xICoq01FQEDBp/9g+PYKicTfaIKpEhII/Zd9MV+P51HtVMh3
         xuuIysAE7xhr6KBUozZxMOUcutDA77k/S+M0FyCNAOsu5RCVnAQSGKZyLKWza5EwduPe
         5t0WwSQdHrKOtY66KhWEXj96tPniBnmA5j4cQIYh0/92/gy0rudcFhcrAnNLeOkQhaNF
         kULQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784561199; x=1785165999; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ppRDMOFJLBPX6KQmdpRBZE7SlCyjKiRE9PJURFV6vac=;
        b=Ba4Ml1meU+f8hQx5E7xBzQfzR54adJTUrjyObOe+IhEMGfLg+somds+EE/q0qrjPyJ
         VQ13pmoUsX0eMpjuHUjh6C4/asZe8ZAiDoXn7RKBRBbDbhUEkfP0UVFcJebQG5Bs3Izv
         Nucy7cAlKENnXpK85SXavSbpJu5FG+uPwO/Gt6Rx2IDMCeJZJmazPcNOwbUrEWpPsEfP
         HSki5K8BRujHqfuMMl2xbIrYAwqwDO6x5g67BvOGALIMc6qQGvhvoPUMTXzfp+70h/z3
         fVVreq98AbcZS3YtGhpP/+tT5usccQGW/x6eBQKD9QbcHn5ArmS93J5MMfuTuxa958Z7
         QGkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561199; x=1785165999;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ppRDMOFJLBPX6KQmdpRBZE7SlCyjKiRE9PJURFV6vac=;
        b=d9kNXAnQYA//q0S/lNiAoQ/EHDBlQazu8CjuzGairEInBHOHpyZK3bj3S/lqZJUaLQ
         fbbqO1uYkbQhxYshes04eNLN4CvtLUB54Ne9liiBU4aSbrEil8CLrtpLM9HLK6uf79x5
         97BiSaSGwGLCss5Jkm4N8u99SJUCqwoP61WeQlHrd01rRcZrCZLBDsjCri1Q3knKhhbw
         BmHjswFXzVXz1iX499Q198nsA0WB3WVkQ8iCNae6nZpskNVxwqnuxFFdTGyCuHROhTJt
         5V49iKT0jdEvyx0bVNPkJcMYMwPoFjGTzgYiOxApgZI+LmGVlzAGREx6pAYJoVle2iqC
         hpSw==
X-Forwarded-Encrypted: i=1; AHgh+RoouC6KNc6IrG1otVidcfQd4/NyOkcjjudLpcSaHRnMONqnEJwOpCTIXqjIHpUQ/e1Lx0Qk/yUrmUzxkG8Tp72Y@vger.kernel.org
X-Gm-Message-State: AOJu0YyaVXDwE7u56oywFsDXQJf9vRRORlKg7Gz4fUEL5RxHZl7CyzPp
	g8POOKs57eSzNShFrn544mED9EUt9Nke/+RpLEstlgmBQH9n+dyx9V2FaXTHijUWNjmzt1Jc3Ln
	4mR6l+L+nP7gAV+Wwm52y0Giw8oZzIRe9lIBagOA5
X-Gm-Gg: AR+sD12lHtAl4uSlUI3zprHq+hJkW87pBrkdDFZQrVvSHAn2KoLEs2KsK7TZ8S/Ux1Z
	nMVrCsD5risGEdPwEFyW6Y5VWZYEIIwV/qWk9lgGzzOww6Ugv0CadgaI4BpAazJ/txuOnPj7yz8
	wGt+rzRQ9u0dYSqfM0Wf/G0n8MVhnHL/eOb47+l4nIppNI562mDBrXm6m0vS7cdzQfFwebbG0pe
	Dr/49FFvH72ypkVgz0aEmuoe7iJgh0RXTahA2JsSH+aurl2R2ntwkENv55XSvBixSV5ywZf6hCN
	prnMPpbx9AHDUpxXXq6FeMOQdw==
X-Received: by 2002:a17:90b:580c:b0:38e:2524:724f with SMTP id
 98e67ed59e1d1-38e4b410109mr15364918a91.12.1784561197991; Mon, 20 Jul 2026
 08:26:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717125023.1895892-1-wangjinchao600@gmail.com>
In-Reply-To: <20260717125023.1895892-1-wangjinchao600@gmail.com>
From: Marco Elver <elver@google.com>
Date: Mon, 20 Jul 2026 17:26:00 +0200
X-Gm-Features: AUfX_mytGrClEjUL35sTA01mL-vDpdcepD52IC2sE_eAPBJUPR35g0y1m7pBRLg
Message-ID: <CANpmjNMpKXxk2KsZORakwwdOpDG=pRbtJKi7doBt7QmQwUKdgw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] mm/kwatch: dynamic hardware watchpoints for
 hunting memory corruption
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	David Hildenbrand <david@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Matthew Wilcox <willy@infradead.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Randy Dunlap <rdunlap@infradead.org>, 
	Alexander Potapenko <glider@google.com>, Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 at 14:50, Jinchao Wang <wangjinchao600@gmail.com> wrote:
>
> Motivation
> ==========
>
> The hardest memory corruption bugs are the silent ones: a rogue writer
> scribbles over a live object through a stale pointer or a race, and

The stale/dangling pointer (use-after-free) case is the main one you're after?

> the victim crashes in a code path far away from the culprit. Any
> single developer hits such a bug rarely, but across the kernel's code
> base and install base they keep arriving, and each one is
> disproportionately expensive to localize. The question to answer is
> "who wrote to this object, and from where?", and it is hard to get at
> with the existing tools:
>
>  - The kernel's own reports - an oops on a clobbered pointer, a
>    BUG_ON, a list-corruption warning - fire at the victim's access,
>    not at the corrupting write.
>  - KASAN/KFENCE catch memory-safety violations: out-of-bounds
>    accesses and use-after-free. But they have a blind spot: a
>    corrupting write can be fully memory-safe - a *valid* pointer, in

Language-semantically speaking, a use-after-free write to recycled
memory (be it in heap or stack) is NOT memory-safe. The detectors may
not always catch these (KASAN relies on quarantine for that to
increase the chances, but yeah, not guaranteed..).

>    bounds, to a live object, written just at the wrong time or to the
>    wrong place - and then they stay silent by design. And even for
>    the bugs they can catch, KASAN's rebuild, overhead and redzones
>    change timing and layout enough that racy corruption often no
>    longer reproduces.

There's also tag-based KASAN (KASAN_SW_TAGS or KASAN_HW_TAGS), of
which KASAN_SW_TAGS has an x86 version based on LAM (not yet merged
though? see https://lwn.net/ml/all/cover.1773164688.git.m.wieczorretman@pm.me/).

One property of tag-based schemes (and any other lock+key detection
scheme) is that upon recycling some memory, the tag (or key) to that
location changes, and any previous pointer that still has the old tag
will fault. The caveat with current pointer-tagging schemes is that
entropy is relatively low (4 bit tags).
