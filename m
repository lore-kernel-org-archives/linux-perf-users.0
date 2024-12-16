Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9541DACBF
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 23:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734391510; cv=none; b=PKgt+iNGoYySfX9Kf1rOPAAnOqlD0lI1sXiA5mtTouAWNGvJQN2i6GaqBhMJk2CAyC0NEwR48dHlSQT7wNjKN9Ige/fl7/kkpNh/Ddfth3FtjZFYc+Bj2lbtdk6B2jFdDW2cE2nfrj4wspuZIW4fRi1ec9gdnquff/Pd6i8e1nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734391510; c=relaxed/simple;
	bh=WydwZX+4HGFs/roSNEAeN+iGcRwNyw0N9yYTQ/F7jhM=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ssgYEmdd1WFQjKZqJfilyT7wg1qxXzeMmAdivbXEhSkZLkZok+i7HcIl+uuBWcMrtzd2rPLwa5LwTqDzYvMTs5ucxgCSsHGTGKBykBacgaWywi9PnLru8Whu9OBXj7zooZvBKgrbVHbslSy/STyaVLfFLGnExeZ2zmdfhtcNrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lKwNvdUL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lKwNvdUL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6ef5d557d48so38333757b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Dec 2024 15:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734391507; x=1734996307; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hgXWFWdI7UOHyMHNmnwoqLPHk2iqhyZAlZkweGRato=;
        b=lKwNvdULgeVVEKuJjuRdUnPiDP5ZGXhfqDRmktuIHNEh+LSjuY9lOmuGJlvy5Sy5Pg
         P4LpK8TkrfQ7nZu5Omd/rzKcaacdAxNMZ3o160AB5YS7VglggSlvLTh3nzZzFvFb8eGs
         +smWkr4ucklys4g+3TB7RrZlTdQbkNfJiOEk1v182cqoWAiXR3nlAM4INebLNc1vZbip
         P9rsr8zebxcxixBYzSR6A2c+fzyKc84WK1mKAtP8aPvNoc8o89K8jkJfkYMe9W430KCj
         IgrQFwjIDR140F/UKUjUdCtxRnIplHpAzAOvY413yamaZ3O/nwt2SF080C0seY47QydJ
         DZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734391507; x=1734996307;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6hgXWFWdI7UOHyMHNmnwoqLPHk2iqhyZAlZkweGRato=;
        b=U1udGegIux+ZdpzpzXv4fGEof1VaYb4IBy/Gm2xjqMAPBgXeyU6JgM3+evCf7ekwJi
         C2gHBCkbQURisWG2s+dofKJshfNWz4M1+acrp9fxP0IU6+uQHxbhIxIuYZQbXvvmWXmB
         3tiabTuyO3CmVmRbl9rZIumTcHhXleykg2XEr5T1n3YyvM6LtJ2YfVv1QXkGxbXKQTQP
         3Rq8C23OGmr5gaFXSJNUDLWe9dlBxtrfQXjSEVOY/u/fqMoqwVMPkOdA6yWyPbDfFoqr
         S0+Rjp1zwmExypRMFhAT7YXqYavPaYas3WyCGUSERdW1tWNxL+a615q/1M/+qtfJNuy6
         eGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzcQcCL3kHziIpXxRdjoLebyOhpPTnlC1QCD72rg+g6gblLtFCQYnF+xrdhu3tjB91RE3QLdINzcG1uLsP6Ksi@vger.kernel.org
X-Gm-Message-State: AOJu0YyzCKIfcarn+0efWx3S/Kqzwgh+GmtsqX3Z3NyOHzhhAVZVPsyX
	97CUqbX5JX1JWstv6WctkYLS1kGEhGJzmhE3GJAaHX+B/G4ap5BJHCwXWn87OrNV335SHix6ayz
	9vYwa/g==
X-Google-Smtp-Source: AGHT+IF4D2bttv5je9lZXd0PUlFLBd/ZvIZtBFpxVXMbpi4Bzh0t/kD8FQb4ayA43zotqyhYA6l+KZfxh7L+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:b850:b916:18b9:17a7])
 (user=irogers job=sendgmr) by 2002:a05:690c:8282:b0:6ef:993a:29b8 with SMTP
 id 00721157ae682-6f279b85358mr113177b3.5.1734391507557; Mon, 16 Dec 2024
 15:25:07 -0800 (PST)
Date: Mon, 16 Dec 2024 15:24:56 -0800
In-Reply-To: <20241216232459.427642-1-irogers@google.com>
Message-Id: <20241216232459.427642-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241216232459.427642-1-irogers@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Subject: [PATCH v3 2/5] perf header: Write out even empty die_cpus_list
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

Reading the CPU topology is tolerant to the dies_cpus_list being
missing by using the feature's size in the data file/pipe. However,
the feature's size is just the header size and may be
unaligned. Making the header size aligned breaks detecting a missing
die_cpus_list. To allow the header size to be aligned always write the
die_cpus_lists even if empty.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 048e563069bc..03e43a9894d4 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -628,9 +628,6 @@ static int write_cpu_topology(struct feat_fd *ff,
 			return ret;
 	}
 
-	if (!tp->die_cpus_lists)
-		goto done;
-
 	ret = do_write(ff, &tp->die_cpus_lists, sizeof(tp->die_cpus_lists));
 	if (ret < 0)
 		goto done;
-- 
2.47.1.613.gc27f4b7a9f-goog

