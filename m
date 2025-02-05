Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8E71FC7C1
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 21:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738791242; cv=none; b=KXzEdTqMn3BJ7yMhij3W5CM8DpvizENL1+4DFKr8KuMTVzHcmRVX4HDOnASdtnC6PUUAenU6TzyONRtxGuHRMbTgwGtuF3MZpLffBPOsHPsiuvnzP7Q/AKFnr2jrxX9EnTZCkBZOGmQs9txIVZ8PvQux5VhpX/QQ5Z1kuvftWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738791242; c=relaxed/simple;
	bh=eBSTUGxD//kOShGY5ELVmIyMxkUfJTCp7ECASLoWsiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qs8xYU1k2udXLo0aeOTCaiCIwhPT1u7CxP3vPKYlId5RFaXGPh7N4tTjEod5Gra+S1bY/hB+vXqy9usOomgFB+O+mtJVvCiHREE8zanWBJJDMs0lG89rKsFNQL1+PThzbBLCbxvVIX9HqaPDaqq7ChEIJVysCgdJgCpI2uoygRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=37hM9eZk; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="37hM9eZk"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3a9d0c28589so26825ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 13:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738791240; x=1739396040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kUUV625mQLpCEzHSpi7Az0I8LU0Hx7vOkVtXv2Yd2Gs=;
        b=37hM9eZkHW374Sf1FwkfMKXKSZap3I3ozCAi0BgSjYvypIPQw9IV5pAWRF2W99Zh4h
         QotHJwLTN75vJu8dT6Kq1D2jXabgoc2Ou0yxD3driudPln1FqpfD/+cIv2y3XU+bCcOz
         O+EZfQfkPguS0ogH5oWUIhkmFX6qWB6LdO4QS88exKdlbKkCJ16koJ9TWbXdxUsox4Jc
         gtC/pmrzIHzXuwygq13nw0QsdmzC/Xk2QFzD/1VvGhVYfwP4qv1bsDvN29HGps/rn0sd
         RdmuQAt6OAlcUTXFgspCdHhdJRxFJzZXwhJzFrrljmze+q8//Gae4szZgD3sr0hLfQiA
         ai4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738791240; x=1739396040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUUV625mQLpCEzHSpi7Az0I8LU0Hx7vOkVtXv2Yd2Gs=;
        b=q0EVqlAuT/qWQbCBim27w/eN8ogrFoD/3CPARErsuiQZDqTCkJrPL5mCuzmVMoyqrH
         DskDzoBguGA5tdVoCRJJaH0uD153BRbE4P/2hW6r3zMWPsuFQ9aMovyDrVg1cCLn55Oz
         hURxJK8G+N1ED2EDLg+StsidRWN2c+m+b3s6HCacR5/AVczviMWZArlw+dOHeD+bZJbV
         6GhuqMEBrS7BG4wImH+y+rIxouK6TuLS7eaXotHwR07sEdDqnSAYfevFoChBjN6fUV7S
         MNIDMrdFWfe7MgCH4mdEHN/501NIBxegXL5/X4gGPoK4j4QJDlcZywd1Uku47gaKkSkg
         QXag==
X-Forwarded-Encrypted: i=1; AJvYcCV5bnSl5PlgroXMm2dkjDI9019sQRB1dIRoew4h7In+TI8dvCwdlNX6qn7Zz59WCYxMlleS9iC3hk9XyLKGm2Lv@vger.kernel.org
X-Gm-Message-State: AOJu0YzMCvgMNUd0p0nl/0Co2ssFbMepB72i7gdqVnD3levEeLloS8Ev
	IjG/cRIFtKLi8XwVd7DEeYetvfnZAfTRaUCZzO4uMli5x1tf2XVoa0v2kaF9wcQnFsGmiwduKr+
	Vh3kI6tj3hM4EBfhKTGMfQi1fuOgGSKa1vkfT
X-Gm-Gg: ASbGncvsMEtrsyBOzPT/9Yu90qoYU2OO9J7UBrSo7j23rIEnpSUmA15urBEzmgoFCFW
	rYph+w2zDDTQjBPv4s3MFLp/gz2BtT3KyQL+T4/aykNLYwT8ksRvXGPpsy+gJ/BWzLVDYBb17gE
	JUoqhLIcMpi0MJzgbFpXhQsprM
