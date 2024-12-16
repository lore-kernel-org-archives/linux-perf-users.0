Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB791DDA34
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 23:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391516; cv=none; b=sVLYj9E+0VFXZ7cve2EbEXslV9Re16F/U04SDi0l+X02BJdb6arQ36l6JLDnWl+lhKDX0uiucAjG6HqhENe5PH8HRi2zSchJqzzWNglY67RGFhGux0te5GqlP45bXLqBVyi8PqrO4zFhgXDSDmfFNo5NZiJsYWAmtVXB3OaqjCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391516; c=relaxed/simple;
	bh=iEVYgx/hxX84VyoDEpscAjkrNLwDJylilFK5OuBYN9g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=N6CV8uGZ/q6ajoeKe6liOHTcxdKEtew1kiCrSAaD/qQPc9+ZGrjSxgzFeCqYn4eEsQ2SnhWv8kQhK17i3k1F58DZSBXCu43mCUB3GuMyxmeqdvZQp6RRfmccTFLQe36vGYXYdRWh6UnLWek56nISZy4sZHMMewDf+d+NUbsSBcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ySu7h231; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ySu7h231"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e3fea893dc5so5686910276.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 15:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391514; x=1734996314; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=ySu7h23181UwWbX3I1NG9aj9Z7WJvw5rfzZVCunSWu6M5wRL/3MKid1z1Jq1mQF8ss
         IxdyVPzfn5k25QW60zLy6oMWzCYMrT8VgEB3d4k8OkWkHkj4zaS91IEtyYaFzq46NEH6
         HYG6YhjSM4J2U5jhQhJYtfbMYlnzfg6JCiDIMzBhBN5rbep3+bLRpMTtyhQoCiGyVlln
         3wBKCUZqGFlt++BgOnjugtoSPLv85LnUvqH9QosH1VfafJLIK3Q33c5ERQ643iwTCYGq
         buY/lvfTV7n+P2xfEKoriDujBnvgWhBidSLVu29qRc4PRY8pom/rYVj0B/278AEMLL+M
         syaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391514; x=1734996314;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FTHl2TPsCH6LymZInluDoB5DdWMc8GssygaKpaKL3WI=;
        b=pa2sBNtDmaxGUmXnbz4/VzJihjEsF5WHNEo/bo5vWtbGb+9dlkQLDMlIV9L4ySjk2R
         pgLJgcZJMecd7iT2EVUpEWzqR0R7eN0qzCDGAVxtedwJSRnoi/pNmHbc49Vvsx++AiXx
         fveNLBDOb/f54O88xVF7yf6jordfKKiGlFbtqypDzUnzqJQToybuxVAGqPn2hPBzWBCs
         TcdIlIxzbm9PQBFzqhqtbvOwQLaJPMMGM3Yh/e8Jl2kF2KJQLeGlL/BPDQ+dXag2pDOe
         lYiQ4qXqgBD+EsRf1aTlevYFm9hSQ6aOkJOaGDuk22f2ZZqEgT4dVUTjNgFMLnyJRXZ9
         Ho+g==
X-Forwarded-Encrypted: i=1; AJvYcCWdnJg8aRSiyRrxk7A81ugrCvrvVqf85nThdMqQ2NVIyeOiqajmT0Pb7mekFwmzS7CaivYiCMTzJhq535FQe7Gt@vger.kernel.org
X-Gm-Message-State: AOJu0YxEW4klL36dxC55Mx9506I69u4IUHzTLcsjAaDBFf0i+p5A5z0B
	zcB/p4mUFGH//O7aHkwCW6eVhImh+44/mi7Bo8w6SxavmKlxEMGHfxdtM+HxuVXmvnZyKH/zblX
	+g6yZeQ==
X-Google-Smtp-Source: AGHT+IFd1yidZo4+PCjzzLBKzlvBgB+iWRLxaQKGvW8aqa9jBsNOiHI2lkdQ9omQXubeZJj1mM0cO/8DOG7P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a25:aa51:0:b0:e38:9694:4c6e with SMTP id
 3f1490d57ef6-e5325f97ca3mr554276.2.1734391514479; Mon, 16 Dec 2024 15:25:14
 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:59 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-6-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 5/5] perf record: Assert synthesized events are 8-byte aligned
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Yanteng Si <siyanteng@loongson.cn>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Capture that events are 8-byte aligned and avoid later misaligned
event problems.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index adbaf80b398c..a5689d0e93ad 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -624,7 +624,10 @@ static int process_synthesized_event(const struct perf_tool *tool,
 				     struct machine *machine __maybe_unused)
 {
 	struct record *rec = container_of(tool, struct record, tool);
-	return record__write(rec, NULL, event, event->header.size);
+	size_t size = event->header.size;
+
+	assert(PERF_ALIGN(size, sizeof(u64)) == size);
+	return record__write(rec, NULL, event, size);
 }
 
 static struct mutex synth_lock;
-- 
2.47.1.613.gc27f4b7a9f-goog

