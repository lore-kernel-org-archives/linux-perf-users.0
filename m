Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BD67E105;
	Fri, 12 Jun 2026 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224518; cv=none; b=mz1d+oSk6sylexMW6T9/j3oSA466jsv8rYGkXC3RY5tsS0HflsHQ1xftF9O+wN1MORm+/iHhcc32SFCPlGg8YOHBfgrILeN2gkjtqrjP5XdIs9MBH6Wn0Vz8RBo8R0MuxLJ+X+UTUG9JbJRTUA3PAYqiXQfBipL0OqKoBzHj3bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224518; c=relaxed/simple;
	bh=MOt3c1ftICu+qWVeOeX/X1xW0XC3TEh9ubHr7ByRYfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HB+J4VytwBqi+6InpLKGJxxPszQ+MTRH4w5qsZoUpDH1HzewhllNalyWiE2M77ypXYNRKslhUmyNYWSSU4YR6ubpM2MpFJFwg96Hkn/p1VKzshX21QUR+DRFgbm7quwmhxbKgHfHHSJoJiyho1y6cn6Gxn1uzc4Qf+t5oy0pzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO8oCay4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO8oCay4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 035EC1F00A3A;
	Fri, 12 Jun 2026 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224517;
	bh=XrzfqI1vaU2tlrcUxifTMBQ2C6q9m0ksStEmoc8wi6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hO8oCay4oeU+4bohIjI2ikPT+YyKwBzY8yChTdaT9Psms0VsPtq0evIe+si98YKgU
	 h/GdmVTYZMqaGvN46uoa3E+RgpxO1HZkt3+zVbDCpEU7gL6e2wiKRlTjd5VYd/Xa1g
	 TEykEJNx1OKynW+AmG5INqK8UIFsSGEaDZY+To3Oo5LZ7PrG/aJSJXflLohaJ86wC2
	 9dVXqIGXfKaFcSjB0i/mGN0qZ8yG+tzp/4HJVSL4VayNIXdlaYgjWnXntmszAjMcCi
	 K/xWmZrJFgN8r7JYBhjKDP6tGSH4tyb0z3kw1PM4JkTbPiJS4QZnDBwQVHUQesgBCW
	 saXfm61n+M/sA==
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
	Zhang Yanmin <yanmin_zhang@linux.intel.com>,
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 07/15] perf tools: Use snprintf() for root_dir path construction
Date: Thu, 11 Jun 2026 21:34:35 -0300
Message-ID: <20260612003444.50723-8-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

get_kernel_version() in machine.c and dso__load_guest_kernel_sym() in
symbol.c use sprintf() to construct paths by prepending root_dir to
"/proc/version" and "/proc/kallsyms" respectively.  Both write into
PATH_MAX stack buffers, but root_dir comes from --guestmount or KVM
configuration and is not length-checked.  A root_dir at or near
PATH_MAX causes a stack buffer overflow.

Switch to snprintf() with sizeof(path) to prevent overflow.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: a1645ce12adb6c9c ("perf: 'perf kvm' tool for monitoring guest performance from host")
Cc: Zhang Yanmin <yanmin_zhang@linux.intel.com>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/symbol.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da1ad58758afd9d9..58fa57e3d1a15f37 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1336,7 +1336,7 @@ static char *get_kernel_version(const char *root_dir)
 	char *name, *tmp;
 	const char *prefix = "Linux version ";
 
-	sprintf(version, "%s/proc/version", root_dir);
+	snprintf(version, sizeof(version), "%s/proc/version", root_dir);
 	file = fopen(version, "r");
 	if (!file)
 		return NULL;
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 0c46b24ee0986059..c2328c9cec1565fc 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -2275,7 +2275,7 @@ static int dso__load_guest_kernel_sym(struct dso *dso, struct map *map)
 		if (!kallsyms_filename)
 			return -1;
 	} else {
-		sprintf(path, "%s/proc/kallsyms", machine->root_dir);
+		snprintf(path, sizeof(path), "%s/proc/kallsyms", machine->root_dir);
 		kallsyms_filename = path;
 	}
 
-- 
2.54.0

