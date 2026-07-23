Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82050360EF7
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784783057; cv=none; b=nd3qs6PD4ar520TBr/ph8IdCP5C7vYoqUCPIRcxRCdubFviJHKmQVMxY1v4nd2FpHfoCcE/jHOfhpBi3O/kuChT/44JYXmAsHGmJS+kTIYedplwgTFkZ1g8HbSVMlzhPJASVqz83r6eRJz8lMco7LjMkSh2x8eqFcgSJhKaGaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784783057; c=relaxed/simple;
	bh=nTSkewIWWx8/t7cp3fpQ9JuC2rGY3I72/Fsp4hc++ss=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k3bHmiYHG4Xr2pvtKnzVrZr0MV3Zao3B9Oze63RcRAjNS1usUVB96s+iy7Ntgb4vH50TLdmOs5pYGUfIH1tYq4TqnTiyFQegxzgCY+hmZnVnH0bNxul11rVCTEnTkRNCarn9jRGzox3oBEDRAeEF3Wn1yBhDcIzWoBrOYQDcx54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZM9qRQRv; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZM9qRQRv"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so299044a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784783055; x=1785387855; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPkKXAx8q7DWcz5buLvew0FKr7dgmdKlFiiJ8cC/3rY=;
        b=ZM9qRQRvUW5nJbgsAadnzlOrOPorXLwl0xaDjJoIGhEQJuNoGtzD90zmcCmU4THzrl
         DD0L2mg05sDYpExrfGD9zZMr/fCFA7YZRV0AEq7+Cm4n+WQWI4u3BK11P4asCfAcEfMV
         lrmEpvRbtjBzFwNOi2gQnO0AXvF5/IQN8gYX8hRLVLiMEfZzaTCU1A3RrckQTEQUPT8t
         jpn4VMniqfOkJXFRuLoUGJ6BU3QQurJS8DRdCie7BuLdqqMujO47Zay72/9NY2eVqXJo
         orhBwJOredTg/wzwxsrZntBvY2VDOhRucPlMGbhCtPHE+sRtWZuwUyYQ+n4hT8dF7p0u
         HbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784783055; x=1785387855;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iPkKXAx8q7DWcz5buLvew0FKr7dgmdKlFiiJ8cC/3rY=;
        b=sUX6ifG8mrTumaKrc811qMbNMCPY5le+8avu25N5b/Yj2RnYH4kBa5m6qI9tV04vdt
         QhrseRN8svKT+sZxgBN/dbAYDi5jHtyuObyskHRduxv46bUm9Kxk3aL3SLKJqxlb+Hij
         InPghmJxF+3bdYH7heiGYP5LSpmfLNWNRn20QKf+3Hbn5t3VesSfkPFAEoWCqO1znQuW
         OneVANo6xgQY/kkbraB8g1SIZr4R+8nWwB7/dJKo2aXULHeH5RkpNB7FmjuesVpLL+X7
         EWIEWzw3kSfcqQf/6Esz1E6HGpQ75OSePNYyTmJZdtOZJmrCIHNuCQTwQ6He6Wwayiaq
         JZJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp3VZ67fZQ+BVczNFiKlPjXEsrGFmUb+mCn76l0rST3PtRvwa2BC2Dnt6xhXNtmPjBhx1CaGCIxgF31FKFzGVIK@vger.kernel.org
X-Gm-Message-State: AOJu0YwaS5zvHHQ+HWdgrQPbuV27y+rV6FKNWA17IwyonvNimbEZ5hcY
	8OVjQliNnxos4pahAwJPSohAAlFXckxR5kyJtNJMMnMCv16JtrJ/wYzbs3+eJ41afTS/ZM54TN+
	kUZM5RrQbCg==
X-Received: from dlea19-n1.prod.google.com ([2002:a05:701b:4213:10b0:13c:ea82:8d73])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:ec85:b0:38e:9279:468c
 with SMTP id 98e67ed59e1d1-38ec660b359mr1557601a91.25.1784783054432; Wed, 22
 Jul 2026 22:04:14 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:04:09 -0700
In-Reply-To: <20260716073753.567782-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716073753.567782-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723050409.991665-1-irogers@google.com>
Subject: [PATCH v3] perf record: Fix destructor invocation and event counting
 in fdarray__filter
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: abyssmystery@gmail.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When processing POLLHUP or POLLERR for an event in fdarray__filter, the
function invokes its destructor callback but fails to re-inject the
nonfilterable exclusion masks into the active event count (nr) increment
condition. Because auxiliary and control pipe descriptors never enter the
POLLHUP event match block, their active event count is unconditionally
incremented, preventing the return value from reaching zero on target
process exit and trapping __cmd_record() in an infinite drain poll hang.

Fix it by applying both fdarray_flag__nonfilterable and
fdarray_flag__non_perf_event exclusion masks into the active event
counter increment block at the bottom of the filtering loop.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/api/fd/array.c    | 10 ++++++----
 tools/perf/builtin-record.c |  4 +++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index 67b73481df27..f97afbd6f07a 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -116,9 +116,6 @@ int fdarray__filter(struct fdarray *fda, short revents,
 		return 0;
 
 	for (fd = 0; fd < fda->nr; ++fd) {
-		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
-			continue;
-
 		if (!fda->entries[fd].events)
 			continue;
 
@@ -126,6 +123,9 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			if (entry_destructor)
 				entry_destructor(fda, fd, arg);
 
+			if (fda->priv[fd].flags & fdarray_flag__non_perf_event)
+				continue;
+
 			/*
 			 * Set fd to -1 so poll() ignores this entry; otherwise
 			 * POLLHUP/POLLERR are still reported for events=0 fds
@@ -136,7 +136,9 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
 
-		++nr;
+		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable) &&
+		    !(fda->priv[fd].flags & fdarray_flag__non_perf_event))
+			++nr;
 	}
 
 	return nr;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index f58d7e3c7879..c6644dab1cfb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1242,7 +1242,9 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 				goto out_free;
 			}
 			ret = fdarray__add(&thread_data[t].pollfd, thread_data[t].pipes.msg[0],
-					   POLLIN | POLLERR | POLLHUP, fdarray_flag__nonfilterable);
+					   POLLIN | POLLERR | POLLHUP,
+					   fdarray_flag__nonfilterable |
+					   fdarray_flag__non_perf_event);
 			if (ret < 0) {
 				pr_err("Failed to add descriptor to thread[%d] pollfd\n", t);
 				goto out_free;
-- 
2.55.0.229.g6434b31f56-goog

