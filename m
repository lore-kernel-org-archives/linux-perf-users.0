Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3cmCFq8F"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9ECF
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 11:39:15 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so2117a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Dec 2023 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702323554; x=1702928354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPV7uaNearP8zA9kFBJU663Ft/w8jrukP3TLLhPBA30=;
        b=3cmCFq8FmHqgF+WuC7o5gZO9EJYKFAGWCFRD30llvKwDtZdrxjf6In9tblQoRp6cPe
         Lx9/WoS9PEG4vJqttQCkrXorppqXu0ivUbsGxvqYVzrjrIHDu8XNcpR6hBoDi+toal50
         FEKyQXZStWJUJjZFmSa3Rn11NvpItkAHNWqtHMxHLaU4nQPi0ewQkNYgEpAhX/fI+kRM
         lEq7d0mcfDxk2uxbmiBCbm81X4O+7QP4oh0JYzTfRAn3eo6RzyKvRLJyZQraZWLI4Ije
         BXCyUNGxHxcfaZP2pF8y5KvOW4MHoY/KnrvanIp8jrMQDd2uL+rgja0kAJDGDppNsOMe
         KpOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702323554; x=1702928354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bPV7uaNearP8zA9kFBJU663Ft/w8jrukP3TLLhPBA30=;
        b=pHLG5FFl8S7Rp9Wj54jVuh5plZPSAga7jOCpchnO2tubFuQmSC+yc5Lut4XTtVgMia
         w8QYSoowNdrH7wYE5YSYDggzrSpm67X+KV0mttrbrlPN2hyjRbJjjJz4T23Ya6Tpjh6C
         6od2+jxI/TFIO4eQ0pa7YENoC5gCyaG1NoNfZhftEDwVSLuTvgwMLI9LY+XjeQMGMEDI
         NGcIMAc6qdmjkfbXBWWHI2gmMN9IhhamElk8dYcY17i/iGKRe1Syk42Dc7X0hVHzKsxq
         xZ5YkpHQ/mVSv4hQ6USL6VO70PGEkCykHTa62q1dfu4D7W+Dq60x6p25af1/Go2RGfsu
         GxgA==
X-Gm-Message-State: AOJu0Yx6XvlqlPd+4e6J5fae44HrOf22+M9G2NrsVdP2BfSl437ktG8Q
	oTlS4wDqha5T2An400Ifbb+wjgAJIFOaAqVH07yuMg==
X-Google-Smtp-Source: AGHT+IFWyamAY0Cu76Wft3lhUxLjx5elTdoJdS0w8kWDI8gqkyOHd+DLn77UDcxpDlIqEXRNnBp8BckkP2sDSGEDCIU=
X-Received: by 2002:a50:f618:0:b0:54b:8f42:e3dc with SMTP id
 c24-20020a50f618000000b0054b8f42e3dcmr278764edn.2.1702323553565; Mon, 11 Dec
 2023 11:39:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129223540.2247030-1-irogers@google.com>
In-Reply-To: <20231129223540.2247030-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Dec 2023 11:39:02 -0800
Message-ID: <CAP-5=fXeZpOg7cHDZmTLvQh=FTamvpdw+=q9vcqrUBd9v7ifLQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf stat: Fix help message for --metric-no-threshold option
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 2:36=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Copy-paste error led to help message for metric-no-threshold repeating
> that of metric-no-merge.
>
> Reported-by: Stephane Eranian <eranian@google.com>
> Fixes: 1fd09e299bdd ("perf metric: Add --metric-no-threshold option")
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping. Thanks,
Ian

> ---
>  tools/perf/builtin-stat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index a3af805a1d57..c77a3308d3fb 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -1255,7 +1255,7 @@ static struct option stat_options[] =3D {
>         OPT_BOOLEAN(0, "metric-no-merge", &stat_config.metric_no_merge,
>                        "don't try to share events between metrics in a gr=
oup"),
>         OPT_BOOLEAN(0, "metric-no-threshold", &stat_config.metric_no_thre=
shold,
> -                      "don't try to share events between metrics in a gr=
oup  "),
> +                      "disable adding events for the metric threshold ca=
lculation"),
>         OPT_BOOLEAN(0, "topdown", &topdown_run,
>                         "measure top-down statistics"),
>         OPT_UINTEGER(0, "td-level", &stat_config.topdown_level,
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
