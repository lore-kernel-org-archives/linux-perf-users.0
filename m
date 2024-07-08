Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9405D78C9D;
	Mon,  8 Jul 2024 15:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720451306; cv=none; b=Q9C+EJAvOjGnOCNPbL0gynVzuLQNiwPTTRkBEBPF0qCRHe2zRuF2E0EltkdGbL/SvwWyJV1T76H+v1F46OBH2i/tI29P3fzGx3o8T8VspD7gbkR0+Vk/p9oSsQFPFxlDKSvGBMPnzahzAB0q7321LL9PD6LfJXdtDsp2GslSxVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720451306; c=relaxed/simple;
	bh=FR7jjvSXa/ZvMmA3hkEdqnmuyyo9SUfn1KCnFEf/n9s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HhyyKbGenk0ww7gTktl/KhWLiOLKLgQ69OjqYunglrYV62KbI3KGUF7sjxxN7miHSieZyzU0U+EuXu8M/koYikuxBbhinsG3UfH3an2gdsQSKC9Vx4Fw0cvFcJLP1WNqhzQ35jLBmSVExP+kvXlrCkAztGjf8uJvtp8wP6RWmV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWuKePE8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWuKePE8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43D3C116B1;
	Mon,  8 Jul 2024 15:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720451304;
	bh=FR7jjvSXa/ZvMmA3hkEdqnmuyyo9SUfn1KCnFEf/n9s=;
	h=From:To:Cc:Subject:Date:From;
	b=fWuKePE8b3zo10AiOZEeozCNx9hhka7TALHkzQzjoC8OudOum6Niy8p9QHX3Xx6mc
	 7e1i99PNeEjJlgYKvrA1vyBcy4JIIKJGUFWkuKSt4JpLUzZUgrTAq+3p/jnteFo7iF
	 0e73t4qEl+gr3lYnYCYnlRUraw9t+pgl+mozPstCP6IcuTOfkEobzZEFJJYNt+qkF/
	 ZkhDps8Gl1dEOLaBD/oSr8j/OQgOuN9647BPg/3meUgqBETn5RFhn3pN/RPmEk706J
	 Td7NEUbrKO9FAvS5AUip01b+IA061W5bfjXVU5rdYdYiKqxHlS0pZ9NL5G7NvRxf7M
	 8xAvfCs+uOfeg==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools-fixes for v6.10
Date: Mon,  8 Jul 2024 08:08:20 -0700
Message-ID: <20240708150820.404000-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.10.

Thanks,
Namhyung


The following changes since commit 83a7eefedc9b56fe7bfeff13b6c7356688ffa670:

  Linux 6.10-rc3 (2024-06-09 14:19:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.10-2024-07-08

for you to fetch changes up to 7b2450bb40275802b73593331b0db2fc147ae2b7:

  perf dsos: When adding a dso into sorted dsos maintain the sort order (2024-07-07 22:26:29 -0700)

----------------------------------------------------------------
perf tools: Fix the performance issue for v6.10

These addresses the performance issues reported by Matt, Namhyung and
Linus.  Recently it changed processing comm string and DSO with sorted
arrays but it required to sort the array whenever it adds a new entry.
This caused a performance issue and fix is to enhance the sorting by
finding the insertion point in the sorted array and to shift righthand
side using memmove().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Ian Rogers (2):
      perf comm str: Avoid sort during insert
      perf dsos: When adding a dso into sorted dsos maintain the sort order

 tools/perf/util/comm.c | 29 ++++++++++++++++++-----------
 tools/perf/util/dsos.c | 26 +++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 16 deletions(-)
