Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D29229B776
	for <linux-perf-users@vger.kernel.org>; Sun,  5 Oct 2025 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759688714; cv=none; b=SVAF8CPzLdpHx4g3eKUlVRKkNtLDrSzR7V8UrhX6nTodNLRWSmwgyOO12VCR7u0rDI95bXN8M9fjqpgB7DLFBBsm5OsrCug0hsaqChJH7DWQMYHYfR1sO2PiqfzmWAxnsLoAiaObjdJgsHIcoVYLu4lX+yYcDp41io0flql59fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759688714; c=relaxed/simple;
	bh=J2R7suUc1maG+yJbyjB4MvtMgl+RvbeHwgnqP11/tRw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=m1ofV3f1J4eHv0NFWfIs+glN2Q5ORVHrthHv2EP3hAppn34DIDSKcgmPa2vr8tJiNIlBEHis7w+sf0WoGZdnMgXlz0pforvuFKFriBh7rNVOaoDXSlo7W+NUF586nbABl5QC4kxbj23bNPd6CtPFORoU0HJAPfExqOwh1hcidmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zXZ+pywf; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zXZ+pywf"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28e538b5f23so43806235ad.3
        for <linux-perf-users@vger.kernel.org>; Sun, 05 Oct 2025 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759688711; x=1760293511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g7rZSYqIMhbdHpnx3G2qSxnHbrMbtZAlgQlZbhQaQXY=;
        b=zXZ+pywfaH1UBdrenARp/zvk/mDFJNPR29AOAmV+bFOULo98kft4dHDTWk8yXxrbxK
         j9We2ti/4Bl23FUE6Z/7YSCZDopUAfSdW3g45l5KW6BZ4CmJA6njEDhVr4Jlp2b9cfX6
         FZyA3w/HnG2kRyCD0c85l2n3dDPBMYLxbSuzu+WlO07DBQYMB+KbSxQHSl7xCV0ga4O/
         ktbJ54TqGa7Hxu4/9WMnSAZEvt12m3hBfUeAn3d5M2arMaM/KCemgEiQzZu+U0PRwfH+
         jR23rfuUXJJPNIDhpOMZj7jctTv3P0rEK8KKCIO6BJhivpMhAZXhVizYUARITMmcgQJs
         HGVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759688711; x=1760293511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7rZSYqIMhbdHpnx3G2qSxnHbrMbtZAlgQlZbhQaQXY=;
        b=hZLvo8NXrkqveVr4mftTnIHnqxPJckpqo61FYg+g7tsrTlSYWDo7Scr13GNDP8q+eZ
         DExNnSwjIBWajJutsg3wM+5WYC0p7y1OSXJWI8ATsYP71yofyKVC5bSc5sqG4hYzv4BI
         9Qbm2xf8dAscfhqGVL+HZz28Oku1jtXeiK9U4p/SllbTwOdx40kZl0h3uMw3x5pDq+/U
         dGNS5/C3giKLRdxCyLUF5uBZlozPtyEXWZi0HL9qdqe6ZYTEPKOLZb42LM1fRUiOHdWK
         oVrdJ87ZgQH46MRD+KdxjJZO1ygqCvG2FQsZ0ZlnkijxFwqAlY3jw8bCvGehIzQo4dzP
         3cOw==
X-Forwarded-Encrypted: i=1; AJvYcCUU7qeVOIPniuaD9tsEJyKX7QIfBIXaG5g/+eL7Qt4rKQFv6L0qT+SR6GPEvlVWN+GdmWtJWDuFw3TpjdX8AfdN@vger.kernel.org
X-Gm-Message-State: AOJu0YxLlGQYaE7L/yxYgWkJ6DDMhn4Oq5QqUmzudupIDKTdfMRl6k6S
	vDOl1DApYSkphY8s6+urbqPXXUU8ZHfIDLtaYhlv80ODL1eAMrcv4x7thWlDdVlKjVuAWnedyL4
	HntVvRQyJKg==
X-Google-Smtp-Source: AGHT+IGVuQwckhqVMxNtkIaGTFP1yNiaBqjgn01MOygUPgnTMxt2L018/yxOFkeVIUgnOVTJbsV+y00zHL1k
X-Received: from plpd13.prod.google.com ([2002:a17:903:1b6d:b0:268:fc5:c615])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e5d0:b0:282:2c52:5094
 with SMTP id d9443c01a7336-28e9a61abb2mr112074685ad.37.1759688711469; Sun, 05
 Oct 2025 11:25:11 -0700 (PDT)
Date: Sun,  5 Oct 2025 11:24:20 -0700
In-Reply-To: <20251005182430.2791371-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251005182430.2791371-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.618.g983fd99d29-goog
Message-ID: <20251005182430.2791371-18-irogers@google.com>
Subject: [PATCH v7 17/27] perf record: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: James Clark <james.clark@linaro.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Andi Kleen <ak@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 26d8da560446..cb52aea9607d 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4341,9 +4341,13 @@ int cmd_record(int argc, const char **argv)
 		record.opts.tail_synthesize = true;
 
 	if (rec->evlist->core.nr_entries == 0) {
-		err = parse_event(rec->evlist, "cycles:P");
-		if (err)
+		struct evlist *def_evlist = evlist__new_default();
+
+		if (!def_evlist)
 			goto out;
+
+		evlist__splice_list_tail(rec->evlist, &def_evlist->core.entries);
+		evlist__delete(def_evlist);
 	}
 
 	if (rec->opts.target.tid && !rec->opts.no_inherit_set)
-- 
2.51.0.618.g983fd99d29-goog

