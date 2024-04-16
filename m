Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 811356EB68
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Apr 2024 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713248162; cv=none; b=IR6XTxqx3Zmod3+j0UbPLl4I7QW+wajfS8B4Y8IRBX4z/WVX5Yoj5ioDFxgLdF0wcjqFAHedjLZb7JBLDmoORcfR9aByM3YyGyNEqIJZTxB74SVC5alP2mxnRPHAVmwirC5CGWwyfRBgErVRLMRHTKeMqj2W80PA8O61+pKJ/6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713248162; c=relaxed/simple;
	bh=lOkYV7UGjD7uAxaUJi//kJNpEQe6aaH4534slbGiVvI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=C5fphLrirqyE0vsRXWCWc9qN4wmRsHgi/sv54DIDF3PIiHNglzWubFpcl2d8ucoeYuLnN2oCrs3P0BohFPGCoQH134vMJjH0Edlltd8h1xo4SL5rAQZ3w2R7KQQY2Q3xdEo2+8lsNES6suXo9cn1AQDxwIYKoCXvaNeB8bhbEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d7dsJHEw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d7dsJHEw"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-618596c23b4so63364837b3.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713248160; x=1713852960; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ykRC4diMMUuCn1traUy9Psb15efHJHW4XPDrKAUvlVg=;
        b=d7dsJHEwoGbzVJyhb9z95qeHkUoM0lJlG7dgYzjC0nKumwiF9wshNHwulLAaALs1y9
         jHnga1kxnggAaAfEoNWXwaKwUVOtpx+NdEu3do6aCIkaz68EGsRw+Pup6+YsdCAqIUAH
         XX16xlHkYQk1TcR0INwF2gq7xiR6zfiEagUKEhCLgnaBx09kT7/HQ8DukDzbGNU51QXz
         V62WvmwExH/b+qncoP+EujYRak7QHyReivee7q2NmZCibjFkJgachDStOpWYHtsTTgxS
         8iUy88wXyBVm4hzDWcHFk5r+GwXwCCkeh57Qo7RRqZfm8sGfvOLv6/xYzgqFdWTBzzG3
         /OCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713248160; x=1713852960;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ykRC4diMMUuCn1traUy9Psb15efHJHW4XPDrKAUvlVg=;
        b=LLnNFROkCLmGtJz80PtIVifwLHoLF0DAWCNbaQXu4HnU8r+qvSJnS4RvNSz3YCfqs8
         5gMoKFYnwN43D6pj3AO+JOXEdJtxw7tujJ1T9BGcLxZmjWG1nm+XU4fWBtBl+DBqvBxQ
         DWBKzX5q6t95QLM6ClcNtiBz1Zu4Co2R7hbq+h1cPUY3rcBPrBTenH74+rdqQThis7XJ
         OJ5XnX/0rsOavKojTWEke1IFJq6eaViyPrA+3zsT2HM6xSsB9/GFeN4L5fPYMANH5LhG
         +c83jN7V7hObqbhcyWrJxDQZ1nApFIbRoIUhqKG9cegV038QvPdCXnzYsQ01XqpwvZEv
         jmQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfXDyKcTNvJAmk1zEzPVY0bm9ksT1oKc9Gk9McmONSnuszSzIh8QMJM2cyXp4jswLCOl7GdDp0RYADhDLlUFNUr8dwwKA7r3fqFcT3ROwDWA==
X-Gm-Message-State: AOJu0YwbNdvbj+XAy6UMVUx0QaAhtYkU6smo4bgEvqwUiIWc4uiXlGBM
	lbRgJ/4WP1qbOlNq0mKRqXyi7FRy0Et2w+xJubOhOAY49Jg+AlXMRw3Ia9sxw3DZBZVOsIrjxOZ
	5JfRB0A==
X-Google-Smtp-Source: AGHT+IE1BkM8u1uMxF/LJ+oAvk+/Ck61XwF1nrFOd9+nZTm6s22+JsAiR5ckes/nbIKLU3LTA7VFsn18XwaJ
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:30c8:f541:acad:b4f7])
 (user=irogers job=sendgmr) by 2002:a0d:d44e:0:b0:61a:d0d2:b31 with SMTP id
 w75-20020a0dd44e000000b0061ad0d20b31mr1012904ywd.3.1713248160541; Mon, 15 Apr
 2024 23:16:00 -0700 (PDT)
Date: Mon, 15 Apr 2024 23:15:23 -0700
In-Reply-To: <20240416061533.921723-1-irogers@google.com>
Message-Id: <20240416061533.921723-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240416061533.921723-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v2 07/16] perf parse-events: Handle PE_TERM_HW in name_or_raw
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, linux-riscv@lists.infradead.org, 
	Beeman Strong <beeman@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"

Avoid duplicate logic for name_or_raw and PE_TERM_HW by having a rule
to turn PE_TERM_HW into a name_or_raw.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-events.y | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
index 7764e5895210..254f8aeca461 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -603,6 +603,11 @@ event_term
 }
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
+|
+PE_TERM_HW
+{
+	$$ = $1.str;
+}
 
 event_term:
 PE_RAW
@@ -644,20 +649,6 @@ name_or_raw '=' PE_VALUE
 	$$ = term;
 }
 |
-name_or_raw '=' PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_USER,
-					 $1, $3.str, &@1, &@3);
-
-	if (err) {
-		free($1);
-		free($3.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_LEGACY_CACHE
 {
 	struct parse_events_term *term;
@@ -710,18 +701,6 @@ PE_TERM '=' name_or_raw
 	$$ = term;
 }
 |
-PE_TERM '=' PE_TERM_HW
-{
-	struct parse_events_term *term;
-	int err = parse_events_term__str(&term, $1, /*config=*/NULL, $3.str, &@1, &@3);
-
-	if (err) {
-		free($3.str);
-		PE_ABORT(err);
-	}
-	$$ = term;
-}
-|
 PE_TERM '=' PE_TERM
 {
 	struct parse_events_term *term;
-- 
2.44.0.683.g7961c838ac-goog

