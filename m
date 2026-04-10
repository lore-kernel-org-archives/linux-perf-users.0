Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B5E21ADB7;
	Fri, 10 Apr 2026 22:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858966; cv=none; b=qRhoaX5wZ/a9vZWdmHI514jpbK1HpcY19eiJ5SSrz7kRuWN2yis4Y3husnxpdIaVTh2ulm50GsLp5Odu0QSlSnMQPkJ1JO2fs/Ksz/qakoLyTi9BY1KdryC6MftVa0shvNvD4d2i6XoNibkki25/zTTl2jjTyBBJ4lvXL9xihdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858966; c=relaxed/simple;
	bh=nRhrm1ogSjO4p55V7XBisFBFW6sxxtenZ9O/wXP8roI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMiu623jjDDRCr+JcNOPDI/7suhZV2my7SqHOozNErJ2tPjg3RY7gNPzGCachIqjAfjqt5E4ZHq06qcYVtDCS2FD1al5tJYk2A06VlRkVK2x4MyRbsSA/beDiEAcZcepjoE2rha1wAb02Ur8cggAzDRZACJkF2z6XLHyB0F8XoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXKXKYql; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXKXKYql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40359C19424;
	Fri, 10 Apr 2026 22:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858965;
	bh=nRhrm1ogSjO4p55V7XBisFBFW6sxxtenZ9O/wXP8roI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hXKXKYqljS4VSfofQOEdmNJZlAxaZ3rC+PB62kvXoMyspWcNrzCT74FmYI5MfhST/
	 6qrV/Yf1ttdfiNZUOz7g0YRBat+JfC8xJYGE4+aDpGbIinNU8U9tqGnhqStg3rkezm
	 e/dCq4dDpF6ipwxNs7uVDSQ0l9tJb6unZ6Ao1t3V7e/gJlP3d1QUedGvrMfBTRkMpF
	 scWukCwe2cXJQrrUJZ1+ddIAa+KEchgWyTogj2+dLbmxwp0CsAwk3/tt9K5OY+nndd
	 c2JEj/I2W59b7JG8efvmxox7ObRUG2p8eEkvXoAwjUl8xDLVTqJXC0F96IRiW1wTuJ
	 wkJjei0jD0nHg==
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
Date: Fri, 10 Apr 2026 19:08:54 -0300
Message-ID: <20260410220905.200051-3-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410220905.200051-1-acme@kernel.org>
References: <20260410220905.200051-1-acme@kernel.org>
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

