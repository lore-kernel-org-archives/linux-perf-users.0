Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QYZdNSY5"
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C76B19A
	for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 10:18:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso43663a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Nov 2023 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701109079; x=1701713879; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YbO6Rn3HgozfB603dwPHxujztq3d0wQRYz9hizN4I5c=;
        b=QYZdNSY5CQWlwu5md0+10k2T/B1aw1+Kg2M0nJrTeMryt/NTBM9PJPydYLgF6PTqYR
         fUxVbiZ927yCL/pcyjsvME1Jb/3L9+DSMUm/2+T58VW18zDZT789fJP9FOZjrARBXX/1
         IXD4x+wUEjJqouXllXdnm4pDn5CnR+cEIkszbs1uBVfhPk8BCRndNoZz2j5Pk87ywWM+
         z7JCrNYi86kgGg8RY5SQMtybUQIcg64IHOY13S6y75JIieZufeiu8/Ppk49VYw6bpFuA
         ZkD9OmSR3OT4zzSqWbJL5dwr9tikMvJuPaaOstPIOMO9j4qJ+VD7+IzxvvYL3Eqr0iNk
         Il1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109079; x=1701713879;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YbO6Rn3HgozfB603dwPHxujztq3d0wQRYz9hizN4I5c=;
        b=v5VJ51tSIwjlEXSsmN43efLCXaJErvyGolibVbQcx7POFZPWRsxoiyQrNoVoAWZZhZ
         DkBxypNUk2gksAzzO/mqMdVvtrSxgP1DWr+d6NCic60IY9LAOY4Vsu7gnI3sx45HdmEZ
         7GKiiWVDyyxuA1QOWFZpv0r4k3upnIP4H74v14cURlxkHHhnSWYLlRrpZ0H4/xt7xXRD
         7qdNCXsjIPxC+7cPJIKlw84ewU56sOTtM2k5Gm3uyZpt61ySZCw4WudKW9SGVFi0sjSA
         3273XUkwsvp9a9t81RJuZUO8uZ80hm74awQm1ZfYmclYEBR1jG/ZB8t34GywtFNsdJZL
         uJHQ==
X-Gm-Message-State: AOJu0Yx6fNwbV5ITLr8UzL5hwEJOG7Xne6STgf6G7jg9uGXgNCNE/8/H
	8nzGmXJk+X9TRYVXzxd/gERXmXPcxYkDJWcNYSePwA==
X-Google-Smtp-Source: AGHT+IGcxh9IUDZlSXE311RsVrwWNEKtFxWrzMAlc7/JeAkg9bemUQ7+Rz1b7VOxjjNQLe6zlmzJJ/CQlZzxCrhVyUw=
X-Received: by 2002:a05:6402:88d:b0:54b:221d:ee1c with SMTP id
 e13-20020a056402088d00b0054b221dee1cmr249061edy.5.1701109079467; Mon, 27 Nov
 2023 10:17:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231109232732.2973015-1-irogers@google.com>
In-Reply-To: <20231109232732.2973015-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 27 Nov 2023 10:17:48 -0800
Message-ID: <CAP-5=fV50dXzK47WyqT-MEX1TfTrEJdGNhuBLSQ3nLE0+F3_Uw@mail.gmail.com>
Subject: Re: [PATCH v1] perf vendor events: Add skx, clx, icx and spr upi
 bandwidth metric
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 3:28=E2=80=AFPM Ian Rogers <irogers@google.com> wrot=
e:
>
> Add upi_data_receive_bw metric for skylakex, cascadelakex, icelakex
> and sapphirerapids. The metric was added to perfmon metrics in:
> https://github.com/intel/perfmon/pull/119
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Ping.

Thanks,
Ian

> ---
>  .../perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json  | 6 ++++++
>  tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json    | 6 ++++++
>  .../pmu-events/arch/x86/sapphirerapids/spr-metrics.json     | 6 ++++++
>  tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json    | 6 ++++++
>  4 files changed, 24 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json=
 b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> index 84c132af3dfa..8bc6c0707856 100644
> --- a/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/cascadelakex/clx-metrics.json
> @@ -1862,6 +1862,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> diff --git a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> index e98602c66707..71d78a7841ea 100644
> --- a/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/icelakex/icx-metrics.json
> @@ -1846,6 +1846,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> diff --git a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.js=
on b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> index 06c6d67cb76b..e31a4aac9f20 100644
> --- a/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/sapphirerapids/spr-metrics.json
> @@ -1964,6 +1964,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/t=
ools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> index 4a8f8eeb7525..ec3aa5ef00a3 100644
> --- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> +++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
> @@ -1806,6 +1806,12 @@
>          "MetricName": "uncore_frequency",
>          "ScaleUnit": "1GHz"
>      },
> +    {
> +        "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 receive bandwidth (MB/sec)",
> +        "MetricExpr": "UNC_UPI_RxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> +        "MetricName": "upi_data_receive_bw",
> +        "ScaleUnit": "1MB/s"
> +    },
>      {
>          "BriefDescription": "Intel(R) Ultra Path Interconnect (UPI) data=
 transmit bandwidth (MB/sec)",
>          "MetricExpr": "UNC_UPI_TxL_FLITS.ALL_DATA * 7.111111111111111 / =
1e6 / duration_time",
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>
