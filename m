Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C691C5F27
	for <linux-perf-users@vger.kernel.org>; Fri, 10 Jan 2025 04:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736485061; cv=none; b=kNzz0xOadV2p9V8AXQQkCzTnRyFpdLGDhE3tRWR6D15nU1/+tXYDYwRugEJYI0zDYXPPLPO85WcECz0vuJEw/sHAUMTwGRculhTxBMDQvXOzFeysPvNPr6n3pDPqJsWm8m8P4vSGIwZ9MfHScrvHsefp7T8tAbS00e3G/Z/hp9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736485061; c=relaxed/simple;
	bh=FAPuDXbpzydSeOdp3Bu3UCMfnS7F6zF7sEI63VHNyns=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=LqNo2ggbUhh1FAxIdCUSyW1GnYJ0dT0Gm9dhS6oSuuKPueQAyKLOLsa+RP5DP+HfqFSBl4bVlntDWQnlcFwS6P3dMHO49/EoYQJ7z+IgyMoGpAfZrPy5Y8+BgD0eBd3HpJI6rR2aL3h8w4+lLoocP0V80HCBd558nt0bTS3tBxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zxb4nw7R; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zxb4nw7R"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3988f71863so3895373276.0
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Jan 2025 20:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736485059; x=1737089859; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DyoAt1BCWmcZs38bcoT5eb7q9M0YpislLNPu4O02Cfs=;
        b=Zxb4nw7RMmlFHb2TSplHf9EcxZSwgYl4SZ5oifxS5a+sCsetTXQGXp34x2L7gm2t7p
         /hEvhhgkuuzio5lTlHHBRKg+VJGRwqxaqX/GVa+BhcnwHSiItJbwMpCsnYafeS+A400V
         G70rwfyofc6vzUxyIu0TRCdxWcHOEDRlGWQaL3u9Ml82QlMXgrvn9JnnKMuYgPxhgNbT
         CdBeQO1RTB3nh/TBHBBM5ZljmP8qaBkEFDRPmVjOGR90D6Y0KdqQkAxbj/erSUG0SZCf
         b0iq3aYTDjtRMZLxLHWUfPYcqKuaanOX4cnO6KdWCNtk6MJyyp8TBXJfmk8TRKxCKF7t
         dPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736485059; x=1737089859;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DyoAt1BCWmcZs38bcoT5eb7q9M0YpislLNPu4O02Cfs=;
        b=eanMC5bjxnT1+vXTzZMrha5o8Ijxi8yv1KNU36P7l3zuo4SJNKWIC/2ZVby13vxmSz
         T4sarSZmQEVVr1iVChnB+WwSvNY7l6y/nqH+MBgOy/oUl56spIf1m7GQF5NHWy2VQPsr
         raUV74j1pSO+BptaQlgLUF+lTr6Gu30aHA7YkEocZVZtzP/9rulTimoOfatK99jreFai
         0fi2BJgXKeTsyxiUPDNUk6tnyp+ZdXHHmKD8BwFGgqfE11P+XT1h2qxtQurFSNWIQze9
         PYuCEF80uKbwZZM5tG33D1hfoOwvB7Yyp7n+aiSZf+9t/c97QxTMgX+5Vg7XIlxkhc5j
         PN0A==
X-Forwarded-Encrypted: i=1; AJvYcCWMQ/xdNoahjgorfgq2ci5+/boRDFjXuIdaoJ87z9v7xGg7QkSNarmWu9w4gWuTM2eG2bRSqIsocs3NLQRylPvS@vger.kernel.org
X-Gm-Message-State: AOJu0YwxpcYbOedak6S8RkNyI1JrVG4nSCu6h2zYibOx+nOF8l8P5VOw
	GZt4ErBS6QzDpop2VOlZHYaHXBYeh334ASEPK0JRk22Hcw8Hhgpt247KSPEof+YpkFmgKor5Qld
	FRno1aQ==
X-Google-Smtp-Source: AGHT+IHvAqSmYq6uTmS15RCUBVJQtY64Ijclo1XlGh2FptX3aszzO5hy/InAhFARQL4SuDgHTFcX15F2Inzc
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:7ea3:d1e5:495a:9a4f])
 (user=irogers job=sendgmr) by 2002:a25:361f:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e54ee20cc49mr21534276.8.1736485059515; Thu, 09 Jan 2025 20:57:39
 -0800 (PST)
Date: Thu,  9 Jan 2025 20:57:31 -0800
Message-Id: <20250110045736.598281-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v5 0/5] perf test: Add a runs-per-test option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a runs-per-test option to perf test inorder to better diagnose
flakes. Each runs executes as if it were a different test, the tests
appear together in the output:

```
$ perf test -r 3 lbr -v
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
122: perf record LBR tests                                           : Ok
```

v5: Fix the patch that updates the documentation for the sequential
    option, as spotted by Namhyung.
v4: Fix crash in dont_fork mode caused by cleanup work.
v3: Improve perf test documentation, including for the new option, and
    add some example output to the commit messages as requested by
    Namhyung.
v2: In the v1 patch Kan and I noted cleanup that would make the code
    cleaner and less indented:
    https://lore.kernel.org/lkml/20241109160219.49976-1-irogers@google.com/
    Add patches doing some builtin-test.c cleanup and then add the
    runs-per-test flag.

Ian Rogers (5):
  perf test: Rename functions and variables for better clarity
  perf test: Send list output to stdout rather than stderr
  perf test: Fix parallel/sequential option documentation
  perf test: Add a runs-per-test flag
  perf test: Improve verbose documentation

 tools/perf/Documentation/perf-test.txt |  20 ++-
 tools/perf/tests/builtin-test.c        | 223 ++++++++++++-------------
 2 files changed, 119 insertions(+), 124 deletions(-)

-- 
2.47.1.613.gc27f4b7a9f-goog

