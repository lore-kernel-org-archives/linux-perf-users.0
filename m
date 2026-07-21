Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470BF45DF62
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 20:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784667483; cv=none; b=BxCgLrVmun02r8/qKZIPzH7qjF7MqkaBPToWFJmrEDRZDYn1VM5zwEhONs68Sp1IvTpBUN5DssyqsW7Sl9mkVwhTAPlc4NwKse3Dv8eLIgHQzuRhcT/61aNB4M0omZci6CW0eHOaUhM4Ks24VIIcodFEZg+hSQ8TSkXJS8cZ1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784667483; c=relaxed/simple;
	bh=QqhbTnK1QW3UXtaxijpP1ZX0dcwh/S6iV1YMab71cHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kY1zmIoAVW8W0SD89BJnEMBs3VBBDwwnh9fw/KvrtdiWG7J9RapTBmVO0a2kxvOuSkD1pBiltzSG4cWC+D0KDWW/GxxPinn257j6kkp1zSG1KOFDvE+WhK4MD7wOhAlYQJgt90pbC7H45XzF+/+F9h9wBPXirZKuwZsrAeo6dnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3O51nrk; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3O51nrk"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e5a616d07so4023565a91.2
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 13:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784667470; x=1785272270; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TGt7N9aWiMOznfCkM+Ds6bJfDr6akzbWShF9H7bPoCc=;
        b=R3O51nrkMtYsOXtUzuc30gUpmxAbvs+Q0eQ8UwTCeIpXznSOuUElJDCWr0Hu4VP/mY
         H+laleL84J7xUHE5MRb3oiW+1RtACAFM6yjPo1zderROyIMct4avQ0RbYMso4VYK+7fu
         lTEhylMhfc6sLh4QbxqdCXODVPUruxNgUSh/SnxRHsp/xhZN1J9ZBzS8ncV8PqnPDNJu
         DUdsI/b3WbG6N8XdHYg7/hV5maEj6vyE+BngpcHAJsMfO9ONqF7u+uosWeO1XLgcecOw
         z8vwHb0ZwIcwMvlP5e/VFou5yGl01U3yFPwniS6BSEjIK9pSEKp67g2G33LXrtZuQSs8
         HCeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784667470; x=1785272270;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TGt7N9aWiMOznfCkM+Ds6bJfDr6akzbWShF9H7bPoCc=;
        b=BY0zW2P13gg/A5JQRHc7FqrQ6ZNH8t6e5wgfWI2vihdWgFx6tM1oGngRTJxUQ8XaH+
         HGddaBZgpWdRwaIA0x8rGZG4C85nfCXBkzVJ+vFIYZZaR/1ixpq0c82Kxj0uoFy3I/lr
         PLrJs9k6IzK5hCY4j+/CXh9f4XzOk9woHwX1l6bzrmN/PubLu62roiGAvX14Y2roR6Ep
         hoNjwC0kHIXo2tXVAV/XXpgpK5ivXqQpwQEDndmhCekRjthtdjK/jy96O24AtQNWWXkp
         f32QvYYoW8v88cbWqEZofxaNh6RkABMTrYleHFzdC+nF0grRVMnjEdbrIn3GE8MVPh/d
         nVbQ==
X-Forwarded-Encrypted: i=1; AHgh+RogqfTVJOdgnM2/C+3EYaLuDsVDgsQEJmKATMCirBxQO5MZ0gmhjdfzw4gyR+GaDkhKY5A3EVYbxtFJQ5p9IRAw@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1jm1IhfsQb12OttcIawKDLmRXF2O6G4UzCUca4tkM6DqVhf1j
	INXukSG91B10jsumRSurDvs3x9KB3rJbLKIfZ+PGB7BkPDQkVugl8e0UKYrOlRLNTSnVSMWmk7m
	cK7Tyiuxo4g==
X-Received: from dlj39.prod.google.com ([2002:a05:7022:527:b0:13c:e616:911a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3f85:b0:366:10f1:3d91
 with SMTP id 98e67ed59e1d1-38e4b3dc094mr19933531a91.1.1784667469344; Tue, 21
 Jul 2026 13:57:49 -0700 (PDT)
Date: Tue, 21 Jul 2026 13:57:42 -0700
In-Reply-To: <20260721182150.94016-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721182150.94016-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721205746.183206-1-irogers@google.com>
Subject: [PATCH v5 0/4] perf: Fix and optimize maps parsing, boundaries, and
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

V5 addresses technical review feedback:
- Clamps pathname buffer sizes in read_proc_maps_line() and module
  synthesis callbacks by subtracting machine->id_hdr_size. This
  guarantees that when sample ID headers are appended to events (such
  as stack-allocated events in machine__init_live()), the event size
  never exceeds sizeof(union perf_event), eliminating stack buffer
  overflow risks.
- Casts member array memset destination pointers to
  (char *)event + offsetof(...) across all synthesis handlers
  (prepare_comm, cgroups, mmap, modules) to prevent _FORTIFY_SOURCE
  array bounds aborts when zeroing padding trailers.
- Confirms explicit clearing of PERF_RECORD_MISC_MMAP_BUILD_ID, build_id,
  and reserved union members in perf_event__synthesize_modules_maps_cb()
  to prevent stale Build-ID state leakage between module iterations.
- Restricts max_filename_len in perf_event__synthesize_mmap2_build_id()
  to the minimum of filename array capacity and union payload space,
  preventing strlcpy fortify aborts even if union perf_event expands in
  the future.

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

