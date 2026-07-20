Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E942B3EA949
	for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 22:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784587937; cv=none; b=ZX3E+HLK4fJFgRWiDkMcRCtieBUjTjRPUAC9sDuylE6uC1LcCkiDNPNarpQIcCYE5ab3s/DkePTa92+cYhU/deQbPXhTOgIYmswTwVWusjJdSLrgAzpwkOJQQO8/LUts0JHFiu1yU96TBjHrVudEVOzRzEBy3GGklWwvUNomaDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784587937; c=relaxed/simple;
	bh=5A9pTIsEX6Ff5p29dhvibLGD9qKe6ff+wRIK2yncZd4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=auwIsjwiyqihQWb+eLeue+F8GG7iB8neOB5mbEJGOE5Q+jEE2jYj00UD3CLOF3nF8wOs2nwxmHKWfyXETy0SVlkckfeLQt/S312qTTX7X2C5IS7QoM+1WplUaoO0/vWr+5BypZvAQ6KNJcFGHw5KpjRxFtrKWLECBa3qL72QyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dNZrV6WD; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNZrV6WD"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so16197614a91.2
        for <linux-perf-users@vger.kernel.org>; Mon, 20 Jul 2026 15:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784587935; x=1785192735; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T3DGekGfKUgaGePiSjsnwXJaoc2HZPooCo5X69eH3hs=;
        b=dNZrV6WDSe3JlE4CHzfrTvGT+V9TvguM6aJX0ePGkkM8HQPAmEi0jTasZQiQY1sXSf
         MAu6g+5gCL8Q1SLy3SQTtvsOYfkJ1OXeofFpVBKbW1MgM8hXVCvPuQh+DA/NKQJux3Zv
         FpEcMe6255X9d+U1IUAh73UxOLuUSPFzDXJvlohtR24esVpygJrSDalwQwYEK/0FrYR9
         8PasfalMn6pPPBaM5LDy4iEPvtAkfRQXCmZvCHRmo6EMzw0/WwHYFzVMPSFcDIkY7g0o
         cd6ArNEWuQNe4Pu0aeybxDvWbY2nylj+UnyvkLVOF2Wuj7KNMtIBOp1QDG1D9eBtKzzO
         on7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784587935; x=1785192735;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T3DGekGfKUgaGePiSjsnwXJaoc2HZPooCo5X69eH3hs=;
        b=rYPLjwLog9Dm/tpnJn+cWMzT8EFBSeIvQSjV+HGHSOiCwBItYodiFY4YKa1pjFrwXw
         Bk8oHKUtT9kTIjIzg5AKKTcmeUsJNBJu3Sr4xFR6cAazFT5K+ldzyZ5vFR0Q8XkWNjsg
         GdxL9lytOotK55rYHCF6qhVJJV3xj79M0jX54eX+QuCACvC7o2mLDEta0ODGsb6Tn3M+
         Y/t+fMI4S3Zy+YmHzx34MZoXaD+bvFlgGjjCtuOmQA4mLvfVPsMXhoA4jaLeijSMmWCA
         xYfJPVaWUNrLRGmVyMtffT3UkfLu4hEuMQyc4XDLGKN2BJWgtnGjrziM7tAplmLEiSg1
         31QA==
X-Forwarded-Encrypted: i=1; AHgh+Rrf133vCsD3vqQUPxaFz9330byU4UedWA9W9IQLo9OIgJuCsqpylwPd4buTarApx4aE/2FzMzqGuvIJ/70TIjNH@vger.kernel.org
X-Gm-Message-State: AOJu0YyCiYJIcMxB/Gv/D+ayfVbjDaKl+fS7SPrfGloAwDcbMz73fySi
	n0Zxiy7ekv+dUPsh9nNa2Ugn9d4wKc9suMAERItAXe8Zh+aw3shuyEIyjOmnvnuIMTrOtIKtK2u
	agTX7TTT39Q==
X-Received: from dlbdz2.prod.google.com ([2002:a05:7022:ec2:b0:13c:dc4a:cba9])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:558d:b0:38d:dc13:6f94
 with SMTP id 98e67ed59e1d1-38e4b586170mr17190091a91.37.1784587934920; Mon, 20
 Jul 2026 15:52:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 15:51:56 -0700
In-Reply-To: <20260720175455.3645946-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720175455.3645946-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260720225200.3810501-1-irogers@google.com>
Subject: [PATCH v2 0/4] perf: Fix and optimize maps parsing, boundaries, and
 bounds safety
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, ravi.bangoria@amd.com, 
	swapnil.sapkal@amd.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

It turns out that PATH_MAX is respected by system calls but isn't
respected by file paths in /proc/pid/maps and /proc/pid/smaps. In the
kernel "//toolong" is placed in the filename of mmap/mmap2 events
where the filename is longer than PATH_MAX, do the same in the
mmap/mmap2 synthesis code to avoid overrunning the event buffer. With
Gemini's help try to address other correctness and overrun issues.

V2 addresses the following Sashiko review feedback:
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
 tools/perf/util/synthetic-events.c | 287 ++++++++++++++++++++---------
 2 files changed, 207 insertions(+), 90 deletions(-)

-- 
2.55.0.229.g6434b31f56-goog

