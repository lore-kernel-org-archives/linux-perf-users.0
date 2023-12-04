Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JvJP4NWs"
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4837DF0
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 11:02:46 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so1564a12.0
        for <linux-perf-users@vger.kernel.org>; Mon, 04 Dec 2023 11:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701716565; x=1702321365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TnoJZxBn1akD3gBCNkqO7z5LOL/dfRt0CuzJTV9dCbw=;
        b=JvJP4NWsKj0O7gE005WcS6i+sTehVWFs3icoKuIbizjUCu5W0XFNTN5FwuXDER/7MG
         YRjAUaSIac9lB9Nq20YWg5Yf+zrlg96TApS7a2HI8wWnnvhqyKXPKsNvEleHpBI1IIjg
         1KQIXj/MCK2RRrYmO7dCzASBYBiatlMxMQs72GTwKKdSaBpj7I0AugiyRkB/cHjcv6GA
         Ym4zMXlasAQjKDJ5oYKoBoikS4yN6rg/KbIrUOk+aRFZ7/8CWp44Kj73p80NvlUISTGI
         ULljNJB6thX07sNnYw1SSJy+ZXTbvWYxfBCll+GP4N4LqAUu1YNxL+SlKPsDw+ggbaSt
         hlOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716565; x=1702321365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TnoJZxBn1akD3gBCNkqO7z5LOL/dfRt0CuzJTV9dCbw=;
        b=rogyN4lp4bUpzO1BJ+JOJ1cDiQrclIMGCDntT2oPTU3MJadKEqenfaXw+O1SA1L+fh
         ugXrNO4lrScIOoSTMJ4dTvkGrxqLgvOD+J5f7KyrVliBa4DQflDtEKzyMGMT/lkw8QXS
         eXOIoqjtjNPJrEGT8AD0MsO+Cdn2jDeCZFdXxNG4ylb+Y4u7fekZapVZV/GGBpPRVlnK
         Wo0+mOPjRMMSjMPC57lQDbvil5lQYQ3TkEjYwavjOVHQX6KCDoitGlF05SD4CtLtpVOA
         PxloaoJMH16DqBSDSWuSMlbVYo/KQ4+dFE85pzTyxn1xzbdIPXHoks8ulOV//OHiWwYH
         GWuw==
X-Gm-Message-State: AOJu0Yw+0psjcYRqdMOjtiwAQSp4wxjEaKDVPwn7eTM0wcjVKqSL7xb9
	QVNuTefP9BbBoZnru278S6m8CMw8E5fVd5KBhyUbPw==
X-Google-Smtp-Source: AGHT+IFxsasyFnZBa9FnFBZicp3ls17foaY1ghbcUf3bVZalwL2VxAoGT930UO0RuiQyMiLRdsXUo8UFlYeQ2dGQeTM=
X-Received: by 2002:a50:aade:0:b0:54a:ee8b:7a8c with SMTP id
 r30-20020a50aade000000b0054aee8b7a8cmr414091edc.0.1701716564523; Mon, 04 Dec
 2023 11:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201021550.1109196-1-ilkka@os.amperecomputing.com> <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
In-Reply-To: <20231201021550.1109196-2-ilkka@os.amperecomputing.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 4 Dec 2023 11:02:31 -0800
Message-ID: <CAP-5=fWr0bmqZjyYiBuMuCD+sPCULmF_q7hU4J8ouvcvwb5Z6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf vendor events arm64: AmpereOne: Add missing
 DefaultMetricgroupName fields
To: Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc: John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 30, 2023 at 6:16=E2=80=AFPM Ilkka Koskinen
<ilkka@os.amperecomputing.com> wrote:
>
> AmpereOne metrics were missing DefaultMetricgroupName from metrics with
> "Default" in group name resulting perf to segfault. Add the missing
> field to address the issue.
>
> Fixes: 59faeaf80d02 ("perf vendor events arm64: Fix for AmpereOne metrics=
")
> Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Sorry, I just stumbled across this and sent a fix too.
https://lore.kernel.org/lkml/20231204182330.654255-1-irogers@google.com/
The patches are identical so I'd suggest taking this one and the first
patch in my changes.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.js=
on b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> index e2848a9d4848..afcdad58ef89 100644
> --- a/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> +++ b/tools/perf/pmu-events/arch/arm64/ampere/ampereone/metrics.json
> @@ -231,6 +231,7 @@
>          "MetricName": "slots_lost_misspeculation_fraction",
>          "MetricExpr": "100 * ((OP_SPEC - OP_RETIRED) / (CPU_CYCLES * #sl=
ots))",
>          "BriefDescription": "Fraction of slots lost due to misspeculatio=
n",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>          "ScaleUnit": "1percent of slots"
>      },
> @@ -238,6 +239,7 @@
>          "MetricName": "retired_fraction",
>          "MetricExpr": "100 * (OP_RETIRED / (CPU_CYCLES * #slots))",
>          "BriefDescription": "Fraction of slots retiring, useful work",
> +        "DefaultMetricgroupName": "TopdownL1",
>          "MetricGroup": "Default;TopdownL1",
>         "ScaleUnit": "1percent of slots"
>      },
> --
> 2.41.0
>
