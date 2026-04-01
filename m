Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55B347799F
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060018; cv=none; b=UJuqHoddcGR1MPDCkf2xy/G0jgDL0X+7yJubjwSYKiposqjVyxDJvxXxv3wOUkAmks7H33JiF0cJjZMP6fra9FZWIgx98bu4kNkwou7EQCdt4DqfKeOK/SPdZZx9H2FDM19MbPMhaeGufCJS8qt7II9GEtg0WVDaN6l0fN38GSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060018; c=relaxed/simple;
	bh=etWLpPUbAL9PbGn2PsAzD1vzOgdSqQ+V+536k9PjEfA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G791WKmy7kiq+9+A1vGNO5RZy5MSYL+xk4JE6xmxSiLu64vbbAVS6nW05Bcdqgu45g83F5AJj5O4W0aXd0T03jRHN5bAcnl3gQdeO0bZkkkz1qbKqnTHJ8zVvIdqsh02yeJb9JfYCodM07RmqI0J200lxGkkQicZkvyQZ//tEvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmdC/Kf2; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmdC/Kf2"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2bdf6fe90a9so7067290eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060017; x=1775664817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WMSD5CIynbKr+BJ31meFhjj49c+zZqPVABuWE4dY/sQ=;
        b=WmdC/Kf22QYLprlJnDJBocJ3Ae5EID73l5WtahVrT07bYIg1+nAHGKNQ3wbkEuPUga
         88KD9N+D9eIjKXC8d5JvqpZ+PtYGmN6jLbg0GupE7xaKe6zu6+pA/t6Ipb8KFqQssSOy
         Z7IdgncozHt+9TureME06ka4S+Qziu5X0ahQ7DU1OeRR0fD1uXW3pUJmu+RbXw8ZyjnL
         ztXls1k8SQh04SjEgoZ+0EfmP/WA/KyKs+QJtIlSNazaaH8cdqHXn4QwHGwsbzdVltyP
         79zIR6XcGMG98ZvL/A3ZnCAShkyo+pqZQIReoMZxgjKgxNueNsT3P5Um5OTdOn4QWtuY
         q72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060017; x=1775664817;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMSD5CIynbKr+BJ31meFhjj49c+zZqPVABuWE4dY/sQ=;
        b=oxbKIXS0PjHH+bzRIrjHMlhtEZ+CokvNDs3uANfzg8PaUIcG7nZiN3aBMPI/rQdNdr
         0bJJY7m+T6jgiGSgquFADpcZX0eWZs+iD2fRPnLtNKFxikhUTBpucEcI0wBvFY/b9x/A
         3q+FbjGIEeELof4gzAvjGOjj3LOvWXG+PfDcnsdFF8Agp5BZukeVMUogGMc9dWoNeTy7
         Z28JS070FQczvkYF450ACGr6QFoNe5AiFYR9ZZPiLh2FvX8fZ9+ec7868hNnSfoyLXKP
         Zt5fcs6NhnptvBn1nywNuQ1bMoPndImQ8WekX68C2k7N6Q1zPF23P4/GIMqmSwkUYzQv
         8f2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLhk4BHSx9jlGv53+GX2W/Ddt+449n7zmmGuuX3FRKHnwd3sysqThoZh2pmLmo5iZxjXMI+DnbJg51OrP7zAOx@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ1UidJXTUaXBuBsPitg97E8ZVYNTAunJQOAK9RgijI4I4KEXG
	OZ3hEtUIcLmYcAGOnEyWI5rrnh/GsN6dmOgNrb+Wi9Z8YcHBovbedAEa6Z/r+x2JuH9LiDniC+I
	Yk3oXW90ylw==
X-Received: from dlbrn6.prod.google.com ([2002:a05:7022:1506:b0:128:ebd8:625d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ec7:b0:128:d7a7:5271
 with SMTP id a92af1059eb24-12be6584897mr2097291c88.28.1775060016753; Wed, 01
 Apr 2026 09:13:36 -0700 (PDT)
Date: Wed,  1 Apr 2026 09:13:20 -0700
In-Reply-To: <20260401161324.332356-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260401055206.43187-1-irogers@google.com> <20260401161324.332356-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.1118.gaef5881109-goog
Message-ID: <20260401161324.332356-5-irogers@google.com>
Subject: [PATCH v4 4/8] perf session: Extra logging for failed to process events
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

