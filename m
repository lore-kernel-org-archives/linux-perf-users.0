Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B17846F
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Mar 2025 03:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741921721; cv=none; b=tHQD0n2simrZaUy+86oBX1EyYuw0LmBK3crbr5zlZ9I8uUf8olubjYn5qBFlfGEOyCK4dki2BqgXjNmS6bYpkBq45u0+gjELBYIZPOYgV2nxHlFBLrXSdV/3b2bY03gU5FmsIe9mxHIkgVFHzIYTFTDLa6sAfzoPAQ9iJl00rX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741921721; c=relaxed/simple;
	bh=R9Xg6/Ngqi7cKsMGCB9U1IMDEdObQAmq0QYpQz3ckv0=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=FAU4Wgja/6zEbkXuEtDzEwGimmrqHn67s1Y/UA39HW3JX3vOOjtpVwIYH4a2ke9K/pbK8TL1ddozlEooMzgkb4txVte6q/SNDqVSVZtI0ncSSVk4E4TBfOIXzm48ySdj+xVdC4xMrDOQ5zpD12jYvDl2WSJGbfpyKck3owCCqno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MwfGTSZu; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MwfGTSZu"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6fec6c91630so26392717b3.2
        for <linux-perf-users@vger.kernel.org>; Thu, 13 Mar 2025 20:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741921719; x=1742526519; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=MwfGTSZuQdrUAI32ckXcqWdyHs58EtI+LwkiejTL05qxpSSQMeUHl82UZVexMeHQnT
         yXZ/y0LIfWnWDcY3j0etZUmv6WtH48ztThuscJornocBd4P8QGX9RosNL6fqG4WAcH7F
         YcScxw+MMtNjoN7sPjpqYaQu0Nc43YREN7ztgabTmVqXVex49OO4s1QoabgfnsZmjlU6
         7WSEnLyWaV2RxweTGo9p33RmpR1vINE560/oANTTdrhBqwvlGwdos0wSEqdsCW3gstlN
         MuJK+XylGjG5iHdRLuhiHWKXntfcOicZ3gdoDj0UYshi3TDEegAWwoL+GUh+MerAhrzS
         uNsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741921719; x=1742526519;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IsSrnV0KmyUDFf76MOHDYiCKaXGAeH1pZZ/Ur+aDjTE=;
        b=UDOf5/MP7Kg8tYhroMz6F0+LtrL3Q8vCDfFoINg9GpRR0XFxtaN1qi1VI1KTDf97px
         NqE/aisXaQrQID36AkQh0kkTaKXofWvjsTn5gS8iEYZMPaKoam+0SlMOvgZ9goNIFZ+l
         YGFl6XONPhvK/a/T6TWerHwH24QaEjpsw3aA/TZDCI3+V4O0dUd3cuxKJbLz8ZQlLvGu
         DMoIqa5SxQ+FwRbM/dlZwcnEruveEl+d894MBvWIZbLO58wLvWK3eid+EEKl9faAzWef
         bZC44dM8MOWm+O+qIM4/9N1LPKomD7C6vTmmRFW48KCK+aLFZUngN6lMa+NyboO11A9I
         cq/w==
X-Forwarded-Encrypted: i=1; AJvYcCWqelYI0iSULH6ek5q65JAbBPyGivWnOBR2LZLl2TmFop/D8sC4MsmN3uPE0WKfqtzaO1Ms4gLO6stVOVW/aVES@vger.kernel.org
X-Gm-Message-State: AOJu0YxFqEGtQ+O28D4piCtw6X+sLjiadH17Uor+1qf2pl/SIcRhBcXc
	YobS2F4d2PA1CGIBrRDPqiuH9rdydm1u83j/6n9AyqbOBOSu+OQvR6gkkaRhhCpNtbkvHSwb1Vr
	lEHb37w==
X-Google-Smtp-Source: AGHT+IETMPFBJExY/EgyF1LGf10HrNsQ9tDE9+N9OXpEXNBDMGqejGQyQjz8s+91H9Szbm5Jc1mVnI3nNDqk
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:cc2:382:11b4:a6ba])
 (user=irogers job=sendgmr) by 2002:a25:cec9:0:b0:e5e:1554:41a4 with SMTP id
 3f1490d57ef6-e63f65e2be5mr496276.6.1741921719423; Thu, 13 Mar 2025 20:08:39
 -0700 (PDT)
Date: Thu, 13 Mar 2025 20:08:34 -0700
Message-Id: <20250314030836.1129407-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
Subject: [PATCH v1 1/3] perf mutex: Add annotations for LOCKS_EXCLUDED and LOCKS_RETURNED
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

