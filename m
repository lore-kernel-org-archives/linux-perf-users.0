Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A2942069
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Feb 2025 23:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738969267; cv=none; b=c3CD82zHAcR961JklkqsBkC+Ox4pNMlxBBGN8lARquBU2/533UtXRtxQh3TjVhTPOmybLDgqlJm4vrlJ9AI1l2pgU//ZP0zYTqZDAoTrjtb962HkjQxtMHgIuq/jHapOg/jChXbSxen8EYRkTaS2KsUXLaOD2uqh1ruk6HBTB4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738969267; c=relaxed/simple;
	bh=/YVBbjgdStsucstPuiF22JUohyLUdQTtDMIZoiQQhPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lH99I8GJiJ7QiePxw10OVPCYqLRMRkNxhGbx+vn58SphZYW4+jyCmOrnnsAyAh/CObwnJd5qrEeBi3oPIRp12qpdT/vllFarEefh22ynJ6QHnqd0iqo6QqyXfKeBB3N9G9Kajcb55GwacP13DbdeIOrF757MpvzoBWWi8oeyzFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PM9pkRTK; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PM9pkRTK"
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3d146357fb2so25125ab.1
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 15:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738969265; x=1739574065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfMOIAC27pniiagSZ/FhquHIbbeUldDht0MiRiI5kLc=;
        b=PM9pkRTKmzct7wCtLLKVXw6pY9UB6NrSKre97aZUPgrthxeChOu9jMI8ypiq3wCUuo
         O6z7sqZFX49xR2wV2C7kjC1lSfs9UkZ8ZOyKyw3zQZqgYVpP9fVks+DZbB4E/bFXTvF2
         McCVd9z0C+Oa+GlFNuQI79irITfmSDuLWn9Om4lpRYTDqwr9yyk3pqTCmq5Inxc8nqZt
         L7/rhRkc+CsmemvUTnBg7hM8xSAz//7uvpFDiy6DBIndscLCpBdQAYA9qNddRu1BCUCg
         5cJ6EXPcb16rLDgoEAdJNuHbjQtOBN1asWwmR9o39urRP13UsnUkbGl/M2sO68+ik6Vt
         8/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738969265; x=1739574065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfMOIAC27pniiagSZ/FhquHIbbeUldDht0MiRiI5kLc=;
        b=jWjzUQMxaNV+kFXzO6XW58ouJz5rhLtYjuuiBwx5+3effyG7DziscGADRKSRbkAkNI
         JMxIURYKUdITNxEoAzeAoC39BMsk3CA7v+su24XVoKtu4vyML0tMHGP//0lghhyFSgwC
         /rGwXlAwuzQWSm5NElourpLn42gg3hZWVCMfDCHHsa6yg6MKIS2lyhDzPoRaWcKU2x+j
         II2fEPUQAzQ42bCCoU1yhTc/oYiorkIiufX1XyYxvYGXevJGWWo5CwPIypC9wi9PpFYs
         Yn3H4SOe0djNVW+ZJh8b2SRjhkN06KYRMUqKJRcmfNZdxPJwPlXKTo6WDAubj/mUpUuq
         cwog==
X-Forwarded-Encrypted: i=1; AJvYcCWnAcOQ/YS/82VmQCpK0NOb94DqYbth21l0RO4Vp6TUv3520/6NsqSxbT6pFL9hCfwIa/flDcFegT21GCnibBJv@vger.kernel.org
X-Gm-Message-State: AOJu0YwVP+11QZoCN44eD0CzaFHQgpcmf6MEpCv6BuA6TpND23oicVpc
	k1e/Vlyv6REUTlVcRmZj6B7Ay9inBJNm57598AYorf/1k0/P69jKvpp2t2k5xZYufc76ojruXwg
	dy7nQ79jv1i/rLdc/hAWDy0khMqM4dXNlhzim
