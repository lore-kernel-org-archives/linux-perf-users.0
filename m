Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736D5283FEB;
	Tue,  1 Jul 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751400629; cv=none; b=m/Bn8TSW2OnSSIEZoXiX1HAwuFJzFLwZ/E+BBSxhcK+NMwnQzcPQ+lN/QVd05EFnZg61FxHpWjdxTNNOtQzm/Z2QggkJ+pVj5k79YO1v048bw4fsrE21/RLy9QV4EdptNvDXZrudIrIoBLgQDYUgB9OrqETf54EWYpqImXYOku4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751400629; c=relaxed/simple;
	bh=x/5s4J6/OTlD9f6oui9G3mjn+w+/x+w57+m2VNsLM1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tnlKdCynkg6hUGuLuuPecDhWhNup7K8DSwUkiL4xHVniH48JAb2M38zQCiRbIFaBvLkdJyV1sLSQNuUuknWJFQjZTg/LQqSL9Bt8NKtQkZ0flVcksWUXnsdmKNMUm0Ne46w78LvtRiq4iNuYAYzfMaHP4lN/9tgL5++ADtr0ILs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+BCvdeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+BCvdeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC641C4CEF3;
	Tue,  1 Jul 2025 20:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751400629;
	bh=x/5s4J6/OTlD9f6oui9G3mjn+w+/x+w57+m2VNsLM1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U+BCvdeo1cmca9l8ZVxpggYM47Mzux1ylSpxvUFJU3ciYBv46iqTHt+NSw5TtqgGP
	 tEFBVMkOWtehGGYY3vPc1WXMOICGzg7d9K6INX1GdMIqyzT1+Hmqdhb0E/XelzsKtW
	 /WXJvpwRgddPVBDu/fkI3bSdfpvNjHdIJ3expw+Kshy/JSclR1+aao97Td02nFDUmW
	 N2yeH/NNOO9RgH30lexA7UXkuIGVUsa7EVdZrmDPis3KpFATwTxpSjY9phHpje1dzo
	 WnevEb2BLwf5viqV5RQ9QvB5nu7Tp5Quh5jZEwzkxUR6pK/neKR55VJMTjOIAEsE5G
	 bPOZ7NksshPYQ==
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
Subject: [PATCH v2 3/3] perf tools: Fix use-after-free in help_unknown_cmd()
Date: Tue,  1 Jul 2025 13:10:27 -0700
Message-ID: <20250701201027.1171561-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
In-Reply-To: <20250701201027.1171561-1-namhyung@kernel.org>
References: <20250701201027.1171561-1-namhyung@kernel.org>
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
Reviewed-by: Ian Rogers <irogers@google.com>
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

