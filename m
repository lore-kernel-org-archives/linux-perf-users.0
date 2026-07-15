Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EDC3B2FC2
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784136952; cv=pass; b=bfrvcTeJBt5uhEY8Qo7+YzwwYO8PFqwRwcMicGz0zrsKlWkoMG2rlECjIi9xOos+0R1sgE35wwfHVlDOl6CRMH9J91tzk0ajCtQVtExoqyFcc89+cH5qu2wKNTZot/vnRuVLukdNOy0WCu7PM93UkALXx66SMTc4cKYrSi02Y0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784136952; c=relaxed/simple;
	bh=srz1nC8CNoEchJhtzs1JNHJ4hD1KzXil7BJl10FqHqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=icAApUUhzpAszRu6AwXUyfVRhzjMydb/17hWfurGabkMSjH78+aLbxweU+N8qJdzf/cscM4u8SP6pCauAmfFOiOziiU0BZkc1SL134I8IBnwnjcG4zD3yUZT5lhPzxZuCSLBJag+NbtBxLDny0msu5oV+9EFLL/vf83TIV7CfcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t/eQjSuK; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t/eQjSuK"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-493c733f15aso51525595e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Jul 2026 10:35:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784136949; cv=none;
        d=google.com; s=arc-20260327;
        b=rF1ftPG5hdbi/vPDqYUjA6gbjkwPkxyB86dZMPz+f74ZmsJ4uJgRsg2lf8mkyRi9aT
         wJAt9s0nt/lnc1V/UBrpeW6g6F+eCMOODMl66xPcorVnnw7E2A6kCn7WnHIx4yqJy9BO
         g2l1x9cyZLifwmD5KH3Cr3mIRJF3WMhRJFbw1cRtJp/OschT8Eq4/F2FNK1eUFYmakoZ
         dALqpple/kEbY5gD6Xtwc6r2DWwbV9rinmX+Ej1SHhkQ9xRxeSgtvnM1QNfSFnkx6zDC
         jx3EY7xMt6fl0yT+KkhFwjaCxQ0RUyBwetgpRtYxyUGEdQvq4IT6I99znOZllpoa3sFE
         Lfyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qzY0S139K/TnuA/ZHnF4+fVZoZz0P2BZ7l6y7TJ6En4=;
        fh=+t5mHj4yB7jNYKsay9V1LHfNc2NIuRDxJ1WQo+gShUk=;
        b=ebsH84BbtfY4NieuIB13vyIat2uvxaVHTmjRP32luD5OA++2kvpMdMCwaqEGCKqp3Q
         f5GO6gH/By0XkF8xSYwLyod6oXiVj18ZkVJMbgvcCrz6P1Yqi8tHn+6QtMWebxpEuaHi
         ua/ptPRPxrqBJosnUGwcx/S6Oq0pUNtZaC2MImiJGpnw6h9PPhwSZACp4KCPQXnAe9br
         7nuZaSIEkqzA29Adu03lESqi+j1/5qVbiyhkAAFAaDHXEmDmYJNyeeHFgYHmxX1O3vql
         N+qnM3x51Zg+CfXFdvxPyFImfPf5+pPK9q27CxvqQomTqfEx6VwHVVV+3q4kAFkVzKRO
         46pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784136949; x=1784741749; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qzY0S139K/TnuA/ZHnF4+fVZoZz0P2BZ7l6y7TJ6En4=;
        b=t/eQjSuKEe6pfJ6OPsXauJ8RY22gBjAikAX8Uvmq3himJXDytOWTh5YH9rQldafvUH
         VlBZCMKVQ7uHWPqSg7zQOWCNXU5LcpMkHhoBRFZe773grON8TOTXgjXB0jo2jWrPdSvK
         WVwCxSsI9fn2cv6gyk25P3HnKKK06qehtI37Lsxzweh1t1L3VBEZY3auJNCs/bkoDZqf
         1aS2k3twFr0mBXn4kmVXB938eiGNMvNoAD+HiVQuYpU7SSXC1+npby646qfOS15eoaka
         Zl+2zfW/r8T6HYwo/1ENQDKbn/sIz7EXQ+DpWEsQr4grUo3CDLalUG8bHL5UrPMp8n1V
         z6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784136949; x=1784741749;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzY0S139K/TnuA/ZHnF4+fVZoZz0P2BZ7l6y7TJ6En4=;
        b=G+Jn8BJBFim56ErMebwAWJkJOe5nBpLD0VTkCEn2/N8YClZBjQUoAIq0c4br7o9I62
         827oU2rQF8xvcWKkanzYNYuZ32ExOKthRA/LtqqCwgEpPVSmLgaaeHsm0UgdnwjFXBnH
         tVuK9h40ZWnB0N9mfPytSR1kvcLLdy/qjV+Vbd1RldSydqYk3zuRXze/1Aa/UKi2/Kxb
         SF+rlUZzAGq2NVoPAWIpWJnVBD0bqR2JbQ4BbhN9XdbQ5xGBEd/EK8+QZOHeMCqxx+GL
         35CS/HtWxqnO4Gqr+BYJiTM5c38vqRQZR2yGhzjObook/a1vGF9xRNRGWwoi2T5cJbYs
         CvYg==
