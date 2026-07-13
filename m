Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A923128B8;
	Mon, 13 Jul 2026 23:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783986338; cv=none; b=GyUN/RYz1OiFn+57RxEHqwJ96DFAUsm0iVshvyNBqD/iU+iZLkTDASZjAyP4xiNKMcA8EycUsqxVpO6fycv33NncJVmIlv8Or5+aTkjyYo8/DLU+s0MtKo9JH+8jGuHjjGYd7Kjy9l28PPiPruuUoarK2i8lsIdKkWEQ0kA/bxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783986338; c=relaxed/simple;
	bh=gTjsDSRK6QsTc279iMz1gaHeWDa7dHRWQcWtMpAJJIo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p6LXXrCiTpZk8QBXIE3jKodxxuYTmMI70NZcWMkvd9Z5Pku2Ukauv1/wt7m+jnhp3ZotlhNrA0nXFuaxYnmaZj7LJ5uLjZbvTLqnG7dIOidPkgEMSzEd1Sn7lPvBLTIpahcF6+VAO5dsLBZCiTVR8o/GeBVFzNPhAtAX/Bd3t4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m4dmEBbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4dmEBbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C581F000E9;
	Mon, 13 Jul 2026 23:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783986336;
	bh=1pXeM4CvLwjkYJex5SFQZwTTBNMFg+ALmq+NLH4yOBk=;
	h=From:To:Cc:Subject:Date;
	b=m4dmEBbWolcJrZrEG8NrBaSFhlCJ94QcpUMyjJYb48G82XXOl50S/ZdudxCFT1PfR
	 pT/DkYf4BXIFfGbniTSJpX76Ilh5pxBPD8oUjrOi2EsO6XxkD00dy6UOAEP5/LuMK2
	 WzwiepgcQGI92Kg1ZFCZ7tSR4wyMiKZkaLRhGHj8V16e9inrk/F3IV1aXooBDSJ6qm
	 z31D5qC2tfmCJ2l4JZjup1tCnuCkSQyuBh4FmObBrO0KzWtjxD8lJeh7kfhYLsRN+W
	 dyGpCA0LjQrKlL77Mr6Uj0KfBsYRVqniYO9AaihfxybO4jiyKRG1LUu2iofTw7JzHJ
	 v1YiZ2Rg9Sxsg==
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
Subject: [PATCH v2 0/3] perf sched stats: Fix memory leaks
Date: Mon, 13 Jul 2026 16:45:33 -0700
Message-ID: <20260713234536.2280374-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is a small series to fix memory leaks in the perf sched stats.
I've tested the changes with the address sanitizer.

v2 changes)
 * remove invalid file closing  (Sashiko)


Thanks,
Namhyung


Namhyung Kim (3):
  perf sched: Add missing perf_session__delete()
  perf sched: Fix memory leaks in perf sched stats report
  perf sched: Free subcommand string after perf sched stats

 tools/perf/builtin-sched.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog

