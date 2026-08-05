Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3D046F4BE;
	Wed,  5 Aug 2026 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936701; cv=none; b=udgUxJe/7N39vAt1O7iABxN7gX0/bnKNs1ZpVqjAGEg0XuxicQ3dkoZkfBsP0H8VBquYOxciBHLd0L7vO35vAw9IWmuBfU2iF/WY7WEiL/3mwkqjIMwN/GK+9m/UK0N6kR/pK0UfMYdlOXgqc8pObdkduffVBh+aC2jUZ+X6J9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936701; c=relaxed/simple;
	bh=ikFrrWyhMBfQZqRUpaRPSY0QmwmGXvUmdIyzmUukMGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBw+/cqkAf2C+//CXD2lrUKEPvNe44g90WKm0+NlWIsxGey+7i7rtph3fWIqtJnL9eJSn0DPf6q7hYc47yc4XkElQPT8I1JcKLAEc7ciTRX6+a/A4FXDLJEgX5kIuFrXjH56F6Jdb/UdpIhbTuPTc1ZAAjX7/4Qutk1jxYz2Tqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXkMWRBW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXkMWRBW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6515A1F000E9;
	Wed,  5 Aug 2026 13:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785936700;
	bh=SVk7zPpKJa5wyALqfhsZ+WOrOVCyDvZ0JgLmgyEfUfM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UXkMWRBW9E9QlAidu9FmIrYhq3S3qvgkw6qOs9MHAPmlDzLYvlx8JR/Xd4qmKjpt1
	 bzdZkRxVn4UtnXRVsw/Bm7jtMv9isIeEkKvY99otYAft4LM93F5gyZ1dIMH/SpNpPy
	 tqehzcsBG+x+jGpTwtFUl6nA7k5jE6jMdT0aitXvfgVrN7ULa90ViWMV32SVi3bZsA
	 KaUTNSCS36fCm9K/vT3qdNIAihgbAolJ6T178X0wHYBwaMPVTpmEbXObJPj2WlkHsW
	 BoHTcLlq2BC+MR+X7FNlU+svtzbgGBHxxUuS4j3cv60mrj0jDxMwzyRWBnOW0cJxS2
	 hJIs1pcxooQHw==
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
Subject: [PATCH 05/12] perf jitdump: Check snprintf return before computing header size
Date: Wed,  5 Aug 2026 10:30:04 -0300
Message-ID: <20260805133013.235016-6-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805133013.235016-1-acme@kernel.org>
References: <20260805133013.235016-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

snprintf() returns the would-have-been length on truncation.  When the
jitted filename exceeds PATH_MAX, the unclamped 'size' value inflates
sizeof(event->mmap2.filename) - size into a massive underflow, causing
the header.size computation to write an oversized header.  The
subsequent write to 'id = event + header.size - idr_size' then corrupts
the heap.

Clamp size to PATH_MAX - 1 after snprintf in both jit_repipe_code_load()
and jit_repipe_code_move().

Fixes: 9b07e27f88b9 ("perf inject: Add jitdump mmap injection support")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/jitdump.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/jitdump.c b/tools/perf/util/jitdump.c
index 078d3304d2b7ebce..fd11e07bf00b7978 100644
--- a/tools/perf/util/jitdump.c
+++ b/tools/perf/util/jitdump.c
@@ -493,6 +493,9 @@ static int jit_repipe_code_load(struct jit_buf_desc *jd, union jr_entry *jr)
 			jd->dir,
 			nspid,
 			count);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= PATH_MAX)
+		size = PATH_MAX - 1;
 
 	size++; /* for \0 */
 
@@ -623,6 +626,9 @@ static int jit_repipe_code_move(struct jit_buf_desc *jd, union jr_entry *jr)
 	         jd->dir,
 		 nspid,
 		 jr->move.code_index);
+	/* snprintf returns would-be length on truncation, clamp to buffer */
+	if (size >= PATH_MAX)
+		size = PATH_MAX - 1;
 
 	size++; /* for \0 */
 
-- 
2.55.0

