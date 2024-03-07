Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECC63113
	for <linux-perf-users@vger.kernel.org>; Thu,  7 Mar 2024 08:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709799260; cv=none; b=aY8gx9Bj9FIXhB4BM72/kFrvvxuVzbDJXGdn5gTQcVJdXgkCTmcTVEXZ/CxhUc4oiaCgCWO/n9eLBG+Be/7ihmFdogX2ofVRqGNtMLGZF8ZaIPOTjs9f/IjUFEdSjvQ+Oopczm/1iD3uw2+AGSG0zynhzNu+gMRrVSFOLTOdLsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709799260; c=relaxed/simple;
	bh=AL+RlRfmm9EW+2LEBi8CtiwlGFHn5YG/hAzWgS3uKqo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=qEoJIGT5Owt7eud28AgfmQVGzMrzqQYhNrASfHvUfTqCzhOJBdKE/qK0iidzXsf18hZECrM15LCn/mYRceZzv1gWzxkiEPsnzHHS7FDP0MtyWqvYlynDFhTK82ObsWPaYg9ctHdQTS9Md3mLw4vAGGKMrpQX8Az7cNr6JjJQzlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y1r9NuEM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y1r9NuEM"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so990352276.3
        for <linux-perf-users@vger.kernel.org>; Thu, 07 Mar 2024 00:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709799258; x=1710404058; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jd08NyYiMNA91jxsr3beU6ue5ay1ib/5+91nlDkza1Q=;
        b=y1r9NuEM589JdaGoXVvRxdpWgUyIbMGdpmOOEyxdIYC7q/PM0WkVoomwRQ0ghvb2pv
         lAJn84br3XLDld+FHRlfPc4pdT5HdU8X2+p2aIDCgbwjeEoeTSPNsDa2Rt+ZOXlmaz/E
         Kkg5azqiP9JMPYEyCy21uxLXObU0tD9wQ0r6Y2Q+l3mmXX0lNT+BlUFufTCY45gTJ9HW
         dg5vSUwRnjs53jS+tJTfpmUYTXJveFhQdxDUDGrFgySSGnPxap2ur1GTAGk9ONYJ2LfW
         SrWKowqp7R1N/lmd/57IppguhopC4MwGJO4VTzJSUvwmgPNhXRGDlSm+6r7+EOuSHhIX
         xYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709799258; x=1710404058;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jd08NyYiMNA91jxsr3beU6ue5ay1ib/5+91nlDkza1Q=;
        b=soUJqchuYSTWptlmn0wThNUl06jh0NL6m63dPUET7HHHAYE/NSbbO34UR00fd0Q4Io
         +e+2s9Dhem2bMeajuelrZOCy/6V8pppMg7fnkMiWAmKHYLEVym40Ir1FcpJM46O+Cng2
         Ei3+OspxuExEUyguvrUraSLjM8I4VzrcjSCTMmVb5qusvLrmAisuq4oteIB/MjKVW3xZ
         vneg564kEh5hHoAhZdtMxGK8gu17BGs7ZcGfeK8Vsbcxyl5sWDJvuQBRPi1ResOXgn8i
         RuKphT+mt88byjca3OHvn9Dmhp+5vAU5FaKc8iSI4t/W1rZSDNuZkqQtQxpVWunDFarx
         bcDg==
X-Forwarded-Encrypted: i=1; AJvYcCUgfNxcSxsAswwyyGp3+lzoicy+2dJyL1fweI27VnKzkW4Y05QKD1e/yzu41Q3qhGDmqMH7nHZASumP5L1ycdsqHamQnMHyhLxj2vabjZboHw==
X-Gm-Message-State: AOJu0YyF+2UScMMs+D9ykv51Uyp/buh++XBg0Gls5MjDMP+ensJWhTvc
	o+ixdGp3svNcyLw0ZbvCJOp+X9dUBqMXPY0NMVodYWLmttyJbkOUOUa0VWqnX22aAiqvhwwFpa2
	JWZP5Iw==
X-Google-Smtp-Source: AGHT+IE/rVRUVOOG6iD5u0rq/IORInjh4yqAhVIpwNFdEP2M6PoOILBd7/gSGHQTenxg93ynqF7KrUXPJYoX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:47d6:1de1:237a:6728])
 (user=irogers job=sendgmr) by 2002:a05:6902:1101:b0:dc6:fec4:1c26 with SMTP
 id o1-20020a056902110100b00dc6fec41c26mr4442538ybu.1.1709799257859; Thu, 07
 Mar 2024 00:14:17 -0800 (PST)
Date: Thu,  7 Mar 2024 00:14:05 -0800
Message-Id: <20240307081412.3933750-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Subject: [PATCH v1 0/6] Extra verbose/perf-list details
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

Ian Rogers (6):
  perf list: Add tracepoint encoding to detailed output
  perf pmu: Drop "default_core" from alias names
  perf list: Allow wordwrap to wrap on commas
  perf list: Give more details about raw event encodings
  perf tools: Use pmus to describe type from attribute
  perf tools: Add/use PMU reverse lookup from config to name

 tools/perf/builtin-list.c                 | 21 ++++-
 tools/perf/util/perf_event_attr_fprintf.c | 26 +++++--
 tools/perf/util/pmu.c                     | 77 ++++++++++++++++++-
 tools/perf/util/pmu.h                     |  4 +
 tools/perf/util/pmus.c                    | 94 +++++++++++++++++++++++
 tools/perf/util/pmus.h                    |  1 +
 tools/perf/util/print-events.c            | 53 +++++++------
 7 files changed, 236 insertions(+), 40 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog

