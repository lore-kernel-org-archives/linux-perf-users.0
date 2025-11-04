Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92271325486
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Nov 2025 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762278032; cv=none; b=uEDOVr0WtJzsiiOFmwV58E6PzMpdgJ3KSn+7wJpNn5dDN8OWBZIqw8tZSq5Qlkl31h3BqOLa9GAJ202TVLIk5HRS7J6zJwZLiA1zKiFF7fgvuxBzdi00HVpJN2QKPZlLz+eYBBnMU5d1m9oCvf3y0H9IaFTe+WFMFFY/4krlKjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762278032; c=relaxed/simple;
	bh=KamOxSeAipgU1rbqbwPiN5PXNmG3Cc1tJF2iWAItvPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5TXtMsYbEbYpbyxoKNf6hiWD2WTjg84bLR8XKGRYdClhzp0pxXQTf7Q6yGMpm1TVbFa1BiOTVoEJeqAJjOeGsCSr4kjLTelVEJU6lUPUw+AgO/PfAijFnW8L1ujxVAI016a6bHKl1qH2tehYkbbV5VUo87CdbWQTc4PRD1ikLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j6K5JJl2; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j6K5JJl2"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2959197b68eso229775ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 04 Nov 2025 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762278028; x=1762882828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/jfT88xD0KOzcLyagDzpznKX6WWcQ4Tbie23BrW5FcA=;
        b=j6K5JJl2sCKZuadmAnuPeJuhJ2MHuMFu9TSmvIYC5jRodjiLgtKgHVlVFsBjlqc/C5
         nbP3SZgE/zquuQIuMR1pzu5q8dJuR4Yma2MJQhdBzETS117Ys3aM1T1hYLJW5lAPc1N3
         jgUmnlpK3/x+dyRltkwfkzpLgGT58R9dlTsnZZwD/RBcNdC3OOuNdoQRU+HGzTJlegML
         ofK+ofq6FQIC3sjuhmXs5HOs2fu+EIM7xvQH5IcQdh32SSctdl7iFBy+mbZEF8Xct6dg
         TGXDaOC4BqW99TKYMq65bQ5h2Fvu7g6W8k2GkQ2fqOwKduXCNCREz65g1sg4nvbbc7wm
         zYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762278028; x=1762882828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/jfT88xD0KOzcLyagDzpznKX6WWcQ4Tbie23BrW5FcA=;
        b=qHCu1bDl6rbmL0fyRelG+Pw7p6HtagwJCkkUVc8DaVpRgvwRatidGvUcbN0qtNQkPV
         1YwjWpJYDOcmBD3PUTlPa97FvZP7Ysdt5mq9mnE1Z5PXKj7wCqQcF2wJqYonBF6ffoxM
         dxUxo2qd0ZDrln9y/Pi+lemMo+SKTGiWEfV3NI6ojCp2WNMQ72YAuUO27FL5eVUqU5eg
         wtVO5l3CkQG7mYPpNelg+gdBmbgYsQ4Ihonv7riCdAv4SPSdgMrQV23IMLAEXm/0uUfV
         IE0ICwXUa1GWr7fsNF/rjP0fmldgLw/K9W4rKASDGiGGB4Deqdrgtab6taDdVnqxqvH+
         jpWw==
X-Forwarded-Encrypted: i=1; AJvYcCWscz0NcYEQs+rrOI/IN/QIz6VpvV3WKF7n/wQESIHvV2w3bn7IM/+gCkldQJuo29PkxIKeDTymC0ihqh4SJVXy@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6lG8c+ORFL7V2gFgbx+LVbeLnc8Ha7r+WqVzqE59XxN1LILj
	e4mlNp0qroVdy/ZspgHVe5/09GCuudkbDdgqgREoKpigCdBfwyfWHEP6NgFcK3CJiQzeLiUh8Wg
	doT72ZG30Q79IadvdfR/cd3JlQxgA0CUHexobPml7
X-Gm-Gg: ASbGncv/8eALRM4+5dbeCQs9Aa0E6vLfNQkdGhI3Kq8MqdOq3fg8XAP1/ZDUilaQ+Cz
	ycAjyFwKtUhcPmYI31EtwSjoMWC6Q9V/MHS06YweDAfn3VbzEao4NrGMV5Jo5D3G/y25PQtCdAH
	PQK7gPi+0pByjZ3T5wsVMfkGVTevXLQiMgsWaeshAq3Dfl1H8YaFVmxg9MGKRV+XLRn888quxwM
	z7TBXFvuL9BfjjDOXZt/PNQoRulabavJJVvTvSsozScAcChxq/w+F/J0HvjSj1Uj3BM81Me0C5Q
	Kd56rLabjtEyksM=
X-Google-Smtp-Source: AGHT+IFtI0ANt6r/2+hZEYdPo9MIQ3FgcReJoH72fieCO+sc5XMcyfjciKQKi955Fim4SjjM2xy1Dd4lSJ7bJl+AH0k=
X-Received: by 2002:a17:902:e888:b0:26a:befc:e7e1 with SMTP id
 d9443c01a7336-295fdaee3aemr6120715ad.12.1762278027330; Tue, 04 Nov 2025
 09:40:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250821-imx94-ddr-pmu-v2-0-052c6420605d@nxp.com> <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
