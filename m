Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C44C441D;
	Tue,  7 May 2024 03:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715051296; cv=none; b=oMX0K6xPkUGLD2uOQS+a4DWKo8lFwaZa4P1MmdIsKVr8Iz2YwnZ2yDYxeJGeX40m7iTX2cj3+1qIA6GQyJNqlWw8S4ocUeFCE7T2TVGisOi2eIAvqaCF3Te+aBbV2Ylyrr7uM+UJ1GAS5kKhMMo4x2W6/QX9PsuVCZDrZTQEpQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715051296; c=relaxed/simple;
	bh=sjD21oc5mAlByVhCwT3GATvzWe4pbEF4vX35kLIucIc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n21nyoJsskaRkPnJdzRtW3AkGT69+Dfp0YYfR2b57iRbMVwrMD1EnQanGHKj23LaYqk1u0Zi9ublJzXzoEaAZ1jSXDQl9gNvqTbLFnYmfpyizz/Ci1zMarfrx//GWjVAHkjNkbbkn3OcWSdPK+9WhHDg0p8DNhwu/zldcRzQzPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N/ncxEHB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/ncxEHB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319B6C116B1;
	Tue,  7 May 2024 03:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715051295;
	bh=sjD21oc5mAlByVhCwT3GATvzWe4pbEF4vX35kLIucIc=;
	h=Date:From:To:Cc:Subject:From;
	b=N/ncxEHBNBX9Dga6tJLHr7hD+N2uTpOfuRj6UQzND6c6XsM4p1apAQLrMHEvPf0b/
	 VDJS6bt7ii89PLs26kUI5/ZyWkYFvBH6fk/CtyyarR14m1Bm159m99qUaF823GHbZu
	 BrkFoDs7X6g3sBizA8YRLUvzhdcHxh657hye+f5e2+82fLtw7P2k3W4BOTDY2Bdfrd
	 YFSfPOyjWLzAlugqbSFtYGxkVu6PqVI+mfPpO1wH4KwOXrm21Oo3+ScHn8Z0emvF6A
	 rJVfmlJI1Y2aQ8P5E5cDBWC8eI/p3mHyrkRqi5Ypuezaj8uzk1LjVGG2Q8nJTITnJ8
	 6/FP9BMdTbfvg==
Date: Tue, 7 May 2024 00:08:12 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf annotate: Use zfree() to avoid possibly accessing
 dangling pointers
Message-ID: <ZjmbHHrjIm5YRIBv@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When freeing a->b it is good practice to set a->b to NULL using
zfree(&a->b) so that when we have a bug where a reference to a freed 'a'
pointer is kept somewhere, we can more quickly cause a segfault if some
code tries to use a->b.

This is mostly done but some new cases were introduced recently, convert
them to zfree().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate-data.c |  3 ++-
 tools/perf/util/annotate-data.c        | 17 +++++++++--------
 tools/perf/util/annotate.c             |  4 ++--
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/browsers/annotate-data.c
index a4a0f042f201a35c..8d6bf08d371dfd23 100644
--- a/tools/perf/ui/browsers/annotate-data.c
+++ b/tools/perf/ui/browsers/annotate-data.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <inttypes.h>
 #include <string.h>
+#include <linux/zalloc.h>
 #include <sys/ttydefaults.h>
 
 #include "ui/browser.h"
@@ -130,7 +131,7 @@ static void annotated_data_browser__delete_entries(struct annotated_data_browser
 
 	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
 		list_del_init(&pos->node);
-		free(pos->hists);
+		zfree(&pos->hists);
 		free(pos);
 	}
 }
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index faefa444af1e0d96..57e7d4b3550b42f8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <inttypes.h>
+#include <linux/zalloc.h>
 
 #include "annotate.h"
 #include "annotate-data.h"
@@ -311,8 +312,8 @@ static void delete_members(struct annotated_member *member)
 	list_for_each_entry_safe(child, tmp, &member->children, node) {
 		list_del(&child->node);
 		delete_members(child);
-		free(child->type_name);
-		free(child->var_name);
+		zfree(&child->type_name);
+		zfree(&child->var_name);
 		free(child);
 	}
 }
@@ -582,7 +583,7 @@ void global_var_type__tree_delete(struct rb_root *root)
 
 		rb_erase(node, root);
 		gvar = rb_entry(node, struct global_var_entry, node);
-		free(gvar->name);
+		zfree(&gvar->name);
 		free(gvar);
 	}
 }
@@ -1817,16 +1818,16 @@ static int alloc_data_type_histograms(struct annotated_data_type *adt, int nr_en
 
 err:
 	while (--i >= 0)
-		free(adt->histograms[i]);
-	free(adt->histograms);
+		zfree(&(adt->histograms[i]));
+	zfree(&adt->histograms);
 	return -ENOMEM;
 }
 
 static void delete_data_type_histograms(struct annotated_data_type *adt)
 {
 	for (int i = 0; i < adt->nr_histograms; i++)
-		free(adt->histograms[i]);
-	free(adt->histograms);
+		zfree(&(adt->histograms[i]));
+	zfree(&adt->histograms);
 }
 
 void annotated_data_type__tree_delete(struct rb_root *root)
@@ -1840,7 +1841,7 @@ void annotated_data_type__tree_delete(struct rb_root *root)
 		pos = rb_entry(node, struct annotated_data_type, node);
 		delete_members(&pos->self);
 		delete_data_type_histograms(pos);
-		free(pos->self.type_name);
+		zfree(&pos->self.type_name);
 		free(pos);
 	}
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d7d55263fc91b67e..2b178835c1f3c254 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2618,13 +2618,13 @@ static void delete_basic_blocks(struct basic_block_data *bb_data)
 
 	list_for_each_entry_safe(link, tmp, &bb_data->queue, node) {
 		list_del(&link->node);
-		free(link->bb);
+		zfree(&link->bb);
 		free(link);
 	}
 
 	list_for_each_entry_safe(link, tmp, &bb_data->visited, node) {
 		list_del(&link->node);
-		free(link->bb);
+		zfree(&link->bb);
 		free(link);
 	}
 }
-- 
2.44.0

