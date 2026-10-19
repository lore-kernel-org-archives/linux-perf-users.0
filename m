Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D29485CC4;
	Mon, 19 Oct 2026 05:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792389233; cv=none; b=McNInmDKXZevNZd4YMahD3cUlswdaoezgDjrsygPhmIcktbO/ZjF0x+zUw5/oa+e4RfQOWkzZmXu1KRmAbNqKAMvmRICPetWke2Wsh9nulHPKjxOJP1HeMnRn+Z3oNfXS44wsRnuQY/Ylz55SpKp6irTUM0K4ioWUhpeD5Zbc0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792389233; c=relaxed/simple;
	bh=P5188q1z5CrZlSOqgtBYKok1fR0XM9TAgpBefNGkUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSXJd/w+98Lmeek8owKl8FM2NmSzTDf+3VzpOuXtR51XKURC+mWViGuGJRw1S+Myk9c1MsT0rnhvb6ICIRey3PAtMex08sPBjHd1+USZZISoIUj/1QNCYTafzsi8AF0oCkOHBryE4dWdkXA9Q/sQao+hLxCo87EAf1ZPYwy352I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffg0XCSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffg0XCSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E6641F000CD;
	Mon, 19 Oct 2026 05:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792389137;
	bh=SvLhb8bjYvaiY0iKG/6v2VqUDl5XgpF3cnObQraUIzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ffg0XCSBx0ZtnCHZ7OGZmXUJkY4c9YC1fIgovo6CT8ullTu+hY970wlht4Z89u7o+
	 2bZGF0xdAKCwD/JZBcgE9Nx/gH/mYMMhdLMKHFwzAjim8W2BJb25WNV5xHqD2M5bSQ
	 +cw6oq2eoLQJNoZKh6jRidJnXIgmmRsybXyGOYU5cPQh3ha4NhPS/hzB+zMd8IMbKB
	 ibe1R2FF3kQcElklAImC3wH/YLDJ+RpLGGowBc1yxKYMYH8ljjzV/FImnRDKqwPalr
	 uv0idW4D9dlDuPVL3AAqgj17zVHdA28pKaEk8Q9HFx8nP4L7rbW0JxX47sb+QVEjtL
	 FCb7lOEBSGxkg==
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
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v2 5/5] perf symbol: Ensure dso__set_is_64_bit() for libbfd
Date: Sun, 18 Oct 2026 22:52:07 -0700
Message-ID: <20261019055207.39325-6-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019055207.39325-1-namhyung@kernel.org>
References: <20261019055207.39325-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Otherwise it can confuse cross-platform analysis.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/r/sashiko-outbox-168776@kernel.org
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/libbfd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/libbfd.c b/tools/perf/util/libbfd.c
index a4dcb406c79e9cee..45fd70c4f7e11cd7 100644
--- a/tools/perf/util/libbfd.c
+++ b/tools/perf/util/libbfd.c
@@ -462,6 +462,7 @@ int dso__load_bfd_symbols(struct dso *dso, const char *debugfile)
 	symbols__fixup_end(dso__symbols(dso), false);
 	symbols__fixup_duplicate(dso__symbols(dso));
 	dso__set_adjust_symbols(dso, true);
+	dso__set_is_64_bit(dso, bfd_arch_bits_per_address(abfd) == 64);
 
 	err = dso__has_symbols(dso);
 out_free:
-- 
2.56.0

