Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5CD25C83E;
	Mon, 30 Jun 2025 23:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751326369; cv=none; b=cu+gGitjf17N0g1RzfeuUnhfH/pjwzuXSddzzrLHxQUotx+gE2IfJmN5MJ4h0iIb48W57yK0MeWBdZktJrq63fYuQr072MByzxIYR1zjqh70eXkimWiaGy0TSxBk4qx3MNLMUz8XUdNQ56gYcMg9Wvl3IovbArd1tE02MxkerN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751326369; c=relaxed/simple;
	bh=RGK7vE2Fxbx0dulRvAkC8eL5IDq9hmzIlTICBDJ1CkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7evmjNFelXUNKCcPU6AD2wK196qWqhC/Wyf+40fr8L2QAf5GvZbfIVgvC0Z3/vcBomgd2SmOk08e3KKAeBp0/Py1tJPTXkHwG+rHe+Db4pWaTXumnk6sGLbPLlqkXIun2YR/xiRtIDy0v4CSnn/Ery30GdJOC6Nd/68dmX4pP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ow6KYz0m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ow6KYz0m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAEAC4CEF3;
	Mon, 30 Jun 2025 23:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751326368;
	bh=RGK7vE2Fxbx0dulRvAkC8eL5IDq9hmzIlTICBDJ1CkI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ow6KYz0m/OBD+xr6mLLbuIz0WV8TGGhogWQ1wWy9vY+W4gkuA6zbGS1rcf8QBUscg
	 6zs//rzPflDKJy8vnQAcA8juXg4knmqD/gWBr5tk3l01YJHpYkc49ZUzj0VDzqJ7WE
	 Dt0ZriYDnT3j3ycbvUHgs6Tb7gvFe6QbYYYMJm3yvFXmMNmT4HqJ1IDafCUWZyl9yV
	 tr08JY5nL0S4taxZ/OAEcAI16sQbaC2GAMKKWZT1zDSomdmZDW7jrPYUrLxFuZJO2j
	 nx4FSa0xMV0wHEKLjwMyC7rkg7iYyft452t8/rVJwC4kHscgfRK3xm87q+IHqZXKYJ
	 5KAhb4yYI5vRg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 3/3] perf tools: Fix use-after-free in help_unknown_cmd()
Date: Mon, 30 Jun 2025 16:32:46 -0700
Message-ID: <20250630233246.1063977-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250630233246.1063977-1-namhyung@kernel.org>
References: <20250630233246.1063977-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently perf aborts when it finds an invalid command.  I guess it
depends on the environment as I have some custom commands in the path.

  $ perf bad-command
  perf: 'bad-command' is not a perf-command. See 'perf --help'.
  Aborted (core dumped)

It's because the exclude_cmds() in libsubcmd has a use-after-free when
it removes some entries.  After copying one to another entry, it keeps
the pointer in the both position.  And the next copy operation will free
the later one but it's the same entry in the previous one.

For example, let's say cmds = { A, B, C, D, E } and excludes = { B, E }.

  ci  cj  ei   cmds-name  excludes
  -----------+--------------------
   0   0   0 |     A         B       :    cmp < 0, ci == cj
   1   1   0 |     B         B       :    cmp == 0
   2   1   1 |     C         E       :    cmp < 0, ci != cj

At this point, it frees cmds->names[1] and cmds->names[1] is assigned to
cmds->names[2].

   3   2   1 |     D         E       :    cmp < 0, ci != cj

Now it frees cmds->names[2] but it's the same as cmds->names[1].  So
accessing cmds->names[1] will be invalid.

This makes the subcmd tests succeed.

  $ perf test subcmd
   69: libsubcmd help tests                                            :
   69.1: Load subcmd names                                             : Ok
   69.2: Uniquify subcmd names                                         : Ok
   69.3: Exclude duplicate subcmd names                                : Ok

Fixes: 657a3efee43a ("libsubcmd: Avoid SEGV/use-after-free when commands aren't excluded")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/subcmd/help.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/lib/subcmd/help.c b/tools/lib/subcmd/help.c
index 8561b0f01a247690..9ef569492560efd7 100644
--- a/tools/lib/subcmd/help.c
+++ b/tools/lib/subcmd/help.c
@@ -9,6 +9,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <dirent.h>
+#include <assert.h>
 #include "subcmd-util.h"
 #include "help.h"
 #include "exec-cmd.h"
@@ -82,10 +83,11 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 				ci++;
 				cj++;
 			} else {
-				zfree(&cmds->names[cj]);
-				cmds->names[cj++] = cmds->names[ci++];
+				cmds->names[cj++] = cmds->names[ci];
+				cmds->names[ci++] = NULL;
 			}
 		} else if (cmp == 0) {
+			zfree(&cmds->names[ci]);
 			ci++;
 			ei++;
 		} else if (cmp > 0) {
@@ -94,12 +96,12 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
 	}
 	if (ci != cj) {
 		while (ci < cmds->cnt) {
-			zfree(&cmds->names[cj]);
-			cmds->names[cj++] = cmds->names[ci++];
+			cmds->names[cj++] = cmds->names[ci];
+			cmds->names[ci++] = NULL;
 		}
 	}
 	for (ci = cj; ci < cmds->cnt; ci++)
-		zfree(&cmds->names[ci]);
+		assert(cmds->names[ci] == NULL);
 	cmds->cnt = cj;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog

