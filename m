Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922F1B151A
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 15:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724943749; cv=none; b=LyaNpEmBx+6YWbh97uvN1fq1J5lo3wn9JDMAIp/uDg9+/UYgQq+Osw8CrThtg794A6cT58WmJiNFLa36CIk7uuY/kea20AVBJxuTASfSv4YQ3gzr2mS7LS+EipVAe8X203F9ICTICsjsjeu7R7nkyy2j+fMnTM8PxbI3kx/S9I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724943749; c=relaxed/simple;
	bh=BtmlMrMAHzQZUpmltBgdlhBhq2zYxwAKCQUSA4rmo2g=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Q91qyai99X3xaiRGqCD/692SwBh/g9qyEqqVdSAcHy4TOviH86jxRkQgEblSuqcmKYM3SvIZ0u4SCu4ZdmclsURw18jekov1BZKvesGJNABAT4hNDEdpgJH4dn/A+sfBnZnNbf8HYPHOWdlnHtxpzoaxdyf630W1m9yk80Sonkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z5oNuDS7; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z5oNuDS7"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ac83a71d45so12479577b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Aug 2024 08:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724943747; x=1725548547; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLDviNvuuZGMvTdlOAKtIuEnHhCZdbVpbH4SWUDE26w=;
        b=z5oNuDS7F98V0xuO+9yhd4e1FsIrneYbBnVYAYSrmJ/nXxtLN1K3grq7V5BRN3glSL
         GeDioxahrlMGB0Zm+HxEPMAHHngCrGdFCGBF+siDbm+UzFFDJvMJtKuMv2S44FRoCQyP
         a6EfD7Q5Opyt/egOxRSbW0/RRkYeWfWorQM3FY3OpO3fsosnMDiTD2XDvyuFWu7uLn2V
         16jf6ewvrliH7fqtXJCbjbyqxPGD/JETaEwpGnpUF0YWmLvGJxKE1cGaVFi1KYaOCjkF
         22Ml1PjOzVJ8xwbIe8Np3G7hBRrwm8UdnBleFRAZYBxLdMMCzCx/KkPHw+9pTvEwfnL+
         vn+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724943747; x=1725548547;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLDviNvuuZGMvTdlOAKtIuEnHhCZdbVpbH4SWUDE26w=;
        b=j3/PkHLM+2v5NxJgQXyUWYOxq13I7vVWSpnBKDE/0jIQIEa8OZ01tbEKICvOAiCMA9
         ePNbFwhwgZB/wPvRFmY1QSjucbvT+ht78zdOIVEdEakku8QbT+jL6SRA4HRu1WaGogQ1
         obeZyyB7twJEx/AG0xBr21FU1bd0vxRSpTcj8+HQnMm2PmZNSnIwpuo9TCFV2sgIQeMj
         SzCQYcIRzTxu8rXxF28ssVWp5RlwkE+y1b0wl1nIZKOiJDXxoEqL1QCfmr6Q3wvypa4S
         tIHONWFis+fTSW31x7myIeM5XJMN/AMzGPTbJQ794DRSxxrHkBTE7utYURoHbPp/fhkq
         P7rA==
X-Forwarded-Encrypted: i=1; AJvYcCVnDUg9bS4WwofUrgPA2VzTiuHVNK8dFDF1WTxadHhvb8Sgy2VzQ7gnYdksX+jy6Fbvp7esPj2vogGkXIZ7M41m@vger.kernel.org
X-Gm-Message-State: AOJu0YxwFRSmAPc2AaLrQBWFAwaQppOBfk1At1zSMmY8i+t47S0QjIn5
	LccWcxWntMwjUrOlb5W7qPj1QPsXlxMNvX2adBmUImISO1kUzcsuOxRtP0SFpdQ/zFxWEHJDPrm
	ZGoXLLQ==
X-Google-Smtp-Source: AGHT+IGwsMKtEw0yeh+uAV4sy4WEt9ZJVXFDo6115QZAyihbKw+75lOKL3DGWFgr6WL0lHHspaVfE7SuoQHu
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:e51a:f73b:d117:cb13])
 (user=irogers job=sendgmr) by 2002:a05:690c:6305:b0:680:cd2b:90ed with SMTP
 id 00721157ae682-6d2e745b27amr434437b3.3.1724943747495; Thu, 29 Aug 2024
 08:02:27 -0700 (PDT)
