Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABB168B9
	for <linux-perf-users@vger.kernel.org>; Wed,  8 May 2024 03:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715140397; cv=none; b=KALZFLunaqrS22BKfAevvdZN1yvwLrScLZj91FEdK2yPJqVumEsBz6uUmQZMKKCjlpE/CZOn+Nuy4rdvIVU5Xr2PeZ2U6dBMK7WjzhmRDPfPN7xcWY6WS3KLyqstJGfyFzCnDYSgr60cDCo/gVKM94QkNZogomZ7tjUzWkd3uCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715140397; c=relaxed/simple;
	bh=aHIl5ajtOsRuKOTphrUaDEcdr7Mjo44/1jnkIBWAkmM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=DgMTZ/QrXyXktdkIaLNoNz/ezPppcWtvnFJooXKZMsUmS2llNm4kGtdB/9lOZzJoYta0L2fi7hzu1qXattT0/s4jaXBxCYRcjjMWRgemF1GVvbaQvYq4u+oh7XKyOfOR+FPA3AuoxPsMNc95QcNfWEVKVywR2m/MqstQLEP8fjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TmjAkqhL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TmjAkqhL"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61beaa137acso69154847b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 07 May 2024 20:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715140395; x=1715745195; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLpi7z8CqpYtGhQQH+K3dVX1FIdgCT+wy4o4hM2y81A=;
        b=TmjAkqhLjNKDM3sVTrlR85Lv6Ui7Mipe3Gka6io25vKuy0XVjPO7O+eo6q7S8u6ccw
         8/CwHqgpmUIrN1AIcuFHqZBPAKVlIgeIUHGygvsDhc76vWcWcxmLPqJTkqncSyn9Qhsm
         JoQTfAGY1NEEy41NES9rWvQKnWPZ2BjXWzMibd7KtIO0BIi+SvOtwqOtNy4UJP2Va8iL
         oaRTI0GxCsytrrIFFeL1RmAW4hfFTZMMVXyG/No8OBKQNhXawhA1/H0ekKzfF6Usxdwt
         +4ZuLmJ8+gpfzzaqsHt+YYAIfO/1pGCgSOgZhXP1MA54RUloCnrpM2WVg+49AfK2zSYu
         3dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715140395; x=1715745195;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLpi7z8CqpYtGhQQH+K3dVX1FIdgCT+wy4o4hM2y81A=;
        b=WdVqGv9LOv/RvsKBl/Aov3IC24gBlcWIAVJWZlm7Ap4NI+1Nk7GGcGwDMMrEBf6PzD
         5Dgfs77Xk2lLY7pl9P197RmIhkj7dXI9zmVKdUZY+yicUy69Q4vt3VFQPhlJzPvQGnm6
         ECmGT66EbnvY3xXIxU5AhGB1VATkAqlRMXW0gJ+gyhbiwMbIUgxTYPeWwuTp+mEBD8hm
         Bz4+Q6nxOc6e8B5aq5lgHdPIw1elzlMjJLq0b+62rOWsn5vwCDouqIMmCW3PM6/ydbCb
         48iDFshlZKxpjdaoNN2NaM0GnEZVLcDFw8/xzw33sPcgUQ+s9etZR95JvSQdHUhLYe1P
         GC/g==
X-Forwarded-Encrypted: i=1; AJvYcCVj4+fZ6th5dXPRM72YOFzFL5MQJ1nlkwQiQLhmKNnc0M8g9rIRsmCeM1iOg/4hGf1OPLr5VsJPIomlgntje5r7d6Ooee8Dl8fTJad/0ffT2g==
X-Gm-Message-State: AOJu0YzLyHegUyajEod+uAoFe0JvO4oISrPiunS4Ztc/5slZefkifV/X
	uZHyeUOt33rxIOk0FRJ7Jm5+nz72HLZ6VCM8lELW9zsx1G+ga/bAE1XUHICD42dXc5K6LxHjwsE
	Gu4S0MA==
