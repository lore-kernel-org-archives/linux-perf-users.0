Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31E337F728
	for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 23:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787007878; cv=none; b=doWpdJzAi7nPVTRN+YbmYFk0xlKYqm1oL9SHv4wCuLJf2++FQKSO7Vv24GRd29Q/T/AK746boVfHAIXXRZTYa5OlAucbc7pu6sFyVVAaUFo7/mwGmwuW5DNtNqMkxhanca7iCNjkCsF/nGVxVP0sKvtqi51tlAaz3aEQvDCwCBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787007878; c=relaxed/simple;
	bh=E2yg9022OkkepR+/7YQyGr94IniuusKnDCGS7VjBYHY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ayFrIG89g0PjP6KSB68t3IFRJZNCzLv1sfmWnnaceF7nR4zZiYUBmPd8BZ3kO0SgWSDyTxHsenrLQm7reTrIodDSK9vOTS/UAsrL02QI0V9ODWLFnoiMmt34i3NMwaNK2aa1bJOB6ryRzjezTXdCv8bXrpexIy0ueN794ITC5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kBIsFS12; arc=none smtp.client-ip=209.85.214.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kBIsFS12"
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2cf1c86963bso3446665ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Aug 2026 16:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787007876; x=1787612676; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nnqgvkSQoTyil38hiTRw17A+dku1sXul92vwKTNk0RM=;
        b=kBIsFS12ELZiE4GXQzw0g7ePLlL71yGjtcCDtvt99hZJZL4tFttY48rPZiBu8J9Kg4
         JKYBwOTGiZxN01/TCbGTcof9iBLvzMJG2tHRL1KJVkKP9dCpMhK+uE3HG9mVeDUlPNBD
         qdDLttshWT2qWeJVe9casdthnVJOlnridUaFSBhPwkpdxzNFXNtV8kWXUX8ggbW/1Giz
         P+Z5b/X+1RKWo4oMTM7VaRaRlUB/uUzec0/lDh4KeMjxA5o9iE11PrkJ1PeuO9DnjCn4
         AgZrsEoddl/tYFB6iRLSNj200Xa6y05sgkV6ee+9yPOjmjI6onOn5SUvwYRsqnkV3aSg
         hPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787007876; x=1787612676;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nnqgvkSQoTyil38hiTRw17A+dku1sXul92vwKTNk0RM=;
        b=aGWpG5fDw2pQTbFMcMZh5OAWa9Ec9U75pnaIgODYZoK8sVfZ5Sm3fwGyO53q+pgf4l
         uV7RaqW1jm2UlojdzVR2HWVhpDCJzH4z5QZImkmdMOHUHKDZDETuquiBLpW38qLcEt+7
         7w0pC/zWvds4CusLgsW5M5/BWZ/bf4rNJkyJ5pvgZSSCJuEYF/skHeFy9LLZjIPkIEOf
         mcfaw79Y/q7xSPvmUos9EpKJMQ5+u0FjwYD4WtS1jVsRcSwzD6pUqGKnUyzKJiDwfOjY
         18bGl1W4gBNP8ZpZR6xdW7576MR8isXcntQIeIuKHwDB3X1F1VTeUmLRa+ARMwuUEN/k
         zxIA==
X-Forwarded-Encrypted: i=1; AHgh+Rr2mGcLVWKtT4HirFEq7oJkqSW6c5u773GCXw6n1zKynpaEL/cKRPrPN7fj0crzeSF/bkcVZwhbXrAExyX/Syoy@vger.kernel.org
X-Gm-Message-State: AOJu0YzDAATxV8xwJwI3v7nFYuraaSC0N7E2x0TvnZP5j+Qlml59MjOb
	mGyF3UpX9dOzgyHWV4qACIPdpwbbi+FyMJVWf0okzjClkJTul2oHe4fwlk8IuFeTjjpR4Z3nBRL
	CbXjUagfTsw==
X-Received: from dyaf2-n1.prod.google.com ([2002:a05:693c:8382:10b0:326:f89c:1b89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:fd88:b0:2cf:7ea3:7cf1
 with SMTP id d9443c01a7336-2d5cac260eamr20568055ad.5.1787007875862; Mon, 17
 Aug 2026 16:04:35 -0700 (PDT)
Date: Mon, 17 Aug 2026 16:04:31 -0700
In-Reply-To: <20260723050409.991665-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260723050409.991665-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.699.gb54405d56f-goog
Message-ID: <20260817230431.424646-1-irogers@google.com>
Subject: [PATCH v4] perf fdarray: Fix destructor invocation and event counting
 in fdarray__filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When processing POLLHUP or POLLERR for an event in fdarray__filter, the
function invokes its destructor callback. However, the exact behavior
around unhandled POLLHUP events on control pipe descriptors caused
premature termination due to thread and evlist pollfd index mismatches.
This occurred because they were skipped by the early nonfilterable continue.

Address this by refining the early continue filter to only skip system-wide
perf events (which are nonfilterable but not non_perf_event). Control
descriptors (non_perf_event) now fall through to appropriately have their
fd value unset to -1 on POLLHUP while avoiding their destructors. Finally,
maintain the invariant that the active event counter (nr) increments strictly
and only for completely filterable events.

Fixes: fb4751e79c45 ("perf record: Fix teardown hang on system-wide multi-threaded sessions")
Assisted-by: Gemini:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fd/array.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 67b73481df27..3681ad7c6527 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -116,14 +116,23 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
-		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
+		/*
+		 * System-wide perf events are nonfilterable but not non_perf_event.
+		 * We want to skip them entirely and never process revents on them.
+		 */
+		if ((fda->priv[fd].flags & fdarray_flag__nonfilterable) &&
+		    !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
 			continue;
 
 		if (!fda->entries[fd].events)
 			continue;
 
 		if (fda->entries[fd].revents & revents) {
-			if (entry_destructor)
+			/*
+			 * Control descriptors are non_perf_event and don't need
+			 * their perf-specific destructors triggered.
+			 */
+			if (entry_destructor && !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
 				entry_destructor(fda, fd, arg);
 
 			/*
@@ -136,7 +145,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
 
-		++nr;
+		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
+			++nr;
 	}
 
 	return nr;
-- 
2.55.0.699.gb54405d56f-goog

