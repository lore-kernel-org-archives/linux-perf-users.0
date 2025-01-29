Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57B71E1A25;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738172366; cv=none; b=mGU+E05eW4zHt5FKFH6tQX1mZWm5RiSHje2xULf90TrhP38hWDSGgP0Nyz4IjCs2HNw5d10D12eFC4AnCBlyK69auz7ZI4BNHbM0c9B+4SC3/B3G8nj8eCjXUIYsFuEHDeDN4DhVoooqBGx/9btRvPTXif2/kzOEp/g+RTdJv8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738172366; c=relaxed/simple;
	bh=xZH+L/OgMoZtO9e2qihzVrLM4quolAqHcEMQwUbsVnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WzomQwW3YCPK2a/1CRbZ6xieXfV7m/uxhvxQFd2fPNCJrm2ksPASp3Ah1fksNwPlyFPEx+a8RRhB9AR3ZSwSLBQvfCe4KTJEHYA3HY5vK7GJOZQBBhqsRZB9nXu+ydSBkxgsIpSVZpwUSTscU3y60ziOaGJSeIYVk/N6xnfzvVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvo0ePWA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvo0ePWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EBBC4CEE6;
	Wed, 29 Jan 2025 17:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738172365;
	bh=xZH+L/OgMoZtO9e2qihzVrLM4quolAqHcEMQwUbsVnU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uvo0ePWAQRshuE4ODsVOlZMf/Eb4UquZ1bWuG+xxJF1ZGwdWBTQ+TJCcIz/GMgrwc
	 ozm4YgmjvX6Ua0GQ51NG+ImWZSa5wvQ46jzjmdzYc0U8dRs0wX1VD85DTukP3jQZnR
	 M/hNySr916mbTk9mnbudMT1ptbHsWwxDovBJrN998Qej8ZBxi+zzylo9773TjtDp5x
	 r/J+/IaRwCookNe0EQ1NJPX3D1f/G+nq7l/dAjFS50c1P6ryxH9hfUob//ExNXVCx9
	 qtAw/pm0+/s17k999dvCioQjVX2EVO05JWIUxoqz/GecjWgDYhY3eCKQu6ameT1Wsw
	 h350Wrww893jA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tdC26-00000004SdI-3IUu;
	Wed, 29 Jan 2025 18:39:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <mchehab+huawei@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <mchehab+huawei@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <mchehab+huawei@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Veronika Molnarova <vmolnaro@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/6] tools: perf: exported-sql-viewer: drop support for Python 2
Date: Wed, 29 Jan 2025 18:39:04 +0100
Message-ID: <49d26071821a841531618296e7287a2a55ed2bb5.1738171937.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738171937.git.mchehab+huawei@kernel.org>
References: <cover.1738171937.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

As stated at process/changes.rsy doc, the current minimal Python
version is 3.x, so drop support for EOL python 2.x.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/perf/tests/shell/lib/attr.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/perf/tests/shell/lib/attr.py b/tools/perf/tests/shell/lib/attr.py
index 3db9a7d78715..3ca405f45d10 100644
--- a/tools/perf/tests/shell/lib/attr.py
+++ b/tools/perf/tests/shell/lib/attr.py
@@ -12,11 +12,7 @@ import logging
 import re
 import shutil
 import subprocess
-
-try:
-    import configparser
-except ImportError:
-    import ConfigParser as configparser
+import configparser
 
 def data_equal(a, b):
     # Allow multiple values in assignment separated by '|'
-- 
2.48.1

