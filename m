Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96C318E19
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 16:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PYtjKeP3"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA7BDB
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 09:31:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40853f2e93eso385e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Oct 2023 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698683471; x=1699288271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUgGBhAUq575qSM0tgYzZcW8UZXPwajt+t4WCeUOLCQ=;
        b=PYtjKeP3xWMUHCaNKBciZ6y+/Nz/MgPTltDDMjuZRB80QQRN/1WeWbqFypAe5toAsA
         sLels+uJbS0zwEah+8/jaB7O/wgYX2qhQcTdlV/OR/D7pRkRyij04JH38v/7l8V8J0ty
         eHLAhBqgOJTZs7UgXteOKbs7+qHU/jZC472WtdyEv/UZ7fBB4UtI272frD6bqxt2HkS3
         IF6d96cuK8FWBP3nEHKiQ8uil4Ml9EaVZckCs8fIzbYXESWnylj56D7WRdQvjk6w6CpG
         zS71o1RYdPP49GW7UOrA5ls1e1/BdEMt3mXpABN5aFmHHE0Uxkf9wrqOFeHirL2vzf12
         kp4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698683471; x=1699288271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dUgGBhAUq575qSM0tgYzZcW8UZXPwajt+t4WCeUOLCQ=;
        b=S0BqY/XMQI7ZQn9b259Tr3mVcqUMGl3czlM2cVqJBp2CMynzQ922kAE6lBZoTsY0J/
         mXu5hOcJBbDi1tRQIhOliP0ae7ZTZw3eV2QqkC3IhVfHbB9CPQH4jZLGXrqKYNwqIwrx
         oWfriHjP2+NPKFm0kBYKZF0dbs3AfT57rVbcAzGo+takZcjy+c0EHzWK7w6gV/enVJSz
         89wML8+5ihvATdpzbQRg8FnSi3TOFGJeC03K9DCiQGZLv4UnyykhpYufTwNa8OgAvgCq
         3F6EQHsk5JsHF9yU4fvnV6QsTHknVtYdXyDowKS5D2eW+RpI94As3uSh+yvpUdcJ2dad
         EWzA==
X-Gm-Message-State: AOJu0YxbME+FxaUuTE6DMwmpRJ+9fvbEqFihhoaKfaoLw6076czTQuyZ
	d4P0rfNYqtnvH2Yj9At4JgYiJG32UgM9lGB3GylS5w==
X-Google-Smtp-Source: AGHT+IHM2pKPoSKXK0V1dT89nWBjcKgKADyzPqg7Dy8ofLAEmOfvrHnweUB3255UvW2FTBui8efpOki/sgyWCoflaoA=
X-Received: by 2002:a05:600c:1c81:b0:3f4:fb7:48d4 with SMTP id
 k1-20020a05600c1c8100b003f40fb748d4mr134778wms.3.1698683470764; Mon, 30 Oct
 2023 09:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
In-Reply-To: <20231030075825.3701-1-zhaimingbing@cmss.chinamobile.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 30 Oct 2023 09:30:58 -0700
Message-ID: <CAP-5=fX6EW+6ZpTkdqKJeeXPjgBiwAGyDLWJGAzoNF5DEYmViw@mail.gmail.com>
Subject: Re: [PATCH] perf tests:FIx spelling mistake "whic" to "which"
To: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 30, 2023 at 2:12=E2=80=AFAM zhaimingbing
<zhaimingbing@cmss.chinamobile.com> wrote:
>
> There is a spelling mistake, Please fix it.
>
> Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/tests/attr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/tests/attr.c b/tools/perf/tests/attr.c
> index 61186d0d1..97e1bdd6e 100644
> --- a/tools/perf/tests/attr.c
> +++ b/tools/perf/tests/attr.c
> @@ -188,7 +188,7 @@ static int test__attr(struct test_suite *test __maybe=
_unused, int subtest __mayb
>         if (perf_pmus__num_core_pmus() > 1) {
>                 /*
>                  * TODO: Attribute tests hard code the PMU type. If there=
 are >1
> -                * core PMU then each PMU will have a different type whic
> +                * core PMU then each PMU will have a different type whic=
h
>                  * requires additional support.
>                  */
>                 pr_debug("Skip test on hybrid systems");
> --
> 2.33.0
>
>
>
