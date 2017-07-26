From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 30/40] perf script: Remove some bogus error handling
Date: Wed, 26 Jul 2017 11:17:20 -0300
Message-ID: <20170726141730.30750-31-acme@kernel.org>
References: <20170726141730.30750-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170726141730.30750-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, kernel-janitors@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

If script_desc__new() fails then the current code has a NULL
dereference.  We don't actually need to do any cleanup, we can just
return NULL.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: kernel-janitors@vger.kernel.org
Link: http://lkml.kernel.org/r/20170722073610.nnsyiwdcfl6bhn4t@mwanda
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index d430ff42208a..378f76cdf923 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2199,16 +2199,11 @@ static struct script_desc *script_desc__findnew(const char *name)
 
 	s = script_desc__new(name);
 	if (!s)
-		goto out_delete_desc;
+		return NULL;
 
 	script_desc__add(s);
 
 	return s;
-
-out_delete_desc:
-	script_desc__delete(s);
-
-	return NULL;
 }
 
 static const char *ends_with(const char *str, const char *suffix)
-- 
2.9.4
