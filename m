Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1C61FBCAD
	for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748379048; cv=none; b=Bsj7vI+US3gQZ/kCZRjvyz/4gF5/jzQLlMC9QkTmJ6sZE/LwRbTTIfrRnY8+60R411LVsHeLjLKsJqKtZWK5saCHVDgMyX1/FV+fwYj0l3ruHNw5pp9ptxDaT2ZLn1eM49yUmKUEPNJDs7eTFms7VxlsLN6qcK7ooaqUnbmi/ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748379048; c=relaxed/simple;
	bh=trD6KtQO0saqCALL8fa0XS+Fe0+p0+rW4uwTKveEimk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N9XfLXzrfrt9y0XlibItcQ3nrGYpD/bPz9VPBMDTt2Q4N1eaIdSsZ3AChjjQP77zPK+8o8ph+if8zHj8ZG2eTmuqtXyrm+JSBeChfCMNre4YkPRSkAJ8eU2L4GcMCKEn1IIopwnJf1n0VL82bgMfjOI6r+hBrYZZA4nY6LCN9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JXKVHqUV; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JXKVHqUV"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3dd89a85414so15145ab.0
        for <linux-perf-users@vger.kernel.org>; Tue, 27 May 2025 13:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748379045; x=1748983845; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yg78/YNDfk4qRmPOviB0ojUMAFS7yO2rfR7kV/GP/g=;
        b=JXKVHqUVLB9MaCe4sFyfZ8qALZVfYwjE6M1ENmcMXIW2CLLosu+oVgyArNbToxEt6i
         qoST3+5yr7FytduANEajl24AT9qQIp3KCwa3dQ2Ov7617rfPmVsh1LPKlNzS5kP2z4ah
         AkbYsaompdceUUDCr3st4eUTxxI4JuMMYf/resVADJqf0nPz61BupvELMuE6ZfkDRbkU
         SnWn2bz7NLQe2fBT8+xVLU9W31r0ldacLxgSVy3G5Ix1FUIzBEj1/fBpx7NR1DpToihN
         Fdz0qe67EtyzEnKxwxEk3NND6x7x43UEGhLKEo4OBlB+Mc1q+8C0/wyMjrVTxBg4j0mg
         eRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748379045; x=1748983845;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yg78/YNDfk4qRmPOviB0ojUMAFS7yO2rfR7kV/GP/g=;
        b=oJ1jepLU5i7bhpCbr/uM0MyqLw2sR0kOhGK3g9fY3nfA7EzBjHksKs4J3SWe2BHYdv
         ipCj1JAhHcR2pwpHdPQFBTAJPZeH2ifhwR3bK/Fp1CutUvQBLEa25SpQUj4u78U76yxy
         Sa0Z7/a/mKMC1hnFJ9ivCJCqYyB7WALJSYOHW4dTBK9tEY/tV48T44rvlfLUPq2lRlgC
         TJvLtEQOxZL5z1o5j5sbw4FuVrnec792gDbGfswIT9lvWWpP+n9uC6aRtXTs58zHYMFQ
         XZhJlnSmOpvq8/+GhYsMdmk5tsDG2ERBGR0C0kofnKTc0XG3qNRi1Ae2cbI7lEtMwvn7
         Gd8w==
X-Forwarded-Encrypted: i=1; AJvYcCV8hYRVywcblvPGUHTcKUPmXQ3CtZ5A74RVoZ3imeqZmAHtgoP2xjHFJvLt+qEMC4NYlXCRB/oOZpSeVZ7Fc15N@vger.kernel.org
X-Gm-Message-State: AOJu0YzPXdk3xDy+PKhebaTs8STpYC5rGzOf8JLnFv3pE/6mBLkmc47A
	vxC2MfhoG4HuhremQSRkBJC468ibIm3jl92ZEgGX3jZPL0kLKugz8/fELzffll/+rTdZ5VMeAOB
	WtKNXth2RcrzmB0zvS5aF7oFQAwMT4ziRsq3Pi9Pf
