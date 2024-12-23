Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F6E1AE003
	for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2024 15:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734966577; cv=none; b=GsYU6ChMYYfoAcNC1BMHQPJvDCUsl64obgP1OQPJyS3+Zk4TVQntebyXDLco3zwXeoAjAUE6qzFwCLZn9QVqtARKPmtP+6dxIasKBvAJ3UMFZmxQ3txneijFqiaa43uvXeJMGWwmoscR+5ScngMixu+kbL7LhNvCYqULD2xLQAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734966577; c=relaxed/simple;
	bh=76U6HkgjRjNLku/D4JgCgXyboh1fQrfuSeI3ikxCPoA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=OppvuYwm0l5mdnPoxkL050jZYYR36KlSVNsSkfRUhwWdv1k52qra7d9caE4DcSCx+Tc2mFVOWcv+eTk1Qv0WMerjVahd8dXaKJGpkAgLcH0NQaJFvNHUJ+sMsurE3WbjE7nXH0OvyKnc+4FrW4bEP6HG/QibDEaE438I4rRqAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mTFKLRRD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mTFKLRRD"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso29343425e9.0
        for <linux-perf-users@vger.kernel.org>; Mon, 23 Dec 2024 07:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734966574; x=1735571374; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BY/WWy80pG3WuBi+kOO4a1NzH1bFT0KS2qVRi1aDXEE=;
        b=mTFKLRRDmaLaSNH/U3Oxjn7Q5NmGOoZtbQwSHcSjyi4V7RRrIdSgj79p1doWbRPROF
         5aVCCl3fTo4J4O/MD4CMMIqcsz0YPdINteMbjk0mTrN1Pr10PeSg85APB67b7okvkPPr
         qZIz3NUJg7+JdI2diGX1pkBvrj6nEhs4gYkVLctqBjiUpatMvPLt/HbIMutOiSJFDi9K
         wW5Zlvx/zMw1GHOQtK7wIrrglbkyP5vDRzd3yowDnwC5b7V1MreOS4yKx8gI/TzAiv54
         l/DZ1pNTgalwHGw/JeC5Gu3WqkJBGweP3qbVcmBIcnwvvRCBzoc6TVj9pd7LYuRoK7SO
         rksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734966574; x=1735571374;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BY/WWy80pG3WuBi+kOO4a1NzH1bFT0KS2qVRi1aDXEE=;
        b=gqDJWFkQ+FP9VeIh2vnlyOjOEqH3e8qNAO6hmoVAew5Xz6evrYfasdKI06P1gv19KX
         GBBtOQ/m2MP6eam0XFHWIOnp6+PQpU7pwJhP8nJ0zH56RPhQB1dx9rhhuEU6qkxYI21s
         EjExu6senmpvFNNYripYbrVvBl6pgQDBCKN1a3EUxappGFBtGDbMLyGBlPROZwSzwZUj
         XI/Rj1CELOkd52m/hkgy2Y5dDRCAfxh8ujfSmbyFUmMvH2ZIActBqKL+qUcif+qh/q7Y
         jAeMx5xblxwUQ8WWiNndccXGPrfqSykkYShKbaLz9W4g0KOgm/8hStAAQL4p+knX1nBD
         Rfdg==
X-Forwarded-Encrypted: i=1; AJvYcCXx6esaznEE3UYcdDefdqQUbLSeHDkMdEsA64XIX9YFK30j23NltXLtg9CDQtAkJki4n4OMV5N0OFJg1ernxxSB@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7++6+HSweieX8tOPfaIxyB0HPNQPaoqutdHc5iZaQu3//JCqj
	3KODB8GiVQCdOCa/PQG+d6BVRZOUW/q8vyJvuMfawAfmTJ/iIzDr7BUVIS781Dc=
X-Gm-Gg: ASbGnct0IAS7ogzdXuajKR2RluQnAhPHcO0Iqmiru/36ZwayFDawSFvtJLOTaDmaVEZ
	NogLvcYock/2baTEYkDefIERfNqO3xHterCoRvPL3kVrEBLzJ4E8Hkv7vUpx8ePpkN5ofRH8hwa
	2xkA9CjgoBdfDvNJ8/JtOUvJqnTYKJd7sjKWg6nrhjloC7q5RF6HsNocQx3F8ZJ6NfMq0cigpcV
	rEi4aOwAXYSyaiGNbShgiyWCZYllB5uhNSi+NilHfATs70Q+hAEz8tTk956HNkLtg==
