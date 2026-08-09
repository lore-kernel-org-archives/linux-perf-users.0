Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2B73AAF4C
	for <linux-perf-users@vger.kernel.org>; Sun,  9 Aug 2026 07:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786259709; cv=none; b=DGj1TW5ejI4rDX5NJUCxFZNO9MAMA8wT0SGYFVTeSALxzT6yWFbkauIL/5kcv8pLL2RvzA9guMyyokUZuPsFtXJZmgzXD+XkAtCTAAZq5vyaZxmvRqP+cR4OMVj15f0lhof9ABFPJKuDxJkB/J5UvTC38NMvLRUoussAxlsKQx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786259709; c=relaxed/simple;
	bh=fE2h2wqf9PkXtGvDyYSw3fuAbsa+IBaCefyXvPXLx4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=chidJ5uf3lWXPtsURa8Bunqz3u1UeS0zT4aWFV2wfL6SlxRtU3Q3qGtQi0ygzgj5t9JnBogIrGJgBg6j5Tj2NXKfSE/aUV0oRC47OVjpY0XYfefmOeFq9gznaf8sDCsEHnxrEX80ZuyyyOx7IdRWwayZXyyrUJY8PPoZrwLl6rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P8wDJ/3K; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P8wDJ/3K"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dde0df80bso1608933a91.3
        for <linux-perf-users@vger.kernel.org>; Sun, 09 Aug 2026 00:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786259707; x=1786864507; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6kXa+8u1WFNiwjJIT6vum7T25llaMli9fa4qouDOqcY=;
        b=P8wDJ/3KFkMFInb2Yr4NDnffuKk6cevmn+dBTiysybfby6mbbyPVrq8JWVTntX29Ha
         jwFX9dNqQmlPDZZAwCYf9g8VK9vNqy4l/X/WRvMRmYXN6KTX9UVXJigxZPVEWPmNYP63
         9PJ6BwWCiJR1wqZtzXj58Y70ZMZwFNqJl7XRx74vBjQ/z3B1MGtQWn81hmoTw45UyGum
         Mf3CofwkR4fMa/47fEu50pIiU7QjVfynmQt5Tl+RSTJS75LRxmjfz8AjRqPMYcWp+01i
         1Z+22tl5oj7YkB7/6fartRULlb79ECILmLsvd8Par9sQW6zWsKEj/R5uQ/1CLbcLQiC+
         tdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786259707; x=1786864507;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6kXa+8u1WFNiwjJIT6vum7T25llaMli9fa4qouDOqcY=;
        b=EtGUgc7zBhh1WxiLiXBVFpL//isxUGmEBK0Ax/XwLQwZaW/C1vUh9pE3UXNzy6wGmT
         Jbn97k+TvoFKEyqDCXthrK0ehXFcI/BBVrfxlJ3qUzx6QJfNQ18Lz4HjrS0qvY0yFBHj
         TQI4X1Iu4ecrvOPuFRG9THM6scrgNbgDq33e3nzcPy/hUplxk3ysjZNIKv2I0ezynpyE
         /jGkh7PqeEvgUWXqOVAnnmdKtct+Tua/KAe/EFlvpeNeZmk0iT/b7drm7Cn8jV0C4KY9
         5ksfBde+/EYJyqUvhxq+3Hdd9DilhHmlOatQtHOeVshsv7rU45msSetnM3D81g4taRBQ
         GN/w==
X-Forwarded-Encrypted: i=1; AHgh+RrWQgS1TOoP6RKS9OhJuY+jMxYo2yTyyfrYvjDepTGY/TphJPyugJh//yPGubLsRGgE4DJz7TgF5h1rvgIzXzVl@vger.kernel.org
X-Gm-Message-State: AOJu0YxkMoW03GMEfUbBEpcNXl4QWcqoQyGWJBy14avwEm4NSCoqpy9Y
	HHTeEG39skAcdMv5eBxuYRpug6PQ/DUZ7jsvyqC5FLUFhdLSBdOukMkmuqXhUyRB8oacAAGttP2
	o9uklPIBqJA==
X-Received: from dlg18.prod.google.com ([2002:a05:7022:792:b0:13e:6e68:2a1])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:528c:b0:380:9f17:6df3
 with SMTP id 98e67ed59e1d1-3903c5448dcmr35930649a91.4.1786259706710; Sun, 09
 Aug 2026 00:15:06 -0700 (PDT)
Date: Sun,  9 Aug 2026 00:14:41 -0700
In-Reply-To: <20260809071455.1221514-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260624051535.3584977-1-irogers@google.com> <20260809071455.1221514-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260809071455.1221514-3-irogers@google.com>
Subject: [PATCH v3 02/15] perf stat: Fix evsel_list leak in cmd_stat
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Fix a memory leak in cmd_stat() where evsel_list is leaked if an error
occurs while opening the output file.

Assisted-by: Antigravity:gemini-3.1-pro
Fixes: 361c99a661a7 ("perf evsel: Introduce perf_evlist")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-stat.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index d68a2617a920..c50cf230f16e 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2735,7 +2735,8 @@ int cmd_stat(int argc, const char **argv)
 		output = fopen(output_name, mode);
 		if (!output) {
 			perror("failed to create output file");
-			return -1;
+			status = -1;
+			goto out;
 		}
 		if (!stat_config.json_output) {
 			clock_gettime(CLOCK_REALTIME, &tm);
@@ -2746,7 +2747,8 @@ int cmd_stat(int argc, const char **argv)
 		output = fdopen(output_fd, mode);
 		if (!output) {
 			perror("Failed opening logfd");
-			return -errno;
+			status = -errno;
+			goto out;
 		}
 	}
 
@@ -2755,7 +2757,8 @@ int cmd_stat(int argc, const char **argv)
 		parse_options_usage(stat_usage, stat_options, "o", 1);
 		parse_options_usage(NULL, stat_options, "log-fd", 0);
 		parse_options_usage(NULL, stat_options, "interval-clear", 0);
-		return -1;
+		status = -1;
+		goto out;
 	}
 
 	stat_config.output = output;
-- 
2.55.0.679.g6767b8d81c-goog

