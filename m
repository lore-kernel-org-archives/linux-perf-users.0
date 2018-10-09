From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 04/12] perf strbuf: Match va_{add,copy} with va_end
Date: Mon,  8 Oct 2018 21:54:19 -0300
Message-ID: <20181009005427.6607-5-acme@kernel.org>
References: <20181009005427.6607-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181009005427.6607-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sanskriti Sharma <sansharm@redhat.com>, Joe Lawrence <joe.lawrence@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Sanskriti Sharma <sansharm@redhat.com>

Ensure that all code paths in strbuf_addv() call va_end() on the
ap_saved copy that was made.

Fixes the following coverity complaint:

  Error: VARARGS (CWE-237): [#def683]
  tools/perf/util/strbuf.c:106: missing_va_end: va_end was not called
  for "ap_saved".

Signed-off-by: Sanskriti Sharma <sansharm@redhat.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Link: http://lkml.kernel.org/r/1538490554-8161-2-git-send-email-sansharm@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/strbuf.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/strbuf.c b/tools/perf/util/strbuf.c
index 3d1cf5bf7f18..9005fbe0780e 100644
--- a/tools/perf/util/strbuf.c
+++ b/tools/perf/util/strbuf.c
@@ -98,19 +98,25 @@ static int strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
 
 	va_copy(ap_saved, ap);
 	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-	if (len < 0)
+	if (len < 0) {
+		va_end(ap_saved);
 		return len;
+	}
 	if (len > strbuf_avail(sb)) {
 		ret = strbuf_grow(sb, len);
-		if (ret)
+		if (ret) {
+			va_end(ap_saved);
 			return ret;
+		}
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap_saved);
 		va_end(ap_saved);
 		if (len > strbuf_avail(sb)) {
 			pr_debug("this should not happen, your vsnprintf is broken");
+			va_end(ap_saved);
 			return -EINVAL;
 		}
 	}
+	va_end(ap_saved);
 	return strbuf_setlen(sb, sb->len + len);
 }
 
-- 
2.14.4
