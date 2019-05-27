From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/44] perf-with-kcore.sh: Always allow fix_buildid_cache_permissions
Date: Mon, 27 May 2019 19:36:47 -0300
Message-ID: <20190527223730.11474-2-acme@kernel.org>
References: <20190527223730.11474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527223730.11474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The user's buildid cache may contain entries added by root even if root
has its own home directory (e.g. by using perfconfig to specify the same
buildid dir), so remove that validation.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190412113830.4126-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/perf-with-kcore.sh | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tools/perf/perf-with-kcore.sh b/tools/perf/perf-with-kcore.sh
index 7e47a7cbc195..2ad2fffdb209 100644
--- a/tools/perf/perf-with-kcore.sh
+++ b/tools/perf/perf-with-kcore.sh
@@ -111,11 +111,6 @@ fix_buildid_cache_permissions()
 
 	USER_HOME=$(bash <<< "echo ~$SUDO_USER")
 
-	if [ "$HOME" != "$USER_HOME" ] ; then
-		echo "Fix unnecessary because root has a home: $HOME" >&2
-		exit 1
-	fi
-
 	echo "Fixing buildid cache permissions"
 
 	find "$USER_HOME/.debug" -xdev -type d          ! -user "$SUDO_USER" -ls -exec chown    "$SUDO_USER" \{\} \;
-- 
2.20.1
