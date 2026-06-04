Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597A33F8A1;
	Thu,  4 Jun 2026 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780609773; cv=none; b=PW3+4lsxpxRF3BrQnHQJwTD8SXzAOVR09sneMXj9h/UkAzNoasbjFtdOi4BsdAGuRbsOZfuOGPgxyTnDAz4v8alkEaarlbseV8CQDSdgl0omkiv8xMEj4m5ci0PUfeJ2tKms5ggPJStf+dypguov5ldUIiCK/0uREmQ2NEteUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780609773; c=relaxed/simple;
	bh=sFcNX4wzNfQIligz+Bj9mKw0+HVTQx9uBEqxL+Ycsdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L4FkIuaCFG1XBN40Z9QwKpLoNyGAUGDSrZkDhbZ49VhgbuizpzlG/Gu3kShybeIQS6D29MgIDFBRIgxdvvNdzrjpiWeHqbJQmoS6/knJaDROKX9t00WshAiT1TxngSXIl3TeP5FFdTVToPCjgM7M4k7C3tV7GOJBMuVSXkLcdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AeNrLJq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AeNrLJq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 213891F00893;
	Thu,  4 Jun 2026 21:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780609772;
	bh=uuI0EPIlpwFgjFIkqr01k2NHIDzpzpZfixXgCqozEIs=;
	h=From:To:Cc:Subject:Date;
	b=AeNrLJq8Xy7RvNAlEvqGajzwbmoTwCa4JUe2sHkZu30FrI0jM5HsvfVxdZv9Yn44h
	 THU3KmMrxESLu4ydDq4PpOJVFGPTeFYaIcgqnq+9iR4zxWYdhy/RHv0aJcF5tDwDLw
	 qN94FQJ5O70PgEN+xqR2HsXrVR07EMYifLFc3vTgSYcIRNQTL7xooZOAbuyXi0RZYm
	 llCjiNNYmrSmMvJPhlevznO4p3zig3JNsVBe45vak30lJdgp53Fd0f4n0N8H+38Z+u
	 S/fvXSQbQSpRwxk2LAeXA+PtrfvwK1uJfMmUpJgizVpwjRICCVMiGvw4UuVSoKXHxc
	 EXPtv8JmP8NIw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v2 0/4] perf timechart: Small optimization for backtrace
Date: Thu,  4 Jun 2026 14:49:26 -0700
Message-ID: <20260604214931.2202322-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I found an issue int timechart backtrace handling during the last review.
The goal is to reduce unnecessary work in generating backtrace string.

v2 changes)
 * fix memory leaks when backtrace is not used
 * copy backtrace when it's used twice

Thanks,
Namhyung


Namhyung Kim (4):
  perf timechart: Don't pass @event to cat_backtrace()
  perf timechart: Generate backtrace only if needed
  perf timechart: Remove unused backtrace in trace_handler
  perf timechart: Remove unnecessary copy of backtrace

 tools/perf/builtin-timechart.c | 107 ++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 55 deletions(-)

-- 
2.54.0.1032.g2f8565e1d1-goog