X-Gm-Gg: ASbGncuN66O8mQ6hVWboYKV87jbCqRUXJhsiT/z970kTlDpTDfZH8wg8+GClHFxFXtv
	m6K7FEoBwxH8LPRLsd60s5E57YXRFh8qSfELbhJJ5uoPkE9Itc8DmteY41Dld7XyrkG2exBCq26
	ploYsUh7uQ8dUjhD+gx35K6Dv6z7/cYGaQ3jvOt1MoJ5kBfLdojq3YU7Tc0k0PTTnI+ID9M/Wt
X-Google-Smtp-Source: AGHT+IE/1T4kZf05oCu4sfIETu9/i2DgQZVrCIQBbMPl3WP/1lslJa5mXkQgfThkOpftvtd6CrCAYg36F6e8ogwjHkI=
X-Received: by 2002:a05:6e02:170a:b0:3dc:7e01:6f6a with SMTP id
 e9e14a558f8ab-3dd88fbc93cmr887775ab.26.1748379045105; Tue, 27 May 2025
 13:50:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416045117.876775-1-irogers@google.com>
In-Reply-To: <20250416045117.876775-1-irogers@google.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 27 May 2025 13:50:32 -0700
X-Gm-Features: AX0GCFtk6Ncs2e_GqsHxj_DiWhthI06H5P6Wv7pGvMZ2M9nALUnx3gSubJEv234
Message-ID: <CAP-5=fU3VW1MjHMiaPG+JirLCCunMC6bEWpsJ3h0E7bTDkh9cA@mail.gmail.com>
Subject: Re: [PATCH v8 0/4] Prefer sysfs/JSON events also when no PMU is provided
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
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>, Leo Yan <leo.yan@arm.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Atish Patra <atishp@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 9:51=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
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
> The situation is further inconsistent as legacy events are case
> sensitive, so on Intel that provides a sysfs instructions event, the
> instructions event without a PMU and lowercase is legacy while with
> uppercase letters it matches with sysfs which is case insensitive. Are
> there legacy events with upper case letters? Yes there are, the cache
> ones mix case freely:
>
> L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|=
d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node
>
> meaning LLC that means L2 (which is wrong) both match as part of a
> legacy cache name but llc and l2 would only match sysfs/json
> events. The whole thing just points at the ridiculous nature of legacy
> events and why we'd want them to be preffered I don't know. Why should
> case of a letter or having a PMU prefix impact the encoding in the
> perf_event_attr?
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
> v8: Change removing of failed to open events that are tracking so that
>     the tracking moves to the next event. Make software events able to
>     specified with a PMU. Change the perf_api_probe to not load all
>     PMUs through scanning, specify a PMU when parsing events.
>
> v7: Expand cover letter, fix a missed core_ok check in the v6
>     rebase. Note, as with v6 there is an alternate series that
>     prioritizes legacy events but that is silly and I'd prefer we
>     didn't do it.
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
>
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

Ping. Thanks,
Ian

> Ian Rogers (4):
>   perf record: Skip don't fail for events that don't open
>   perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
>     legacy"
>   perf parse-events: Allow software events to be terms
>   perf perf_api_probe: Avoid scanning all PMUs, try software PMU first
>
>  tools/perf/builtin-record.c      | 63 +++++++++++++++++++---
>  tools/perf/util/parse-events.c   | 47 +++++++++++++----
>  tools/perf/util/parse-events.h   |  3 +-
>  tools/perf/util/parse-events.l   | 90 ++++++++++++++++++--------------
>  tools/perf/util/parse-events.y   | 85 ++++++++++++++++++++++--------
>  tools/perf/util/perf_api_probe.c | 27 +++++++---
>  tools/perf/util/pmu.c            |  9 ++--
>  7 files changed, 235 insertions(+), 89 deletions(-)
>
> --
> 2.49.0.777.g153de2bbd5-goog
>
