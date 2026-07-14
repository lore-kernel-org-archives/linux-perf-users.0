Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE4A42BC2A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 20:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784061777; cv=pass; b=fGXNlrx40FVeRtoAhuvAA0NZXddsBAuFzTEAX1ZuZQ0hS0IRrZpmxrszq4wdGp2VKPjFs9+jckSAIB9OANuvleKTarHbF+xOURcP5Iw1Cf9d8VJKbrWdtIPOKqnlFGGS3fOGZ8qYs1bCJU2Y0i7Q6T0yo597yl69rBEIyEJS6Ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784061777; c=relaxed/simple;
	bh=7KjVQLYHPtX3nJauxvxiPn02hrWzmIMtcu7AbOqGLBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XoxGeerT8G8EyJHXaoes05ekX77H7yLrN0zl1/mtnC+dKmOtBT3wr0Tw+GvgGcMJI8kDNc2NrqNvriSERhcA8KYAtLea0hfq8Xk1LrDvz4mbb4Xt4XXPEgBjEkaSBIKPRTDveu8eyvo55S0tbMS3EAa83Ajy6sPVpCcN3M3ZMwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZalLx9tZ; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZalLx9tZ"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8484a0b998fso2305205b3a.2
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Jul 2026 13:42:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784061776; cv=none;
        d=google.com; s=arc-20260327;
        b=J1hSUAB4znfp649hz8r8VeejCFWlgY29EbeQyBSP8oonGfLkURl3Lv0sWXomPUu2fS
         PMy9nIWRKhCz86q48UdP/HyqsP5W6E86FdjhGC5sNzxpd6lI7k/isPeK0Z6amyuY3BdQ
         zWwLcosYOvPBiBEdOj6vruMOGKZWLs+JOJjowT+2aXL15PolEHVFLYz45XR15+q9KLhV
         GSvHfyqAS3RtNNC26M2MTnj1if1DCelOPS3lSLJmbmoPkYTylclc+qAcsusetd1bBH8C
         YcAmCG4xEXpKedH+AcnzeHxhrHn+ja/UAIYSyBGA3H/Cqr3RLzMdotYHWB0sbAflBZe6
         YMIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VdH2b+2fTNQFGkMktHvZHWkWYFKBBdDhxmr+yk6Qk0c=;
        fh=gjIQkYjcp+nCqZ10uBoHKKHpaOvpMDQTQxduDwP1F1c=;
        b=feN43Pt33B22WKR0i7MZU1QoprQA5bEaxAMsIirC51d4JwifW3EBXyFrPEcOjcpaBQ
         vFBHjrR4IMKVncvcJA4s/8hpJN6TZxMMRigni7j3OQ/nMSIxw5CrguAiGvyfoN8f/T7F
         tjOHM1gJIXh8ZMzckZ5bEPptQYUQwbtYcSh6mmaC3kQi8T/d+tiKnwyIKZww7lc5Al2R
         7qkX1AqjOW2UdCkqv9CG57xqda2K+C3notkGN4zcxqshz3IhJw/lrl/EsllJBi1PghpA
         Bmmz1Ytg4MOf8ZeuCAdGV2o+5r6V7/+fTTeDJlsXWhiL75HfOCLRiMSx5AtliCQRQTl6
         itTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784061776; x=1784666576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VdH2b+2fTNQFGkMktHvZHWkWYFKBBdDhxmr+yk6Qk0c=;
        b=ZalLx9tZ/Osi+xlyYK5IwzQ0xXUH61c0yxD2ju4AyvJSpdVig0IJVya9z173J7PqBE
         VbV13nH1u/8mhn+S7cDYkAnEBcKSIVX82iIY8w+9Qw6O2xjdVpRktDlqWhILuebYow79
         /0r2TYWtX/w2SPepClAODZUz8JnyQd07t+8ok4z6mOrKo/hXwpfJTbE6yRodZ2eQmB96
         41KZ2PyWtncDHcOlYrZWA3ZOt1waNXzS0fcVfHh9wqEKq+onu5QQPZ+cIgvx5G0k9X2P
         N7hjaC2bpMa1W+sX0luQEkN+qGbQ/pdJ8UdyXgXOIaFVTBvFdqlx2H4ukdOwFVQUc8S1
         PfMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784061776; x=1784666576;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdH2b+2fTNQFGkMktHvZHWkWYFKBBdDhxmr+yk6Qk0c=;
        b=lnlZ71FqfZ7rIn92vkQ4RubkMozmo8TUANcBoWPW55hx9sbvCtCmo74t22c7nY93rX
         xRAM3lzUe+rhQFIwDhUHD+9OR+PStO16dstZht3yqmTQlqnWIUq6rWAAeGDGlimqQRE7
         al5MWAm+J1hM7yp6yCibG0PObjkHqs9CxA3znaWU7cWVbjjvHm2/z1pOMnb13lEeoCpW
         DESJFCFDsBg9/EdZVSDIRIGDXFd7ZJ5Y/Yu+QDdgvolrFa8uJ38ZmfXel0w2lRLhNY8F
         KOKi55lfO7uQ1jT5dSaIbXgXHcMglcQeFuSTtaR/OywZUEL70Tvg/L5YHli4tH1OTA/u
         huXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYiuVc/WDBzLMULjUglpm7A5x2DVDEJlVUTzntUMFV37kiAlAB243cA3mgTgkTMWkvRaduFzAgp+K929Zw6qG/@vger.kernel.org
