Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8AB346E67
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262014; cv=none; b=bxnHA3+x0LLKwa/f2RY3Ya14uSc65Lwz/SVcpuYLrk+byPZ7TuWPJplcbity/Tg1KxMURkIDbuXsA6c4TVuAvza1V83lawFWfJsQ7gUW3Tcc7+pYx9x9EKX0q4ZvOKC59wTNlNWN8DNwTG7te6F2lGSJJ1Ct49+R8TfWtAjsFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262014; c=relaxed/simple;
	bh=7sIjHudW7FWHJUUA2b7c4SCeJtZgcleFZwQLO504uPM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=p62m6vlyXfMXnUzO0ezTLTGoxMW/gxqyHtYtqp/o8Ka+WEJv9QcnTg9q7uO3PBJ7mwtR7OLskKW1ius8RuBbSb2WJSNJY/9fMtKsZCKpZ5AvWvvZnWjog1iFk+ohpTE9ChqOTJ3hid6eFzQwv4rJ7eUlgpabeKdWV3NfhChEcMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E1FhEh73; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E1FhEh73"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2ba8013a9e3so2700916eec.0
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262013; x=1772866813; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/wg1/ueOUJ8UkhVCAoXWbqideDmQLzWl9fomGjlxiM=;
        b=E1FhEh73jKnvXiQCH6d4Z3nS3wvJ6mFtONt9VS1FF1LVuKOoeFyCmOXe+WiiteW9VN
         pNdBCOtf9y2AhpGMgViSryH3D/ATt2c8qhtPeU7pvE1xL70Juq4bK7oaSQGmAt9I8gWI
         x4qrb9HiOQ+cOYfpKSzcdfR/TmHRvIKj95kaFPiWXABMJeRMIk/biLFZTPn2qDQvdjeK
         2oWi60r+9YBcxBJ4oW+nTKqHojtwXfAdFVapJZCG+HWC2mPqSqeppyy4TZ8L6RCR4TOY
         T5h6U8HtlQVU9R0Be/yLqcyfhFXinhK049iRKZjIvExPUsRP66qfuSq4acCpDklHhGAT
         goMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262013; x=1772866813;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z/wg1/ueOUJ8UkhVCAoXWbqideDmQLzWl9fomGjlxiM=;
        b=QNaPMiVYBUFWe/1dojuNIF1hQApmyuUI19Dl1GQPaUjWr7HJreemRKr3yvdRw7ahqt
         sRZ7PsKTUNZMcaH+tj8NBr/v52tMMj6uV5vl7xF+KaylvTn3PI4d5Nf8ztukuUpGbIAE
         MQ/dO+f/L9AZk3bqyj1NKwJKmkGqNJezeDhiXfVxBYHfs3EFQBzEEu08KyE+VkE09Z1F
         pi+PX6yxW+ssK7xpBDGQc4PbNsyjAHGY5LAhg/5ITkV1VjSmolltGq73/tmCqxVMuRm6
         8xveyDMdrOuZFBeeKnCi4vIE06QDBs9KMgXHdHqvFUE+T7h1snp6nDnlMFz/7S2pIHup
         WpwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0eYyzgeQ36QEFDWsKd/GE/UHJLD5Q9wGC6yCI/EV/yfkLCuVIaSGgwJ8mrBvIrVO4GXGGE7dQkcVgHsz7Y358@vger.kernel.org
X-Gm-Message-State: AOJu0YyvuLKKgJifvTx3ERgMHtjQQ1cM2pmBZY9d//kYLtgJI26gJgP3
	4scXXj7/Kk7jFZZZdLSQejIq+aYdokOiH7ZSmEA9RfuGIzr6xuyX2hZPv1CSmNra8UC0sHVOJH+
	1/meuZ8B/Ag==
X-Received: from dyblc5.prod.google.com ([2002:a05:7301:1305:b0:2ba:ad3a:9ab0])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a146:b0:2b7:f0a0:c195
 with SMTP id 5a478bee46e88-2bde1f9c667mr2195942eec.31.1772262012517; Fri, 27
 Feb 2026 23:00:12 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:49 -0800
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-4-irogers@google.com>
Subject: [PATCH v2 3/7] perf session: Extra logging for failed to process events
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

Print log information in ordered event processing so that the cause of
finished round failing is clearer. Print the event name along with its
number when an event isn't processed. Add extra detail about where the
failure happened.

The following log lines come from running `perf data convert`. Before:
  0xa250 [0x10]: failed to process type: 80

After:
  0xa250 [0x10]: piped event processing failed for event of type: FEATURE (80)

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 4b465abfa36c..492515789d3d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -131,10 +131,17 @@ static int ordered_events__deliver_event(struct ordered_events *oe,
 {
 	struct perf_session *session = container_of(oe, struct perf_session,
 						    ordered_events);
+	int ret =  perf_session__deliver_event(session, event->event,
+					       session->tool, event->file_offset,
+					       event->file_path);
 
-	return perf_session__deliver_event(session, event->event,
-					   session->tool, event->file_offset,
-					   event->file_path);
+	if (ret) {
+		pr_err("%#" PRIx64 " [%#x]: ordered event processing failed (%d) for event of type: %s (%d)\n",
+			event->file_offset, event->event->header.size, ret,
+			perf_event__name(event->event->header.type),
+			event->event->header.type);
+	}
+	return ret;
 }
 
 struct perf_session *__perf_session__new(struct perf_data *data,
@@ -2110,8 +2117,10 @@ static int __perf_session__process_pipe_events(struct perf_session *session)
 	}
 
 	if ((skip = perf_session__process_event(session, event, head, "pipe")) < 0) {
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-		       head, event->header.size, event->header.type);
+		pr_err("%#" PRIx64 " [%#x]: piped event processing failed for event of type: %s (%d)\n",
+			head, event->header.size,
+			perf_event__name(event->header.type),
+			event->header.type);
 		err = -EINVAL;
 		goto out_err;
 	}
@@ -2225,8 +2234,10 @@ static int __perf_session__process_decomp_events(struct perf_session *session)
 		if (size < sizeof(struct perf_event_header) ||
 		    (skip = perf_session__process_event(session, event, decomp->file_pos,
 							decomp->file_path)) < 0) {
-			pr_err("%#" PRIx64 " [%#x]: failed to process type: %d\n",
-				decomp->file_pos + decomp->head, event->header.size, event->header.type);
+			pr_err("%#" PRIx64 " [%#x]: decompress event processing failed for event of type: %s (%d)\n",
+				decomp->file_pos + decomp->head, event->header.size,
+				perf_event__name(event->header.type),
+				event->header.type);
 			return -EINVAL;
 		}
 
@@ -2382,8 +2393,9 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	if (size < sizeof(struct perf_event_header) ||
 	    (skip = rd->process(session, event, rd->file_pos, rd->path)) < 0) {
 		errno = -skip;
-		pr_err("%#" PRIx64 " [%#x]: failed to process type: %d [%m]\n",
+		pr_err("%#" PRIx64 " [%#x]: processing failed for event of type: %s (%d) [%m]\n",
 		       rd->file_offset + rd->head, event->header.size,
+		       perf_event__name(event->header.type),
 		       event->header.type);
 		err = skip;
 		goto out;
-- 
2.53.0.473.g4a7958ca14-goog

