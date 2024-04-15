Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83FE374F5
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Apr 2024 06:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713163010; cv=none; b=oDX61/HLguEe3eZMJfb7X6p/AxwNJkEZoHxDzwlr/1CRAhcgjARbet8gNvhcFzbS/nJxdU9y8KUkvPMW98KeKgdeAF8QVXxl7xWFD8jCL/T/GdmQj5LqOwWsNuqp6o678cvn85J/xXh5FHwcQ1HuiaEqYUaFHESi0qg51XXHQ7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713163010; c=relaxed/simple;
	bh=yRXdGKWgYrAy4QEN4utAId08JcclyUD6POZY54MLD3g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=rob1BLU/h4OXSk0GSeuBkS3SxnZ8L/sbmddJCc85Ko+GOO/nB5TO/hbc1kRDmRSzlQ7+KSWP/mhgCUejgvg16czTMMjSrFdw7x6NjQUCdR43p0e1KGez4zCVw8p1qSDpqlbIiX0dykGnctj5NWBm5JGLqiTPQaGTfroAnVI+mAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jDzBHwiA; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jDzBHwiA"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61ab00d8a2eso16367047b3.3
        for <linux-perf-users@vger.kernel.org>; Sun, 14 Apr 2024 23:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713163007; x=1713767807; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t6u9K3gcjLrMHLCFAhYLG4bnVQmGcLUFFxbpFKDU6RA=;
        b=jDzBHwiAOkRQskyS5zSTKTDjRWNAisWGYxkQYiJHclJSKc6s5nkq5mcNDw5yP+/sEB
         BFWqiKD9XbxK8gyJCu1tFIf2sZnqE7Es9jS5YcsEe2qkgfHKFQoadiV1PQ5SA0q6bG9y
         r5rusuuE+q77qkwkTm5Z5I9xn4WYjvUPmSfw94d/lsAa+fUaMNMPYWOV+vfhl5OWsIsx
         JzdHvJQl90399wtcKZhgQAgk2lEkXwjZ9UpGJLac+AAqkMtu7j0Nr+I4xz3TCiPHPs3P
         HRTA9Gveyg1N5b+eyYT7rR2SPQ/jXtaxBuMaAUx2BfyL5ANmiVX7J921CG7Xf8RXF939
         zasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713163007; x=1713767807;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6u9K3gcjLrMHLCFAhYLG4bnVQmGcLUFFxbpFKDU6RA=;
        b=Fv1d7mP1xyzZW0tC9AfCfa5P8dvAPthTOFzNMNBRbf+WFbWOd8PFmLFLRj4WylIHni
         yEa5+ok0aTkfB+3TEksNOYOvDc4uJYZHBQcJ9kgegXFQVHSF3GzSGYVr2wJkpDwQGq2L
         i/6sWVtZXH1/tmZc7aAgE8hYa6QqINu8i02HJI069hq7Pw/PLKEO9/W51ky9rFhachTx
         o09SjNTUD/RnTpu736EFBHdp48fC425NJ3FGtDfdkSzduHiHJG7xUK0EFKruTKcag1Nw
         7LDJMf6NRxLKhbpkpRK3THyTLQ9G8Rf1MQzaAmN2M5+YDhS5jXjKZYaWc1Ci/1uRy2GA
         j/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVtkFa5wYJrzxfztiGchBmwgL77FrbZbTKaQa4+VeVVGLYsHIeK79fHS1LfQpXjOJzYUljVeo1bsQOXw7MGYBiGOapGkoLIwGzyjGYJdgQ0nw==
X-Gm-Message-State: AOJu0YyC1KFUrh/gil0qAPJWG0VnqUEIIsCCIcyTagnBMk1Xc9A2Stur
	grxIj7xXfUt6gZxSUy1cniN/AhRLnzhXnJ14sr+4RI2fituAFohPJhcV7iHZ0wn9EuVlEhDKUkh
	vkfpM4g==
X-Google-Smtp-Source: AGHT+IG8RJ4TxbVqnYh/ZFFdHmJfxbpZPCmfmXJfgiLHBndDiPsUAFRcqUnZUMNnHTZLEpylkDO/67CKESCA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:f304:d776:d707:4b57])
 (user=irogers job=sendgmr) by 2002:a05:690c:64c7:b0:61a:c98c:c2a3 with SMTP
 id ht7-20020a05690c64c700b0061ac98cc2a3mr623165ywb.10.1713163007703; Sun, 14
 Apr 2024 23:36:47 -0700 (PDT)
Date: Sun, 14 Apr 2024 23:36:24 -0700
In-Reply-To: <20240415063626.453987-1-irogers@google.com>
Message-Id: <20240415063626.453987-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415063626.453987-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Subject: [PATCH v1 7/9] perf parse-events: Handle PE_TERM_HW in name_or_raw
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
index 14175eee9489..bb9bee5c8a2b 100644
--- a/tools/perf/util/parse-events.y
+++ b/tools/perf/util/parse-events.y
@@ -605,6 +605,11 @@ event_term
 }
 
 name_or_raw: PE_RAW | PE_NAME | PE_LEGACY_CACHE
+|
+PE_TERM_HW
+{
+	$$ = $1.str;
+}
 
 event_term:
 PE_RAW
@@ -646,20 +651,6 @@ name_or_raw '=' PE_VALUE
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
@@ -712,18 +703,6 @@ PE_TERM '=' name_or_raw
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

