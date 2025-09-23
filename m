Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20292BE04C
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Sep 2025 04:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758601168; cv=none; b=dAFBDhip5atTTOl/0CU5HoD6w7s/L2s/6Im9vp8CL25wfvfYUeiVso926v5MInzVs4j8aBx6gvpGjXBCcVGsCLu5MEsbmWuMj6iyUp0BckpenOEiB9+FKpKy+bZRf4FZ1EjSuGl/rsAr6Y5iu7UG/M3G7lVXN3Z5sC18HU5maPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758601168; c=relaxed/simple;
	bh=kinTax4WdFsYYPU1EvIznTAAAXuDIYlDDYft/HbDYZg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Eh/vrzP2Jq8oGnBDxInBMu27jIPkD1OW/lCvO6Pfmch7DNu+SR80L7OMT27jEkODT68tHoT7g+Rmh5YYIgF9q6HbElv1k7F+21KPtovbmq3mvN6Hlq8m8+iUCF7kV/QMbO1e6XP0ggz9F4YuRbnA49+fI+gMwS+YyTuVoJfRdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gWeajIij; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gWeajIij"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-77dab334f78so3853535b3a.3
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Sep 2025 21:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758601166; x=1759205966; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2M2YAgOSBSViQ5ZvyBXj2nrlbVi3MlFs0a+H8ZM9A3U=;
        b=gWeajIij78utNW3daspl8y9IgMOLeqMyl/qvSpiuVdWwmjqMd5U9NfqZwScCcuww/P
         qKUGdEZmLQEi5QtHekIBdVrNWy9chAm4Dxm2DnyZ+zJxClD5YREAKyoipxWGT+2HBKs/
         S7JehYMpv4AnVpV6tKJQKhWw1oGrdS4f6+H4UT/0uwci94E/cl0cTwl2Q+i/nPIErJR8
         +KuXqK2NJgphtlT523D3fhV0dTcPALguj2FQkuv4UdE7Em9y+9xaTN5d9XAnebLrAUp0
         ry3NZCViGhylDAG0nUHoLmIaA/jDJBZ889s8JJe8Y+pnxNcFSM9n/JaQwvpEgELF50MJ
         DJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758601166; x=1759205966;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2M2YAgOSBSViQ5ZvyBXj2nrlbVi3MlFs0a+H8ZM9A3U=;
        b=HRWs56AxCEg7KhPiy1ZDduvh4AS2nkMG4Khou9PDljWqAJC2u/a0uJ7nsUxPj2su4l
         DAvCoKs/VWc0rpSqI6iO4AX8UJBShms9e9fgAwBSgg2aGdwkKt2RnxwYNC9BcYziK6ud
         bYfVd3wZ9pXPOemRc1im4xSev6rdjyjDHGfVPp+ID781w8x+m220iXwKaLzO01f4meT3
         2gmvq23TkDHLDRf3/BhFpKclA+33beCaO1eE6Svx1H8uHE+oIDA51UZ18QYKPUo6U1Yh
         pqliB6xS4POh6KZdkZg2iYfbA+5mdIOjLKPboYFYGHa45rCM453uRnQD0S1dJ9o5Duoy
         2aHQ==
X-Forwarded-Encrypted: i=1; AJvYcCVb26EsbqXd8qFSkOgpEMMOQIy+RAzKS+PbfH7ACtYk9/Edeo14sm6wXtFvDI1siyyAO/cilaie6MS4+FOPxRpO@vger.kernel.org
X-Gm-Message-State: AOJu0YxpeqkM1xafJxWQ6RrTGEVoFuDuj4f4h5e15wFR+V6QYdQq1UCh
	pTBPcSrfMCCeqdMXai8KJ9Gk0ZwvKuSaeAyOOJQaVA3FXNvnVq9k98vlqHXwIUkMsLEOpRYr745
	/RjrbvXIHqg==
X-Google-Smtp-Source: AGHT+IGFvYMI9CkPRNmvX33lF+WTbl3MB9WJT75wpDfB4ZwwgH/gt8LTh154TO4b3nLNiaMYhRQW8xlPPCuo
X-Received: from pfrg28.prod.google.com ([2002:aa7:9f1c:0:b0:77f:4da4:298c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:2e1f:b0:77f:3db0:630c
 with SMTP id d2e1a72fcca58-77f53aad431mr1623421b3a.26.1758601165878; Mon, 22
 Sep 2025 21:19:25 -0700 (PDT)
Date: Mon, 22 Sep 2025 21:18:36 -0700
In-Reply-To: <20250923041844.400164-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250923041844.400164-1-irogers@google.com>
X-Mailer: git-send-email 2.51.0.534.gc79095c0ca-goog
Message-ID: <20250923041844.400164-18-irogers@google.com>
Subject: [PATCH v5 17/25] perf record: Use evlist__new_default when no events specified
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Xu Yang <xu.yang_2@nxp.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	Atish Patra <atishp@rivosinc.com>, Beeman Strong <beeman@rivosinc.com>, Leo Yan <leo.yan@arm.com>, 
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

