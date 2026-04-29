Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DB93FFAAA
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 18:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486329; cv=none; b=A9MOFDeje1EwtZTpxk+OVVQo5NGSEvKkpsIA07L//GKPAKcWxkybZ44CzCm4qX5PpbmhnqTm+K0i/VIBnqiWyh7ZKfNRUtUiQQAoapjFxiiZPpySyxx36tuo2piqARvWTOAHy8P1Be4uFil3p1Z3TqGplGlRblBfDhOfUdEMbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486329; c=relaxed/simple;
	bh=II9UcSlnKSmTiBg/MrvHOQc8MKCWmNVK++9AcJauFfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IlbyVAZmEkIgrG9hxEh+uMOV3MHgictJXPNHQ6vrkBIAKJgOw9JxJQOfWr+f6ESuMf0XgQpyI2AOKdN9/D+jscO3ppizXeQcQtRgPhY4SjtcuCcWIFxQrbH1NfuNI0gneuz4ZVYavsSLhOJC3FoYsfUyUQ+1TAn0l7KWLoqVK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mBlO89z+; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBlO89z+"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c7993b17335so11992a12.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Apr 2026 11:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777486328; x=1778091128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fN0zHTn3DicGyILncj/ff/JaD9SeB3/uyr9LyX/yFY=;
        b=mBlO89z+zNhWCqEDD+3IHu6UainN2w1sjKA2se1CkUyiVcny5WYljQv86W9SQuew74
         StTLuEgE/arXMJjK5Vv5b0zVytfgX7/gAbYKZL5OSXIVSSLrcRh+eABzHZ2oAomp0KVU
         i7TRIopv2XyhFqy1axQxifAsi3jas1D0ChoFLuJ87aRNvik07fsgQCpNDqeLoouX2kI1
         REfPdfLkXEwocfCmlBOKNpSYy6s0drG3NsYhmFDkTxjNQL6jR7XI5/8gBMgCos4ncdIs
         MNP743l0sWOBJc8N0owHLikcD26RSlkUUpPeb6VZSKTFSXnZV8f25lKoHJs/ZqldomtZ
         dvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486328; x=1778091128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3fN0zHTn3DicGyILncj/ff/JaD9SeB3/uyr9LyX/yFY=;
        b=YHGjQns9MXpeCFZg7Gq0cIVA60NS8gSZGbhVjVqJmF4/nDbavZigp1HZpYzrH7Nucr
         +F3+9eqGO3y9kVbsdlzumzzzMGZAy29ZxbMS+PPN3GFifZBYbbu2e1wXT2arLWpeNgjb
         TxzIeM+QFyVU7ho0SWToKdQHrWBnhHPpWixn7W1wuAqYMCRvv09qwYWxjN+MuF38dLae
         tjQSKRThoqYH8s7Iud2M5F37dLSEc2jGV8CiRNP7OkLMWLrKPDLrsR8Pot9Ot2f9hKAi
         L9FLcRFhV7m905YIPaxDJbrozvhKx4DYcUwn+7QqxEc8m3NLn3rQZGxpcvKZnaZVQJXs
         0HGg==
X-Forwarded-Encrypted: i=1; AFNElJ+jx9qTBsMA/f5ZpHabei9MfMHkcvTC4bWoOKOd8nGQhGn05Y5QLGZ4aC5fodyTjBVjrCmAOeT2TwgyTym7xsFD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbjvnp/lyQZL40cGeupq+YNQurKPVI8vH0pJdap9MXeGlBjjXx
	0waOvzL8YxFGXWVaAM1NZkPzzaQPU5yVESxPVyBWxbstfSa32MI3HG3lpC5W17FCzJ5zQXhGY42
	0ddq8/e2j7w==
X-Received: from pgbs64.prod.google.com ([2002:a63:5e43:0:b0:c79:5904:e14a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:33a1:b0:3a0:cc67:396
 with SMTP id adf61e73a8af0-3a39c2722a6mr10110390637.28.1777486327713; Wed, 29
 Apr 2026 11:12:07 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:11:34 -0700
In-Reply-To: <20260428070328.1880314-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260428070328.1880314-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429181136.2712655-1-irogers@google.com>
Subject: [PATCH v2 0/2] perf inject intel-PT LBR/brstack synthesis fixes
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	namhyung@kernel.org, thomas.falcon@intel.com
Cc: james.clark@linaro.org, leo.yan@linux.dev, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	ravi.bangoria@amd.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

An intel-pt trace can be turned into LBR events either in perf script
or perf inject with the --itrace=L option. With perf inject the
generated perf.data file failed to be parsed as the sample events were
out of sync with their perf_event_attr. A range of fixes were
required.

This patch was separated from a large perf script refactor that
highlighted the breakage:
https://lore.kernel.org/lkml/20260425224951.174663-1-irogers@google.com/

v2: Response to sashiko fixes for patch 2, Namhyung's acked-by for patch 1.

v1: https://lore.kernel.org/lkml/20260428070328.1880314-1-irogers@google.com/

Ian Rogers (2):
  perf event: Fix size of synthesized sample with branch stacks
  perf inject: Fix itrace branch stack synthesis

 tools/perf/bench/inject-buildid.c  |   9 ++-
 tools/perf/builtin-inject.c        | 107 ++++++++++++++++++++++++++---
 tools/perf/tests/dlfilter-test.c   |   8 ++-
 tools/perf/tests/sample-parsing.c  |   5 +-
 tools/perf/util/arm-spe.c          |   7 +-
 tools/perf/util/cs-etm.c           |   6 +-
 tools/perf/util/intel-bts.c        |   3 +-
 tools/perf/util/intel-pt.c         |  26 +++++--
 tools/perf/util/synthetic-events.c |  25 +++++--
 tools/perf/util/synthetic-events.h |   6 +-
 10 files changed, 165 insertions(+), 37 deletions(-)

-- 
2.54.0.545.g6539524ca2-goog

