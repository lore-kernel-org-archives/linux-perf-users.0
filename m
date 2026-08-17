Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05FC3E2747
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 22:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787004747; cv=pass; b=geU+VkTloLaA+2dsM+SbHq6747CL6XzCIVTDYGoe2hI6k/D2TIMu1ZTgd3HZgT8ZWlhQEOJNo90w51c47UkkW5Z9z+uP85gcIqsyLHMKaJKhxP/Gt/KZvWKKI9nkbVZhFikjwaeEBSHSaKvS+OHhhOz6JkmOjX6biB+1XaVBbSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787004747; c=relaxed/simple;
	bh=iLpbu0z4sjo1U7tpvvCrLl3BcnoSNOlRezm3ciUSPrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rg0Bu0XHeFxathldeNMx44VGu7vYcRddzy2VdQtGrZJ/7Er4AX72IX/1lkyeaFjqaO/oJfmGdZZyYYM19Con8vA7y/8uEqRqgLhnZjcz236rLkUdr7ofJVdasncWN6begZ7XRoQBR+fCH5KKZFX84ehogGA1VZkbrK10EUsZKnw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KBitHLHB; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KBitHLHB"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c10ed63c0so39191cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 15:12:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787004745; cv=none;
        d=google.com; s=arc-20260327;
        b=JCE9+d8q9BPRGEEnoQ8mY4oiTaLC9mq/e1IaOGYcxCr/YophbLqw9PDkAIslPUH5Rg
         Bb1wv31EtK1GJJCiAGKTmY3Gkf23pEPdNEdVuMNAL/B2s+YuPJAt3EG+viiWiKDJowjk
         HJ9GwuqMHnzck8SaFjDvZscv0Hgb3AliukTVfgCtlmrUW/j7qztDeaZES0vjqRs8l9KT
         PkUwv3l+4cBW/Hf5EVarmBzCrMfUg6v6q5Wn4+9dZ/vVYmvFrp5aXzaAx4NFvLfz2+aP
         EoGQg/hzWer2gWVxiAAUEXEtwKHvEVz4MnUvAZ5q7tH7uIKaK6dVUKygLK2cmYfUNYsc
         VbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3iPop2ujfkMJ3UibadaMeO6Qqp65tzmpjESRscDs1Ek=;
        fh=I41Fs0s3tI4EGd77TevBMbs3sA0UjIjQNbU9z6kvqtw=;
        b=YXvX7nZLX6R/s7d/TnH8JbsPZfQ90WOtvHa37G2AdgSqayg4NYmO580u8ZDMzNLG8C
         FlEQVph1JZOBzQz6uZ9XB/Vzqdicrtnbydz28p2wjoRGFjRuYZuN/x/5KjEOWeybBX/H
         fe66I2qR5rS2ujckimupha/UXrUwizkU/2x3OhK1SCnf+A/qKP+dM5/nEtUsRPfIBh33
         55DQirPKqAB5+AEkhDnfCrBovH/UeKlZqxraLxnnVZgWomHnXWpLYAtyLH4NLg/PlMxC
         bMQwdCaMa5slz7n044kXvFYQAGab9j4Wnb7lt4Qy5cb7QIMR7nveKA8Kiduu/fNLVI6R
         wHzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787004745; x=1787609545; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3iPop2ujfkMJ3UibadaMeO6Qqp65tzmpjESRscDs1Ek=;
        b=KBitHLHBPZ1gWfuNwnHeFet9PJY+lx70yn8jx/QhsbYDv4juFa0uLgWx2ImkmMI6/I
         ytKDFLKgHbANwrMN+73oecsGCIGKjF9NcV6UldI4gwNQs/ghtsKJz6xbd58WnpcfnORd
         h8dRA35Dxh3QnayvTqWKIAcp7RuFircliQVF8gjJVA75dtNVH8rsAvyjxyWCHJHvrIrW
         ZzhlOZMdE++Qrb2e5CMfvLrlJS8T2jQ2AZ+0zM6Okh+dIfY9Uo1YJhi8198SDDeSCF12
         7JkOiw5b4c9ZLrUTiBpu0VeO5IijNqjbeCGUvCUSX28PUZ9mv8Rzbk5dtNWpU8h3Q3SQ
         Xy+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787004745; x=1787609545;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3iPop2ujfkMJ3UibadaMeO6Qqp65tzmpjESRscDs1Ek=;
        b=ZJ2AaLQ0g5MGyIXA007BYKw0xSR5E+9Kx7c7ajwrhBXV/f+uv7nfq2oyDSXwE7N5Yx
         UiFTszbdvDLTDSN0+q1VCKLNV5evPUXMnsReDMCliNK63NwcrZB+N1FnRTt8R4EZ39kE
         tjt2hLyJspDq47H720P1n2ikvza9UoxSJf+plPBSQz2NDMgxhTKY023OAWHiMGyfvEyT
         ZSRGgrszkIafKjVMBGBZxEQJqDo81F9yzW/YqP4Jzj2hvpCnKKFRSLAuFlma7M2IkMsl
         DeztMgUaBA2e3mJEvIfh6f/b0yiqv/2TwlaiDsmIVJD+3jUVmyJieq4KkAbR2yFakn9q
         4TQg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1hOShxCV7UVcGaeCPKjqJCY9axoqepybtCtqop1CFsy7GWy2FH+kK+/LeWU0U9fvJw1l7l1W1izv82x91Ycf/@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdf632ctsfTdPaSQZe/VPrYc09iaLVFU7ls+LdvGX8XCkHAv6z
	7LFSeMjBEkEZSnQatsVr2itpfEGK/x9wJI+tVXtC8efV8JzwmC071OhWMKvhZvwygzfRos9Dput
	TsY+7BIh1Qq5S3OnKpU9OgWMpoue186TpOiASsx/0
