Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E62D7BF;
	Sun,  3 May 2026 19:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777836703; cv=none; b=h8ZLSgolhRVosMSzQwv1tcs8kj9pz6VCSKKbHokKH8WWTlIlsSVmPdEatyZS6TgLyCNNxyZ8/Cwi2X5TNlvWkSKM6vbbl2zALGtO/iXywRQvwkE9/gQipEZG+s67SxHqsGfRLWDodJ82GgJauVaT8dC4+mGlkVEDXA2puog0qMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777836703; c=relaxed/simple;
	bh=PMcjjpa1IBOYloxfWcXjNVTZHzaLTaESaMUONj5gf+g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y5sTsD33kRGao7DYpseY/MZx4oo9tadHUAHwC2yHvU14FQfima4Ofj++KwJEfFnNhB/IcdrULZ2tCexiPH/MFpGMXAOoVV2tvGQjgSgDmYBGrsRXXeQmd+tgNRvrf4S2Z453XhuIqesfJyAAHNTjM6wsN3mxohe8ENVb9fS8N+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipbZnnOl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipbZnnOl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE129C2BCB4;
	Sun,  3 May 2026 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777836703;
	bh=PMcjjpa1IBOYloxfWcXjNVTZHzaLTaESaMUONj5gf+g=;
	h=From:To:Cc:Subject:Date:From;
	b=ipbZnnOlgKOz9mRxU9tyJrOVqOHiReDUJMjWcujTzmRVlccSZNvIHA+uUYjfkXky+
	 Yc4V/TF8aKHV4pTBzBZCtJVPVefS/kh6qwnrjkdwpkwL8BSUuztuGOv06bDDiaJxlu
	 /xzs+jRBcf7h60jrIEFtHufqxER6jJ0oGq3xW3fX1N5ppcqq7AdSqh17In0pZZFVi2
	 uuKOaufQOgmoeC8vJ3cI6bqb8M9zqrWD6uaGKsTycXPyV1wYBZ4NdhM4YR2buNdk7x
	 IIM6+cIdBP2ISSAuscGiUyrLlKA90rXqwfsjJrQDCprSHXdAL/wSgFrLWYHssJj97j
	 WCr3r2hj8o2OA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Ravi Bangoria <ravi.bangoria@amd.com>
Subject: [PATCH 0/5] perf build: Update kernel headers
Date: Sun,  3 May 2026 12:31:32 -0700
Message-ID: <20260503193137.27465-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is to update copy of kernel headers for v7.1.  I've updated ones
in the tools/perf/trace/beauty/ and left others which seem not to
affect perf syscall beautifiers.  This is suggested by Linus to avoid
unnecessary builds of objtool and the kernel.

There are AMD IBS changes that are directly related to perf, but I
think Ravi is working on it with other Zen6 changes.  So I didn't
include it here.

Also I removed the header difference output in the default perf build
and added a new make target to check it explicitly.

Thanks,
Namhyung


Namhyung Kim (5):
  perf trace: Sync linux/socket.h with the kernel source
  perf trace: Sync uapi/linux/fs.h with the kernel source
  perf trace: Sync uapi/linux/mount.h with the kernel source
  perf trace: Sync uapi/linux/sched.h with the kernel source
  perf build: Add make check-headers target

 tools/perf/Makefile                             |  3 +++
 tools/perf/Makefile.perf                        |  1 -
 tools/perf/trace/beauty/include/linux/socket.h  |  2 +-
 tools/perf/trace/beauty/include/uapi/linux/fs.h | 12 ++++++++++++
 .../trace/beauty/include/uapi/linux/mount.h     |  1 +
 .../trace/beauty/include/uapi/linux/sched.h     | 17 +++++++++++++++--
 6 files changed, 32 insertions(+), 4 deletions(-)

-- 
2.53.0

