Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7693DCDA2;
	Wed,  1 Jul 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934915; cv=none; b=mYIhEWJNkRnpGw93AWcvrhg7eJNdhnHhW3iDEUPyq9WUj8GZeZdkIB8oELe8n1UsFHiy4e+c5nwrMDavew3Ex/cCXVzv41wAyswHbc3iSZeGqmUvkj2W9YMKf0GLcwY6UwEI9eXIUY91G7YKoD2zUeAioRhnxfdz726BaHLWa8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934915; c=relaxed/simple;
	bh=ttNSSTcxZkNjXzjzkhAeFOle4fIgECSrehNK2zaxxlY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eDwDN5lL+dZmnVYqHch5nh+9fBGRlH1lFZHvH5uYk+RdtSjoirwAZFiiCAOZWabaQLHOn64fgMY6YJqFdglShZ+u8ylzgU51z5/GDpHWhtdaVHnKY456h7D7x9eKrujGIRCzvNATOGpjw/pUBMHfOpYtgQfMNpJpg4mEX0h1+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcMb6iX4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcMb6iX4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC2C1F000E9;
	Wed,  1 Jul 2026 19:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782934914;
	bh=gg5yTS7lbLv6UWhM9AFpqDX8kk+qXya6Pt41GFIoKNU=;
	h=From:To:Cc:Subject:Date;
	b=UcMb6iX49WioTVzkKlx0kp0GJh0mSIPt6ui3ESYi3qTTWvVQykeWkFJMa6YgFyVnU
	 iKyCyIp/ap30nyr2o2xpnhsAOzqlIWyCQjLK7baXHmyly1cAaimwd/b7Lt/6ckVjDy
	 XEFGjYxUTEbeqvLg9TFB4wch3DAE3DLDKwSqWmk/V/0LgYW29tmK0MaYrt4S1U9el+
	 2q4rp/DpsobD5nn0v/wYxhC5JWiW1VCUec2hAfeB4qt0EIqz90VolKCuzcHgUr59d6
	 MqUVO0JY626XVxgjy2qFQyMbMmyVkDUacpt6mcZMHgjFmWFWGzmprrLFSk2Yl95nbw
	 yf58xJVBt0nyw==
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
Subject: [PATCH v3 0/6] perf kvm: A small update in the default arch event
Date: Wed,  1 Jul 2026 12:41:47 -0700
Message-ID: <20260701194153.401218-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Ian said there's an issue in the perf kvm record command line option parsing.
This is my attempt to address the issue, simplify the code and fix memory leaks.

v3 changes)
 * remove unnecessary error check  (Sashiko)
 * update test code after rebase
 
v2 changes)
 * handle kvm top subcommand  (Sashiko)
 * handle other arch/condition for the default events  (Sashiko)
 * add <stdlib.h> for musl compatibility  (Sashiko)
 * fix some memory leaks

Thanks,
Namhyung


Namhyung Kim (6):
  perf kvm: Factor out kvm_need_default_arch_event()
  perf kvm: Check kvm_need_default_arch_event() early
  perf kvm: Kill STRDUP_FAIL_EXIT()
  perf kvm: Do not copy filename string
  perf kvm: Fix a memory leak in the usage string
  perf test: Extend perf kvm tests to check default event

 tools/perf/builtin-kvm.c                      | 109 ++++++++----------
 tools/perf/tests/shell/kvm.sh                 |  10 ++
 .../util/kvm-stat-arch/kvm-stat-powerpc.c     |  31 +----
 tools/perf/util/kvm-stat-arch/kvm-stat-x86.c  |  37 +-----
 tools/perf/util/kvm-stat.c                    |  41 +++++++
 tools/perf/util/kvm-stat.h                    |  18 ++-
 6 files changed, 116 insertions(+), 130 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

