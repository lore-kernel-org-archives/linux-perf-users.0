From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/75] tools lib subcmd: Fix a few source code comment typos
Date: Thu,  6 Dec 2018 18:25:29 -0300
Message-ID: <20181206212602.20474-43-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Jiri Olsa <jolsa@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Ingo Molnar <mingo@kernel.org>

Go over the tools/ files that are maintained in Arnaldo's tree and
fix common typos: half of them were in comments, the other half
in JSON files.

No change in functionality intended.

Committer notes:

This was split from a larger patch as there are code that is,
additionally, maintained outside the kernel tree, so to ease
cherry-picking and/or backporting, split this into multiple patches.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20181203102200.GA104797@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/subcmd/parse-options.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.h b/tools/lib/subcmd/parse-options.h
index 6ca2a8bfe716..af9def589863 100644
--- a/tools/lib/subcmd/parse-options.h
+++ b/tools/lib/subcmd/parse-options.h
@@ -71,7 +71,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `argh`::
  *   token to explain the kind of argument this option wants. Keep it
- *   homogenous across the repository.
+ *   homogeneous across the repository.
  *
  * `help`::
  *   the short help associated to what the option does.
@@ -80,7 +80,7 @@ typedef int parse_opt_cb(const struct option *, const char *arg, int unset);
  *
  * `flags`::
  *   mask of parse_opt_option_flags.
- *   PARSE_OPT_OPTARG: says that the argument is optionnal (not for BOOLEANs)
+ *   PARSE_OPT_OPTARG: says that the argument is optional (not for BOOLEANs)
  *   PARSE_OPT_NOARG: says that this option takes no argument, for CALLBACKs
  *   PARSE_OPT_NONEG: says that this option cannot be negated
  *   PARSE_OPT_HIDDEN this option is skipped in the default usage, showed in
-- 
2.19.2
