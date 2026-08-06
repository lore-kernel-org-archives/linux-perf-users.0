Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A12305699
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Aug 2026 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785982245; cv=none; b=D6dGbaW30xq2uc4lI3ERWIF+8VJmpy/5G0AndAqCny4fbr7Hrv7qvJstuwxkpGEAXu5JzWCREkGSfm8HQ7H4YK6sDtVOE9SgIRYPazUwOeGLr/rD9Au8OglE9LY+KhevcN9Kmp/duu3ZDvUbBEGM0eFulCaQ/vWq5r9/+DsXOs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785982245; c=relaxed/simple;
	bh=Y+TZl/y9/hV+sun39kavC4+lwIlG+BwQf8lj9L/7Mcw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=RI0rFrDBiwe5GRspwJewMCmCsjiF+7kLymbBUEGjNWqjtVt9/kCOBzOYug7frcmgKbJeS8CCJFVBgzKcGV/TEHu9Q4att2jodz2yS8kDhtI5eEVrL6frxshF9O0OCSZkJDz3xNGG7RtiEkGYiMBA6gjUWL7rGCmYCF1OHD0w+3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y+zp7rri; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y+zp7rri"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38f5ac7416eso2103178a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Aug 2026 19:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785982243; x=1786587043; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXsoxVGBNSjfiRdARFInMi8AsNaMqbW9uwYEKgGxQWg=;
        b=Y+zp7rrihJcRwxvAmkj6m1+kHKl4cGjDzEK1AM2FI7x53U9LxrP+Q1ICfnli+ojnwG
         qWQZQPAOm4ADW4uzSC8iAlYz2M/Lk0XCaKpUcYyP6Tl78SrsfoKWNkNbKBcKdMsy1NdV
         qQx0Rl7+RPVDg0f7XgJ4Db6uGx0DbA9rAO7uGJRJ2+pohrW9WPqieTfaUw4AkboHdmID
         dAcbols39xKQ0p8TfHyRspIPJ43JHQRnNps2nSRfq9kEFu8VyGgDiaJuH+tgI0ITK/9U
         IJqkd/rNkv3ithXfbYYrpzr/ic6KMqXGoo0YIAP8Qt3N+fSOJuhwnFVO9pYXOzyCRas4
         eXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785982243; x=1786587043;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PXsoxVGBNSjfiRdARFInMi8AsNaMqbW9uwYEKgGxQWg=;
        b=F2DJF8trOvWvan9sCLPeabksjTESa2e5M8z3CZrdCnZTdeELF5Zx2pTqGNQT5+6zUW
         LgTVlNWsJhbYHKWIz3bFWoUdNlgHcANTUtrl+EagyCkcvrO3uaTQtmf0K4/RbuBxV3gb
         Zx701luCqKvn2/eK78xixX9K+Dj/6+dbKWjAIWAwOc25TgeA8AVQUaOY3dzcadWSq6ge
         DK8O4tlwsgwxi/aBmNJfcbzUTrUHv7/ucbSEgDa3Aoo485wFLc7ojy1GV87q7VIHuY3K
         cplwf0A59T481d5myHl+qGeOK3Jq5kQyyQUQ8bfWaxvo9VF5QP+JDTjt+CA5u8vRWafR
         2o1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqWBR6uHYY5qunxsO3IVfMRfqHnzXIuAhqu6aR1bo4ZqMk/4CSEumvE78soJujSHop5/8dfuujGJqJRNPP2RrHD@vger.kernel.org
X-Gm-Message-State: AOJu0YzoTfhHzqJyOq2s96TLvp4FMlLi+2DE4EiXeEX+7pI81At+fbE5
	+zONN+1o270y5kH12hc47sCsA0fbqr458KyQxYHSRURlZSSNC6oeAws24Ad1nrO9ak7z9UNrpP+
	jSLAIzt0CNg==
X-Received: from dlam17-n1.prod.google.com ([2002:a05:701b:2091:10b0:13b:2d46:494d])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:520a:b0:366:10f1:3d91
 with SMTP id 98e67ed59e1d1-3903c54adbamr11271299a91.1.1785982242879; Wed, 05
 Aug 2026 19:10:42 -0700 (PDT)
Date: Wed,  5 Aug 2026 19:10:38 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
Message-ID: <20260806021038.2291417-1-irogers@google.com>
Subject: [PATCH v1] perf evlist: Warn when 'sleep' workload is used without
 system-wide (-a) option
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Tanushree Shah <tshah@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"

A common mistake when trying to record system-wide profiles for a given
duration is running commands like 'perf record sleep 1' or 'perf stat
sleep 1' without passing '-a' / '--all-cpus'. When '-a' is omitted, perf
defaults to per-process monitoring of the sleep process itself, which
does not collect system-wide activity and records very few events.

Add a warning in evlist__prepare_workload() when the workload executable
is 'sleep' and system-wide mode is not enabled.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index eb7c0d7be064..d53f594ace86 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1562,6 +1562,20 @@ int evlist__prepare_workload(struct evlist *evlist, struct target *target, const
 	int child_ready_pipe[2], go_pipe[2];
 	char bf;
 
+	if (argv && argv[0] && target && !target->system_wide) {
+		const char *cmd = strrchr(argv[0], '/');
+
+		if (cmd)
+			cmd++;
+		else
+			cmd = argv[0];
+
+		if (!strcmp(cmd, "sleep")) {
+			ui__warning("workload '%s' specified without the system-wide (-a) option\n",
+				    cmd);
+		}
+	}
+
 	evlist__set_workload_cork_fd(evlist, -1);
 
 	if (pipe(child_ready_pipe) < 0) {
-- 
2.55.0.629.g250fe7f194-goog

