Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F35A40099C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658119; cv=none; b=u9Fseds1B7zfCTT686OW32+eKwdY+kM2MMtXDnJeiJCf1j9Cs+iXBy5SAWiyHzU8cjuyGE4NKNNdqojlFEiFCqQkXk2570eXo9Mf8Mt05qLlKb4mDxMSgZWVvSf3YDonEugQuXNPFeSvX9sDkyjTKPRVYsmMgtdohtnHw2q6q6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658119; c=relaxed/simple;
	bh=k9UPC2jWtUyT+AZ/nqyJ/OP5rEB4L7bredx0YRihRBQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uBRYAm+ThEfaXh3A/a25EeGUHuciBI4E93QQJ1kQ3ekitf1jikumRDOA0JkNwahkbmR0LnEbMPFOeWLA0LHX5qOazNyYHoHLDDcse0zlR2wn8BvDqgMTKb5Df98wzvo580iJahsPHgUog8tqFJgW3uyOu1SUj7SBgzrp3macRsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rUKcV/SE; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rUKcV/SE"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so11431392a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 11:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784658118; x=1785262918; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yX27j+RKf1WJllB4mwQCE41TCPkOFTd4aXkNKaJTAI=;
        b=rUKcV/SEtYE7dAIAws1KeQ+GFmGdnrGO6sDTvDxAfPhIbxwNTeEGGeShCOz2OHimT2
         EAv1/Hk489tTZKUGJPdu1NLkK7QQ8Ta4+/I/MWxMUN88E/dZF9e0v9/Ci0+j0LZnmZO8
         PLw1xImF53kdZ8kaqZoqC4tYJ4jaiwTSc4q+ib4pEffDejloC0m0mEWWZCazi4Nvs0i/
         PwplyBJ2Bn74JHZV+YGpL5rxyj0HMsyEwyjrbajCOctWsSrcqUd+LsFX3ZfKNz8BUqeC
         FOEW8RenmsHCsU94mQiWjD9YRKvGsFQbagJm4fFGPGiqHtolFx2Fdq0d1Pn5VYE/siMU
         fdEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784658118; x=1785262918;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5yX27j+RKf1WJllB4mwQCE41TCPkOFTd4aXkNKaJTAI=;
        b=sa8F/QMBtty13cQHIUJhy0+bCigiLpxEvxJQXo1OCUMLhEAHHNqZ51QwPYTzQUwPvf
         tL4dG82VdhdndeGh6eCysS8uC5EIM49bLYjYqIq4ws7ZN3ZHoMr8CNO/tnyWlztubNk+
         2sMVnDmqETR4lL53nbBGYRu7vAvpcKeC7g5wk4tSc7Opz4pvjuWi84NJ9u1IpCHPoR5y
         pE6Sk1xBD0Obi1+DEaSHQehbvHzX5XV+9bKFjFWT9P2QG4SaX7kR/buRiBJ3H1C6yEi0
         FL0RstkBcY7uoYf3Gq3tAzGfIlbF5NH1YjFjRDVEeI4FR5IybQThLd6Auq2d4KdFuSUW
         2GrQ==
X-Forwarded-Encrypted: i=1; AHgh+RraeeVzLF198sQYWoQnRmb6jfzqgMra5ZZ+t5nqhdtEDgMBWpE2n/8/bAX4QdVUz21lIyU7Uw/36ooyIR/YnMj0@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8ajb0bJZPkHVsRBL8tD3s7cORt0MEELRYveNUlhi630JgRdnm
	HI39WsAoUzlB/4hkk2Vti1aya9iUKN7Oa6YyQOSCEUClEqKEFRt0lpSkWYrbZXtTWTIXctD5R/h
	d60mUIZgtMg==
X-Received: from dlbsi6.prod.google.com ([2002:a05:7022:b886:b0:13c:cee1:f20a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2692:b0:38e:79f:76ad
 with SMTP id 98e67ed59e1d1-38e4b52efd9mr19034377a91.23.1784658117383; Tue, 21
 Jul 2026 11:21:57 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:21:46 -0700
In-Reply-To: <20260721173347.9163-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721173347.9163-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721182150.94016-1-irogers@google.com>
Subject: [PATCH v4 0/4] perf: Fix and optimize maps parsing, boundaries, and
 bounds safety
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com
Content-Type: text/plain; charset="UTF-8"

It turns out that PATH_MAX is respected by system calls but isn't
respected by file paths in /proc/pid/maps and /proc/pid/smaps. In the
kernel "//toolong" is placed in the filename of mmap/mmap2 events
where the filename is longer than PATH_MAX, do the same in the
mmap/mmap2 synthesis code to avoid overrunning the event buffer -
note, the filename buffer is bounds checked but this makes the
synthesis more similar to the kernel approach. With Gemini's help try
to address other correctness and overrun issues.

V4 addresses review feedback:
- Ensures io__drain_line()'s do-while loop is properly included and
  committed directly within Patch 2. When ch == -2 is passed on parsing
  errors, the loop correctly reads and discards remaining line
  characters until a newline or EOF is reached, preventing tight failure
  loops and preserving line synchronization.
- Replaces member array memset destination pointers in Patches 2 & 3
  with offsetof() casts on (char *)event to avoid _FORTIFY_SOURCE
  runtime array bound aborts when zeroing padding trailers for long
  pathnames.

V3 addresses review feedback:
- Updates io__drain_line() loop condition from a while loop to a
  do-while loop to ensure initial non-hex/dec failures correctly
  drain line remnants.

V2 addresses community review feedback:
- Corrects read_proc_maps_line() and io__drain_line() to safely handle
  already consumed newlines, preventing valid map data from being skipped.
- Restores the early exit block for timeouts so the TIMEOUT flag is
  always emitted to tools.
- Removes an unused assignment to avoid promoting warnings to build errors.
- Clarifies and dynamically computes the maximum filename length boundaries
  using offsetof() to prevent E2BIG errors regardless of struct layout.

Ian Rogers (4):
  perf find-map: Remove PATH_MAX 128-byte stack array restriction
  perf synthetic-events: Fix line synchronization, bounds, and
    truncation bugs in proc maps reader
  perf synthetic-events: Fix bounds, stale state, and misc flags in
    kernel module synthesis
  perf synthetic-events: Fix bounds and union member access in mmap2
    build_id synthesis

 tools/perf/util/find-map.c         |  10 +-
 tools/perf/util/synthetic-events.c | 288 ++++++++++++++++++++---------
 2 files changed, 208 insertions(+), 90 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

