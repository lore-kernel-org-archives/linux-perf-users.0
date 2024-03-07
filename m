Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8343617722
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833226; cv=none; b=QtRXgMNxD4p956GI+EhUIj6eNu6a4/MkNNeDKO9mNMZpUWY96hKALMKcRfVBfBTR90N00aUqj7P5NOwHecIIox4rvwFqNFyAOq8rGBPtFFQTTY0oaSzY6ymXBzYcOxhnmLi77EdFrQihravdGXGRieL2ZQ5CkRNsk8zgruQHa7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833226; c=relaxed/simple;
	bh=E3FbZVS+5W3wbr+dJuJyj/1HOsmFrMm/1IuvFUVVRH0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=W/oH51vLUdQPLsFcd9nU3VEW2cst2Rs+OjQkFrcLerDrZhjKzT7vtlBMSJjczZ3aAbT39vAdUhjFABtq9vTDRgXS4MwcoxLOUcwex3D29AIovz55xtsDfln326YannI0fn0yD9q5K4SCYEwl3jm3I0aI02e+kwgt3VGS/BdT+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R/vsGspl; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R/vsGspl"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so1748626276.2
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 09:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709833223; x=1710438023; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bbbX1TG2BWH8q29heBgqTmsbGlvHWc4NiRRO0gtZGa8=;
        b=R/vsGsplAP1XeaKUaGssGFV3Jf/w9ffek3jYJuqxpMC4zVJ19bJA/rUezCKcVs9WGC
         1biXVidEdXIlbaq4LJLgwaKzwIK1XoG7fc5pOqUkYhK5umWgxyffY8UwIoGW9JVF8iBy
         vMza7ML4zNx7kpBhx1Bem8qj+4FkFzR+5et/iWu/0rAC6wPgnpvuTHK2FrG+t+0dYkdk
         LW9SyLopXx54FpFS9a1bof4LwufHYoXBD0WFYMVWuSKVfM/dyUEKIpH5ow/0sZtTt0ZL
         /4nPtYpbD+zEv9rti9ww7JNY98MUtmGf4Fff+i+AV1+rS5quNJntwRSyzgTYewLjpkdX
         yfxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709833223; x=1710438023;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bbbX1TG2BWH8q29heBgqTmsbGlvHWc4NiRRO0gtZGa8=;
        b=jfXRTPLPiHPTyOAdfi2yxFEuSqO3yvrElTPzn0ud1vG42gxUdY4bbI6pertbaF5VFG
         gZ7qBOjKFtj2eoAnmOGjBUGNIzWkfjydLB+ZMgOT/oQpoeY1+0CAwECCyuURwQefYEv7
         nsZwhfrCkl0iM5WjwicVh2RFbQUIxFPbibeR4GAZjX73r0cOO8di/ANf4Sd1sJT33A4J
         muPFn7EZubi0idd8FKG9ibz5qZBGfiE+Npsi6xcIcrRi+JvAnuuCh5CCWH8SAetm71C8
         n2IhfDBlbOYz3IaQpGQVBtH1o0w0xYJEhuaVW1WbkGcIVQQikyTi2ji3MYOAOREPh1Vz
         mynQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhkdJDQnqfD0kNOO/cmfxJuowRKY3oRVqpCgh3uUGuIjP6/as+e4D/uISxKrpeqKPaK4of4U4vI9ffSPLMSrBX2NBBdryluQ77ot5v60l2Lw==
X-Gm-Message-State: AOJu0Yz/TY+++ZqxifnLCo/ZxqalSgizJHpkVHFPJ0+KuDHtTkoJCDCK
	GopmgnHY4CEcbwRLtcd+85WZQs5iDGRv/8fBoHarx0cVE/bB2mlvVzOtgahwsb/sKMT+7s6pv42
	QrH9RKg==
X-Google-Smtp-Source: AGHT+IHUl58MW/cUd9uCSmHmzkjs13fm14Tb3sqkIFHwDcPvVmTVkoCqoONHriLNYdM1AH7uH9UBW2dY5WQp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:6902:18d3:b0:dc7:865b:22c6 with SMTP
 id ck19-20020a05690218d300b00dc7865b22c6mr762132ybb.8.1709833222401; Thu, 07
 Mar 2024 09:40:22 -0800 (PST)
Date: Thu,  7 Mar 2024 09:39:49 -0800
Message-Id: <20240307173955.3982040-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v2 0/6] Extra verbose/perf-list details
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add more encoding detail and raw event details in perf list. Add PMU
name and reverse lookup from config to event name to
perf_event_attr_fprintf. This makes the verbose output easier to read,
and the perf list information more specific.

v2. Address feedback from Kan Liang, "Raw hardware event descriptor"
    becomes "Raw event descriptor" add assert to keep term numbers in
    sync, fix a commit message.

Ian Rogers (6):
  perf list: Add tracepoint encoding to detailed output
  perf pmu: Drop "default_core" from alias names
  perf list: Allow wordwrap to wrap on commas
  perf list: Give more details about raw event encodings
  perf tools: Use pmus to describe type from attribute
  perf tools: Add/use PMU reverse lookup from config to name

 tools/perf/builtin-list.c                 | 21 ++++-
 tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
 tools/perf/util/pmu.c                     | 83 +++++++++++++++++++-
 tools/perf/util/pmu.h                     |  4 +
 tools/perf/util/pmus.c                    | 94 +++++++++++++++++++++++
 tools/perf/util/pmus.h                    |  1 +
 tools/perf/util/print-events.c            | 55 +++++++------
 7 files changed, 243 insertions(+), 41 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

