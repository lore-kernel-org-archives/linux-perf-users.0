Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CA04D09FA
	for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350611; cv=pass; b=T/hXvTi8GCPdGyV4Fs6+gNhD2ls6NVOlFjC+uQGzvlVwstMG/nlua9+KerQrKQsH5FD2h3F+pAOSLvN2ep2jVEyaNIHrpxRNqqKPY5WuhPlX9TyWy/6vFjvItj31N7swxjnmfuX7JXqReOu57mKIzXOf7mJGu8cW21BXgdJKknk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350611; c=relaxed/simple;
	bh=ETJVPMpJzcUAznXvWNfiozqAROrzK6c0EB+nTNGmH6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aG26nUu+hExP3WTG/JQDM0J9OZZymjfdFuMyaTEROsbY27BF6SP1sEj1/yXp9s88kJZk9/PYN7o1xN93YA5E0XL91XQ4T5JDT1iY33LqqqfMvDJWNZLs1OZuo/gBEgiBP2L3OM7GDmhrXG+mibN82bLBUHFvyVMV9GXkA7OdQ4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=edwnsQsv; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="edwnsQsv"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53113d72966so258761cf.1
        for <linux-perf-users@vger.kernel.org>; Fri, 25 Sep 2026 08:36:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790350609; cv=none;
        d=google.com; s=arc-20260327;
        b=XXlflrlRsZt99CvGiKOTmsrqOz13zUIec+EDxmNgoV96sh4kAZwvzvKv6JdXX+pnLg
         hM8jfXUtK2gG0UPhR4yFhqi/QIiP4Ph8v+gQPnwL8Hae+aPAoPJ8cEfrb7FlsUTWFukx
         j2s9YwILFOkrtmp2h2FEW6IHP5u0wJEtHfemnxLzj4Un1rnPCSNyBaeC9BQ9LUaAMOiZ
         OL+JfFtPmBnscv7ZlcwpEJ04vVnUlo8c4Sf+k+sinMsg4GcNaChWo3X0inASQHmXlOhV
         I6wiS9CVNeU9Xzq0cUNXephRY0P9wWlcS9pzpPr/UjsMEHVnuNhoIsSENWYhZ5mW/tYe
         wUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qv6yjwMH9L0+5sXgmaQRRhA21zs38OM1ICUpeT3O0Cs=;
        fh=5jvUFjSC36Z/Yirw59wD7q4uG2Y6bPcMMVMjCYL/eCg=;
        b=KhYUIaLg6NRwdpyBllAE/K7VLIiSB3azJlQ+jYga0PnsbHGb1wn6J/A2qUnNPYn/jT
         L8kg+wT3DtO4Y2gRpJ+8pAoje9Kkw0oJobJQ8BEUikCFXkmjtd1FO+rEJutActgFvE7N
         rlBxmiowZuCOJ3XcnM00ob7TqWXXjdkKz+OvlFMEul2JuzJiL0szFN0jK1pkC4lLIUB2
         AVrzdpwr6/SlKDTudVK52kP98hFAj6aFRBo2xoZe8z2vf7Ex6MER8oTkwMaPGpOWPVmL
         CYdR+5HhrhnBO399Kd7gErs1IQhvHkXvh1KhBm3mrUTe8yWCW6AVljmOL6FDTOYnnBcL
         HXdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790350609; x=1790955409; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qv6yjwMH9L0+5sXgmaQRRhA21zs38OM1ICUpeT3O0Cs=;
        b=edwnsQsvb31PMQbhQHy0/08GH6nyG+tUM4J3JJkhAqYY3ribcgG60LaEquxoCEBuoB
         eqUdtLIeUL5clhM8knV1nIelH91PRvjGQxkOamJwEDWgC7U7+gmmtzZC02cKcdN9QN3h
         ZV8u/dUCt8Od6RJePkfWNwUyHkJOWR7Wb/5VNaD3PPjVUl5ROAfpEk9AWArN7lGWgzIx
         8GogzhIgNlAESfUgjBgE3d4qchlOkz3D6Zb7q8giI3wm9duGDPEjlRVC2HlinGwgYc/T
         UlF4zwcbCPjN7Ro154sfeT5kkdD8nO6sho7ExR1MEO/wSTObAYGqsVtsF17PRQ7H5Jgc
         umVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790350609; x=1790955409;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qv6yjwMH9L0+5sXgmaQRRhA21zs38OM1ICUpeT3O0Cs=;
        b=rD2GrmqD5Wyyr38W/xb7AuU4oLiyHzQ6fr4Ep9AFCvwlu/G4uddsBtuIkAWsVriKW5
         aVpuMOoJdxwGPrMw/ePLZ1rcnqpwc/F+budYH60YEbYEhICLX3wWx6PmbZwcuxJ4lkqK
         F7WEVymxJzAaX4C9DrTpwt4v93XbRktfIfia9eUvt3FzBkp+cWxXEXKPWl7oBJe39LVb
         YfQ9Q881o/V5g5uJZU7ZcbUaeU81RvB6kQ+msJp1cEh33UDlEwpKG+SMH8UvSDc7XAye
         vSS8M5w0oCHbUyVvl/TY7iN7bJ++opqIUPdb4WDgECY7yjKCtVNlAHA8vBQ3nhadjh+S
         n6Hw==
