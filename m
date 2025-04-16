Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E513227EA7
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Apr 2025 04:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744779091; cv=none; b=TwDbYdT/dT+DSMunZr96GvDRce8Bh41S00YZVE7v98GJvEx6dT8vMqWozgI7CZvP/oZOHrgJ28Cnt7hPdniP7psSSWWoqY+U9H2n22D3LEYpVxymO2+l7nutJx1tjPiSwJNfpxmFLXclVE+T2MIXmApfdhcQAND6mI3fMuibJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744779091; c=relaxed/simple;
	bh=WX0S1cbXsx+DeJk9hkHln37+mf5sEji+VyjkKbCTpLY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=spmmPXql7yNNhDEAFv6k/DRR6IUYThjEb0toW9yTeAF6lFt3nU5GdvI9IpGQ+vohU8kKRXmAF+XbzXOppduKNNyV1BRBtNy/tb73mDuhQZuEoZdcJesWWZhoHgGyHlcdYqleZ6SCfXxU4+XXtdwzGr+LCplXGCQLcAtLc+FmaJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SCjVl8x/; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SCjVl8x/"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c2339b26fcso4823741fac.3
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Apr 2025 21:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744779088; x=1745383888; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LiL9dWGwg8zqcLQ2yDvfK2EAWVYqud9JwKQuTd0tBE4=;
        b=SCjVl8x/D3/3jVUE5ZlnnDhM6hAPPn48iJxQ9ifBRYmDtI4Bv2hhRqQw3/eAKwRYeL
         5ZS3ZdvKhhZFDNsWxL+/jd8Alqs7qzFwxRvuIbhJGlEfKT2SDvipiDrNEUxInRjAlTTV
         K6XeKou+tgBnn9a8WVvIMbLSyJOR0MwQXDt/mexi8mQtJCplhkmJrfd0A8047PV1yWHd
         jRqrKnyzK5G5Ll5hIeT8N3HqlBAiDbjT9MxsiJ5WD9/Sqwpe/VTgyWP5Tw/UCZAHhn4A
         DG1SZPuFN388S1g2yvOlhNRrFdj0DK4W6jOD0RY5olUcNNgMqEgV2TTexKnY7Sd22lwR
         9NyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744779088; x=1745383888;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LiL9dWGwg8zqcLQ2yDvfK2EAWVYqud9JwKQuTd0tBE4=;
        b=A/RYjPPlddHFOqNDwEWnPQLo4SJQ3vkch8dx122Kh44YnmDVGMryLAHNAnPLH6OWHt
         tr+k8lC74IsMly3BSBxCTuTOw7VlE9QBqf7nIvsjHDFRw+vkZIFVopP0KSSyqkySw5Uq
         Oa5eHJQBGPwNyfyYoq79qchvvG+//a47a99QtB8kVtpZZ0qmcKcF+Bgl3mzGZFY8DgOR
         BcnOanqy/9hAxfkwlb9j+FRXqCTSu6nzSnC1n50OnheRjAKux17JlfBubZ1RJfNWkMAV
         Iv3iPg2ldtI/IPZI5ReCGoSH9m4tjAm5mes8yALqD/8F5K71nWfvAianGF4c/FcAh82T
         CGUw==
X-Forwarded-Encrypted: i=1; AJvYcCUop9M0ScZXCSWumhzTlwyrq1qOFxZeWKcCYicK3Z7IgUKBUYzEtcmBdy5xRrV26VbZIJm1YwUay0gE320/m0GN@vger.kernel.org
X-Gm-Message-State: AOJu0YxSpn/lTyjsCnwdATVqJCQxedGt/ewBi35SPSM8LT0gnYi8uy/f
	ILn6lfSiqvefbobH6lTRljLlS5LxmmZ/XX435JxZ6sVOdM54S4XZNANAVCqG734gPRlQxpTTsIB
	zjRFOnA==
