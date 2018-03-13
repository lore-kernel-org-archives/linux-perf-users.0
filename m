From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/31] perf vendor events: Fix error code in json_events()
Date: Tue, 13 Mar 2018 09:04:49 -0300
Message-ID: <20180313120508.29327-13-acme@kernel.org>
References: <20180313120508.29327-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180313120508.29327-1-acme@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>, Andi Kleen <ak@linux.intel.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, John Garry <john.garry@huawei.com>, Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org, linuxarm@huawei.com, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>, Namhyung Kim <namhyung@kernel.org>, William Cohen <wcohen@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-perf-users.vger.kernel.org

From: John Garry <john.garry@huawei.com>

When EXPECT macro fails an assertion, the error code is not properly set
after the first loop of tokens in function json_events().

This is because err is set to the return value from func function
pointer call, which must be 0 to continue to loop, yet it is not reset
for for each loop. I assume that this was not the intention, so change
the code so err is set appropriately in EXPECT macro itself.

In addition to this, the indention in EXPECT macro is tidied. The
current indention alludes that the 2 statements following the if
statement are in the body, which is not true.

Signed-off-by: John Garry <john.garry@huawei.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxarm@huawei.com
Link: http://lkml.kernel.org/r/1520506716-197429-3-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/jevents.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index 9e0a21e74a67..edff989fbcea 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -249,9 +249,10 @@ static const char *field_to_perf(struct map *table, char *map, jsmntok_t *val)
 	jsmntok_t *loc = (t);					\
 	if (!(t)->start && (t) > tokens)			\
 		loc = (t) - 1;					\
-		pr_err("%s:%d: " m ", got %s\n", fn,		\
-			json_line(map, loc),			\
-			json_name(t));				\
+	pr_err("%s:%d: " m ", got %s\n", fn,			\
+	       json_line(map, loc),				\
+	       json_name(t));					\
+	err = -EIO;						\
 	goto out_free;						\
 } } while (0)
 
@@ -416,7 +417,7 @@ int json_events(const char *fn,
 		      char *metric_name, char *metric_group),
 	  void *data)
 {
-	int err = -EIO;
+	int err;
 	size_t size;
 	jsmntok_t *tokens, *tok;
 	int i, j, len;
-- 
2.14.3
