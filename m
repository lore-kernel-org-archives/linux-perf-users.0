Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6741D5ADE
	for <linux-perf-users@vger.kernel.org>; Thu, 21 Aug 2025 01:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738865; cv=none; b=WJVhMuWkTCke3loHRyzIUvxmJr5qBV5ejn8UX1R+GyYbKNIhGf6fuxi/HF7m0tz8ZEkyPIrePPs1sjCsPxsA3XGbyHlc8nrjfrix53T5dKUAe+rQ9rKJi4eg00vgTotCJvprE4BzrogRgh5dZ8Q8Az+98mqQJLzzf3EKuwCBwDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738865; c=relaxed/simple;
	bh=RYNH5Fn80bdsRjGGIR09BiBns06z0WrpWMzLI0Wu/GE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nMc8aa6xSMNeVtlQifJYYFZ6ryJtuxSnLhnjJUcLUgODo8RnNs+UJjZMjXBNogsv+x9FzHGV8lJs90HQvLnNer0Gcmp7kOMp4dm9N18HAzTpbA7fosXIabUL2q4xqdxt/8OtTKimKEhtaZI+RaYIXMoVovLCIhQOM3mrp9PLxV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zmebX3HN; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zmebX3HN"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-333f8f5ca72so3459821fa.1
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Aug 2025 18:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755738861; x=1756343661; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KCYpRny3qA+sjxXdlk4UywqmKcgpUts7E2+CnSYsDQM=;
        b=zmebX3HN4+lNFfDOrvveHpImIuAXvZsx8SnIm0vqHFrYuou1CuJVejDbNvo6DxyCvH
         /XIhUeBtWCn98kwjCXIrU9rJdy5JWKgdTAJ83CQeA3pStF8GxaXSw9LlhZpvkU+KtMRP
         fGU0zoiBOT6B2SwZl81Qk22sx5JTXsYlvUa8qEtmpOa88bhh+SnI+/7sWWne/4hv7qK0
         Gz+lSgbi4aBghNVWvaL63J7I4FUjuyD5ZD+VZhF/93lYEioYrN1B9UpUxx0wvhDcX4xu
         Ak3aeL7b9PC5RgY9J3mSkdkB9bI+Rb+kh4AWFM1mfAvu9y8MkT7xsKJViQQoFVqK43m3
         f7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755738861; x=1756343661;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCYpRny3qA+sjxXdlk4UywqmKcgpUts7E2+CnSYsDQM=;
        b=WOw3zU7B4P2yR74P1qGBw3WzZw/1phyLwxsC029Z6OX98CwX13ijOTZfrhAQa0toU3
         PMZnOCwAGHgL6NtiSMAHE4CzSIaGlFCoNAtfI0TdtaYOHf8UbmTtNf/RuwDH7zHTH3A0
         zV9thyHPwiBK266haX5/L7T4ldoG9gkGfLNowqedt4HFdV6wJ1JKk51AQlJJSsjoopwC
         z/n8U8a+NtzmWGb213VAilwZGGHOWAMVgCUwfjXwDaMhnCP/IeZmJxfYB8cLq+WWH7VZ
         fc84pL3+1quz4cUbP5jdOy/L7cx3kuKj2M7XeyfJJFz+n37z7Nk3mkJ99P02p7IeGUi6
         LKLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlqUT31sJeafmzhACzeKp0bKvNsR1EvltMA59oL1wugUCLRocgkrobaySMXfFh3dIaMNvchMWPXFgtt2YHy2O7@vger.kernel.org
X-Gm-Message-State: AOJu0YwFVR/s0cimNGbDiSze8gKSd0ssU/ifyKb7wK/ti5KrJy8cNdnf
	ymYh8YrQRFVUnY8gfoP8igBSZ0fNWHruorRnxh//ek2XlGvlBCEgKhv3FTZx0y1dip5Qn8DqSbC
	qxCw3tjWbk6z6QL4NUCdcUDDOSetpCKkn0O+pVLxE
X-Gm-Gg: ASbGncuap3sVRCnqBbH0epK6E1L75Iv37KnE+mwvABnjEPy0INeEXeUuM7kH5gDC/l6
	VuisAGmeNJnZxXFU+xc84LnCTQKmm3UC1k4FfwIvvTqsFXCfuW3cFvhFNjr2WvtWYf8/uKEyqCm
	lOmuCjswIJdP9YeJ/PbH4jh6npDtdMvgGO4MsPX6Hv+2yntCr/QnuIpfV7L0owGurzPaxfn7q/d
	yxCNX6oo8jO4LOeC2Lg+9Ei5ZZ4gqLcMe48Rnp/Z01T
X-Google-Smtp-Source: AGHT+IETu+WGJrhtRV9VHuwi/ck8JYd8pX3ll/eT1ROeF1CZnsMIRL00vhQjhg2HXjIPlxreYuVZ+8/vGfYAVUBxe/Q=
X-Received: by 2002:a2e:a541:0:b0:32c:e253:20cc with SMTP id
 38308e7fff4ca-33549e926a5mr1677211fa.11.1755738861280; Wed, 20 Aug 2025
 18:14:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aKYEpf7xp3NnkBWm@x1>
In-Reply-To: <aKYEpf7xp3NnkBWm@x1>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 20 Aug 2025 18:14:08 -0700
X-Gm-Features: Ac12FXzOF28RR6xZa7Q2rFIJD-4EFx1-2GTlpbXjfttBrprj8oDB-Hsf_xlfQEc
Message-ID: <CACT4Y+YX-ROx0cW4pkDnqbdfbigVycwPLwO12RNbbtX9-Qp73A@mail.gmail.com>
Subject: Re: [PATCH 1/1] Revert "perf hist: Fix bogus profiles when filters
 are enabled"
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Aug 2025 at 10:23, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> This reverts commit 8b4799e4f0f40a4ec737bf870aa38d06288bf0fb.
>
> Not combining entries in 'perf top', so we're getting multiple lines for
> the same symbol, with the same address.
>
> To test it, simply run 'perf top', then do /acpi to see just symbols
> starting with acpi_ and notice that there are various lines with the
> same symbol, press V to see the address and its the same.

With this revert, does it show 1 entry but with a wrong percent?
I am not sure why there are 2 entries for the same symbol, but if we
merge them, we can sum of percents. Is it the right thing to do?

> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/hist.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> index 64ff427040c34112..f3f64aff9b882303 100644
> --- a/tools/perf/util/hist.c
> +++ b/tools/perf/util/hist.c
> @@ -1391,16 +1391,7 @@ hist_entry__cmp_impl(struct perf_hpp_list *hpp_list, struct hist_entry *left,
>         struct hists *hists = left->hists;
>         struct perf_hpp_fmt *fmt;
>         perf_hpp_fmt_cmp_t *fn;
> -       int64_t cmp;
> -
> -       /*
> -        * Never collapse filtered and non-filtered entries.
> -        * Note this is not the same as having an extra (invisible) fmt
> -        * that corresponds to the filtered status.
> -        */
> -       cmp = (int64_t)!!left->filtered - (int64_t)!!right->filtered;
> -       if (cmp)
> -               return cmp;
> +       int64_t cmp = 0;
>
>         perf_hpp_list__for_each_sort_list(hpp_list, fmt) {
>                 if (ignore_dynamic && perf_hpp__is_dynamic_entry(fmt) &&
> --
> 2.50.1
>
