Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262081EDA37;
	Wed, 12 Mar 2025 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741811516; cv=none; b=qtezKQ6XtYYcJieiKGGGh8E4IAOUYsv7lU3Fb+BFc9nq0vM1jrdik8U22Z8NWPBMhbGhTSXQ9yu4BK+lmdpALFRdKKQ8ohES/40pxbLc8vKh94v1kYqGb6pzvIpUnhdZtn5Jr8aTtavUVk7ihuS3W04N1pQogjU2HQSu4hrWlR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741811516; c=relaxed/simple;
	bh=OFYIVs8S99HbB0u5/QSSewDS5CadnJF4cJmlidQbtrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VU4+dC0JBYSTO6mOj2UhnDi/0AeP3GSRRSfh11Ex5pHjMYsShib+1oebI6JN5Jq5UrHISUbR7jnlbNyTC0hAv4VQFhh0lsizz8gFSs7tW5YNQXI30/Y+GQN25SnWI7FT7kDMhDXgYNBcVBLt2Z4+dFlrI82G34MTfo0c/P1Pyjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITL6mN7Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITL6mN7Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B43EC4CEDD;
	Wed, 12 Mar 2025 20:31:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741811514;
	bh=OFYIVs8S99HbB0u5/QSSewDS5CadnJF4cJmlidQbtrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ITL6mN7ZyKIiSdzU6xpAwfi4Gj//pPeDyICgMDY7aa5eeM5ONpBVvx8gLyHT5AtUF
	 Dbqm4uQMVEGsxdop8aGHlym12Wh8HBIaRAQgRi1cCCFQZ0YeDbLDGaiMtDtTpd7gSZ
	 pB9NDDDWp0C/6eZo7W3zGtbe+jjQf9Q8F8Ho0aZkt9mHlqoFg6aqPGSBxRKUhOh3UR
	 DYeKrnpXoAJUlgCfeORE005fPy1ua1IMHwtBkD0MgYbkFadSbs76Q9yaGNo9Y//pkC
	 SHUPu/VE1/QoHc+JWOW6F0KFgQPI0mg0ZRMDUamJU0bV/tDOmqWpnvVSXipqybg+uV
	 qX/rVPAxX18fA==
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
Subject: [PATCH 2/6] perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc)
Date: Wed, 12 Mar 2025 17:31:37 -0300
Message-ID: <20250312203141.285263-3-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312203141.285263-1-acme@kernel.org>
References: <20250312203141.285263-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When python2 support was removed in e7e9943c87d857da ("perf python:
Remove python 2 scripting support"), all use of the
_PyUnicode_FromString(arg), _PyUnicode_FromFormat(...), and
_PyLong_FromLong(arg) macros was removed as well, so remove it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/tools/perf/util/python.c b/tools/perf/util/python.c
index 6c5bb5e8893998ae..f9491b6699764fbc 100644
--- a/tools/perf/util/python.c
+++ b/tools/perf/util/python.c
@@ -22,13 +22,6 @@
 #include "util/sample.h"
 #include <internal/lib.h>
 
-#define _PyUnicode_FromString(arg) \
-  PyUnicode_FromString(arg)
-#define _PyUnicode_FromFormat(...) \
-  PyUnicode_FromFormat(__VA_ARGS__)
-#define _PyLong_FromLong(arg) \
-  PyLong_FromLong(arg)
-
 PyMODINIT_FUNC PyInit_perf(void);
 
 #define member_def(type, member, ptype, help) \
-- 
2.48.1

