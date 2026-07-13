Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF0ACA52;
	Mon, 13 Jul 2026 20:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975629; cv=none; b=e51eT1WAdZ2kVBxxqT1Lmy88pzg1Hujn8NDVgr5+B4iGPNebaI8aqP7ilszJ43/PgAs+tY3LOfkc7eph5eerBJwsKrJxzheCuQp4QR5fUkfN4ZOpYZd3+tREnbpizKitKpjYIdDIANbR6eUuBjyTEwuTG8ymyTHm3eA9Ck1JNDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975629; c=relaxed/simple;
	bh=twXJtWWH5oaghquo53bbOQw63dtMySpSvj6QkbbR8Hg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cetk7QGlOxmrkqC+F392ejgKHF76KLzar+tDpld3ak2N89Krt0mMOtwdoeZIXTpal7gtdxj2bWLZQ/E0hu/UqHZ3nHq552BTm/yvLM5giVvusLxNUPUSIa+F+PsavqjGw4CcVsbf7bK/FKxMRZrM3IvOL+tD3M1D1AU6Z5OOFNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W0bcMNBD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W0bcMNBD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825481F000E9;
	Mon, 13 Jul 2026 20:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783975627;
	bh=TDeuzjI90FLjEMS0jJqqnnMlB8u+tFcLwlJfq4wBKK8=;
	h=From:To:Cc:Subject:Date;
	b=W0bcMNBDpwU80+IzFbqdiw88bWHGzopR32rWHE2+UeqvMvfhgpdOsgIWkD+awgem/
	 FGkNHwlB/YTE2fNlJrWFF5Xr6xMRIOtCJqh5nbK7FkpMrFrI3fdJ2ONJTFZKsRZKdr
	 pdjep1e5maDcFQP62eHBlKw4mQoUArSoZVF9Pd1iQ67DwxSfdBOoKWUhND2+FWh5Zn
	 XQOsnTAPeoDGf6rZ+JWv6OaA71NO7i0Q84K1VNMh/ibrfiXjh2H2Hv5Bq+Toxn60u3
	 efimrqDnmAjiQMyDf010Xax1/bl9eRU5wkxraptnj4iHzGiZhk9CFA6Oy7UNYuri3t
	 CVO0GuzBXHaPw==
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
Subject: [PATCH v1 0/3] perf sched stats: Fix memory leaks
Date: Mon, 13 Jul 2026 13:47:04 -0700
Message-ID: <20260713204707.2181098-1-namhyung@kernel.org>
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

Thanks,
Namhyung


Namhyung Kim (3):
  perf sched: Add missing perf_session__delete()
  perf sched: Fix memory leaks in perf sched stats report
  perf sched: Free subcommand string after perf sched stats

 tools/perf/builtin-sched.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

-- 
2.55.0.795.g602f6c329a-goog