X-Google-Smtp-Source: AGHT+IGvSykJ3Jr3HdejhQmZCMrMy6Nzrqa9tGmG7zFDpNO//SXq9aLM82WgR7OFyor8uzFKKp4NGg==
X-Received: by 2002:a05:6000:1542:b0:385:e43a:4dd8 with SMTP id ffacd0b85a97d-38a221e1832mr10213524f8f.4.1734966573864;
        Mon, 23 Dec 2024 07:09:33 -0800 (PST)
Received: from [192.168.68.163] ([145.224.66.70])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a2e25edbbsm4185927f8f.110.2024.12.23.07.09.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Dec 2024 07:09:33 -0800 (PST)
Message-ID: <823e66dc-9ff4-4168-be54-2e800aef0b28@linaro.org>
Date: Mon, 23 Dec 2024 15:09:31 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] Prefer sysfs/JSON events also when no PMU is
 provided
To: Ian Rogers <irogers@google.com>
References: <20241221192654.94344-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Ze Gao <zegao2021@gmail.com>,
 Weilin Wang <weilin.wang@intel.com>,
 Dominique Martinet <asmadeus@codewreck.org>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>,
 Junhao He <hejunhao3@huawei.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20241221192654.94344-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/12/2024 7:26 pm, Ian Rogers wrote:
> At the RISC-V summit the topic of avoiding event data being in the
> RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
> events being the priority when no PMU is provided so that legacy
> events maybe supported via json. Originally Mark Rutland also
> expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
> M? processors, but James Clark more recently tested this and believes
> the driver issues there may not have existed or have been resolved. In
> any case, it is inconsistent that with a PMU event names avoid legacy
> encodings, but when wildcarding PMUs (ie without a PMU with the event
> name) the legacy encodings have priority.
> 
> The patch doing this work was reverted in a v6.10 release candidate
> as, even though the patch was posted for weeks and had been on
> linux-next for weeks without issue, Linus was in the habit of using
> explicit legacy events with unsupported precision options on his
> Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
> where ARM decided to call the events bus_cycles and cycles, the latter
> being also a legacy event name. ARM haven't renamed the cycles event
> to a more consistent cpu_cycles and avoided the problem. With these
> changes the problematic event will now be skipped, a large warning
> produced, and perf record will continue for the other PMU events. This
> solution was proposed by Arnaldo.
> 
> Two minor changes have been added to help with the error message and
> to work around issues occurring with "perf stat metrics (shadow stat)
> test".
> 
> The patches have only been tested on my x86 non-hybrid laptop.
> 
> v3: Make no events opening for perf record a failure as suggested by
>      James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
>      rebase.

Looks like this could be interacting with the dummy event for itrace 
events which I must have missed before. Now it "fails" but the exit code 
is 0 which some of the tests rely on. I noticed "Miscellaneous Intel PT 
testing" is failing because its skip mechanism is broken:

$ sudo perf record -e intel_pt/aux-action=start-paused/u
Error:
Failure to open event 'intel_pt/aux-action=start-paused/u' on PMU 
'intel_pt' which will be removed.

$ echo $?
0

So the test thinks it has the aux-action feature but it doesn't.

> v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
>      Patra who have tested on RISC-V and ARM CPUs, including the
>      problem case from before.
> 
> Ian Rogers (4):
>    perf evsel: Add pmu_name helper
>    perf stat: Fix find_stat for mixed legacy/non-legacy events
>    perf record: Skip don't fail for events that don't open
>    perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>      legacy"
> 
>   tools/perf/builtin-record.c    | 34 ++++++++++++---
>   tools/perf/util/evsel.c        | 10 +++++
>   tools/perf/util/evsel.h        |  1 +
>   tools/perf/util/parse-events.c | 26 +++++++++---
>   tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>   tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>   tools/perf/util/pmus.c         | 20 +++++++--
>   tools/perf/util/stat-shadow.c  |  3 +-
>   8 files changed, 156 insertions(+), 74 deletions(-)
> 

