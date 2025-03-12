Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E391EFF82
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 21:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741814190; cv=none; b=f1kgHnUR7+RAwIpPys4kq75cMiizG2s5CDnJblqtEgQ6809Kilv98z1O7S928qmxCHCUqfNN49P8WD6+tf/LPP8IMNnzrTilLUVwPj8+4EH9euNE3sV2ZfTvcrD2Z+qpLDgkDb0o0Y0zaoyujsfcKBE4ySsMQPkrKDyQF7Yy7J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741814190; c=relaxed/simple;
	bh=XjoUmC7tY9V2b6+Llm0Cxr+NpzQVvmpQg2A5hW3NXqk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Z6EeBC8oUz3FaMHI6hr7p1vYYuZiSv/ctnK+1EOS89XqBsuscX9AEOAtIZBHXYkOaRdyMhCzbEHvCv+o7PKT//CBWxK1jIvlamYTPgL2sgJp6Y1tQcONSebuMvKGrss0wJhyAX3xt+JpUbGPJg1N6d2A2fao61XqignwKdqWu44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NDIwS4ZO; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NDIwS4ZO"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-22412127fd7so3475265ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Mar 2025 14:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741814188; x=1742418988; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1R2FkT2tfJZh41ZsJKKpXajtCJc0zCkOgHYDY3bqItE=;
        b=NDIwS4ZO1qWtqYA/QY3fx1YmGI/T7B1d1hq3nDsoJAlT1dM3W49iMFrfGlGJWR2xsd
         HRsQSAm1rvyMcJlh8Rxbhj2po3NRFYPVg/OJ89HIl8pIN+FH1EWOAvKIQCfo0QQm9SF0
         xlRnS3xYvkShcKVm8PFz269MV2aeOfDzHl+QvVNee3LY16xItG8N1osMPuJs01jdZUvn
         7lcuSGa0dK8fy/xksfFywyZJdZWBe9vNReEz0rgvMFZwCUyg4G1bdROxp9qf1CxjGdNq
         /ltCSxK0bCzzsuTNSq48Let8xhZ8EtP/j5I8fmiwXEZnQLJ0DVqJUnY9Aeq3kbLwsvsq
         wdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741814188; x=1742418988;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1R2FkT2tfJZh41ZsJKKpXajtCJc0zCkOgHYDY3bqItE=;
        b=v1dRfyK8Irx1u2McsdewkjUzspjTosRHnSGiwRXEgXYWW3RXqM5lFhD0+me9Qm8gmJ
         omZpRSNPZfHJuWqZzNZAqqx7kcG9aiMy/OH/Im8CBqVr/rMKnZFuLDRrWvJbqQEmPYil
         /hx4CGSoaWvwn2QZERkNham76wKd43V7NoTMX6rPoGi+iEAe5lvEPPt/9Cl0uldJ/Rah
         IaVEG85VCMlQJ+qKdC/LAAK8Zv2ACbVJk8sVR6qKV8UccnrndafDdMAsl3CZVDfbtUOf
         jlCi1+vscZ3SNI3VMDfxJLsaqZXYb0Peiuvv01857pCwlVgnG1RghbL7G8qkDqMXIVpk
         XkIg==
X-Forwarded-Encrypted: i=1; AJvYcCVvKNRduEOMbpgogsTzQC/5pfZ0wVLzaN9gqAz6oqgwr+hl79tzF4LoHvmeNkuWmjtE7AwBhLjJCkU19oVSZimH@vger.kernel.org
X-Gm-Message-State: AOJu0YybOcwGqhzVKKFCDeSxrMZS6k9YKvnhJaZsXWSP0h3Mxr0+5X92
	DEEObW5nvyvDar1vg0pfGaiHI6EgztaTF/HhJQ2TPOQRnxopXkUY2wQXJNahd2gllQ6epWe0NeK
	3VS1ReQ==
X-Google-Smtp-Source: AGHT+IG2WLS74cPcK7E5Wvi8f2Oxevqu5AVQwTAFnu05lz4gonixU5828tmhcN0VzTUeoq4/BGCQ/0DZgSSp
X-Received: from pfbho5.prod.google.com ([2002:a05:6a00:8805:b0:736:4ad6:1803])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4b4a:b0:736:6ac4:d1ff
 with SMTP id d2e1a72fcca58-736aa9e7154mr37167458b3a.3.1741814188109; Wed, 12
 Mar 2025 14:16:28 -0700 (PDT)
Date: Wed, 12 Mar 2025 14:16:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312211623.2495798-1-irogers@google.com>
Subject: [PATCH v2 0/2] Consistently prioritize legacy events
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	James Clark <james.clark@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Yang Jihong <yangjihong@bytedance.com>, Yang Li <yang.lee@linux.alibaba.com>, 
	Weilin Wang <weilin.wang@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Leo Yan <leo.yan@arm.com>
Content-Type: text/plain; charset="UTF-8"

Legacy events were historically the priority over sysfs/json
events. This behavior was changed in commit a24d9d9dc096 ("perf
parse-events: Make legacy events lower priority than sysfs/JSON") to
fix issues on ARM Apple-M CPUs. Sysfs/json being the priority makes
most sense, was preferred by RISC-V and gives abilities impossible
with legacy events. Making this encoding consistent is proving
impossible with endless bike shedding, people saying they see
something as a fix then when that fix is provided continuing to
object, etc. Given that in the RFC [1] legacy events are seen as being
preferrable let's just follow up on that and make their use
consistent.

If it isn't clear, I think this is the wrong decision and landing [2]
should be the priority. When I try to have this conversation it just
gets ignored and I want consistency more than my preferred
prioritization.

[1] https://lore.kernel.org/lkml/Z7Z5kv75BMML2A1q@google.com/
[2] https://lore.kernel.org/linux-perf-users/20250109222109.567031-1-irogers@google.com/

v2: Missed revert of stat-display logic for json event prioritization.

Ian Rogers (2):
  perf parse-events: Make legacy events always have priority over
    sysfs/json
  Revert "perf evsel: Add alternate_hw_config and use in evsel__match"

 tools/perf/builtin-diff.c       |  6 +--
 tools/perf/tests/parse-events.c | 13 ++----
 tools/perf/util/evsel.c         | 21 ---------
 tools/perf/util/evsel.h         | 19 +++++++-
 tools/perf/util/parse-events.c  | 81 ++++++++++++---------------------
 tools/perf/util/parse-events.h  |  8 +---
 tools/perf/util/parse-events.y  |  2 +-
 tools/perf/util/pmu.c           |  6 +--
 tools/perf/util/pmu.h           |  2 +-
 tools/perf/util/stat-display.c  |  6 ---
 10 files changed, 57 insertions(+), 107 deletions(-)

-- 
2.49.0.rc0.332.g42c0ae87b1-goog

