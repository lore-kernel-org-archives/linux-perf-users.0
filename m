Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119056BB46
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Sep 2024 05:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725426372; cv=none; b=hymsah8KoUQzzLQ2Yj+/qlbiLXSohyO97aIE6B/qBE3pzkzE1uiDQeKSNBYs7NerbZefH+4g2Zl3nGDMk8ZhiMypfBCvqf0YSonr4XFOk8+z0D5h3rqyZ0r/oYl7nmzO4vyNVcpEMfSm0ei/3a1vEwDJQaltu98Lg+vDrsiTN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725426372; c=relaxed/simple;
	bh=8NZXFOK5kVcVvWq34hjYgP7IR//Zf1C4jXrpWDVCx7c=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=iKLJ/Ts/lvyrQPkDsAEd3xqLAJlq0nJzUT/N5h+qCmvaMPkkc5XB22Clerr+JL++3M1DoX/fyMtYU1PiLdAwDvMo3iA3x7efeKfm9n+22HATMOewEXdEWNE/r1RMOPFJu7BrIS21h3M2e2N9Zn7YtD1QilrAfbHBfS3Q5FxaY3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QCywuEXl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QCywuEXl"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6b41e02c255so128797827b3.3
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Sep 2024 22:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725426370; x=1726031170; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sOEY0OPjV6UwK7RE5otslHgrEtU0LZKMZO4cnEiTsX4=;
        b=QCywuEXlQGbWWJO55l8l1rR0S68oWX6ixiFog6hcIQpXiYf0Ffs4x8z5zEiuwBMfh5
         NLLi9KkiahbpVxNIl9d27UQOne3XRvux+FTFwXNVbKVfJW+q9a1uw4jQVudKRCTJ3BIj
         PQh/1rw5iUQALFEwvsdsZ9Wf+s8c+qXIUgaMQx8lqC5bOq9JQHF+zuCEDSbQV6tJNlbE
         gBmymHSWDoECksksE9H3SCdbS8F0jICrTuXF4NdiMDvszR3CrqH3mQvKQcHHzFGhvOJk
         qPsc2cSwlcuCytUsZF5jD5TJGQg+lJYTYi+y+RjLDDRSnrvaqX3wPiGGTaBbdw0Ptnrk
         X+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725426370; x=1726031170;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sOEY0OPjV6UwK7RE5otslHgrEtU0LZKMZO4cnEiTsX4=;
        b=Ql60+WXP+na3wYl5Q68Ui70iKLIqjch/15K2N6MQq+fiwbx4mJlmg8A5zgbWNge99l
         69YFhELf3fa8JLWhwkFfUEmGdg55GHJAb0+8iW70cXDy2swIZ/mANZ8GAAHRC35bzFoy
         VvkcPJrhQiLIPAh73lVP1cu9ZLHb77U5hte8aOSZZ0PoXOTWJxovIuHnGOsgJCyoFhfm
         Vi7FOtXUstRc9x2dbg0L7ujAC7PbLxYXh9oDcCWmDNS5D1Y765XaNaUG5zs7ltihl5n9
         iZveWDm05e7IwKZKVb5KgQ664yESp0tY7pBpxgx6iQLJJEoqyAP8m511GFvRfu6//E0E
         3iLg==
X-Forwarded-Encrypted: i=1; AJvYcCXfxI+o5Ysma2rkR+5ab1NMDExL+JdGZyYdXXnxsVbUnvsq8F5GZY6kXMEWrqLbb1jkIMreUSIZuDiI9OQpb63j@vger.kernel.org
X-Gm-Message-State: AOJu0YzXfcgYsZlG9TNIcMeXA1vb5FfrYlksJ5rBxPFeWpasKcA0dMkj
	vowIO48O40qK2yBRsSsskpgw4GmccG82h2BmZ3xTlYFdRroW7zonTG6+xHCjti2KlNd5o9GPBKZ
	4vLZh7w==
X-Google-Smtp-Source: AGHT+IG4q2Rfl1bh+1E2WEnu6VeIwyumA3FKC/smF40viGQ80EGwkIhHpGxoi6rFJcYWGrtZnXz/zCN+ierB
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:c48b:5e3:a63c:2d09])
 (user=irogers job=sendgmr) by 2002:a05:690c:713:b0:663:ddc1:eab8 with SMTP id
 00721157ae682-6d40f4397a5mr3374497b3.4.1725426369795; Tue, 03 Sep 2024
 22:06:09 -0700 (PDT)
Date: Tue,  3 Sep 2024 22:06:00 -0700
Message-Id: <20240904050606.752788-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Subject: [PATCH v2 0/6] Various 32-bit and test fixes
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Dominique Martinet <asmadeus@codewreck.org>, Yang Jihong <yangjihong@bytedance.com>, 
	Colin Ian King <colin.i.king@gmail.com>, Chaitanya S Prakash <chaitanyas.prakash@arm.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	John Garry <john.g.garry@oracle.com>, Junhao He <hejunhao3@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Running `perf test` as an i386 executable yielded a number of
failures, some of which are addressed here.

The first 2 are straightforward use strtoull issues when parsing a
64-bit quantity in 32-bit land.

The 3rd patch just avoids a fail when `perf probe` isn't compiled in
(in my case as LIBELF wasn't present).

The 4th and 5th cases fix the breakpoint length, on i386 so the
sizeof(long) used matches the kernel's sizeof(long). On aarch64 the
value is change to 4 instead of sizeof(long), ie 8, as future kernels
may make 8 an invalid argument.

The final change addresses i386 watchpoint support not supporting
8-byte values.

v2: Fix a signed comparison build issue with gcc.

Ian Rogers (6):
  perf pmus: Fix name comparisons on 32-bit systems
  perf time-utils: Fix 32-bit nsec parsing
  perf test: Skip uprobe test if probe command isn't present
  perf parse-events: Add default_breakpoint_len helper
  perf parse-events: Vary default_breakpoint_len on i386 and arm64
  perf test: Make watchpoint data 32-bits on i386

 tools/perf/tests/bp_account.c                 |  4 +++-
 tools/perf/tests/bp_signal.c                  |  3 ++-
 tools/perf/tests/bp_signal_overflow.c         |  3 ++-
 tools/perf/tests/parse-events.c               |  3 ++-
 .../shell/test_uprobe_from_different_cu.sh    |  7 ++++++
 tools/perf/tests/wp.c                         |  5 ++++
 tools/perf/util/parse-events.c                | 23 ++++++++++++++++++-
 tools/perf/util/parse-events.h                |  2 ++
 tools/perf/util/pmus.c                        |  6 ++---
 tools/perf/util/time-utils.c                  |  4 ++--
 10 files changed, 50 insertions(+), 10 deletions(-)

-- 
2.46.0.469.g59c65b2a67-goog