X-Forwarded-Encrypted: i=1; AHgh+RpwfxH7ZSHyHLKKHxAMaMEC926W7t7IyISYYZBk8Otck88uWJf3PSIl12crzfVF8a/EpmKIgsBEW+jwBRSIMtyg@vger.kernel.org
X-Gm-Message-State: AOJu0Yx71Fszeem0jErSO8rPJhaa7MXwgA9SqH8kYfyACXrF8fZ8QxAA
	ib+0JeqV+MhnUPlq8cOlREqwaCchjY0YwcElFnNT0L52jzSp3XtV4eugNnRDy/YHZHpcysTdj8/
	yBDr29Kwc8SfR8Wep47VoiCZgQLyuDzb5QAAzGSBY
X-Gm-Gg: AfdE7cn/9zeXL60D4/fKncCV1W5QrLDkegR6P7lH7tU1MWd1KvbpugtjM4VG8AqnCdi
	u++dojYWl32U5F9lwYkGpwWwQiUxrr/FT+a1ekYSAfMYZGvfIwIXSzL8Lk9xb7VVF1LL8i7Ng2j
	qhoN/+YP+e545XkPnLUIb1vktfM8Bqrh181JPQpd/EJGh1cpZmVTmNbYZvU4dfo/P/H+PqXKdYs
	snMLnS0ZAU3GfAAds1ynxCZPLdlpr00sNb1oBOl2iG8O1EOZBpelFluQma62cd+2CEV5xpmFpoW
	SvnCcdYxLYEXq9y65QQRLZJpag==
X-Received: by 2002:a05:600c:c84:b0:493:ece1:86b9 with SMTP id
 5b1f17b1804b1-495389cdfbdmr82115475e9.8.1784136948712; Wed, 15 Jul 2026
 10:35:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714204044.1952031-1-ctshao@google.com>
In-Reply-To: <20260714204044.1952031-1-ctshao@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Wed, 15 Jul 2026 10:35:35 -0700
X-Gm-Features: AUfX_myhrLlF7wsR2Gz8OBmwra7buyIw2KmjH8eo6ZOwISiG--ryKqqLeOGhhzk
Message-ID: <CAJpZYjUa4HpbUvPhcjG3-ezKkig8bd1mbdQmb7xo_c9S_uyvfg@mail.gmail.com>
Subject: Re: [PATCH v2 0/12] perf vendor events intel: update
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
	mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(Please disregard my previous message due to a formatting error, I
apologize for the spam)

Following feedback from Ian
(https://lore.kernel.org/all/CAP-5=3DfVc6tw3hfnvB7n_UZ3B5JF7vBpm7cnE8516t5H=
VUWwFNQ@mail.gmail.com/),
we have decided to address this by fixing get_cpuid_str rather than
modifying mapfile.csv. I will send a separate patch for that.

Please disregard this v2 series and use the v1 series instead:
https://lore.kernel.org/all/20260713181757.481164-1-ctshao@google.com/

Thanks,
CT


