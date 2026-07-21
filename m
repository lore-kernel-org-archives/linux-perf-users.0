Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E2246C4AE
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 17:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784655242; cv=none; b=JAUnAS2m99vX0RHEkKUm4hWMOpZUhIJed/OGnoUmaKIOKTBrguwyVV4awBsLAJq932muYmdssOu8LFNrl60blHjtLu0sa2raHVoj2yIg7+wc6vIRyS3cFtVSpaUAnOXp9WRn7689gSUfBVWw4S5ryMkGKIVExXNH2oML8CKAFig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784655242; c=relaxed/simple;
	bh=OYTObqt3amkSPdQxg3z1kF/GbtBjryn45sQZDBynauk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Xdb5PYlQHdLtKBvMoFgRi3JQ7ek+CjETYwSTkgbpwC+hG+3+w+Hx4q7vzgFI/QPLJTHH5UcLvScS3hV2jE7ez2Zk3Go+rgKWq0pSA5D9R6vjk5AnIJ6kRJms7/vpRdRJnlcpnGGIIzzhO0j/kayu4dXBeK5b1kW3Rga3Aex6H/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GOBuhQco; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GOBuhQco"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38827cee19eso12600812a91.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jul 2026 10:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784655241; x=1785260041; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cSCvDk5nPww14vo9MHhWAorlTeMJB2zBj5PcutPInCE=;
        b=GOBuhQcoDLdSFA4EoQTfWwrmbx1TM1NMZ46b4/KG1VBzpA100CoUzgen302ZtMtF0C
         GGgBJtnMbukn4I7+J2JrLwI7ga7el/Ff6a7kvUEQrP19bBNagKvGGCMC8CObIw4Ve/ra
         twVzN7SH+kom617TZK9xfb3c3YWmgcapTgP4EiXsZmmJK13TqcYuyHWuEr2bttxU6vYx
         h1ceJRpf4CenhdQOwzHA3+RMIk4fkGVrc41oNNqaeTHz5upVyAHewl58VDeVCAk/S3My
         x5KtG67guMa1EFk81+xEAzd/vRfP2dcznhywqZG4VsMiFMfjKrrdVwNHBZUr5uflaa2G
         Ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784655241; x=1785260041;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cSCvDk5nPww14vo9MHhWAorlTeMJB2zBj5PcutPInCE=;
        b=rLjnGP1ZW59DEec00rpoE/nhq9/UbGU260cdj1tYBtdqIkwR/5CxYOVj9ND24mjgBe
         YqWrrA4GsmgfZLSnf2pHu6KaK3xjfXTuiQ66QYNWVllwhIAVIPLjYeLr49pM0ruvV1Np
         PWWd7uz22BitC85BZKJwTi/MTohOYpP6qDHxxKjtx+PuHRXuMzlkhq/iKAqNkuE8PXrz
         lou+ieD9P9r+obHX4mQUYJJSWDxkifoB35Jx7RTRbizLol/kgx/buNw4qONx/NtFb+vw
         yEbQA9C/rZA5eAgc+M4qlKEhi4zdNzH+DXKejxd50RNxRa/lVB2BX3ykL3VAEXGVHcx/
         xc8w==
X-Forwarded-Encrypted: i=1; AHgh+RokjTlR2ipE7l8WBjbRFLv8M48jqLAeRkEUET/wTt2d8mTtTXLUIjl7nrQOYlnzWWyiM7IvlFU2sIxXMS9gZ/ZG@vger.kernel.org
X-Gm-Message-State: AOJu0YzTwWuF4+kbpCZbz7uIZsYBX8M8lKJp7Hwp4eEBpOe9GQDQNtFf
	e9YyEAVgVdSYeORv4xP/bfv5Fsfm4uRJYy3G4KcB5LrwWPPexnT4UhFFynPL3CjDf+GSyciWkP4
	el8lgzQvQlg==
X-Received: from dlbsn8.prod.google.com ([2002:a05:7022:b908:b0:13c:e5e8:c617])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1f8d:b0:38d:c0f9:30be
 with SMTP id 98e67ed59e1d1-38e4b578797mr19205476a91.38.1784655240105; Tue, 21
 Jul 2026 10:34:00 -0700 (PDT)
Date: Tue, 21 Jul 2026 10:33:43 -0700
In-Reply-To: <20260720225200.3810501-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260720225200.3810501-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721173347.9163-1-irogers@google.com>
Subject: [PATCH v3 0/4] perf: Fix and optimize maps parsing, boundaries, and
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
mmap/mmap2 synthesis code to avoid overrunning the event buffer. With
Gemini's help try to address other correctness and overrun issues.

V3 addresses Sashiko AI review feedback:
- Updates io__drain_line() loop condition from a while loop to a
  do-while loop to ensure that when ch == -2 (initial character
  non-hex/dec failure), the loop correctly reads and discards
  characters from io__get_char(io) until a newline or EOF is reached,
  preserving map line synchronization.

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

