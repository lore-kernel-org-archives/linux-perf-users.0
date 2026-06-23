Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6663A9632
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 05:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782192936; cv=none; b=MDR9mQ8LSjkWlUO+oV5YKJc/1Y+gPT63uhC5T9ribX3aZWbVyNIoE15VgNHSFF7ojrrVnMAlAOm+PjL3WJAFjqTt93VwVwi+zpcCF7n77hr7NfpV7KZ+fcsWZ6AqlD6TusozTeD6hhKfVKF6lG3elcLo2iQbTi5Gi2b0vGuXciI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782192936; c=relaxed/simple;
	bh=+7BYb8w3BrwrpFEQj+Af2akUMZDOfy5AkVZMEyvnJhc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j7cWg4byTL79iLB6oJ1C1yukhkgqqu62HGcklsybeJITY79CMNnMMq4aK5zzsoKioTZ/hdwqMimsuxYbIfc6bSw/hEcBIrSO7sF87/rjgdfyQ5BZIyUOsbmGyPkvF0GLn7g5mRK185LU0T9DvL9LoqlYAZO0bs4EB/Jrg1lym/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HP9E6fxB; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HP9E6fxB"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137fc6f8e9fso5745587c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 22:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782192934; x=1782797734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlVBF2YSYJ6WK9bgCi2is6wLj0L/prwxNarlEs3DfRY=;
        b=HP9E6fxBBmm2VYgfuaQ1/5Qjqh93oMIm8mFPGWgzBbgrrpGAzQlJUVjsrlr7KhuY3U
         NzNxG9DlALRZZ4TjZVoY3fM6rk2xaYYyn4WwOe3aXEYzLDC3UY6+PN+pxzTWCI4kYlsA
         4Bw092Kjfd7s9Xdfh5spAK98+Tihc5xYNJkaG5HmAxhcP8IPCp+afZz0LvVulwT1gYOR
         0tQay87KRR2pFN9KOUEuZw7fUJ1PSpkkNwiWRdShGLocofn4cbG2/PxLW0Xris9PfmFT
         8l6pbaq5O/T3Lm70Zyw4JpAke1Kredex9VM9itWcalsYwXYmNJ/3KiMWkAGng5+w48zc
         RjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782192934; x=1782797734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QlVBF2YSYJ6WK9bgCi2is6wLj0L/prwxNarlEs3DfRY=;
        b=QRtPDMJQ2GY/6cyS22vIe8KXDZNBv/NWi5OfN70P69Kn0pTsEJVEB3hfGIv1PXDbP9
         p/bNDyYlxcn9soP6KMPLBgrX3KVSivLj+7hAqXRnRXyBSvl/NKpEqG0/afYTJ2njxDIh
         6frUwEQghJOKynT4wXWD930f6j3k/cLlORaHA/uey9VY0SUcIfnYMfr0ckIi/hJUfjil
         DqbaSW8Q9iCOJ1X2E9/Il4Rzf05o+tRKdkswQU4OwWRnDpqD1BqgtCWOTVwZSG8NdA9a
         H9siLmLnYJHqhSvxuEA/TE/waI01T/bWZ1unLDz9uCwjNlg/Ik5SkSTuWd7svHLx2dia
         vkgw==
X-Forwarded-Encrypted: i=1; AFNElJ974G16vmiFXCfUivCtv4KNHkG7Nu6qbEcklFSH6ERAug7ahlIwGJ0GJiXabfiqFdegneu4x66iA/CX8l5d2onA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc4/Uxjodo9REEr+Oxdwm+97LS8K56N2wgHvjBcYxtw6TEG9zH
	MLMJZoNMWwbRyM0CB33y0DI8xvP6yk9xAE9cpF/XAdYBBW7/oktDrKFC0m0MUuAcoAEXx/Wx8IB
	gOknt2X9BtQ==
X-Received: from dlbps9.prod.google.com ([2002:a05:7023:889:b0:139:a1c3:d075])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:907:b0:136:b370:64c5
 with SMTP id a92af1059eb24-139a367cf27mr9861930c88.30.1782192933889; Mon, 22
 Jun 2026 22:35:33 -0700 (PDT)
Date: Mon, 22 Jun 2026 22:35:04 -0700
In-Reply-To: <20260623053515.2677888-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260623053515.2677888-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623053515.2677888-3-irogers@google.com>
Subject: [PATCH v1 02/13] perf stat: Fix evsel_list leak in cmd_stat
From: Ian Rogers <irogers@google.com>
To: acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alice.mei.rogers@gmail.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org, leo.yan@linux.dev, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, tmricht@linux.ibm.com, 
	Ian Rogers <irogers@google.com>
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
index 3f897b2e8638..7cb6ea937e87 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -2718,7 +2718,8 @@ int cmd_stat(int argc, const char **argv)
 		output = fopen(output_name, mode);
 		if (!output) {
 			perror("failed to create output file");
-			return -1;
+			status = -1;
+			goto out;
 		}
 		if (!stat_config.json_output) {
 			clock_gettime(CLOCK_REALTIME, &tm);
@@ -2729,7 +2730,8 @@ int cmd_stat(int argc, const char **argv)
 		output = fdopen(output_fd, mode);
 		if (!output) {
 			perror("Failed opening logfd");
-			return -errno;
+			status = -errno;
+			goto out;
 		}
 	}
 
@@ -2738,7 +2740,8 @@ int cmd_stat(int argc, const char **argv)
 		parse_options_usage(stat_usage, stat_options, "o", 1);
 		parse_options_usage(NULL, stat_options, "log-fd", 0);
 		parse_options_usage(NULL, stat_options, "interval-clear", 0);
-		return -1;
+		status = -1;
+		goto out;
 	}
 
 	stat_config.output = output;
-- 
2.55.0.rc0.786.g65d90a0328-goog

