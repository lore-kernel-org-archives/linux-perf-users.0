Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E129543CEDD
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 19:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789501455; cv=pass; b=lWBlVd8S0jwBSO4cOjyFPkNwcqCZQE8oYwsqYoz9se9dCDg6cDJbrKrbokIXQ+761ID0tmsogDfJynqvf+vdpIH9ZOQVNR3ya4gjEgnv+sRAUsiDPtirKYjcUBQkxZB+cq+g0rWdarFaHOcgnbIuufj3tu0L95uWtJfCNhe90AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789501455; c=relaxed/simple;
	bh=H3qSjQGi76PgVHeND0Z40zDpqLslWmiK07Q51ZTkBWw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEru8CIzCrPFvOc1+XZZTs9JhVvLZ8gGqRb0NSs2+gE0141ee5Gp+dzNastgszrZfczs7rCALgUOGFEFVHfyS5npmuXe45gPufciQ9Bw756oRuSEaWZ58qpRkVz5DHG4JB8dBheQmKRyOMhm/FEDaVrP9/49fF+xcn4l0A9lYsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wjXPrTEB; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wjXPrTEB"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530d5fc2cd8so62061cf.1
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 12:44:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789501452; cv=none;
        d=google.com; s=arc-20260327;
        b=J7ZJURK5cejtTDbYvAmNbyrEmOrV6CzOxrs0xEF9OAD8lcJ9GL+f7e5WKzPN4aAQK5
         l45tvHRVmUxT6myXEufllTpWwp9dQ1LViDvvzNXSHI19aj7sk3rrk8SF8UySziew0ung
         iOajbj79zKTe+JmMK6wyjyo4K7dERRKJKbaNIzie+ZIRueegA0ThziGh85LuTwMGCHJy
         TiYFlLnF/tQiepyFzQUfaQSYvUrK2nasEXSUxgAUNk9p3q0lhUv6eiGAeqkzamEsxN2E
         fyM/9SfsqHsV/KPmMr8uyjHdqjHrfVO9r2YdlVlOGapjpHJZcH4HGoIr7J4wRjodxxyV
         KRuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=STuNBH/M2NDqA51kDqdq9V/ip/zqwavA2GBjIvz0ZeA=;
        fh=5sxN6tb02ZJGOMH3Wsb0iSnQ2ZrpHOA/1ekPu6qhCgQ=;
        b=DgFOqpftibGZF55BCG37W67CyaKterrM4uVnnW+ksGo0w/+shb1MTEqgUsmUVDCuAU
         JRlBCSsO7Z1X2JPxX0i5PhrJtkFLMyFAd9iiOTDfP9yScVpLkIokdFjBAm/Ghn8rd6YR
         kUbPJt5Pa0slyPgyH9cLj7yGebc3R2K64FoxguaF8cUAOnuHrrpmCfk0a5YyjJ/IJVgh
         W6rlB0zA8+8jnsY7z2ALOGzdSwlKiKUY89gh1zmorP4QuwD8Pk+2P5ihyaw2qE3pupse
         EN1fhq+N1Sqba4ccHnERUqsftvLcRX/EmvOz/PAwhCTJQBwH9j/p6mimjSnRIT7/tvXe
         HZVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789501452; x=1790106252; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STuNBH/M2NDqA51kDqdq9V/ip/zqwavA2GBjIvz0ZeA=;
        b=wjXPrTEB6e8TgdAvkehFkpV3Uv94wtI6EZsBw1D6wjLmWHh1exdTBibfkcB6fAOyek
         mGqg6xmOYnrgbvQo3uy5afER+FpZRicgChgl8RcauSjLqax85j82KkMukSduGyxUCfpz
         EhKq06535SHS+9/i7zwUhutHZ3pAMR9ao1scFFTHuVx5Goegij42QN6kQCSy0EbCuH79
         XNC2U0bME0Eut6zVfYAtU6yc7hbEi6Y5GDBDBZF4axeaw8+Smxs9ju5sZaNzGLYAdV9G
         biOySafuH4o6HFiATCTCpKm6PASY5APE+/g3P3UVYm99W18jfpTw6gjc+/62PRMncaN0
         JxgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789501452; x=1790106252;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STuNBH/M2NDqA51kDqdq9V/ip/zqwavA2GBjIvz0ZeA=;
        b=hRxQYLEilbgx2sEROoKjFgZBZPA9afTl3m7jsQ2S4cWX9FDONNKCRwaNj0xIxV8t1n
         StixJ6TsjpWUC6s+LsYDsxCQwvQqCCPmDAzF2qrJ7VlXEd1G0ba7Y2I9vUDwhJhCXDvK
         Iah/Nyhpg0isHrA7LjWeAC6KgMHIzbsb7H+6BKUy8+5okHgb/fCx6KZ2E1dB87oLJ1QC
         GiFQ88d+KAuGWrp2ExKZSlLfkzthkuPvFtxjZ+P0cgz7fpdbMItvlm/19c6HC4dl0Lnd
         IUuvBv079dDVRl4MLW8nw7vyUGXK8LeagMpO04kXZp/hlACx+L2U1E+jWsUlB26jHbmK
         scXg==