X-Gm-Gg: AR+sD135sEixK23rN4lAPsxlXZYVHJGdovxY1Wg4EBDQ6W0xabC2jIqq+n9c14/koPf
	4LAlmY2ORrEUmCK28kszybwOFxO4E6Yp8YNKfs57MHIT7gCchY7Nh8+pnm2h3/Xa0yYXK1uRXil
	5B4RnatR6wWukHGxbwYzp6X/E+MHU6YiMCzGIYOu9U6G26Xzrt2p5OLo61tkpiw/Q2B8afRGwbW
	g4gIvPFGd5/y9MhhD1QsFDiHDB64970bR1eM3pdmtG/kb2iL1zUGRTZmF73xqrUehaNqPPd5Rjn
	todfbGC7+cEFMb9Oy6XTottZEyh/bdltLUyK5SP3Zj0oCiGAcT/28aadvorwwQKMG4xpxIuLBzI
	=
X-Received: by 2002:a05:622a:1f97:b0:528:38d6:71b4 with SMTP id
 d75a77b69052e-52dc4810b19mr775631cf.11.1787004743815; Mon, 17 Aug 2026
 15:12:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804065606.27532-1-liuqi@hygon.cn> <20260804065606.27532-3-liuqi@hygon.cn>
In-Reply-To: <20260804065606.27532-3-liuqi@hygon.cn>
From: Ian Rogers <irogers@google.com>
Date: Mon, 17 Aug 2026 15:12:12 -0700
X-Gm-Features: AcwNN1XPK4z6cXmvTLGHK_e-T5UjycXvKIgnxuI5xz-Ym2D1kCSMvljjTO6SuBU
Message-ID: <CAP-5=fX0nXLsMZMRYb9PHd=OF47BG9RVDPBxnsoFg=yM9NgWOg@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] perf vendor events hygon: Add Hygon Data Fabric
 PMU events and metrics
To: Qi Liu <liuqi@hygon.cn>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, sandipan.das@amd.com, 
	ravi.bangoria@amd.com, x86@kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lijing@hygon.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 12:00=E2=80=AFAM Qi Liu <liuqi@hygon.cn> wrote:
