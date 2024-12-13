Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E383118E025;
	Fri, 13 Dec 2024 19:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734119459; cv=none; b=ZQzT22yTdJKof6MieGdursrU+bgNr5egg8TvfeYBhV4pUyMZD6ZW4MYVUtG0Z3pweUatWuXu/TQUreeTrPU8uCMpX1/GAk77XAQN2pizrlaOZsYbMyMehKajPB6kXW6fm3B17QVVpl5dXEgfGCDqPkaRNUFG0xROna+TnaZ4/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734119459; c=relaxed/simple;
	bh=qoTfGgpOj/Ulq6By5ZbCyaPeLiAwlfZQGTZu6vJxAbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2tQAeI/PJZm7hi1SCKwXhxQgEKqmvN/W26lJ5XH9M6NLi622uF4qabxunRj03aWm6oFIYY7kPCMjqo5Z0VB3fL5fm5bvepxY6sc1FHAHj2d989EwG7aN7MeGMhmphmJP9d+0ugAQMBy9eO2aAkz5hUyYNGZ2dXyjZK3mZYNCDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/CfWHe0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/CfWHe0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D2FC4CED0;
	Fri, 13 Dec 2024 19:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734119458;
	bh=qoTfGgpOj/Ulq6By5ZbCyaPeLiAwlfZQGTZu6vJxAbM=;
	h=From:To:Cc:Subject:Date:From;
	b=I/CfWHe0Jr1qDZZWX+JpQ3Imj7z6F5tArBSgwFIARuuM8xNKRDC1nywPT6phUIAYt
	 jWvn5ZJ8KjB5aCXtcBobrsIDS3HtqHrcQSxtk/77qe5ozkFik49ZDk38GfST1HeXt7
	 UjkTe5+FhtSA2fqLvtwS+0I5D8Wt/8KE+fz53SRfu6+/d8khYiB6ET8zoA1XgXLF61
	 MYruA4Ssu9bfO7sK8ctH2D+eh137KOlZY7GkOignySrm55IqZnsn25dxEnESkbJn42
	 bWaxOGGLJU4DZefhpJfS4uFzpYU5v+uvzPQ/CZstDtU68ZDwuFOH6cT7M2H4aXseXY
	 wOnG9moqcEGow==
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
Subject: [PATCH 0/2 next] tools build feature detection fixes
Date: Fri, 13 Dec 2024 16:50:50 -0300
Message-ID: <20241213195052.914914-1-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Hi,

	Some more work on auditing the feature detection fast path.

- Arnaldo

Arnaldo Carvalho de Melo (2):
  tools build feature: Don't set feature-libslang-include-subdir=1 if test-all.c builds
  tools build: Test for presence of libtraceevent and libtracefs in test-all.c

 tools/build/Makefile.feature   |  1 -
 tools/build/feature/test-all.c | 10 ++++++++++
 tools/perf/Makefile.config     |  2 --
 3 files changed, 10 insertions(+), 3 deletions(-)

-- 
2.47.0

