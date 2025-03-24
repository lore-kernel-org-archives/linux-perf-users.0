Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2212E3374
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742834763; cv=none; b=bn3fG0kgQ0e8pK5p/PELVfVB0gEQcbYm7pfPXaA2Cz8IrHDDu3B82cUdKm/MwA+U1AFg6xG5VqaCie8oMJgK1VGYexqGkcHUwNELEB83Lx89NQk/SvFl6wOk/kduBnqYNt3ZW8nzKJdanDz9RsuPd2kycW4V9Zo9hM2/BBXexb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742834763; c=relaxed/simple;
	bh=kGGm0hHX97r5Hlte6ukMiRM+d5X7SguOOWvGRL5+nOg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=rJOcCak1GOYKIXMU0tU59JoevVuJJ9pGAlAzP3vSX9OCUmL+6dQfgaU1IFZ2Z+Drbi//bUvnnoOKeWbB8ozMPkvrjrY1LaCAnwrUlz8A0DvUIS0G9wos2fLXR/eFFW/mSfHeAGmNVkAws9GFN3vDa4gNTZ7XWpobucFASvLB4RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uOpBFxHV; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uOpBFxHV"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2241e7e3addso65760075ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Mar 2025 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742834760; x=1743439560; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4DoYbS0EKj0UryA+/vVWIl7aYLqF4j2vWeOth/Be3Fc=;
        b=uOpBFxHVlq9fIjL5njeOJ0JFIgUpaUBsx/a5uRamubKeMkikEuqu+1ytSG0ZlkgEt+
         bgMTNmcPUs1MB0Vv0pT937pTNlvIFakrnRWqFqp1LKbWkPZvlVmD+JlNcUZhQ2JHKaBK
         n3y7yyYgIE0NRJO2l3xckEpOSqqmHCYgjf4NSWwJvMCnILzYyvXR2eFGVzNPSl8LSpZw
         p6KAjXgkXZwBiG4GtCsL2JwdmeNaZXAOiDj6vU83QfEPZ24EWCPwLZtIoDUlFhpiuHHf
         oMjsd+d4rGpC1I2h8HJaedPm4yAGd5Qw9cs11Vxs2e2gAUlrB+YGcfVDxGfPngGGWUBk
         PSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742834760; x=1743439560;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4DoYbS0EKj0UryA+/vVWIl7aYLqF4j2vWeOth/Be3Fc=;
        b=RJMCrfPnTm5dES0AbV5IVuB7/2TjLZqpP8TSUz5o4AeSRTuBqbvzQ+ZNHyX3gO7NBe
         tVwIdsstBIf6J4IK+SoKReBUvaaSJxYjNsuLaQUUCjYcgLueaMh3QJx2tADmx5h4LFH5
         lpIlrBJyactslutkjyuj9zaV2l65/OR6d2W2QE2wVv1u7bxK3G9OlP2it/71DIbL+zqh
         auZpiA00drNw9aQsuSexf8NpiqQNqOnYy1re2ldCEGhtkaEHc4kvybxmb/j8QvpZxNc6
         ZKdWPyRZgV9S/HMvq0G3YCO4RenA/H1+c2a//uSQ16Rf05aZLMFfbLEDFzlBywB2qZ3N
         WB+A==
X-Forwarded-Encrypted: i=1; AJvYcCVAk5O1WapYzQYI4hsaSnEendZPH1T7PLlAPSJtuOJO9N2vr1gdifPXWvy4lFzwtHxW+kFqvaeVCJF/ToF5h131@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj8+Oo0orxOkQvDsiNe2gc0D+AVdDf9nHoCnHnmQjfgOQrilJX
	96hGwz0vr7rk5rYuRQ+R2LULG7L0oeVsbsJAEAIA+j5/xU0nTJtsvFV8ffvW0FV26Hev9HqqV/N
	aDhvh7Q==
X-Google-Smtp-Source: AGHT+IEeiuHTxFvewILH6wDwbFMGhKcv5zYy0sVfAdJuDf+15o2LQaZG/NbWHw71gAdjQTxb5tpvI0QIZV2X
X-Received: from pfbhx24.prod.google.com ([2002:a05:6a00:8998:b0:736:5b36:db8f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f606:b0:215:89a0:416f
 with SMTP id d9443c01a7336-22780dbb8c5mr201419115ad.30.1742834760680; Mon, 24
 Mar 2025 09:46:00 -0700 (PDT)
Date: Mon, 24 Mar 2025 09:45:40 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250324164543.62574-1-irogers@google.com>
Subject: [PATCH v6 0/2] Prefer sysfs/JSON events also when no PMU is provided
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
	Aditya Bodkhe <Aditya.Bodkhe1@ibm.com>
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

Ian Rogers (2):
  perf record: Skip don't fail for events that don't open
  perf parse-events: Reapply "Prefer sysfs/JSON hardware events over
    legacy"

 tools/perf/builtin-record.c    | 47 ++++++++++++++++++---
 tools/perf/util/parse-events.c | 26 +++++++++---
 tools/perf/util/parse-events.l | 76 +++++++++++++++++-----------------
 tools/perf/util/parse-events.y | 60 ++++++++++++++++++---------
 4 files changed, 139 insertions(+), 70 deletions(-)

-- 
2.49.0.395.g12beb8f557-goog

