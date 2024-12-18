Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1838315855E
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734551243; cv=none; b=bB5zbWdt9BpB7ZvMgxyBKcvk7yfaqNsynzfDtSIagAWvC8Q41I9j5I5C1d9z4ESyTuxnGoCJZLAK3p5BbRgtC8LMFt+ZUntaN0jTkJa8xWxFBO3/EoWrB+4IWFEwm7SYwpZHfbPwkiZIb3GIEy1rEyV8NUG6eFgr7ZbUd2vqzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734551243; c=relaxed/simple;
	bh=JLLZg3e+a0WIwpalzBkE8TPpMoH9GNLJox+8xsNqstk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2dcYqkW/RRRY00bd4nD1/iPjU/EaxKA+IDdnvWbyvfOUt7WMz+roo4kZFyP0V7nSEvzmctqE28aQ88Fg6HP0dsBq9A/Lwgahwy47okwPAjpbLHM1MLnJHu+B2aUdkfUjePOYsSPgjRgB2dxSL3nL5ytkHFiZiNBUiZ4L1OYQ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hMqbocoh; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hMqbocoh"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a815a5fb60so16985ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Dec 2024 11:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734551241; x=1735156041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEIz13Q/pX/IO5J/PJ0QFTU3dk8boWRXFmG3LFxMs+o=;
        b=hMqbocohUI5EvhFWJPTsHbyf8Bg3c2b8FatjQbaowNQXLgAMcmgo66V7naIIPh2f7q
         iavz5oaKznHdbapQK40k+BaZobvakO+DR4UTuOJqypDBGHI4h+Et84slm20QVKflqP69
         DyLGso3Dt7Nqyxb554jxasiFE4kdBqjugrD7Mu1Z3FTKevbqj7gblXYUD3quIiJGckv5
         4uCBm/lZ5Uozaz//HT2lgjs+7aOx7HeIgZdjaQ9jF8COCJsZa3zWmof09MUp/FjHyB0c
         7D5iSlxnQ2gO/HWDiUbQgLKYudJN+9OomNld1dma02ws2pnUgI82DLTQcnDFQ63pt/nJ
         89Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734551241; x=1735156041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEIz13Q/pX/IO5J/PJ0QFTU3dk8boWRXFmG3LFxMs+o=;
        b=W4AghCGXDR80KmS14puIws4ncDaewyJQGVEfMFzqn7OYZhaCXdHCEJBZxOSok17aWq
         M8LwtV7+ZqfZuyJbUOgvQNRnzVFDyvzcyHOldp8Yb5G/l9mICdepEiOitm0Y0jfs3KSN
         T1jjIDZ6Drug9qda3cFFxj20fL1BGoH4xkDmdTmf+lLe44KXi1kEsW/Zz+AwhoBZ0Ju8
         QDhNbhbG49xSRkiyTBm2QKnOPAa1iCo/pnfJpQnRRB08lF7V4bIaJPj0itl+rw9bsOWH
         k35McZWhtc2U5AUPo1+2llRZm5wMJxfxqvEg/y7q6rkeoawv4D+e2LlUc1ySkqL7+R58
         D80A==
X-Forwarded-Encrypted: i=1; AJvYcCU9F+6jf7bymDah87K6i5X5eszEgw4kVli8iODpXfLkI0izNE2GXnvj+7jh9NzCPiGiNGa5VZy0sJWWf0E7piDP@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9nNX867oiqB/LA7uWhiA1KqFMQ9NwwgoI2YB6BgpwjNKcGUKb
	riWbq+s4CF4adf/Wfhy4rGeypgNuYPSG8ZhIRdU4r1PMBSxfxLYO9h/91qcQ2uHorE+JEpDLc/V
	3xFPyesZ3HGoKku24GhcHQ/FMT9yi4M/qzJ7a
X-Gm-Gg: ASbGncthFnEnS5X96j+R+mDwdtSL1ap+y2PvSx0el8LnOSJRlCtSzRN8ubDv9VQVstu
	+LGr5e8T2Zya6LlT6D9yUhLsCz9lIwwJ5gxiC0Rk=
X-Google-Smtp-Source: AGHT+IG9HMLA2DZQdt0++217X1MrHCxsIDtlyjTzOXdQZIizZh8ClUQJQcagloMoINGz2IdswyylFE3OGbzaZct2+iQ=
X-Received: by 2002:a92:dc02:0:b0:3a7:28e3:268e with SMTP id
 e9e14a558f8ab-3c0579abc0amr359345ab.12.1734551240983; Wed, 18 Dec 2024
 11:47:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217115610.371755-1-james.clark@linaro.org>
 <20241217115610.371755-6-james.clark@linaro.org> <CAP-5=fU7RNzvzxBcAQy3RT9Ge3YtqPhDonupNWS7Wgb8HGQkGg@mail.gmail.com>
 <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