X-Gm-Message-State: AFuF++lbbyvvybWMW2J+kC0wqcmbmR5IPvYp/bAJpOv7jQ/gyrFMD4W+
	mWHDj3jZEijwH2BBODdbOlsQD60BAFFgEEL4QiCZy2D9ELtljwnNvvsFbOk9+cvZAH6yp2/kVAx
	wBnqUJ4eveU/eqGglpUiXoerE/b44APFDg+qEbrRz
X-Gm-Gg: AYBFou1FuX7pOOF16pMcHj9CbShDFGHGnpA+LMwlh4zCMxb2RbRzTgxvRrh1711gP/o
	HQ4BVFblDMy4BllwBiNYMAIXeicKumnHzR9I7Qkg3v5UlGmkDXcxfxSlKf0LYG4FjZCjFvXCnac
	ubXsQqTmXlu5kdPG2AuInnRXcUDThcOdNTs52MxNUXxW7rIKVZDgaeDG1h78q66hwi4gLGAZCfd
	iRPD68yzz9GeOhmdJbQF+sNSig0LK4zZS5fQoTjWiljsLik4eQ639hU+lqxqkgokTbVd69e2d4f
	L7frwMlVe5M8KiWEHOoUPEKbONX8prmQxFpPp1lJfUv729Kt1hRRbC7nTrJo/PiQXhU8QtYjeo/
	mu5/vkxLgTQ==
X-Received: by 2002:ac8:5a4e:0:b0:531:282:6560 with SMTP id
 d75a77b69052e-53259b49c10mr2158041cf.15.1789501451815; Tue, 15 Sep 2026
 12:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903112835.1694260-1-nanshuaibo811@163.com>
In-Reply-To: <20260903112835.1694260-1-nanshuaibo811@163.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 12:43:59 -0700
X-Gm-Features: AcwNN1VVU0mXc4k_HpwEgXzGNEMH97BhLgpNu8B-eFOs4SAp8P0d4b-6zKavSUc
Message-ID: <CAP-5=fVBi=VSnGQ_uNAb5+Y=mVi5mBz+Zazgw-kS173hR5vDrQ@mail.gmail.com>
Subject: Re: [PATCH] perf sched: Make output_name variable static
To: nanshuaibo <nanshuaibo811@163.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 4:28=E2=80=AFAM nanshuaibo <nanshuaibo811@163.com> w=
rote:
>
> The output_name variable is only used within builtin-sched.c for the
> stats subcommand, so declare it static. This fixes a sparse warning:
>
>   builtin-sched.c:4140:12: warning: symbol 'output_name' was not
>   declared. Should it be static?
>
> Signed-off-by: nanshuaibo <nanshuaibo811@163.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/builtin-sched.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
> index dd39a4fb..22486df2 100644
> --- a/tools/perf/builtin-sched.c
> +++ b/tools/perf/builtin-sched.c
> @@ -4137,7 +4137,7 @@ static int disable_sched_schedstat(void)
>  }
>
>  /* perf.data or any other output file name used by stats subcommand (onl=
y). */
> -const char *output_name;
> +static const char *output_name;
>
>  static int perf_sched__schedstat_record(struct perf_sched *sched,
>                                         int argc, const char **argv)
> --
> 2.43.0
>