X-Gm-Message-State: AFuF++m8Ms3XzmiuMvO6+V4Mc8/JZy0PgUH5sEVCDgELNJ5UZje5tBsn
	Gxadyx3V1788uM+YlRumI/8HGPwsFKdNplH/w4tMRwg/VP/xIX0EIe4zkUw8ADjarJ9n8wLkQyI
	ktYgvTVoncInFafj6UVll3Y22P+vgkoyTk0lDJr25
X-Gm-Gg: AYBFou2UIEXP8o6uQSK/n+LB6j2mKF2OJ+U3Sfw2hN4gr0xtDfD5st19wmsgSuTrg/V
	zGgs8r1mYOGZmlnyYjejE24zh0YO69xUQ1QePiKOdSvfohvRQ24KdaghY/pmekMbvPPcURNwPNh
	7OXYAP3f3NepOyBVnrzwzk/EevLAjRVNLrKMJRk/wmJ0HYMPlfV3cOPQoUq05lhPfo/YDcXM/Ey
	P39IhGvkfp/GTh6BCggcJxVJtHpIHnfd5CjPWBKk0/o0/Aa/d5FcS8dDx7WY1wJJojD39p2X7p5
	8NzvOLBGw+bNS09r3Jeodxa8GuPk0POgNQEZf74lpsQPYAQXKhnCdMZaEPr9PdNXkoRcCf+bNHY
	1jEEMyICIYY1ZdnDNom2q
X-Received: by 2002:a05:622a:5987:b0:531:16a:5a3d with SMTP id
 d75a77b69052e-5331a854757mr4724991cf.12.1790350607902; Fri, 25 Sep 2026
 08:36:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <araUAt-S6YM_bbAf@x2>
In-Reply-To: <araUAt-S6YM_bbAf@x2>
From: Ian Rogers <irogers@google.com>
Date: Fri, 25 Sep 2026 08:36:36 -0700
X-Gm-Features: AclHuK8BkqzoQMoV_CDc2mGyENuJX02Azthfg8HnP5mSalUGaUhKyBcyiYr4Nvo
Message-ID: <CAP-5=fUjJqOARxMHwLY2uKDFzroPmfjCDYf-=9C+hshh8bf8Tw@mail.gmail.com>
Subject: Re: [PATCH 1/1] perf test workload: Use unsigned int in
 code_with_type instead of uint
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Dmitrii Dolgov <9erthalion6@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 8:32=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> The declaration of the Rust helper test_rs() uses "uint", a BSD-ism
> that lives in <sys/types.h>, so on glibc it is only visible by
> accident: glibc's <stdlib.h> includes <sys/types.h>, where uint is
> exposed under __USE_MISC, which is on by default.
>
> musl does none of that: its <stdlib.h> doesn't include <sys/types.h>
> and it typedefs uint there only when _GNU_SOURCE/_BSD_SOURCE is
> defined, while nothing else in this translation unit includes
> <sys/types.h>. Building it on Alpine therefore fails with:
>
>   tests/workloads/code_with_type.c:9:21: error: unknown type name 'uint';=
 did you mean 'int'?
>   tests/workloads/code_with_type.c:39:17: error: implicit declaration of =
function 'test_rs' [-Wimplicit-function-declaration]
>
> The second error is a consequence of the first one: with the
> declaration at line 9 rejected, the call at line 39 has no prototype,
> which is an error since gcc 14.
>
> The breakage is only visible when rustc is present, because
> tests/workloads/Build adds code_with_type.o when CONFIG_RUST_SUPPORT
> is detected, and tools/build/feature only checks for "rustc
> --version". That is why alpine:3.23 and alpine:3.24 fail while
> alpine:3.22 and alpine:edge, lacking rustc, build fine and hide it.
>
> Use unsigned int, which needs no header at all.
>
> Fixes: 2e05bb52a12d3 ("perf test workload: Add code_with_type test worklo=
ad")
> Cc: Dmitrii Dolgov <9erthalion6@gmail.com>
> Assisted-by: LLM
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/workloads/code_with_type.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/workloads/code_with_type.c b/tools/perf/tes=
ts/workloads/code_with_type.c
> index 65d7be7dac24d411..d2d437b86e0c6dbd 100644
> --- a/tools/perf/tests/workloads/code_with_type.c
> +++ b/tools/perf/tests/workloads/code_with_type.c
> @@ -6,7 +6,7 @@
>  #include <linux/compiler.h>
>  #include "../tests.h"
>
> -extern void test_rs(uint count);
> +extern void test_rs(unsigned int count);
>
>  static volatile sig_atomic_t done;
>
> --
> 2.55.0
>
