Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A82D6E78
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033629; cv=none; b=Ol40tyc8pljKyRXdyefg6awoUZ0yghtplhA+J0hs5WClo+L6TY8i204NMUTbaJkvWZ8iH+WZZ5WmdV2R2AmMTtzSGTlZfA+cHEDbHFq1j/fAv0Uj2RKiQneCL5b7Qn/nRRlVe/VNM2jnPMWNhhTz2hDUJmszdQ4/Un5cQpguWy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033629; c=relaxed/simple;
	bh=X1MjIcGZucyzCm2r2IlBzTymaxjsdQoFFc+rtk3RK20=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=s0tVU8xv3r/2+NTOf5/xqx4xeDlx0cXRNO/bT7EGTplnPIXWBAVm808ZXBh5xDJv03uPQoNgFBLBHFz3g/Q+qg51SHjNICxC4SBhpXyGcnOQpR3xvxJSvvdmPGvrcGGqM9smj+sz32Bvp4011hSWmUIGuYpb7SuZPDzzRtqlJGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUb8wGM+; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vUb8wGM+"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ac363a9465so4126798eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 00:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033626; x=1768638426; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GeyCcyFu8+y/NnCQ7WsdxHS48sCTNn9MjknKssLg0z0=;
        b=vUb8wGM+CFbmthM8TckKZ9PYJN50ecvwCP9JOUOInjrK5PbVLd2MfhwPFdqZOs/0d5
         NeufndcmZwZopgEV6CWd+bmfUWiV8SBag/F+INL4GXoxHWWVPnKFUi3W1qUcoVNNIzoK
         VXcvrKSYsncBf2aa2FDcEfN63i14zsaNUWz5iCvVS+z3HZoGvSnMe2XB3xosoX6dzqgP
         BI4Qwgq7iIOf2oN8XKC121X3QEv9FdvIESwb5sDWW5b/blGNhjS/WfHT0HwULQLX2fTk
         QQPUThGScLQvZEE2E9tveBXk5Qi1+h/n4oqTXAEaOjaeKPNVOpz4yV31XrWvJ6ozISJF
         gvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033626; x=1768638426;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GeyCcyFu8+y/NnCQ7WsdxHS48sCTNn9MjknKssLg0z0=;
        b=Lea4SQkOAk2jcu627ngZYNJ60LNEzgiX3Zq6f1XX6yN0izz/ZqFntCpkaECm64wi6a
         iDuSRLfQO6DfaiheSlTIC/1Y0e2TgJLJQgL9Zb5zBRYywmCm4HsHRWBuk7RXY3L/W/I4
         ZVk3adXQipUegRc2Y/anaz+414yjBPSQUdmxih7dMsSvsW8j5LNQCCgUpMgD63b0Pv37
         1bNWoUIetQhgRw7TJKV70Jt9U6yhwY51UTMitgAbfev8Wjc8N3/vsMY5AY1bUyueGgMd
         I8dnk9T2jG54AFwTDJQug/cHBVPopz4LVvRqJqfH4kYs4Zd6pyyUg0oz4DCrxj1NSNEO
         bXbg==
X-Forwarded-Encrypted: i=1; AJvYcCWKWhI7Tw+c0IOw1CcqVOvUdrKYNIvbY0yoKF9BOw3cyfmX9SIjRfmtl4ziWVLGHozuPK6rJ3DSSKSSwCvtr5xY@vger.kernel.org
X-Gm-Message-State: AOJu0YyQW6xvyAOxGDeval/89P1MWf7vC1gWs0NnuUHdwevErdUe0ak7
	eW+Iefv08gMoBZEGKdh0uZ2s8pdm2fIcJ61mCyoceZH9JqRQLncoHRmk7JqGh+ldLXX8v3Z1Fe0
	0sOktxT9NdQ==
