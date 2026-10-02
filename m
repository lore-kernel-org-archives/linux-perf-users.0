Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08AB840DFC8;
	Fri,  2 Oct 2026 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936517; cv=none; b=ISrmmerItkFmV1UKWcrVUbiFt+Kkbe+bANPLzF3WkAJSGBM0fnsy+nBFqs+18fYsOPeyRYmdRSBxJWTil+D2HvR3INalbN9di7WXl0xDW9JTqLv+Qy/UFMz95R4hgtg5yUb48GiuW7oF8pECe29eCWoLbv0BN7Ta0JXLyCF9TwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936517; c=relaxed/simple;
	bh=Dgh3sRdHf2PcYrdOL/7o0iCt97LnQ5tUH1RA4taB/Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fL8gyl5584caMAZ7GFUQEs7tchupbxyU+UnXYjQ2P3fkDW3yaUn+LQz1FZxSgm0hQS1X0Er3KWRwIONbPyvSpl2FsNf/WFWypEKcA0TYS/q0dBdoWS6q8D8NGA67O36xxYz+A88sLjgmQYa3DsWrUM2dVd1mnfhcRcaoYKFZO/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxoFYLlp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxoFYLlp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F371F00893;
	Fri,  2 Oct 2026 10:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790936515;
	bh=OBKP8NmwUjXwEyDc9gSaOA3RTicUkdI0rDQMOs+pZHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hxoFYLlpNOR6LuS+a5zUeStWdqYng5oS2ZI8TqGnutpCBFQ7dEn3wAOAP8LZgZIKa
	 TW0l3N9RMXiD1aIRWH/cNEZG/hVNCPfWJUxP46ZOoX5jy6cei1ZAxYxk6/jDCTeuER
	 wg/TztGuptSBB9iMEYQqx//OCtwFJaKELqH2dg3U+yDvR8B20mGvkaXBmM6P+1QeKe
	 gWs86mZV1N3wrCnyfLEAjrZm6hmBy316sdV9ewuhnubHpn1YtS2fFXMzvJoUj1ry4q
	 N3cGWSTms0uYl2gWW+qkuKXEJ9J6kudXjIX1R1XURL4Z32q/ABlImj3qJxzu4LI80H
	 YT1cLWnEqHxwA==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v8 3/9] perf mutex: Add DEFINE_MUTEX() static initializer
Date: Fri,  2 Oct 2026 12:21:04 +0200
Message-ID: <20261002102110.27587-4-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261002102110.27587-1-acme@kernel.org>
References: <20261002102110.27587-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

For file scope mutexes, so that they don't need a constructor function
to initialize them at startup, mirroring PTHREAD_MUTEX_INITIALIZER
while keeping the clang -Wthread-safety annotations of struct mutex.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mutex.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index 70232d8d094f8bfc..b85a80ad60386aed 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -92,6 +92,9 @@ struct LOCKABLE mutex {
 	pthread_mutex_t lock;
 };
 
+/* Statically initialized mutex, for the file scope ones. */
+#define DEFINE_MUTEX(name) struct mutex name = { .lock = PTHREAD_MUTEX_INITIALIZER }
+
 /* A wrapper around the condition variable implementation. */
 struct cond {
 	pthread_cond_t cond;
-- 
2.55.0

