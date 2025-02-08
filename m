Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A638214A0B3
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Feb 2025 05:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738991734; cv=none; b=HUO321oNx3jorD1NUJ8f0heUTJAswkPwt/Z6OcTfiwRCql5dXKVkORbpLxjnjWS0GWJCt/Ab3IB8yWaulw5vCV5gBuHInIpdw8aZNQLb9bx6hMUTB2uMII0cbNnKjTay5A0e0A9fTSiZmgVff/wRLY9K29JpIe4W/IH0GzrXfdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738991734; c=relaxed/simple;
	bh=0Y1yI1G9yWg/44OGJw0mAYtHdGwPTLWSQwX18k0jBoM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MrNReW4/tDMye26HAQljya6rUm3xrApVAdKIcDWPAufUQ/EcSrAFjR3bWK8rg4g+ZBIB9TUUYk8ZvwZdRZ33HRxSvlVOJQdqagQIsUHiCYpdF3uM5gC51anqxGrBTAKLbEbSjXSh9MCzNKT82Jmz4PPTRsNdZNzBtw90htgUk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rMhrbSu8; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rMhrbSu8"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21f032484d4so85215ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Feb 2025 21:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738991731; x=1739596531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sdv4cop+FoaTBS3YZo+JpEzMsfPAs9hJ8S6R0h0XwJY=;
        b=rMhrbSu8XonKLeFrbs7zoQE9bRP2zTiLbhAkIymM/dw34qsYtVRXSRV+FM2AP8zNFh
         VYQRPGxCdDRooetPzxTKDUj3vmzp/nAc4aaOLsS/CpD/W91HG9zxpideCLspFaYhTncs
         VGtwebeXFrzicSQuOecLgHDgHE8YsT3eQnMiPGAZIZYPM9CNS2SRe/hPrBxi6lqvvG5e
         fyzMkrfgX6luvPr6JHrwGEJ0m+CAteGAD/lyHGoMFhFjpN1I2W8J5OEY+mdFgc4wXHrj
         oxt+vSdEp0tdWWXqnH0xl4FjXRN9AmQs9mCrVtWwImbEyVMeeMkIqKFbVJeXvfpZJj1o
         mDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738991731; x=1739596531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sdv4cop+FoaTBS3YZo+JpEzMsfPAs9hJ8S6R0h0XwJY=;
        b=kWYF3ch2EI05VPvDIzzJk/G12zDJOVelPUqpyFdGxeX/LoNpbTtsDcB3O1woNCB9GM
         n0U4/ynBZEu2F6qzNVD1St89jD3Tg4KtF+G0GpCv6MqNwxbcEinEbJk8yipHOIskO61M
         kgSuwoSLi87QUr6C4PtmMfeHblw7ko2gxkPSMl0Vb1MwDnGw/kuJXvDF/ejrOPwE8VEn
         06zQ6lEjSRvRdBp8NdexlUyOPfEton1LxAkR4ZPTtldEryjK+eNGO69nvHAXcQ6BUGmT
         0UZi1N0Ruef1agK8nAvnGLygekaJNPqbcEIcKb1S6wDMrlOlwQXb8kmYMldMo+9aHsOZ
         MXyg==
X-Forwarded-Encrypted: i=1; AJvYcCUDoLRhY3HD0puUjFu9OhN68YwPhlitAurBs+lKMdqLEC1RFwZaqwF5swQ1Xrrng6oI1mZo4luF1pBWT/LCoHx0@vger.kernel.org
X-Gm-Message-State: AOJu0YzmOcdmFICjG0lzFWCvohOcFAu0vByraxryiaNd+iP5z5sbLGvz
	ve4Sqgl5tn9fLKuioHBRWCevKQ9rlKSYobVxfhh3S8TaCgNYSnL3g3ZyOO0vRej19x58PxGbhOA
	qK94zbnKh/tSL0OkcFxFuUXEhTdgY9j+/ZCc5
X-Gm-Gg: ASbGncv3OXmi45CrZsBCTan2Q+dYfE/uWe7+RRDVgwroesB22PJEtvv8AjVaEPe0A26
	GkaEHRGvnWzFUAIgjbSIpJW1IvqNyvqY9Zmrc5thKqMLrv+j6DMXxyLmD5bpa4kVEXU7PIFcYag
	==
X-Google-Smtp-Source: AGHT+IGPuDvIEz2fDn4wwBNiODWl8n5z5tiBzMPsJnK0s7+dAFA6Sn/zIrjbtfYS8iwEQbdKPNLS4LgJJDnOvXGU+8U=
X-Received: by 2002:a17:902:b411:b0:216:201e:1b4c with SMTP id
 d9443c01a7336-21f6c8e8c88mr744465ad.9.1738991730761; Fri, 07 Feb 2025
 21:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207185154.824433-1-irogers@google.com> <20250207185154.824433-4-irogers@google.com>
 <0990a674-d8ab-4abc-a904-299513773f90@linux.intel.com> <CAP-5=fXCtWZicFAk+d8KSWkNDNREjk-Djz0jh=EZXX1f29Dd1w@mail.gmail.com>
 <309171b2-430f-4169-a396-d8bc34b637bd@linux.intel.com>
In-Reply-To: <309171b2-430f-4169-a396-d8bc34b637bd@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 7 Feb 2025 21:15:17 -0800
X-Gm-Features: AWEUYZntgsXFFljj82EHot2bGHjrBy5ciEyYjblbiUCTs9pKAD-pK6wDJoHDkq4
Message-ID: <CAP-5=fXQGfEiMn7DVR4UX6=7rcQ02ycF2A9AA+GAGjmpD0+Vfg@mail.gmail.com>
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

On Fri, Feb 7, 2025 at 5:19=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
> On 2025-02-07 6:00 p.m., Ian Rogers wrote:
> > On Fri, Feb 7, 2025 at 12:44=E2=80=AFPM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >>
> >> On 2025-02-07 1:51 p.m., Ian Rogers wrote:
> >>> +    {
> >>> +        "BriefDescription": "Percentage of time that the core is sta=
lled due to a TPAUSE or UMWAIT instruction",
> >>> +        "MetricExpr": "100 * cpu_atom@SERIALIZATION.C01_MS_SCB@ / (8=
 * cpu_atom@CPU_CLK_UNHALTED.CORE@)",
> >>> +        "MetricName": "tma_info_serialization _%_tpause_cycles",
> >> It doesn't seem a correct MetricName. A convert script bug?
> > They come from the E-core_TMA_Metrics.csv line 91:
> > https://github.com/captain5050/perfmon/blob/main/E-core_TMA_Metrics.csv
> > Info.Serialization %_Tpause_Cycles 100 * SERIALIZATION.C01_MS_SCB /
> > #SLOTS 100 * SERIALIZATION.C01_MS_SCB / #SLOTS 100 *
> > SERIALIZATION.C01_MS_SCB / #SLOTS 100 * SERIALIZATION.C01_MS_SCB /
> > #SLOTS Percentage of time that the core is stalled due to a TPAUSE or
> > UMWAIT instruction
> >
> > The % works okay in the metric name but we could swap it if you wan
>
> Yes, the % works, but there is a space between tma_info_serialization
> and _%_tpause_cycles.
>
> I'm not sure if it's an issue of E-core_TMA_Metrics.csv or the convertor
> script.

The space was in the CSV file but the converter shouldn't have passed
it through. I've sent a fix:
https://github.com/intel/perfmon/pull/286
I'll send v8 when Thomas fixes the E-core units.

Thanks,
Ian
