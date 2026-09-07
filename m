Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690AE3EEAC1;
	Mon,  7 Sep 2026 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788801960; cv=none; b=UT5SWn+ZbTC5am/Gc21cmAtQLnJC/xeKF9nacrgCSt6TucjTuMHrYP0wzAYdhSDkUDu55ltdqMH2fjm817OMcXqhGLh/08CdsL5jYbgrOeXl37qB6gCaxJUXVtjBRWb2cTks5jbIZ1IiQsQHA7OaDMyhjQtIPozSFmR862JxDWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788801960; c=relaxed/simple;
	bh=C7sFotT11O1ANajPY1QOnEWoQxEbS55YJhCn02mJpyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZTAmMQqIPwxRUE/YQQDySCUtzf34NIe5A7/u14hld6I8fEg+PEgxJSu8z1IA+USp2LfOey68DJ320EQxeeQfnAC9RdfkUVeCA/+won+xDaNQbKBeWdU6wLmh5/+xpyF2XBz3DsVug9v42BBCFzJzJXQo7VNXH+NVrex66rktn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR6DsfST; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR6DsfST"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A80401F00A3A;
	Mon,  7 Sep 2026 17:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788801958;
	bh=D9TeqG9HFjW0vfXGdcfWZilMx0Opu04KA7bcQCZ/TXo=;
	h=From:To:Cc:Subject:Date;
	b=HR6DsfSTgEq4JzeKy/R7TM5yOGBMokE8ZM8UcurqNKL/pyDmLLIGZr8jZSraDe1Id
	 2uVAoeRKG/BetF14KhizzD6DmUY4uKHd48McNYQTCEGNp1VqWLPTDDM1IcnYHim/oj
	 kF+cQOtZNU/gW5RwyQmAjlRjlQj4Jj18w6/+quCio+SU0reqkfd8mrYlZ2bIAVkChH
	 AO10YD5nNQyc9MWhNpmrPuRN/izBPaPMb8jX8UHVEJw/dwrB4U2vwTnRs6J4SNeqCS
	 QMIAURwTaKd4C6SUQy+ztH0GAXo3h++W8oSUBDSZqSIXdYk7h2f2E6dIM+bht0GXuJ
	 qPQdH6NV126kQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [GIT PULL] perf-tools fixes for v7.3-rc3
Date: Mon,  7 Sep 2026 10:25:57 -0700
Message-ID: <20260907172557.3679541-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Please consider pulling the following changes in perf tools for v7.3.

Thanks,
Namhyung


The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools.git tags/perf-tools-fixes-for-v7.3-2026-09-07

for you to fetch changes up to aadea57f532882d8bab444646863c7ef8a778ff1:

  perf powerpc-vpadtl: Fix raw_size of DTL samples (2026-08-30 23:11:35 -0700)

----------------------------------------------------------------
perf-tools fixes for v7.3-rc3

Here are two simple fixes for this cycle.

 - Do not use separate debug files for Intel PT decoding.
 - Fix size of raw data in the PowerPC VPA DTL samples.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>

----------------------------------------------------------------
Adrian Hunter (1):
      perf symbol: Do not use debug file as the binary type

Wang Yan (1):
      perf powerpc-vpadtl: Fix raw_size of DTL samples

 tools/perf/util/powerpc-vpadtl.c |  2 +-
 tools/perf/util/symbol.c         | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)