X-Gm-Message-State: AOJu0Yxem7cV6rBarmLzMxfm5Wj+mXps/3junfT1jdba+4374xDzHw5s
	jA99UtZROqMuC6rfHQdjUp+22KjrRQA88O9uXoNO28e652wSS1YAjkXHWaM25oOBtbVBNOQlQY/
	N7o7/a7dB+uX4op72I2euSDtOANQjBtvZ9pkIEyaO
X-Gm-Gg: AfdE7cklMCrCqEyf5SZZ+AAtZyq82UX/5wTHJXisLsEp3Ghxo4SvuE2/6C+YhsW2wM5
	FVzprxlCux1psaUmes5zSBsqpiZYlDGkBOEUfwCSPoQLai1a1vyjEJ0XIfUyW8tPL/W2jjhkXMh
	5U5D92tJ6Zmjf7uNMqwzdU+QwG8mn4Eyc3Wq8J5v3qMuNlr1q6c7FB5f5hf9cC6tKJaNSKSWKNC
	KqKlDSjVgQ7jWxu5UuRtSo/sabTo6GhWLZNRg6Ua9lmkDaSM6d7VftfEbOFNPImOsuc8+YuZSFX
	wh8oRC6QpqzIryvd4j/LQU2xZQ==
X-Received: by 2002:a05:6a21:10b:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3c110009b76mr17160909637.2.1784061775342; Tue, 14 Jul 2026
 13:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713181757.481164-1-ctshao@google.com> <2e182845-6771-473c-a82a-bf96953b458e@linux.intel.com>
 <alZz0xH7h98uzLo1@google.com>
In-Reply-To: <alZz0xH7h98uzLo1@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 14 Jul 2026 13:42:43 -0700
X-Gm-Features: AUfX_mwNR-6RBHRwkCR6l9s9jl7wCJNZzj5aDLVdloA-V_fPRX9o2DAV1Ml8jWU
Message-ID: <CAJpZYjV8Z5wYGoS362GzKuQnnw0z1CGHSzYH6xW4CHeO+7BigA@mail.gmail.com>
Subject: Re: [PATCH v1 0/12] perf vendor events intel: update
To: Namhyung Kim <namhyung@kernel.org>
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, thomas.falcon@intel.com, irogers@google.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	perry.taylor@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Dapeng and Namhyung, I submitted v2 for fixing the wrong cpu_id
for Novalake: lore.kernel.org/20260714204044.1952031-1-ctshao@google.com

-CT


On Tue, Jul 14, 2026 at 10:37=E2=80=AFAM Namhyung Kim <namhyung@kernel.org>=
 wrote:
