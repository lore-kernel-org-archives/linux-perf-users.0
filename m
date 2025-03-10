Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E915C288A5;
	Mon, 10 Mar 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741635941; cv=none; b=RRhkKYlcga8C0RBZOHsoSmULcaAdxNiIb5xYicueX47f3smYr2jsqgvkv3J2nnNFUmJyRW6b3SpML4YbC7irbToCkePWwuHqE0Xw46xunNRrGA2SmwTHB1vtpN9PcyKtviU9KUpUqrvlBdfDD9CGuXvnzUJrTgexsBetDX0SMwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741635941; c=relaxed/simple;
	bh=gM2+5tc0EOJVPYZyuyU5TV8pj8lS4LzGvMcCMoNTiCU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XQS5tCN3q78jPcGpStg2MkHMvFWohfNVbQQOSVvR1aYu79u2j7AWWmcIXFlaKY6J8RpqUpW5CJkiz40Btl5tYKa2TeZ5sAX+7f+/P1w4YTv/17BnbS4t+Z1GyYUgcqh6HKmXxKfexRZuOYVR4QRM6CYOWT3bPpfXsU8GnJYqHzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHmwYuIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHmwYuIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87096C4CEE5;
	Mon, 10 Mar 2025 19:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741635940;
	bh=gM2+5tc0EOJVPYZyuyU5TV8pj8lS4LzGvMcCMoNTiCU=;
	h=From:To:Cc:Subject:Date:From;
	b=dHmwYuIrVkX2BBsYOBKjZH97YZsROP8t/nOtlgWEzhm5MKNzAKApoAdE19qAJSg18
	 Fof/XC3JcJXMo73lcYzlGgWPvcpN37uwuBzBsqtNJuEcij4lk9GsNJklMwNFjKKmF7
	 VuUN5SMoyUDJe9VcQg5JXgZNn3LKxgir85/OJTI0Ahc9xGt2aCTTta+xQIeLyfYU/E
	 aOnW1/At66ssO5MRuAFE/x/pMVQtE9bBlJmqZIEqXNRti9IMd2At3M/j5aLpwB5wz4
	 TO51RNIgoPcWaFMgE0JEbYAXk5sr7dNtzOsCPcL2Kqxv8vhhxjjFQIjB3ZTad5nwcJ
	 cZPWpxTYvopNA==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 0/3] Some build fixes
Date: Mon, 10 Mar 2025 16:45:30 -0300
Message-ID: <20250310194534.265487-1-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi Namhyung,

	Some fixes I noticed while building with my set of containers.

Best regards,

- Arnaldo

Arnaldo Carvalho de Melo (3):
  libapi: Add missing header with NAME_MAX define to io_dir.h
  perf units: Fix insufficient array space
  perf hist stdio: Do bounds check when printing callchains to avoid UB with new gcc versions

 tools/lib/api/io_dir.h     | 1 +
 tools/perf/ui/stdio/hist.c | 4 ++++
 tools/perf/util/units.c    | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)

-- 
2.48.1

