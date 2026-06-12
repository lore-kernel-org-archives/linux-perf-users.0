Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCA51B3B19;
	Fri, 12 Jun 2026 00:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781224507; cv=none; b=LSrkmC+ixbMdAdgdzEjNaMRKcupdIdwcYPGN9tS+JLRo7erxgQDRcW8OqQIUdj7KpG+FrBkql+MVzZvMzT2WnBSAFy0yx2TJtxWk0La5ohCe7Ghx3Gz0ggmn1wUvRZ2ynD0SlfU1HZvWliMElFjM5zaqlKw2LaBMtc1lKXgKYB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781224507; c=relaxed/simple;
	bh=5kvW6ibvKQO9RKqdxNENawpoVXuvRH7Fq9ZfLZZa+jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YPYPBsPZjBUzY6A1qCHu2uOmnLOzNB/gYBDm82lYGb5G0uiJ6SmYKkmKPvDsfFBwZzUlCn1cxMnV1W9Z2gmI72CnoL+kZTU6iD4w1M/U+48Ci2Fj+ztJjrtr2Kr/t4EDr6c7AwH9FnrNIIFV4uKhp7MwOkjtsgVhILhtIcCVaLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=meE0jSsQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="meE0jSsQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87FBA1F000E9;
	Fri, 12 Jun 2026 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781224505;
	bh=h/UNjpl+taa6GDb8Q/gQUZEr/Mpo5Rn6HGWV69Uvxpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=meE0jSsQcmUW3cnuVDFbB+7jf7KhpWZ8Bnc4AAVf3WVRwml9+Nmw8KpxZ88PpE1tG
	 eKWKzERUtM71V23K3C3kSNo9FGvjCb8EiLjt4SJvsc3NKjQSvoz7JddbSel1xmRGlt
	 97iwEsr0Qskysu1WENdEFli9dlLNiJS1QhOScqCWa+eKjautymKoIieGZ5EUDaSls8
	 9q9Siw3RFdrcASy7Zl4QJqplCdewDEdR3sv2z3cPqPICzPNL65p3nOZ+TkbMha8vDQ
	 /JEqF3Vq5kW9XfhDlO3ttlTs8v5egNkFiHuJS9TYLuqEMvq9dBG5gTgd35Kyz7QGfI
	 Je+wqUlZqNyfg==
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
	"Claude Opus 4.6" <noreply@anthropic.com>
Subject: [PATCH 04/15] perf symbols: Break infinite loop on zero-filled notes in sysfs__read_build_id()
Date: Thu, 11 Jun 2026 21:34:32 -0300
Message-ID: <20260612003444.50723-5-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612003444.50723-1-acme@kernel.org>
References: <20260612003444.50723-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

sysfs__read_build_id() iterates ELF note headers from sysfs files in a
while(1) loop.  If the file contains a zero-filled note header (both
n_namesz and n_descsz are 0), the code computes n = namesz + descsz = 0
and calls read(fd, bf, 0).  read() with count 0 returns 0, which
matches the expected (ssize_t)n value, so the error check passes and
the loop repeats — reading the same zero bytes and spinning forever.

This can happen with corrupted or zero-padded sysfs pseudo-files.

Add a check for n == 0 before the read, since no valid ELF note has
both name and description of zero length.

Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Fixes: f1617b40596cb341 ("perf symbols: Record the build_ids of kernel modules too")
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol-elf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index d84e2e031d430cf5..dc48e2d2763379b9 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -995,6 +995,9 @@ int sysfs__read_build_id(const char *filename, struct build_id *bid)
 			} else {
 				n = namesz + descsz;
 			}
+			/* no valid note has both namesz and descsz zero */
+			if (n == 0)
+				break;
 			if (read(fd, bf, n) != (ssize_t)n)
 				break;
 		}
-- 
2.54.0