Date: Thu, 29 Aug 2024 08:01:53 -0700
In-Reply-To: <20240829150154.37929-1-irogers@google.com>
Message-Id: <20240829150154.37929-8-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240829150154.37929-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Subject: [PATCH v1 7/8] perf header: Remove repipe option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Nick Terrell <terrelln@fb.com>, 
	Yanteng Si <siyanteng@loongson.cn>, Yicong Yang <yangyicong@hisilicon.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

No longer used by `perf inject` the repipe_fd is always -1 and repipe
is always false. Remove the options and associated code knowing the
constant values of the removed variables.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c  | 19 +++++--------------
 tools/perf/util/header.h  |  2 +-
 tools/perf/util/session.c |  6 +++---
 3 files changed, 9 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 59e2f37c1cb4..a6386d12afd7 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -4113,13 +4113,8 @@ static int perf_file_section__process(struct perf_file_section *section,
 
 static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 				       struct perf_header *ph,
-				       struct perf_data* data,
-				       bool repipe, int repipe_fd)
+				       struct perf_data *data)
 {
-	struct feat_fd ff = {
-		.fd = repipe_fd,
-		.ph = ph,
-	};
 	ssize_t ret;
 
 	ret = perf_data__read(data, header, sizeof(*header));
@@ -4134,19 +4129,15 @@ static int perf_file_header__read_pipe(struct perf_pipe_file_header *header,
 	if (ph->needs_swap)
 		header->size = bswap_64(header->size);
 
-	if (repipe && do_write(&ff, header, sizeof(*header)) < 0)
-		return -1;
-
 	return 0;
 }
 
-static int perf_header__read_pipe(struct perf_session *session, int repipe_fd)
+static int perf_header__read_pipe(struct perf_session *session)
 {
 	struct perf_header *header = &session->header;
 	struct perf_pipe_file_header f_header;
 
-	if (perf_file_header__read_pipe(&f_header, header, session->data,
-					/*repipe=*/false, repipe_fd) < 0) {
+	if (perf_file_header__read_pipe(&f_header, header, session->data) < 0) {
 		pr_debug("incompatible file format\n");
 		return -EINVAL;
 	}
@@ -4246,7 +4237,7 @@ static int evlist__prepare_tracepoint_events(struct evlist *evlist, struct tep_h
 }
 #endif
 
-int perf_session__read_header(struct perf_session *session, int repipe_fd)
+int perf_session__read_header(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
 	struct perf_header *header = &session->header;
@@ -4267,7 +4258,7 @@ int perf_session__read_header(struct perf_session *session, int repipe_fd)
 	 * We can read 'pipe' data event from regular file,
 	 * check for the pipe header regardless of source.
 	 */
-	err = perf_header__read_pipe(session, repipe_fd);
+	err = perf_header__read_pipe(session);
 	if (!err || perf_data__is_pipe(data)) {
 		data->is_pipe = true;
 		return err;
diff --git a/tools/perf/util/header.h b/tools/perf/util/header.h
index 7137509cf6d8..a63a361f20f4 100644
--- a/tools/perf/util/header.h
+++ b/tools/perf/util/header.h
@@ -131,7 +131,7 @@ union perf_event;
 
 extern const char perf_version_string[];
 
-int perf_session__read_header(struct perf_session *session, int repipe_fd);
+int perf_session__read_header(struct perf_session *session);
 int perf_session__write_header(struct perf_session *session,
 			       struct evlist *evlist,
 			       int fd, bool at_exit);
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 23449d01093a..578010be046b 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -45,11 +45,11 @@ static int perf_session__deliver_event(struct perf_session *session,
 				       u64 file_offset,
 				       const char *file_path);
 
-static int perf_session__open(struct perf_session *session, int repipe_fd)
+static int perf_session__open(struct perf_session *session)
 {
 	struct perf_data *data = session->data;
 
-	if (perf_session__read_header(session, repipe_fd) < 0) {
+	if (perf_session__read_header(session) < 0) {
 		pr_err("incompatible file format (rerun with -v to learn more)\n");
 		return -1;
 	}
@@ -162,7 +162,7 @@ struct perf_session *__perf_session__new(struct perf_data *data,
 		session->data = data;
 
 		if (perf_data__is_read(data)) {
-			ret = perf_session__open(session, /*repipe_fd=*/-1);
+			ret = perf_session__open(session);
 			if (ret < 0)
 				goto out_delete;
 
-- 
2.46.0.295.g3b9ea8a38a-goog