In-Reply-To: <8c15786c-47b6-47ff-b1dc-ecbf32d582fb@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Dec 2024 11:47:09 -0800
Message-ID: <CAP-5=fXV6LXrUtvgRKuyurmu5SoSZLTf6MN=+BBXkqv7drvOjg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf docs: arm_spe: Document new discard mode
To: James Clark <james.clark@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, Graham Woodward <graham.woodward@arm.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 18, 2024 at 2:07=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> On 18/12/2024 12:54 am, Ian Rogers wrote:
> > On Tue, Dec 17, 2024 at 3:56=E2=80=AFAM James Clark <james.clark@linaro=
.org> wrote:
> >>
> >> Document the flag, hint what it's used for and give an example with
> >> other useful options to get minimal output.
> >>
> >> Signed-off-by: James Clark <james.clark@linaro.org>
> >> ---
> >>   tools/perf/Documentation/perf-arm-spe.txt | 11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >>
> >> diff --git a/tools/perf/Documentation/perf-arm-spe.txt b/tools/perf/Do=
cumentation/perf-arm-spe.txt
> >> index de2b0b479249..588eead438bc 100644
> >> --- a/tools/perf/Documentation/perf-arm-spe.txt
> >> +++ b/tools/perf/Documentation/perf-arm-spe.txt
> >> @@ -150,6 +150,7 @@ arm_spe/load_filter=3D1,min_latency=3D10/'
> >>     pct_enable=3D1        - collect physical timestamp instead of virt=
ual timestamp (PMSCR.PCT) - requires privilege
> >>     store_filter=3D1      - collect stores only (PMSFCR.ST)
> >>     ts_enable=3D1         - enable timestamping with value of generic =
timer (PMSCR.TS)
> >> +  discard=3D1           - enable SPE PMU events but don't collect sam=
ple data - see 'Discard mode' (PMBLIMITR.FM =3D DISCARD)
> >>
> >>   +++*+++ Latency is the total latency from the point at which samplin=
g started on that instruction, rather
> >>   than only the execution latency.
> >> @@ -220,6 +221,16 @@ Common errors
> >>
> >>      Increase sampling interval (see above)
> >>
> >> +Discard mode
> >> +~~~~~~~~~~~~
> >> +
> >> +SPE PMU events can be used without the overhead of collecting sample =
data if
> >> +discard mode is supported (optional from Armv8.6). First run a system=
 wide SPE
> >> +session (or on the core of interest) using options to minimize output=
. Then run
> >> +perf stat:
> >> +
> >> +  perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev=
/null &
> >> +  perf stat -e SAMPLE_FEED_LD
> >
> > Perhaps clarify this should be an ARM SPE event? It seems strange to
> > have one perf command affect a later one, the purpose of things like
> > event multiplexing is to hide the hardware limits. I'd prefer if the
> > last bit was like:
> > ```
> > Then run perf stat with an SPE event on the same PMU:
> >
> > perf record -e arm_spe/discard/ -a -N -B --no-bpf-event -o - > /dev/nul=
l &
> > perf stat -e arm_spe/SAMPLE_FEED_LD/
> > ``
> >
> > Thanks,
> > Ian
>
> Hi Ian,
>
> Confusingly this isn't an SPE event, it is a normal PMU event. The fact
> that one Perf command affects the other is because these events only
> count when SPE is enabled. When it's enabled it has an effect on a
> per-core level which is why in the example I made it simpler by enabling
> SPE system wide.
>
> SPE is an exclusive PMU like Coresight and some others so it can't be
> affected by multiplexing or anything like that. The SAMPLE_FEED_LD PMU
> would be, but as long as SPE stays enabled it will count the right thing
> regardless of multiplexing.

Thanks James, sorry for my SPE ignorance. I'm smiling about the use of
the word exclusive. When I was trying to make the tests run in
parallel I used a file lock - so shared and exclusive. There were a
lot of issues with that, hence switching to 2 phases in the test,
parallel then sequential but I kept the "exclusive" tag for want of a
better word. Perhaps the notion of an exclusive PMU existed previously
but maybe I've accidentally invented the term by way of a failed file
lock experiment :-)

Presumably the two PMUs side-effecting each other is a known thing. I
wonder if we can capture this in the documentation. When you say
"normal PMU event" you mean core PMU events?

Thanks,
Ian