In-Reply-To: <20250821-imx94-ddr-pmu-v2-3-052c6420605d@nxp.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 4 Nov 2025 09:40:15 -0800
X-Gm-Features: AWmQ_bmwvZDCteGTl9ZAIX7nqQG3lPWAF4Bp-vTXqzNi5uHkHP-MkyAZWUz5qN8
Message-ID: <CAP-5=fUd24kWOG7=8DpmiaMXkwdf9=BOzmoTrjn9b5Da0ZfP3g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] perf vendor events arm64:: Add i.MX94 DDR
 Performance Monitor metrics
To: Xu Yang <xu.yang_2@nxp.com>
Cc: Frank Li <Frank.li@nxp.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	John Garry <john.g.garry@oracle.com>, James Clark <james.clark@linaro.org>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-arm-kernel@lists.infradead.org, 
	linux-perf-users@vger.kernel.org, devicetree@vger.kernel.org, 
	imx@lists.linux.dev, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 21, 2025 at 4:02=E2=80=AFAM Xu Yang <xu.yang_2@nxp.com> wrote:
>
> Add JSON metrics for i.MX94 DDR Performance Monitor.
>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

Acked-by: Ian Rogers <irogers@google.com>

> ---
> Changes in v2:
>  - add Rb tag
> ---
>  .../arch/arm64/freescale/imx94/sys/ddrc.json       |   9 +
>  .../arch/arm64/freescale/imx94/sys/metrics.json    | 450 +++++++++++++++=
++++++
>  2 files changed, 459 insertions(+)
>
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.js=
on b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> new file mode 100644
> index 0000000000000000000000000000000000000000..aa7b58721dc7e23dc9d9905a7=
9e0c1778b7bbf11
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/ddrc.json
> @@ -0,0 +1,9 @@
> +[
> +   {
> +           "BriefDescription": "ddr cycles event",
> +           "EventCode": "0x00",
> +           "EventName": "imx94_ddr.cycles",
> +           "Unit": "imx9_ddr",
> +           "Compat": "imx94"
> +   }
> +]
> diff --git a/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics=
.json b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> new file mode 100644
> index 0000000000000000000000000000000000000000..629f1f52761e2210ef43a9cbb=
a175871817e1230
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/arm64/freescale/imx94/sys/metrics.json
> @@ -0,0 +1,450 @@
> +[
> +       {
> +               "BriefDescription": "bandwidth usage for lpddr5 evk board=
",
> +               "MetricName": "imx94_bandwidth_usage.lpddr5",
> +               "MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi=
_mask\\=3D0x000\\,axi_id\\=3D0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,ax=
i_mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32 / duration_time) / (4266 * 1000=
000 * 4)",

nit: It is possible to have metrics use other metrics, this may read
better as (although I can't recall if the '.' needs escaping - I'm not
sure if the 4266 is significant):

((imx94_ddr_read.all + imx94_ddr_write.all) / duration_time)  / 17064e6

> +               "ScaleUnit": "1e2%",

nit: I think this would read more easily as "100%"

Thanks,
Ian

> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bandwidth usage for lpddr4 evk board=
",
> +               "MetricName": "imx94_bandwidth_usage.lpddr4",
> +               "MetricExpr": "(( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi=
_mask\\=3D0x000\\,axi_id\\=3D0x000@ + imx9_ddr0@eddrtq_pm_wr_beat_filt\\,ax=
i_mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32 / duration_time) / (4266 * 1000=
000 * 4)",
> +               "ScaleUnit": "1e2%",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of all masters read from ddr",
> +               "MetricName": "imx94_ddr_read.all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of all masters write to ddr",
> +               "MetricName": "imx94_ddr_write.all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x000\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of all a55 read from ddr",
> +               "MetricName": "imx94_ddr_read.a55_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3fc\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of all a55 write from ddr",
> +               "MetricName": "imx94_ddr_write.a55_all",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3fc\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 0 read from ddr",
> +               "MetricName": "imx94_ddr_read.a55_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3ff\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 0 write to ddr",
> +               "MetricName": "imx94_ddr_write.a55_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3ff\\,axi_id\\=3D0x000@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 1 read from ddr",
> +               "MetricName": "imx94_ddr_read.a55_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x001@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 1 write to ddr",
> +               "MetricName": "imx94_ddr_write.a55_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x001@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 2 read from ddr",
> +               "MetricName": "imx94_ddr_read.a55_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x002@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 2 write to ddr",
> +               "MetricName": "imx94_ddr_write.a55_2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x002@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 3 read from ddr",
> +               "MetricName": "imx94_ddr_read.a55_3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x003@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of a55 core 3 write to ddr",
> +               "MetricName": "imx94_ddr_write.a55_3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x003@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m7 core1 read from ddr",
> +               "MetricName": "imx94_ddr_read.m7_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x004@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m7 core1 write to ddr",
> +               "MetricName": "imx94_ddr_write.m7_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x004@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m33 core1 (in netc) read fr=
om ddr",
> +               "MetricName": "imx94_ddr_read.m33_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x005@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m33 core1 (in netc) write t=
o ddr",
> +               "MetricName": "imx94_ddr_write.m33_1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x005@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie2 read from ddr",
> +               "MetricName": "imx94_ddr_read.pcie2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x006@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie2 write to ddr",
> +               "MetricName": "imx94_ddr_write.pcie2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x006@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP=
 transactions read from ddr",