X-Google-Smtp-Source: AGHT+IHE9Vx086lIoTrWWG1vp5TySLItIjd4vQpFqbKYzj+qrscX9TnMYQwc8CbtTQguFwdLajmDJdpxGp7G0ao0WJU=
X-Received: by 2002:a92:dac1:0:b0:3a7:7d6e:fef9 with SMTP id
 e9e14a558f8ab-3d05b55607dmr625755ab.27.1738791240131; Wed, 05 Feb 2025
 13:34:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205173140.238294-1-irogers@google.com> <20250205173140.238294-12-irogers@google.com>
 <7692d2d6-16d5-4f50-8c3a-37f1db356426@linux.intel.com> <CAP-5=fU+9MgMbQKpFix+Jw8k+-_yfAs-F+FYE4CmTWxevPmd-A@mail.gmail.com>
 <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
In-Reply-To: <9fa56c75-2ee6-4901-9e04-0ec23412fd62@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Feb 2025 13:33:48 -0800
X-Gm-Features: AWEUYZk1_XgKXzK7N8G8o0zkZNjpDmzS6I_UBHUVp7jTC8iYrMa6799OUcHoAtw
Message-ID: <CAP-5=fWpbXSwZq5biRZ1fjcSJY2DO4g=cv-0K8jZ1Gzv3bOfhA@mail.gmail.com>
Subject: Re: [PATCH v5 11/24] perf vendor events: Update/add Graniterapids events/metrics
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

On Wed, Feb 5, 2025 at 1:10=E2=80=AFPM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
> On 2025-02-05 3:23 p.m., Ian Rogers wrote:
> > On Wed, Feb 5, 2025 at 11:11=E2=80=AFAM Liang, Kan <kan.liang@linux.int=
el.com> wrote:
> >>
> >> On 2025-02-05 12:31 p.m., Ian Rogers wrote:
> >>> +    {
> >>> +        "BriefDescription": "This category represents fraction of sl=
ots utilized by useful work i.e. issued uops that eventually get retired",
> >>> +        "MetricExpr": "topdown\\-retiring / (topdown\\-fe\\-bound + =
topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 * slo=
ts",
> >>> +        "MetricGroup": "BvUW;TmaL1;TopdownL1;tma_L1_group",
> >>> +        "MetricName": "tma_retiring",
> >>> +        "MetricThreshold": "tma_retiring > 0.7 | tma_heavy_operation=
s > 0.1",
> >>> +        "MetricgroupNoGroup": "TopdownL1",
> >>> +        "PublicDescription": "This category represents fraction of s=
lots utilized by useful work i.e. issued uops that eventually get retired. =
Ideally; all pipeline slots would be attributed to the Retiring category.  =
Retiring of 100% would indicate the maximum Pipeline_Width throughput was a=
chieved.  Maximizing Retiring typically increases the Instructions-per-cycl=
e (see IPC metric). Note that a high Retiring value does not necessary mean=
 there is no room for more performance.  For example; Heavy-operations or M=
icrocode Assists are categorized under Retiring. They often indicate subopt=
imal performance and can often be optimized or avoided. Sample with: UOPS_R=
ETIRED.SLOTS",
> >>> +        "ScaleUnit": "100%"
> >>> +    },
> >>
> >> The "Default" tag is missed for GNR as well.
> >> It seems the new CPUIDs are not added in the script?
> >
> > Spotted it, we need to manually say which architectures with TopdownL1
> > should be in Default because it was insisted upon that pre-Icelake
> > CPUs with TopdownL1 not have TopdownL1 in Default. As you know, my
> > preference would be to always put TopdownL1 metrics into Default.
> >
>
> For the future platforms, there should be always at least TopdownL1
> support. Intel even adds extra fixed counters for the TopdownL1 events.
>
> Maybe the script should be changed to only mark the old pre-Icelake as
> no TopdownL1 Default. For the other platforms, always add TopdownL1 as
> Default. It would avoid manually adding it for every new platforms.

That's fair. What about TopdownL2 that is currently only in the
Default set for SPR?

Thanks,
Ian
