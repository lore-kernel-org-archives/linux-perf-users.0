Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A6A19E81D
	for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 20:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723495708; cv=none; b=pSvNDin0+0oPEqYaSeUT71vhwVmYRdvOB1OiY+H0sbNC+IZWWnh2W6ZIPoAmWUkMDs45GuQEf/lj4kap/+rkuvV1NODKLstDox4rRBEfP3DdTAfdb1oqoTWUdeddSxwt7/Z9dphlFNHcrrretl3MG3eWUYsIkCcWnvbx2zlbdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723495708; c=relaxed/simple;
	bh=cov7foVGktnTU+1VpOC6fkSOoDWyjnwMmCK5fmzw0ek=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=BLvp0nsCJB6Gu2GS4gJGoF4huK3Gc8b7bTH7D5MIkfkQyaEsMLpMh2FYEEuUdSlmoXez0jL5a1J/clevqj4w+Q9UGjpIUZwUyOf6rPv/ibZ9kqtfqxz3ZCWexDCbR6pbxPjMpbgVJINfc2X1kxSnT2TLY6BUt424vZYM4TkQzWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VDWH2Ojr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VDWH2Ojr"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e02fff66a83so7839642276.0
        for <linux-perf-users@vger.kernel.org>; Mon, 12 Aug 2024 13:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723495706; x=1724100506; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4wczZj/G5PmxA13DCbaUvl0QUyy3P1R91oRL5UB3198=;
        b=VDWH2OjrDzPAhvhFPrf5ludUp1YB5nxRvb02hug33xWji/hYm3p7lZsLi1aeAyU0gC
         xaHsR+E7+52rTrRzF8Cs3sYk3P1vbokXBQb8C7cxMypxTmdKMndEHBBg8dFILauFaGcQ
         vSM58U3+M3YH5TStvmT4VnoBzxWf1I/ltpfNIP3lTA20SNRukTz9VjYwRAFww79DWYGq
         NxUTulnq5UNdOFWKre0xbtB7YlzxuDx878/V3ue8JVcxZFNlwH6eb62Oh+iHee7dHO2Q
         wv7Hv5Vbt0fmFRv9sldn0l3AIP0uf9OcdoqW98OXF6SZasgU+mnS0WthRHFTbmaGm+kJ
         0dwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723495706; x=1724100506;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4wczZj/G5PmxA13DCbaUvl0QUyy3P1R91oRL5UB3198=;
        b=TIQo66QguG4ApnXkpHPGEqoWBP20ud7pQJFmBAFd6AU24peQiqLYKdLn5+38uGZt3D
         n1RMUJs9ttPiLqXUMc57xnTT2Ue2N9XCXqM4//AaOReyj4czaAdlOlXBT6ncLZ2PDQCJ
         09ndtcD4BQpJwpfJmiO9FJBjvgOOtO2pKX+m9a0ntkjDpB8RVw48vKjCHR4uECtp7x8J
         UJCgt9r/O87UGyO6K+nipvOXWPngty/jWDqagcuH+nOcgeyK4tLCzPH0+sdNnihqWABA
         403e/LnUlcU3z0Utu9JwJkyLQAKDi3lr/B0Ivrag+khftcYHjaoMB0Zw9YY0fR3TLqjY
         6ifQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoQqkzBMoSRr2ULjFh5gemveaWmJKmXCKJptyiWhHLplmrr98WxUtbE1ZPXDxkWmZwZfJ1BpPt8+F0l8LPMtYElLRUgUQqMmgikT5MR22soQ==
X-Gm-Message-State: AOJu0YwIRdox3IGTDLqzot3i/wnmjbCiDAqBBiQZa5SX0k5DEXqRXCaU
	wHvTL/405XOw4Im2GXt77EAK/ZxPFRLwGi5zxNlq6ua+Z5m+tdEtMX6y3R2C3NzeZAodtkpIctf
	ydnOkxQ==
X-Google-Smtp-Source: AGHT+IEEkdfVbmMdg47zJ1xwMISs3qxpK2W4sG4GNErhBkvDAcSIFEm9nvYqC0j8/UjSL/PUOvwkYvjYDWoT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e7f1:b90:720c:35bf])
 (user=irogers job=sendgmr) by 2002:a25:f30d:0:b0:e03:59e2:e82 with SMTP id
 3f1490d57ef6-e113d27c9a9mr2472276.10.1723495706163; Mon, 12 Aug 2024 13:48:26
 -0700 (PDT)
Date: Mon, 12 Aug 2024 13:47:19 -0700
In-Reply-To: <20240812204720.631678-1-irogers@google.com>
Message-Id: <20240812204720.631678-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240812204720.631678-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
Subject: [PATCH v7 27/27] perf session: Constify tool
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
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Yanteng Si <siyanteng@loongson.cn>, 
	Sun Haiyong <sunhaiyong@loongson.cn>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Make tool const now that all uses are const and
perf_tool__fill_defaults won't be used. The aim is to better capture
that sessions don't mutate tools.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/session.c | 6 +++---
 tools/perf/util/session.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index a8404cc99cfc..d2bd563119bc 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1770,7 +1770,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
@@ -2200,7 +2200,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2250,7 +2250,7 @@ static int __perf_session__process_events(struct perf_session *session)
 static int __perf_session__process_dir_events(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	int i, ret, readers, nr_readers;
 	struct ui_progress prog;
 	u64 total_size = perf_data__size(session->data);
diff --git a/tools/perf/util/session.h b/tools/perf/util/session.h
index 7f69baeae7fb..7c8dd6956330 100644
--- a/tools/perf/util/session.h
+++ b/tools/perf/util/session.h
@@ -43,7 +43,7 @@ struct perf_session {
 	u64			one_mmap_offset;
 	struct ordered_events	ordered_events;
 	struct perf_data	*data;
-	struct perf_tool	*tool;
+	const struct perf_tool	*tool;
 	u64			bytes_transferred;
 	u64			bytes_compressed;
 	struct zstd_data	zstd_data;
-- 
2.46.0.76.ge559c4bf1a-goog