X-Google-Smtp-Source: AGHT+IFrOkRLRqDS7GqMlrxDcpHsAvJyI+R0IRXLkCqe5dHNCgLGD/WBcjQn8SmUgyEm27PVlV5ZhjoZc6rT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:56f9:40dc:113f:ba3])
 (user=irogers job=sendgmr) by 2002:a81:52cc:0:b0:618:8e4b:f4b0 with SMTP id
 00721157ae682-62085c3ff7dmr3595067b3.9.1715140395469; Tue, 07 May 2024
 20:53:15 -0700 (PDT)
Date: Tue,  7 May 2024 20:52:59 -0700
In-Reply-To: <20240508035301.1554434-1-irogers@google.com>
Message-Id: <20240508035301.1554434-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240508035301.1554434-1-irogers@google.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Subject: [PATCH v1 2/4] perf comm: Fix comm_str__put for reference count checking
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Leo Yan <leo.yan@linux.dev>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Searching for the entry in the array needs to avoid the intermediate
pointer with reference count checking. Refactor the array removal to
binary search for the entry. Change the array to hold an entry with a
reference count (so the intermediate pointer can work) and remove from
the array when the reference count on a comm_str falls to 1.

Fixes: 13ca628716c6 ("perf comm: Add reference count checking to 'struct comm_str'")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/comm.c | 45 +++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/tools/perf/util/comm.c b/tools/perf/util/comm.c
index 1aa9a08e5b03..233f2b6edf52 100644
--- a/tools/perf/util/comm.c
+++ b/tools/perf/util/comm.c
@@ -19,6 +19,8 @@ static struct comm_strs {
 	int capacity;
 } _comm_strs;
 
+static void comm_strs__remove_if_last(struct comm_str *cs);
+
 static void comm_strs__init(void)
 {
 	init_rwsem(&_comm_strs.lock);
@@ -58,22 +60,15 @@ static struct comm_str *comm_str__get(struct comm_str *cs)
 
 static void comm_str__put(struct comm_str *cs)
 {
-	if (cs && refcount_dec_and_test(comm_str__refcnt(cs))) {
-		struct comm_strs *comm_strs = comm_strs__get();
-		int i;
+	if (!cs)
+		return;
 
-		down_write(&comm_strs->lock);
-		for (i = 0; i < comm_strs->num_strs; i++) {
-			if (comm_strs->strs[i] == cs)
-				break;
-		}
-		for (; i < comm_strs->num_strs - 1; i++)
-			comm_strs->strs[i] = comm_strs->strs[i + 1];
-
-		comm_strs->num_strs--;
-		up_write(&comm_strs->lock);
+	if (refcount_dec_and_test(comm_str__refcnt(cs))) {
 		RC_CHK_FREE(cs);
 	} else {
+		if (refcount_read(comm_str__refcnt(cs)) == 1)
+			comm_strs__remove_if_last(cs);
+
 		RC_CHK_PUT(cs);
 	}
 }
@@ -107,6 +102,28 @@ static int comm_str__search(const void *_key, const void *_member)
 	return strcmp(key, comm_str__str(member));
 }
 
+static void comm_strs__remove_if_last(struct comm_str *cs)
+{
+	struct comm_strs *comm_strs = comm_strs__get();
+
+	down_write(&comm_strs->lock);
+	/*
+	 * Are there only references from the array, if so remove the array
+	 * reference under the write lock so that we don't race with findnew.
+	 */
+	if (refcount_read(comm_str__refcnt(cs)) == 1) {
+		struct comm_str **entry;
+
+		entry = bsearch(comm_str__str(cs), comm_strs->strs, comm_strs->num_strs,
+				sizeof(struct comm_str *), comm_str__search);
+		comm_str__put(*entry);
+		for (int i = entry - comm_strs->strs; i < comm_strs->num_strs - 1; i++)
+			comm_strs->strs[i] = comm_strs->strs[i + 1];
+		comm_strs->num_strs--;
+	}
+	up_write(&comm_strs->lock);
+}
+
 static struct comm_str *__comm_strs__find(struct comm_strs *comm_strs, const char *str)
 {
 	struct comm_str **result;
@@ -158,7 +175,7 @@ static struct comm_str *comm_strs__findnew(const char *str)
 		}
 	}
 	up_write(&comm_strs->lock);
-	return result;
+	return comm_str__get(result);
 }
 
 struct comm *comm__new(const char *str, u64 timestamp, bool exec)
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

