Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97660415B9C;
	Mon, 31 Aug 2026 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788181925; cv=none; b=pjz8AOlB1jvfSQBWaICKVnrLqEDwS/qPMRnJfSi0hl9iiG8f3Kb/dtHepJUNdJ6ZEkz6DlcXqy5+lONcr5/MhIRtv72d9rz2WFZqFaYhFZPaKA4bkTuibMuOBqSLi1tL1fi2DwldJGBDF4NV9xMvitG6W3UohkXP3qxZyty2wgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788181925; c=relaxed/simple;
	bh=n5JyfkLUI1umoPs3xeGc8sxlvVNnXZtD11X4RcZpEKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ndcrRY5JNzq3ZNEqCRJbQsG/PBINnLykB8UNzuBQOqMBgem5PViivveIKwCb2Pbywb8L96QVQbVcqSxksNBrnTERU0MvAnN83Q4vSEL53PWFCQADbd4cv5qrWFSY7HaR/kUL05l65b+I0rCBUREQSB25v00RwgCloETu/doNL1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOhtdU3Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOhtdU3Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70DF91F00A3D;
	Mon, 31 Aug 2026 13:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788181924;
	bh=7BJ4IbMFemaIyg3qYdYweZLVLYXJyCfnE4LQTgJgD/8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mOhtdU3ZGOvfzjADHFAgd7loMU0kbzq1mizMO/w0bwxASPoNg2TqCwWbDlKWyvVHI
	 UazzUtlvxmGfQrYngOhiZ9EaDiPWNtWwBfYa91Bg6qV9ly3ptZRxxblMxtp8sgd+q1
	 a1Uw+dVegNdnK4Teeotaexqufh9QiJBqcw7Ay/beGgQXVA2Ac6J+ejuY4eO3lkWUvF
	 8m4SSHFCFn4jf/R7FQ5hgUR90AFWez43Y8R0nMdDMVVxhm0gxcdOS2DxiGqKAdcwW2
	 6OLRt/4kaOWE4eU22NIH4kLz9XDK0h139AA8wYCYLD0Zn419FeyLBwpo5XdKLfhW9s
	 3+Fu3e/pRM7sA==
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
	sashiko-bot <sashiko-bot@kernel.org>,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH 09/12] perf jitdump: Use dirname() return value in jit_open()
Date: Mon, 31 Aug 2026 10:11:05 -0300
Message-ID: <20260831131110.4681-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831131110.4681-1-acme@kernel.org>
References: <20260831131110.4681-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

jit_open() calls dirname(jd->dir) but ignores the return value.  POSIX
says dirname() may return a pointer to internal static storage — glibc
does this when the path has no '/', returning "." from a static buffer
and leaving jd->dir unchanged with the original filename.

Capture the return value and copy it back to jd->dir when dirname()
returns a different pointer.

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 91aa1eea8229faac..d3de307532d55065 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -146,6 +146,7 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	ssize_t bs, bsz = 0;
 	void *n, *buf = NULL;
 	int ret, retval = -1;
+	char *dname;
 
 	nsinfo__mountns_enter(jd->nsi, &nsc);
 	jd->in = fopen(name, "r");
@@ -241,7 +242,9 @@ jit_open(struct jit_buf_desc *jd, const char *name)
 	 */
 	strncpy(jd->dir, name, PATH_MAX - 1);
 	jd->dir[PATH_MAX - 1] = '\0';
-	dirname(jd->dir);
+	dname = dirname(jd->dir);
+	if (dname != jd->dir)
+		strlcpy(jd->dir, dname, sizeof(jd->dir));
 	free(buf);
 
 	return 0;
-- 
2.55.0

