Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8AA231A2A
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 17:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744393571; cv=none; b=leVjstFeyW6aWxobBrDPcZoYeIs6WVj7+5XCmrDW23nI39zWU8CGWy2Tejcy45eUOREvhi/yyLofLnM9ledbGJoDVVukkFcuDRUypDqXxT7mSMBOYRlYPYeNQN1RpmFS4vfEUHZu1L1MWkTssRcLvE3lydpmgNKsFWw5jrn29y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744393571; c=relaxed/simple;
	bh=B1jYEsWvbPKX/zHd+TR/zfbKqNYvM6PzAvJxDjT/KEc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PNaiZAfOuz2U7zk7cl32Mf69K7NDhUlmZg4kz/T9LfwKmhoJXugn3cR4C+dmwUbPakddKuvewtaPVwwtMUqKgr/WZBdBuJ1ZwKTKDQFRlbCcqEtjxCJSyvnGyl2Ki/HiMk0xVKnUej7ULDct2H90ycVRlt54ZY3YAkS0xjiSAyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IV+0Ryad; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ctshao.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IV+0Ryad"
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c6eb3e0b2aso672678fac.0
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Apr 2025 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744393569; x=1744998369; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jgi9ZCDenpfQcCDLeVmdhfWFbSEmiaBaDhUIXsiKq7M=;
        b=IV+0Ryad6hON/NcTvv9AQ8yWYhFHfCV2fn3NoIwHyq/SJpL1lciMTT228BPGfIiV8r
         VZLzzYgXIrwJlf/7J8DYspE1K9u82LiRwVOyVmITp4oe0h3fIuSELRS3ggmOHFooc82b
         /qvgOfiMJAJIdDxO/WfJWVone4kMUiC3aLzebAZXKJTysWnGkOqE7tWtS23gbqafkJsV
         3knqpXo7BY3o1fuT87Ei9n30cVyj1P2g9iST5ZIfrK4UHd8hwl3kanoDs6NCPYBXob16
         V4atPKD0yBNZTlbHY3xPhSBKsZtE6YOaLXXwJ0YTUITKppv5MFDRv85uKhlaiPLU7GfG
         WTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744393569; x=1744998369;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jgi9ZCDenpfQcCDLeVmdhfWFbSEmiaBaDhUIXsiKq7M=;
        b=tAHAPQBvGZF+OAuAJvoJBHv6+BL1C8bXLqWP3MPtbwbm624fMyugCdxbbD9P3BDEpJ
         QLE40P9IeADdngg8efgOHXWo7gklms2PXvvt7WXAXHyc8ThyCNvZa2rsKdXLDWjcE3Rx
         5fgHYklHV0sTQcwYWJzE0vJ986Euzo+3wIyByIl+7y9+5tdTpq/YFYrRI/JRdd2mlv74
         WJ+Dg6Sk2ban3nqINwwYtq9J6CbAuEJzJwuI6VfJIYehBAe1jN7lBT305lOCiceI+g3U
         Y3gVVhj/9pTBuEJfkXOKdmAKf/ExkZwaEicPsQtlcju4/SsoB1gmITlJ8ha4yiaPS6VO
         qsqw==
X-Forwarded-Encrypted: i=1; AJvYcCUMqlUvtZIsOAW6FWxP0sfV0E+ySDi2RZuZDU3JZZxyXlJSBAkdFP3rqTVrYytTpqzoPpZHdqVCf+HjUy/Ha4+5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wR7vu3fg+KMb4O28TJoaT3VV+GVRXQtYE71a9A/AmkAiyVCZ
	G8M77wkuwLtZtNItFNxFb4t6FyQeP19XtzfDRj4cIUoSq8+6n+Vm7ydEaDszWrEVH5qJ8N+iR+a
	6OA==
X-Google-Smtp-Source: AGHT+IHCxo9rii7BaWbC7Qp3hg0zBqPEpg/RV9DoMTnkF1kSO93N6tJwevyHOyZkZ5+N1SP74Cnm73DYhOo=
X-Received: from oabwa5.prod.google.com ([2002:a05:6871:a485:b0:2bc:65b9:2ace])
 (user=ctshao job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6871:6086:b0:29e:5e83:150e
 with SMTP id 586e51a60fabf-2d0d5f408f3mr2303412fac.27.1744393568940; Fri, 11
 Apr 2025 10:46:08 -0700 (PDT)
Date: Fri, 11 Apr 2025 10:45:21 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
Message-ID: <20250411174547.2208959-1-ctshao@google.com>
Subject: [PATCH v3] perf report: Skip unsupported new event types
From: Chun-Tse Shao <ctshao@google.com>
To: linux-kernel@vger.kernel.org
Cc: Chun-Tse Shao <ctshao@google.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dvyukov@google.com, ben.gainey@arm.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

`perf report` currently halts with an error when encountering
unsupported new event types (`event.type >= PERF_RECORD_HEADER_MAX`).
This patch modifies the behavior to skip these samples and continue
processing the remaining events. Additionally, stops reporting if the
new event size is not 8-byte aligned.

Signed-off-by: Chun-Tse Shao <ctshao@google.com>
Suggested-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/session.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 60fb9997ea0d..f55b2ac4e103 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1639,8 +1639,17 @@ static s64 perf_session__process_event(struct perf_session *session,
 	if (session->header.needs_swap)
 		event_swap(event, evlist__sample_id_all(evlist));
 
-	if (event->header.type >= PERF_RECORD_HEADER_MAX)
-		return -EINVAL;
+	if (event->header.type >= PERF_RECORD_HEADER_MAX) {
+		/* perf should not support unaligned event, stop here. */
+		if (event->header.size % sizeof(u64))
+			return -EINVAL;
+
+		/* This perf is outdated and does not support the latest event type. */
+		ui__warning("Unsupported type %u, please considering update perf.\n",
+			    event->header.type);
+		/* Skip unsupported/unaligned event by returning its size. */
+		return event->header.size;
+	}
 
 	events_stats__inc(&evlist->stats, event->header.type);
 
-- 
2.49.0.604.gff1f9ca942-goog

