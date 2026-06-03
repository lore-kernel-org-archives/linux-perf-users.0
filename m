Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD063911C1
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Jun 2026 15:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499223; cv=pass; b=R//wRfU/TZIDq95mX7SLonokcbgvYA8QNG7wVPs29WtnI1GbvKSt0cUvosId0lVGGRZqS9y0zm229d6UQXQGXO5nQMNJzbND3QPk8qZujpAe7tfi1ySrMe3ipAf0gss0jneUaquNctHcWT98v/LQOfy+2RR6BKXctQtTk8T6yzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499223; c=relaxed/simple;
	bh=5YrLX14fFAoVjDAsredjuMaDXlbCOKCNkQFYWLylc6o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZF5iVCqmTt/DWOhsghbB7Nnsig6sF0spgWTvhOBuk2oDs0rZNGvNNTQ1pWnCK6j2GTEGNWkTYRVoBrR6v5+wQ0TisQ7RT5ZN9mjWoguoQ7pA51gyzW+Zw2kclTv69DGWLsJzljen2IaUH2POun7YLjA5ESZZEcenlQgz+fa9Iwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M2RtkmdA; arc=pass smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M2RtkmdA"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf22c18ad3so102125ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Jun 2026 08:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780499221; cv=none;
        d=google.com; s=arc-20240605;
        b=cJwoRBNnZLcwEw+INOFJuUtvKKeaycMDUOps+GTDsqbQYG4nW2T/h9CyANBQiZOwYD
         2KAaq9pFawaAWWOxRQ8tkqJAps/DF82tFwlcytrIQfok6Gq8LIMWyrCBjHack7Bs6/TK
         nx48o62VObMadREDFyKec0t7nzzn9zEf2QV+Dua6lcnIvYLgm6Jb0Vc04dVg69UcfjW+
         d0h8pZj4V99aKL63YphoV4USwdB29fVf6bwR7eTZCqe18yVNg007UMXKfsTzLyuNnRM4
         wJSYFzHpWzC5MHN+ePFNeofVTBLwCDBYd2oomvd0i15zZ781Scp4wkVWMYbtYFfSN0J6
         I4fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NDdQqpnx+yNQH/NOkRBwEuqWBVVlw+qHvlj5oAMQOgo=;
        fh=h1bC2DAOLAWET7A/o7aGGiW/3WHwxJWoeDjPW1xbipw=;
        b=LvLcugYRCuOz7ctAES55WlY/+z1ILNIzNW/hJ9KITVNYoPhBJ9h3abWWBGK34MlFcv
         ZuPbVuieNCJpIY46jS+XdkfIkBVhCHZyrICxW3+T8Z86b0Sr97HjmLqrodeFioK9SaAV
         VSsZ5TahjBrWIqsIGYP31Ar8hrJvGsbwrsRWq7uRGX3zKPsjS5u7uKTJtH4q0gNsbUji
         858M+rRy7uHdvqtNm3CyqiH1n00/gNLdZK/GgB2uOtZTWu2fJhO+IbL/M+vta37eRrw4
         uT2Uj4ZG3fO2XgD4KdkhGy+wG+qDHcKKn0pQzA903XCP0o5Wo4u/za2V6YcgRnlotn/i
         wamA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780499221; x=1781104021; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NDdQqpnx+yNQH/NOkRBwEuqWBVVlw+qHvlj5oAMQOgo=;
        b=M2RtkmdAYV0Yc6uIB4X6tDADKuhTJsVC04Qxe3iAogtaa73yHBQW3rYJF5uKR6Dxka
         uXybTRoDLWwNdbaKlQoxG/jG7Mx6yKJFis0ui9okXLIhTtIfGSXmnhgAKvWv8W5LYad2
         OWIsLUlBR3NpR5ZP91SxdTSH4HU6EAhnGs2ESL/2i075yf4L+mvAptOPVZa69m+C4gnR
         wKqDnhvFNWsgR+qEs0B6mfqDEwiO1WP2ZeYRC2tcrJUt0y/xG71n/NHetMH6J1Pjpc9C
         KRxHItBwmL3a2e5mdQ7NJt33c88ASZXUq5h0Dh2jaqmpjgLjZe0JOyqrXp8BO+hRKzte
         9GSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780499221; x=1781104021;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NDdQqpnx+yNQH/NOkRBwEuqWBVVlw+qHvlj5oAMQOgo=;
        b=M0onRpQYp2bDkxQKn/0EzeWZ98eggmMa2IVmD+Mu9sd6DKRIF/R4QDSmLjJmIwc2WY
         4lbQtarXUQATyJKDT4TnHSvYggvS1CKSB6xAkGtlWGrCR+HMcChrCC/P5EAD4e3eKIZJ
         bvCYIYSM8X4q2gg0O2nSb5JnLfHdzBvDRbQtwPkpzK1g1FgofzZkw8SfYEzfTwn3ssa3
         TcX8X11s285Jil5fKQEeobf0GqCJC1OU3dkC7LoxO1ilp8cF+8mzfSqKadDlY7BPWIvI
         3LWiXMo5mEXY71pZ7g+NJhW5Ys7AW1ZErLH3HALnxoNhsOz79jMfrUhnZ9BzQS7sZ6PY
         IeWw==
