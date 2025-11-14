Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B011F2C21FE
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763139536; cv=none; b=mDmCR7xVgg7e9pbUcZv0q5OncA3twQHn5pOqljKyudjOMqi8sEvcair3ZcTU5f7Mi+YKUsbfZC7wpfNd7HT/okx+qu+s1i1Sxxe24WlzbFKsdXMAsxgzSnvvsX4qQ2uo/GIEfSADh9E/mWSyxV0N2bregq2Tosyzks3435KuW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763139536; c=relaxed/simple;
	bh=vzgDH8xzq40uS5GNCwpYWMhx4+kqnYGqKFW1Ze4OCjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XOajXnPzAHwYHQBoPUTrQebIZKMx8vRea/SqGlb0tcu65BOMIpEdTwr7ZnQDfJ463qM3Ht5FqHUXtQI21SWS9snbgNnoq7GkuW+LAa7SwEyT/Y5yxruJcMlcWNW+de7OxPXsfhqs5rYMhZywJ3EJ+gZuQFGB4hw4fzdfgNM7FNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C+L9snaz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C+L9snaz"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297e13bf404so224615ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 14 Nov 2025 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763139534; x=1763744334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvQNEhmiLQ9/e2D4liU4aL62bET5lSRZ3tynWsU0kxE=;
        b=C+L9snaz0y7P3zRTC3LhvIPCA6XRQ6Uk3pzYI+vCNl+Rt6yLJIQan1dNg7vN1IPnom
         GBbJZT0YysSk/AuCLCkOIlmL6LNL5pdcMV7rnwwUuzXyTRDykvBtfKnSBJkF791kJqT5
         HaGfsDPOJO9Ly83qCWQBRHeusxuJwzof/i9yUz/cNrj/JtsYq0XxIz7Cm6vprDpcXo+c
         ztWiVwafaBXZaSkP7qJ8fJJVCQPACxMAgtco+AxPjcYOOYYIBBQhrqi7Yq6I6nZYUdr4
         nQqxmZLvu8v7E3dsGbFeE3CGeiuFGmLKHCPYTRfPWLPFMxGYMoTthTJ7yEAA9JNcaoWI
         Ajvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763139534; x=1763744334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SvQNEhmiLQ9/e2D4liU4aL62bET5lSRZ3tynWsU0kxE=;
        b=bZglo7wcbg7gnncgTSIdxiohlGJD1i7fP2QMn1gDvrMYaApcV7JyPpy1Xnu97iqK8q
         iYm5tE00F9KO+l5KYhl0f81awLP/jSU5ORRyUeIKWl81q5zTPPIUCEK/9RdniThC6jc5
         ft2nPI8pmiwGTFnMrpB5FgeVL9abb52rVx3fY3852IKkaHdpDC5N3BgssX5e5rRtXJLv
         x7iM68hp66mHHpKYWIk76nTnr8dqZFRUJm4//z6RhITSCzR8bz1MEj407yMlZBx93TmL
         QOsSP8ENrV74fDoftiE4FlaHF2C1Xi+eA1H/tXlRMqMT3lMiukqzx+cdU7ScABfAKkqW
         Qfgw==
X-Gm-Message-State: AOJu0Yyc6FUnUlVHT+j0EMvcmavW9wFDjOgyEj0TesOPiflcMahrJHKM
	3nrQJUTR7reubzvS+LDCkkGYkn3Cvwcpn3mxZjgATmNz2UHZb0+C+MKROoiKUfc3pTFlPNE01Ys
	9M3rCoMl2PfeEhqQfpC2qnbSFAo8SJLbNeT6t67Wr
X-Gm-Gg: ASbGncsG9ygRpK3LO2fQRX9aRuR1Vl1n8P5yvZYdiQNAhSsVdEvC7jUfBrTUZIwkpp7
	xdzVqlILLluXgfv7heJf2VavLkrpttdSoyy0q8U94AwdlUj6gDWabcjXQsf2ruy1phCPqY6X6+x
	/tfdFmu3bkuiTjZ9hsQ45MuL7rtDZ7ldVs/Hm3wcYb8d8qW4NW89bQYFse6V9Ty+GmUwLgPbgzp
	vpHP1aWaWoePVndSbCQCPzr3jX7w6aVashUvMdnoedloz1aq+/mpWT82VGxpds8wUuKBvkgZxsx
	GCVQ2gO0nxrPtM/UviTfqUEobXoEJA==
X-Google-Smtp-Source: AGHT+IHeQ7YAwqZnNtIQHCql/mGPuoLh/LPfDIR0JhCn2ZW3Ga1DntBw1Z8xI09COf2tIWPYOgmz6KUMgbq4lti6s1k=
X-Received: by 2002:a05:7022:4187:b0:119:e55a:8085 with SMTP id
 a92af1059eb24-11b4793dab4mr117257c88.2.1763139533635; Fri, 14 Nov 2025
 08:58:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114140618.229205-1-james.clark@linaro.org>
In-Reply-To: <20251114140618.229205-1-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 08:58:40 -0800
X-Gm-Features: AWmQ_blEKDhrfEVynU3Ab2rfj4nYwfH4jxIcvUlA82RO6L5_WFCzDwJbjMO2G3Q
Message-ID: <CAP-5=fWDMqscf3m3bTog1hMCL6pEjYOsy71Xw7Sbo8inoZE2KQ@mail.gmail.com>
Subject: Re: [PATCH] perf script: Fix build by removing unused evsel_script()
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, acme@kernel.org, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 6:08=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The evsel_script() function is unused since the linked commit. Fix the
> build by removing it.
>
> Fixes the following compilation error:
>
>   builtin-script.c:347:36: error: unused function 'evsel_script' [-Werror=
,-Wunused-function]
>   static inline struct evsel_script *evsel_script(struct evsel *evsel)
>                                      ^
> Fixes: 3622990efaab ("perf script: Change metric format to use json metri=
cs")
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

I saw this on clang builds, but didn't get time to dig in. I'm
wondering why GCC wasn't complaining. Anyway.

Thanks,
Ian

> ---
>  tools/perf/builtin-script.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index cf0040bbaba9..581fb101e8be 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -344,11 +344,6 @@ struct evsel_script {
>         u64  samples;
>  };
>
> -static inline struct evsel_script *evsel_script(struct evsel *evsel)
> -{
> -       return (struct evsel_script *)evsel->priv;
> -}
> -
>  static struct evsel_script *evsel_script__new(struct evsel *evsel, struc=
t perf_data *data)
>  {
>         struct evsel_script *es =3D zalloc(sizeof(*es));
> --
> 2.34.1
>
