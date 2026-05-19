Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A27376A14
	for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779216928; cv=pass; b=Q1Xe7NfGCnxWnK7o/CrUAfDh+T7LouReNm+e47jYaSRN2/xKcs+5YiW7XcxZBdUgM2lc5FMf5bVDMYe75kRX57jxPrQuBhHsvG+SuSAxEY6PoFZswo7EoryCaXaJAsTF7UeTdxwD692OrLEHmwcqLxQCWTbOYS11RCODMeiJKFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779216928; c=relaxed/simple;
	bh=7jJuTFyxIQFgGbFSaoiVo+0a3X/OYWa6i6xQj0whl7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvjTm0hQIeWi1+YnCPK/GWFCeRwrzi0w6CXUCppc71GagoMqvguYdF+jXhjeLnSyfrRGICETjo/0DResFfcmGyOKV3wP4u0rpgk8ZTJOzJhL6vLT1SkJDa2MDdW4uCRw4q4jESaKSvKE6jrGtIsMKqEIAy9Q4YI6YaCgx88xZK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i9Kthbg8; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i9Kthbg8"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so265ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 19 May 2026 11:55:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779216924; cv=none;
        d=google.com; s=arc-20240605;
        b=VkRjgHGGIyYPQXKV6JFnmB+gdhU6Pv8OGFtCmkXGYx6hrGANZasC+ZeCqq2T4hbq39
         MnX/qpv+tB8l0IzODH6a9MoN3PvMUKaVDQfAczjdKtW7t941XGoRpFCQdaZOQUErIwCR
         OyzjY9WOOeGHrFXc0VV9fHJbHwi4DVmnu+1uk8dGpcQdS3P5mZODG3QX9Tcc+I9PAuyX
         kxIddanpBaws02Wf2c8vq+9/cbxkxsfEv0li4iyLE5v3ktQ86euuuyvAtzu3IVXzIWBi
         IzLajDlqKwWsrok4XGsAHcFxnSdNwRMMl3qOzZPvUGHExqsejnP4KRssGbn+8ymCNYPi
         ByWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        fh=OVJOQ0PrzQxzE4CdMoXe1ZtWR8K/tVvVsLpiPREFYpI=;
        b=c3OChmbJ2JG+Df6RS4gaPT4k1vwX4eN4s8qNUP+6gc+j0MBTXyWoafr1yDyR8ncgHU
         FnJOoNPLL32Q/woLJLprFd56umA9qMJp7ODgomc8by5cpH3TmfzwFVJMQC9vQfXgYhUj
         sv8ZSQz2s2w4PtpSdSvCE0qwZa4H5e0L2dvvPacw7tnmYMGDOlY3ZcjQbA8FZw9MeAC4
         SvexIaX8fyC3RBjMvP48aqmbVH6RPa1OrMb83E2+kM7a4hU5Xii06UZEFVst/T4Ca5R/
         ysPzsylxhldaXeAJbqhYNbXZ2ghu2Sw54eSt+d0q1JoPxTe41b3qihJu3fMoapfHhyOQ
         xrGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779216924; x=1779821724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        b=i9Kthbg87uGSj60qNgX++RI5HMot2mTo3Z80iB6m5FOj0vdvFLe7BuCS7ZS8KGawiq
         lJId5S1ibyfqKS0qyYnf37u+KESGNRRj91238j93W2ptP0dEmJxunzy87oV0dtmO6B+d
         XVFf8YTxVP2oUgGbrwdUs5oOJCxdROc2JlpozFST32x4Nb4Y3NoM6NdTEZOxZdhYndr0
         AK4g3OjtiZ/Z/2HBg1thGhNicI8pTk+dI7iwXSzg8wRAH2+ournVmExK7FzjJgx3wNUp
         +VtdzzbSW0ZqGzgsQzMVwEAGozV2vp//HxoEhg2KOgSdZaH71FElFrP2C8fCD1HiR82A
         BJog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779216924; x=1779821724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ3Jvwmd3/jYVoY+5T+/jl2kd+9Tp3/RpWPQ69jbyeo=;
        b=YRGVPe9lOyHmDaoIUaEajPXiIqLtGD48DqfnyWDkUEu+qcZnJf/9iWKRGaB2ST9/Fi
         Tqksf/z2HY+F3BepGTh9Q5PrsreE9geik1tcOW5I6Ol0VSaRy8slICXbdlLsBhRbq2z2
         XO0FRLHthMUHrYVn+kieAx6Btbii40nHksmi+CTQ7RSJl6cGKmoMQfjIBQn4GJIghMcw
         wTTSUtz2h5c2ZF7kRfIiDgfOSSIWXIt589d1Zck33w2xEkhq8yziAlxkMTJa9m4/hEjp
         W5ugOUEuiKM5Rk9M+JIKXWyT4kZKh3FmiqC5K5ztlm1JTJdLlMnGe97kgshCHoNlclrT
         Pyhg==
