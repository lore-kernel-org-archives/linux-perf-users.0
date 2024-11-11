Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A7F175D48
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367411; cv=none; b=CFEk/OsWB32FbslkptIguAmhZGs/M32442JGTKvxC8eIxf0RsI8DJHzgiaF1ppKUBx2UAd2j+/EVcmh3JWBo639BqgJ/EdxiH+Zyrf1T3bF3859BbsduyDUp4CNRvPxV7RMQWKlfRw3W1SIWL7L4uclwH+d0rVdSySuxfjd77Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367411; c=relaxed/simple;
	bh=pezunZPY1Pnl/E71gvuB423SjwlhMvE+i0G93CIYoR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=boN7WZIB0rihZyP3xHXZWXqN9ARkog/nlMklBzXUXW5mQQTNWUVyCs7XFGPsU0q7RwH/ANS3etV5q0p4YfifowXp6bS1Q1xNHlPOMGntWkB4ewcC8RhX/7LrlxLen6cymiU0A+jw6pVDV8R9aHToIiSkwcN+7v9M4y3sFuQJx/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=M4yy66o2; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="M4yy66o2"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-724455f40a0so587557b3a.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 15:23:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731367409; x=1731972209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfkKwHEqEKuvC0xVezU0FnOzboDm7id7i17WV79t3rw=;
        b=M4yy66o2menQefM4+xNOZrb38RKYKKy5izdI86diaAtNrrhloI/bm5PhK27bijbivG
         qlEINHIpqpa0Xuw6xM++vutpyv4HUtTldgZK22rn3t/aLvYTQ4iEWwH080vhSBHLA6PM
         OO+V5/Ysx8wyANMyOLBD+WEx6X5xZuicw5BSFNt8osxuwxOxPi7k8IT6rM4m3EWpIzc8
         St0qqw4LL9ZHmVSE6koT4TrYfwH3kntbvpAbgWYWLqtcQNS4PIwUvXvcurOdaM+f3cAz
         ZafJIUc+6MZ9TIhbw1/XCtCwtRF9D/of8BHaJRfDNmdpHAdDVLjw7LlomU44ECQRfctq
         ggKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731367409; x=1731972209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hfkKwHEqEKuvC0xVezU0FnOzboDm7id7i17WV79t3rw=;
        b=b163IIwVFxilV3E3OorNJjJvX75wlFQ3qu/K/UzyfldCC4Wrpe9rh1yF1zr5dnSDMB
         9lhzptGtxos40YyKbWMCsNK1ige3V8BHfDPGWqVR/JAyNlftKuhWAgH4cZZnnQ5ajmDv
         QPYz9RCHT/M6YnRAhbLpUB5zLJY/frpND5lUxek5XQI+8KIZv/WPnir2KxMmQlPy3pGd
         G7/E0smB18uiukajYTOje92orLO8z3QwG2di+fIR3jhAJa0M6799tn9mAtEBIalXydd2
         UOLJy316+/GhUl2WBb/+K5E/M+dzXmVk2aLc6uibeceC1bBq1RU5Cqvzoe/KQzVRzPrU
         RKmw==
X-Forwarded-Encrypted: i=1; AJvYcCVeqb75xmAXs5c1wJnAtfv8nb8oLTkzYTHEblEv6lcBfEVxjhLSxHcXpKQCMlbpre+ZarCbF0ApDQ00caNeVwDQ@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqbvx14CC83TzX15+GLvavsMCvl1gfq+hhysde/mrb+H0u6Evm
	SUgLJjzRSagyQDs7jXjeLWJcSXa6lMGUj8gHiwFJz0+RmwvpRYlDA1HLvtoq3Umcz9XA42FQ8r8
	bJ5XzT1xveuqLwPy3q6b7Hmw1bDNBsNAEg8UE4A==
X-Google-Smtp-Source: AGHT+IFB+aENPfYJcxrY/B/QgxvxxyBcebWQTXtdrGQMviuRc2OeVXcpmuwNdw+GfRFld6Cwnlx4fxFV61+mb2R453c=
X-Received: by 2002:a05:6a00:14d3:b0:71e:659:f2e7 with SMTP id
 d2e1a72fcca58-724132a1a87mr19143630b3a.8.1731367408901; Mon, 11 Nov 2024
 15:23:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026121758.143259-1-irogers@google.com>
In-Reply-To: <20241026121758.143259-1-irogers@google.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Mon, 11 Nov 2024 15:23:18 -0800
Message-ID: <CAHBxVyF5c4CW7kdPoBENv7o7mObo=yaHdf7peATY+Jq6Aug=Bw@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] Prefer sysfs/JSON events also when no PMU is provided
To: Ian Rogers <irogers@google.com>
Cc: linux-riscv@lists.infradead.org, beeman@rivosinc.com, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@linaro.org>, Ze Gao <zegao2021@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Ben Gainey <ben.gainey@arm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 26, 2024 at 5:18=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
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
> Two minor changes have been added to help with the error message and
> to work around issues occurring with "perf stat metrics (shadow stat)
> test".
>
> The patches have only been tested on my x86 non-hybrid laptop.
>
> Ian Rogers (4):
>   perf evsel: Add pmu_name helper
>   perf stat: Fix find_stat for mixed legacy/non-legacy events
>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
>
>  tools/perf/builtin-record.c    | 22 +++++++---
>  tools/perf/util/evsel.c        | 10 +++++
>  tools/perf/util/evsel.h        |  1 +
>  tools/perf/util/parse-events.c | 26 +++++++++---
>  tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
>  tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
>  tools/perf/util/pmus.c         | 20 +++++++--
>  tools/perf/util/stat-shadow.c  |  3 +-
>  8 files changed, 145 insertions(+), 73 deletions(-)
>

Thanks for the series. Tested on RISC-V qemu with counter delegation enable=
d.
I am able to get the event encodings specified in the json file
instead of legacy event encodings.

--------------------------------
root@debian:~/host# ./perf stat -e cycles -e instructions -vvv ls
Control descriptor is not initialized
Opening: cycles
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             136
  config                           0x1 (cycles)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  { bp_len, config2 }              0x7f9
------------------------------------------------------------
sys_perf_event_open: pid 424  cpu -1  group_fd -1  flags 0x8 =3D 3
Opening: instructions
------------------------------------------------------------
perf_event_attr:
  type                             4 (cpu)
  size                             136
  config                           0x2 (instructions)
  sample_type                      IDENTIFIER
  read_format                      TOTAL_TIME_ENABLED|TOTAL_TIME_RUNNING
  disabled                         1
  inherit                          1
  enable_on_exec                   1
  { bp_len, config2 }              0x7fc
------------------------------------------------------------
sys_perf_event_open: pid 424  cpu -1  group_fd -1  flags 0x8 =3D 4
---------------------------------------------------------------------------=
--------

However, we may still have to provide the encodings in the driver for
vendors due to the reasons described in the
thread. Hopefully, we can get rid of legacy PMU events one day which
will allow us to remove those driver bindings in the future.

Tested-by: Atish Patra <atishp@rivosinc.com>

> --
> 2.47.0.163.g1226f6d8fa-goog
>
