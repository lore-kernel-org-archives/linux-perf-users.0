From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 42/86] perf test sdt: Handle realpath() failure
Date: Wed, 19 Jul 2017 11:29:06 -0300
Message-ID: <20170719142950.3747-43-acme@kernel.org>
References: <20170719142950.3747-1-acme@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170719142950.3747-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

It can return NULL, in which case we should bail out and remove the
directory created with mkdtemp(), which is stored in the "__tempdir"
variable, not in "tempdir".

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Fixes: 8e5dc848356e ("perf test: Add a test case for SDT event")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/sdt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/sdt.c b/tools/perf/tests/sdt.c
index 5abe8cea54e6..d80171526f6f 100644
--- a/tools/perf/tests/sdt.c
+++ b/tools/perf/tests/sdt.c
@@ -83,6 +83,8 @@ int test__sdt_event(int subtests __maybe_unused)
 	}
 	/* Note that buildid_dir must be an absolute path */
 	tempdir = realpath(__tempdir, NULL);
+	if (tempdir == NULL)
+		goto error_rmdir;
 
 	/* At first, scan itself */
 	set_buildid_dir(tempdir);
@@ -100,7 +102,7 @@ int test__sdt_event(int subtests __maybe_unused)
 
 error_rmdir:
 	/* Cleanup temporary buildid dir */
-	rm_rf(tempdir);
+	rm_rf(__tempdir);
 error:
 	free(tempdir);
 	free(myself);
-- 
2.9.4
