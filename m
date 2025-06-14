Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCAB02E11DB;
	Sat, 14 Jun 2025 04:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749876221; cv=none; b=q1lAbtzNQ8l+qGHIJtxcG/Pc7latTQJHBPyX2i4oEFIxc3sDXfKtJxdWZDmnCBdozblsj/Nb0gkgd9zHQWXdnJzq4bPtY6VdSnhMzRnjC2BVxrdddzso0cGL1UCm3Sh1DvVwQH94Tba1xs3v37kqOPQs2xbhxSQQ0bmSMAnc3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749876221; c=relaxed/simple;
	bh=mlZHXgtFWfZA6JABbBlri37rpv/BirGA8Ph3KVbw+9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRs6wBAh/HPRulrZ+VUnceOqkmeTTGQnTG40bu44574eXznctotCAHWaQFuVAYkW7SEiXmmeoxHLNqBRtZ85aBnDwLlt0La4EaifBDY1ZgAtiQCvHHo7uzztjgpPPRym9ouegDJe2gKakB1PHmsJxEZAS6Tlpuf93XATMr7CJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRRQWqaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRRQWqaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3509C4CEED;
	Sat, 14 Jun 2025 04:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749876221;
	bh=mlZHXgtFWfZA6JABbBlri37rpv/BirGA8Ph3KVbw+9E=;
	h=From:To:Cc:Subject:Date:From;
	b=YRRQWqaOVrTPezTS4wSZnpZskt+BI1Wy6zUTTtSSIk//YLFWwQyFS0QzCOSvNUEmJ
	 DVB7rJB6y0vxAuaWxwg4YDbP3097mub6tuAFyz5gS7/yJOFHQpuKp66Zk6Zlpo/j7s
	 OKZnlsr2FfCls78cIoZkR2tpbaeokQQ9QBanRqGSxaBbMMsRXcYzPRzsDDYoRF2j82
	 LxitOcPUGuGDSLStlW5GISM4vnXC6CJSOZ6vHuA6d41kdDssJV4ecSXaF+2b9nyBGx
	 uMa5Edy7LfOOIhOYXDtSDcJ3gmY3n3WPP+4iJSvH89XbO3SfNhs1I82yaB5A2n1t5O
	 saWQ/zwyno+lw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Liang Kan <kan.liang@linux.intel.com>,
	Yuzhuo Jing <yuzhuo@google.com>
Subject: [PATCH v2 0/4] perf: Remove libcrypto dependency
Date: Fri, 13 Jun 2025 21:41:29 -0700
Message-ID: <20250614044133.660848-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a reworked version of
https://lore.kernel.org/all/20250521225307.743726-1-yuzhuo@google.com/.
I've changed it to add a new minimal SHA-1 implementation, instead of
trying to pull in the kernel's SHA-1 implementation which is not really
designed to be extracted into userspace programs.  I also added a test.

Eric Biggers (2):
  perf build: enable -fno-strict-aliasing
  perf util: add a basic SHA-1 implementation

Yuzhuo Jing (2):
  perf genelf: Remove libcrypto dependency and use built-in sha1()
  tools: Remove libcrypto dependency

 tools/build/Makefile.feature            |  2 -
 tools/build/feature/Makefile            |  4 -
 tools/build/feature/test-all.c          |  5 --
 tools/build/feature/test-libcrypto.c    | 25 -------
 tools/perf/Documentation/perf-check.txt |  1 -
 tools/perf/Makefile.config              | 17 +----
 tools/perf/Makefile.perf                |  3 -
 tools/perf/builtin-check.c              |  1 -
 tools/perf/tests/make                   |  4 +-
 tools/perf/tests/util.c                 | 45 +++++++++++-
 tools/perf/util/Build                   |  1 +
 tools/perf/util/genelf.c                | 85 +---------------------
 tools/perf/util/sha1.c                  | 97 +++++++++++++++++++++++++
 tools/perf/util/sha1.h                  |  6 ++
 14 files changed, 156 insertions(+), 140 deletions(-)
 delete mode 100644 tools/build/feature/test-libcrypto.c
 create mode 100644 tools/perf/util/sha1.c
 create mode 100644 tools/perf/util/sha1.h


base-commit: 18531f4d1c8c47c4796289dbbc1ab657ffa063d2
-- 
2.49.0