On Tue, Jul 14, 2026 at 1:40=E2=80=AFPM Chun-Tse Shao <ctshao@google.com> w=
rote:
>
> Sync the Linux kernel perf PMU events with the latest upstream Intel
> perfmon repository.
>
> This patchset includes event and metric updates for Alder Lake, Alder
> Lake N, Arrow Lake, Clearwater Forest, Emerald Rapids (including IIO
> bandwidth metrics), Grand Ridge, Granite Rapids, Lunar Lake, Meteor
> Lake, Panther Lake, and Sierra Forest, as well as adding initial event
> support for Nova Lake v1.00.
>
> v2:
>  - Fix Novalake CPUID regex in mapfile.csv to match single digit model
>    numbers without zero padding (GenuineIntel-18-[13]).
>
> v1: lore.kernel.org/20260713181757.481164-1-ctshao@google.com
>
> Chun-Tse Shao (12):
>   perf vendor events intel: Update alderlake events from 1.39 to 1.40
>   perf vendor events intel: Update alderlaken events from 1.39 to 1.40
>   perf vendor events intel: Update arrowlake events from 1.19 to 1.20
>   perf vendor events intel: Update clearwaterforest events from 1.02 to
>     1.04
>   perf vendor events intel: Update grandridge events from 1.12 to 1.13
>   perf vendor events intel: Update graniterapids events from 1.19 to
>     1.20
>   perf vendor events intel: Update lunarlake events from 1.25 to 1.26
>   perf vendor events intel: Update meteorlake events from 1.21 to 1.22
>   perf vendor events intel: Add novalake v1.00 events
>   perf vendor events intel: Update pantherlake events from 1.06 to 1.07
>   perf vendor events intel: Update sierraforest events from 1.17 to 1.18
>   perf vendor events intel: Update emeraldrapids metrics
>
>  .../arch/x86/alderlake/adl-metrics.json       |   80 +-
>  .../pmu-events/arch/x86/alderlake/cache.json  |   36 +
>  .../arch/x86/alderlake/metricgroups.json      |    2 +-
>  .../arch/x86/alderlake/pipeline.json          |    6 +-
>  .../pmu-events/arch/x86/alderlaken/cache.json |   32 +
>  .../arch/x86/arrowlake/arl-metrics.json       |  152 +-
>  .../arch/x86/arrowlake/metricgroups.json      |    2 +-
>  .../arch/x86/arrowlake/pipeline.json          |    2 +-
>  .../arch/x86/arrowlake/uncore-memory.json     |   84 +-
>  .../arch/x86/clearwaterforest/memory.json     |   33 +
>  .../arch/x86/clearwaterforest/pipeline.json   |   19 +
>  .../clearwaterforest/uncore-interconnect.json |   10 +
>  .../x86/clearwaterforest/uncore-memory.json   |    2 +-
>  .../arch/x86/emeraldrapids/emr-metrics.json   |  135 +-
>  .../arch/x86/emeraldrapids/metricgroups.json  |    2 +-
>  .../pmu-events/arch/x86/grandridge/cache.json |   25 +
>  .../arch/x86/grandridge/counter.json          |   42 -
>  .../arch/x86/grandridge/floating-point.json   |   56 +
>  .../arch/x86/grandridge/memory.json           |   57 +
>  .../arch/x86/grandridge/pipeline.json         |  140 ++
>  .../arch/x86/grandridge/uncore-memory.json    |    2 +-
>  .../arch/x86/grandridge/virtual-memory.json   |    8 +
>  .../arch/x86/graniterapids/gnr-metrics.json   |  102 +-
>  .../arch/x86/graniterapids/metricgroups.json  |    2 +-
>  .../arch/x86/graniterapids/pipeline.json      |    2 +-
>  .../arch/x86/lunarlake/lnl-metrics.json       |  142 +-
>  .../arch/x86/lunarlake/metricgroups.json      |    2 +-
>  .../arch/x86/lunarlake/pipeline.json          |    2 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv    |   21 +-
>  .../pmu-events/arch/x86/meteorlake/cache.json |   11 +-
>  .../arch/x86/meteorlake/metricgroups.json     |    2 +-
>  .../arch/x86/meteorlake/mtl-metrics.json      |   88 +-
>  .../arch/x86/meteorlake/pipeline.json         |    4 +-
>  .../arch/x86/meteorlake/uncore-memory.json    |   84 +-
>  .../pmu-events/arch/x86/novalake/cache.json   |  749 +++++++
>  .../pmu-events/arch/x86/novalake/counter.json |   17 +
>  .../arch/x86/novalake/floating-point.json     |  452 ++++
>  .../arch/x86/novalake/frontend.json           |  600 +++++
>  .../pmu-events/arch/x86/novalake/memory.json  |  299 +++
>  .../pmu-events/arch/x86/novalake/other.json   |  144 ++
>  .../arch/x86/novalake/pipeline.json           | 1976 +++++++++++++++++
>  .../arch/x86/novalake/uncore-memory.json      |   42 +
>  .../arch/x86/novalake/virtual-memory.json     |  338 +++
>  .../arch/x86/pantherlake/pipeline.json        |    2 +-
>  .../arch/x86/sierraforest/counter.json        |   77 -
>  .../x86/sierraforest/uncore-interconnect.json |   10 +
>  .../arch/x86/sierraforest/uncore-memory.json  |    2 +-
>  47 files changed, 5615 insertions(+), 482 deletions(-)
>  delete mode 100644 tools/perf/pmu-events/arch/x86/grandridge/counter.jso=
n
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/cache.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/counter.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/floating-poin=
t.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/frontend.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/memory.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/other.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/pipeline.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/uncore-memory=
.json
>  create mode 100644 tools/perf/pmu-events/arch/x86/novalake/virtual-memor=
y.json
>  delete mode 100644 tools/perf/pmu-events/arch/x86/sierraforest/counter.j=
son
>
> --
> 2.55.0.141.g00534a21ce-goog
>
