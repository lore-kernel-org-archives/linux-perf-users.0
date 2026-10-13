Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C927518143
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 22:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791930377; cv=pass; b=ONHifrblrBGZC3SRsQdP+UoB+iw4ZQTvUrW2y4S/EemVkj8ZbnGPPzmYyIf9VF716SEssMALdHkSaHi2HSdpZjscCYxDPSitUYNeK7rMuUw9hixU1O4QOnLCY7NhPRa7/3lDOHy7YclIcOAA9H8dq4ligWXoRhFAvact39Ko2q4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791930377; c=relaxed/simple;
	bh=e97obOSaBF5A+CDMxcrni6hxHYCVamGCzvFlkP2JwH8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cukSiJg5KJ0M924gpTQf9gnPgWsTuGO9uXz+dUcmcm9+Mft5ptqNwDUJrbQL6keoTSKWgnIhxxCp2rgJV8UMUl87X/FeWo16oRmyjzHHcUKxyVBkfCigedALMMOQYIn2NUaGlxoE3MlQ8znAQNc1R9gJIxlE4jf8+UrqUNlR3sE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gx5cY/0n; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gx5cY/0n"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so164195ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Oct 2026 15:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791930375; cv=none;
        d=google.com; s=arc-20260327;
        b=IewiFzL5MTutO+DN6JJlWjQHIWKVx4iyQivJBXwyD2lQpaTtCkn/Jm5D2DUmS5kr9y
         DIN+PayGe1ahQqlvrY5CKmYfEX+NSlUX5ubNqKpo4cxUuYR91Vs4TBK2JlI/fivLpvTn
         h25Ti50DcIe+90PcTi9OVYEAsfSYGIvJgQubsXMNnNONzhvmLH7ILCok5QlvfyXAPHZZ
         HaRrbNEHJyUdRvvVHFYU0KzvwTIB77LS85ogXvHO59PSDwsOsH+M0nZXsjNbol5D3qXY
         3yXnweeItgnRkPJBxpbicXM86kbVPLt8VPsl2FDDJitrs5fqLeJazMvkK+ig17a/20PT
         7iig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o4Q09YSNA5+tLu9OvcCxqGnBvUFwTFzGq4mB2ylO5ZY=;
        fh=IoLA1qW4qBApjJT0jXG0oERxbGO8DqX0njNnl7Fhnp4=;
        b=ngy6G+w4ldDyzK3FrjCoksUyMQi4iKRrQZtGb/M2Zy0Vm20A21J+9nLbip1cvvXOhE
         bhDWRQ6WkwtIIwrRy5xoEpCh4DQhY7F5JN81xvqt//XdjBZyVFIyBHWiyYjTv5iMwkeV
         vItOREI14NCSe697eyYJqu7AOXAikFTmeSTX2Sl3iho3loBxoEHYufjZJWCnxxE5m2mB
         CA9NXTEFTqbHAt5cNzE947/DauJX+eg7rdpKLUlNX2cApmfV5l/WvPcQvNn7WF7kdLj7
         5GyT3f9PBn5UU9sM+KZ9pETQ0tgiFuYx06NL3pTNGidalsV6xExrrJvqhJjTHk9NF6wg
         VjBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791930375; x=1792535175; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o4Q09YSNA5+tLu9OvcCxqGnBvUFwTFzGq4mB2ylO5ZY=;
        b=Gx5cY/0n2T+TX1Jjci9abHdU5GkifM4O2FaGpSduj2vDdLlu/72ZX2mrV05+GNjeYH
         A9uTy734iEekvblnCy2+/QI/EKfyjKWqDMU6ZMFB3ZZgowtKKT7X+xJLBut1AnZeJKuU
         avD1TfwrOOIX2XuGYBvPjhIMGNmgXgbxXc5twtFLCqc3Kv+wxeVmG/4OAbIYIaliC0/Y
         T3YzyscW9qUJPgqeyRNgPruECQvT0RmGwyFMEpEbMRx/mEFUThHRC4TcDHL12nSnUxL4
         Q+0RJccrTOSKDpUW3NZG2d+RN0fZby8fEMXOXLaTAA/KA69/9zV3rbasrN7PXvWF7eay
         vN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791930375; x=1792535175;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o4Q09YSNA5+tLu9OvcCxqGnBvUFwTFzGq4mB2ylO5ZY=;
        b=tDW/UWVB0cT1dpE4MEPBR+UwnWPGpOv0lZggai0s3XwfbEAy4y6MfB/MV2wfwksVX5
         RnP1bw8ClRDDiFLKoEmJ88G8d+T3p+It8fiABy30C+WYJr22OU8HOefegqoxe92biZR6
         a8CJeDxNEy4yjZOR7IYU2s/xP7VOU9Yei7Kku2U+Ksw8y3SlgkvyIJJqyquzg8R8xfD5
         olAoq4G/Kinz19z9LUYdH7PTWKcE3J5XkoPI5CqRYqXL+om5vK/bkP5uzN86oFuXuJ/T
         9Q2URvb7O5OK16+PZf5Tch8xY9OAOKrEG0NQDRL7YEUFNZwf41zy856UwH2dEOcyZWkV
         j7mQ==
