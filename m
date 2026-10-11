Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802446C849;
	Sun, 11 Oct 2026 23:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791761818; cv=none; b=aEqojDJzoc0X5mQAzzqju/GbaFpqu2QI8KralCyzksBWdeQgWatIfMP8sWPLYn7XPGGreESrJij/GjWX2DDqTLiZ5y6dYxzFNnTDfxtVbVV/x8wzhhuF1mmphAv8dw+GRuXuDzNUBULMoosAG5krpVOS0nONpF0+v6ba7IvLsv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791761818; c=relaxed/simple;
	bh=D+lZEc5wTtYRJ8cHF4/QePBhwF/rALbiJH3zwQb0+E8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9rkecpHNPotps/acT4k9ysCdxddwG2L6LfbdUj95ve4CEAw/BlPJGfiWuDRVhwZtUF6+WNA4WC3Gh1lgSCZTD6fDzs6xmTYy6hRFOWwittMunuDSAVpLYZ9g1ggLhdu96jhJci5KIY5wJEABjLD/XK6UVTA3ZawffFYIDOvk/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nK3jhylg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nK3jhylg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38461F0089B;
	Sun, 11 Oct 2026 23:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791761817;
	bh=h6GtHFasplHpf1gaf8Qe6/5PEC9X6FmStaixdFf6ChU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nK3jhylgzr+V6lg2cuuuHNIhxAAXJSiFcXg6rckO1CX4GUmAB0EFv+J+Y+RyqGNBO
	 HacL4WfKkUqBqVLrIKl45MxaQwEglZ0ebV4lxagD7B8ycX5U3bQqFy2j9ZmE5TeQEB
	 b+DL3b/K0/3z/r8Tnk5uabvje+BIinzx1fLHKTE7D8eOXSZkVhjp/jSkxVUkefRelC
	 W7V5FuCpjCTN99enIzHWjtfl01S1yXyNjCNeJrH38qSuUXPeAlvpOnV3WNX3FwBFox
	 V9QUBTW7maQMOrQe3nOzOPHgW8wHsXIGS/boOY0OvWZmq/M8uJzJ29t5QkcJZPhNXl
	 iyyPQKTmLyVEQ==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [RFC PATCH 5/6] kbuild: build the tools selected in tools/Kconfig as part of "make all"
Date: Sun, 11 Oct 2026 19:36:44 -0400
Message-ID: <20261011233647.2454648-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011233647.2454648-1-sashal@kernel.org>
References: <20261011233647.2454648-1-sashal@kernel.org>
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

