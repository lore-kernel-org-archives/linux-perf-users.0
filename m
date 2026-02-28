Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA92271A9A
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262022; cv=none; b=pBINh7vYqSFTLFXDbLX6s4CsT56Jfp9Qyc9LKjTbx5BUnZFymp4UWfxKGxsiakLVKQVgINEW5MDX3Cng6FrVnHtTkYD15Uvsq3ywagXF0coNQ4SCCKwsSK+93n034Gaopm5dRKOmWfcKGw9+zLazPTI/1pbRKhOflgKyY+GntUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262022; c=relaxed/simple;
	bh=QvRWYt+Y1GnrkS1KnNIWPyNcQFsQz5y+CvtFYQ5TX7s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pBbgo1rcTMnqZrknoVQe7FLAVNGKu9FpSyEmPAQmwW07k358BN+SQnv+udRODQfrHtxO+LjhEu4EO/ut/Vazjq0+8S9uz5by9PpkvtFL5UJgqiGxem7nWpobOeLj/lubvfQMouz/dXEOTsauq7wm9jBkOp4KWmPnpf1TgMOvJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9QMqt17; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9QMqt17"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124a95b6f61so18440375c88.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262019; x=1772866819; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TDpebJHPDPcU5V+xyvT7INvO6tm+KadCONtksWNWUwM=;
        b=n9QMqt17EQXdtB2gpaZygcNAzSGgGVZ/uw/h0we1EXrQfelmwuhNMKFxBsHM2HgMbh
         nLO51eEYvnjonpoboW4mVSLQKIxLqiGrYF9dMWiePWJodW07MUBFzfUbtPdKwivJ1PMZ
         LFnoI29NCCY0CiK+1BRRcSe7uQlGnngkqtA9gPgQZBzmGi+CGqS6ulxDV1mEMisItFlY
         gcPe/5Nj5lNofXtE7c9RThahXwlrs1wgyYd5oQXYp8r5cdChoYOjavsVgOlBopTsaMaP
         wuZNCpSmMeRYr5V9aHGYXGaUF29TynXHx2Ejo52yrgMEtcSMKL7QV48aZe4nDlQgvwD9
         esQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262019; x=1772866819;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TDpebJHPDPcU5V+xyvT7INvO6tm+KadCONtksWNWUwM=;
        b=g609oJuPfjXV3jGzI3i3rWZs9It7Ogzf4YRGlJ76/k1Wqr6ko1j83jnZ5x/526eQy2
         4R/YoS1HxyWGv2DO0pOoshSgsiN1eEeJLF6tUPew8ElLUjhEG8YFohnBC3DKZceA0Oz4
         RBPPOYRZVPkatlt0lEgajJ/dQAl4EtLDZzA2UdNfgmW8l1LYLsdhN4VSAEkxNEvqfB8C
         0gJR6Xb5csenUlL97ULDl7QZB1tWGIZsampeYh8WB03IrugBkNTFjhT/4DLMn4iGCcON
         tPuFqL5jxC0T9uIPR7lA6Xe9e80xlq0t3P+qqNwzKq7PUuuAKld17seXu/7i7E3UYCRo
         uh0g==
X-Forwarded-Encrypted: i=1; AJvYcCUX/uHE+u5DxVIseUelQNWXVc3fqDofZ91o9/o18l8du7FdkG5ODETdnnlud0wamZMYMDOYSf2ryywGMZzashoy@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc27sDYtKGTEZcoNxCGu6RvXihn+oVx3kNKxLnPvRVZzRaPZu+
	4KjwJWyVkxSRzCIyJ05VZSuKIwQ7rQC7xsEm+rgBmO85cMmUFosChe1+zV0jtTPGsNXu44x2foe
	gOYkHrr3iYw==
X-Received: from dlbsv14.prod.google.com ([2002:a05:7022:3a0e:b0:127:8b2a:c1c2])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:128f:b0:123:3461:99be
 with SMTP id a92af1059eb24-1278fcdfe04mr3121230c88.21.1772262018581; Fri, 27
 Feb 2026 23:00:18 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:52 -0800
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-7-irogers@google.com>
Subject: [PATCH v2 6/7] perf evsel: Make unknown event names more unique
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In situations like the perf data converter the evsel__name will be
used to create babeltrace events. If the events have the same name
then creation can fail. Avoid these failures by including more
information into the unknown event names.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evsel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index f59228c1a39e..fdc67df0e739 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -926,7 +926,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
-		scnprintf(bf, sizeof(bf), "%s", "unknown tracepoint");
+		scnprintf(bf, sizeof(bf), "unknown tracepoint id=%#"PRId64,
+			  evsel->core.attr.config);
 		break;
 
 	case PERF_TYPE_BREAKPOINT:
@@ -938,8 +939,8 @@ const char *evsel__name(struct evsel *evsel)
 		break;
 
 	default:
-		scnprintf(bf, sizeof(bf), "unknown attr type: %d",
-			  evsel->core.attr.type);
+		scnprintf(bf, sizeof(bf), "unknown event PMU=%d config=%#"PRIx64,
+			  evsel->core.attr.type, evsel->core.attr.config);
 		break;
 	}
 
-- 
2.53.0.473.g4a7958ca14-goog

