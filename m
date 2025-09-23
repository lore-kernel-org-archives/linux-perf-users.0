Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DBC319865
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758666836; cv=none; b=k5nEc5p+LM8J+daIzgYgMyyo/tVdMuRgvh6A0+JdCuUyyAXSg00/gWBC21es/VzIw5diHjhUj+dfP19sm5/qZrNIfp6POOJJ8PaP52dXYX3lUThx2z1pMomAfSVLdkPn7IAytjAzss+uNe37VqsF95z2YjSDaqWBqIx+//w6qJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758666836; c=relaxed/simple;
	bh=kinTax4WdFsYYPU1EvIznTAAAXuDIYlDDYft/HbDYZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=h6mLg/O/MdxtUKIJ01x1k536Cpk/yIuXNbRvIvK3VWhQYlwugxHDu7pG2wblIomE7BDn7CUNBTNqH7U2c2KRD/QtSpcmgXtAQMK+XP2NGbNCxRDAgUdtLzeges/mwvDWsAxsuHwROs+cgSjja5UfZRggLSoolbgXFkJGUifiRl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y68a8MPi; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y68a8MPi"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-24457ef983fso129598785ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 15:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758666833; x=1759271633; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2M2YAgOSBSViQ5ZvyBXj2nrlbVi3MlFs0a+H8ZM9A3U=;
        b=Y68a8MPiyoXN9UA+tp9PwgEZlYTzFvygVvVqs/SEi6SqDyrNa9dd+SZ5WXyX++Iaw2
         dsdojXljcq7G16d/60Ty93AJE+q0UUysGwuAZqUelHhvydVRvbz2xFXKw4/plPZ1Pj91
         dRnd6h5rKMgtYc6rZh/VQ6LRWscmxLM6azTno606RrX+VlOeKQOL7ARTHzPnqKEEyFbI
         ox4X1X2g09ioy6duJGarEvG/4IB+bPeL1zjkAvDdUEkh8RKvvJAIqkpFD92ub7ksjJ9j
         a8AIrHs20f2WyTl3noJxiRrRL2Qw5l0rUpqSewuxWs9YbQgkiPf/yTPcLuHbHj7zgO5r
         Hubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758666833; x=1759271633;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2YAgOSBSViQ5ZvyBXj2nrlbVi3MlFs0a+H8ZM9A3U=;
        b=FHmvawcIt6Jyg58eBhA82Xg5gVGV55uoGmJtz9FAmEO2zSDv4I1B2ifRGpNeLZx0+2
         6a6i/3/uLzVSb5TOAccil3tKWp30XhVIfUANMa81lmLlQNpSOE2k6xY5JxHTU+oj4niZ
         +IDBiGkfIfZfRiI7YsC/j7e+7fYvpfCKCNpo2jN+Yf2G5elA58703PoSxiN+RWkOpU9h
         GKKwfhYB89fycSb2Jcqn3qxn7dXOLBRHtnPlHlRq0QEccm8rMRWqhbME3tSsh/2eGHfL
         SejQW8icPSNM5uWwN6mVS5aPxhc8+9ECdp7hbGxkx+7f2o8YwdZi4jl/yo3jFv64Yhos
         vy0A==
X-Forwarded-Encrypted: i=1; AJvYcCXzV1mZq7XFehpx73z6szMyRLORsddrv8iyxH9v4Sp2/FmJ9GXCCOSkxPGzP9PI+yqvL7+9aqtSzCSBmXCkcFqX@vger.kernel.org
X-Gm-Message-State: AOJu0YxmelQ8D/egeT3OUSYxoYoU697N6Nb6p/NYiPhJF5J+9nBMvc+t
	V+hBH9767eD2FNuFzK3308a5HQy0YqGXMTPT07BR5ogzjq5XrPfOnwuJneo+bXTwdo0VFT/lF9r
	x6napHnwA7Q==
X-Google-Smtp-Source: AGHT+IGjohmk085Bt7hgNSYy4qobunpfeMzukLWAVzAkXBIc1/tN9I0IdDgHb1iE9xLkPZU8IJVSAVHFU4AS
X-Received: from plih16.prod.google.com ([2002:a17:903:37d0:b0:266:b1de:9fa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f60b:b0:25c:38be:748f
 with SMTP id d9443c01a7336-27cc09e4184mr47330855ad.9.1758666833513; Tue, 23
 Sep 2025 15:33:53 -0700 (PDT)
Date: Tue, 23 Sep 2025 15:33:02 -0700
In-Reply-To: <20250923223312.238185-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923223312.238185-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923223312.238185-19-irogers@google.com>
Subject: [PATCH v6 18/28] perf record: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Atish Patra <atishp@rivosinc.com>, 
	Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
	Vince Weaver <vincent.weaver@maine.edu>
Content-Type: text/plain; charset="UTF-8"

Rather than distributing the code doing similar things to
evlist__new_default, use the one implementation so that paranoia and
wildcard scanning can be optimized.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index effe6802c1a3..e7c0e5363797 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4343,9 +4343,13 @@ int cmd_record(int argc, const char **argv)
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
2.51.0.534.gc79095c0ca-goog

