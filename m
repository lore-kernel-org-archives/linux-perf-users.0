Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2385417F4E3
	for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 18:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720807992; cv=none; b=ttAv4RzxPTJH7Rh7jwOsvqlulJU0ZNBp2GvYi1PkrHcLYuQNkPdSf/+2hcjM09z9e6Wp18Qxse/hkc/jtdsl7ovB9xCKllavD2a/gfQFqF2jfQaIIO/jaOHmg2DhogPHe1RYZ2WUqcI4GQfQmzHNCkKw9y8R+2TrFC+zS9ZFG5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720807992; c=relaxed/simple;
	bh=sUheNSIamO8SvMj19zBLNxCVmjvlLRxDlh7AUAyjtXE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=mNUffRxU3nfUXObU1ZJKj4vhY7qWH9O+9OLd6vt0rpEbMOCp2azePLw7C4ilTS0cZ9TLZtiN505Wq1lcKYADLRCvLHd5JPbivP7Aoph04aF5q0z4N32D+V7j1MRtG3bkXqMDayEe+B/eRHyJLoYhsyPlWdiahFa/eNayum6XLYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SjQrw9WO; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SjQrw9WO"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-654d96c2bb5so38507547b3.2
        for <linux-perf-users@vger.kernel.org>; Fri, 12 Jul 2024 11:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720807990; x=1721412790; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=SjQrw9WOhPtCuoJDNhuMHweOV7gQ9mK7LuDbSS2TafyJHxozCGDaudmRZmuvbwNzkC
         AQJtP3//pCleloSeRtPxj3XZdKwarSMcNDYoIarIaEgdr96/GuEnD1zTnpCGFxyrmhl3
         2gCOkgXB7rqukJ2KBjxRGlRvoTAA6GdSoG9EYFsbWlsQvEB47dOfFV5MIDKlp4dAxfA/
         hTCCSuE3slbHIYE2aPyCAyaGw/AwlVdrVrX3PmxztJZl0qbizmktkBKJje/rNrUsjJND
         pjFp8zSSxAkTLqPtKwIL7XayZxHnxx4IQ01voSnVVxzd98/uNFMIIl7JuwCh45ja06uv
         5L7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720807990; x=1721412790;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DzgUQ0L67yHK9ZgYOmZnLIT3MZDT9EVRhOxDmj12OGQ=;
        b=tXp2DXPMvqmVQumIhKntd7RL9x20E5WCYMRVrWBzvGPaOfTWefniXkqTb/KKvSzJxY
         0zEb6SkwiltZeGGUgjkOKNiK1z6kmdtvxqHb6UWMTYyOB5tie48EuF7+gGytauNnWrbM
         pFoRqnVGMPQ0toNZtWfNhn0h68Zdr/pbA5iLSdCfY28TJRU7tWI6nMbYqy5dS9NtoeS7
         k278CShEdlQktvXt6+r3UJp8f8ktOHmAAxmVQiACXOK4OFFM0wboRtruPZI46wooUJRm
         McExhCMf9uUciyg+w0gO80rbjk5Yr9c7vqxogjDeikJAHQKylJzzgUjjGKJ9aINAbAqN
         ZsZw==
X-Forwarded-Encrypted: i=1; AJvYcCXvrryMmcb1G7njUii8/u8lVfZdVS+Z+x+Gew83jDhjHniRH4djU//kzbYjinzvEX3UOwQzBOYd5uI26QYrcD7GqYpvHPNfGSiUGe8WQPDn7A==
X-Gm-Message-State: AOJu0YxINR9LR8cFG08XoxDexj7ttDUFWYiq6WD+tt//mIZlJqqMEx0x
	oZ+O+SWYmWVObZJ/9JVmpWG+wiZZs2t06oQFfSj/9L05qkKoRcLRBveAk+6mnul8842XDKKdYs8
	WudYxyA==
X-Google-Smtp-Source: AGHT+IHiAKXzsCdcEZM+MFSDfgz1r4L7ozGy4B9BF+4puH4qqiiY89mJfDURywhS/WGVSxBcH3QuZhcuBDvg
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:2e7d:d47a:a0c6:e3b1])
 (user=irogers job=sendgmr) by 2002:a05:6902:188a:b0:e03:2217:3c8f with SMTP
 id 3f1490d57ef6-e041b035055mr23746276.2.1720807990114; Fri, 12 Jul 2024
 11:13:10 -0700 (PDT)
Date: Fri, 12 Jul 2024 11:11:08 -0700
In-Reply-To: <20240712181108.475336-1-irogers@google.com>
Message-Id: <20240712181108.475336-28-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240712181108.475336-1-irogers@google.com>
X-Mailer: git-send-email 2.45.2.993.g49e7a77208-goog
Subject: [PATCH v5 27/27] perf session: Constify tool
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
index ad5da61d2330..0c7cc092887d 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1765,7 +1765,7 @@ static int __perf_session__process_decomp_events(struct perf_session *session);
 static int __perf_session__process_pipe_events(struct perf_session *session)
 {
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	union perf_event *event;
 	uint32_t size, cur_size = 0;
@@ -2195,7 +2195,7 @@ static int __perf_session__process_events(struct perf_session *session)
 		.in_place_update = session->data->in_place_update,
 	};
 	struct ordered_events *oe = &session->ordered_events;
-	struct perf_tool *tool = session->tool;
+	const struct perf_tool *tool = session->tool;
 	struct ui_progress prog;
 	int err;
 
@@ -2245,7 +2245,7 @@ static int __perf_session__process_events(struct perf_session *session)
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
2.45.2.993.g49e7a77208-goog

