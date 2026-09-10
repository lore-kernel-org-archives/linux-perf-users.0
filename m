Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C6D569F11
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 17:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061861; cv=none; b=NjaYnZIC/zF4dzYssh6mfXdmJT8JqlJZXQ+8cMMuaFlzMETpKadMTut00hOqzxCrfSufk0v5mnAnvEKK9yuS1facUM3KtNnSqYuwYqm45r3zpMp5AQGNt6R2JUo33pgrBCf75Wh3xo0gtu9dq6ReHij11rx1AcYlPGgnOPBHPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061861; c=relaxed/simple;
	bh=bsg/VePzOz1lxM8CfGsZ2ouP6WK2qYLF+kdJw+NDm1w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Y7XJlSpWfDtP394G+bcq/4wILyvTo+Sr9cRd2d82F4F/mrnGnB2YQyCQRrwUYHkDSMIr8wZDEybZFcbOcI6vP5nyOBPc2bKRWxVzPaVWSi0HWuE7l9tOf2IftqUBH4bs9tgtDe+2/y//fhvDjjRwOOEw433k1whQeRpGkYSX0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=THlZYpmz; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="THlZYpmz"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3823dcc1647so9164839a91.3
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 10:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789061851; x=1789666651; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alJIg6NFHmOIfLpqOpn9VCme24M02xLRvisdX8Uz++w=;
        b=THlZYpmzrsI3zg4fJHyHsc/tYIuSLGqVKRy8iDB0tU1fOzZ8DZxCZmxOGm2KpjOnPA
         XR4ROhEt9dKvrim7HWwB6StnreDSXkwS6ygpf1SaMSfFxyQlZ+dGI6RvALvbm81rDfYO
         UWr/O/cuOJN//oWlC0aMc0mWvkNfrRIT193X/P1BigocE2uQvCDaYibgtL5mNiqpwRLv
         TzIOjWl+mEA2O69whxKc2v7bQvaJT+3HtDWCPtJxwYv6f+LH+lKWMLxceuv9hj1V8A2C
         4jo97AFLZwiJc0c1yM6CODOjwBIJ6ro9roJVoi7s3VZvewU+j/5ytSCWqiybX1vQHzNX
         FOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789061851; x=1789666651;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=alJIg6NFHmOIfLpqOpn9VCme24M02xLRvisdX8Uz++w=;
        b=g4Wrg64HCJiZW5vfsipHhVtIkg1v+tgPyO+ia+8t2JYk7UE/VDP5EpyxB5Ymixd8ER
         NadrNkcJNTSneuPw3UsvRH9rb5PfqRBzThMz1zM+BHcPYf9Kbt9A7AJrqgfptx7tJdk6
         Jd5Huz32Rdj+mnT42RQv1bo46aQQR6w2MMq6X72bU7SRxMGrtPs6Q0KPvVqjSCuQrX/6
         VGN1I6Q67gKzl8pKPNDXKVCJIOvDUEyR7Ql9UwRJw3NxN+GNYgjXHVz7u4X/ZaVlahjB
         D19iTLbSwB1FdRfhmRVUGOy7Z70oumymUWoNPgBowxHXqmqOc8Z6qcDWTLkxn4iX6eIM
         M37w==
X-Forwarded-Encrypted: i=1; AKwUvByFSW6T3hl3ysyppH4kuPTqrHcsQsXcozdGR6cdUZiZrP0DqujxTjd7GoURD0XTQKQ6zuzKfTGE/A5PIfxnteha@vger.kernel.org
X-Gm-Message-State: AFuF++mwuldsceZ5hV95sZ/Ir0PJZVRx+Lgyym9fSDKfG4SA0m8qraRQ
	rYh8bQpqitrFBGK9S48yk5dQQlN0mF9IJFoeoS0D0osTctsjXSMQxopl9vrGqPXhXCBeUHNlTLy
	ZACmBxP4EgA==
X-Received: from dlee1.prod.google.com ([2002:a05:7022:6281:b0:141:5987:7f07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d44b:b0:398:bee5:61d6
 with SMTP id 98e67ed59e1d1-39b26252edamr68840957a91.24.1789061850497; Thu, 10
 Sep 2026 10:37:30 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:37:15 -0700
In-Reply-To: <20260910173715.2996571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910173715.2996571-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910173715.2996571-3-irogers@google.com>
Subject: [PATCH v1 3/3] perf header: Transition WARN macros to debug.h equivalents
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Avoid a checkpatch.pl warning on the use of asm/bug.h by switching the
use of WARN macros to explicit tests and then using pr_warning from
debug.h.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 78b16a098148..a3e6c334a289 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <asm/bug.h>
 #include <byteswap.h>
 #include <dirent.h>
 #include <linux/bitops.h>
@@ -384,8 +383,10 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
 static int write_tracing_data(struct feat_fd *ff,
 			      struct evlist *evlist __maybe_unused)
 {
-	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+	if (ff->buf) {
+		pr_warning("Error: calling %s in pipe-mode.\n", __func__);
 		return -1;
+	}
 
 #ifdef HAVE_LIBTRACEEVENT
 	return read_tracing_data(ff->fd, &evlist__core(evlist)->entries);
@@ -406,8 +407,10 @@ static int write_build_id(struct feat_fd *ff,
 	if (!perf_session__read_build_ids(session, true))
 		return -1;
 
-	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+	if (ff->buf) {
+		pr_warning("Error: calling %s in pipe-mode.\n", __func__);
 		return -1;
+	}
 
 	err = perf_session__write_buildid_table(session, ff);
 	if (err < 0) {
@@ -1013,8 +1016,10 @@ static int write_auxtrace(struct feat_fd *ff,
 	struct perf_session *session;
 	int err;
 
-	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+	if (ff->buf) {
+		pr_warning("Error: calling %s in pipe-mode.\n", __func__);
 		return -1;
+	}
 
 	session = container_of(ff->ph, struct perf_session, header);
 
@@ -1108,9 +1113,10 @@ static int write_dir_format(struct feat_fd *ff,
 	session = container_of(ff->ph, struct perf_session, header);
 	data = session->data;
 
-	if (WARN_ON(!perf_data__is_dir(data)))
+	if (!perf_data__is_dir(data)) {
+		pr_warning("Expected data to be a directory");
 		return -1;
-
+	}
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
@@ -3714,9 +3720,10 @@ static int process_dir_format(struct feat_fd *ff,
 	session = container_of(ff->ph, struct perf_session, header);
 	data = session->data;
 
-	if (WARN_ON(!perf_data__is_dir(data)))
+	if (!perf_data__is_dir(data)) {
+		pr_warning("Expected data to be a directory");
 		return -1;
-
+	}
 	return do_read_u64(ff, &data->dir.version);
 }
 
@@ -4394,8 +4401,10 @@ static int do_write_feat(struct feat_fd *ff, int type,
 		if (!feat_ops[type].write)
 			return -1;
 
-		if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+		if (ff->buf) {
+			pr_warning("Error: calling %s in pipe-mode.\n", __func__);
 			return -1;
+		}
 
 		(*p)->offset = lseek(ff->fd, 0, SEEK_CUR);
 
-- 
2.55.0.1007.g17ff1f9808-goog

