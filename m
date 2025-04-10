Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040538F80
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 03:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744255583; cv=none; b=UF2kOSgr3uzp9LKxImcZUf8VptWRh9VO0yejhmIqUByxX3BzPB7B6TQFjXKF+wV/5G2pbk2eHi1V0FBKOF9b8UEvq+cpYRnYc+tfNT25OlOx7cswl82ILZCo5zhNxmretkA6JWcXd71pS2kRF+P/xR6mFLSlPZQxFr8ENG1N3oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744255583; c=relaxed/simple;
	bh=M/vGV3Mpk6prS0Ozism8D5Ws1lcrSpDFZMZNWgiINj0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDCgl2xXqk1iJJKDEs7IStEwJuD0QBOjNlrmk3NDrT9LFyaOIRLcSAcYckBAMQQECwCnfQhZ4qjXrYE4fs3JIXOsgqeNvozT4XlTd0Ankg/T30i2VZ7eC0+UcsqwLRUCgpVhWNIPtLyAF8ilIOIVACsyHsq5MVRKgWPGvoRpr7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yhV6DGp5; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yhV6DGp5"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e66407963fso606555a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 09 Apr 2025 20:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744255580; x=1744860380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LRcWQsIL/ZObsYFazuQjFAzWBbG6LKR31TJBSpTWZNg=;
        b=yhV6DGp5tJ18sgd7YG5eDEr1fFg33iZ5Cox7fDHByibuKtYNRm6/OkifiZTN8guCdN
         aPp60/oM1fN44fkNb8rDhx1TVyhhmtwBKTeW/NjWlkoRRJfb6Wv59evk/fIR/18mIIbe
         QLF2GzqZ3PnJoi+AEBRMh+RT1ZL/q/s/FgoLMlanbtx32doezv01NnEKxXq5lNHkjylk
         CfuHzgVm5yNBf5ep6bORGa1vDRmvf/h0h7khVwoXzOGcLd5aXqmNgcu2BSEA2vl8EIN0
         HR4sRYCfa+ZYluEn4JEGSE3rggLhXD+PWiTdIUkaea+g48ABX6q5GBZ0Us6WdLFIikcb
         6smw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744255580; x=1744860380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LRcWQsIL/ZObsYFazuQjFAzWBbG6LKR31TJBSpTWZNg=;
        b=R7eQxx4R1Kn+agYgwW5b2nh5tqU//5PYkjE7CX5D9krF6PvxMC0xyY72+rI9974wX3
         nd6fOe9TJZkqUUKod4VuGDzzDu2R9fixOfVLvMtZlOXaoRU3Uqqp0vPqgCkiSjV57cNu
         8ejN9OLTwD0YLXSCgwhlUOsXmA+khXwWf6f2VkWPMXBteUmeJtn6/0CwOwjbYmskfTMz
         oOg/jK1HBIe2+s0qGgc4Kvky8oAaDTjkUSCuSnCpjp52WwupB+f5SSOSnfidF51cIioB
         MRLUQU16HQuOZN857WkpK8hxcQiRnaDxhttOmJr5kJ+G11HlLOugJgjyYmg7P+lldRI2
         sUJw==
X-Forwarded-Encrypted: i=1; AJvYcCUJQT6Wn1pDyk3dt3GgNWqgaP2vkEL2cE3GvzDW9Yd3wVbjFtXC+QseSfGcafrSZJNRaY/mcIuZbqGE7YynGDTM@vger.kernel.org
X-Gm-Message-State: AOJu0YzG7aGXax6kNbBhYisuGHhIBPRsnctimHd/BrCoqNroYbfqqjCc
	Sc64BzbFfd/EQUMie4eWGjdXeM1C1uMCh3lBe94uLgtzyoKsnk+36HTXWCu1K5ri3sKoOr1WLTB
	+BHUqoGpu4Vmwr+z5ZfJX3zh8CnyZYIxT/nQo
X-Gm-Gg: ASbGncu6yy0aIvMFosfF9Tkh8Y2ChNJgJ/F5fzFFKGmfId+A0M0wGCdM5lg7NggLoW2
	j3Su5hZe/ib/URLx8PEq0hNJm+ND1r2EJb7p0iswQ9FGUd7Z7OI3kQYolw/1DoG0qKCvkK9+eOP
	YFg7imY5pImUXbZpC/cHN2
