Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DBD94F5DFF;
	Wed, 30 Sep 2026 13:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790773920; cv=none; b=LiuYil4CLPKI07kUBVhEjPu/vDVTH4hEzIe7hNq/0mOZKHPb2vwz46MGXBiuDH2G4DHu0PAqfsRvAu6s3Kjqta9RJJexdrlxVtsp3GcchFW8Aegi9B2RD77oXAKZNGZ/pj+9MPCfwuc8jxRcrHM4muQuU4IBrxLK0ztJRBJFDtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790773920; c=relaxed/simple;
	bh=5VXyDGgHM1h2GOfGAbHZtu7Q+5PwQ6iLptI7+l4XeJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RbeZ1Dha6sZtyVNN6l6vTiwl5VY7dDRV0WtWK8JFTpxR+8XmN6bhDOFfQYHR46TmW0sIsKk4C8hm8ekFy3DFt/3en7fe27zITvTNxL5keMuQO6JenGmQo6T/Ho5vZN8MCrOjSucRaf6FcxryPGfT5qWEpEGoEnSfIxHwp/X5Jb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tMYetKmf; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tMYetKmf"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED31F1596;
	Wed, 30 Sep 2026 06:11:48 -0700 (PDT)
Received: from e132581.arm.com (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA1E83F86F;
	Wed, 30 Sep 2026 06:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790773912; bh=5VXyDGgHM1h2GOfGAbHZtu7Q+5PwQ6iLptI7+l4XeJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tMYetKmf6jrekBTPegUzTsTn9LLqqp54/dUAwFmC+bckflrqRrWzrHcnbVL4DksHM
	 ALHrtxn552Q+P94gPKtDyv2wFQ/NfvzWEK6lGrf6BQk2DcdhdoTaJhuPgFuLxQUPH1
	 vU6jNCv9Qqkws58YuMrvyRzZR7Ts9Kj/6Zi4DrAA=
From: Leo Yan <leo.yan@arm.com>
Date: Wed, 30 Sep 2026 14:11:38 +0100
Subject: [PATCH v2 3/4] perf test: Suppress optparse deprecation warning
 with older pylint
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-perf_fix_pylint_errors-v2-3-945cd526576b@arm.com>
References: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
In-Reply-To: <20260930-perf_fix_pylint_errors-v2-0-945cd526576b@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Aishwarya TCV <aishwarya.tcv@arm.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arnaldo Carvalho de Melo <acme@redhat.com>, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790773904; l=1253;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=5VXyDGgHM1h2GOfGAbHZtu7Q+5PwQ6iLptI7+l4XeJk=;
 b=zc2jA8xdAJia24aCzX53BqSTaxJbBmRlQdhBH8rwqIk1/f/mQ83VAX7zSzxmh798G4lq6RQ+d
 WEvSwyuYB+rAFOERQmz9ED6BScsbuwEompQagMRWnXRnR9AGMtRU3aB
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

Python 3.13 reversed optparse's deprecation, and pylint 3.3.5 removed it
from the deprecated-module list. Perf supports older pylint versions,
so suppress the warning on this import and document the reason. Keep
other deprecated-module diagnostics enabled.

Link: https://docs.python.org/3.13/whatsnew/3.13.html#optparse
Link: https://pylint.readthedocs.io/en/latest/whatsnew/3/3.3/index.html#what-s-new-in-pylint-3-3-5
Fixes: 8a54784e708b ("perf build: Add pylint build tests")
Reported-by: Aishwarya TCV <aishwarya.tcv@arm.com>
Assisted-by: Codex:gpt-6
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/lib/attr.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 7f3d5b64b00dd7de45baff4f7d9baff89e003147..523257bcf8e126cb662af589727144bb26cff4d5 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -4,7 +4,8 @@ import configparser
 import os
 import sys
 import glob
-import optparse
+# Pylint before 3.3.5 still treats optparse as deprecated.
+import optparse  # pylint: disable=deprecated-module
 import platform
 import tempfile
 import logging

-- 
2.34.1

