Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FF128504D;
	Sun, 10 May 2026 20:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778444632; cv=none; b=G/qQoHf/PV8/0hZraedM0pf7ta0fPhmdo4Lc9myOHFEfV6bJ0y80jfCUEOiq6rmaH4pKtNbiRN0wzzcbHKmn0dcTtv7VADeKrZlSxt9UwkSk/A3DZbYDJSJDsfLvsSlmcVc9OcKvVLdj3JoCnctJ6w9O77x2gxVpvMvawxrZKhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778444632; c=relaxed/simple;
	bh=OvcQP9a8wh6KWBN3eVIM1RUWCZZWvm8d4oOc4luaL9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DEAfsTQHs3ItoxjFP21Dx7hl4CZxaBrDFdrCor5CHlWDrJG6Ei7W0DFvd6iaw1s8ycFezNXgunrUfcDMFHoZ7Nd3+aqg2xXuaDrmlBXALtjoOkyG0Wtqks8wKY72+u0/Y7DWFAFWueg6lCDjScJ5T7LKGLiHzOC+hDo+LRFPwZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3T/kXUF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3T/kXUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076C8C2BCB8;
	Sun, 10 May 2026 20:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778444632;
	bh=OvcQP9a8wh6KWBN3eVIM1RUWCZZWvm8d4oOc4luaL9k=;
	h=From:To:Cc:Subject:Date:From;
	b=n3T/kXUFcIUa52jtJlOhxxN96XcW1SJK/41CchGRRx8rrnsXPteIm7NY8SuQC+IK9
	 KGy1KvO/dX1FrY32I+5ENPDqsHKos+s8uUyvbOoQwxguTT2cGnc89xm0Ju7kvulDp+
	 HATYLIfcAfjjHk8QShrSYYp5Ang5qxBSAlyutbmjlc8e6iAEtyECURkearpWS2j227
	 zIdtZqbHvgeh6T+5rgrgaVl7JsmrzfMjTjkXBSqv1Da/c8Rdb9tmkO2p4ufTtavvgV
	 VvG465rqgg8lDe0eLtPlfGh26ap08R3aMvugWYdjq6Ts3OCxzDIdvKdzZ8boOWofxx
	 F9ytUZoLYtPYA==
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
Subject: [PATCH v3 0/7] perf build: Update kernel headers
Date: Sun, 10 May 2026 13:23:39 -0700
Message-ID: <20260510202346.49853-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0
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

Due to the header file changes, some beautifier scripts for perf trace
are updated too.  This was detected by Sashiko.

Also I removed the header difference output in the default perf build
and added a new make target to check it explicitly.

Thanks,
Namhyung


Namhyung Kim (7):
  perf trace: Sync linux/socket.h with the kernel source
  perf trace: Sync uapi/linux/fs.h with the kernel source
  perf trace: Sync uapi/linux/mount.h with the kernel source
  perf trace: Sync uapi/linux/sched.h with the kernel source
  perf build: Add make check-headers target
  perf trace: Add beautifier script for fsmount flags
  perf trace: Update beautifier script for clone flags

 tools/perf/Makefile                           |  5 ++++-
 tools/perf/Makefile.perf                      |  9 +++++++-
 tools/perf/builtin-trace.c                    |  9 +++-----
 tools/perf/trace/beauty/beauty.h              |  3 +++
 tools/perf/trace/beauty/clone.sh              |  4 ++++
 tools/perf/trace/beauty/fsmount.c             | 18 ++++++++++++++-
 tools/perf/trace/beauty/fsmount.sh            | 11 +++-------
 tools/perf/trace/beauty/fsmount_attr.sh       | 22 +++++++++++++++++++
 .../perf/trace/beauty/include/linux/socket.h  |  2 +-
 .../perf/trace/beauty/include/uapi/linux/fs.h | 12 ++++++++++
 .../trace/beauty/include/uapi/linux/mount.h   |  1 +
 .../trace/beauty/include/uapi/linux/sched.h   | 17 ++++++++++++--
 12 files changed, 93 insertions(+), 20 deletions(-)
 create mode 100644 tools/perf/trace/beauty/fsmount_attr.sh

-- 
2.54.0

