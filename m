Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196913C4B9B;
	Tue, 16 Jun 2026 02:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781576877; cv=none; b=clkvb9SsNVi8IpxP9gDaoNbKnbLigC1W1oztcaY3OoOHl0JvBQfqlmnxg44xpLqFLGa3HIOIvOyWTmueEjRYJm0+ESounnlNaole2lXyKB1CBpOuD5ZPiwV7ilxKiBq739+Leh/uMd3HhY7vFQ9KazmszcgwxUY2m4WoDO4dOLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781576877; c=relaxed/simple;
	bh=NRiKmhnmjLYlJafMKqk7qKUNLZ2QLSADLHKNOka4yqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uzpE4FY7ZolL/8+spjMUpDhUyGce6sWVUakVGobSWhsgEFkw4x46bDPNNNj4YV8/1VRRu9XDldABQbg79C2Zr6/n3dHPGCM/TuD96kxfbgpJEtG6pfWaX2/Jg7Up8PxRAnVTYHj17N3G2e3KjT6LSIB/RW5rVI0QcE5oCcb+udo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CF4BLEks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CF4BLEks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AD81F00A3A;
	Tue, 16 Jun 2026 02:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781576876;
	bh=bY7pKN93MZ0mC+o+KJ5949YOMQsNMysQBTZt8566+70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CF4BLEksRyqd1XWLY8bIXlDS612/WSDbcwSsPF/pq8HcjAQamlsYB9WJW2iv50lS0
	 /5DH2J38AlunWiC/YT1/ip0Rk1t9EGoCX5fJrlOnPfwMDoVQ0+Eh6EjpZU/E/8PUlt
	 HMnMtGNrFDzAtd12X3c1/pI6xev1OrpYGbyRyFPc8zks+VLKtskSvx7TU2dahLKa/W
	 N+YH3m6t8IzTm0zE0joN+1IiZeDXHRLR6HDVnqB85543yKaA2LHlSLJG68tsDj3FZc
	 L420z2ntQdDroft73cE3yqQUM75B2JUBhadoIhHF4Sp58+prupDdNqtKrNh6ndBzVA
	 0WF+/wISy/qLg==
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
Date: Mon, 15 Jun 2026 23:27:15 -0300
Message-ID: <20260616022715.5739-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616022715.5739-1-acme@kernel.org>
References: <20260616022715.5739-1-acme@kernel.org>
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

