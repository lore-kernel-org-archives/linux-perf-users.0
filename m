Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B6A15C120;
	Wed, 18 Dec 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734559495; cv=none; b=HFL6I+h/EHHUQtFuIf0SjrsJErPJYCgJvdynsduzasIfTv81QQLF03iDrcFJQnd6nGOhBTMBYPth/sIytKr/Ofsb7i1I8SDkDtrcRTGEzqKiYhiRcUTaNPKvnL+yIUYKUqNX6oiVECvb1m8TYbYTZlUx3EIV/F0aD191iOJJhM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734559495; c=relaxed/simple;
	bh=R+51lVeknPijVqPbZj3/Uv1ec5SrZmM3b3Oj2JxFd8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JXMJCPiiyPriakoJhOQooFmjqgt8AY8OdIXf7O06ZARaGMCZmpaykCU8CHg3tMhYOpCFZ9gPBvZ3K994vczQBxJ5LQv/GNRqVmmS1KuRyXTovHu8LvojyHjEjP+z3BxF8QNxT0YXMmeTyrm+zQNa9QmKZpUigv8FIF++vr9eERI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZZWxMu2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZZWxMu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE0B8C4CECD;
	Wed, 18 Dec 2024 22:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734559494;
	bh=R+51lVeknPijVqPbZj3/Uv1ec5SrZmM3b3Oj2JxFd8Y=;
	h=From:To:Cc:Subject:Date:From;
	b=AZZWxMu2SvP+sCQL+c9Ibz/6vLAgSpPFx/gNCsXdvxHJha9MgU+Luc5cFWW7Q3nXI
	 +Y527Hg9UGpdg+XNib4y8DC0U4fE2CM0eqBoq2aRV04deO3D708T0+agOtZI3e2r7E
	 9UyWfYE989/FkJIUH+zaJJ9ghKCKuBswEYngHq4X1u9vWwlKc44NCDZgy6iaUE4rze
	 tyzq2YCcL9TXMYiQ7iNBbyHbUhJWOM/DvI2WYx4kikMqDFJsiLn2ekj/7cuq1Wy0XA
	 FgRePN5Qy4Bh3NUdcWlgjtbpPJTdt1PEVSw1oCRMWE6fB4Z99dhE9p9Vaf0qdSgSl1
	 1nyfcgJFQfDyA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Blake Jones <blakejones@google.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH] perf tools: Fixup end address of modules
Date: Wed, 18 Dec 2024 14:04:53 -0800
Message-ID: <20241218220453.203069-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In machine__create_module(), it reads /proc/modules to get a list of
modules in the system.  The file shows the start address (of text) and
the size of the module so it uses the info to reconstruct system memory
maps for symbol resolution.

But module memory consists of multiple segments and they can be
scaterred.  Currently perf tools assume they are contiguous and see some
overlaps.  This can confuse the tool when it finds a map containing a
given address.

As we mostly care about the function symbols in the text segment, it can
fixup the size or end address of modules when there's an overlap.  We
can use maps__fixup_end() which updates the end address using the start
address of the next map.

Ideally it should be able to track other segments (like data/rodata),
but that would require some changes in /proc/modules IMHO.

Reported-by: Blake Jones <blakejones@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: Daniel Gomez <da.gomez@samsung.com>
Cc: linux-modules@vger.kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/machine.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 27d5345d2b307a97..8bb34689e3ceeec4 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -1468,6 +1468,8 @@ static int machine__create_modules(struct machine *machine)
 	if (modules__parse(modules, machine, machine__create_module))
 		return -1;
 
+	maps__fixup_end(machine__kernel_maps(machine));
+
 	if (!machine__set_modules_path(machine))
 		return 0;
 
-- 
2.47.1.613.gc27f4b7a9f-goog