X-Forwarded-Encrypted: i=1; AFNElJ9ISDm2yaACnX0XWp+xWJIf98GyejXKGb6xv+gZqIOZgPjZbfJs4EyXIwQm/6m3zTdaxHb152qooj46KRAAQYB3@vger.kernel.org
X-Gm-Message-State: AOJu0YzC0jVJC/z+sUPYdFXgaJJ0KEOf4NSmL9dOsxoVKsJFcbS9YgfH
	ZqTYNUqmcZaoc3LsGbDcd1+u8VPg5kgFWVtoTdOrSlOV1og27GB2FlcvVsYjgaKptR6dZ1Ysc17
	NCNSpD0TCOCo7QVSkopQfMsdeLBz23cbwsRVEzkYu
X-Gm-Gg: Acq92OEMk871AEWE+NWtDKTcg8BbxS1XNzdT353NcI/8x2WIKfMm0+uzB0AAe8O/VN3
	mjM2QkMpbhzoIIoPKbNM9oBL+Sw8qhcsrVRkCUeAyi+04cIYfgZLqKmumY2Yj/M6jmdc5IEecty
	NuWOkFoNrlu4xAicGHIPYyGrBUpdWUi9TSlvhqNsXqDWr+YVR87SUQBg7RVy9QvkdSnQnQFPPsX
	Imb0G2X3UApT/g2nJCr3iMFnSxwWGImzv7udGDLk777W8VcsbmLps9irrt2giMvDOHXdxOr2DrV
	PkcgDEqAR2sJ8olfA1sHe5KWdUI29PNEbvMizT5ud9xlA5je
X-Received: by 2002:a17:903:2f03:b0:2bd:6727:d689 with SMTP id
 d9443c01a7336-2bdb03a2b85mr7785775ad.12.1779216923701; Tue, 19 May 2026
 11:55:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
In-Reply-To: <20260519185154.2987285-1-florian.fainelli@broadcom.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 May 2026 11:55:12 -0700
X-Gm-Features: AVHnY4JlPZT2y2KVD2Jea3uptVn6tXWN7jpuqmjhnpWHibNi0RSzYBZXKWi7G-M
Message-ID: <CAP-5=fUuhNRj2Dwz9FmMnWKwXjM3RCFV1oQKO4e3X20EOHstEg@mail.gmail.com>
Subject: Re: [PATCH stable 6.1 0/3] perf build fixes
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: stable@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-perf-users@vger.kernel.org>, 
	"open list:PERFORMANCE EVENTS SUBSYSTEM" <linux-kernel@vger.kernel.org>, "open list:BPF [MISC]" <bpf@vger.kernel.org>, 
	"open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>, bcm-kernel-feedback-list@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:51=E2=80=AFAM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> This patch series contains "perf" build fixes specific to 6.1. We have
> seen occasional build failures in our CI looking like these:
>
> util/parse-events-bison.c: In function 'yy_symbol_print':
> util/parse-events-bison.c:901: error: unterminated #if
>   901 | #if YYDEBUG
>       |
> util/parse-events-bison.c:1020:62: error: '_p' undeclared (first use in t=
his function)
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |                                                              ^~
> util/parse-events-bison.c:1020:62: note: each undeclared identifier is re=
ported only once for each function it appears in
> util/parse-events-bison.c:1020:64: error: expected ')' at end of input
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |                         ~                                      ^
>       |                                                                )
>  1021 |   YYFPRINTF (yyo, ")");
>       |
> util/parse-events-bison.c:1020:3: error: too few arguments to function 'y=
y_symbol_value_print'
>  1020 |   yy_symbol_value_print (yyo, yykind, yyvaluep, yylocationp, _par=
se_state, scanner);
>       |   ^~~~~~~~~~~~~~~~~~~~~
> util/parse-events-bison.c:991:1: note: declared here
>   991 | yy_symbol_value_print (FILE *yyo,
>       | ^~~~~~~~~~~~~~~~~~~~~
>
> which are resolved by these patches.

Lgtm, but the changes should be unnecessary as perf from Linux 7.1
should run on Linux 6.1 and with more and better features.

Thanks,
Ian

> Ian Rogers (3):
>   perf build: Conditionally define NDEBUG
>   perf parse-events: Make YYDEBUG dependent on doing a debug build
>   perf build: Disable fewer bison warnings
>
>  tools/perf/Makefile.config     |  1 +
>  tools/perf/util/Build          | 12 ++++++++----
>  tools/perf/util/expr.y         |  4 +++-
>  tools/perf/util/parse-events.y |  3 +++
>  tools/perf/util/pmu.y          |  3 +++
>  5 files changed, 18 insertions(+), 5 deletions(-)
>
> --
> 2.34.1
>
