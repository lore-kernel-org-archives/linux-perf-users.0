Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BEC1F4C8E;
	Fri, 10 Jul 2026 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783712545; cv=none; b=I+j8vItjzfy+U8gS4rjSkW4fpPsQSqrYcMGLfGSg2Iz+ZSnKOp/r/dUxdIgDQiWpw7o9VSEkNdl8BtJwZQSYA4V0IGsXTkrKlQH/NWr1GJFIn1kDV/TSrxAdTzuvjYMXsLbzPqxbBRd6CzU8id+Mq4HyQbjE2rGhz+I+ChTjPNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783712545; c=relaxed/simple;
	bh=G5oHIz4tAxUa6k5FcWQfgu1sS2zdano6cxaykdLKJuI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUH+zdP1B58EG9wHM+ILFqbHvsqdXsNihf4QQCL/xglZJ/nz7794Sl3BO5nkkxk0rfd/vSPB1busRNLs+LTjNs03AxrYCJLh/qS7S8/OQlfzZ/eiFBzTtfOATpyVzQyH9jKSUQRzJKJ6dF9tAyDBO97oH9vGAsvC2aGdE0xjw9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NujVjyeo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NujVjyeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF641F000E9;
	Fri, 10 Jul 2026 19:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783712544;
	bh=LO0zqHOJ9dSjyHF51rObfpXQMN44T/Au8VwL+fLVjEk=;
	h=From:To:Cc:Subject:Date;
	b=NujVjyeoFYXoCqtyCLv/Qrk/xbkO04Pb9mbd9l0FEodWH1FrtP8kWJPs1QyHjwwG+
	 /WgLDqI+IMTn7HQ4rG4GuBU0blPg/TefFqAVyccfrC9nTWXu9rBe4VzlsSs7jp469e
	 i6RdQebokaV1frHa5Q30kgAx2s1mRL8fSuwfEil61J0IaJhro09PCQjoQOtLBYKm80
	 9scdli/qu0blAPWwGUCLgsxHkyKmBYIXFCgkPCsxQn7A5pa4jcBS1+EjmOrFidLN6/
	 CqlUlmoaD0Z+LbhWTtA4ny/rsVlm+e8g34Z4ME182oQX4qNsP7h0cikGvRI/fxlitY
	 qio6T8WZ7Cxfw==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jiawei Sun <abyssmystery@gmail.com>
Subject: [PATCH] tools/lib/api: Check nonfilterable in fdarray__filter()
Date: Fri, 10 Jul 2026 12:42:22 -0700
Message-ID: <20260710194222.1788638-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IIUC fdarray__filter() should check filterable events only and leave
non-filterable events to be handled outside.  The recent change to set
fd to -1 made perf record test stuck forever.  Adding the check the flag
fixes the problem for me.

Before:
  $ timeout 100 sudo perf test 105
  105: perf record tests                                     : Running (1 active)

  Signal (15) while running tests.
  Terminating tests with the same signal
  Internal test harness failure. Completing any started tests:
  105: perf record tests                                     : FAILED!

  === Test Summary ===
  Passed main tests : 0
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 1
  List of failed tests:
    105: perf record tests

After:
  $ time sudo perf test 105
  105: perf record tests                                     : Ok

  === Test Summary ===
  Passed main tests : 1
  Passed subtests   : 0
  Skipped tests     : 0
  Failed tests      : 0

  real	0m52.472s
  user	0m0.830s
  sys	0m0.535s

Fixes:f94563fac269 ("perf record: fix poll storm when monitored threads exit")
Cc: Jiawei Sun <abyssmystery@gmail.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/api/fd/array.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
index ffe8272af59b2da0..b4570e4981492cd7 100644
--- a/tools/lib/api/fd/array.c
+++ b/tools/lib/api/fd/array.c
@@ -117,6 +117,8 @@ int fdarray__filter(struct fdarray *fda, short revents,
 	for (fd = 0; fd < fda->nr; ++fd) {
 		if (!fda->entries[fd].events)
 			continue;
+		if (fda->priv[fd].flags & fdarray_flag__nonfilterable)
+			continue;
 
 		if (fda->entries[fd].revents & revents) {
 			if (entry_destructor)
@@ -132,8 +134,7 @@ int fdarray__filter(struct fdarray *fda, short revents,
 			continue;
 		}
 
-		if (!(fda->priv[fd].flags & fdarray_flag__nonfilterable))
-			++nr;
+		++nr;
 	}
 
 	return nr;
-- 
2.55.0.795.g602f6c329a-goog

