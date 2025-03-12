Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4537F1EF0BA;
	Wed, 12 Mar 2025 20:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811518; cv=none; b=ujoMgPEser+WVNCmW6LFEuiLKFfc3HEVhtR/BzcN0E6fHi1LZsVuwE8NFw0fCc6VptQcoXys93ZN3a1yGqKBxDBw6ar/aEn7gF2YqB/WHQU4B9iw6bacG/vAuVliL5g0xy9apr9/BaM3NCcRdXWWU5b1ZfGVupBM3hugQ11YxM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811518; c=relaxed/simple;
	bh=D4ZmBfnR5++/ReQIqJTxBZ11pl2EfSik2080N1gHruc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvuniVx/ZfwGiEyhbgnWrRSYDgZ8QwAnKFlcTEDUnjCcw4pI485k2aAGLmBvsjMk1tfHtjDljNyUSkJQfLacI7qbWLAcq4iXGTtv3KmbZegHOChSRrY0rc8lmRB4v1nsUpBc56Mi0eRfS+Ez4eqNz4tIUr98iL/K8zRGf6bIEwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SA321C+s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SA321C+s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CF4C4CEEB;
	Wed, 12 Mar 2025 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811518;
	bh=D4ZmBfnR5++/ReQIqJTxBZ11pl2EfSik2080N1gHruc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SA321C+sUTtud+pT+L2sgI7u8s1OaaCop/ORHtUt1z1IbbMzYkwM7O9/iUVF5nAwf
	 8/8eC+rc4BeaOxt6Sn3du3JNLu0vK47G4zOgXcicZHCsI8EQJFZ20vA2N0K9EAHJKF
	 SgnNvqYILB7aYQIDYcuAtv4IDlyofcq3NpV3eyRyaS2/CAFo1KSa9GSNppnSQkz7Nb
	 4ih6qkZGpb5pnWBYtZ09sM99bdJaxusgrnEM5s8+WMqk7jqoTpYqe7W8eoyS8w3k5E
	 IpYkBNxCPC27VHQXUe8lPKsQhZbsQcEfYHtmwmopzbELrNPmXAfL+UmpSBc20SYz5H
	 deHYkt2MPMQmw==
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
Subject: [PATCH 3/6] perf python tracepoint.py: Change the COMM using setproctitle if available
Date: Wed, 12 Mar 2025 17:31:38 -0300
Message-ID: <20250312203141.285263-4-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Otherwise when debugging we see just "python" in perf, top, etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/python/tracepoint.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/python/tracepoint.py b/tools/perf/python/tracepoint.py
index 38b2b6d11f64566a..15b0c82689966f23 100755
--- a/tools/perf/python/tracepoint.py
+++ b/tools/perf/python/tracepoint.py
@@ -5,7 +5,15 @@
 
 import perf
 
+def change_proctitle():
+    try:
+        import setproctitle
+        setproctitle.setproctitle("tracepoint.py")
+    except:
+        print("Install the setproctitle python package to help with top and friends")
+
 def main():
+    change_proctitle()
     cpus    = perf.cpu_map()
     threads = perf.thread_map(-1)
     evlist = perf.parse_events("sched:sched_switch", cpus, threads)
-- 
2.48.1

