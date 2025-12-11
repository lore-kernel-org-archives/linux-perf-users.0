Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6092D6E5B;
	Thu, 11 Dec 2025 22:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765491491; cv=none; b=B+LnXV8LpZcLRl1NgoBRxs+jGCuXIRotH308275pvXHQtErWU00KqSZt31MLcGaFRr9N0eY9PHv/Nwv77XnlBqM8FTeIsTq1Vtw2vqiCWoyFK1F/uwGIzH3nBEyYmaytwA1DyAXSFxSnqwlLlQpgb9pAvDyXUKTnEppMvFn0aME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765491491; c=relaxed/simple;
	bh=w4yfUP3WqGg3ALDETvkl70tHP/a6zGD0PqOjs9hXsgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D8XvG+iUYK53R1BxeevacrjZUSUyYzBG5LpZel/Fcmk5saejoUaD8b9BBWrUtAHQUyPJvkLdnqNUDimfdK//eNFTk0wwu7w1HqCzkWwMYgLNWp29sy6AlTsCwRfg70W3ELgT0PJaSJAbaZ0tGWW60xvbuk1wJnJUWj/oJbp3r1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MPwPcZDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MPwPcZDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88E3C4CEF7;
	Thu, 11 Dec 2025 22:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765491490;
	bh=w4yfUP3WqGg3ALDETvkl70tHP/a6zGD0PqOjs9hXsgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPwPcZDvlrCuRmoVa8KLDoVAP5BqleBzleYsG7sgBkh3ODi+TkPwGk5TroVBLfPOK
	 vA89DJF7IDicjvA6HIby1ag71dW6eQtVnSI3tkqW2fPL2+YmJqPktgK3LIIiMe8kdz
	 DbnLV26AGr+abT+KGturolIr7j8qKl8GQ8Ns3oHwl8CigcW5jmDW603okcj1pCJnYo
	 ujHuB8e4hE2eVAtVKuYqO/gH+krjyYh1Wtk4zJc39UC0ybF1aSTWcfIV9nptKKDIfq
	 S/X7HZWJ1MxwLbDLyo7i5fyovAVjwlXftNNeFunvZwnIZ0Xzpq99FWo5jjb+ntz+/p
	 Hc1cZDHuepc2w==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/4] perf diff: Constify strchr() return variables
Date: Thu, 11 Dec 2025 19:17:54 -0300
Message-ID: <20251211221756.96294-3-acme@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251211221756.96294-1-acme@kernel.org>
References: <20251211221756.96294-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer glibc versions return const char for strchr() when the 's' arg is
const, change the return variable to const to match that.

Also we don't need to turn that ',' into a '\0', as strtol will stop in
the first invalid char. No need to touch read only memory.

First noticed with fedora 44.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 53d5ea4a6a4f7b54..59bf1f72d12e226a 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -178,10 +178,9 @@ static struct header_column {
 	}
 };
 
-static int setup_compute_opt_wdiff(char *opt)
+static int setup_compute_opt_wdiff(const char *opt)
 {
-	char *w1_str = opt;
-	char *w2_str;
+	const char *w1_str = opt, *w2_str;
 
 	int ret = -EINVAL;
 
@@ -192,8 +191,7 @@ static int setup_compute_opt_wdiff(char *opt)
 	if (!w2_str)
 		goto out;
 
-	*w2_str++ = 0x0;
-	if (!*w2_str)
+	if (!*++w2_str)
 		goto out;
 
 	compute_wdiff_w1 = strtol(w1_str, NULL, 10);
@@ -214,7 +212,7 @@ static int setup_compute_opt_wdiff(char *opt)
 	return ret;
 }
 
-static int setup_compute_opt(char *opt)
+static int setup_compute_opt(const char *opt)
 {
 	if (compute == COMPUTE_WEIGHTED_DIFF)
 		return setup_compute_opt_wdiff(opt);
@@ -234,7 +232,7 @@ static int setup_compute(const struct option *opt, const char *str,
 	char *cstr = (char *) str;
 	char buf[50];
 	unsigned i;
-	char *option;
+	const char *option;
 
 	if (!str) {
 		*cp = COMPUTE_DELTA;
-- 
2.52.0

