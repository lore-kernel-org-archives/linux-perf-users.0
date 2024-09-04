Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8649140E37;
	Wed,  4 Sep 2024 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725476743; cv=none; b=UDXRUeCsr2EdKMWXO0v0wsiL1+1468JxPs5Y32Z7o4RRgy1F1oV6X/jGSCApBBFQf8UBzlyoXQRdpOxm7oDR8JCK/10fPpFWAume1BX5EQGhuvIX3eDiZptSlwwqlP/zQzP25gGOpbiGXd/vPI0RqQkkh2Rsy3qWYk3c3OYRW4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725476743; c=relaxed/simple;
	bh=luk6gtaB7f7vYu1sx+cmxl7AuSMpS2NE1lnhPOz4NaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdefA9R/bVbDnwo9tFk/LHTIjeOv5ES8uBg1PNBLpyGXIwAAcJszd3GWgaAOkbtqsC1EEfOBasBvjbKGFNWk5eIUOJcz3OYFYMWVmMAqY204Q3/2fxAeIlbm3FhoSyT9U2ZL30TegR233T8C5ONvPOgEfzDI5wbDU3Lld7ei7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io1BvRbd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io1BvRbd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 732F9C4CEC2;
	Wed,  4 Sep 2024 19:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725476743;
	bh=luk6gtaB7f7vYu1sx+cmxl7AuSMpS2NE1lnhPOz4NaA=;
	h=From:To:Cc:Subject:Date:From;
	b=io1BvRbd4wOD5RcY+qw0KqB8DaLaXGiJjGudf8tm9fQmcoqBmEOVLdvCNndaDaEvg
	 rB1a38fnyox+i9+XDgFI0CIt6m8uEuJ6ED3PHMuwk/pJFWDnGGS2BainojZZTbFW+t
	 vEmnlAYp5p1FPwIhkgIEXTMKXbUDIleCwW41pZ0lojUZHot04BnponovAtmryzCqch
	 Bwpeg8JowJZgiuf46AX8se92qf+QBed+6g6IZzCmsT1NX00Yae5/MVt95TYEozEth6
	 6VL6CXSSTg6JBdnlgPl0iJUEfmLY/A1AxFMaur/ualbn/w39TQ3S9GdcJyvBW5jYqr
	 uYGJxBQo1nbxg==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v6.11-rc7
Date: Wed,  4 Sep 2024 12:05:40 -0700
Message-ID: <20240904190540.4086525-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.46.0.469.g59c65b2a67-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v6.11.

Thanks,
Namhyung


The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git perf-tools-fixes-for-v6.11-2024-09-04

for you to fetch changes up to e162cb25c410afc42051a582c46a47dde597f51c:

  perf daemon: Fix the build on more 32-bit architectures (2024-09-02 11:59:24 -0700)

----------------------------------------------------------------
Small perf tools fixes for v6.11

A number of small fixes for the late cycle:

* Two more build fixes on 32-bit archs
* Fixed a segfault during perf test
* Fixed spinlock/rwlock accounting bug in perf lock contention

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Arnaldo Carvalho de Melo (1):
      perf daemon: Fix the build on more 32-bit architectures

Namhyung Kim (1):
      perf lock contention: Fix spinlock and rwlock accounting

Veronika Molnarova (1):
      perf test pmu: Set uninitialized PMU alias to null

Xu Yang (1):
      perf python: include "util/sample.h"

 tools/perf/builtin-daemon.c           | 8 ++++----
 tools/perf/tests/pmu.c                | 4 +++-
 tools/perf/util/bpf_lock_contention.c | 3 +++
 tools/perf/util/python.c              | 1 +
 4 files changed, 11 insertions(+), 5 deletions(-)
