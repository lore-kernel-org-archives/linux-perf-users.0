From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 01/75] perf build: Give better hint about devel package for libssl
Date: Thu,  6 Dec 2018 18:24:48 -0300
Message-ID: <20181206212602.20474-2-acme@kernel.org>
References: <20181206212602.20474-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181206212602.20474-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Stephane Eranian <eranian@google.com>, Wang Nan <wangnan0@huawei.com>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In debian/ubuntu its libssl-dev, but for fedora/RHEL/Centos/etc its
openssl-devel, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Fixes: 8ee4646038e4 ("perf build: Add libcrypto feature detection")
Link: https://lkml.kernel.org/n/tip-lnxqszts6aq2c9jy4b7mlnym@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.config | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index e110010e7faa..c643d5e0c26b 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -588,7 +588,7 @@ endif
 
 ifndef NO_LIBCRYPTO
   ifneq ($(feature-libcrypto), 1)
-    msg := $(warning No libcrypto.h found, disables jitted code injection, please install libssl-devel or libssl-dev);
+    msg := $(warning No libcrypto.h found, disables jitted code injection, please install openssl-devel or libssl-dev);
     NO_LIBCRYPTO := 1
   else
     CFLAGS += -DHAVE_LIBCRYPTO_SUPPORT
-- 
2.19.2
