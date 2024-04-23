Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4371F95A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 04:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713846386; cv=none; b=KWV5P3v3is7OEW3xfixMeb9FTByIVJipH392CoWXQyJSuXO1DIvNwlfuQy3I65So5nl8P0a/OU3TweU0BARzi9QVa55ZPDrVVJtGvIaXTpp10mCHg7aAa8ihg0YhndstKTdhXls9YETXCDBJM5o0kg0hLEjXvfK/m+ZSEilWVwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713846386; c=relaxed/simple;
	bh=yUjT8P/u/B1NvSyqFF6Xe0KfOnvdIqmsfdBBhuufJoU=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=etyegENHb87h9BahzFaCOZ63MxsJ8bXiUQ0wKPv4tWNnjAYHFn+YKtjtBNlxTSZQaZ0JDX7ri8Rr/78ch+1jrqs9UbBwnjDMGijG77CXKmmVBmZXsgzAISrEQTidAHYGFmAD7Gh9P++kmw/P1bC8+z0TOedq3ebFvMU+ogmb+iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OtzGqESa; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OtzGqESa"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61b32e7f94bso81965307b3.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Apr 2024 21:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713846384; x=1714451184; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=egW6wC7a2vf04dYdvmCm4HwIn7PFhsPkwsZotZmHl6Q=;
        b=OtzGqESanv53dJ+T/LpOF3iw+aGXqSVQH8ZTb5zfOja8Y+Xbd77jDb94XUo7Sp2uiV
         9cfYaHrD+SnyLXodHi5X7Hdqc5UWhZL4PchYHW52eMtW9ab+Z+4+HjoBisVgi80aO/Xv
         EFVFnCjLrU6nAAZNJfn6KK7OkBQsDg/+DtIcmhlVk2IkIimAnjTiGlVwFAevi6fVrDDK
         eKqYvokRc5xAinT9kU1+urn61jNL2R6Ok0/80M8EllxJQIlHsvqilN+r2ch3BqDbVQ3O
         zbTPiO1Pd64iEf+iPvNKWnRWPS1I+rfyavmLz8Gj/7iR0hIdfxZv4s+Mcmq5cNg/Oi9a
         b8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713846384; x=1714451184;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=egW6wC7a2vf04dYdvmCm4HwIn7PFhsPkwsZotZmHl6Q=;
        b=Mbiu2bEvAoH/Oh26Lj97jq+mUtQ5vsNn6yBaoRFHb/GQ2ipfF92aHPHQo37tbMf4tz
         9jStdg6Vnhz62WN8QOerirEBrkWweRYNrVgda7qKEYpbI5NAHPozuZoqUZWq+TGuxQ4b
         hbeDxgSFxRujbo1+jxzrRpgb8xTpa4dQFr/w52ZQRZXJKx8suXpDURH5xca+xyCKi7OG
         bHTeWTWL4eV5REzWdP1g345Arf6YFQ7MjBtr7vFgLXXM79Voq25NISAppmUJixC0D2Jz
         cVOx8EkGJpLRenzSo2Cqj9Zh6SQAg3eh5MDK8fHiIq6o/BBWTymA6S4jpLlFxGQQhNwP
         vn2A==
X-Forwarded-Encrypted: i=1; AJvYcCVHePpv6h6sRfkBxvjqfEWqRbd9GYAmZR8P4SmU/Au2DqAEaXD4SMWYDfu3vLynT+ud5hjrui78TQ+hnjV1YNDGTa6QNKDQYd+x2Q7iY1G/tw==
X-Gm-Message-State: AOJu0Yw50C/NMDULxZVtzttdwZg+tesQzbTbLEqO8fOAnrZlxZ2eIX0E
	DvwyFMIX+9q/Xcz7AQvocAf+Ara09IUcYjUipeoAYTqLydNqQbaMEcIcMB1oax0U7eZoTIet9iX
	nsnOp1A==
X-Google-Smtp-Source: AGHT+IE2os1+HQ2OZb9YCFhvP3ZM+TYfxKBgk8bo+cQsRHum3506ljwIH0nNK+Q1w0VLHS+2OVWiaW6nvwxU
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:4ca4:4d48:a7fe:d70c])
 (user=irogers job=sendgmr) by 2002:a05:6902:709:b0:dcc:c57c:8873 with SMTP id
 k9-20020a056902070900b00dccc57c8873mr3981086ybt.9.1713846384089; Mon, 22 Apr
 2024 21:26:24 -0700 (PDT)
Date: Mon, 22 Apr 2024 21:25:56 -0700
In-Reply-To: <20240423042601.2009469-1-irogers@google.com>
Message-Id: <20240423042601.2009469-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240423042601.2009469-1-irogers@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Subject: [PATCH v4 2/7] perf dsos: Remove __dsos__addnew
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@arm.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	nabijaczleweli@nabijaczleweli.xyz, Leo Yan <leo.yan@linux.dev>, 
	Song Liu <song@kernel.org>, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
	Ben Gainey <ben.gainey@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	Changbin Du <changbin.du@huawei.com>, Andi Kleen <ak@linux.intel.com>, 
	Thomas Richter <tmricht@linux.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Dima Kogan <dima@secretsauce.net>, zhaimingbing <zhaimingbing@cmss.chinamobile.com>, 
	Paran Lee <p4ranlee@gmail.com>, Li Dong <lidong@vivo.com>, 
	Tiezhu Yang <yangtiezhu@loongson.cn>, Chengen Du <chengen.du@canonical.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Function no longer used so remove.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dsos.c | 5 -----
 tools/perf/util/dsos.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
index cfc10e1a6802..1495ab1cd7a0 100644
--- a/tools/perf/util/dsos.c
+++ b/tools/perf/util/dsos.c
@@ -341,11 +341,6 @@ static struct dso *__dsos__addnew_id(struct dsos *dsos, const char *name, struct
 	return dso;
 }
 
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name)
-{
-	return __dsos__addnew_id(dsos, name, NULL);
-}
-
 static struct dso *__dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id)
 {
 	struct dso *dso = __dsos__find_id(dsos, name, id, false, /*write_locked=*/true);
diff --git a/tools/perf/util/dsos.h b/tools/perf/util/dsos.h
index c1b3979ad4bd..d1497b11d64c 100644
--- a/tools/perf/util/dsos.h
+++ b/tools/perf/util/dsos.h
@@ -30,7 +30,6 @@ void dsos__exit(struct dsos *dsos);
 
 int __dsos__add(struct dsos *dsos, struct dso *dso);
 int dsos__add(struct dsos *dsos, struct dso *dso);
-struct dso *__dsos__addnew(struct dsos *dsos, const char *name);
 struct dso *dsos__find(struct dsos *dsos, const char *name, bool cmp_short);
 
 struct dso *dsos__findnew_id(struct dsos *dsos, const char *name, struct dso_id *id);
-- 
2.44.0.769.g3c40516874-goog