>
> Add perf JSON event definitions and metrics for the Hygon Data Fabric (DF=
)
> uncore PMU.
>
> Signed-off-by: Qi Liu <liuqi@hygon.cn>
> ---
>  tools/perf/pmu-events/Build                   |   2 +-
>  .../arch/x86/hygonm1/data-fabric.json         |  87 ++++++++++
>  .../arch/x86/hygonm4/data-fabric.json         | 122 ++++++++++++++
>  .../arch/x86/hygonm6/data-fabric.json         | 154 ++++++++++++++++++
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   3 +
>  tools/perf/pmu-events/jevents.py              |   2 +
>  6 files changed, 369 insertions(+), 1 deletion(-)
>  create mode 100644 tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.js=
on
>  create mode 100644 tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.js=
on
>
> diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
> index 372773b998e4..79a9b4cad202 100644
> --- a/tools/perf/pmu-events/Build
> +++ b/tools/perf/pmu-events/Build
> @@ -95,7 +95,7 @@ endif
>
>  ifeq ($(JEVENTS_ARCH),$(filter $(JEVENTS_ARCH),x86 all))
>  # Generate Intel Json
> -INTELS :=3D $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v m=
apfile.csv)
> +INTELS :=3D $(shell ls -d pmu-events/arch/x86/*|grep -v amdzen|grep -v h=
ygon|grep -v mapfile.csv)
>  INTEL_METRICS =3D $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metrics.json=
)
>  INTEL_METRICGROUPS =3D $(foreach x,$(INTELS),$(OUTPUT)$(x)/extra-metricg=
roups.json)
>  GEN_JSON +=3D $(INTEL_METRICS) $(INTEL_METRICGROUPS)
> diff --git a/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
> new file mode 100644
> index 000000000000..99c243bd9ba0
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/hygonm1/data-fabric.json
> @@ -0,0 +1,87 @@
> +[
> +  {
> +    "EventName": "cpu_read_requests_cs_0",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS0",

Does "Data (64B)" mean that each count should be scaled by 64 and the
units are bytes? In which case adding:
"ScaleUnit": "64Bytes",
Would cause the count to be multiplied by 64 in the perf stat output
and the unit Bytes to be added.

Would it be possible to define terms like CS0?

> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_1",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS1",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_0",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS0",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_1",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS1",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_0",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS0",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_1",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS1",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_0",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS0",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_1",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS1",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "MetricName": "cpu_memory_bandwidth",
> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cp=
u_write_requests_cs_0 + cpu_write_requests_cs_1) * 64 / (duration_time * 1e=
6)",
> +    "BriefDescription": "Total CPU memory access bandwidth",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_max_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_w=
rite_requests_cs_0 + io_write_requests_cs_1) * 64 / (duration_time * 1e6)",
> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (up=
per bound, assuming 64B per request. Actual inbound I/O requests may be 32B=
 or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_min_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_w=
rite_requests_cs_0 + io_write_requests_cs_1) * 32 / (duration_time * 1e6)",
> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lo=
wer bound, assuming 32B per request. Actual inbound I/O requests may be 32B=
 or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
> new file mode 100644
> index 000000000000..f32dcea7061c
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/hygonm4/data-fabric.json
> @@ -0,0 +1,122 @@
> +[
> +  {
> +    "EventName": "cpu_read_requests_cs_0",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS0",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_1",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS1",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_2",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS2",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_0",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS0",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_1",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS1",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_2",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS2",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_0",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS0",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_1",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS1",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_2",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS2",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_0",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS0",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_1",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS1",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_2",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS2",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "MetricName": "cpu_memory_bandwidth",
> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cp=
u_read_requests_cs_2 + cpu_write_requests_cs_0 + cpu_write_requests_cs_1 + =
cpu_write_requests_cs_2) * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Total CPU memory access bandwidth",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_max_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_r=
ead_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_wr=
ite_requests_cs_2) * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (up=
per bound, assuming 64B per request. Actual inbound I/O requests may be 32B=
 or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_min_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_r=
ead_requests_cs_2 + io_write_requests_cs_0 + io_write_requests_cs_1 + io_wr=
ite_requests_cs_2) * 32 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lo=
wer bound, assuming 32B per request. Actual inbound I/O requests may be 32B=
 or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json b/to=
ols/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> new file mode 100644
> index 000000000000..bff5c0959d82
> --- /dev/null
> +++ b/tools/perf/pmu-events/arch/x86/hygonm6/data-fabric.json
> @@ -0,0 +1,154 @@
> +[
> +  {
> +    "EventName": "cpu_read_requests_cs_0",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS0",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_1",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS1",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_2",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS2",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_read_requests_cs_3",
> +    "BriefDescription": "The number of CPU read requests to memory: Data=
 (64B): CS3",
> +    "EventCode": "0x2",
> +    "UMask": "0x07",
> +    "ConstId": "0x3",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_0",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS0",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_1",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS1",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_2",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS2",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "cpu_write_requests_cs_3",
> +    "BriefDescription": "The number of CPU write requests to memory: Dat=
a (64B): CS3",
> +    "EventCode": "0x2",
> +    "UMask": "0x08",
> +    "ConstId": "0x3",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_0",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS0",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_1",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS1",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_2",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS2",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_read_requests_cs_3",
> +    "BriefDescription": "The number of inbound I/O read requests to memo=
ry: Data (32B or 64B): CS3",
> +    "EventCode": "0x3",
> +    "UMask": "0x0F",
> +    "ConstId": "0x3",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_0",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS0",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x0",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_1",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS1",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x1",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_2",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS2",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x2",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "EventName": "io_write_requests_cs_3",
> +    "BriefDescription": "The number of inbound I/O write requests to mem=
ory: Data (32B or 64B): CS3",
> +    "EventCode": "0x3",
> +    "UMask": "0x70",
> +    "ConstId": "0x3",
> +    "Unit": "HYGON_DF"
> +  },
> +  {
> +    "MetricName": "cpu_memory_bandwidth",
> +    "MetricExpr": "(cpu_read_requests_cs_0 + cpu_read_requests_cs_1 + cp=
u_read_requests_cs_2 + cpu_read_requests_cs_3 + cpu_write_requests_cs_0 + c=
pu_write_requests_cs_1 + cpu_write_requests_cs_2 + cpu_write_requests_cs_3)=
 * 64 / (duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Total CPU memory access bandwidth",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_max_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_r=
ead_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_wri=
te_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 64 / =
(duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Maximum inbound I/O memory access bandwidth (up=
per bound, assuming 64B per request. Actual inbound I/O requests may be 32B=
 or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  },
> +  {
> +    "MetricName": "io_memory_min_bandwidth",
> +    "MetricExpr": "(io_read_requests_cs_0 + io_read_requests_cs_1 + io_r=
ead_requests_cs_2 + io_read_requests_cs_3 + io_write_requests_cs_0 + io_wri=
te_requests_cs_1 + io_write_requests_cs_2 + io_write_requests_cs_3) * 32 / =
(duration_time * 1e6)",
> +    "MetricConstraint": "NO_GROUP_EVENTS",
> +    "BriefDescription": "Minimum inbound I/O memory access bandwidth (lo=
wer bound, assuming 32B per request. Actual inbound I/O requests may be 32B=
 or 64B)",
> +    "MetricGroup": "DF_Memory_BW",
> +    "ScaleUnit": "1MB/s"
> +  }
> +]
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-=
events/arch/x86/mapfile.csv
> index 50a403b429b1..ba17117245d1 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -45,3 +45,6 @@ AuthenticAMD-25-([245][[:xdigit:]]|[[:xdigit:]]),v1,amd=
zen3,core
>  AuthenticAMD-25-[[:xdigit:]]+,v1,amdzen4,core
>  AuthenticAMD-26-([12467][[:xdigit:]]|[[:xdigit:]]),v1,amdzen5,core
>  AuthenticAMD-26-[[:xdigit:]]+,v1,amdzen6,core
> +HygonGenuine-24-[0123],v1,hygonm1,core
> +HygonGenuine-24-[45],v1,hygonm4,core
> +HygonGenuine-24-(1[012345678]|[6789ABCDEF]),v1,hygonm6,core
> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jev=
ents.py
> index 376dc2d24162..63ae3a763a4f 100755
> --- a/tools/perf/pmu-events/jevents.py
> +++ b/tools/perf/pmu-events/jevents.py
> @@ -294,6 +294,7 @@ class JsonEvent:
>            'L3PMC': 'amd_l3',
>            'DFPMC': 'amd_df',
>            'UMCPMC': 'amd_umc',
> +          'HYGON_DF': 'hygon_df',
>            'cpu_core': 'cpu_core',
>            'cpu_atom': 'cpu_atom',
>            'ali_drw': 'ali_drw',
> @@ -390,6 +391,7 @@ class JsonEvent:
>          ('Invert', 'inv=3D'),
>          ('SampleAfterValue', 'period=3D'),
>          ('UMask', 'umask=3D'),
> +        ('ConstId', 'constid=3D'),

Is Const a shortening of Constant? It seems a little redundant in the
format name. Would CsId be more intention revealing? I don't know what
CS means, but this at least looks a little more intuitive to me than
Constant :-)

Thanks,
Ian

>          ('NodeType', 'type=3D'),
>          ('RdWrMask', 'rdwrmask=3D'),
>          ('EnAllCores', 'enallcores=3D'),
> --
> 2.34.1
>
>
>