>
> Hello,
>
> On Tue, Jul 14, 2026 at 01:21:46PM +0800, Mi, Dapeng wrote:
> > The patchset looks good to me. But It depends on this patch
> > https://lore.kernel.org/all/20260708053226.3776183-1-dapeng1.mi@linux.i=
ntel.com/.
> > Without this patch, the building on NVL would fail. Thanks.
>
> I'll pick that up too.
>
> >
> > Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
> Thanks for the review!
>
> Namhyung
>
> >
> > On 7/14/2026 2:17 AM, Chun-Tse Shao wrote:
> > > Sync the Linux kernel perf PMU events with the latest upstream Intel
> > > perfmon repository.
> > >
> > > This patchset includes event and metric updates for Alder Lake, Alder
> > > Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
> > > bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
> > > Lake, Panther Lake, and Sierra Forest, as well as adding initial even=
t
> > > support for Nova Lake v1.00.
> > >
> > > Chun-Tse Shao (12):
> > >   perf vendor events intel: Update alderlake events from 1.39 to 1.40
> > >   perf vendor events intel: Update alderlaken events from 1.39 to 1.4=
0
> > >   perf vendor events intel: Update arrowlake events from 1.19 to 1.20
> > >   perf vendor events intel: Update clearwaterforest events from 1.02 =
to
> > >     1.04
> > >   perf vendor events intel: Update grandridge events from 1.12 to 1.1=
3
> > >   perf vendor events intel: Update graniterapids events from 1.19 to
> > >     1.20
> > >   perf vendor events intel: Update lunarlake events from 1.25 to 1.26
> > >   perf vendor events intel: Update meteorlake events from 1.21 to 1.2=
2
> > >   perf vendor events intel: Add novalake v1.00 events
> > >   perf vendor events intel: Update pantherlake events from 1.06 to 1.=
07
> > >   perf vendor events intel: Update sierraforest events from 1.17 to 1=
.18
> > >   perf vendor events intel: Update emeraldrapids metrics
> > >
> > >  .../arch/x86/alderlake/adl-metrics.json       |   80 +-
> > >  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
> > >  .../arch/x86/alderlake/metricgroups.json      |    2 +-
> > >  .../arch/x86/alderlake/pipeline.json          |    6 +-
> > >  .../pmu-events/arch/x86/alderlaken/cache.json |   32 +
> > >  .../arch/x86/arrowlake/arl-metrics.json       |  152 +-
> > >  .../arch/x86/arrowlake/metricgroups.json      |    2 +-
> > >  .../arch/x86/arrowlake/pipeline.json          |    2 +-
> > >  .../arch/x86/arrowlake/uncore-memory.json     |   84 +-
> > >  .../arch/x86/clearwaterforest/memory.json     |   33 +
> > >  .../arch/x86/clearwaterforest/pipeline.json   |   19 +
> > >  .../clearwaterforest/uncore-interconnect.json |   10 +
> > >  .../x86/clearwaterforest/uncore-memory.json   |    2 +-
> > >  .../arch/x86/emeraldrapids/emr-metrics.json   |  135 +-
> > >  .../arch/x86/emeraldrapids/metricgroups.json  |    2 +-
> > >  .../pmu-events/arch/x86/grandridge/cache.json |   25 +
> > >  .../arch/x86/grandridge/counter.json          |   42 -
> > >  .../arch/x86/grandridge/floating-point.json   |   56 +
> > >  .../arch/x86/grandridge/memory.json           |   57 +
> > >  .../arch/x86/grandridge/pipeline.json         |  140 ++
> > >  .../arch/x86/grandridge/uncore-memory.json    |    2 +-
> > >  .../arch/x86/grandridge/virtual-memory.json   |    8 +
> > >  .../arch/x86/graniterapids/gnr-metrics.json   |  102 +-
> > >  .../arch/x86/graniterapids/metricgroups.json  |    2 +-
> > >  .../arch/x86/graniterapids/pipeline.json      |    2 +-
> > >  .../arch/x86/lunarlake/lnl-metrics.json       |  142 +-
> > >  .../arch/x86/lunarlake/metricgroups.json      |    2 +-
> > >  .../arch/x86/lunarlake/pipeline.json          |    2 +-
> > >  tools/perf/pmu-events/arch/x86/mapfile.csv    |   21 +-
> > >  .../pmu-events/arch/x86/meteorlake/cache.json |   11 +-
> > >  .../arch/x86/meteorlake/metricgroups.json     |    2 +-
> > >  .../arch/x86/meteorlake/mtl-metrics.json      |   88 +-
> > >  .../arch/x86/meteorlake/pipeline.json         |    4 +-
> > >  .../arch/x86/meteorlake/uncore-memory.json    |   84 +-
> > >  .../pmu-events/arch/x86/novalake/cache.json   |  749 +++++++
> > >  .../pmu-events/arch/x86/novalake/counter.json |   17 +
> > >  .../arch/x86/novalake/floating-point.json     |  452 ++++
> > >  .../arch/x86/novalake/frontend.json           |  600 +++++
> > >  .../pmu-events/arch/x86/novalake/memory.json  |  299 +++
> > >  .../pmu-events/arch/x86/novalake/other.json   |  144 ++
> > >  .../arch/x86/novalake/pipeline.json           | 1976 +++++++++++++++=
++
> > >  .../arch/x86/novalake/uncore-memory.json      |   42 +
> > >  .../arch/x86/novalake/virtual-memory.json     |  338 +++
> > >  .../arch/x86/pantherlake/pipeline.json        |    2 +-
> > >  .../arch/x86/sierraforest/counter.json        |   77 -
> > >  .../x86/sierraforest/uncore-interconnect.json |   10 +
> > >  .../arch/x86/sierraforest/uncore-memory.json  |    2 +-
> > >  47 files changed, 5615 insertions(+), 482 deletions(-)
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter=
.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/cache.jso=
n
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/counter.j=
son
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/floating-=
point.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/frontend.=
json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/memory.js=
on
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/other.jso=
n
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/pipeline.=
json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-me=
mory.json
> > >  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/virtual-m=
emory.json
> > >  delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/count=
er.json
> > >
