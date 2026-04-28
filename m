Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CCD133A014
	for <linux-perf-users@vger.kernel.org>; Tue, 28 Apr 2026 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359278; cv=none; b=UHfqrUh+q6OT9lFPl+CBFyVtB06N1vJMoo8+Zj5/MtKHSmHRQQySQj1YDBBCx1tKt/H+0aYCG/02yTs+63jWDwr/V1MoRbiLYnuoMvmc89T6P2TnYPPTKyJ/OD6gEflZyfQ9BK8UD4dlwyTw4WoQ2ocDFk9R9qZYGjF5ovK+/Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359278; c=relaxed/simple;
	bh=IM9ESi6nZ2GNqGO23/dFzs6wZwAg2FXQqPWBRXVgMic=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GN208KqFtnd+eHVinjh9nBSkeb7R8jmkz1uFN95W/bwsQqog4wgM6XfxgW12l78U1qpOa//3P4xRW3dWDyPKj/R9BRkiVHlk6r/L6F6qwk5VaOGPUTtRL+0X+83M9yJ0hXpR24AFwvHpc2kI8H0Oat9P17LphqI6glJtvpcEwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k2gd9TjA; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k2gd9TjA"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12c87ba0890so39466979c88.0
        for <linux-perf-users@vger.kernel.org>; Mon, 27 Apr 2026 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777359277; x=1777964077; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zio41ZFzhjPT5cI6wrI5OFkLmqAK3oJn4tmFEmpUdG4=;
        b=k2gd9TjAdsV603Xc9cbpVWKDGBlSE4rRf3h56WAMb3JRD5G6SEIr/f9BdGxY7eNsK2
         oqgAUw+p5721Ftjt9Zn/B3+6P7jMdqZfRxZGeIfMxhZ8HfmFAccFX6J5nbGk+zjl5LEb
         xJuQqMr1LqUCXL202XP/8ZeMRsNXbJcenFtvbEM0xrF29LcLF/AYxZdolE6f37HoXHLa
         6TpH6re+e4LaBSf3RCU9hCTbTszRFTdNkFvBZkTK5ykz4uf37XKapgj/7YZ8JhoN9e/E
         WJVSlJuZcHfTOxd3Ir/8mLBypVKdRru0I1y2O21EUguMtwsQtt6vU9M99ubDnTU1OMX6
         lzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359277; x=1777964077;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zio41ZFzhjPT5cI6wrI5OFkLmqAK3oJn4tmFEmpUdG4=;
        b=Pqo24ybO9iwxAUS2zyplu7kvyPl3iaSfdpu3h3nB31Nb26bAdVl63ey9Z1w7sO1yA4
         ZSiFmo41IDZrYon9jzNqRPXmrg4ZGeBpTvUot8tMIsQJA3VrEOa1SEDR3wE4hHSZ28Ca
         Iw0iQiSZ4kKtZUAlzeYQKT3UeKatoFU9TNHUhDg44hhiNdK9joPcEnRTVkbyzLqAnUTc
         788tlgCHzOABEpZ1YYlc4CS5iMkLEWtOYffaKV18FPPpnxjhIb8K9t30Yi4qxRGaxbvK
         GNtluVAZwlmrB2QbJVAgwWM8IO91biOqpPbgtN7L2TltUjqfj5JHh/zlxUA2Z8odtLyO
         xSAg==
X-Forwarded-Encrypted: i=1; AFNElJ/jAekCrfdEeGmgRFSTYdE3UDDPwx4HZOcJkJuH6JizFq5kWQeMftx6+tL79PdtJkccS3gGyg/IvAULlnAhj/rh@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/S3qaPAZpTn7R4BE4PxuCegCL5cYCRnOI711bOvzzLNIDEq1q
	9Vgg/eLk0365Eg+g0U3CWLCcpMgsEQGZVyX0Kgx1R3TlSD6EV8EP+tDSF9jf55OOv7y+e6SKTli
	GL8PhebyiAA==
X-Received: from dlbto5.prod.google.com ([2002:a05:7022:3b05:b0:12c:1f83:7b4c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:e28:b0:128:c9fa:4c32
 with SMTP id a92af1059eb24-12ddd9dd721mr881046c88.28.1777359276536; Mon, 27
 Apr 2026 23:54:36 -0700 (PDT)
Date: Mon, 27 Apr 2026 23:54:32 -0700
In-Reply-To: <20260407165551.3075684-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260407165551.3075684-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428065432.1877423-1-irogers@google.com>
Subject: [PATCH v2] perf clang-format: Add a perf clang-format that overrides
 some kernel behaviors
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: akpm@linux-foundation.org, joe@perches.com, justinstitt@google.com, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, morbo@google.com, 
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In particular, header file ordering is an issue in the tools/perf
directory given the larger number of depended upon libraries.

The order of header file includes was proposed in:
https://lore.kernel.org/linux-perf-users/CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com/

Sorting headers is desirable to avoid issues like duplicate includes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
v2: Move the .clang-format file under tools/perf rather than tools/.
---
 tools/perf/.clang-format | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 tools/perf/.clang-format

diff --git a/tools/perf/.clang-format b/tools/perf/.clang-format
new file mode 100644
index 000000000000..902b2f7456f6
--- /dev/null
+++ b/tools/perf/.clang-format
@@ -0,0 +1,20 @@
+BasedOnStyle: InheritParentConfig
+SortIncludes: true
+IncludeBlocks: Regroup
+IncludeCategories:
+  # Implicitly the corresponding header for the C file has Priority 0
+  # C Standard Library Headers
+  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|iso646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbool|stddef|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|time|uchar|wchar|wctype)\.h>'
+    Priority:        1
+  # OS/System-Specific Headers (directories)
+  - Regex:           '^<(sys|linux|asm|arpa|net|netinet|x86_64|machine)/.*>'
+    Priority:        2
+  # OS/System-Specific Headers (POSIX/System flat headers)
+  - Regex:           '^<(unistd|pthread|fcntl|dirent|dlfcn|poll|sched|semaphore|spawn|syslog|termios|pwd|grp|netdb|sysexits|err|paths|pty|utmp|resolv|ifaddrs|elf|libelf|gelf)\.h>'
+    Priority:        2
+  # Third-Party Library Headers
+  - Regex:           '^<.*>'
+    Priority:        3
+  # Your Project's Other Headers
+  - Regex:           '^".*"'
+    Priority:        4
-- 
2.54.0.545.g6539524ca2-goog

