Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D87619C54B;
	Wed, 12 Mar 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741795626; cv=none; b=LBYWYVvkildPTCv9HLXqlIi7GsjZ7uyFcDe9MB+vgUtTJA5qzwDIHyJtibkEYRhp2Rk0A2KkU4naMIITySMIYfAO9E/sj672Hw+YxeT5KSm5kbnIKeCl5QbfSX74V1MWh+wVqSMV/PHwUyt0kIQhLOFbQs61GplM0N0qq5WExZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741795626; c=relaxed/simple;
	bh=OFYIVs8S99HbB0u5/QSSewDS5CadnJF4cJmlidQbtrc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCcOaAOcybxAKJdk53T3c9c+D+zNi55N4xGgJFr5hD/76IwUbKcNZjuYCGNiupxBYQQpN4ngP1/aQTgby7z16FfTWAunP7PWKZbI/nUlIJzVVbHUp6207p14f2UuYbmjau06X4QFNXZMpEst3XHL8z84G6QeVJd7iu7AuKI5XLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcdI1LuD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcdI1LuD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A4A5C4CEEC;
	Wed, 12 Mar 2025 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741795626;
	bh=OFYIVs8S99HbB0u5/QSSewDS5CadnJF4cJmlidQbtrc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcdI1LuDnVSw2RubwvGHOkNJzY9cKi8RAUc/81c3WwYB8yqzIaku9IfmfRBJeQ9iv
	 y4VdG+lF5EnCbTg3QlN0rmpf3tJkK5ubio/rs3Vaj0HzXCXDALwRl1/YfmZDVBEKrq
	 JDFmBC36b+89G0dGqS9ZngH7tJFtrz9fk+mA0D8YKH2g0bKSHVNVJNtUmHt94zOYsh
	 FPFGSYjyli45cJW9IgSMujB6JGktEO8gUqzF13+II1eHzXZIe7kRCaJXlhl+55O5oe
	 1Y8dgJ0KqSAKMiht8vnv/T1eXXqR7hdShf1j3HiHa7yL62pdCn0EPrkP6CwSMm/Mno
	 46CKUZp7ziwXg==
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
Subject: [PATCH 2/3] perf python: Remove some unused macros (_PyUnicode_FromString(arg), etc)
Date: Wed, 12 Mar 2025 13:06:50 -0300
Message-ID: <20250312160651.280817-3-acme@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250312160651.280817-1-acme@kernel.org>
References: <20250312160651.280817-1-acme@kernel.org>
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

