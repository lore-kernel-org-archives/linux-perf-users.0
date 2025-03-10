Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AED288A5;
	Mon, 10 Mar 2025 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635944; cv=none; b=iNlnuJCHMVf5iPWpHOIKNbqRt64uU1kUAuuSBxtpxTlU8lsG6dm+87iqJrzSw3ZEEUR6k4Vmxl1q38C9BTUXLu6Yu7FL2pDPq4HtfJucmKa6yS5Sb36sDa1dAVR2m2KmGlhVdg5UcNl+J9h3waZLOKuU8tud06s91WtCX1c8FyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635944; c=relaxed/simple;
	bh=l1FDuMJU96isGCHJ2N/qe2WIo8RAdJvFaAqFz1/i3ss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n0SbeV5yP3NdLtQreG3pJqAWfIHUGkiS0V44CDl1h09le+F6Xlee9V8B8eyCTV6AeG5o4w2u60RM4ZtZLHvqlRI3HrszH4anBi4vElihMsb/O75RR2YLKYidxpZSYw1uQBoLy7N5oH/9MH7NSWRCsm61hH1i6+UW25sPaXD4k1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMHZn9Rl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMHZn9Rl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF4C6C4CEED;
	Mon, 10 Mar 2025 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635943;
	bh=l1FDuMJU96isGCHJ2N/qe2WIo8RAdJvFaAqFz1/i3ss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aMHZn9Rl0i73zM/IkFCkp7C0K5LW0ruLdDYgibz/N09NX1MBYPxP6QOVrWelFeba1
	 hYMXwqZVtJtczD1dH8Trr8WMSaA2JNtf75/2HzF0PvoIO1e3Kj62hL5C6nFzjcjcZo
	 6QlEh2p4rgCVFYc3wSTabT9D3NgzWpMJMaBoplWmW2tA/tpRewYcDPVP6g0viFIQD8
	 dQLlb/Cen36cGKeh7y8E+KEWeoMqwB7E3ZCibjT7mrPP5ZxUtBgVPK8SEQQi4NLAjo
	 AZyvqqMSCmqQ9Wc32rOzeZI9UB8Ww/9Ain4UEEerUVC1U4ycoDKnbN35y8h3VrZqhD
	 gzgqMWh4IBx8A==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 1/3] libapi: Add missing header with NAME_MAX define to io_dir.h
Date: Mon, 10 Mar 2025 16:45:31 -0300
Message-ID: <20250310194534.265487-2-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310194534.265487-1-acme@kernel.org>
References: <20250310194534.265487-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Most systems get this indirectly, but some odd cases (some musl libc
systems) can't find it, so just add the header where NAME_MAX is defined
to avoid that.

Fixes: d118b08f7eee6d6f ("tools lib api: Add io_dir an allocation free readdir alternative")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/api/io_dir.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/api/io_dir.h b/tools/lib/api/io_dir.h
index aab73393d2a217ab..ef83e967e48c59f7 100644
--- a/tools/lib/api/io_dir.h
+++ b/tools/lib/api/io_dir.h
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <sys/stat.h>
 #include <sys/syscall.h>
+#include <linux/limits.h>
 
 #if !defined(SYS_getdents64)
 #if defined(__x86_64__) || defined(__arm__)
-- 
2.48.1