X-Google-Smtp-Source: AGHT+IFiNbZL8zBQ61wqoykyJMyxlzCNV4Dnpo+uPuFeWFdkSSYtZrTbTPhfi56pcUDS5JqF9yr4caC+R4C5
X-Received: from dyek19.prod.google.com ([2002:a05:7300:6413:b0:2b0:5041:8a8b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:8290:b0:2ae:598e:abe5
 with SMTP id 5a478bee46e88-2b17d321a6dmr6978326eec.35.1768033626253; Sat, 10
 Jan 2026 00:27:06 -0800 (PST)
Date: Sat, 10 Jan 2026 00:26:43 -0800
In-Reply-To: <20260110082647.1487574-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082647.1487574-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082647.1487574-3-irogers@google.com>
Subject: [PATCH v2 2/6] perf addr2line.c: Rename a2l_style to cmd_a2l_style
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The a2l_style is only relevant to the command line version, so rename
to make this clearer.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/addr2line.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/addr2line.c b/tools/perf/util/addr2line.c
index f2d94a3272d7..0f1499350d47 100644
--- a/tools/perf/util/addr2line.c
+++ b/tools/perf/util/addr2line.c
@@ -90,16 +90,16 @@ static struct child_process *addr2line_subprocess_init(const char *addr2line_pat
 	return a2l;
 }
 
-enum a2l_style {
+enum cmd_a2l_style {
 	BROKEN,
 	GNU_BINUTILS,
 	LLVM,
 };
 
-static enum a2l_style addr2line_configure(struct child_process *a2l, const char *dso_name)
+static enum cmd_a2l_style cmd_addr2line_configure(struct child_process *a2l, const char *dso_name)
 {
 	static bool cached;
-	static enum a2l_style style;
+	static enum cmd_a2l_style style;
 
 	if (!cached) {
 		char buf[128];
@@ -149,7 +149,7 @@ static enum a2l_style addr2line_configure(struct child_process *a2l, const char
 }
 
 static int read_addr2line_record(struct io *io,
-				 enum a2l_style style,
+				 enum cmd_a2l_style style,
 				 const char *dso_name,
 				 u64 addr,
 				 bool first,
@@ -298,7 +298,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	char buf[128];
 	ssize_t written;
 	struct io io = { .eof = false };
-	enum a2l_style a2l_style;
+	enum cmd_a2l_style cmd_a2l_style;
 
 	if (!a2l) {
 		if (!filename__has_section(dso_name, ".debug_line"))
@@ -314,8 +314,8 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 			pr_warning("%s %s: addr2line_subprocess_init failed\n", __func__, dso_name);
 		goto out;
 	}
-	a2l_style = addr2line_configure(a2l, dso_name);
-	if (a2l_style == BROKEN)
+	cmd_a2l_style = cmd_addr2line_configure(a2l, dso_name);
+	if (cmd_a2l_style == BROKEN)
 		goto out;
 
 	/*
@@ -336,7 +336,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	}
 	io__init(&io, a2l->out, buf, sizeof(buf));
 	io.timeout_ms = addr2line_timeout_ms;
-	switch (read_addr2line_record(&io, a2l_style, dso_name, addr, /*first=*/true,
+	switch (read_addr2line_record(&io, cmd_a2l_style, dso_name, addr, /*first=*/true,
 				      &record_function, &record_filename, &record_line_nr)) {
 	case -1:
 		if (!symbol_conf.disable_add2line_warn)
@@ -351,7 +351,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 		 * binutils, also force a non-zero address as we're no longer
 		 * reading that record.
 		 */
-		switch (read_addr2line_record(&io, a2l_style, dso_name,
+		switch (read_addr2line_record(&io, cmd_a2l_style, dso_name,
 					      /*addr=*/1, /*first=*/true,
 					      NULL, NULL, NULL)) {
 		case -1:
@@ -397,7 +397,7 @@ int cmd__addr2line(const char *dso_name, u64 addr,
 	 * as we're reading records beyond the first.
 	 */
 	while ((record_status = read_addr2line_record(&io,
-						      a2l_style,
+						      cmd_a2l_style,
 						      dso_name,
 						      /*addr=*/1,
 						      /*first=*/false,
-- 
2.52.0.457.g6b5491de43-goog

