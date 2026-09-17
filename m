Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A03E410E
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620832; cv=none; b=NuhOifqmMhdE2aDjM5CgIA/ERgxFgvubnxDS+70zq5e+VxfbeYMTLw/sZauGCbc1aYQKOOKVBee5rXPPeZDj4N81Q+KiNWQ/yUShPQ41VsPkKOi4wlvVdki7hqlKiYdktm837EmvoPddoMl6k1bli+VuX6bjgY7Lr5Ultcwj7Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620832; c=relaxed/simple;
	bh=5DklQJpfCFJyN0EZrRZqRXjxXKTZyUSm4Q+g/bsrlA8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tOHoQfm0vpqKaQaIVR2JnNcqLh+yyHQtld4wPbBFdDZMCw7qAwirXK3wi0ZyTRaVFBCgvkjq99XNXHzHi63kg5MaGoSM5YzyDBAm0PSki1dtXmwxktjWyvWuvzM+dnsvf6QDDYngIhWMM4M/CtmYabXh3L+Q2gBkwYEJ6vRfQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OX25Gn7k; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OX25Gn7k"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d94a158dc8so9215625ad.2
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620829; x=1790225629; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ctknpE6kMV5LkwM9lNHtmlsQ1sWEmYmqXPSOFSZmCm4=;
        b=OX25Gn7kOuOpuWa8t41EIB7Ldk7ZTJVHPh+brxsLz/koIVy6N3BmaKMyy30ZJcnP14
         IysnRzr6GZQ6xmw953oqfvXTRqKfNp1jAsocJkhT8mw2ryxEG401KsxsFWa6Uam/LV4c
         Zc5qTgNONK5oP12HGjRuGBEtsB1u3c2AlQ4sOh1zKQJfDc75y1o+3IKcylF83Xcf58aK
         2lMOZZgRE3A9f2hKpHJq24r2RkGJMNlwUKDuDLXv2jfDLF5feWOpC8iiXbI6ncGVp1Pm
         JyF8jmqhBGVTu5QIScBoI9EmqX+mmicfIhQnCCCJaf3BFnfwUPq4WiWkZzD9FD5Dfz4t
         Tiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620829; x=1790225629;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ctknpE6kMV5LkwM9lNHtmlsQ1sWEmYmqXPSOFSZmCm4=;
        b=SOjP3pHBCiNg3tqdggMCxKfODMibOYDjgxnV6ciTt03B1twV7rzWyp1AhWHnspUFZf
         jQ8xVng1XXn6P7ykz+NYVeWbrbndOpe/8N9qIWr9WUg9OUmaq9JXcL13ZgztTVVeavcu
         wqIREOnh3ExgWwKZm+skzb2yI9g3UN1e7xLgS+3xpwyWs4/W+bvtafcZAvPdYrJm6klU
         uoV6IFeq+AkwQRF6Kiukm6/N3JcbgnTbw3qUY1qm8PYHNnDycYjXj6CneoinVZRCkDwt
         +h6YMAFBFIsd8SG3+W451pXFHgG5YUBw3NviopBbtsXMGzrIKG8Psk2IOAfk+LRq0s6R
         98WA==
X-Forwarded-Encrypted: i=1; AKwUvBwrA/9PEowKDpifQVKNSQVmpIdQZ7MVHkooNJrGIF1iHVIE405qIzIlLuyeyD8PQyCHprIEXt8mfJN0xE+D1ycQ@vger.kernel.org
X-Gm-Message-State: AFuF++lrW50fd5mZZnizcTbdBqjxq7w4KobyCO4oCS/nv2oJMKlNd0RP
	uUqTZxu3wyM3Mifv/v0N/2lpCz4oWHvaPypgzma2xSQjsPsJdKonL4bITlCpDJjPx9MCBwCtCqJ
	BIvFlyxc9UA==
X-Received: from dycc4.prod.google.com ([2002:a05:693c:60c4:b0:336:afee:118c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:2584:b0:3da:bea4:6215
 with SMTP id adf61e73a8af0-3dd5f72046cmr12464935637.19.1789620829321; Wed, 16
 Sep 2026 21:53:49 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:23 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-8-irogers@google.com>
Subject: [PATCH v1 08/11] perf annotate-data: missing <string.h> inclusion for
 libc string functions
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When compiling the perf tool with musl libc,
  tools/perf/util/annotate-data.c fails to build due to the missing
  <string.h> header.

  The source file utilizes standard C library string and memory
  functions, such as memset() in init_type_state() and strcmp() in
  data_type_cmp(). While glibc implicitly pulls in <string.h> via
  other standard headers, musl libc enforces stricter header
  separation. Because the header is not explicitly included at the top
  of the file, the compiler encounters implicit function declarations
  for these standard string functions. This results in a direct
  compile-time build error.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate-data.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index aff60a630fd0..02df833504be 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -4,20 +4,23 @@
  *
  * Written by Namhyung Kim <namhyung@kernel.org>
  */
+#include "annotate-data.h"
+
 #include <errno.h>
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <inttypes.h>
+#include <string.h>
+
 #include <linux/zalloc.h>
 
 #include "annotate.h"
-#include "annotate-data.h"
-#include "debuginfo.h"
 #include "debug.h"
+#include "debuginfo.h"
 #include "dso.h"
 #include "dwarf-regs.h"
-#include "evsel.h"
 #include "evlist.h"
+#include "evsel.h"
 #include "map.h"
 #include "map_symbol.h"
 #include "sort.h"
-- 
2.55.0.1082.g2b9226bbc0-goog

