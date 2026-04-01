Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9779032A3DE
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 05:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775022737; cv=none; b=IglyioNk1V2L41y3Cys8FD1Enr4Kpjj7a5gccUkgTswj+C+XQbP5rTQ7PTIi2/Ta60BkI2LC2IMNZOA2nCHr5K/Q7IDQCWB21uHfhoq+e/VakdCLMMCvop4IU2DdZpR2n3Y3HX1PzrBdrQ+8vFBnHXlX8LSyndbqgUnPDcsjkns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775022737; c=relaxed/simple;
	bh=etWLpPUbAL9PbGn2PsAzD1vzOgdSqQ+V+536k9PjEfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aPhQR5EEmsLA0Z5uqCNRHsEt2jBsXr76ejNhbqdbnyfIu1qk2j/KOBnzagPmCdYHdKCM/AFKINOt0bFCCzKLIy+cCUzx2HttDUWRlPw4ik74hgUrO39nQy4KACG1p+k22qio0kVlET6Cf7sM1V225NfPzhAZb6gb45CHvCZ1gdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fguTCcAR; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fguTCcAR"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12a77b008deso4791115c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 31 Mar 2026 22:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775022736; x=1775627536; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMSD5CIynbKr+BJ31meFhjj49c+zZqPVABuWE4dY/sQ=;
        b=fguTCcARQzzg7D5v4oX3OL9t0cGqUNMKHPWvYPqnpE7ng9CO5r9kzBc9Pv6jKCGoSm
         r1SruYbYTvcyvgH5HwsAc18OLrtHsxXcxgyXjPUGM68sKPzKDUrUHethZarYTVKavwoM
         DvMjLcbwQ1CYz6wF+yrM8pW53m5oZs1idi0ZLu5k8eEZK96iRrrpGoi5ECBkJt+ADOM1
         Qab+A7VoW5EuCopYxlsQu7iudq1f86ULCHwpXYAD4p4KvAWJNcP0LaQwLt45NwX8Ef/z
         F5762UmqjsU66XhMetv4vNddTBEYMw00LQ0YYnH269kCQ9K44fpURsccGkAugDimKO5j
         GTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775022736; x=1775627536;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMSD5CIynbKr+BJ31meFhjj49c+zZqPVABuWE4dY/sQ=;
        b=lrSCr5qKrGhSwRUDiGT3OQqugQaveq6dtn/XsvBRUiEpOap3d5cmNiUncv4I8bdPLV
         evkU84NVJQniqI4qCq2IAAe2KbDxRqXkuu4BiVP7vdhl5DX6gUaQ3yUoqytzyzWhqOyd
         Iw71ReiOZtm8MfzkrbcwJjmNBZVV4DG4fp/6irjDEGXGNB+EL7XjHpD1XNeE3XrUb2ip
         eXfT1yHpVd+gypmZK4qdFX0rw3vnPzEh7SiTdcw6cmeH4CLCQOGDQI4SUJoD8b/IW5UK
         31+78abilXaYaLqni1BiV9ZXEaz2GXMt5OPWJapbdaRrXeG8HsmmiW9vuBm47opuv4Zx
         +EAA==
X-Forwarded-Encrypted: i=1; AJvYcCWDTn03r9ORF3kkp5nGASnuY+HH5ekjL9jzUCTcc9CRIzdQNd/HuHk85+h9hJzBbkFkmjYQroUMEfgBaqDQOTAF@vger.kernel.org
X-Gm-Message-State: AOJu0YyRS7lK6BWJK7Iv92XbtxSARp9gRyJtgItY3C1h/vNVaHeGe4P1
	EsSl3Odh4AXjezC9L066714vHGD04LOhX5LzIUDf0z0hD4YwfTHmbX8YAxYwKUYOClvr585sPvy
	lpEpg7p9vGg==
X-Received: from dlbvv5.prod.google.com ([2002:a05:7022:5f05:b0:12a:6a54:c33e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2220:b0:128:d438:cad
 with SMTP id a92af1059eb24-12be65577b5mr1511311c88.18.1775022735419; Tue, 31
 Mar 2026 22:52:15 -0700 (PDT)
Date: Tue, 31 Mar 2026 22:52:02 -0700
In-Reply-To: <20260401055206.43187-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com> <20260401055206.43187-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401055206.43187-4-irogers@google.com>
Subject: [PATCH v3 3/7] perf session: Extra logging for failed to process events
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: irogers@google.com, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ashelat@redhat.com, ctshao@google.com, 
	derek.foreman@collabora.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	swapnil.sapkal@amd.com, thomas.falcon@intel.com
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
2.53.0.1118.gaef5881109-goog

