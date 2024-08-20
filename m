Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395D522A;
	Tue, 20 Aug 2024 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724114585; cv=none; b=G+ufmZuzXpWLK3HDKQQ/mbcCFE1UGTIKuPs9YYh8dof4ksDe/C+OYPArEbC75i1lZsNL1JQn4sViNdQYr5AGtdfW67w3ZN6vFPmZ9dWzgmK8dGPZj+gF21UbkjQDf/S04XjRE9Lc1UOEeagIeW0+OruD0nMcmCcPeADWvAbG0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724114585; c=relaxed/simple;
	bh=PLQFyNjW7jIBUFjnKWDB4RyobC0CXckPPAD1eWgsz8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=je+oMYT6aZ9PvexQ0HYn+UPDRKoAAioJGWCyozbrK574bHiNqGLu8bVnn4qljnvWKQaRgm0oTXaKl7mVJJTMTBr+mBicUVnuLEztiwUv/4LdfJX2JzwMuufMB3/nuej3D99UbO6KcYZB3puM6xTelolGtjW4eA5sLzvJQ3xxBpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WtarLXAY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WtarLXAY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01525C32782;
	Tue, 20 Aug 2024 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724114584;
	bh=PLQFyNjW7jIBUFjnKWDB4RyobC0CXckPPAD1eWgsz8Q=;
	h=Date:From:To:Cc:Subject:From;
	b=WtarLXAY6veUBhhLosPazxNWJaaJ8qB+KAWFYN2JczPdqw7Z50dQfJg92gleLaWwn
	 uWx+r9BquP/qGjyj2f6jDVNimnwBL0pu3GxghAs72Sl7A2FBtK5M6W5WiQLw0uM1RM
	 kh+O+T3Y8UGPQ61bm1tKa/DxZd2wR7JCVCSLaMrwHf/0qZ4uZhxHmOaxEIYkrjgXAc
	 SwdMwwDKfpwv5exV2pSDZ5QXz4viHS03AIckQF8fQZnKZtoxNA3vdzVOryEjvBstUE
	 4viWl981u1OxDXVaaPPoe4L5ZNiwSQAHryk+9vpDkat58mJpb8xktADJvIS6e9g6oX
	 WQspFsT2DmjiQ==
Date: Mon, 19 Aug 2024 21:43:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf daemon: Fix the build on more 32-bit architectures
Message-ID: <ZsPmldtJ0D9Cua9_@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

FYI: I'm carrying this on perf-tools-next.

The previous attempt fixed the build on debian:experimental-x-mipsel,
but when building on a larger set of containers I noticed it broke the
build on some other 32-bit architectures such as:

  42     7.87 ubuntu:18.04-x-arm            : FAIL gcc version 7.5.0 (Ubuntu/Linaro 7.5.0-3ubuntu1~18.04)
    builtin-daemon.c: In function 'cmd_session_list':
    builtin-daemon.c:692:16: error: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type 'long int' [-Werror=format=]
       fprintf(out, "%c%" PRIu64,
                    ^~~~~
    builtin-daemon.c:694:13:
        csv_sep, (curr - daemon->start) / 60);
                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
    In file included from builtin-daemon.c:3:0:
    /usr/arm-linux-gnueabihf/include/inttypes.h:105:34: note: format string is defined here
     # define PRIu64  __PRI64_PREFIX "u"

So lets cast that time_t (32-bit/64-bit) to uint64_t to make sure it
builds everywhere.

Fixes: 4bbe6002931954bb ("perf daemon: Fix the build on 32-bit architectures")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-daemon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/builtin-daemon.c b/tools/perf/builtin-daemon.c
index 7dca39c4314b6fff..f0568431fbd51981 100644
--- a/tools/perf/builtin-daemon.c
+++ b/tools/perf/builtin-daemon.c
@@ -691,7 +691,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 
 		fprintf(out, "%c%" PRIu64,
 			/* session up time */
-			csv_sep, (curr - daemon->start) / 60);
+			csv_sep, (uint64_t)((curr - daemon->start) / 60));
 
 		fprintf(out, "\n");
 	} else {
@@ -702,7 +702,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			fprintf(out, "  lock:    %s/lock\n",
 				daemon->base);
 			fprintf(out, "  up:      %" PRIu64 " minutes\n",
-				(curr - daemon->start) / 60);
+				(uint64_t)((curr - daemon->start) / 60));
 		}
 	}
 
@@ -730,7 +730,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 
 			fprintf(out, "%c%" PRIu64,
 				/* session up time */
-				csv_sep, (curr - session->start) / 60);
+				csv_sep, (uint64_t)((curr - session->start) / 60));
 
 			fprintf(out, "\n");
 		} else {
@@ -747,7 +747,7 @@ static int cmd_session_list(struct daemon *daemon, union cmd *cmd, FILE *out)
 			fprintf(out, "  ack:     %s/%s\n",
 				session->base, SESSION_ACK);
 			fprintf(out, "  up:      %" PRIu64 " minutes\n",
-				(curr - session->start) / 60);
+				(uint64_t)((curr - session->start) / 60));
 		}
 	}
 
-- 
2.45.2

