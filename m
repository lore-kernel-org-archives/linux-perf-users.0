Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555F7427A03
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 21:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789074776; cv=none; b=tmL4U5uucmIGXdukwKj4GBA9AhgkIAsaQjqTMMaZuAoSpGirz2v5W+30bi9jucPmKMxvsj/wbzSF+4tPgfAEOr2VPzeEx3v8Z5V6pt+S79fY4xG7+czzkjg6xMycoFxLU/HJFok6fbfXKjJvzwFasLypSjUJ7oO64xMPpuDN9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789074776; c=relaxed/simple;
	bh=pHmH4FKVoanWCsK6EvzxcfwQB0GYW9gq4JtV5uiHIwM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=QltgPrzO9Z/PoBaXfB/ovK81N/lirhpP5dbrXdbuwdPuxPqlfR6xu2DHaMlroLFHGmJtqhj2YEmpb4egrEDJz9JxJAqPdynu8mlyaY+av2Vu0uywiWMWGCRADSgD3tmWsmh0nQ0CGkZxcMoNy0myBO03IPO2qkov3bfA/h47JfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ae1y8A5c; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ae1y8A5c"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1ca15334cso338507a12.1
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Sep 2026 14:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789074762; x=1789679562; darn=vger.kernel.org;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BmuwdNR4NKfLQOl78IvOzdTNOGEQTEMkPYahKNXJxGY=;
        b=ae1y8A5cGiboZjuE9w7IHqGVAX3yh+AoiTAJZKHJJudD8gniefqgHkrYyqufYZPg5B
         CydwIuRRqZlAmOp02dqkzNm2uSDS08AaIqDBGvXSQcA3MHsj79R/lkQb799TdAwDLy9p
         8/EhdW1Nt3JIyCEain74Syv+shim9eCv9T/j7z0NDgQIYtddJmt1hG8s73uAnfbgwnor
         9slYUSpzEesRkPpNS/p/bRFh7Rc66DHhb7dJC7Oistwozxj7YtZlLaeLBETkmwoEslPg
         yqki1Ni4/ETj23ZhOkRgs7xAZz3LaNOeBYIhxs36e21zkW7zCCQI7e/6T5oFQIwshMUQ
         MGTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789074762; x=1789679562;
        h=content-type:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BmuwdNR4NKfLQOl78IvOzdTNOGEQTEMkPYahKNXJxGY=;
        b=LkA+GvDeu7jtpD8j81g2mMc0+L91JqZNQLGpRtE6RYrKtmR72BKAV6tp7QdL2LLkIi
         sLqKWtdwcBVFyeOPsAHVhTkpnd0LrGMVEwrcMQo86fLOEBvZthMRVPfPhzp7LOMl7law
         sUKQI40AyKkLBGKA/aYvDjhakATc8gym8zzDh+Phbt0yYAnaaaUzhJKn94K/QIgz1vEK
         sp1ryBtYM8Jjori0Q37HdW6I423vQSHhO0BjURhHryRNH33R46bh3h+bLKSiU7sYy7bK
         DStCWan7tZOBAuxWFVeO06Rg4pzkDHeFi1FB4NLjsYeAQx99HhFzgrzTK9HnlvO5rqu5
         KWnA==
X-Forwarded-Encrypted: i=1; AKwUvBywbwpvTnm9vaLL1JxhiHm4vnML/rJtDhx/MUHGSjhsI7v57EY6V9MhCKrh8UXAu3RqfKO4Om5AvQEcSxB9Ajru@vger.kernel.org
X-Gm-Message-State: AFuF++nmFB5UKHVcRIh76hNvnDaeUn2P0oVk3E/1TbPqb2pjRwYKCclX
	0GBz8cbqs3HBDG+P+0wPTINX1pto0ihcl8Q6yKUY+ZjSCUhZdVeTYOyJbQBtHykq4DCf0FwNPiX
	tBI3CZYbMUg==
X-Received: from dlbdt18.prod.google.com ([2002:a05:7022:2592:b0:143:6670:4d89])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6300:618d:b0:3cc:f008:8123
 with SMTP id adf61e73a8af0-3daed153d75mr1559765637.8.1789074761613; Thu, 10
 Sep 2026 14:12:41 -0700 (PDT)
Date: Thu, 10 Sep 2026 14:12:20 -0700
In-Reply-To: <20260910211221.3154261-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260910175634.3014018-1-irogers@google.com> <20260910211221.3154261-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
Message-ID: <20260910211221.3154261-4-irogers@google.com>
Subject: [PATCH v3 3/3] perf header: Transition WARN macros to debug.h equivalents
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
index 0a4236fc0293..c7f2c29f02b0 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -8,7 +8,6 @@
 #include <stdlib.h>
 #include <string.h>
 
-#include <asm/bug.h>
 #include <byteswap.h>
 #include <dirent.h>
 #include <linux/bitops.h>
@@ -385,8 +384,10 @@ static int do_read_bitmap(struct feat_fd *ff, unsigned long **pset, u64 *psize)
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
@@ -407,8 +408,10 @@ static int write_build_id(struct feat_fd *ff,
 	if (!perf_session__read_build_ids(session, true))
 		return -1;
 
-	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+	if (ff->buf) {
+		pr_warning("Error: calling %s in pipe-mode.\n", __func__);
 		return -1;
+	}
 
 	err = perf_session__write_buildid_table(session, ff);
 	if (err < 0) {
@@ -1014,8 +1017,10 @@ static int write_auxtrace(struct feat_fd *ff,
 	struct perf_session *session;
 	int err;
 
-	if (WARN(ff->buf, "Error: calling %s in pipe-mode.\n", __func__))
+	if (ff->buf) {
+		pr_warning("Error: calling %s in pipe-mode.\n", __func__);
 		return -1;
+	}
 
 	session = container_of(ff->ph, struct perf_session, header);
 
@@ -1109,9 +1114,10 @@ static int write_dir_format(struct feat_fd *ff,
 	session = container_of(ff->ph, struct perf_session, header);
 	data = session->data;
 
-	if (WARN_ON(!perf_data__is_dir(data)))
+	if (!perf_data__is_dir(data)) {
+		pr_warning("Expected data to be a directory\n");
 		return -1;
-
+	}
 	return do_write(ff, &data->dir.version, sizeof(data->dir.version));
 }
 
@@ -3715,9 +3721,10 @@ static int process_dir_format(struct feat_fd *ff,
 	session = container_of(ff->ph, struct perf_session, header);
 	data = session->data;
 
-	if (WARN_ON(!perf_data__is_dir(data)))
+	if (!perf_data__is_dir(data)) {
+		pr_warning("Expected data to be a directory\n");
 		return -1;
-
+	}
 	return do_read_u64(ff, &data->dir.version);
 }
 
@@ -4395,8 +4402,10 @@ static int do_write_feat(struct feat_fd *ff, int type,
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

