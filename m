Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819A72D0C72;
	Sun, 26 Jul 2026 23:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109227; cv=none; b=Xs1oZvjIrqZyUD+0sqPXBL9CVFKEHNZu4G39Fbt2TraLhpZC/BD1hq4MMft2gB1ty02Y3rMd1xtIn6hzdwwDUVlTcJJU4xKZxGKbMQ1RatjOqVNvVswUX791yybbzZTv45a3RhVrclLpqID0wwtvqANrTISo7lXR4bkqkssSkQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109227; c=relaxed/simple;
	bh=wys5rbWymPBKAXl2yifvgLaw5WyvC6tDiCLMwMkwhxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cctQix8w6Q80OJ0h9796CDebTA/vgXpKlzDQtGPiH6hpEjU7QAeIcEIrL6+/gXEPggxz2FyMRrvjONssaTDjTqrgfs/EdjXfXubocV6/1KL5P0zbS6N65ybIpb+Hyp0Hj0kr7INZUASkvhbb/rA+fytNopBpFUDX6GULL9KBqnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wos3nQ1+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wos3nQ1+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97EB01F000E9;
	Sun, 26 Jul 2026 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109226;
	bh=0dXYC/Kqji6OGh7reXbtP3eM5c6LDJ9i3rj455Vo59g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wos3nQ1+46T6L4Mzrg+FQGhdBBDoqwYp9OPR90gHAug6fSI5naAP3+T3XW4l1cBNL
	 yNad3+VBgaDxaSD/03ciw2YHzrAh02VvHgRqv3NEUvW8RrrJaR73heGMzcBo6TwVW6
	 hAxTZTuAEKAagcOO3XjluqcJB2MRaCAV4nT0zY1cjt1Ozpiw7OGa/ZsW+7X9zRFAj3
	 Ry25qlnzwQm39ZMrzXqQFuj+JU6+5xcABFmTiw4wVsYZ1sB9JiT/mMtA2kM/v8ru5F
	 RbUiy3tyn+xN7cG3vJlp7mHOQ04QzOqliP1NLpPTM+htZhLUZdAkjAZNC606hAHtsv
	 hA9OJy+zoKMog==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	sashiko-bot <sashiko-bot@kernel.org>
Subject: [PATCH 2/8] perf machine: Fix NULL parent dereference in fork event processing
Date: Sun, 26 Jul 2026 20:40:08 -0300
Message-ID: <20260726234014.63111-3-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260726234014.63111-1-acme@kernel.org>
References: <20260726234014.63111-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

machine__process_fork_event() calls machine__findnew_thread() for the
parent thread, which can return NULL on allocation failure.  The code
then dereferences parent via thread__pid(parent) without a NULL check
when validating whether the parent PID matches.  The later NULL check
at thread__fork() does not prevent this earlier dereference.

Add a NULL guard before accessing the parent thread.

Fixes: 5cb73340d92a ("perf tools: Make fork event processing more resilient")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 503f5a65e0cca639..8b213482e5648e97 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1923,7 +1923,8 @@ int machine__process_fork_event(struct machine *machine, union perf_event *event
 	 * (fork) event that would have removed the thread was lost. Assume the
 	 * latter case and continue on as best we can.
 	 */
-	if (thread__pid(parent) != (pid_t)event->fork.ppid) {
+	if (parent != NULL &&
+	    thread__pid(parent) != (pid_t)event->fork.ppid) {
 		dump_printf("removing erroneous parent thread %d/%d\n",
 			    thread__pid(parent), thread__tid(parent));
 		machine__remove_thread(machine, parent);
-- 
2.55.0

