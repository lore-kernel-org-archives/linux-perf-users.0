Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3071917920E
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 17:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336380; cv=none; b=CvOLfbXvrr5A24RVTqt+IIvSVyG/dI2o9Cy/E9PdRJfNlD1hDxn46cOjOZV+h6qR86JMCAjZwb+l9szqifvtDnQYh+lUdJ4ZjLIx113NTkpzRTga1hIkykyMhhmRk169K7PQVlz8Y7MZttKJ/uxDWzDCBr1Ji1j62yXS8E+xKck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336380; c=relaxed/simple;
	bh=tz6IrydlIAL03yTzezHDaA3gvT5YEyeJ8FoCdimUD7E=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=MaFlwJNor1/5lpr5eLnYuHwQW2VKDnhjkVFhxQTQUYduD5LQpEkfzjv7CN7PRX//jtLFUKDG6Z+xc9rw4K0m156wxHtTbJc616K/wYABiS8/3pHrwyJzATOfGQ6TrAS3b1tuZckJcbJxkDuFg0HlxzmtS544l8wL/Vg/2r7ssbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUGMErYO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUGMErYO"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso10644370276.0
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 10:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719336377; x=1719941177; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xUgjNt0xneeMqPZ/Mwlp/Zt17wNAbGBqOmTw4fJjROQ=;
        b=jUGMErYOtibhQ3eESlX/+5BJGC53os5kPbZTQztyOWsx2JEu9POmamynz7huLsn4c6
         fcsa3B/RehoRTqYKUItxXnpBF8xDR4pc48sVhUVyyV7vTM/X0BCMWUoxkgc8dvnufy/S
         JHjbWj+U56VL/QrrJcf+YRcoOymX3S1279P9GE3MK6QFAmbH48sBuxaz/ULsTXZ+vZyH
         hl4pQuAhYM5X00EwLkT/NVajKRBYGbv0JpgS6b1iIyo2BWXendY1sDG7QCMxir4sfneX
         frIcAAd1xLlc70ndfUnis1YrEds73pTZBfQSgb44EYsLOIJoI8mia9ZSbRJmy3lIRBEP
         0ZBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336377; x=1719941177;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xUgjNt0xneeMqPZ/Mwlp/Zt17wNAbGBqOmTw4fJjROQ=;
        b=DkyerP5ZGR8IXWKnwAL6CWzj0ASnItqs6WBID0w5cIQ6nvaNY3Xr+vERH+jB3M1Per
         saPGNi+xzyidphTpCYj74WnXrSdSeJxL7+38s648LS+lE0RLdACQdjOS0Kmn4U+KTcjz
         f8mVnbR83XmP5v7zaQa1pP1elwn4OWU2x21wwqySGAcdWBzPH+IO6bCTyX4oZw9rgl25
         NA6FK0pgQBtCQuUe+5gxq3IZpgOeJ6n6tS3nsnTGhVfQwFFKdIYIZwSVyefDXivJAC2D
         E5WKRTLmdgsgiec4/xL0S2glJOvbo+yUVq0WzXX29BEBKyY9IW3a9jQYXbgAnCyjFtFI
         ESGQ==
X-Forwarded-Encrypted: i=1; AJvYcCV5JREKXs3udhUy+XsEUkTMmvkwum0R/7fSXMABbQAxh2Y/P/LXwDr2EEUO9LDPzEyyfGB397wjftvOjYgTRKnrw+TRfQjm1rO9xzDJRaMbBA==
X-Gm-Message-State: AOJu0Yy88+R3hHaMzvs3fpWNFlxs/TRF9u1jxjRpOyNQy/Wc0cvLqF1g
	yH0j1VnAfw6i6HbuVfOEZakRxeOygzv/qAbVvR9rnLvFp0ImbGGhEvHJG3K05LlhawJvvGFIEsx
	h7I37RA==
X-Google-Smtp-Source: AGHT+IEug2riBjyQ5J5/zm+p50Ba9JZYc7CfD/IFxeRNPwpJVP3SLj0aXwP/kplaHWhb2QQb7pyYEG7HBm6P
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:b4cb:a52b:f9ea:8678])
 (user=irogers job=sendgmr) by 2002:a05:6902:f84:b0:e03:31ec:8a24 with SMTP id
 3f1490d57ef6-e0331ec8aa0mr2108276.8.1719336377155; Tue, 25 Jun 2024 10:26:17
 -0700 (PDT)
Date: Tue, 25 Jun 2024 10:25:41 -0700
In-Reply-To: <20240625172603.900667-1-irogers@google.com>
Message-Id: <20240625172603.900667-5-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240625172603.900667-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Subject: [PATCH v1 04/26] perf kmem: Use perf_tool__init
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, James Clark <james.clark@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, Leo Yan <leo.yan@linux.dev>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jonathan.cameron@huawei.com>, Nick Terrell <terrelln@fb.com>, 
	Nick Desaulniers <ndesaulniers@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	Anshuman Khandual <anshuman.khandual@arm.com>, Song Liu <song@kernel.org>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Huacai Chen <chenhuacai@kernel.org>, 
	Yanteng Si <siyanteng@loongson.cn>, Sun Haiyong <sunhaiyong@loongson.cn>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Reduce the scope of the tool from global/static to just that of the
cmd_kmem function where the session is scoped. Use the perf_tool__init
to initialize default values.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-kmem.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 859ff018eace..b3cbac40b8c7 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -986,15 +986,6 @@ static int process_sample_event(const struct perf_tool *tool __maybe_unused,
 	return err;
 }
 
-static struct perf_tool perf_kmem = {
-	.sample		 = process_sample_event,
-	.comm		 = perf_event__process_comm,
-	.mmap		 = perf_event__process_mmap,
-	.mmap2		 = perf_event__process_mmap2,
-	.namespaces	 = perf_event__process_namespaces,
-	.ordered_events	 = true,
-};
-
 static double fragmentation(unsigned long n_req, unsigned long n_alloc)
 {
 	if (n_alloc == 0)
@@ -1971,6 +1962,7 @@ int cmd_kmem(int argc, const char **argv)
 		NULL
 	};
 	struct perf_session *session;
+	struct perf_tool perf_kmem;
 	static const char errmsg[] = "No %s allocation events found.  Have you run 'perf kmem record --%s'?\n";
 	int ret = perf_config(kmem_config, NULL);
 
@@ -1998,6 +1990,13 @@ int cmd_kmem(int argc, const char **argv)
 
 	data.path = input_name;
 
+	perf_tool__init(&perf_kmem, /*ordered_events=*/true);
+	perf_kmem.sample	= process_sample_event;
+	perf_kmem.comm		= perf_event__process_comm;
+	perf_kmem.mmap		= perf_event__process_mmap;
+	perf_kmem.mmap2		= perf_event__process_mmap2;
+	perf_kmem.namespaces	= perf_event__process_namespaces;
+
 	kmem_session = session = perf_session__new(&data, &perf_kmem);
 	if (IS_ERR(session))
 		return PTR_ERR(session);
-- 
2.45.2.741.gdbec12cfda-goog