X-Forwarded-Encrypted: i=1; AKwUvBwVTLO1BuwPyaEeVQmIHALojYjqBlNN5UQFOYwUFafXhiPGz+afHgaRh1aLBIjHcK9V0W4Izn11hV8bnvJ3jHlN@vger.kernel.org
X-Gm-Message-State: AFq9FYKA6LotDPPGgfLYxsVzLlICMiLSFxd20gAkMWNwVvTIEO73mv1u
	L0SeJhNPAiYmRHfJxGM45/rT0XKb4vPLI4Nijy6cKsM47O3yenlo9beAyPx3LlbspAQW+Lp6PPq
	uxabdei5dQabOef5YJZU3DUCnYF1op8wplBSh9h13
X-Gm-Gg: AYBFou0teHjuwSDjQDxNoHrU7v9SSLwF6k1c2M0UjNRYM/wXbwP9xV6ahWRwXNMk6SG
	tljoT/cMNsDWHuk+qWf9m5JPQLgLHVaL7KTVo19p96xjVTeKug5o9FLzfUg+U3vZMppMmVM7Obb
	CYDjQRRbRrl0eChojLcuVoEo78QrBGPM3vkyUwQ1tr23f9xs8oIlhzgPaTxtQImQlL3vqCvqpXE
	Odvapg0djpEsFo0SzIvctI97S1i/whg4gi0zVps4ojXRdb7irSnCRCAirqHhH9C/p41q2qVj66h
	n/n5nMjwkW6/q0E9mQYRwUwim/9yRAhv/q1mM4WOXBly5dPw+xICy1XlFniby+7oIBW66DjfHeP
	KJc2sHUk028Z8lytHOHc=
X-Received: by 2002:a17:903:124d:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2e939438b27mr346965ad.2.1791930374188; Tue, 13 Oct 2026
 15:26:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013182458.1234616-1-irogers@google.com> <20261013182458.1234616-2-irogers@google.com>
 <871bf440-5b43-4d63-83f8-15ba96719fa6@acm.org> <CAP-5=fX1XZu=3scB1-hA2ppcM0+sR7t_3=C7fFx=kGikm=dLqA@mail.gmail.com>
 <56cea1ea-a4a5-4c26-a15d-732415986ede@acm.org>
In-Reply-To: <56cea1ea-a4a5-4c26-a15d-732415986ede@acm.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 13 Oct 2026 15:26:01 -0700
X-Gm-Features: AclHuK-gmtH3OisE1f-Puo1s8QVH6C5PZ7oWuzSB3BanVBcur38Q_IjsKLcry1A
Message-ID: <CAP-5=fU1fBNwnMWjjzqz+SNW2n5NWsEYeEbXd8QGBXfoCTADYA@mail.gmail.com>
Subject: Re: [PATCH v1 01/10] compiler-context-analysis: Avoid unused
 parameter warning in _context_unsafe_alias()
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Marco Elver <elver@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 3:15=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 10/13/26 3:10 PM, Ian Rogers wrote:
> > On Tue, Oct 13, 2026 at 12:44=E2=80=AFPM Bart Van Assche <bvanassche@ac=
m.org> wrote:
> >> On 10/13/26 11:24 AM, Ian Rogers wrote:
> >>> diff --git a/include/linux/compiler-context-analysis.h b/include/linu=
x/compiler-context-analysis.h
> >>> index 8302ebc2ea8c..024e303188ad 100644
> >>> --- a/include/linux/compiler-context-analysis.h
> >>> +++ b/include/linux/compiler-context-analysis.h
> >>> @@ -243,7 +243,7 @@
> >>>     * alias as a function argument).
> >>>     */
> >>>    #define context_unsafe_alias(p) _context_unsafe_alias((void **)&(p=
))
> >>> -static inline void _context_unsafe_alias(void **p) { }
> >>> +static inline void _context_unsafe_alias(void **p) { (void)p; }
> >>
> >> Why a void cast instead of __attribute__((unused))?
> >
> > I agree; unfortunately, the macro isn't declared before this header
> > change needs it and I wanted to minimize the change.
>
> Hmm ... as far as I know __attribute__() is not a macro.

The kernel use generally comes from the macros in
include/linux/compiler_attributes.h. You can see similar unused
variable warnings being avoided in the  __assume_ctx_lock and
__assume_shared_ctx_lock macros declared in this file for the
!WARN_CONTEXT_ANALYSIS case.

Thanks,
Ian
