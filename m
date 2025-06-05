Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479651E7C03;
	Thu,  5 Jun 2025 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749158184; cv=none; b=Z6gyVY7zBoSbcmdd7DF/lYiFnyxAAnjvYuP6XJnHUTU183VKoedEtMbBlTQqF7t7BmVF20LW00tI76jYD+E9BgciYgnCklUv0Khiq0tkK19XNajtIP4cq9nns3EmnuTHmWZNh2GEA+vZWuulZKlh8s9h2o6sS4atJ2WxAVDfDe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749158184; c=relaxed/simple;
	bh=AafT3RGYRZdiJ+9sjWOv+ipYlHsW8qokTYJ2bjP8fjc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aSt2B3uIpVtq2Xbp6/n3m76ErdxTWhQ9+8Wp3+G+5D9qxjJIgvAOnP7vIPjMcqC5QUDGNaBo3+Au4QmdHdy8VjiRSclPbIpboJQFlESJ+MEj4O1T2vsKDnnUour+Z6cWPnvfjl5EgynS3BzTwZbpUtvScYDt1C/6Yw7X4x1u/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZzPLgt1i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZzPLgt1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C68EC4CEE7;
	Thu,  5 Jun 2025 21:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749158183;
	bh=AafT3RGYRZdiJ+9sjWOv+ipYlHsW8qokTYJ2bjP8fjc=;
	h=Date:From:To:Cc:Subject:From;
	b=ZzPLgt1i5ARTo1JdQ+QidHAjGhZwiW3pNsCmuj7Qj0s3P8++jn6tD11+ro4cSOOMP
	 XWxLKbRquFd0Net7vUVZwF3Yg/yVAtXgJQPsFrm4aGuPlYGCml/dzbBUUo2RNANnnZ
	 gxxIEROF7rrYzwXQZUry718Dv/leEUoyJtUwBT/77MMiuJ0wKNf74cw5kRUTgSw3F5
	 qB1vjnc4jeYScaV8dB7fCsEos7u36dll89qnxA1CFzS0O+rMPHt+DF2rGHN+uIhEGd
	 p/CvIYA3d7wGOqoO7po6uMf5llyS9AiqbqkIMliKu2I2yAI/BnTPTmBfEw+VttEPmt
	 M8mVb82NUMeTA==
Date: Thu, 5 Jun 2025 18:16:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@kernel.org>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf top/report TUI: Provide visual cue when starting
 annotation
Message-ID: <aEIJJIiuRTVjPaPT@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sometimes it takes a while for the annotation to be presented after
pressing 'a' in the 'perf top'/'report' TUI, provide a visual cue
informing that the annotation has started for that symbol.

This is the quick and most of the time improvement, but for some cases
its better to improve on it by having a cancellable progress bar, which
is now in my TODO list.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index cd1d452035a265d3..66ffeb96db29532c 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -2,6 +2,7 @@
 #include "../browser.h"
 #include "../helpline.h"
 #include "../ui.h"
+#include "../util.h"
 #include "../../util/annotate.h"
 #include "../../util/debug.h"
 #include "../../util/debuginfo.h"
@@ -1016,6 +1017,7 @@ int __hist_entry__tui_annotate(struct hist_entry *he, struct map_symbol *ms,
 		return -1;
 
 	if (not_annotated || !sym->annotate2) {
+		ui__info_window("Annotating", sym->name);
 		err = symbol__annotate2(ms, evsel, &browser.arch);
 		if (err) {
 			char msg[BUFSIZ];
-- 
2.49.0