X-Gm-Gg: ASbGncvlce9knAKUPRJhw2aMChQ0OYaxmvYgdx0Ua1SkjaxlfQGCw2mpLs4ftTQMcdK
	35kvc+IFKr34m3OFtBkMNyQQjyyegCdPIEAQIH0oApdpqJ9fl0JahDezqwcts2RXGp5a1CAq1gw
	==
X-Google-Smtp-Source: AGHT+IEQavM44VaMiVTdLFXb3q3Pnsi9/ocZob5iEs7I2kOf0D7P/rqPiNB+EnCuylIv+Aq8KgoHLfUMvDDHSv1zloU=
X-Received: by 2002:a05:6e02:ca5:b0:3bc:bd17:d68e with SMTP id
 e9e14a558f8ab-3d14f0f95bamr163065ab.21.1738969265248; Fri, 07 Feb 2025
 15:01:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207185154.824433-1-irogers@google.com> <20250207185154.824433-4-irogers@google.com>
 <0990a674-d8ab-4abc-a904-299513773f90@linux.intel.com>
In-Reply-To: <0990a674-d8ab-4abc-a904-299513773f90@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Feb 2025 15:00:54 -0800
X-Gm-Features: AWEUYZkjpQVxy9CeNCt8XEEaPoctFrZdno6hJO3kJVCcgAYPbRPLwWzPi6nRiIc
Message-ID: <CAP-5=fXCtWZicFAk+d8KSWkNDNREjk-Djz0jh=EZXX1f29Dd1w@mail.gmail.com>
Subject: Re: [PATCH v7 03/24] perf vendor events: Add Arrowlake events/metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Weilin Wang <weilin.wang@intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Perry Taylor <perry.taylor@intel.com>, Samantha Alt <samantha.alt@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>, 
	Michael Petlan <mpetlan@redhat.com>, Thomas Falcon <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 12:44=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
>
> On 2025-02-07 1:51 p.m., Ian Rogers wrote:
> > +    {
> > +        "BriefDescription": "Percentage of time that the core is stall=
ed due to a TPAUSE or UMWAIT instruction",
> > +        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (8 *=
 cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> > +        "MetricName": "tma_info_serialization _%_tpause_cycles",
>
> It doesn't seem a correct MetricName. A convert script bug?

They come from the E-core_TMA_Metrics.csv line 91:
https://github.com/captain5050/perfmon/blob/main/E-core_TMA_Metrics.csv
Info.Serialization %_Tpause_Cycles 100 * SERIALIZATION.C01_MS_SCB /
#SLOTS 100 * SERIALIZATION.C01_MS_SCB / #SLOTS 100 *
SERIALIZATION.C01_MS_SCB / #SLOTS 100 * SERIALIZATION.C01_MS_SCB /
#SLOTS Percentage of time that the core is stalled due to a TPAUSE or
UMWAIT instruction

The % works okay in the metric name but we could swap it if you want.

Thanks,
Ian

> > +        "Unit": "cpu_atom"
> > +    },diff --git a/tools/perf/pmu-events/arch/x86/arrowlake/uncore-oth=
er.json b/tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json
> > new file mode 100644
> > index 000000000000..1ac5b5ef8094
> > --- /dev/null
> > +++ b/tools/perf/pmu-events/arch/x86/arrowlake/uncore-other.json
> > @@ -0,0 +1,10 @@
> > +[
> > +    {
> > +        "BriefDescription": "This 48-bit fixed counter counts the UCLK=
 cycles.",
> > +        "Counter": "FIXED",
> > +        "EventCode": "0xff",
> > +        "EventName": "UNC_CLOCK.SOCKET",
> > +        "PerPkg": "1",
> > +        "Unit": "CLOCK"
>
> On MTL and ARL, the unit should be CNCU.
> Thomas will propose a convertor script patch to fix it.
>
> Thanks,
> Kan
>
> > +    }
> > +]
>
