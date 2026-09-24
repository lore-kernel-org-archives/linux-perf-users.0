Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9E7322B6D
	for <linux-perf-users@vger.kernel.org>; Thu, 24 Sep 2026 03:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790221171; cv=pass; b=bBCdXTVi7Fm1jqdZ7Q85VlxdnUAJ69i/89k0DioGBLFpgdgFKhOYEyk/eOblmO7cFz48Yj5Sm3vGnlGwt2xWQnAUfFmPox6QTsHo5ybdIoI+WbYxXK4Pf0uduB52/nND/6X6W7HuzqSvXglaQUugbFcdIWzDmYOKXtCyuk7yHTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790221171; c=relaxed/simple;
	bh=fGksLTEQdisW4wJr5F6dvnMICWkrI+Db3OT5iI3lrXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mizKuYzmo1ygeYpXR++Bswe8WI2JUGHoxwqtRGeu9gGzygqThCUXgRV+d8sjvfSkoBs0qG7lgNxDXBy9rPMG7AYGk9CKKc3OR9rMy9HZt4R/LZ5gnKN6GyF579QiFiKE25UScd8jmF/UCWFMPriP25WeoRStU3RibkUbcKV8W/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EAMxywvB; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EAMxywvB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-532e9ad9a1eso91151cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 20:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790221169; cv=none;
        d=google.com; s=arc-20260327;
        b=Ikjg1gba/6H/0ZF2XaMlwgHkVv/Krd6aUPgC5RNU6/g7KgaR4WA3mpUdEL2VMKAWJ4
         vlnsf3H28tQg2Si6Sc2i5lBZUfNnk+2elNzPG+asS5c0rH0syfT8iapdbjikpDZV+6Z/
         tNuKrToRbm6RzcGu4hgRVJ0RHQx1c64vsaFbsf89C/QbmEHj2kPh10p9uOLLMIY2cfTp
         +DLX2dpnhgtP2lHRe8tSMB4BIF+EABzNCPspM4U/Up3jLirSJbpDiSfqwueMeo1a6L9J
         aKH7/Vv968APzHJq/JxlV2TYo7VFbvNmhRvgaCL3ctjNB7WyinwxIvucb4c6NTSJDyhv
         Mpsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InKJQQCOPRqbPlss8oCpbkbxv3WxU2400I74ZRffvr4=;
        fh=2rxbmK9Y2tRnrK8TuMYTWAIj3y4kRl9/4iNVegqrtUM=;
        b=dBRWpd46Pg1atyCYXPrKNDOdhDzzJaktRMjiHj9ShgVs2MtZHqmvKCxaFS4Di09QJT
         jJyOerO+elKnYDKNrl9CQmVqjlBdvxBlrKEYSX+Km5IkH2ZVmWS6hYhV9cEiIPef+TV/
         6fcW6aNP32VZhZbTBOxSMNIMgNrF6WKmp2P1lSnzSz2vQokObvGvRdq9qtwvydbcyrsu
         5+HQt7o5yDObvhTiwQGFN9I764Niw02rHDj8NLwcSp62WtsfE8QZgf2nsL3qFML4I0yS
         GbNpBAIAc/582VfKmdQrpMaxc087aoAd+JVI3RwIf+1NjK9H5BKlY17hFiqkhQFD+PSE
         v6Tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790221169; x=1790825969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=InKJQQCOPRqbPlss8oCpbkbxv3WxU2400I74ZRffvr4=;
        b=EAMxywvBE9LjrzW0NWV5Q2j8kN6cFdINYa5qkCzmzZuKHpzwyDjYrpD9Ql5MM5LhN3
         DFEWsx90W26woQYCxX0Rn8LZyflQK0Em+eJst3WbOoUVgXxX/0p5pBVxcgg4nTqhVJ/h
         j5IKMRMhBJBAWFWeBr91YM/y53/BGS+ygiZgUSiurUPJ/pB4sOGmdXmeC6t7Cb3B6UoJ
         +C4ZbP15YAlVAlzfP4kTheIY+pIy8DxlxI3hDVwAbH9OfK7zqmgYp/zwcjqoYtWeFE+3
         zlq6v9St4DNmVnNsoSY1HEKSKWemvD62vHn+3aPY1xDt5Z1TXhxiMKV+KdRfY71H6fr2
         SlSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790221169; x=1790825969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InKJQQCOPRqbPlss8oCpbkbxv3WxU2400I74ZRffvr4=;
        b=jNCFhdENI0MfmzN347kkLNOEda4akUPBCi7FdELDC3BSZiGweOkHhyVmxwT6yoNzt3
         v/hkw5SUsS/Yse6ws5TqnFwWMU8w9I7ej99+e1Wo3YuRmmdwuE/BUJDjzYUpzTidVIlf
         3Of5oZP50e52GrCuNN7Q5hkVd1H3N4lh63+Ap45otob1hi5monbQxk+nZxFjPPXC6Lom
         SBZcf6InMvQ7YG+WzdZCmD6XX/Hpv7cT28mlP087+RITb8ccIe540dH/Rj1CPNYffKlA
         WfR5H7yNKh3kXX19icA0xCZR1+WqFAzvUwJGR8ueJh+Q525WgdM94qGe/Xys5XDYYntW
         4UDQ==
