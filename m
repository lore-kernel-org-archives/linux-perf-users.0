Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0D9175A7E
	for <linux-perf-users@vger.kernel.org>; Sat, 21 Mar 2026 02:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774061460; cv=pass; b=f91NDpxUaegd3Jc1fSuyzRztQ77tL4RjuC01Qpl+GxgHaUITcy/PzFrAyM6nPiRe0glRHmjrF9Go/MconBiWhpLXEWXqmg88kXZD+jDBP2VYlXhv7ymaidHSZRs9F7ZbvKOIyjjGQbKIgKWABwPbIqAU/BAMI+zIc5Cicta3gIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774061460; c=relaxed/simple;
	bh=NZr0R2vRPM+VJI4M0US80jvhJIY2EehWBVWoAZYHPBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=MF8/Xb6+PTv3nUUAFFdYjRtVzDigOD8ZxQTy+TwW2I0Ia4rlFPQYXTeaWuFg4YaOOO/Byb3C0JhtkNYQzel93P4PlMWe5N8RphXbzPGLDcSMET19y0G7ecoB2Sfez4Jdbe0/wrMNNXUZE3qjYt3uStiiOO1vUBorMQAR2c9bD5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BaZeg+lP; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BaZeg+lP"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2aeab6ff148so33565ad.1
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Mar 2026 19:50:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774061458; cv=none;
        d=google.com; s=arc-20240605;
        b=Vj1TS1gP75blCEpNky22XtH13SUgOd8ZPJbSIeiCXYTAr2gmiUl4VN2mza7vH7cHHB
         G42j5/iaoc4nkpyiqUL3GDn1M4iO0Qg4CEl/HSqBirwHZo3Els56B3YjvSuCtPCWLIfW
         edUI4vn0EaljXJtysc457OYW44Ru+VXOUh3pGoiHTd2seajkgZ649ytiGudlDoJyTKkG
         E3yjrHt5XfCj/vq5LeV/IGGvpPro7YOV0/ctaqFRXaC3KUSsDZNtj82qpWQxrs3mM7s0
         0WAs5tGl3OcyuC2BN+v/25Jg1maiYp2m81OA5iiVyKGJFii6pLXBqk3K4ygNpvrYa6Mb
         Lykg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OnKSaILKNY9d9t2S+sGZHIQutmsLtF6NiF/zLveN4hs=;
        fh=1KS+kz/y4XEdLhsM2K7+Uj91Y8ihs7CmGfXl/4Dif4c=;
        b=XrIa0h7ckwlogpUyT0z2/UXx5nFd0S294Y7Un1Zibu6Zvw2tfbzq1RHeYhOPuHY3vn
         3Kqhrf8s4stbqTM8pvo5yHSxDykYYReujp8Yi28SJWkeihWAb+F/GKyOzPV7SvpCLUA8
         PgMcRLsKlQiPzFqyQUlLYOM8eKqzOT728Qt7SSyeG5UyIhW2vPBZVegYLNg7MeLVqJQg
         VgnQf7kCSlDIPdEVERilujk7qNL2lE5zXpIk3eouU0kprS6RfB14WIAHkthU8riYoTvx
         BtAwccOJxkjtf0n38rMgxjsabOgzsUwW2dWRNSOMAq0wlBBxOhQaNm1p3J9OH4qc852o
         J9Ug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774061458; x=1774666258; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OnKSaILKNY9d9t2S+sGZHIQutmsLtF6NiF/zLveN4hs=;
        b=BaZeg+lPn3bDDO9Ha4RNH4cd7w1CsHN8U/WW3uchNkKMZ9/kaPLqbG6xY5gaOzcxIo
         UlXpWFzWBxIGKOuuodOtW6rqa+udxvxr7NxWxiuih9v+il8HSjJda1IEFZTCt7IYH9EJ
         4ozK7REjG45OH7+GKY4QxznYMBLzQD3h8r2k2DgSE5yqwGWRgPqVd6BPED8Fmfaw0pe9
         sd2FLj3MGRo4eQ4zzcr/7vWzoZU144SaamRuO9IZxuayaslVLosi5E0Q2SUA3u1WSM5e
         YsB5vUPaGPBg7hsxsctDVIw4uNO+QtgxV4ZJBP3/QbHpBojeDk/ZF7Q8Vf1As+XHND0A
         ipLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774061458; x=1774666258;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OnKSaILKNY9d9t2S+sGZHIQutmsLtF6NiF/zLveN4hs=;
        b=c/Vbi2sV8C9jECM3lwpjsWbA5gykN+ZgG3BRXgVOyDwvgbi4tZBK1uuhDud/sycAva
         TnSrTsVK5qdVAfasHwyArzJLxMBvqV9uNMRbnSSBrlD5wBMgrAk/fGcOOcTSwT0HYzXB
         LtSZjTVKEC1c6bN8zxQ/DlT4C7kM93s1NB/z07EyPWYuCWqiA+UBV3Zsa78/Z0g/0QND
         dmFZh41nQ3Uc3UZF2NivyKdJ8K37vu6C1K6yHRtWd6fLD2cRgarnZdIQerrVsdsu7rf5
         S2idr6Mvc0KNPeS/hng1Mmdbnr+VQIebAWrUSE2kZQgtqGTbQkVqpDaxtVmqA1pCrQd1
         Ke0w==
