Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C93480356;
	Fri, 16 Oct 2026 14:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161120; cv=none; b=YHG6hrGV4JGQtrTf7L2MGM3pGRgVPam+HRRrUjJFZ2+V+ft6DOUXQ1v7qBopTCELIvu4FGPvMWZiBsr8lKzWAPf2+huTAoH+TIahAsgyfiHtJtOW663pdFWfvRrQ2ayzYevNr4RWojvb/6+FfbJV59s684LufsDq08ElH0+poKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161120; c=relaxed/simple;
	bh=D+lZEc5wTtYRJ8cHF4/QePBhwF/rALbiJH3zwQb0+E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsCbEzmlsUVpyf+ACdKdwegGHFzjGp0sXwsOknlQQkhOQq7JxMqdfZEs8JqyVrE2PgMg0EIPPLadP/ALP9gFsH8hqBLUre0xr/q+nYvbf/FS6kT1+ODs1PcUXrCVHoK1UzSl0stIXd9BFMCj9UakREUuQyFhwlAcPLEWXEdvt0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMleMs2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMleMs2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E32B1F000C4;
	Fri, 16 Oct 2026 14:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792161118;
	bh=h6GtHFasplHpf1gaf8Qe6/5PEC9X6FmStaixdFf6ChU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AMleMs2bDWG4lVy9UDCWToFyTUlcYdSmzyYqYR/7baowctzXG1Z3edapRNYigHwZT
	 Q+lOg+RPuEGT48nLfMrn7amcVIVfYm1XnfDm1BtffYPSwWU2rSxBKsje+nR/3LeE6X
	 ME3eeOfbC8a6G6ivm42oLDu8uLARkDnJyTJySuk/P6aPi6tusobNwCq8+foUjp1/Gd
	 4KGg7I9QUnp9Tyty5s9suDN0jE5ZCO+1Eoj/AMCv5Gks/+dIj8qfkNA5RMhUsVh4pf
	 /U0+mmKcb6KKYJ33LAb2EG6+rFD5OlFKa5SiPPLSVYuW7XsIlbCBCoBoyQM/lUUfkd
	 v8QRTIZ/tDGRg==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 6/7] kbuild: build the tools selected in tools/Kconfig as part of "make all"
Date: Fri, 16 Oct 2026 10:31:42 -0400
Message-ID: <20261016143143.3613501-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016143143.3613501-1-sashal@kernel.org>
References: <20261016143143.3613501-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_TOOLS_BUILD set, make "all" depend on tools_build, so the
selected tools are built with every kernel build, and allmodconfig and
allyesconfig builds catch changes that break them.

"make vmlinux", "make modules", single target and external module
builds are unaffected.

Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index af5d0a9d51df9..1c55086ea5c8b 100644
--- a/Makefile
+++ b/Makefile
@@ -1638,6 +1638,10 @@ PHONY += tools_build
 tools_build: headers
 	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
 
+ifdef CONFIG_TOOLS_BUILD
+all: tools_build
+endif
+
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
-- 
2.53.0

