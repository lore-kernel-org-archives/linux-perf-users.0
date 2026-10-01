Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA8842122F;
	Thu,  1 Oct 2026 18:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790880865; cv=none; b=MX6VhGStmQwZ0KwcxWSPltzJuIyZhkclOwmXtuaTtBsMbemxyINR2FJdT8/Th4FR1Q3+kMVh5FRwUj0AfPXMmwjymqFAGw4I10o6uwqNlM+nBeqTfDDVCJ1qaISetJi/bEeIHdWGQVn9ssEBBBWuLjWuchgYZfyTL72BSErB4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790880865; c=relaxed/simple;
	bh=tmOLRhJ/wVy6QMEKFBf7nu/AAA3kN/A6CBISnDIVv9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XtX9bMS1rfNBj8obxQnQzCCUhQZqPV6VR72YquCTxTK7DIfBXzidv5gG4enUmD4InQ/Q2UvX/Qf63MWPIFlH53ydqYJPoxsEeLhL0LJI8Z2Hwu3M5y/v2IbQpwFIgHKvqeXDgT/548Q1I8jEcTN1Es4WMlsOE4SqnmIRxKozag8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXsZrhwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXsZrhwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93C011F00899;
	Thu,  1 Oct 2026 18:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790880863;
	bh=k3PB4VXc9btsIZyuEobSXeM/lcAKbTJyqxM2CjADxMk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HXsZrhwvvM3rMvmNgxomZkead5h7jmdvv4Yi/YhsZR9HDXEzbaCZgLfl3hYKCbCik
	 to32UaeoYGkSTwDLE4NRXz5IW6gxOue+Ax9aUmYkkXjAFOVuUUyS3CyFODsl6s0a2U
	 qrAiJBJ6RvNIiBoS0vVqa3EfWbUV2QmnEhQFxa0zKNoEb/w6YJVLQRVVTbZsxqsjuS
	 jO+rtlOIvDT14S/9F2eQlKASLuugDkRG5mLp6HkxUj0Iia4qXIOTUKtxIGehzYV+Bs
	 FptPZZhYPiPcPdv5S9vj++3yQrI0pjd1YSmpAgZ3N7mbDAMOtslRdiceVjCNYg+utF
	 H+L2MlOpReLiw==
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
Subject: [PATCH v7 4/9] perf mutex: Add DO_ONCE() for one-time initialization
Date: Thu,  1 Oct 2026 20:53:55 +0200
Message-ID: <20261001185400.2754753-5-acme@kernel.org>
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

For lazy init that more than one thread can race into, without
pthread_once() so that it stays within perf's locking primitives and
clang's -Wthread-safety keeps an eye on the mutexes involved.

Mirrors the kernel's include/linux/once.h DO_ONCE(), dropping its
static key fast path, unnecessary at these cold init paths: a per call
site static bool plus a statically initialized mutex, double checked.
As there, code reachable from more than one call site must go through
a common helper.

Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mutex.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/tools/perf/util/mutex.h b/tools/perf/util/mutex.h
index b85a80ad60386aed..87937970615ff675 100644
--- a/tools/perf/util/mutex.h
+++ b/tools/perf/util/mutex.h
@@ -95,6 +95,29 @@ struct LOCKABLE mutex {
 /* Statically initialized mutex, for the file scope ones. */
 #define DEFINE_MUTEX(name) struct mutex name = { .lock = PTHREAD_MUTEX_INITIALIZER }
 
+/*
+ * Runs fn() exactly once however many threads race to it, the rest wait
+ * for it to finish; per call site state, so multiple sites wanting the
+ * same once use a common helper, as in the kernel's DO_ONCE().
+ */
+#define DO_ONCE(fn, ...)						       \
+	({								       \
+		static bool ___done;					       \
+		static DEFINE_MUTEX(___once_lock);			       \
+		bool ___ret = false;					       \
+									       \
+		if (!___done) {						       \
+			mutex_lock(&___once_lock);			       \
+			if (!___done) {					       \
+				fn(__VA_ARGS__);			       \
+				___done = true;				       \
+				___ret = true;				       \
+			}						       \
+			mutex_unlock(&___once_lock);			       \
+		}							       \
+		___ret;							       \
+	})
+
 /* A wrapper around the condition variable implementation. */
 struct cond {
 	pthread_cond_t cond;
-- 
2.55.0

