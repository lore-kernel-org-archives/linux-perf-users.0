Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82D337C906
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jul 2026 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784782805; cv=none; b=rOe76rZhf+cqluBs6+MKoTBVPeLhRtkWg4jmaJBsAoWDdre0Ugphoe4iJsyiKJAuNYCBREspmRgVFfPRvDrU4TABhb8AwZ0KMwRZWjuVYjsJ4VuiwR425dWur9KiKlYkfZA7pM0aPSLGd+5X3vC7yW0KaAzS0qiUqWJnKwcFUUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784782805; c=relaxed/simple;
	bh=bEnNECJvHXimmsTecSP4yaSIJ0gxccx93jr0yIJvCVI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TIxlmYPo84mkDMCERJVw2iZtl2l5xNQytacQN7MetXjILli6gpATtGoIdYXlSbKtG4L82lIt5F2JMztEr/71Oz9FG285UsswGfwNt77BxrUOI4Yv6WVIdsZm7o1YbzeMWYHx29walpdDYfedNf2/pHlaA6UcZdwTennLHZWJ1K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uqe0IYNy; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqe0IYNy"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e63de75aaso394171a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 22 Jul 2026 22:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784782798; x=1785387598; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=asfkKKPPdKeo5C2ctXLmi7D2DfJoKiaFqe1LNGAidu0=;
        b=uqe0IYNyQCHR/MeMlVn5DuQjzp0pOEbz6UQb4UIhDXNPitsTIJGFsO+VUDjI4TuTV1
         cMHn7vtMckcKYL1N/wuozIaH2vyhnK8LLZA+EZRuiGtdHrgyw+Mm7XC2I/Ywep6/O2f4
         L25Pb2tHJeG6A15U7un1gJ2aSK516HceJqOmAvPHP/YwmrLbjAMs7rjMz0wn90SzFY2f
         mxG5M6CZBCdidvwZlrBzwsUTgHeIB8Eyb7ANzWRYSxjz32y9WLMcjBwoHs31d5Xa2aW0
         fHCLjY3RGkC2FYQXbwJWu52a4fXZR8xqJ8NgFUJDZ7ZUUUekkDCSbiyc9GBmwvcLG+Td
         uhvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784782798; x=1785387598;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=asfkKKPPdKeo5C2ctXLmi7D2DfJoKiaFqe1LNGAidu0=;
        b=niFKHCr5a9Hp5K+z+RbdGGaIEMcduYfacn+wNZ/hE70mTfrS1C0YyxLDy7fcOVd4RC
         r3UbzyeX4TPbZKXjaQWjwyZPJ2vOKN7Kb4bUzit7fQiGukFErCINuW/CbWyJWa+t2nJ2
         Ed8m3+J7U59swGRsR6o6xEGuSVvyr8bPC5HxmPC1TIeEWWY6cP8Mli5ETqzAL2Y5hplM
         xK8OTtpZudX+tajjDzu301hpJxjIc+QKrYA/z7Aou1vXtkLURq8WyqZ3aeXJKqoJ/fqr
         NB9A02yv8H76CpstrxtZ8dl8kbXF+Hvcl1Ga/iuZPNtOR2WVdbJe/qWeO+8e98JeZTh+
         Ew/g==
X-Forwarded-Encrypted: i=1; AHgh+RpzHlRk058buOj6t2rufgKxzGpcOq4ROXGDmIuRmDNx0XQj1atwSiSsXl6ytymD6+ABu+QglJnVM3G3MiiRT2aw@vger.kernel.org
X-Gm-Message-State: AOJu0YzVmZsFkR0mNL/M8R6HO3gLSFTD7BclkuMinT0bqmFudoi0qghT
	UoNxpGCzVW3N3KzYkzxsZ8uNd5kagBzcWHCNrrksuxuhOjLjo3TOwUR/u1OTt/rYK168BTkaO5B
	OltgzXLc7AA==
X-Received: from dlbtu15.prod.google.com ([2002:a05:7022:3c0f:b0:13d:1bd0:e6cd])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1d44:b0:38d:dfd1:7a8
 with SMTP id 98e67ed59e1d1-38ec63e1ed7mr1593723a91.2.1784782797906; Wed, 22
 Jul 2026 21:59:57 -0700 (PDT)
Date: Wed, 22 Jul 2026 21:59:45 -0700
In-Reply-To: <20260723045949.988740-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260716072351.560311-1-irogers@google.com> <20260723045949.988740-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260723045949.988740-3-irogers@google.com>
Subject: [PATCH v7 2/6] perf ui hists: Guard against NULL hist_entry in add_script_opt()
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, dapeng1.mi@linux.intel.com, 
	james.clark@linaro.org, jistone@redhat.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tianyou.li@intel.com
Content-Type: text/plain; charset="UTF-8"

In add_script_opt(), when the browser selection has no valid hist_entry
(for example, when all entries are filtered out or the trace is empty),
hist_browser__selected_entry() returns NULL.

Add an explicit check for he == NULL prior to accessing he->time to avoid a
potential NULL pointer dereference crash.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/ui/browsers/hists.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index be8a6b169722..f5e13fc125c6 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2826,6 +2826,8 @@ add_script_opt(struct hist_browser *browser,
 			time_optstr++;
 			time_act++;
 		}
+		if (he == NULL)
+			return n;
 		j = sprintf(tstr, " in ");
 		j += timestamp__scnprintf_usec(he->time, tstr + j,
 					       sizeof tstr - j);
-- 
2.55.0.229.g6434b31f56-goog

