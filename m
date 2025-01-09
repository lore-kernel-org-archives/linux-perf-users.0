Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A324B2B9BF
	for <linux-perf-users@vger.kernel.org>; Thu,  9 Jan 2025 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736445528; cv=none; b=HzWTLguIVbTt4VEYSQrqt1DdlNNhVuq4y46jU+yFMCYpORwG1/OkCNTjgjxBOULaaatvJQV7gid8YxJ/S5QR12TIrZD+zFz6lgnzZuDLikaNFR1p5Qkwy5mR+20DjvQPIcGm1w3s+PVUV7Xnxyy+i+zeIdD/5uSFsGLHQgH1i/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736445528; c=relaxed/simple;
	bh=lomIqOtJ/ynGJJVv1VdqQaSHLi5oIrChDMi7EfyciFw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=pgY9TWxdBnQGqoUZY7b5f8pap6QQSlPqsUmo4GXtEiJLLTkbmo1dcEfEZqnoHvwFdeImrQetAlkibqyqcpFMDH7/+H5vTLeQPXfdh8FQBDWfNfLkepsdhHrXTAhfjn6uRaWUKUObk4rekyy1cBGWcNHsoQyDrEZ6I/HSPbX0zFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gi/9QtFs; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gi/9QtFs"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so3795ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 09:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736445526; x=1737050326; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNP6kZl0BWMuS5Jra3qtVvP+rXQgGZY5VcWnXzDsqEc=;
        b=gi/9QtFsRipSBWmScD4eHDJ8VhCehEksPOzF0EMUkIMsdT2BPfzbZ4c2sU/nO2Ks04
         DLekcKSuNdDX7lbaysRPU2u3oQ2ufdY1CaBj1H+OambgCgPN6bVYhPExN4V3ZIq9Bdah
         +l7LJzj3V4VgKHO7IgKOIhS0ncunOcnoHedwOIDzk8dqo84QzGP4pjGYet5NSZIfFEQS
         56JbOMq8z49ksQENfW//JM6WZShPzX6RCoESdU+oOhbJkVyjkKLZTSDWyH0HLXMcJQvL
         wLB2+VJLwCG+qQi02HQ8mNHwFOR5AlZqvTEIMKX6hZeKKg9Xn0QKQPXo6ANHchORAc8r
         IQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736445526; x=1737050326;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNP6kZl0BWMuS5Jra3qtVvP+rXQgGZY5VcWnXzDsqEc=;
        b=nmW3TtI+9RCVnbPL2YaE/vJbtGFft8IS8HGnvXyE4ZddTwgtBK4e60MNXQ43WXLMZn
         KYq/BtsoP2xS4UIkhfWt5vC/LUO5nAY1TOi+cQMk1UHxqavCQbyNxqbQ5idPMrF6ILvZ
         d52E/i2fXYgSegXSZRswP3CworHa1ISbGooHO8Cj0jfwTQ56NZDsQITNCBETkSA1Y9Rx
         PGF/eQmZxBng8eC8nlC/wprDwPq34rNvRsvPi8Veirqmm3ShK5+RDfGp7vRfi211A6Uy
         3mnF/IAPY0HUq7GpPkt91oaZDOEu88WvMNYcVKery+kjvRq+N3afmV0aIQCSjbMOEKMY
         mGrg==
X-Forwarded-Encrypted: i=1; AJvYcCUVpLO0QWC3BfQoBKj3Btwh9JMgYscr2AySbXyJ6Of+SeofJrXsZbBgl0bOBmYhCY0apMN9CudfHXynHALwaDqL@vger.kernel.org
X-Gm-Message-State: AOJu0YzHx19S/n7Zu35pVdSw1XKcAvl1zsyIAwGBDSlpWUMYSWYE8qtO
	c4NrmgQNfra11dhuusBNm96cjvNwZRmdk5w5xn9YYXw8H+gDRdUuHryaA2+Y1l//P+DyDr16CeB
	upop6H1S34kH6+D4PY2hltOPRQ1rG0WzNFk0b
X-Gm-Gg: ASbGncsNqu6H0+YoLo35DqyT6wlIeuLU1ANam/noTj+2HyOqDbYtHrh26s+BS6eNPiy
	+o+Qz0pzSZ82ILzLINjxhIFpLArkVGyYh0WlA2JAvqwnvMLlkDNbeZEg09SpsRTbc3hLa/g==
X-Google-Smtp-Source: AGHT+IGSVfuUfR0qUPjmpfptUU/N9ChAG3VMNXjX5RR+ePhUnWB+Hl0cIzCTPbgK71/n5/QmNJRi3BM14QIfqZb5ICw=
X-Received: by 2002:a05:6e02:1d86:b0:3a7:dcc1:9936 with SMTP id
 e9e14a558f8ab-3ce4acf68dbmr3276315ab.23.1736445525787; Thu, 09 Jan 2025
 09:58:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119031754.1021858-1-irogers@google.com>
In-Reply-To: <20241119031754.1021858-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 9 Jan 2025 09:58:34 -0800
X-Gm-Features: AbW1kvbfWKF-FDZ6gTQYTUVPrOwhzIPI48_dT8WN06zUu6qKFhb7XjtEkSAxn0Q
Message-ID: <CAP-5=fWBEGj-bKnfF3bi+qy3nzrV+oWzDj-0M5bRe2kQSsJ2Tw@mail.gmail.com>
Subject: Re: [PATCH v1] perf symbol-elf: Avoid a weak cxx_demangle_sym function
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 7:17=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> cxx_demangle_sym is weak in case demangle-cxx.c replaces the
> definition in symbol-elf.c. When demangle-cxx.c is built
> HAVE_CXA_DEMANGLE_SUPPORT is defined, as such the define can be used
> to avoid a weak symbol. As weak symbols are outside of the C standard
> their use can lead to strange behaviors, in particular with LTO, as
> well as causing issues to be hidden at link time.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/util/symbol-elf.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index e398abfd13a0..66fd1249660a 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -287,8 +287,9 @@ static bool want_demangle(bool is_kernel_sym)
>   * Demangle C++ function signature, typically replaced by demangle-cxx.c=
pp
>   * version.
>   */
> -__weak char *cxx_demangle_sym(const char *str __maybe_unused, bool param=
s __maybe_unused,
> -                             bool modifiers __maybe_unused)
> +#ifndef HAVE_CXA_DEMANGLE_SUPPORT
> +char *cxx_demangle_sym(const char *str __maybe_unused, bool params __may=
be_unused,
> +                      bool modifiers __maybe_unused)
>  {
>  #ifdef HAVE_LIBBFD_SUPPORT
>         int flags =3D (params ? DMGL_PARAMS : 0) | (modifiers ? DMGL_ANSI=
 : 0);
> @@ -302,6 +303,7 @@ __weak char *cxx_demangle_sym(const char *str __maybe=
_unused, bool params __mayb
>         return NULL;
>  #endif
>  }
> +#endif /* !HAVE_CXA_DEMANGLE_SUPPORT */
>
>  static char *demangle_sym(struct dso *dso, int kmodule, const char *elf_=
name)
>  {
> --
> 2.47.0.338.g60cca15819-goog
>
