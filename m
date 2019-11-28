From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 16/22] perf diff: Use llabs() with 64-bit values
Date: Thu, 28 Nov 2019 10:40:21 -0300
Message-ID: <20191128134027.23726-17-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Jin Yao <yao.jin@linux.intel.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

To fix these build errors on a debian mipsel cross build environment:

  builtin-diff.c: In function 'block_cycles_diff_cmp':
  builtin-diff.c:550:6: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    550 |  l = labs(left->diff.cycles);
        |      ^~~~
  builtin-diff.c:551:6: error: absolute value function 'labs' given an argument of type 's64' {aka 'long long int'} but has parameter of type 'long int' which may cause truncation of value [-Werror=absolute-value]
    551 |  r = labs(right->diff.cycles);
        |      ^~~~

Fixes: 99150a1faab2 ("perf diff: Use hists to manage basic blocks per symbol")
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-pn7szy5uw384ntjgk6zckh6a@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-diff.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 376dbf10ad64..eae879376283 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -547,8 +547,8 @@ static int64_t block_cycles_diff_cmp(struct hist_entry *left,
 	if (!pairs_left && !pairs_right)
 		return 0;
 
-	l = labs(left->diff.cycles);
-	r = labs(right->diff.cycles);
+	l = llabs(left->diff.cycles);
+	r = llabs(right->diff.cycles);
 	return r - l;
 }
 
-- 
2.21.0
