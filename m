Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F5E21638D;
	Wed, 24 Jun 2026 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334734; cv=none; b=APhQGHhGxZYsxL6PwR4kbRfbCBPHfcOVMJROCblhUlK08j6A/Dgtm5H/fUoNwAr7cN0dyMTTKiDvlJEMw7hKj7u0jPSndCpXxhz6kJahdwkBeznKJScDOilWGoBAr1VrAMq6YCwSAydXsOTJBBsb9/FKyowilcBw/xTXPZvv9A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334734; c=relaxed/simple;
	bh=wzVdNEgHHuQ8O2Uo4dpPAMN7mZUj9GuHCz/g/KLqpcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=liqErdVXp9E3k9+V4poWx8dTWkrpfkorMm6GkoeZYqRcZF2wfaBQc3gce/JNqNBCdWFOWYgSO8XKoTAPAukFSUdFfFWic9ySuHJKSN08hTClQiZegHwT+p509Zp2U9ouhhrftmtt3ltRS/EgOI6jEbJcj9xI5OWr9tIMl7LrOq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXtywF++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXtywF++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03251F000E9;
	Wed, 24 Jun 2026 20:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782334733;
	bh=kmEUdIYMMXphddrS0rAdNquY3vJ8sEBXzbtsIsDP+/M=;
	h=From:To:Cc:Subject:Date;
	b=JXtywF++ATvwcLLoAgG1va+NfxHkp546Oo1cA8/KG/JhH8AxgskpEhjJfMa2In8XF
	 oKb0eqpbzSR9lq7aUx7NhIMWpqBRqNwrm9oZ5yCxqg6u7MlAS35+ewVPmlmD/yjLDF
	 FNHBgOwwI5DPAiXhjwTSY+QfZlwyrvzKy7jZsXwyBM9K5xaRUEC0/KoanqNBfVUHjA
	 2JgwszdOElHXrW0x3sTBuzyz4SarVYpyezJHmvfREjMk8izbjS+nUJR8Q3HbP/abrG
	 IgcFkSOx5lCHTaUm0VW2M5AXF4cYH7z4l39gu7UYkDmicuC+SOFLp/1E9TJmLircw7
	 wNDcaAforNLVw==
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
Subject: [PATCH v3 0/8] perf timechart: Fix memory leaks
Date: Wed, 24 Jun 2026 13:58:26 -0700
Message-ID: <20260624205852.3864874-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patchset fixes memory leaks in the perf timechart code.
I've extended and verified the timechart test with ASAN.

I'm sending it with my previous work on backtrace optimization.

v3)
 * combine small optimization series

v2)
 * use zfree() and explicit clear for potential misuse  (Arnaldo)
 * fix a wrong condition in the draw_wakeups()  (Sashiko)
 * move misplaced hunk in the second commit to the first

Thanks,
Namhyung


Namhyung Kim (8):
  perf timechart: Don't pass @event to cat_backtrace()
  perf timechart: Generate backtrace only if needed
  perf timechart: Remove unused backtrace in trace_handler
  perf timechart: Remove unnecessary copy of backtrace
  perf timechart: Release event samples at the end
  perf timechart: Fix memory leaks during record
  perf timechart: Fix memory leaks in draw_wakeups()
  perf test: Update perf timechart test

 tools/perf/builtin-timechart.c      | 212 +++++++++++++++++++---------
 tools/perf/tests/shell/timechart.sh |  24 ++--
 2 files changed, 158 insertions(+), 78 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

