Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE2C8E6
	for <linux-perf-users@vger.kernel.org>; Thu,  2 Oct 2025 15:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420630; cv=none; b=qtBk17GMo9fjm6AoLnTR3MLEYM5+rIs/VmBpgToFisi8tPRBqwNAdUXNfwFI0pq74+JIOWeKIDsCDusNmCDNHJgwWYYtvbfzieRsHwMEcD7o+LkLOHz7e28m2woXN2NHIsrfrRfRJREhFhvi4vL/bmHPCnhjGmrYcbnCyvOirZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420630; c=relaxed/simple;
	bh=XfUV5XegIWPsrtsXcJ939TwFlfhwct8RclP4jki8I7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOZqx8Rcdo+pbSrrzD2hj5fQDelziYMdu/JaH0PyPsYIfimda19oe3uoAQYGYHyZ/uCekJ8pkCT7LlEyD7qRjIhQhF9gt558e8uXStWFRRh5FxCxpQauw/wz7HOXe4/16AB7UKK5oh2RIMluq74s5rtdyh/Dsrj3LRByFskRPbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lkw8uNej; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lkw8uNej"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2681645b7b6so169195ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 02 Oct 2025 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759420628; x=1760025428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dY0WE2c/yXBySLtJpxfHDCV+p1YIydI9WOBXVmdAH3E=;
        b=Lkw8uNej5nBpEbADQJAfE6o3XmCPVJKxsWkloRqHBjvofXOyVstWQXf9zj+0lrMwzP
         gPqrZy2Hwgs29OYJDn6w8YzJ8nZtlRXYRQ52u/MBDAFJNc7zEudtpMIlOUgBtySVTBmR
         5UX4yoKpfQnEovzadYwCnStsELir1c2hTqhW9iGrIeYAHrFixUKFu8mhtXMn6oHjg19I
         bTN6vZxaq+AM9Jy9wciA5zmaix+8q4IvchuNPLM34TEZwtzeJTjxyZ1zf3udStc6/iyN
         oB3sDr6vSLzcRKw28NiImTH5O5oYxdOTDx5YTOOZ+T3IvV4/BwQp5ekGGOo+hckvBs6i
         ovfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420628; x=1760025428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dY0WE2c/yXBySLtJpxfHDCV+p1YIydI9WOBXVmdAH3E=;
        b=OhRNL3lbPD5IBgaESzrj3b0WC3VRXX8KQnARtVqfPQ8dGhbp2S+kCSKoEoTBH+8lWR
         9QJNx6gEqQZ+kHNmhzqN2P05B8VU/bC2du3fOwjbRCwb67PXeRVBHbOIrA9nlQVITbFY
         8qFEMSHaI0tWSmd+Frjg3qbmfxtfbLGnejL7angpu0MB83/atuN5kw2kMGRX+ZjWTNC+
         14H91KAmQDPkqcrFcueQgfbJU/95UHVznL4MgK2GO5JfPTcFDWnAY7LFmOoh2iorgYh7
         0u+w3HxviVtyP1L94r9YApU90C+OJBtwIo+VQMTZ+IoNNacT+KF4DgAWKUGsqqFSn88V
         /FjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2Gbn93+MIXg6Mfc4/vUUnoQjNznJmPgMQYrdtMv9P1deA5BPAc+F9uE0qLEWOhNg3JX6w4+GNueMIY19I6UIn@vger.kernel.org
X-Gm-Message-State: AOJu0Yx372pKr2IsP8FTpLpDzbFP3Gn76eDhS5AjULzbciCO6+7YdrpW
	PiwsRzuELbtmmZEFrGFms1MFCE/F5jNSrcKnbXyz0aRXQUH2BQzdWj8jFdOm0jiyJHTt5qi3oXU
	1ILbAHNhdHQbY8yUFjoFhWJ1fh5ZNrKd+UQ0MnWGl
