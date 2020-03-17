From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 08/23] perf map: Use strstarts() to look for Android libraries
Date: Tue, 17 Mar 2020 18:32:44 -0300
Message-ID: <20200317213259.15494-9-acme@kernel.org>
References: <20200317213259.15494-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200317213259.15494-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Dominik Czarnota <dominik.b.czarnota@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And add the '/' to avoid looking at things like "/system/libsomething",
when all we want to know if it is like "/system/lib/something", i.e. if
it is in that system library dir.

Using strstarts() avoids off-by-one errors like recently fixed in this
file.

Since this adds the '/' I separated this patch, another patch will make
this consistent by removing other strncmp(str, prefix, manually
calculated prefix length) usage.

Reported-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Acked-by: Dominik Czarnota <dominik.b.czarnota@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: Link: http://lore.kernel.org/lkml/CABEVAa0_q-uC0vrrqpkqRHy_9RLOSXOJxizMLm1n5faHRy2AeA@mail.gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index b342f744b1fc..53d96611e6a6 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -44,8 +44,8 @@ static inline int is_no_dso_memory(const char *filename)
 
 static inline int is_android_lib(const char *filename)
 {
-	return !strncmp(filename, "/data/app-lib", 13) ||
-	       !strncmp(filename, "/system/lib", 11);
+	return strstarts(filename, "/data/app-lib/") ||
+	       strstarts(filename, "/system/lib/");
 }
 
 static inline bool replace_android_lib(const char *filename, char *newfilename)
@@ -65,7 +65,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 
 	app_abi_length = strlen(app_abi);
 
-	if (!strncmp(filename, "/data/app-lib", 13)) {
+	if (strstarts(filename, "/data/app-lib/")) {
 		char *apk_path;
 
 		if (!app_abi_length)
@@ -89,7 +89,7 @@ static inline bool replace_android_lib(const char *filename, char *newfilename)
 		return true;
 	}
 
-	if (!strncmp(filename, "/system/lib/", 12)) {
+	if (strstarts(filename, "/system/lib/")) {
 		char *ndk, *app;
 		const char *arch;
 		size_t ndk_length;
-- 
2.21.1
