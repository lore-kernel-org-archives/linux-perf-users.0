Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7222643B48C
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675397; cv=none; b=LZ5gMBXdjD5wdEJDY7kUlQ1WpIXDKtns7hqpf1FEabGrCQNAmNlQ03EUhi68HRHD8omlR6elYmE6eYOQTgFJpUzEeCsty/Pp5K9JMXQsJB5M//G3zrX6cYNn67PuuTwPGoxDfQ2XxrJGJYOehJbMtar1NAzTddOcFw/QD/EsH7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675397; c=relaxed/simple;
	bh=NZHqzcrqGwdK5Lc5SPDVbw2rQqp8o7YUG+AKlyMz89w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GjvcVpk9tPsSbzWLBthI5oG351yOVBfcqhdaiORJFPHkQqGRF01OyNjehxwd5DpMSwn6JKHAvMHxbZhwf2sd0Q2wiyJTSxQtEuKOLCheUpxdFL7cLQ1kYg9Ve0ZJ0+2WS+2QCRSFsow7r6rMy7wcMitGVDEZ0zl9SVVsPW2Mk68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfGzLbT7; arc=none smtp.client-ip=209.85.216.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfGzLbT7"
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-381250979d5so9057794a91.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784675396; x=1785280196; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sRt81Ta6pTSr62C6hADYhlpri9jzv7r3UrqNrrgbOjo=;
        b=YfGzLbT7iF/0pyewcB8pnGi8bdbcLIeeoJZYoJs0U1VGqTgJNSg8fh4ViQ6vTvKHM4
         mfADmLOp5gFEM8K/HS/NmOU4CrCq03d8kIUenedBUXRGltqD3el2LFqmxHYG3h1rP9f+
         SP5tckK5TANB0oTP/OIFnYj8VJf91fNrU17QKU1TMR/H6oU6e2QXAjr2bp+ah0O9rMoF
         z2OU2fxqBIElMI0eiAXjhqKAkL33DiofezTR9/kg9K1XXVyDtoeNeUrgiMFy4KQy6ISj
         yNBuCdGTJhEA7WJfRRxfI2HKX4uOt6KrfTuB3+bdeDX5e5IHZF4/T7d+CHl8ZxNvQPK1
         ejUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675396; x=1785280196;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sRt81Ta6pTSr62C6hADYhlpri9jzv7r3UrqNrrgbOjo=;
        b=EpXszbvur+HhYdLl++UA1WIsSLUy6Ipmt04eUxjmiM6+QVCZ/eGz8tB/AhW1X1ydkh
         eV2nVPd4R96S+IFJ06zXizFKneNFxT5u6zlQznIxDJMVItNeY91Jsu76Zz+1CPT+UPla
         9FfsWT5I1LU71Q/thjTZtR9iZ+xrlPbAis3gD2C+M3qIlSHgbQovZpbIGxtp6Er+6OMl
         K0HQRHZD6A4bOdjy19dg2JR9MPwxF29il5FWI4Nwc4vx0xAVGxrcC8moghha1Cl8XzGT
         0PQxfL91TOfm+MYlodTTzL6aM97V0ga9UBBsNRACgxrCn0iDbm52sVB1jaCPw4eGh39T
         U3Xw==
X-Forwarded-Encrypted: i=1; AHgh+RqgoQMqNED9LcmQVEsH/7+6ElYCKSh604M1SAjtim6RcmUNCZ1khjUx24FpF2aQa951Rf72wklv162toc+KU/i3@vger.kernel.org
X-Gm-Message-State: AOJu0YyYa2pDVevrqDgFWwg2rrs4r2w71DqPCt+MjxpLWwouSm4IzPqw
	7YFcZTERZ8XTUHHGetwDu08F/pILujw/d1ba0l+eRDMjfN0NyWhefs0ITW6liK3AuvsHw8l5HuZ
	SoW+jUjimfQ==
X-Received: from dlbbq44.prod.google.com ([2002:a05:7022:672c:b0:13b:447c:4e36])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2f0f:b0:387:e0db:bc31
 with SMTP id 98e67ed59e1d1-38e4b56ed5fmr20715701a91.39.1784675395457; Tue, 21
 Jul 2026 16:09:55 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:09:48 -0700
In-Reply-To: <20260721205746.183206-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721205746.183206-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721230952.267754-1-irogers@google.com>
Subject: [PATCH v6 0/4] perf: Fix and optimize maps parsing, boundaries, and
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

V6 addresses review feedback:
- Ensures Patch 2 leaves perf_event__synthesize_modules_maps_cb()
  completely untouched, preserving the pre-existing build ID clearing logic
  in baseline.
- Patch 3 explicitly clears PERF_RECORD_MISC_MMAP_BUILD_ID, build_id, and
  reserved union padding members in module synthesis callbacks to
  guarantee no stale Build-ID state leaks between module synthesis
  iterations.

V5 addresses technical review feedback:
- Clamps pathname buffer sizes in read_proc_maps_line() and module
  synthesis callbacks by subtracting machine->id_hdr_size.
- Casts member array memset destination pointers to
  (char *)event + offsetof(...) across all synthesis handlers.
- Restricts max_filename_len in perf_event__synthesize_mmap2_build_id()
  to the minimum of filename array capacity and union payload space.

V4 addresses review feedback:
- Ensures io__drain_line()'s do-while loop is committed directly in
  Patch 2.

V3 addresses review feedback:
- Updates io__drain_line() loop condition from a while loop to a
  do-while loop.

V2 addresses community review feedback:
- Corrects read_proc_maps_line() and io__drain_line() to safely handle
  already consumed newlines.
- Restores early exit block for timeouts so TIMEOUT flag is emitted
  to tools.
- Removes unused assignment to avoid promoting warnings to build errors.

Ian Rogers (4):
  perf find-map: Remove PATH_MAX 128-byte stack array restriction
  perf synthetic-events: Fix line synchronization, bounds, and
    truncation bugs in proc maps reader
  perf synthetic-events: Fix bounds, stale state, and misc flags in
    kernel module synthesis
  perf synthetic-events: Fix bounds and union member access in mmap2
    build_id synthesis

 tools/perf/util/find-map.c         |  10 +-
 tools/perf/util/synthetic-events.c | 294 ++++++++++++++++++++---------
 2 files changed, 212 insertions(+), 92 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

