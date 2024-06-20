Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26BD1BA084
	for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906887; cv=none; b=XlRbyxohzQz9lXJmoHpyz+7uCzoNq75ElkvnEc7vkSTQic5Xfqn5mUNpiFHNbNbhngeoGn+2nYRSe/AAj87brmrUV67PdZO8K1Fsr6xB0/0/t5a3zHuqfJ3PYNXS8T254YbVRSEvRscR5vQpvTj9IWG/lVz2XaONH5kgYRwdsrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906887; c=relaxed/simple;
	bh=AiSUFmCvXmOIY11aG7P0jqpokdtXDCdMyccJlMzbZrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bGkgIxdxClPIBPncqJGNMz6aWF+vwlckvxYuYViv2ZgU6wFG6Jtv8F6I6gIzOfPTbjAfrg3H+dgq27duM+mg8iEjEPVQ8bxUQbIFBm42UiERX8hb2EDYzaSsXC4w8vNQPp29yDrFR+JSRwO4f+yHkTl8BMvzq7mqTlz62V/81UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pltnY0Y; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pltnY0Y"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3762775e9ebso14585ab.0
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Jun 2024 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718906884; x=1719511684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boOOgjA2cYx+WRs+FXruMxLj/lb0birCa2UkibJY+OY=;
        b=4pltnY0YSdMtfBO6JNJQx3edd+EbdMeBBPIZnvkbcCOTXqwE0kiNIK94/iKzAXVbzb
         jDogKkEXJvD/Yc/BPeW7TtcKEdM4WLy/zqb26u6EBruMeLQZG6NKtaEBxZMwREOU3tKl
         NjOcvBzgcHxFsYBRd0kaCZ/bJNblJNgbshac9WHq9kYeTLndmaK/hxomOlmlwlzwokW7
         RwDsSxn/0tU4doWMoxP89Gu1PpVDsrrVROWCbYBNuNbivPeROQz1p9ArJCZ5NtKk2Yzz
         btaVKnNh5ehCyb4Y3u4JpeJSqClWa6OIDbYNF1oM081YWJtQiDlnXaS8ulF90z2+mtaV
         QM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718906884; x=1719511684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boOOgjA2cYx+WRs+FXruMxLj/lb0birCa2UkibJY+OY=;
        b=R0BddlAxGPLj1gQj8ndXfhZgt4YJWVNOEaAIi3p8RA2Xu9sjRJ3Tgmhfi9PqMTuO8R
         hWgGfs43Wl4a6RJyokGR0dRBAXJ1ZdcBH94cP6Y9CgWoLCU4FCqROk8GvVxY4Ure10aV
         43nqOInCA0NnrKRNsE+4Op0k0sPHza7RpCw5/a/+5BEQJnIMW6lSLoJcFwh+M6jtB54t
         uLnS6AWYsdNj3FAfTOseuLAwGyvzKiFtIwVC8ZN80VFnggZK6DHdTMCEgwWQcvUCv4BT
         G28k2IXY0ET36T1tCZHYN0Gq2vBEqy4vsVJuZUfIQ+KG4Bs4kNjgr+d9bcB3kIL6hUTK
         AmLA==
X-Forwarded-Encrypted: i=1; AJvYcCUB/VHaCypqv0sSZ3D6ZPrPVORm8omC2Trpfl6gJ+KzmyEIL0CJ9i2BySTF68Is/mEY5LvftLZUGjfAduBHfTG5TPL9Upa/Q671vcAwu+H3Hg==
X-Gm-Message-State: AOJu0Yx7gbJV6t1LAqqleDfewA8u+D07D1A51fzZgHC5nk/WHXbBTr3o
	oGkEEEDt2r1GPpj9eZ44RmUtGy5jQpLDl7lqe39r/mxWyvQ2AjKLt8npxPJIuqyUEV2G/u9v7Hg
	68uHK1qOmMvNcs5FcYBJcL+TxOlCk9y/144D7
X-Google-Smtp-Source: AGHT+IHpxw0aH2Kn0lYlHD9maAaOsFDpR+FzuRFUpUCA6/zf78WxdostPFIWO5RhK6uC2MEo8LVy36QxkLBAh68cAlA=
X-Received: by 2002:a92:90c:0:b0:375:9743:9f4 with SMTP id e9e14a558f8ab-3762e5dbbbdmr270055ab.0.1718906884043;
 Thu, 20 Jun 2024 11:08:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240614230146.3783221-1-irogers@google.com> <20240614230146.3783221-14-irogers@google.com>
 <00ac4787-c290-424f-8461-7ba300a4c1a9@linux.intel.com>
In-Reply-To: <00ac4787-c290-424f-8461-7ba300a4c1a9@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 20 Jun 2024 11:07:52 -0700
Message-ID: <CAP-5=fVzr5a85DO1ZMstj6AXTEfkawphT6RY7oT38mbbGCLr8A@mail.gmail.com>
Subject: Re: [PATCH v1 13/37] perf vendor events: Update grandridge events and
 add counter information
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Weilin Wang <weilin.wang@intel.com>, 
	Caleb Biggers <caleb.biggers@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 6:45=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.c=
om> wrote:
>
>
> On 2024-06-14 7:01 p.m., Ian Rogers wrote:
> > Update events from v1.01 to v1.02.
>
> The subject has a typo. It should be "perf vendor events: Update
> graniterapids events and add counter information", not grandridge.

Thanks, will fix in v2.

Ian

> Thanks,
> Kan
>
> >
> > Bring in the event updates v1.02:
> > https://github.com/intel/perfmon/commit/0ff9f681bd07d0e84026c52f4941d21=
b1cd4c171
> >
> > Add counter information. The most recent RFC patch set using this
> > information:
> > https://lore.kernel.org/lkml/20240412210756.309828-1-weilin.wang@intel.=
com/
> >
> > There are over 1000 new events.
> >
> > Co-authored-by: Weilin Wang <weilin.wang@intel.com>
> > Co-authored-by: Caleb Biggers <caleb.biggers@intel.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  .../arch/x86/graniterapids/cache.json         |  825 ++++
> >  .../arch/x86/graniterapids/counter.json       |   77 +
> >  .../x86/graniterapids/floating-point.json     |  242 ++
> >  .../arch/x86/graniterapids/frontend.json      |  469 ++-
> >  .../arch/x86/graniterapids/memory.json        |  175 +-
> >  .../arch/x86/graniterapids/other.json         |  150 +-
> >  .../arch/x86/graniterapids/pipeline.json      | 1009 ++++-
> >  .../arch/x86/graniterapids/uncore-cache.json  | 3674 +++++++++++++++++
> >  .../arch/x86/graniterapids/uncore-cxl.json    |   31 +
> >  .../graniterapids/uncore-interconnect.json    | 1849 +++++++++
> >  .../arch/x86/graniterapids/uncore-io.json     | 1901 +++++++++
> >  .../arch/x86/graniterapids/uncore-memory.json |  449 ++
> >  .../arch/x86/graniterapids/uncore-power.json  |   11 +
> >  .../x86/graniterapids/virtual-memory.json     |  159 +
> >  tools/perf/pmu-events/arch/x86/mapfile.csv    |    2 +-
> >  15 files changed, 10975 insertions(+), 48 deletions(-)
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/counte=
r.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/floati=
ng-point.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-cache.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-cxl.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-interconnect.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-io.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-memory.json
> >  create mode 100644 tools/perf/pmu-events/arch/x86/graniterapids/uncore=
-power.json
