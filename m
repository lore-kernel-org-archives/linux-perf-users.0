Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0F837E5D1;
	Sun, 26 Jul 2026 23:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785109224; cv=none; b=LQ6HMnncMU6Dh27UXwZaUKjY5mVPoXYxEKQzuatUrA1keI3XK92ovnVD6x1pYCdF6gdt/xQ0XjtNY9Z7wlZhxZoX4F78vObDkpR6TzGyTIJU073lQHMCyg06dEkkT+k0tbvwS7LAufASBVah3kvpmFXla8TEFbboH80Ud4xC2Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785109224; c=relaxed/simple;
	bh=a1SA2EU17KSdk6Uw9C6SOiT+z4UVvQFXceHYPW9d2XY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CbWH6ePH4H7ZM8ujUqKKP+RU6p+pwEFLXdqAvzNvRAQm8ICBG5FQqyaTCaJocDHDLRyihggbyClREKtYT6Faj40spsKNY3fl9vvSif59QBWV103PkJrC4YBFI/eNkyGmy8HV5DXsNQtvWWv2/+PMP0WKRByFL9rXsePrZTYDQ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QpURexr5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QpURexr5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8911F00A3A;
	Sun, 26 Jul 2026 23:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785109223;
	bh=RVhBjAbctgCYsSimTM3yjrlRX9pyzCwFiWfvhl6cXqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QpURexr5ILFx5FTftJYNoR2w0LQf1S7HAaYvNlplIpj4ttiH2flcrbrfMzDrQhT2Y
	 1BLg+3kVVqSmI4q2QgAHTG5KqYE5wcX4lEZMFSyYg6UhSITTdeuUAT8Jgv8oiBvrMc
	 Kco+rLUkTBcINbfjwz0mtJGOrr3ro41x+zwDwkaKruncMh51ZetJymQs00B15GHddd
	 8Hb2nPppIVWBJqjxA1lqA23gvVqQNnlGbCOsHRvsYjog69MrLnHXepL4O3kxT52JDE
	 Bqrmft7jV9v2FHBmW9BOcYj6/foa6qIoEYkirz+tWmDvYydnlYQOwkEbwvD3I1jUXn
	 uWIESFIkfuorw==
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
Subject: [PATCH 1/8] perf machine: Fix fd leak on bounds check in maps__set_modules_path_dir()
Date: Sun, 26 Jul 2026 20:40:07 -0300
Message-ID: <20260726234014.63111-2-acme@kernel.org>
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

The bounds check for root_len >= path_size returns -1 directly without
closing the directory fd opened by io_dir__init() a few lines above.

Jump to the out label instead, which calls close(iod.dirfd).

Fixes: e7af1946818b ("perf machine: Reuse module path buffer")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/machine.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 0d2ebf6a84bcf880..503f5a65e0cca639 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1411,8 +1411,10 @@ static int maps__set_modules_path_dir(struct maps *maps, char *path, size_t path
 		return -1;
 	}
 	/* Bounds check, should never happen. */
-	if (root_len >= path_size)
-		return -1;
+	if (root_len >= path_size) {
+		ret = -1;
+		goto out;
+	}
 	path[root_len++] = '/';
 	while ((dent = io_dir__readdir(&iod)) != NULL) {
 		if (io_dir__is_dir(&iod, dent)) {
-- 
2.55.0

