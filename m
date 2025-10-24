Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D7346E6C
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761328749; cv=none; b=G4jRLSH8S48E+bESBQBtKcEHjMJccJoIv45tI9QuapiCkRUxHcBT2D9iHfzdKEeTaKMecowzSN9isah7CTaJJE6ekqh/q3rqquVccKrqCbjtq7MsCyFMPblGgMIJ7QhlfDpA7JmYJRP6KJchCbGAcynTbJvviaMMzGS4ox6Sqzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761328749; c=relaxed/simple;
	bh=rFnvrhJrQ7j7hkJ82kWWbtJZ3FFEl0AVotLlFTPUNLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=rKWFMxQ7/9tzZ/FsUOTXXEZs3GeuSjCvxjLXoMkHCVSA03/5GbbntoP3Uucu24n698PUKQC5RNT3v0ImEin8DaX1USwcuLYEthPz9vBHU8jZ7umoDbg6xyfDzxDJjCLXR4YTuVDV5OiiRp19CHNiME1qPbOeXWSUNLrlHp+6i34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OeoonKfU; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OeoonKfU"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b63038a6350so2363531a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 10:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761328747; x=1761933547; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/orE7Kl2T5+FMrzRJXD3kZQQJ5k2gk8t41KGFSxw6I=;
        b=OeoonKfUrJzc8h6T6Bo83j1pKLTKnl0sXNUuDbFCz8GnRzvmOQWG1YN1malGFP3kn3
         KtMdbHn4t7cb6/WtfLSJJ+LOcDyOG/fSTyPNOgxNfxYPrmdSvtXaIAgsa+4v1gJEC4sl
         BYazjc7G66z+mmH56LDroOTjYQAHPGKLvp66DJokNjHg1IOLNBjV9rps4JJAlDGSvHJj
         +DJTj+xEkkyDH21909rMiVAgGgHDPZDb+sUodq/R2cpK14F++KVVH9kVSdwpO40yAWDA
         WG+M09eA180uE+hKnZSVtdal6BLywjF96kRpjkUiClD1SHdL7yT+PAZlT5PyE/plfJgw
         FC7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761328747; x=1761933547;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/orE7Kl2T5+FMrzRJXD3kZQQJ5k2gk8t41KGFSxw6I=;
        b=jSzajMFbInucwQFAvGbVAl0TWNgMGbfUGGVTIsk3qiqK5jO8+Au7f2sj6gc3OW8nht
         Nqe6gJdxgPz4PHLF3UZGQUF5AZQ4pLktala9z6ivaCkMdGgxnxmtc16e85AtfW+TLAEM
         BrZJ6OQkkDjaytXrhBoxL2pfJMksMvC7rjl8/pKO2JLl955ReDF00DT8fHpSyA9XKYOu
         7YuayeEBDLeSrhiQxo4QUU6JLYN9Vx7tMQ/Zz+Wtrqbg4RBb56dEO6plNjhpYAf5qAOi
         TNQVuCCqFv65Gz1whJNM4NPgLTOPKHQ6KET8IurwNW80Aw6j6V+p9afg9d34cCA+PEGM
         8A4w==
X-Forwarded-Encrypted: i=1; AJvYcCWKuwEuVboVJT6VUJt8MB82v2f5huqAvDLlAPQGGzs0h3YgmNmx8Ygz7FQ54421H6GU8YVBf+JGWmqBHmlMmm0A@vger.kernel.org
X-Gm-Message-State: AOJu0YzSYeH0zx+7EXI3CTuLDK8LjLyavHS8dyqVUu8J8/EqV80TuypG
	vABP64zaigYsaE/BpGje1dhgK3LS3ROv3lwtSZ8waS7/LuP0MjPleKqNxlMTJkEvjM5SkYqOB3B
	e5WzfabmOnA==
X-Google-Smtp-Source: AGHT+IEiuNrfkGll/jw9TGPgzbkCABGR+L/ughckv4/H2YorryoqXMAe9/saT1zEWVT6iUHw7By6llK3W7B/
X-Received: from pjuq16.prod.google.com ([2002:a17:90a:d390:b0:334:1843:ee45])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f64b:b0:274:506d:7fcc
 with SMTP id d9443c01a7336-29489d71137mr45832845ad.6.1761328746916; Fri, 24
 Oct 2025 10:59:06 -0700 (PDT)
Date: Fri, 24 Oct 2025 10:58:38 -0700
In-Reply-To: <20251024175857.808401-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251024175857.808401-1-irogers@google.com>
X-Mailer: git-send-email 2.51.1.821.gb6fe4d2222-goog
Message-ID: <20251024175857.808401-4-irogers@google.com>
Subject: [PATCH v1 03/22] perf metricgroup: Missed free on error path
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

If an out-of-memory occurs the expr also needs freeing.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 595b83142d2c..c822cf5da53b 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -1455,6 +1455,7 @@ static int parse_groups(struct evlist *perf_evlist,
 
 		if (!expr->metric_name) {
 			ret = -ENOMEM;
+			free(expr);
 			free(metric_events);
 			goto out;
 		}
-- 
2.51.1.821.gb6fe4d2222-goog

