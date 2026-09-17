Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154FF3E40FD
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620830; cv=none; b=SpfcVSiEOteOZQM5gZdbwbvgo+2EfpxYtbrsYVFDKxWxodVcU+8oXbPI/XqEw+JTN2InmenqaJW3Lr+VFlfVwaVLavzsAr1u6dNV3k8zxpQUzHqSYTW3GXuGvfkSFd4prs2uWbDnGgqS2yzSmmvgYwr19SvaWZpxfn2Rhus3fAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620830; c=relaxed/simple;
	bh=XMY6It02gomDaO+lQY03j88MDhp7d33GjXIQLWPQlJs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L4PLut+A8wFulf91FjLVnSvVwkCgKE+JTIMEljeLRPMdEaiPuNf7hIy135Rhbi6kxMwANUtTmuB6WEGq+GsWB1TagfmK/xssYZiC6w3X0qbHjvX/TvpraFPolRyAXrYV9uVGurESJuOLHwS6i4ZXiyf3+avmfB+mJv1xcqAIH18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jkZxk82d; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jkZxk82d"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e7ff7b375so612063a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620825; x=1790225625; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2+yu5lUjZB/Uf4gL/uikHbr9OPJzXTroFwBV7D22ya8=;
        b=jkZxk82d9ln6SEQggWlIevDzE3pi911AeJX3eefxp8c5HsXRZq+BnI4AeVhj4FXi4E
         szlHGQLW2ek6C2D4Kvfy8VUkK5k7ZEcF+qzoKGfuNg6O0sLId5St5nU55QAnyRTP9I46
         6e4Gv6TPHFHOpABPVjwjsW56WsbolXZr9l6wf9b7ukS0ve2NFAWDXLfYFUiiKYrQSGRC
         Es/Cudw7wy/xmNxjv9eIk/bcrRlmNFpBxCY8CIEyZszpba7cRjNY3X16aCuonETbZLMq
         xMq9XwT+l+WsnuSLk6fkXfHI06Bv0XyYX+KA0sYW5Hf+pc2DaaJfZ9bnDP6XIQ6o79sZ
         QTAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620825; x=1790225625;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2+yu5lUjZB/Uf4gL/uikHbr9OPJzXTroFwBV7D22ya8=;
        b=RrDYHa6ytYyDnqDfiLed3KV2/je04d91l4Xj8DJq/zjngCbCIUo4JITrl8HLBAX62N
         EhZbGYFhZ7frCkH9Umi/7kboEuOxaGt62C0p/itkHvofbTEwAifQmljinLK5rKbKzW1K
         SzWZtn18NUUuHiQa589VSWPOxSz9vxlasTNH9Lg/Et2R2febfGlrz1e7I0ihJfBVvBe6
         BQWlGFvQ+P33KuWFzDrf8r3+0lR7axpY2Y3EjjxI4+O5GwQGftgoWtfj96BUXhxhkO70
         MWbqPGz4fZnROergYmpmAIK7roxUqS40rFCLoHcgBGJ19Iw73mYdmSvo+L89tK6AAeZb
         8x3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzG+kIdfOtKuqAOvGfAmiYIchAGDWgqGF2zYzY0YyFTjW/dogYr144XFiFzQaUDrpm4pyliUWlcmiXTKScKB7jk@vger.kernel.org
X-Gm-Message-State: AFuF++lchZ5uBERBR/hneza6EvBvea6L2mYRwGcs0bZAOC7toULRUKSw
	8eBMIFyp0L0wlsn+pM72IUPFipKIATY+M30cHwFZdONmXXgi1mSpjaU8gvWR/v2vfyH8rzeGJQm
	K46VKMR3Xfg==
X-Received: from dled18-n2.prod.google.com ([2002:a05:701b:42d2:20b0:144:bef2:bc76])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c88:b0:39d:fd82:de0c
 with SMTP id 98e67ed59e1d1-39e1e278ae9mr11868893a91.2.1789620825041; Wed, 16
 Sep 2026 21:53:45 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:21 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-6-irogers@google.com>
Subject: [PATCH v1 06/11] perf test: missing stdio.h and signal.h inclusions
 in cmd_test()
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When compiling the perf tool against musl libc, the build fails in
  tools/perf/tests/builtin-test.c due to missing explicit inclusions
  of <stdio.h> and <signal.h>.

  The file relies on standard I/O functions like fdopen() and
  fprintf(), as well as signal handling constructs like signal(),
  SIGINT, and SIGTERM within __cmd_test() and related helpers. While
  glibc may implicitly pull in these definitions through other
  standard headers such as <stdlib.h> or <unistd.h>, musl libc
  strictly enforces POSIX namespace separation and avoids implicit
  header inclusion. Because the required headers are absent, the
  compiler cannot resolve these standard library types and macros,
  resulting in a direct compilation failure on musl-based systems.

Add the header files and use git clang-format to sort.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 4d0784b16723..ca3e7b84d5d7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -5,16 +5,15 @@
  * Builtin regression testing command: ever growing number of sanity tests
  */
 #include <ctype.h>
-#include <fcntl.h>
 #include <errno.h>
-#ifdef HAVE_BACKTRACE_SUPPORT
-#include <execinfo.h>
-#endif
 #include <setjmp.h>
+#include <signal.h>
+#include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 
 #include <dirent.h>
+#include <fcntl.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/zalloc.h>
@@ -44,6 +43,10 @@
 #include "util/strbuf.h"
 #include "util/term.h"
 
+#ifdef HAVE_BACKTRACE_SUPPORT
+#include <execinfo.h>
+#endif
+
 static const char *junit_filename;
 static struct strbuf junit_xml_buf = STRBUF_INIT;
 
-- 
2.55.0.1082.g2b9226bbc0-goog

