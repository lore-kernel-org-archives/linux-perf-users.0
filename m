Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657E13C9EF1;
	Thu,  1 Oct 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880861; cv=none; b=BkAV/5JJhUCLfx0Sg6XhDa+FKfj+0/jfU8KNfafDbYrX/xHr+48avYeoDB2mEB0GiT1kG+Ey4Z4lOMpRxUubfARRHOnicbDD3YThvAIjtCFjrl5o1Hi9NxUPlLy5E3+VUGO9Z5R+0IVNTsCe98rwLdlAYo9YJjlk01QOJ+k8nCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880861; c=relaxed/simple;
	bh=Dgh3sRdHf2PcYrdOL/7o0iCt97LnQ5tUH1RA4taB/Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xu1GLlx7Nma05oBgmHaWb2qnnNY1dbJVqigheUeZEKCVoP+A1DXW1ZzPAvZArfjHBIXuNa8D3EnG1IyTZKjuFZ/IZs9vJUgsE/np6MNIPGNMyVBer31FjVQ6iNA45HVbu8Zyi3qsFuWHAr0MdIOFNZjTfyvXU1Ytb2/CColf6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nDXsf9k3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nDXsf9k3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB441F00898;
	Thu,  1 Oct 2026 18:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880860;
	bh=OBKP8NmwUjXwEyDc9gSaOA3RTicUkdI0rDQMOs+pZHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nDXsf9k3Vb/UDgiYk8XjDWOKjrs664nF1qZjfELF8fHAJcTec9ryjbK3nQ84WivKC
	 S2kAKK/vIJGvUhPOzLeIxpNjr2hbHOLGoB+gOMPT13uhEFD5k6eT+yNcS8G6bQc36g
	 bn2QULgObHVemk04JfyGC8zpm69UK883ZyV1CP+Q8Vlv1e8380GFoEE2qnlRcIGEQ0
	 xPitanH6yimmnhidBXzTly3Brxl1V13v9aoLBRU1HrjjhqR1lYHouk+A5Izb2oAEYc
	 8jBA2e2LTi4DDO//kH5rqdsuNiF0NFVub782N5H2saMfAaYU6k7PTKlXk/CbkrmVve
	 h3JSjVX8UmSgA==
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
Subject: [PATCH v7 3/9] perf mutex: Add DEFINE_MUTEX() static initializer
Date: Thu,  1 Oct 2026 20:53:54 +0200
Message-ID: <20261001185400.2754753-4-acme@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001185400.2754753-1-acme@kernel.org>
References: <20261001185400.2754753-1-acme@kernel.org>
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