> +               "MetricName": "imx94_ddr_read.cortex_a_dsu",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x007@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of Cortex-A DSU L3 evicted/ACP=
 transactions write to ddr",
> +               "MetricName": "imx94_ddr_write.cortex_a_dsu",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x007@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m33 core0 read from ddr",
> +               "MetricName": "imx94_ddr_read.m33_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x008@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m33 core0 write to ddr",
> +               "MetricName": "imx94_ddr_write.m33_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x008@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m7 core0 read from ddr",
> +               "MetricName": "imx94_ddr_read.m7_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x009@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of m7 core0 write to ddr",
> +               "MetricName": "imx94_ddr_write.m7_0",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x009@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of sentinel read from ddr",
> +               "MetricName": "imx94_ddr_read.sentinel",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00a@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of sentinel write to ddr",
> +               "MetricName": "imx94_ddr_write.sentinel",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00a@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma1 read from ddr",
> +               "MetricName": "imx94_ddr_read.edma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00b@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma1 write to ddr",
> +               "MetricName": "imx94_ddr_write.edma1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00b@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma2 read from ddr",
> +               "MetricName": "imx94_ddr_read.edma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00c@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of edma2 write to ddr",
> +               "MetricName": "imx94_ddr_write.edma2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00c@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of netc read from ddr",
> +               "MetricName": "imx94_ddr_read.netc",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00d@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of netc write to ddr",
> +               "MetricName": "imx94_ddr_write.netc",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00d@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of aonmix read from ddr",
> +               "MetricName": "imx94_ddr_read.aonmix",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x00f\\,axi_id\\=3D0x00f@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of aonmix write to ddr",
> +               "MetricName": "imx94_ddr_write.aonmix",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x00f\\,axi_id\\=3D0x00f@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of npumix read from ddr",
> +               "MetricName": "imx94_ddr_read.npumix",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x010@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of npumix write to ddr",
> +               "MetricName": "imx94_ddr_write.npumix",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x010@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc1 read from ddr",
> +               "MetricName": "imx94_ddr_read.usdhc1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc1 write to ddr",
> +               "MetricName": "imx94_ddr_write.usdhc1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc2 read from ddr",
> +               "MetricName": "imx94_ddr_read.usdhc2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0c0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc2 write to ddr",
> +               "MetricName": "imx94_ddr_write.usdhc2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0c0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc3 read from ddr",
> +               "MetricName": "imx94_ddr_read.usdhc3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0d0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usdhc3 write to ddr",
> +               "MetricName": "imx94_ddr_write.usdhc3",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0d0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of xspi read from ddr",
> +               "MetricName": "imx94_ddr_read.xspi",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x0f0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of xspi write to ddr",
> +               "MetricName": "imx94_ddr_write.xspi",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x0f0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie1 read from ddr",
> +               "MetricName": "imx94_ddr_read.pcie1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x100@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of pcie1 write to ddr",
> +               "MetricName": "imx94_ddr_write.pcie1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x100@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb1 read from ddr",
> +               "MetricName": "imx94_ddr_read.usb1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x140@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb1 write to ddr",
> +               "MetricName": "imx94_ddr_write.usb1",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x140@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb2 read from ddr",
> +               "MetricName": "imx94_ddr_read.usb2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt2\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x150@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of usb2 write to ddr",
> +               "MetricName": "imx94_ddr_write.usb2",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x150@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of pxp read from ddr",
> +               "MetricName": "imx94_ddr_read.pxp",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt0\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x2a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of pxp write to ddr",
> +               "MetricName": "imx94_ddr_write.pxp",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x2a0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of dcif read from ddr",
> +               "MetricName": "imx94_ddr_read.dcif",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_rd_beat_filt1\\,axi_=
mask\\=3D0x3f0\\,axi_id\\=3D0x2b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       },
> +       {
> +               "BriefDescription": "bytes of dcif write to ddr",
> +               "MetricName": "imx94_ddr_write.dcif",
> +               "MetricExpr": "( imx9_ddr0@eddrtq_pm_wr_beat_filt\\,axi_m=
ask\\=3D0x3f0\\,axi_id\\=3D0x2b0@ ) * 32",
> +               "ScaleUnit": "9.765625e-4KB",
> +               "Unit": "imx9_ddr",
> +               "Compat": "imx94"
> +       }
> +]
>
> --
> 2.34.1
>
