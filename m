Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A51376A00;
	Wed, 10 Jun 2026 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121167; cv=none; b=k+uN41A7JoGawKp7mqlrYfzfVFMKlXmnyjzd8uCGnpcwoaSVHpx/YFRmJTKaqePtJKnKEC8qND63X65bew+NFNb78Cjf8F6cB1gQ0GeNTpF/FzBrxXrnhe4HC0Q03Gc3ANYQLNBSTMIXw7KxjrBzmVauVs+4W1WbZjqzxkibscM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121167; c=relaxed/simple;
	bh=U8XUsMdBiSeRXn8BD1bxLHaGXk+cYzuPq1b6LICmGqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6MPKcwH+kymuT9j24zUToqKPRx5TVYDv6AqfpgXlIxkxRqj7nJPFsl4BqOZvC0wS8CJg04WBp8VmcN/9d+op3opblQwdjT1j5wIKYNN2Zs1VBWatREbH3XKdnQtU6kmtR7q/yyNSv4tfkjqD5dPghMJcPhJHHhoknbEjSEOL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=USwvGME4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="USwvGME4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8562B1F00893;
	Wed, 10 Jun 2026 19:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121166;
	bh=PZqBrR+wuBd/vnC+O1nigshQyObWcwPc/K+wvFXXE+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=USwvGME4mEP4/yh+tINJgTXAd1a8XmnkS0ObOl/epZZFb/U3kki6TpPQhxR72h8dH
	 p6Ge7SBWLP+9bQ4/1pl2nziaA1M4pXPhIgMZ90nzZqyM90ZJWdNjv31tRckQPSnT8Z
	 8OncELySZv7nY+WrOXTPBIhxTuOPZLl8dy1/ZQiRssoCooFY3VY3vJ6QGLX4G8Nrf7
	 yT/f3aI5Ga6tq9ogf+b8vjhPWGXQVOHtpQP2wC8ho8C5Vdn18JRo9iAsSH4qQhFeVm
	 jam1WK7mYkPw/zqBzWAQXa6neOSpsxroiVvuHZTENceBaD3iiWx87FGFT1cS0o1rqF
	 IkmD8mbObW5Aw==
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
Subject: [PATCH 08/23] perf tools: Fix thread__set_comm_from_proc() on empty comm file
Date: Wed, 10 Jun 2026 16:51:41 -0300
Message-ID: <20260610195157.2091137-9-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610195157.2091137-1-acme@kernel.org>
References: <20260610195157.2091137-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

thread__set_comm_from_proc() calls procfs__read_str() then strips
the trailing newline via comm[sz - 1] = '\0'.  procfs__read_str()
allocates the buffer before reading, so on an empty /proc/pid/comm
(reachable during late exit teardown) it returns success with sz = 0
and an unterminated heap buffer.

The sz - 1 underflow was the original sashiko finding: it writes a
null byte before the allocation.  But even with a sz > 0 guard on
the newline strip, the unterminated buffer would still be passed to
thread__set_comm() which calls strlen() — an unbounded heap read.

Fix by treating sz == 0 as failure: free the buffer and return -1.
This is consistent with pmu.c's perf_pmu__parse_scale/unit which
already treat len == 0 from filename__read_str as an error.

Fixes: 2f3027ac28bf6bc3 ("perf thread: Introduce method to set comm from /proc/pid/self")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Assisted-by: Claude Opus 4.6 <noreply@anthropic.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/thread.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index ba33c0dfc18fe242..e483ffcb5d937fbc 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -295,6 +295,11 @@ int thread__set_comm_from_proc(struct thread *thread)
 	if (!(snprintf(path, sizeof(path), "%d/task/%d/comm",
 		       thread__pid(thread), thread__tid(thread)) >= (int)sizeof(path)) &&
 	    procfs__read_str(path, &comm, &sz) == 0) {
+		/* sz==0: read got nothing, e.g. race during exit teardown */
+		if (sz == 0) {
+			free(comm);
+			return -1;
+		}
 		comm[sz - 1] = '\0';
 		err = thread__set_comm(thread, comm, 0);
 	}
-- 
2.54.0

