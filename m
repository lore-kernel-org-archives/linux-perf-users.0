From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: [PATCH 2/7] tools include uapi: Sync sound/asound.h copy
Date: Fri, 19 Apr 2019 09:30:24 -0300
Message-ID: <20190419123029.11328-3-acme@kernel.org>
References: <20190419123029.11328-1-acme@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190419123029.11328-1-acme@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Daniel Mentz <danielmentz@google.com>, Takashi Iwai <tiwai@suse.de>
List-Id: linux-perf-users.vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Picking the changes from:

  Fixes: b5bdbb6ccd11 ("ALSA: uapi: #include <time.h> in asound.h")

Which entails no changes in the tooling side.

To silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Daniel Mentz <danielmentz@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>
Link: https://lkml.kernel.org/n/tip-15o4twfkbn6nny9aus90dyzx@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index 404d4b9ffe76..df1153cea0b7 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -32,6 +32,7 @@
 
 #ifndef __KERNEL__
 #include <stdlib.h>
+#include <time.h>
 #endif
 
 /*
-- 
2.20.1
