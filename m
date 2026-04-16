Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C21214F70;
	Thu, 16 Apr 2026 00:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776298473; cv=none; b=eFPWB8TWL5XZmVEqJaYCVwK6GkS7HDT2mA3wGIldN7SliMBiLYDRvVDqpvJ5HNXIjZRsbjEUpO9GpMbVjWXgoAGycX9iMw5NkGopRvQfekIY8kpJz1PWasF//ln/RrlY3ap0L5xWuIdiisqF61QTq3I8G8IyjNFGFfsrVs97fZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776298473; c=relaxed/simple;
	bh=5kC8GnUxgmCosjdo8DIFn9fV60EnFfYi8c1/qAoKvfA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cDpgzNuxwBULSUd8zVr29TiDIGNz0UZ8XuJloIypz1pQjwiT2ss1yUN6/SjeCavCEI4dCYj3KziSepsvrzLS+BX7P6vnRfLCUvIJimLpJesNj6PHn1n0nFSuTo0KHV6c1LgXZJxgioErnzs1mmqua0R4FT9O6h1TCRYvMF7uvfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aAeL+YMg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAeL+YMg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5757C19424;
	Thu, 16 Apr 2026 00:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776298472;
	bh=5kC8GnUxgmCosjdo8DIFn9fV60EnFfYi8c1/qAoKvfA=;
	h=From:To:Cc:Subject:Date:From;
	b=aAeL+YMgD1Ebp1tj/L1fLcFIkbWixFaz/FYzU1Ai4Us7swDTOkhmGfb3zGmOcewuR
	 FpMqgFIt0niKK0ZUEqyoefLn5ooy7aQXk0hm+3eY7qY4yv9kmLddsbzdu/7Qbulpu+
	 qKDX4wrRh2z/cDFMS+zMji5NfvHV3zmYRhfztc6geSwCBLG4HRjfnzAkWFtjKypJvV
	 OEuhgY3+wMZ7PtHef3OzK9evQtB4sbehSD9RAEQIj6Df0ZVbPWqIBvMLUJpdXyh+Rc
	 LnSx5iM5NjmHDPHtEcjhjYNu33mAFk2hL/tMwFHfS6B6gKAVpORbn1ygRoGcPslSOW
	 8MElwPZn+cVlw==
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
	Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCHES 0/5 v2] More perf.data header validation
Date: Wed, 15 Apr 2026 21:14:19 -0300
Message-ID: <20260416001424.362797-1-acme@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

	This is picking up from what was reported in the previous
series, pre-existing lack of perf.data file validation, processing files
and buffers in header.c in a similar fashion.

	There is more to process in the trace data, but that is a
different can of worms that needs to be dealt with in a similar,
upcoming patch series,

	This is probably 7.2 material, but if feeling this can still
sneak into 7.1, feel free to do it :-)

	Now lets see what Sashiko discovers while I still don't have it
running locally right after Claude, before submitting it publicly, which
will soon happen :-)

- Arnaldo

v2: Addressed sashiko comments, adding a patch to the series.

Arnaldo Carvalho de Melo (5):
  perf header: Add section bounds checking to the fd read path
  perf header: Validate string length before allocating in do_read_string()
  perf header: Sanity check HEADER_EVENT_DESC
  perf header: Validate bitmap size before allocating in do_read_bitmap()
  perf header: Fix 32-bit incompatibility in bitmap serialization

 tools/perf/util/header.c | 57 +++++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 9 deletions(-)

-- 
2.53.0