X-Google-Smtp-Source: AGHT+IFl03PSz4Ap26oYDFjTlnffyjudvw4kIb3j9j4GpKvAvogJYsA/BL9ehHZmVxdZVjmkT6xg8u/2bkkO
X-Received: from oabwh14.prod.google.com ([2002:a05:6871:a68e:b0:2c1:1eb1:aacf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6870:71cd:b0:29e:290f:7af4
 with SMTP id 586e51a60fabf-2d4d2d7c4bbmr144978fac.34.1744779088590; Tue, 15
 Apr 2025 21:51:28 -0700 (PDT)
Date: Tue, 15 Apr 2025 21:51:13 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.777.g153de2bbd5-goog
Message-ID: <20250416045117.876775-1-irogers@google.com>
Subject: [PATCH v8 0/4] Prefer sysfs/JSON events also when no PMU is provided
From: Ian Rogers <irogers@google.com>
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

At the RISC-V summit the topic of avoiding event data being in the
RISC-V PMU kernel driver came up. There is a preference for sysfs/JSON
events being the priority when no PMU is provided so that legacy
events maybe supported via json. Originally Mark Rutland also
expressed at LPC 2023 that doing this would resolve bugs on ARM Apple
M? processors, but James Clark more recently tested this and believes
the driver issues there may not have existed or have been resolved. In
any case, it is inconsistent that with a PMU event names avoid legacy
encodings, but when wildcarding PMUs (ie without a PMU with the event
name) the legacy encodings have priority.

The situation is further inconsistent as legacy events are case
sensitive, so on Intel that provides a sysfs instructions event, the
instructions event without a PMU and lowercase is legacy while with
uppercase letters it matches with sysfs which is case insensitive. Are
there legacy events with upper case letters? Yes there are, the cache
ones mix case freely:

L1-dcache|l1-d|l1d|L1-data|L1-icache|l1-i|l1i|L1-instruction|LLC|L2|dTLB|d-tlb|Data-TLB|iTLB|i-tlb|Instruction-TLB|branch|branches|bpu|btb|bpc|node

meaning LLC that means L2 (which is wrong) both match as part of a
legacy cache name but llc and l2 would only match sysfs/json
events. The whole thing just points at the ridiculous nature of legacy
events and why we'd want them to be preffered I don't know. Why should
case of a letter or having a PMU prefix impact the encoding in the
perf_event_attr?

The patch doing this work was reverted in a v6.10 release candidate
as, even though the patch was posted for weeks and had been on
linux-next for weeks without issue, Linus was in the habit of using
explicit legacy events with unsupported precision options on his
Neoverse-N1. This machine has SLC PMU events for bus and CPU cycles
where ARM decided to call the events bus_cycles and cycles, the latter
being also a legacy event name. ARM haven't renamed the cycles event
to a more consistent cpu_cycles and avoided the problem. With these
changes the problematic event will now be skipped, a large warning
produced, and perf record will continue for the other PMU events. This
solution was proposed by Arnaldo.

v8: Change removing of failed to open events that are tracking so that
    the tracking moves to the next event. Make software events able to
    specified with a PMU. Change the perf_api_probe to not load all
    PMUs through scanning, specify a PMU when parsing events.

v7: Expand cover letter, fix a missed core_ok check in the v6
    rebase. Note, as with v6 there is an alternate series that
    prioritizes legacy events but that is silly and I'd prefer we
    didn't do it.

v6: Rebase of v5 (dropping already merged patches):
    https://lore.kernel.org/lkml/20250109222109.567031-1-irogers@google.com/
    that unusually had an RFC posted for it:
    https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
    Note, this patch conflicts/contradicts:
    https://lore.kernel.org/lkml/20250312211623.2495798-1-irogers@google.com/
    that I posted so that we could either consistently prioritize
    sysfs/json (these patches) or legacy events (the other
    patches). That lack of event printing and encoding inconsistency
    is most prominent in the encoding of events like "instructions"
    which on hybrid are reported as "cpu_core/instructions/" but
    "instructions" before these patches gets a legacy encoding while
    "cpu_core/instructions/" gets a sysfs/json encoding. These patches
    make "instructions" always get a sysfs/json encoding while the
    alternate patches make it always get a legacy encoding.

v5: Follow Namhyung's suggestion and ignore the case where command
    line dummy events fail to open alongside other events that all
    fail to open. Note, the Tested-by tags are left on the series as
    v4 and v5 were changing an error case that doesn't occur in
    testing but was manually tested by myself.

v4: Rework the no events opening change from v3 to make it handle
    multiple dummy events. Sadly an evlist isn't empty if it just
    contains dummy events as the dummy event may be used with "perf
    record -e dummy .." as a way to determine whether permission
    issues exist. Other software events like cpu-clock would suffice
    for this, but the using dummy genie has left the bottle.

    Another problem is that we appear to have an excessive number of
    dummy events added, for example, we can likely avoid a dummy event
    and add sideband data to the original event. For auxtrace more
    dummy events may be opened too. Anyway, this has led to the
    approach taken in patch 3 where the number of dummy parsed events
    is computed. If the number of removed/failing-to-open non-dummy
    events matches the number of non-dummy events then we want to
    fail, but only if there are no parsed dummy events or if there was
    one then it must have opened. The math here is hard to read, but
    passes my manual testing.

v3: Make no events opening for perf record a failure as suggested by
    James Clark and Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>. Also,
    rebase.

v2: Rebase and add tested-by tags from James Clark, Leo Yan and Atish
    Patra who have tested on RISC-V and ARM CPUs, including the
    problem case from before.

Ian Rogers (4):
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"
  perf parse-events: Allow software events to be terms
  perf perf_api_probe: Avoid scanning all PMUs, try software PMU first

 tools/perf/builtin-record.c      | 63 +++++++++++++++++++---
 tools/perf/util/parse-events.c   | 47 +++++++++++++----
 tools/perf/util/parse-events.h   |  3 +-
 tools/perf/util/parse-events.l   | 90 ++++++++++++++++++--------------
 tools/perf/util/parse-events.y   | 85 ++++++++++++++++++++++--------
 tools/perf/util/perf_api_probe.c | 27 +++++++---
 tools/perf/util/pmu.c            |  9 ++--
 7 files changed, 235 insertions(+), 89 deletions(-)

-- 
2.49.0.777.g153de2bbd5-goog

