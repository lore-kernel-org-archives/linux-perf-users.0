Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6E7301468;
	Wed,  3 Dec 2025 14:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764773407; cv=none; b=fPclRJZtjBCgxfU8oBAhXrX7ble6lPbntnS595WJW/XTYg3CmCSZn2sujykAJhivFxRviTYBxHpSX34tz/TQOxfy9BFfohbliJhr4sDcKs32njK5qkrPDKCYmmdoHEzRRNLpp+Ml+WIox8IEHwp6ihC7DMM+fVrwfeOJdwncCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764773407; c=relaxed/simple;
	bh=8uVgtYBSkB0Aw0zdBOrJ7XvOI9WKa3qjg/u+fiXL714=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZEK6w7BmFnp66wIvTKS1NEr5KVuw7nX9GpbtOaUvYwHKjIIj4qJjcdC7+wjqW/tClY0Ai7Uj5EveSSqdrmy/KvPya6Fi7rnPtRjsQSOcfbeX2xNey8NYOgecmehqu+7UncTpXfScQ/aHl959Z2V7LRHiBVa5UaIQ0oKWLF8SL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ML/irMWK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ML/irMWK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79063C4CEF5;
	Wed,  3 Dec 2025 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764773406;
	bh=8uVgtYBSkB0Aw0zdBOrJ7XvOI9WKa3qjg/u+fiXL714=;
	h=Date:From:To:Cc:Subject:From;
	b=ML/irMWKtaselxNsNnbXqS9FMzZ5nwH2qbkS/x07nfRuwUyfN6zUyyO3SaepzzfbJ
	 35hXSmlbml0D8CAnYrLVptu8+oLJbZ5J9zPkMTMucWp6D/F+Zy7oQ3aa+nUGe2sRWX
	 f+h7U34nsJ85+lpOkzXUdQoNO5/kN2KC2F2jdLhhqPM2gGeIoGSlDcVyfiDveQ+UuP
	 40f25ydRpbQF6pkDHfao9rPgap4TVsoSgv7g1IgM+usmOsWAv+NVMqeH+qGVaOtvZA
	 F7ZDU0QMyxEfpuSnX7TMqp3yff2fQaN9o06m6cZBTld0MNrEzD5ZzgyJVbgotCR8m6
	 AxMkZ8tgJqo+g==
Date: Wed, 3 Dec 2025 11:50:03 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH v6.19-rc1 1/1] perf auxtrace: Include sys/types.h for pid_t
Message-ID: <aTBOG7H7OAST04iB@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In 754187ad73b73bcb ("perf build: Remove NO_AUXTRACE build option")
sys/types.h was removed, which broke the build in all Alpine Linux
releases, as musl libc has pid_t defined via sys/types.h, add it back.

Fixes: 754187ad73b73bcb ("perf build: Remove NO_AUXTRACE build option")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index eee2c11f76668348..6947f3f284c02928 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -7,6 +7,7 @@
 #ifndef __PERF_AUXTRACE_H
 #define __PERF_AUXTRACE_H
 
+#include <sys/types.h>
 #include <stdio.h> // FILE
 #include <linux/perf_event.h>
 #include <linux/types.h>
-- 
2.52.0

