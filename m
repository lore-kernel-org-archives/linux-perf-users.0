From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 12/13] perf tools: Initialize perf_data_file fd field
Date: Wed, 19 Sep 2018 11:25:36 -0300
Message-ID: <20180919142537.29985-13-acme@kernel.org>
References: <20180919142537.29985-1-acme@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919142537.29985-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=A9mie=20Galarneau?= <jeremie.galarneau@efficios.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Jérémie Galarneau <jeremie.galarneau@efficios.com>

Building the perf CTF converter fails with gcc 4.8.4 on Ubuntu 14.04
with the following error:

  error: missing initializer for field ‘fd’ of ‘struct perf_data_file’
  [-Werror=missing-field-initializers]

Per 4b838b0db4e9 ("perf tools: Add compression id into 'struct
kmod_path'") and the ensuing discussion on the mailing list, it appears
that this affects other distributions and gcc versions.

Signed-off-by: Jeremie Galarneau <jeremie.galarneau@efficios.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20180829201648.19588-1-jeremie.galarneau@efficios.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/data-convert-bt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index abd38abf1d91..f75d4aa612c5 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1578,7 +1578,7 @@ int bt_convert__perf2ctf(const char *input, const char *path,
 {
 	struct perf_session *session;
 	struct perf_data data = {
-		.file.path = input,
+		.file      = { .path = input, .fd = -1 },
 		.mode      = PERF_DATA_MODE_READ,
 		.force     = opts->force,
 	};
-- 
2.14.4
