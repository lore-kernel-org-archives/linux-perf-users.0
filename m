Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1601E7C2E;
	Tue, 16 Sep 2025 21:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059966; cv=none; b=E+MNKPL3jX79GZYQhvcBuREbDA0OBUWTnzX61/dUdOQk5AOoPlPIpYAVNs5TnHX+elK50EBsFLuHheejlTkcdaF6im3QjIVXJTf8+59GY1alSwM1xSOnSVVUcXe8OLKqlP5FaNfe48GOqaOP7G4QmfUDVZGKPymUrAPrMUrcMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059966; c=relaxed/simple;
	bh=4XJwcLtuB2K41g7CjjX1uOn3hEO0On5PL5Gc7LkE+F0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=klHC6XZ0ZswqmB827v5pxnvhvv3KEWoS9fxC2zZIcyCalWGKy5JZrzLnyASX6ggYzhAgX0SNLskXvgOc5NKgPkYhOqDBOlX7np+UF1NMwPGVpTYHgv3UiGpn0S9/TLrm83z72lNTWynqE/Wr4TMLiZHtq7sJ/8z7SLk7RwzNjeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaBNT5YL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaBNT5YL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBAD2C4CEFA;
	Tue, 16 Sep 2025 21:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758059966;
	bh=4XJwcLtuB2K41g7CjjX1uOn3hEO0On5PL5Gc7LkE+F0=;
	h=From:To:Cc:Subject:Date:From;
	b=XaBNT5YLvDy5GQ6aJz8MCi2nHZ7ADWfRUFnl1KIxqfUgrD+Mtwc2C88l8MLONGqax
	 N4aW39cFlZY+xvIREF7NjIzxNvbTWWJljU8XCy2I0Fz1FqcUywa3fi0DjVS4KejxQc
	 jtJv4b02bvVr6/EtQpdaS1Lh3iN4C/SW5eFUvthLL0R4o9LhkusDceRNHhM5ivkImm
	 XWLQeFEsuWWi4AlfD72MQpNTu3YPjcuD92QzLW6wo20QXT15IXsMsavF2XKH4XovYa
	 2btMAL2NA+kOlKm8W9TYJEymWOC3OHNKStDeK6U27Ljqy4W8damvPI8TfotZzllHcZ
	 FJaft52m1RsKQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.17-rc7
Date: Tue, 16 Sep 2025 14:59:21 -0700
Message-ID: <20250916215921.773759-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following fixes in perf tools for v6.17.

Thanks,
Namhyung


The following changes since commit ca81e74dc34734078d34485d4aa123561ba75b15:

  perf symbol-elf: Add support for the block argument for libbfd (2025-09-04 16:37:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v6.17-2025-09-16

for you to fetch changes up to 20c9ccffccd61b37325a0519fb6d485caeecf7fa:

  perf maps: Ensure kmap is set up for all inserts (2025-09-15 10:03:23 -0700)

----------------------------------------------------------------
perf-tools fixes for v6.17-rc7

A small set of fixes for crashes in different commands and conditions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Ian Rogers (2):
      perf lock: Provide a host_env for session new
      perf maps: Ensure kmap is set up for all inserts

hupu (1):
      perf subcmd: avoid crash in exclude_cmds when excludes is empty

 tools/lib/subcmd/help.c   | 3 +++
 tools/perf/builtin-lock.c | 7 ++++++-
 tools/perf/util/maps.c    | 9 +++++----
 3 files changed, 14 insertions(+), 5 deletions(-)
