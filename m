From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 14/16] perf strbuf: Remove redundant va_end() in strbuf_addv()
Date: Fri,  4 Jan 2019 15:33:35 -0300
Message-ID: <20190104183337.12771-15-acme@kernel.org>
References: <20190104183337.12771-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190104183337.12771-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Mattias Jacobsson <2pi@mok.nu>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sanskriti Sharma <sansharm@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Mattias Jacobsson <2pi@mok.nu>

Each call to va_copy() should have one, and only one, corresponding call
to va_end(). In strbuf_addv() some code paths result in va_end() getting
called multiple times. Remove the superfluous va_end().

Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Sanskriti Sharma <sansharm@redhat.com>
Link: http://lkml.kernel.org/r/20181229141750.16945-1-2pi@mok.nu
Fixes: ce49d8436cff ("perf strbuf: Match va_{add,copy} with va_end")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 9005fbe0780e..23092fd6451d 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -109,7 +109,6 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 			return ret;
 		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
-		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
 			va_end(ap_saved);
-- 
2.20.1
