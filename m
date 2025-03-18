Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07071991CB
	for <linux-perf-users@vger.kernel.org>; Tue, 18 Mar 2025 04:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742272319; cv=none; b=FbRPoIXTx1xFND/peBDigXzZrg7aNpwlz1cz1T+wjbon+ipK8hnXYh74tK0B3lA7Y2AVO3TEFxZb7wG9SVduleOYB5gS9jRRBcn9MmBC6TGF2FeNE3Dw1gcASiD649WMwMC9Lmn2VC1lOhIPZgbky/Ew/KaonJjj4E0siYw6dDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742272319; c=relaxed/simple;
	bh=R9Xg6/Ngqi7cKsMGCB9U1IMDEdObQAmq0QYpQz3ckv0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qSBD5wG2XXVgBa6VVZKhfvbdzNgmyBq/AX9ij/9fjblft931u1XCoaE+WMa/8FTt7E0y2aM6iQrm56Up1ee1vO7O/rzDMSwxdzxwAaz6SIKT9eHrJ4RzFHQoTIG1J5TN+CDwWxqszQvIlWWVHR+nKaac3H06hSykLKsMtcwIXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjg+fDHv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjg+fDHv"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e63458181eeso8195280276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 17 Mar 2025 21:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742272317; x=1742877117; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=sjg+fDHvjvQIY9HiBYOWJjK7dS2bM7G2F/oQkfE4fItu+N2Xdq1LljzC2z0gFDC67U
         oI1LcRMyFEFSeAYa3UGsSSTmWgW4uKrkzAPA1AIgupQVdoTNFMMDHsJmWclZfK7urxU6
         F3XT5+6T0ICX/nyDyUqL21cKOuugxakQ/RefYbcP2xRB48zS1eAqFuheXI+rlKBoZabj
         B3u1Gh/4tqnFwP2x/ASXDja05auhmts/PxXLxCwrV0j4Ud5Uw+gtRaDN7oZRgBo5XTBu
         SLKlMTN1byTjP/CN49EY7yFlyYKWlNmeJ3fgXpPWBkA8k7hIFukSyLfgrmptAuzvJHwU
         3G4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742272317; x=1742877117;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=kZ8NB0PjnZ1/T5P2l3Yy4r0QZamL6UqmNisV0D+fLOE+1xHPBsTozJrNpJUGNv2J1q
         KlWkhN89mWWpEyt/m635F7dA7H0YRimCLAl72JbQxtLdP8SPtc8gzwARiO4h6qCrNn64
         Yd3sBgP7GxXgD+bQr8UvX81Wc/q7r6BNOvvAk4UMuoTbmq9Dhr9KZfNtjvKKQRL0SrLG
         KkvdrEggyfnykMPc21OHxVkKPpDORdPvKoPQoV70X1GrVVVWAmsCoe2bFE7UFgDhASUV
         XVZWN8ZnKRyrwbuLHpNIZIX5BEVs5JN1Aa2c1bYItOKqIyo9sX74CVT1QJsTtvms7vhg
         3mHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5sOztRelcEn3nxGv55sBosj24a8XvJ+mhCy6nGR4FIQPSBoiM0MtTY1L4btTPu+RRvqjz1AQJu9FLmHEWg8X+@vger.kernel.org
X-Gm-Message-State: AOJu0YyjNNgxl5Noz6gEI9qe+7NH2Pp8aApF9gIH45IgUw5IXnsTAzK3
	lrydGXG0IVnYBJTG7qjglEFEef7WePoL0gk0W8nSqdxe0v1LPImnx90hnkcDyBJs6NxWiFK8GK7
	ytsPCHw==
X-Google-Smtp-Source: AGHT+IE9RLBPYYi01/nJ6WpnF2viapxrPRVS7wY4MLSGpo6dfqlkOjr5inF2G5LwZ0a2dZ+mLAaiBH+9FSni
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:ef29:15ce:a42a:b69f])
 (user=irogers job=sendgmr) by 2002:a25:ad4b:0:b0:e60:a0b5:e57 with SMTP id
 3f1490d57ef6-e63f64e8581mr7989276.3.1742272316696; Mon, 17 Mar 2025 21:31:56
 -0700 (PDT)
Date: Mon, 17 Mar 2025 21:31:49 -0700
In-Reply-To: <20250318043151.137973-1-irogers@google.com>
Message-Id: <20250318043151.137973-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318043151.137973-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v2 1/3] perf mutex: Add annotations for LOCKS_EXCLUDED and LOCKS_RETURNED
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, James Clark <james.clark@linaro.org>, 
	Yunseong Kim <yskelg@gmail.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Used to annotate when locks shouldn't be held for a function or if a
function returns a lock that's used by later mutex lock unlock
operations.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/mutex.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 40661120cacc..62d258c71ded 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -33,6 +33,12 @@
 /* Documents if a type is a lockable type. */
 #define LOCKABLE __attribute__((lockable))
 
+/* Documents a function that expects a lock not to be held prior to entry. */
+#define LOCKS_EXCLUDED(...) __attribute__((locks_excluded(__VA_ARGS__)))
+
+/* Documents a function that returns a lock. */
+#define LOCK_RETURNED(x) __attribute__((lock_returned(x)))
+
 /* Documents functions that acquire a lock in the body of a function, and do not release it. */
 #define EXCLUSIVE_LOCK_FUNCTION(...)  __attribute__((exclusive_lock_function(__VA_ARGS__)))
 
@@ -57,6 +63,8 @@
 #define GUARDED_BY(x)
 #define PT_GUARDED_BY(x)
 #define LOCKABLE
+#define LOCKS_EXCLUDED(...)
+#define LOCK_RETURNED(x)
 #define EXCLUSIVE_LOCK_FUNCTION(...)
 #define UNLOCK_FUNCTION(...)
 #define EXCLUSIVE_TRYLOCK_FUNCTION(...)
-- 
2.49.0.rc1.451.g8f38331e32-goog

