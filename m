Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F63A142E7C
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 20:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209773; cv=none; b=CApwkVTVoshHWx5aY28Cz7htlZVj7FVMUoF3F85nK8aZ5+qXSEIf7Z+622An5nf6OYFKfxm4B5Zq+5BEWjGM23l5+1CHP62G4LyPV1vrW5/anG9W60N5JCh5O6b2a3/9mkcwNfBaxIfnVOZNBKrTFQAbgRpLi22NSe520fKl5rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209773; c=relaxed/simple;
	bh=PtX+W/q3gJmCuugsS+94q7mw5XIB5HE5Wl91R6OdMX0=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=an3uy5d6pqflg7iis1qg+YpiQxJQJkeb+kRQShBumCRO7WOtZc4bKkOmf1RmOtbq8xw2ubBM3BomF0QCp76Gofl6kffwaTJyaJb8SY265vmqWpaIsVz+x9kltzH76jIbt8TmVyUZK2YyE+SRICsRSBonbWWpoUapeSNBjl/W0zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iz6/liMk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iz6/liMk"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d54ab222fcso124192537b3.1
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 13:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727209770; x=1727814570; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1HkuesZQ4Zi0pHjkOZXlLb37KFxnICByhewLIZRfLio=;
        b=Iz6/liMkgwIfOCOpGfCFnyMenPqt0gE+HVR1IVDIkdtdRm779c8v6WoK79+YwWUrHV
         JIfCQAxwcY3vFGAu5Izxn9eNs1OUntpA6rIxr0+xlYFTjFYg66lkCG5WGysY9Q8ZIiXA
         5weu5aNPpqFRY2sDaoIB6joCMI77yEhRchu0R5/FleGiOof1ukCOQGvOREgS12oEH4wP
         hhvyOG8HsibhIqrKM/rc4n8owXi2mxMAr/rwb4mb00luvtrxzU+BEZiQzoXvUClFqFSv
         UNeKhrxuxdAAJdUaNycAlkH4l7PNNKsv/RjkKTbMSJiVIHeYM2W1YlAPbB7hQEJ4E48x
         1tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209770; x=1727814570;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1HkuesZQ4Zi0pHjkOZXlLb37KFxnICByhewLIZRfLio=;
        b=tUoUX3C8wqcGQbWWSuN4tcn8kZWgb6h1kcwBWsYMamYoMn4QAcOyB88jF+ulsbqo5D
         EuAP2XrfhdoluZd8sxyF5aM6+HBiGXOBFbNevakZ0Z7+GtARdhpmqBST5gIuCSEvV8ke
         dN+1Pl5SpIh5L/lRjePrHVgIdem8921JknZpO2PSxDnHKKUnuL/OHxi8n26oLfzyJFS9
         T07Kfw+Pgv/fsjHWUYQHYNVBrLltAn9ehU/vidwT9GlhQMUJUmdTDxmhYrSoNbeaXEmQ
         0Oc+FF46X44kocRsidK4zgfT3uavr5JVt+ATXXbKBccKdzTxIahzLllLTaYiKXegWyYx
         +H7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbdDA7vTcDQoB3Z0Jbc8eNsBtbJLKB7NMTLObBq/wN7Au3fEfI2ir7eUY16bcTvfWEwSSo4h/+NNOxEQFko3EQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxIAXC0b7ozeOJ02ZYLJ5nqmGHS/ExGWa5fsSPyoYR5KtGcR1Fs
	m93uFTsbs1HhEveg5JL9IvhYSNTI8RPpDMPzZ+U6QTnGB8v1qKWxI+a4PKr93izd80FHIqsUls1
	LlbUzEA==
X-Google-Smtp-Source: AGHT+IFpEMC8996EAOgp99APVUdgRySmVJIIuwrUW6GaJ2VCURhl5BXQCDxBVH1gzO4Fxy5MmO2Hz2pgRyo4
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:965e:4297:88a9:5902])
 (user=irogers job=sendgmr) by 2002:a5b:90f:0:b0:e22:5bdf:39b4 with SMTP id
 3f1490d57ef6-e24d7544bffmr339276.2.1727209770308; Tue, 24 Sep 2024 13:29:30
 -0700 (PDT)
Date: Tue, 24 Sep 2024 13:29:16 -0700
In-Reply-To: <20240924202916.1560687-1-irogers@google.com>
Message-Id: <20240924202916.1560687-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240924202916.1560687-1-irogers@google.com>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
Subject: [PATCH v1 4/4] perf test: Skip not fail syscall tp fields test when
 insufficient permissions
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Clean up return value to be TEST_* rather than unspecific integer. Add
test case skip reason. Skip test if EACCES comes back from
evsel__newtp.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/openat-syscall-tp-fields.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/openat-syscall-tp-fields.c b/tools/perf/tests/openat-syscall-tp-fields.c
index 888df8eca981..3943da441979 100644
--- a/tools/perf/tests/openat-syscall-tp-fields.c
+++ b/tools/perf/tests/openat-syscall-tp-fields.c
@@ -40,7 +40,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	int flags = O_RDONLY | O_DIRECTORY;
 	struct evlist *evlist = evlist__new();
 	struct evsel *evsel;
-	int err = -1, i, nr_events = 0, nr_polls = 0;
+	int ret = TEST_FAIL, err, i, nr_events = 0, nr_polls = 0;
 	char sbuf[STRERR_BUFSIZE];
 
 	if (evlist == NULL) {
@@ -51,6 +51,7 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 	evsel = evsel__newtp("syscalls", "sys_enter_openat");
 	if (IS_ERR(evsel)) {
 		pr_debug("%s: evsel__newtp\n", __func__);
+		ret = PTR_ERR(evsel) == -EACCES ? TEST_SKIP : TEST_FAIL;
 		goto out_delete_evlist;
 	}
 
@@ -138,11 +139,21 @@ static int test__syscall_openat_tp_fields(struct test_suite *test __maybe_unused
 		}
 	}
 out_ok:
-	err = 0;
+	ret = TEST_OK;
 out_delete_evlist:
 	evlist__delete(evlist);
 out:
-	return err;
+	return ret;
 }
 
-DEFINE_SUITE("syscalls:sys_enter_openat event fields", syscall_openat_tp_fields);
+static struct test_case tests__syscall_openat_tp_fields[] = {
+	TEST_CASE_REASON("syscalls:sys_enter_openat event fields",
+			 syscall_openat_tp_fields,
+			 "permissions"),
+	{	.name = NULL, }
+};
+
+struct test_suite suite__syscall_openat_tp_fields = {
+	.desc = "syscalls:sys_enter_openat event fields",
+	.test_cases = tests__syscall_openat_tp_fields,
+};
-- 
2.46.0.792.g87dc391469-goog

