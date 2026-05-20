Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4917C329C6B
	for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303967; cv=none; b=e90wEWeu+pCPlIUDcLuRSc8gPj0zyHTw3u7XpyZDUtX+kWJahXQK2sxS43q8qVwbr5y4QFNoESDCfQETiy0Aoz9A7iD7RSh4t3A6HN9NBWPhyb2G0vpwhKttYDL9CjIlt0J5Qnq3Hm4ts+IBHgaR1HKXO8FrgtGqla595sASkxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303967; c=relaxed/simple;
	bh=S2e9RZWnJAjOM4rZRaq5ZVrCHlUyK8omjHSzaihuZj0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I7+MDZRWeqNLukwPCg2t0GLE1koJpma1pUodDz2c0OD78ynvusbvb7dZAqJjXQIYOu0KGWdNioa+V5nuNyfYNJnENTijdN/DStLX0Y2WJM1tloDJ3b94pVBvaQgljcF3BYYms1Hw13Nurn0EReGiOVgz8ONExdOR3qDA3K/csoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQtMnYCM; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQtMnYCM"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353bfdbf99so9138873c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 May 2026 12:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779303965; x=1779908765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KtZTnSUx4EyEfsBoIiFYlWWQdtWvpt94k7BNBsYS7+E=;
        b=vQtMnYCMQ6WB5tQ6LMd8fXv8gaSAyMnQcTv1vWWEblxn63OI/lrVU73MtICft/INRe
         b4TqMr1q7AY7cQ3t2tuUTE3sqgzM3vxmJcqgp6ZX9zyzaBZ8Ppw6CK3VKkyAxYFuQGcH
         pBXpxCI0skfdbgM/Ls3K35DhC8M0kcrUUTzq6NSDAa6MK/Ks4IiFNmOKWkv0NH6TEhku
         e3AWYCTcAs4mwLW2d7wvrkk0fiR8LO7NeO6We1JswngIgt+WqPAyI1sBgHyNlFulC+qC
         SDQEIFZoYosBtiBtkCLHW/ftDSEFeqob2fjoILJA3187ahkVH3Y96JPOv6oFx5++BoAt
         rR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779303965; x=1779908765;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KtZTnSUx4EyEfsBoIiFYlWWQdtWvpt94k7BNBsYS7+E=;
        b=N7wmuBECXz0VKmEJcuXAAxN+7OCj6j6NvQgdhvgAEhkX3mVxV4lbboP63BMpYbmxf/
         TOcq2eJuZQcS6/vD6wCCQdeT/KhJZ1mKSF0tuwrlzHF3DJsWK2fM17ava+zPhDvweB+n
         DO1j27Yd/H2usHUz1l2dLwa4hKLjw0Imrsz7C90PvHPuiAurgdrm1TPxRMe5cXQRsK81
         nasIBrhCbVjLROG5c7ojRLH6NbnsZIlj7QtM0tF0RiQx6UTGr1fVHZDt55DYdsMdWCQJ
         snCRjcvuKnwoVH/fgjTyIVE3wbW5DkWF1ktu24mpJM6MRoPA8HhyO7A1ez30/rAivyRw
         A2vA==
X-Forwarded-Encrypted: i=1; AFNElJ+KkP6AkPOpxF8fE9r9s+R7OSHJG5wLDuxZ0a5fjONE+ZgwFZ2UZjDkUm9c16aLyUNsyGGcbmnJWk7tQMpo8OM4@vger.kernel.org
X-Gm-Message-State: AOJu0YyjIznUH86EfI/ZGD4nbN9gLwRkZZXHbFXM5LNwtkI0gSE6ms8w
	/0dvmS84y0rG7qVhmWhWI3QpEglf1rq0rG7oikV0Ud+5U1oUTZD3o27nzT5XaPQKmUeD8zcvlQh
	0fEck2/DAww==
X-Received: from dlbsj5.prod.google.com ([2002:a05:7022:f905:b0:135:f8d1:1804])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f313:b0:135:d931:bed8
 with SMTP id a92af1059eb24-135d931bf98mr2246701c88.25.1779303965159; Wed, 20
 May 2026 12:06:05 -0700 (PDT)
Date: Wed, 20 May 2026 12:05:17 -0700
In-Reply-To: <20260520190538.142018-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512223001.2952848-1-irogers@google.com> <20260520190538.142018-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260520190538.142018-12-irogers@google.com>
Subject: [PATCH v14 11/32] perf annotate: Don't pass evsel to add_sample
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, ajones@ventanamicro.com, ak@linux.intel.com, 
	alex@ghiti.fr, alexander.shishkin@linux.intel.com, anup@brainfault.org, 
	aou@eecs.berkeley.edu, atrajeev@linux.ibm.com, blakejones@google.com, 
	ctshao@google.com, dapeng1.mi@linux.intel.com, derek.foreman@collabora.com, 
	dvyukov@google.com, howardchu95@gmail.com, hrishikesh123s@gmail.com, 
	james.clark@linaro.org, jolsa@kernel.org, krzysztof.m.lopatowski@gmail.com, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux@treblig.org, mingo@redhat.com, 
	nichen@iscas.ac.cn, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	ravi.bangoria@amd.com, swapnil.sapkal@amd.com, tanze@kylinos.cn, 
	thomas.falcon@intel.com, tianyou.li@intel.com, yujie.liu@intel.com, 
	zhouquan@iscas.ac.cn
Content-Type: text/plain; charset="UTF-8"

As struct perf_sample now directly contains its own resolved evsel pointer,
passing the evsel separately is redundant and clutters the interface.

Remove the redundant evsel parameter from annotate-specific handlers and
structures, ensuring the tool always directly accesses the evsel bound to the
sample. This simplifies the API signatures and eliminates the risk of passing
an inconsistent evsel.

Signed-off-by: Ian Rogers <irogers@google.com>
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6f8be9ead43b..719b36d4eed5 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -232,11 +232,11 @@ static bool has_annotation(struct perf_annotate *ann)
 	return ui__has_annotation() || ann->use_stdio2;
 }
 
-static int evsel__add_sample(struct evsel *evsel, struct perf_sample *sample,
-			     struct addr_location *al, struct perf_annotate *ann,
-			     struct machine *machine)
+static int add_sample(struct perf_sample *sample,
+		      struct addr_location *al, struct perf_annotate *ann,
+		      struct machine *machine)
 {
-	struct hists *hists = evsel__hists(evsel);
+	struct hists *hists = evsel__hists(sample->evsel);
 	struct hist_entry *he;
 	int ret;
 
@@ -298,7 +298,7 @@ static int process_sample_event(const struct perf_tool *tool,
 		goto out_put;
 
 	if (!al.filtered &&
-	    evsel__add_sample(sample->evsel, sample, &al, ann, machine)) {
+	    add_sample(sample, &al, ann, machine)) {
 		pr_warning("problem incrementing symbol count, "
 			   "skipping event\n");
 		ret = -1;
-- 
2.54.0.746.g67dd491aae-goog

