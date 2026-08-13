Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398C72459EA;
	Thu, 13 Aug 2026 00:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582191; cv=none; b=BKY5Z/h6VsLghv0TftG3KQ5f33VjGeLVBA/XwfiKdMYqugdQ0SvFUPZc0RmKt4Gtv/d1Qe5LtcWBEqfcSLfYKe1A5P/SkZIzE41RdsvmuQt0M8XENnR5JtUFuNAlKNGjwaVgpUhhQ+i5xAJoS/SVxtOCqRh0rI3vpUcBqIet+6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582191; c=relaxed/simple;
	bh=wXfrViw83ley/fLzMSqJOPxqnIvdFApGnDd4yaNCo64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ruz/Uq7hLPUFL9/yv1os+hA9+VkYY1vOsD+7aW1+KtzsBfticsrF3R3FqKJg3HVzkNHiodbwmJm637mnNmvpymelQyh3PKx4IHEJceJtYRe8E466pGeyEFCTAvjrHUkwqudqOumV1UC5o5NbKWIZZt2vRCl8dwUq3TKVMrR7dKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EO/Zyuaj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EO/Zyuaj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4D41F00A3D;
	Thu, 13 Aug 2026 00:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786582189;
	bh=WuVjmL8PoiiOSZzjOJbihk5uOtwMRudcM4sg2VDkp2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EO/Zyuaj8lp4Si1QlK7pCLr4FsOc734/uk4/VcysRU0nZAk9kx1udL902Imzk+4Lp
	 amAqneD/mH/0c7ubHhBB/AV3H5h8b+rIODn+k23tcRqlgpBU/7CBOdTx2kpAxq13zN
	 QI5S2fFltMoMDyLNh3YwBI5FEy3xEgewAqAYb4bohdJsl7d0RGbnAhFxuQtXn3aVWq
	 M4i41jksSJfFsSy7C71/FpmxjG2vXJ7lcR+vGY7poCPcSHg7AfKF8faCY8MNq6SgQz
	 Eagrjx2iOQUuOCDhQiicKtqTWUXgW5NAo9tH0mkCyebHyBPoyVMwubKNzSJbaQnBDt
	 kqpwre4ei0p0g==
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
Subject: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno in file_read() and file_size()
Date: Wed, 12 Aug 2026 21:49:22 -0300
Message-ID: <20260813004927.16738-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260813004927.16738-1-acme@kernel.org>
References: <20260813004927.16738-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

file_read() and file_size() use ret = -errno when
dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
multiple open() attempts inside try_to_open_dso() — it no longer
reflects the actual open failure.  If errno happens to be 0, ret = 0
looks like EOF rather than an error, and file_size() callers like
dso__data_size() would then report a zero-sized file instead of
failing.

dso__data(dso)->fd is always negative on failure — -errno from
__open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
or -1 when do_open() itself failed — and never 0, so use it directly
instead of reading the stale global errno.

Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/dso.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 124193453675ca18..c7fb9e1d07f14f17 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1029,7 +1029,9 @@ static ssize_t file_read(struct dso *dso, struct machine *machine,
 
 	if (dso__data(dso)->fd < 0) {
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
-		ret = -errno;
+		/* fd is always negative here: -errno or -1, never 0 */
+		ret = dso__data(dso)->fd;
+		assert(ret < 0);
 		goto out;
 	}
 
@@ -1151,8 +1153,10 @@ static int file_size(struct dso *dso, struct machine *machine)
 	try_to_open_dso(dso, machine);
 
 	if (dso__data(dso)->fd < 0) {
-		ret = -errno;
 		dso__data(dso)->status = DSO_DATA_STATUS_ERROR;
+		/* fd is always negative here: -errno or -1, never 0 */
+		ret = dso__data(dso)->fd;
+		assert(ret < 0);
 		goto out;
 	}
 
-- 
2.55.0

