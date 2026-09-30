Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA49F4BEE38;
	Wed, 30 Sep 2026 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773914; cv=none; b=V4auQHANugwHA06xnlWhndCJHWLVBt30ajYpyTLtK4nxLAe8KgisE/MZ7bOZmfufBfGtq3H90Gm042wawnzbFaZYtb1wI2nAX0+ZefKJIQhw3ZVGhPFjEt2/P46aI8ZxBObmZyFFoiTimFp4533aQmNeMkMoUH2UtWSpT5+o4oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773914; c=relaxed/simple;
	bh=NXIKV0QZVWBgN25oqgaa6GjmQk1Nftn3SVI+OVPkSxA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DEJJGklhsRybCY6UK42AdH1JGALRstb/bmO2GRHu6CudiJlJv3LShSKJ2zquvakrEOBYpw0uLwoQ/3XdEz5QUQXVb8ndTXa+CHl2SKSHD4Ko9T5AGwXKkfiQMj3YA1Mn4xwcyUD7UC8GhnkOnuzEj6uw1Gv55kfdxfcAhUB31Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=grgDidvi; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="grgDidvi"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4654B497;
	Wed, 30 Sep 2026 06:11:43 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EA703F86F;
	Wed, 30 Sep 2026 06:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790773906; bh=NXIKV0QZVWBgN25oqgaa6GjmQk1Nftn3SVI+OVPkSxA=;
	h=From:Subject:Date:To:Cc:From;
	b=grgDidvi6tQRYRKlrLhBCpjxQ5GNOJW5+P0uH+hYLF0v0DJKeH2eXtJ6QbDsDBcZP
	 mrgNjCBhZjMeFCr//ftB/bNGei3keZQbZ35u7Dbz+UyApx9+jaquLpKhtBs3h2Xt2q
	 QZMVruFCBFj+2ph81oByfu2PZEImbQ/KUNk3iA2o=
From: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 0/4] perf build: Fix pylint build failures
Date: Wed, 30 Sep 2026 14:11:35 +0100
Message-Id: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgKvWoC/4WNUQ6CMBBEr0L225q2WEG/vIchBMpWNhFKtqSRk
 N7dygX8fJOZNzsEZMIA92IHxkiB/JxBnwqwYze/UNCQGbTUV3krpViQXevo0y7bm+a1RWbPQZQ
 WnanLXuGlgjxeGHPpED+bzCOF1fN2/ET1S/8qoxJSuEoro4a618Y8Op7O1k/QpJS+E5DIz7oAA
 AA=
X-Change-ID: 20260930-perf_fix_pylint_errors-3cef583b1e47
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773904; l=1958;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=NXIKV0QZVWBgN25oqgaa6GjmQk1Nftn3SVI+OVPkSxA=;
 b=6mZTFSObmumwv8GOfmkKeDeCZlCSWG2oXJPNd7pEMEbzkPDP6L3AlKBBjtNdpgxhIrUUvd08s
 lDxbPRjiDVLC6Yn5jsfbHnrSHnMIupKytItWHRU0bMVO/cboB3jEr48
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Recent changes to perf's Python module, including enabling pylint by
default, exposed build failures in our CI. For example:

  tests/shell/lib/perf_brstack_max.py:8:0: E0401: Unable to import 'perf' (import-error)

This series builds the perf Python extension before running pylint on
its consumers without delaying C builds. It also prepends the output
Python directory to PYTHONPATH for out-of-tree builds.

The series also mutes the optparse deprecation warning from older pylint
versions. Python has reversed this deprecation, and newer pylint
versions no longer report it.

A final patch renames an exception variable in the PostgreSQL exporter
to fix pylint warning.

Tested on an x86 Intel Xeon(R) w7-3465X (28 cores, 56 threads), the
average real build time over three runs was 20.104s for v1 and 18.998s
for v2, about 1.1s (5.5%) faster.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
Changes in v2:
- Run pylint after the Python extension without delaying C builds
  (Sashiko).
- Fix the PostgreSQL warning.
- Link to v1: https://lore.kernel.org/r/20260930-perf_fix_pylint_errors-v1-0-f72151d8b255@arm.com

---
Leo Yan (4):
      perf build: Build the Python extension before pylint consumers
      perf build: Add the output Python directory to pylint's PYTHONPATH
      perf test: Suppress optparse deprecation warning with older pylint
      perf python: Avoid shadowing exception name in PostgreSQL exporter

 tools/perf/Build                          |  4 +++-
 tools/perf/Makefile.perf                  | 17 ++++++++++++++++-
 tools/perf/python/export-to-postgresql.py |  4 ++--
 tools/perf/tests/Build                    |  4 +++-
 tools/perf/tests/shell/lib/attr.py        |  3 ++-
 5 files changed, 26 insertions(+), 6 deletions(-)
---
base-commit: 45d15e89a783a0a279b7a54f9018c230127380d7
change-id: 20260930-perf_fix_pylint_errors-3cef583b1e47

Best regards,
-- 
Leo Yan <leo.yan@arm.com>

