From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 06/28] perf annotate browser: Be more robust when drawing jump arrows
Date: Mon,  5 Mar 2018 11:29:10 -0300
Message-ID: <20180305142932.16921-7-acme@kernel.org>
References: <20180305142932.16921-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180305142932.16921-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>, Jin Yao <yao.jin@intel.com>, Kan Liang <kan.liang@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

This first happened with a gcc function, _cpp_lex_token, that has the
usual jumps:

 │1159e6c: ↓ jne    115aa32 <_cpp_lex_token@@Base+0xf92>

I.e. jumps to a label inside that function (_cpp_lex_token), and those
works, but also this kind:

 │1159e8b: ↓ jne    c469be <cpp_named_operator2name@@Base+0xa72>

I.e. jumps to another function, outside _cpp_lex_token, which are not
being correctly handled generating as a side effect references to
ab->offset[] entries that are set to NULL, so to make this code more
robust, check that here.

A proper fix for will be put in place, looking at the function name
right after the '<' token and probably treating this like a 'call'
instruction.

For now just don't draw the arrow.

Reported-by: Ingo Molnar <mingo@kernel.org>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Link: https://lkml.kernel.org/n/tip-5tzvb875ep2sel03aeefgmud@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/annotate.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index e2f666391ac4..6ff6839558b0 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -328,7 +328,32 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 	if (!disasm_line__is_valid_jump(cursor, sym))
 		return;
 
+	/*
+	 * This first was seen with a gcc function, _cpp_lex_token, that
+	 * has the usual jumps:
+	 *
+	 *  │1159e6c: ↓ jne    115aa32 <_cpp_lex_token@@Base+0xf92>
+	 *
+	 * I.e. jumps to a label inside that function (_cpp_lex_token), and
+	 * those works, but also this kind:
+	 *
+	 *  │1159e8b: ↓ jne    c469be <cpp_named_operator2name@@Base+0xa72>
+	 *
+	 *  I.e. jumps to another function, outside _cpp_lex_token, which
+	 *  are not being correctly handled generating as a side effect references
+	 *  to ab->offset[] entries that are set to NULL, so to make this code
+	 *  more robust, check that here.
+	 *
+	 *  A proper fix for will be put in place, looking at the function
+	 *  name right after the '<' token and probably treating this like a
+	 *  'call' instruction.
+	 */
 	target = ab->offsets[cursor->ops.target.offset];
+	if (target == NULL) {
+		ui_helpline__printf("WARN: jump target inconsistency, press 'o', ab->offsets[%#x] = NULL\n",
+				    cursor->ops.target.offset);
+		return;
+	}
 
 	bcursor = browser_line(&cursor->al);
 	btarget = browser_line(target);
-- 
2.14.3