X-Forwarded-Encrypted: i=1; AJvYcCUXWp6ERrMOXPEJLKVo4xd9bDSz+Mj+WrHruuMRjZmbvuDusErxG5ql4P/pttr+2fNp9mibOwdvAXaVL+IRsfoD@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3tZEe7knTVSIQxLyQrKQx33J6sdvq40opD6VxwnzNpo0lcHuP
	NLY4qUz+sALxT3pb68c9jacwweCI79gFZ9mLK4jB7BSfXqGbYbK6m/qZQaDor3jTYx6a4ieX7Vd
	5ENOjnhyIV9I9ulqG6eYvPdIkl26BCu/mcm1KVv1j
X-Gm-Gg: ATEYQzzwn2hJCzfSfL9FlcLAA4ughaX1ZFAAmJSB4E/yVAu9LTnRcEm+UdrmgJCTQA4
	+xzcy8PiSWsv6RN0clv+auYu6bCC4knE515/sLokLjsmXADM7t5HfOLwGCddgN0InZvqwAnKBeS
	xWwPgfVN+v6JONYPPj8uG4xrVq2Wj8114aNJJlRcVUayjGh6Dz9S/IT7iSSjZ8C2r+JsEoHDJLa
	T0ldrsgIokvohBEeC+peWFaZ+fX702/KILequZR1XR+fQsX8HSIRIq/tKFIU8L4onxq/6jY39u7
	uGox1MCaATBdKFuyX5U=
X-Received: by 2002:a17:902:cec6:b0:2b0:7a9b:82f3 with SMTP id
 d9443c01a7336-2b08b2a1431mr1614445ad.8.1774061457424; Fri, 20 Mar 2026
 19:50:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306185022.2016541-1-irogers@google.com>
In-Reply-To: <20260306185022.2016541-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 20 Mar 2026 19:50:46 -0700
X-Gm-Features: AaiRm528RSLShTIi7awfAybN6VfwO63THdxIiR2qAoHjMHicV_G0GmfaaCQUNJ4
Message-ID: <CAP-5=fX6ttKud+b0sDS2SjHytocVNq8Ga7j66LFwRBXOwKJ85g@mail.gmail.com>
Subject: Re: [PATCH v1] perf ftrace: Proper error clean up in print_profile_result
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 10:50=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> The ftrace profile_hash is cleaned up on success but not on memory
> allocation and empty paths. Fix by running the clean up for all. Free
> the profile too, so make it NULL, just for clarity that this is all
> clean up code.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  tools/perf/builtin-ftrace.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
> index 6b6eec65f93f..19e796e58fb0 100644
> --- a/tools/perf/builtin-ftrace.c
> +++ b/tools/perf/builtin-ftrace.c
> @@ -18,6 +18,7 @@
>  #include <poll.h>
>  #include <ctype.h>
>  #include <linux/capability.h>
> +#include <linux/err.h>
>  #include <linux/string.h>
>  #include <sys/stat.h>
>
> @@ -1369,17 +1370,17 @@ static int cmp_profile_data(const void *a, const =
void *b)
>
>  static void print_profile_result(struct perf_ftrace *ftrace)
>  {
> -       struct hashmap_entry *entry, **profile;
> +       struct hashmap_entry *entry, **profile =3D NULL;
>         size_t i, nr, bkt;
>
>         nr =3D hashmap__size(ftrace->profile_hash);
>         if (nr =3D=3D 0)
> -               return;
> +               goto out;
>
>         profile =3D calloc(nr, sizeof(*profile));
>         if (profile =3D=3D NULL) {
>                 pr_err("failed to allocate memory for the result\n");
> -               return;
> +               goto out;
>         }
>
>         i =3D 0;
> @@ -1403,6 +1404,7 @@ static void print_profile_result(struct perf_ftrace=
 *ftrace)
>                        p->st.max / 1000, p->st.max % 1000, p->st.n, name)=
;
>         }
>
> +out:
>         free(profile);
>
>         hashmap__for_each_entry(ftrace->profile_hash, entry, bkt) {
> --
> 2.53.0.473.g4a7958ca14-goog
>
