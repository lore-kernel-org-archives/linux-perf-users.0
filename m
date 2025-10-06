Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3D71DC1AB
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Oct 2025 22:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759789482; cv=none; b=cfAj95sA4TUdY0WZDjgeI9dvosFb8Av1Js64lN5kh7OVFcu4oPlGB1xWjSXXhng4i7W6bzqI0k/NQP7EeGGzI3adaXv45nBS+bvCuPYbH1PUzXvGWDYlarldaEw42m6G01qz43m+s5lnC4+Pj4xlXcmtaUY7/LdMOU4zVEpgnU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759789482; c=relaxed/simple;
	bh=ZzEjdQ3Ctlt2q9UjuwjY8sL9bTZfjoRUrpSLbw/FI2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=k5agJM6NmlHMN+ZuOQZUKKJTGpqNuyIgcWyS7AyDG94X2JHBTL27JYDuvgwBU/bi0ruaGUu8IZQx6iyQVGgspqtBkxrs4mn9qjg4/Wlvm2AXUTXZfQdfb7FBpurPlBiMF3PLMbYO+cVKK8GMjTcXjKAwAmCVUlmf5pwQgcXbbvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LV2ooRbm; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LV2ooRbm"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-27eeafd4882so86735ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Oct 2025 15:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759789480; x=1760394280; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=csUKuBy/cfwB0rrhjYySeSh9a7d+66DcWdMpSkcGTEM=;
        b=LV2ooRbmrWd9BOCHXl+BHvv/ZahR/FBrj9jkbL2uPLmcYSqSAg354xhYOEkey/GSBz
         CZQYBbb9MAJzte3i3orlur2kFX5dqkhbJLGHmlFKCpvkKF77XecK19ysZTSO9zM/m1Qb
         0oEm5cXLNP0qNSh2KZcihBo7Ohkx8w2NcVYzjRjgi/tVzam3MlYw86Q2UMS+cqYj4DfI
         yVS9qax+5fGjV75XeyaL6wt7DB0/313to5XiPwDLrTjaV+ssxEWL8EX2+y147dUY4vwF
         l6Irciu2hRGWfzKV3x98HoRNvbOx8VNaQyxcM+8NvB7Sc+1/LoF9ub0v3aQj9dRb6ZhW
         KoQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759789480; x=1760394280;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csUKuBy/cfwB0rrhjYySeSh9a7d+66DcWdMpSkcGTEM=;
        b=Nbr8JZ9uKCwTcj+WXs14ojDu38zWkkOM67yr+vzF4ewaGC+/SRkinF1zkr/2KRkFxa
         M0lnfqEiCj/3DhQe5OE2Zhu0Hm904nR1fqM1kMtVdzBefvCWHuA4hjIBEXkcwYXt+tPL
         WsiC2gW2fA67yG/twtf1cFwfWIEN9CBQyCPgotWqRTX1R6XCtr3wgbxE8AoZJ5JzjsX9
         BRi1x/FbsEOBdSw1gw7NmnwhJxU/b0BAKhTMXtgSL8aPni1a57fQe/3vP3RCdnlpxnpn
         EfD1kevN+0VMgk1KkrDlawYwkormQ4zDwBVxWDlerpna5xc0lGDrZjyCKVKPzO1U4jeg
         7TOw==
X-Forwarded-Encrypted: i=1; AJvYcCUBgkg5e5vtz91d1VXluzfB5cyKj5nm8CIFRmKZWSh3p1gcmpUgWrEQRxjnwYZ5/raLYONge3usbh3LaZK+xWcP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy078FZyPYJJ5nJc19WI5Fr9ndvHQbYL8nL/b22kpa8Ec4kROwb
	tGY/v57Kpwu5I1CGh69thm2XFdaxVaWxJNiOXIVLJa6LwYJ+Pmf7PpAeYQyyBBRQ8Kq/lynTO+9
	ju9odOErminaONAybCM5gMXAfAK/i7J0C0EhOIbqe
X-Gm-Gg: ASbGnctBoHYEijCW0iUn4wsIS3zwYVqXIkJ8mImIzVHAMIQGPmEA9XSUPgCTOkTogcD
	gvRcJWB6FgL3Oi7wQH3slV/y5RZV+DRnQsxhfPBo3T+DQi76yTld66QG5A9jYcmR5u+XXXQWKrD
	19uFubCL+SqHrjg9Uu3oyhtbHFst4vWnQUxAEsUdI42DcsqC8nupFbfi4OedXtNTjfLabfJe0Fi
	PyEZk0EA0M/XR75pwc95EWBx2OfJMNZuCdqWSfBXumhrHl7OkNJ6yl7+BZqshkBmEMF
X-Google-Smtp-Source: AGHT+IG8G66y1nO9UVw8rOFx+n/thLkwl0ArE55uKz7jbSHnJDPIVWJsU206eEQU7TiWRH9QC9ziDBifo6OAAslWGrs=
X-Received: by 2002:a17:903:24d:b0:240:6076:20cd with SMTP id
 d9443c01a7336-28ecb769fd3mr795835ad.15.1759789479891; Mon, 06 Oct 2025
 15:24:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006222116.3335193-1-irogers@google.com>
In-Reply-To: <20251006222116.3335193-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Oct 2025 15:24:28 -0700
X-Gm-Features: AS18NWB_2GJZPs9mIpmzgg8B7DFq11s7c_bmSvm4OYKklR3eKQo9HSIAnjYj1E4
Message-ID: <CAP-5=fWo66PRxCBQSmwy4C0X75k9fagy8OrphUyh72ciwc1Ggg@mail.gmail.com>
Subject: Re: [PATCH v1] perf build: Don't leave a.out file when building with clang
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 3:21=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Testing clang features doesn't specify a "-o" option so an a.out file
> is created and left in the make directory (not the output). Fix this
> by specifying a "-o" of "/dev/null". Reorganize the code a little to
> help with readability.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Maybe a fixes tag of:
Fixes: 5508672d7f49 perf python: Remove -mcet and -fcf-protection when
building with clang

Thanks,
Ian

> ---
>  tools/perf/util/setup.py | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
> index dd289d15acfd..6caf2126b1cd 100644
> --- a/tools/perf/util/setup.py
> +++ b/tools/perf/util/setup.py
> @@ -22,8 +22,16 @@ assert srctree, "Environment variable srctree, for the=
 Linux sources, not set"
>  src_feature_tests  =3D f'{srctree}/tools/build/feature'
>
>  def clang_has_option(option):
> -    cc_output =3D Popen([cc, cc_options + option, path.join(src_feature_=
tests, "test-hello.c") ], stderr=3DPIPE).stderr.readlines()
> -    return [o for o in cc_output if ((b"unknown argument" in o) or (b"is=
 not supported" in o) or (b"unknown warning option" in o))] =3D=3D [ ]
> +    error_substrings =3D (
> +        b"unknown argument",
> +        b"is not supported",
> +        b"unknown warning option"
> +    )
> +    clang_command =3D [cc, cc_options + option,
> +                     "-o", "/dev/null",
> +                     path.join(src_feature_tests, "test-hello.c") ]
> +    cc_output =3D Popen(clang_command, stderr=3DPIPE).stderr.readlines()
> +    return not any(any(error in line for error in error_substrings) for =
line in cc_output)
>
>  if cc_is_clang:
>      from sysconfig import get_config_vars
> --
> 2.51.0.618.g983fd99d29-goog
>