X-Forwarded-Encrypted: i=1; AKwUvBzW4XVuk1k+rTRCIc+jLrLh4MnJbF6Lfk7r/yRSarBLgAz/TQh7OtmvzoL/aE1M80ppvAAC+rKZER25o9y9R0Ei@vger.kernel.org
X-Gm-Message-State: AFuF++nqqvqV8HxWXCqebOVi+QHqAmZxvoe7+rwKtL9l4R09tahRe/mu
	UhInRHQwwBTuEy628Okqe+OsBqcQFvl7dTQJPzUL1uAPrf2wtqxPnPtLw6a59/i52h3evE3khQO
	nIh2oSJiNGGZy5xGaNncciOfvTVzce9/xD8pBiN7F
X-Gm-Gg: AYBFou1JvKA9s6w206sKzZ1ifajbwkoelzOBM5LbuY9eekRtDAq46mObx0+VF8DHHbv
	OazeBc++S1kh9A1oMRD4CzsqNK11eHSS303YpePT/J2kl8iio/WqSfq4tYO3spN4LbxTMVD/z9h
	ZP0qfB9n8rrRB+ZPJDjSrOyQUEXFu7aeDMYmOsf9/CRzfKPXr+V1P4ZVTxMBCQy6KoppxHPe0BC
	dARjB2UzEetv2UcC/wuDHFwwN9PoK42Iw3YWD2EdUCBGPtt37Q5q/yD5uljtF5OOKF23SBwNqoL
	1Cihh4WkYifA47kqFHXNFxPXXbmwJg4/2a89G2b5Zfp38qIgc8v3UrVQgsLkVBu0Cw==
X-Received: by 2002:ac8:5907:0:b0:532:ad75:e432 with SMTP id
 d75a77b69052e-532fea67702mr2293511cf.8.1790221168556; Wed, 23 Sep 2026
 20:39:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923215255.3329181-1-namhyung@kernel.org>
In-Reply-To: <20260923215255.3329181-1-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 20:39:16 -0700
X-Gm-Features: AclHuK9XnE0LiW7nXbe7EWNZaKPqTqC9HteFYo1ykilXqCGOj8UXWSio3_EVr60
Message-ID: <CAP-5=fUBb818Z6-nyLScXq+KztRaQCeq0NWub+tPNBN3JK-dkA@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf test: Fix errors when deleting data in perf
 record tests
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 2:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> perf record with multithreads would create a data directory instead of a
> file.  But the cleanup and retry logic expect a file and try to delete
> them with 'rm -f' which would fail.  Add '-r' flag to remove directories.
>
>   rm: cannot remove '/tmp/__perf_test.perf.data.ZVHTw.old': Is a director=
y
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Tested-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/shell/lib/perf_record.sh | 2 +-
>  tools/perf/tests/shell/record.sh          | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/tests/shell/lib/perf_record.sh b/tools/perf/tests=
/shell/lib/perf_record.sh
> index 2b9e11b66dc7a801..a95fafb8b6fa8b40 100644
> --- a/tools/perf/tests/shell/lib/perf_record.sh
> +++ b/tools/perf/tests/shell/lib/perf_record.sh
> @@ -30,7 +30,7 @@ perf_record_with_retry() {
>    fi
>
>    for duration in 0.01 0.1 0.3 1.0 2.0; do
> -    rm -f "${perfdata}".old
> +    rm -rf "${perfdata}".old
>      ${cmd_prefix} "$@" -o "${perfdata}" ${testprog_base} ${duration} > "=
$logfile" 2>&1
>      local record_exit=3D$?
>
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/re=
cord.sh
> index 4a4931cb5ba91849..cf8ba3d3411b0bcc 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -39,8 +39,8 @@ default_fd_limit=3D$(ulimit -Sn)
>  min_fd_limit=3D$(($(getconf _NPROCESSORS_ONLN) * 16))
>
>  cleanup() {
> -  rm -f "${perfdata}"
> -  rm -f "${perfdata}".old
> +  rm -rf "${perfdata}"
> +  rm -rf "${perfdata}".old
>    rm -f "${script_output}"
>    perf_record_cleanup
>
> --
> 2.56.0.rc1.310.g51773c2048-goog
>