X-Gm-Gg: ASbGncut8GjiJyzTCIL0aCuHmmPyxBZEHr6kNKoUQwhic1NTk4Bg31JGRr+ArDqsiKi
	w2G3jcCAk3ERCG3ERH39dEFllXAPHP/Vy1hjE4LdcmqbJsaxjt88p35UbAosCEJekMU6Aij3ozE
	KxY17Q6pOsUWXO9V/44DnfJwCAwrx+y5PnIZbgw9Qo5EzfwauIyaflPE/l8ChlcxfNGp8YUOigV
	kPS3FWCslteQ3Mw2FOcVrNJatkPxBa/NnKtnycIMxnIc2QKFqcr/6aQoycwYF7P1/zEb93S66TL
	Q40=
X-Google-Smtp-Source: AGHT+IFbZu1sX8rBFZojBP9UQNCMTAzswKj1VcmmvPpI30Vfx/Wg4Icxratlw1QrTSPIXIcpDbqGAINXJPK4JsnalZw=
X-Received: by 2002:a17:903:2b0d:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-28e8ea7de2amr3923265ad.7.1759420628173; Thu, 02 Oct 2025
 08:57:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aN6eqf1nPwrfa4YU@x1>
In-Reply-To: <aN6eqf1nPwrfa4YU@x1>
From: Ian Rogers <irogers@google.com>
Date: Thu, 2 Oct 2025 08:56:56 -0700
X-Gm-Features: AS18NWAy6ttVGBpCCgBQZyRBauFGyVfxgmuuXkbFv4KEUdNgaAHzZZ7yH-EwHbQ
Message-ID: <CAP-5=fWBCcwF9jcOh+vWwKU0P04oiTSu2n+bO+X3SaqeDLtx=A@mail.gmail.com>
Subject: Re: [PATCH 1/1 v2] tools build: Don't assume libtracefs-devel is
 always available
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Gabriele Monaco <gmonaco@redhat.com>, 
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kan Liang <kan.liang@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:47=E2=80=AFAM Arnaldo Carvalho de Melo <acme@kerne=
l.org> wrote:
>
> perf doesn't use libtracefs and so it doesn't make sense to assume it is
> always available when building test-all.bin, defeating the feature check
> speedup it provides.
>
> The other tools/build/ users such as rtla, rv, etc call $(feature_check
> libtracefs) to check its availability instead of using the test-all.bin
> mechanism, stopping the build and asking for libtracefs-devel to be
> installed.
>
> Remove it from FEATURE_TESTS_BASIC to not have it as available, as noted
> by Ian Rogers during review.
>
> Acked-by: Tomas Glozar <tglozar@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Gabriele Monaco <gmonaco@redhat.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/build/Makefile.feature   | 1 -
>  tools/build/feature/test-all.c | 5 -----
>  2 files changed, 6 deletions(-)
>
> diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
> index 9c1a69d26f5121fd..531f8fc4f7df9943 100644
> --- a/tools/build/Makefile.feature
> +++ b/tools/build/Makefile.feature
> @@ -83,7 +83,6 @@ FEATURE_TESTS_BASIC :=3D                  \
>          libpython                       \
>          libslang                        \
>          libtraceevent                   \
> -        libtracefs                      \
>          libcpupower                     \
>          pthread-attr-setaffinity-np     \
>          pthread-barrier                \
> diff --git a/tools/build/feature/test-all.c b/tools/build/feature/test-al=
l.c
> index e1847db6f8e63750..2df593593b6ec15e 100644
> --- a/tools/build/feature/test-all.c
> +++ b/tools/build/feature/test-all.c
> @@ -150,10 +150,6 @@
>  # include "test-libtraceevent.c"
>  #undef main
>
> -#define main main_test_libtracefs
> -# include "test-libtracefs.c"
> -#undef main
> -
>  int main(int argc, char *argv[])
>  {
>         main_test_libpython();
> @@ -187,7 +183,6 @@ int main(int argc, char *argv[])
>         main_test_reallocarray();
>         main_test_libzstd();
>         main_test_libtraceevent();
> -       main_test_libtracefs();
>
>         return 0;
>  }
> --
> 2.49.0
>
