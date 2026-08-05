Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5FB471D1B;
	Wed,  5 Aug 2026 13:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936722; cv=none; b=HHEhT+IYY/JNGhWKMI4Uv8ldT4tUv6+OvWKNkM+o9Oqt5mUjWAG5SA9iTcupFXpm9NRwT5MX8JDz4EM0JWFifEvERy6nnDCdFPFCR8BhIhwfPFyAXbswMHleQCLBAUVFmLZiKiNa6T5Lv1VaJJ14JP8EoaUw4+T23WMa8dLmAqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936722; c=relaxed/simple;
	bh=xF81jda+5dqYafQlyt1xrp7a0Ji5p/BUDTIbscvLN8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ezl9e9hpPyctsOa7EbJge2yN4u7y0uzQXAIk3qQHRc9dtYv6E9O3jN4PmbPeZ73LHv3OtAt0px/ip4rvB5zBAO8tmbHFQ7eennZXCQOMs6brKb4bis/jSDCanhZav3419VMib0hPlf2I0z1VALdUtJ+IUzFEQkX9ekWNzBWxfaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkzto8yk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkzto8yk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C46F1F00A3A;
	Wed,  5 Aug 2026 13:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936721;
	bh=iuGw7UmKVJcSVp1OPKsiB3Zy+LN8qE51vkEEpa+vI+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fkzto8ykWHQBFrLG4VuMczmt9hoBPJ6GEGCLPjspmzltwN49Urcn/0RMQgnteNd4M
	 Ejycuqmzo1JFw+lCSz9jzCeW7hoCcp0UdZkD4b7aGx4/hXo/MJOvljyYTk2oB9wnkR
	 abbHsm6pjX0KOCgFv90lbsDmQTWk+sZUH5bXRBu4fGcEVgPBR5kid+To98qTWR5OUl
	 rHZPoWaoI4XQcU4xb9LmoECR46rSLRvdQtC3p9zp4iMzUy64ZT8bclJy+d+I0Rs3zC
	 xLuKZf+Bf/J0GBL9mJ2GeIrT7U2IEzA8oyDLLzfOGDJ8MRMRsVhzlyJ3Sb4NVX26m+
	 DKtpSwvdo85sQ==
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
Date: Wed,  5 Aug 2026 10:30:08 -0300
Message-ID: <20260805133013.235016-10-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
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
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 3085091b95a517ae..02840dbf8a1fc16c 100644
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
+		strlcpy(jd->dir, dname, PATH_MAX);
 	free(buf);
 
 	return 0;
-- 
2.55.0

