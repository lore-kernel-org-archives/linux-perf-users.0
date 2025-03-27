Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0512915533F
	for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743102839; cv=none; b=fKhOQlAwWVGC/f87kB5gQjpR4xQwcuC3sNZJmOekrbaY3pqIP0qc6pPzfyvu1Ks35UfuwTeII+ytIjciPU+dHv2PFEjYoiS8tB7kM8HAliNckPgqb0A6S5Mas31qpMQW7J5qx0oSWGNHG8kdzwLV5Vz7fgDb4qp32sMWUxQi4T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743102839; c=relaxed/simple;
	bh=hh/VQK/Xetz3rf5KW/ZpVNh5HJlX1LtlVn5UOEhuUgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=tKKkqKIe2VGZyEJjg30rt8/0b33ecrawrswEstIqGEiT3aM+6bFN51qxtqh0qob5FGsg0duHDPAchNQc/nevIreUg9DpH58Vflyr1F7y6Uek7UdDdKuzy7xgk+NoTPrr+umZnM8+RZYSlkxMTCpdqtXaVYnXL3ysO2nq22tnqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j64nZna3; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j64nZna3"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2264c9d0295so39285ad.0
        for <linux-perf-users@vger.kernel.org>; Thu, 27 Mar 2025 12:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743102837; x=1743707637; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UnOFmUEgN1tAjvwdzmU7V69QQB8mSVp/gwZR2GHxM7Y=;
        b=j64nZna3W/CU8+ELupqIVuDyeMl8AdZowZwwcJy7qLzKQnaSZ1aZraR7iMhD2P8EjU
         WaQOtyaNRlpvQ9AvVSVfZZahl5YCxvcjhnUM1e+OWbBCmCZDi/Zkfyjd4+AgDLTOjRI9
         IU/7nS9Hec/gZlsywDhlURaeeA88ag33gCBssHwAt/rlsDl7DfA4AGoZNK1dI5WNqb8d
         woZFiahiBNRES/icDNKAikd7hniNTlXkiMJwaODayr9AA8+md/ZHnTibeLzlhCh4WghC
         TUStaZaOODb+E7wOizp4hoI4xRX7jA1sZw4F4ovac8YMwbz0C6kjb4PLzLdvDNw82Htw
         ENaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743102837; x=1743707637;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UnOFmUEgN1tAjvwdzmU7V69QQB8mSVp/gwZR2GHxM7Y=;
        b=DguKwERWGIyE/LsgWgkkPKykafLOCcC8YecYfeDnnKMCwoX4M0zZvorARN1ZcOW6fG
         ezODMdek9Hc6aZrrcI+3fiRYR054VNCJtQlifkWrtJwFVLFK7CKeaQhMJKZXidP3A+Qr
         4gdhzDvxnkKLMO1zB/sIhvlb/gZ8KDr6J/9TpHx9PMP1Y5iBMhFVSkLE+Qak7q6YGv/T
         bLbE3KXsT7ea5vnJOFauqGNtIe6mjzHOPEShOz02JbFmhKAMIA8RRq5MJEyKILVaSbrJ
         a25Cn1U6Z62RCIYVthBW74w5HqaURj8pseUNsAvfJiekDtpkXjtHQohmpnjJFDjOQB+V
         V1Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVpvYFiVhqw4k3TNJB2uoNQszb37FM99Purq/yfJfevUt3VG6647E8H6Yuoc+8iwongsoT25FvoFQxbZPSb6/8H@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc1JXxdUYGPVxDXC4DewXl4cPWawLEB7UiUt/6hEGt7GdTNdKJ
	8d00JpV4BixC55r7XVCtUvn4XZt+XNyTlVZaLRRzc2O9DXgYEyGA/eqINvyj2nyO737wmG7y7kW
	omlqRIRmKyPLUmtI+XdWxKStmiDJDLZ/qf0fj
X-Gm-Gg: ASbGncsNUThfuhB9AYLn78+Cdk6y+hmjhNPVErNmZ1nTv9u+qFQTsrF+AJSzwvvTbVG
	jZCelfK8M17rC1OQ7XNEmcfwPmHwUy8iTN4eUQFnqyYG/m93x4WHdlDTtDnjrOWhTuByKTA9GRF
	p/nZZdtouFoVnxjS4/dF3NpYVOIDc+M0sLgJPjWS8g27j1rcDXQLJuKOk=