X-Forwarded-Encrypted: i=1; AFNElJ+1MRDrm4LcG/5W1fXAE/jHQp1M+b6G+38pLlOXeQ9TYVzT6Asfn1VxafQQCPaYtM14feWeUUfToEUMFP+AYvYJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzsB1c2NZ5EeSTLU/EY5Zzvzw/j3xiCm4dhIRiYjzFre1evzimB
	qsXsyW3ZOwyoXIp0qjUw0hqIx9LdSotHvViwNR6coFqU2+Zij7opKJn7yMFD+PHnu453/qwHRNc
	bdO0veu1ktimlSh/n5BnKzZ5ZBY6msed+OezeozhC
X-Gm-Gg: Acq92OH09Ale4ObLxRb0q7VtouRWn74HKQxa1QURBGfCnf35IeTYCCDVDK1apPwN5b5
	KPWem01MiArqazOXyD4yN6Ig5+XR4OKxVnSMghuFHgVJwg4bfD/WpChRVwHC2/aDB4gNt7BewBP
	NJRM5zmK+hijn03ubR3AXaWQGERxua757I13Fs9k9x/RfOlDnTcLaUhsZKPw1jYpMfOeLCz9XXL
	P+NpsA6IqOvv40vlrn5fmKF2S85A/2ucxcwmMF+sC5TUlCyHwbY5M4NHqZgNtnL1DsunoGy9/w/
	32jLiDSdnszvJbZqxJw3j2cEOyHdOpyBoG9ehjNE7OLxXPF+
X-Received: by 2002:a17:902:e74d:b0:2bd:907:2ce5 with SMTP id
 d9443c01a7336-2c16fb1e609mr1729725ad.7.1780499220864; Wed, 03 Jun 2026
 08:07:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235709.1541603-1-acme@kernel.org>
In-Reply-To: <20260602235709.1541603-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 3 Jun 2026 08:06:48 -0700
X-Gm-Features: AVHnY4Jdeq59qwSlUfa_LORTJkIuuWSk3kxVn62B7eA7E093pclGI_q-nVjWYBM
Message-ID: <CAP-5=fVR5zLokhki3CnQTkG1Lb0C2y=BYVRUEYG9fsCXWVfZ5A@mail.gmail.com>
Subject: Re: [PATCHES 0/8] perf tools: Diagnostic offsets in skip messages +
 two hardening fixes
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 4:57=E2=80=AFPM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> When perf report, perf sched, or perf timechart skip a malformed or
> unprocessable event, the warning message doesn't say where in the
> perf.data file the problem occurred.  This makes it hard to
> cross-reference with 'perf report -D' output or to locate the
> corrupted region with a hex editor.
>
> This series adds a file_offset field to struct perf_sample, set in the
> event delivery path (including the deferred callchain path), and
> retrofits all skip/stop/error messages to include:
>
>   - The file offset where the event was found
>   - The event type name via perf_event__name() with the numeric
>     type value in parentheses
>
> For example, instead of:
>
>   problem processing 10 event, skipping it.
>
> a user now sees:
>
>   WARNING: at offset 0x1a3f0: MMAP2 (10) event size 24 too small (min 64)=
, skipping
>
> The peek_event() path, which validates events during initial file
> scanning, also gains file offsets in its three warning messages
> (misaligned size, unsupported type, undersized event).
>
> Two pre-existing bugs found by sashiko-bot are fixed:
>
>   - builtin-timechart.c cat_backtrace(): use-after-free and
>     double-free when an invalid callchain context triggers zfree()
>     before fclose() on an open_memstream buffer.  The open_memstream
>     contract requires fclose() before the buffer can be freed =E2=80=94 s=
ee
>     open_memstream(3).

Fwiw, I've also been around the timechart code prompted by AI review
and also trying to clean up tests with address sanitizer:
https://lore.kernel.org/linux-perf-users/agzWqrn6XPEwTAsb@google.com/

Thanks,
Ian

>   - builtin-sched.c: three BUG_ON(cpu >=3D MAX_CPUS || cpu < 0)
>     that abort perf sched when PERF_SAMPLE_CPU is absent from the
>     sample type and the CPU sentinel (u32)-1 is cast to signed -1.
>     perf.data is untrusted input =E2=80=94 a corrupted or truncated file
>     should produce a warning, not an abort.
>
> Arnaldo Carvalho de Melo (8):
>   perf sample: Add file_offset field to struct perf_sample
>   perf session: Include file offset in event skip/stop messages
>   perf sched: Include file offset in event skip messages
>   perf timechart: Include file offset in CPU bounds check messages
>   perf tools: Include file offset and event type name in skip messages
>   perf timechart: Fix cat_backtrace() use-after-free on corrupted callcha=
in
>   perf sched: Replace BUG_ON on invalid CPU with graceful skip
>   perf test: Add file offset diagnostic test for corrupted perf.data
>
>  15 files changed, 261 insertions(+), 101 deletions(-)
>
> Developed with AI assistance (Claude/sashiko), tagged in commits.
>
> Best regards,
>
> - Arnaldo