X-Google-Smtp-Source: AGHT+IHfdpbDUty8qm3lnEg2XA0Oiq+40JKXIA4G+b4cSmskVRXbuU2/OT3e2+ICwZmj7nphhqpQr7kL4i/A0759s9Y=
X-Received: by 2002:a17:907:1c22:b0:ac3:3cff:268 with SMTP id
 a640c23a62f3a-acac00ba91cmr64701866b.30.1744255580219; Wed, 09 Apr 2025
 20:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250410010252.402221-1-namhyung@kernel.org>
In-Reply-To: <20250410010252.402221-1-namhyung@kernel.org>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 9 Apr 2025 20:26:07 -0700
X-Gm-Features: ATxdqUHmAHPAs6VDJuowq4uVYhO0jQGIbi8PN3dtZqS653OEvaiYdqy3CkAdJGM
Message-ID: <CAJpZYjWTN09uXcArncRVXRRDcCH042MeN4UC1FAokoUNzsuG6A@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Remove evsel__handle_error_quirks()
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Ian Rogers <irogers@google.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Ravi Bangoria <ravi.bangoria@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 6:02=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> w=
rote:
>
> The evsel__handle_error_quirks() is to fixup invalid event attributes on
> some architecture based on the error code.  Currently it's only used for
> AMD to disable precise_ip not to use IBS which has more restrictions.
>
> But the commit c33aea446bf555ab changed call evsel__precise_ip_fallback
> for any errors so there's no difference with the above function.  To
> make matter worse, it caused a problem with branch stack on Zen3.
>
> The IBS doesn't support branch stack so it should use a regular core
> PMU event.  The default event is set precise_max and it starts with 3.
> And evsel__precise_ip_fallback() tries with it and reduces the level one
> by one.  At last it tries with 0 but it also failed on Zen3 since the
> branch stack is not supported for the cycles event.
>
> At this point, evsel__precise_ip_fallback() restores the original
> precise_ip value (3) in the hope that it can succeed with other modifier
> (like exclude_kernel).  Then evsel__handle_error_quirks() see it has
> precise_ip !=3D 0 and make it retry with 0.  This created an infinite
> loop.
>
> Before:
>
>   $ perf record -b -vv |& grep removing
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   removing precise_ip on AMD
>   ...
>
> After:
>
>   $ perf record -b true
>   Error:
>   Failure to open event 'cycles:P' on PMU 'cpu' which will be removed.
>   Invalid event (cycles:P) in per-thread mode, enable system wide with '-=
a'.
>   Error:
>   Failure to open any events for recording.
>
> Fixes: c33aea446bf555ab ("perf tools: Fix precise_ip fallback logic")
> Cc: Ravi Bangoria <ravi.bangoria@amd.com>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/util/evsel.c | 22 ----------------------
>  1 file changed, 22 deletions(-)
>
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index 1974395492d7da5e..3c030da2e477c707 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2566,25 +2566,6 @@ static bool evsel__detect_missing_features(struct =
evsel *evsel, struct perf_cpu
>         return false;
>  }
>
> -static bool evsel__handle_error_quirks(struct evsel *evsel, int error)
> -{
> -       /*
> -        * AMD core PMU tries to forward events with precise_ip to IBS PM=
U
> -        * implicitly.  But IBS PMU has more restrictions so it can fail =
with
> -        * supported event attributes.  Let's forward it back to the core=
 PMU
> -        * by clearing precise_ip only if it's from precise_max (:P).
> -        */
> -       if ((error =3D=3D -EINVAL || error =3D=3D -ENOENT) && x86__is_amd=
_cpu() &&
> -           evsel->core.attr.precise_ip && evsel->precise_max) {
> -               evsel->core.attr.precise_ip =3D 0;
> -               pr_debug2_peo("removing precise_ip on AMD\n");
> -               display_attr(&evsel->core.attr);
> -               return true;
> -       }
> -
> -       return false;
> -}
> -
>  static int evsel__open_cpu(struct evsel *evsel, struct perf_cpu_map *cpu=
s,
>                 struct perf_thread_map *threads,
>                 int start_cpu_map_idx, int end_cpu_map_idx)
> @@ -2730,9 +2711,6 @@ static int evsel__open_cpu(struct evsel *evsel, str=
uct perf_cpu_map *cpus,
>         if (evsel__precise_ip_fallback(evsel))
>                 goto retry_open;
>
> -       if (evsel__handle_error_quirks(evsel, err))
> -               goto retry_open;
> -
>  out_close:
>         if (err)
>                 threads->err_thread =3D thread;
> --
> 2.49.0.504.g3bcea36a83-goog
>
