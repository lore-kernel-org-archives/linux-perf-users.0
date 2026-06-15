Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252A38BF75;
	Mon, 15 Jun 2026 21:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559461; cv=none; b=vAjqPQSsVfgYlUuc3hJkLR5nSoj0agZx5U38Fa2lytoxLtQkWgi94cu8qpCM2z5MWvtHPLeWMoUkGVZ9vnLnWVTUeCr2ABgClp0BQIh/dqBjYS+ysEpsWOeSI8+uSfPLG9Lv4hZ4OjlSW3QyaV9Hqit1zisQQpg+r5q2cHmCXqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559461; c=relaxed/simple;
	bh=NRiKmhnmjLYlJafMKqk7qKUNLZ2QLSADLHKNOka4yqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pl5URg9CZ8JofwV8+z02WCm6C6TcBRyMMyMzymK43jCkIaSRQq0kkaM1ETzElYwlhA9HohqdTsUDDOdCpJetFI4eAf3K5DcV8gXnpt4SObdLgfABwBvwk4sHg/pwxI4XvN1tGCWcjVpezT+NYAb9HGnTf1YYCb2WDQGTBFvjm7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AXRXvO4u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AXRXvO4u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE5601F00A3A;
	Mon, 15 Jun 2026 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781559460;
	bh=bY7pKN93MZ0mC+o+KJ5949YOMQsNMysQBTZt8566+70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AXRXvO4upp2S1oAnahbm1omDcRPTD8iYtGIyTmmTDowzhUwH2nsMSgs1fldJ3tpTb
	 bJnxjDKfZI7aSqySJYXRclHHLRLjZCYWz5GWsnmsIhYBbT9v9TUle2xNVypVooeS2y
	 JnIOyZluPdthqgCjbz7Zmue34eE7b0AtWxp8PyKm1L/hWFuB6F8R4wq9nVi/fMW7+/
	 KfqaVWqsLg6HHe9xTR48+KrYCMTFOlE6a/4l8tw8HjEcMDavVogNUQpB4YN/Qgd/gt
	 ISrFMljhF7hKHmsuyZgX9Mw0+HIBtLAccW8oVU+cB8kf2PYWGevRtqi83ddZ8Ua/wy
	 IrysveEGHPBtg==
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
	Claude <noreply@anthropic.com>
Subject: [PATCH 9/9] perf dso: Set standard errno on decompression failure
Date: Mon, 15 Jun 2026 18:36:57 -0300
Message-ID: <20260615213657.35776-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615213657.35776-1-acme@kernel.org>
References: <20260615213657.35776-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

dso__get_filename() sets errno to a negative custom DSO_LOAD_ERRNO
value when kernel module decompression fails:

  errno = *dso__load_errno(dso);  /* e.g. -9996 */

The caller __open_dso() then computes fd = -errno, producing a large
positive value (9996) that looks like a valid file descriptor.  This
can cause close_data_fd() to close an unrelated fd used by another
subsystem.

Set errno to EIO instead.  The detailed error code is already stored
in dso__load_errno(dso) for diagnostic messages.

Fixes: 1d6b3c9ba756a513 ("perf tools: Decompress kernel module when reading DSO data")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Assisted-by: Claude <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/dso.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 79f1a30f3683d6b3..2309196d8df3111c 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -600,7 +600,13 @@ static char *dso__get_filename(struct dso *dso, const char *root_dir,
 		size_t len = sizeof(newpath);
 
 		if (dso__decompress_kmodule_path(dso, name, newpath, len) < 0) {
-			errno = *dso__load_errno(dso);
+			/*
+			 * Use a standard errno value, not the negative custom
+			 * DSO_LOAD_ERRNO stored in dso__load_errno(dso):
+			 * __open_dso() computes fd = -errno, so a negative
+			 * errno produces a positive fd that looks valid.
+			 */
+			errno = EIO;
 			goto out;
 		}
 
-- 
2.54.0

