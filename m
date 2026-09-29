Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F82BDC0F;
	Tue, 29 Sep 2026 01:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644307; cv=none; b=FWrGVbDQSUBz02cfubWGT+WWh/MAITR21SEoLQQL6DCrFVAXHBu2K5616+Z892A0d9iLcpfk3bQ3RQ/6BEkifkISyrULn9bHHVku8g4luBub3C7mUssQpP1CZdUg5AZCH7TUp55BUlNxvyHUcF9OxFeVYnpP2NNK9ve9OXqq17M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644307; c=relaxed/simple;
	bh=0CZsXtdJmyufQ/dCKhjk+OMSUrmia72ZixXHWg9MEL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZHidBQmlBAScY0E0IkGNw2V5x5mUaENqMhW+N3pSlCe1m3hmN1T/GOFq0sb+w8WrUtWXHy3r0sJl12klAFVG0VjEFKKPp/Iwd5DZ2u3hsK45PbYcPR+uXRY0ATSh3hIgdPsNt/58555KGKlC7FfLURm62EuDJXW3a6h37DazB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DU6vAYQV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DU6vAYQV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BED1F000FF;
	Tue, 29 Sep 2026 01:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790644305;
	bh=10xKHwDvbJASAl4/xS+1/Lb20/iATxaO1Z+bJ05coPE=;
	h=From:To:Cc:Subject:Date;
	b=DU6vAYQVrliQk6TvDyeBPq5aBrlSChmoOi74KRn6dJait40/JeiMB3lW86KtSBcAb
	 6xacyLFSTOUexkfZJJpaxCMBbbyM2B/ygllsbNNzx6akahgTLoW//eZOgQa7PAGlv8
	 U1FRPzLgGs442wguerhmOFJxdx2VNe77gBe8CCoca08OGHSIaZ6qQXEASfmNItPRy2
	 5t9wxXWyaXGtVSE1XWzhp7aNZGLDLdb3AnegekwQqBeRsb4syVu6/AsJK/Ay0Uj44K
	 T9bis3xlexDqomoCq7P/uSc31ivcfdecRr1AgmKp2OGVxw0d1m2PR274tMd3QCi6Rh
	 /J+SttlXNd3jA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2 0/8] perf tools: Cleanup dso debug info access
Date: Mon, 28 Sep 2026 18:11:31 -0700
Message-ID: <20260929011139.53242-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a preparation for DSO file access cleanup work.  IIUC DSO
access has three types - symbol table, binary data and debug info.
Those information can be placed separately like stripped binaries and
split debug files.  I've added dbginfo_type to DSO to track location
of debug info like others.

I'm sending this out before it grows too much.  This patchset focuses
on debuginfo open path.  Once it looks good to others, I'll update
other places accessing DWARF info to use this info and cleanup other
file type accesses too.

v2 changes)

 * check .zdebug_info section as well
 * slightly change the order of debug types

v1: https://lore.kernel.org/r/20260928055055.95144-1-namhyung@kernel.org

Thanks,
Namhyung


Namhyung Kim (8):
  perf tools: Add dso->dbginfo_type field
  perf tools: Factor out dso__find_dbginfo_type()
  perf tools: Check system path when check debuginfo
  perf tools: Export dso__get_filename() with type argument
  perf tools: Add dso__put_filename()
  perf tools: Avoid repeated failing search for debuginfo
  perf tools: Looks symbol file first when check debuginfo
  perf tools: Update debuginfo__new() to take DSO

 tools/perf/util/debuginfo.c   | 51 +++++++++-----------
 tools/perf/util/debuginfo.h   | 13 ++++-
 tools/perf/util/dso.c         | 90 +++++++++++++++++++++++++++--------
 tools/perf/util/dso.h         | 33 +++++++++++++
 tools/perf/util/probe-event.c |  4 +-
 5 files changed, 137 insertions(+), 54 deletions(-)

-- 
2.55.0

