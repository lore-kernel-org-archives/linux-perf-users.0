Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1914739A7FD
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784677981; cv=none; b=fXx/NloHhRaukx3PJdMeI6cvlVLgj7nm3JW+Ij/cY897nS/M7rpOf829bpaWOzW0BviGLH7gngsbFImT8pabvG+V3rmupLvVl5uhlkeGQqo8ynOeySmA4/yL9KFlHTdXcQEiVquWlOtbgHYWfCqhzP7ohizmqWit3Tr26K+KHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784677981; c=relaxed/simple;
	bh=ZgBVbpZYwP2j+Boik20wwQzO79iuYL5t/gPiVbXkCJQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uYFl+RwDsB+4F2g5XAu7HtZhaxg+/JJrJLxXo9CRc50zPIcCFFr/LtUp4TW7dPdc51niKkEJ/xW67T8hPagUEzJGOxfFVwh1RyjBdyM6TZOt677aEE3Lu19hulq7GLCi5f9C6xJZDpxsAqHcsAkYmP5DRZfnM1X25Rjw23SnN6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SflE3tz+; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SflE3tz+"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ccd1958e8fso119235135ad.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 16:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784677979; x=1785282779; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6nFO+q5bz20Z4ybg+vD17VdVqCcvqm/2TvhlmN/M+I8=;
        b=SflE3tz+ETjmEv3OuMPIL5hnK/d6yZCUCjMa/F73QyVmWTgyy+9R22YVjIJH6Jx5T/
         3fLvMbk/i25Scx83UP8QfYZnA9+d8NpmfL/Rft0ZYqMPJLD5RQclKE49Yg65lEIJHBkm
         3iaBece5fkVdzYGs7Gx6iWhipY3kJlWBAdXSN5KeFIQy2OHdF4lyLwVE1qQzMcMRSTzE
         JxHNqUu3OsXK/jEsx3KvorY1m3gu0Q6XYXC8o/8staheVVWk/khuIv0cT+BF7NgQKPdq
         rjRRosmKnBpn4OJcjWI7g57cgoHe4b+v5/Dkkr7K+sgqlcF0Rn0Za0vv3R+M1Cp2vY+I
         YQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784677979; x=1785282779;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6nFO+q5bz20Z4ybg+vD17VdVqCcvqm/2TvhlmN/M+I8=;
        b=skim5ru4TE5OpMtV53hSbcTEBz3TDI2cAAQqs109DmSoKIX21DEu0VJHjvYVvKERw3
         bUaW1c43Nse2c6jHMKosbKXLBRaemTXCuW8a9bpc9527LjoFOUMuie0s4LFIjkmWZ5wj
         AMppmoRaKWviAUyarIKkLAPouahFNZM5EtRhIcgej8QEmesv8fl+WoLKh0FTI0zNetGN
         GI9GyzaE3QddFBPwYgHsVrN/+BAXkcdx860oylHMeuEK8W8HXbn4BewL/f1Af+ep7UaS
         p/yVbUHLSnuvBiMxP995wv6dw0v9c3g+vL+Llb+xARBWXxhdq1lYOl+N2JIH2LrKoJ1L
         cMfg==
X-Forwarded-Encrypted: i=1; AHgh+RqDWJcokVHirbtosKZqg+QpfBzewtSyHN6LREgsUvHodMOQ3qrWr6ooBpWbe6ItntpWyJONM9ApZMTraZLWd9J1@vger.kernel.org
X-Gm-Message-State: AOJu0YxQzIOlFvjCdTy0clfqY5E4KMsL4rIod3Ew+Z+ccK2iCnGaAmNi
	TmhYn2i4D49kGXLTlfx0AHdnsRDANhrUiQ/BE+k9mAJf2HM/eSYD+IzToDzcrihFORs244JRSqK
	QCZ7nLIt/KQ==
X-Received: from dybgl5.prod.google.com ([2002:a05:7300:e005:b0:313:cf3c:796])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e844:b0:2cc:307c:51fc
 with SMTP id d9443c01a7336-2cf348b2545mr231293825ad.21.1784677978487; Tue, 21
 Jul 2026 16:52:58 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:52:49 -0700
In-Reply-To: <20260721230952.267754-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721230952.267754-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721235254.294053-1-irogers@google.com>
Subject: [PATCH v7 0/5] perf: Fix and optimize maps parsing, boundaries, and
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

V7 addresses security review feedback:
- Adds a standalone patch (Patch 3/5) to fix a pre-existing stack
  buffer overflow in perf_event__synthesize_cgroup(). Eliminates
  in-place null padding mutation of the path stack buffer, calculates
  aligned path_len using PERF_ALIGN, clamps raw_path_len to account
  for machine->id_hdr_size, and uses strlcpy with combined memset for
  alignment and sample ID header padding.

V6 addresses review feedback:
- Ensures Patch 2 leaves module synthesis callbacks completely
  untouched, preserving the pre-existing build ID clearing logic in
  baseline.
- Patch 4 explicitly clears PERF_RECORD_MISC_MMAP_BUILD_ID, build_id, and
  reserved union padding members in module synthesis callbacks to guarantee
  no stale Build-ID state leaks between module synthesis iterations.

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

Ian Rogers (5):
  perf find-map: Remove PATH_MAX 128-byte stack array restriction
  perf synthetic-events: Fix line synchronization, bounds, and
    truncation bugs in proc maps reader
  perf synthetic-events: Fix stack buffer overflow and bounds in cgroup
    synthesis
  perf synthetic-events: Fix bounds, stale state, and misc flags in
    kernel module synthesis
  perf synthetic-events: Fix bounds and union member access in mmap2
    build_id synthesis

 tools/perf/util/find-map.c         |  10 +-
 tools/perf/util/synthetic-events.c | 309 ++++++++++++++++++++---------
 2 files changed, 223 insertions(+), 96 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

