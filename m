Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4852D9EF0;
	Fri, 10 Apr 2026 00:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775781633; cv=none; b=QdZzsBCLJTFlyvkgzHUyXTWE2U9w0qWjMt/yn6FVzLMTX7TgU0BXD1/ezF89ZrfCPddsYc+sxDgQZO6vRBtoLShrMpYyG7XHZ/2rAIMQeGPv9j6aaMKwcpn/RQUL6LhhO2HOpd2UdMnJllQVnn6JAmlwid887fkk8dXjtZbNxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775781633; c=relaxed/simple;
	bh=nRhrm1ogSjO4p55V7XBisFBFW6sxxtenZ9O/wXP8roI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PSiA6OaTTrpVMpPBqEehEmPdiLTWXvX5/GKV95nORhEDmUn40Me8rg2c4ftryGZz4B5o0K2TfWi6pa9Z9sgav8N6h5bXimG0s004TVoZJZUpbIBkIAKVr8QiedFI7Vf04HDc3nfpymGqGxLCjaXqMeUsNDo2N90xd09Ot5k9Mg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNmys/lU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNmys/lU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43E4C2BC87;
	Fri, 10 Apr 2026 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775781633;
	bh=nRhrm1ogSjO4p55V7XBisFBFW6sxxtenZ9O/wXP8roI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eNmys/lUBj2VKlaIp3b/P6fGFwOEH8De8ZHO0o4oYh9pCp+RkAWsMfKAHMpo3TJDs
	 3vXGPGzhXlO5SY3s9Ga+Q0UsI1L1e5indpPSCoWrdreHkyMfeLMgTN4tvoTjcaCxcM
	 rSAfreS9Ows91bkAVlKR4zMGvP1VfigJHEU99ueMVwH0qn7bxvLIf+uEbksmTrsNqH
	 iFy/uAtF7RNtLRHmHhvT/2Wfw0opp3C9QKSKi2Hq1qsCypTWE4h+hjacz2tDoLEdGg
	 fKIutIr6TKYKLNSy4mvAlM7jL5Ma0T1Z//yGNSSQ/HEo8AKJVosZanteGbTI0S51Ks
	 4sJxLCXulvXuQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 02/13] perf header: Bump up the max number of command line args allowed
Date: Thu,  9 Apr 2026 21:39:49 -0300
Message-ID: <20260410004000.148138-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410004000.148138-1-acme@kernel.org>
References: <20260410004000.148138-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We need to do some upper limit validation, bump up the arbitrary limit
as per suggestion of Sashiko about command line wildcard expansion
ending up with more than 32768 args.

Link: https://sashiko.dev/#/patchset/20260408172846.96360-1-acme%40kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/header.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index a2796b72adc4d908..22c44b6f0b098f95 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2795,8 +2795,11 @@ process_event_desc(struct feat_fd *ff, void *data __maybe_unused)
 	return 0;
 }
 
-// Some reasonable arbitrary max for the number of command line arguments
-#define MAX_CMDLINE_NR 32768
+/*
+ * Some arbitrary max for the number of command line arguments,
+ * Wildcards can expand and end up with tons of command line args.
+ */
+#define MAX_CMDLINE_NR 1048576
 
 static int process_cmdline(struct feat_fd *ff, void *data __maybe_unused)
 {
-- 
2.53.0