X-Google-Smtp-Source: AGHT+IGBRbFyYUB2Vr/yTuISyABvJclwetdAehk9rr0dNRdaF2BlgmVj4U4jVsqQ/N/bApYGl6IcTDFbuP4adTp3aSI=
X-Received: by 2002:a17:903:c08:b0:220:c905:689f with SMTP id
 d9443c01a7336-22920f444f1mr349155ad.25.1743102836749; Thu, 27 Mar 2025
 12:13:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324164543.62574-1-irogers@google.com>
In-Reply-To: <20250324164543.62574-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 27 Mar 2025 12:13:45 -0700
X-Gm-Features: AQ5f1JqARfOJjp7cH3_mePJVpMcG2u9oleFxHG7NMH3xqmsS7lzAQhyNRkCtfIQ
Message-ID: <CAP-5=fWr8EUyro8ckxfMYWR3BhiXgzkjejTjmTb=8PR1p+wvWA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Prefer sysfs/JSON events also when no PMU is provided
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Ze Gao <zegao2021@gmail.com>, Weilin Wang <weilin.wang@intel.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 9:46=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
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
> v6: Rebase of v5 (dropping already merged patches):
>     https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.c=
om/
>     that unusually had an RFC posted for it:
>     https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
>     Note, this patch conflicts/contradicts:
>     https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.=
com/
>     that I posted so that we could either consistently prioritize
>     sysfs/json (these patches) or legacy events (the other
>     patches). That lack of event printing and encoding inconsistency
>     is most prominent in the encoding of events like "instructions"
>     which on hybrid are reported as "cpu_core/instructions/" but
>     "instructions" before these patches gets a legacy encoding while
>     "cpu_core/instructions/" gets a sysfs/json encoding. These patches
>     make "instructions" always get a sysfs/json encoding while the
>     alternate patches make it always get a legacy encoding.

So another fun finding. Sysfs and json events are case insensitive:
```
$ perf stat -e 'inst_retired.any,INST_RETIRED.ANY' true

Performance counter stats for 'true':

          129,134      cpu_atom/inst_retired.any:u/
    <not counted>      cpu_core/inst_retired.any:u/
                        (0.00%)
          129,134      cpu_atom/INST_RETIRED.ANY:u/
    <not counted>      cpu_core/INST_RETIRED.ANY:u/
                        (0.00%)

      0.002193191 seconds time elapsed

      0.002354000 seconds user
      0.000000000 seconds sys
```
But legacy events match in lex code that is case sensitive. This means
(on x86) the event 'instructions' is currently legacy, but the event
'INSTRUCTIONS' is a sysfs event. The event CYCLES is a parse error as
there is no sysfs/json version. Given legacy events don't follow the
case insensitivity norm this is more evidence we need to reduce their
priority by merging these patches.

Thanks,
Ian



> v5: Follow Namhyung's suggestion and ignore the case where command
>     line dummy events fail to open alongside other events that all
>     fail to open. Note, the Tested-by tags are left on the series as
>     v4 and v5 were changing an error case that doesn't occur in
>     testing but was manually tested by myself.
>
> v4: Rework the no events opening change from v3 to make it handle
>     multiple dummy events. Sadly an evlist isn't empty if it just
>     contains dummy events as the dummy event may be used with "perf
>     record -e dummy .." as a way to determine whether permission
>     issues exist. Other software events like cpu-clock would suffice
>     for this, but the using dummy genie has left the bottle.
>
>     Another problem is that we appear to have an excessive number of
>     dummy events added, for example, we can likely avoid a dummy event
>     and add sideband data to the original event. For auxtrace more
>     dummy events may be opened too. Anyway, this has led to the
>     approach taken in patch 3 where the number of dummy parsed events
>     is computed. If the number of removed/failing-to-open non-dummy
>     events matches the number of non-dummy events then we want to
>     fail, but only if there are no parsed dummy events or if there was
>     one then it must have opened. The math here is hard to read, but
>     passes my manual testing.
>
> v3: Make no events opening for perf record a failure as suggested by
>     James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
>     rebase.
>
> v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
>     Patra who have tested on RISC-V and ARM CPUs, including the
>     problem case from before.
>
> Ian Rogers (2):
>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
>
>  tools/perf/builtin-record.c    | 47 ++++++++++++++++++---
>  tools/perf/util/parse-events.c | 26 +++++++++---
>  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>  4 files changed, 139 insertions(+), 70 deletions(-)
>
> --
> 2.49.0.395.g12beb8f557-goog
>
