Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10484028C3
	for <linux-perf-users@vger.kernel.org>; Fri,  5 Jun 2026 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780640665; cv=none; b=LE5bhJ1NYABCz4U8fkOCJO1rw1oAXm82V7A7l56qXVKue2FWvieCWX80ilb43e+9WL3GO42wkEH6ee567oQ0BRCPlPk5Xqo8bNfEzjClJOXq5kvoZlE36sFrmvlKexRmXulAR6nEv4yhRGHEawDDueFqPKUH0Ci28Gj7ivpJnpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780640665; c=relaxed/simple;
	bh=SsYVsQeKi/5b/UzZewCXaxnNrPG6g8xXWLF60LmEvtU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hFYQNv5o3VqOT/P+oNRgAnRTte9CPFRdNbKHG9eyrB2t3R9TKYY0jsxyDpgGLqTC/nOaZSJfcZ1avef/FeqFlQNmkx8xZR+ER+0qHOSqrEiSt6pytX+hJyqgKeYj9piKMCCeQlBXbluJxeX19JG+oaR2zpmI7mpGzmw50nDnqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iFb3Duym; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iFb3Duym"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304b8d0ee63so1957699eec.0
        for <linux-perf-users@vger.kernel.org>; Thu, 04 Jun 2026 23:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780640664; x=1781245464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWVEvD+ATZ8vjsTwLHNHtlWDj39jPmck2CQkdnWUZgM=;
        b=iFb3DuymdZshqJHy2YsJZ9HEYBc96gvn4o3INBh3om0P3tQ/GVxHKsZAQjmRT0s+vJ
         cdSmhjy+qf9rd1AMICEEfvIRLwk2Z4LT6CTkB3mrLK3d7mJJfKdh53bQRfTr7CiBQger
         6Ox/JzAPJPClGFnN4ydHF+CImNDmP7KgRFmizs2sIciKnSDPghlUR9EVnM6Vuamk4utq
         SzPwBek61j6SENDQkK71JF5oDkrxEsWdhw6qIHuOlHEsqbPby31HmMYlaMysgEgWdKj/
         gZdPzSKmRJcBIPR0wiSvLzTOa+qx7Uj/xIkw8QiOU5eJ74Tdu9kNVbUZwuXbm1+psrqI
         tRDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780640664; x=1781245464;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jWVEvD+ATZ8vjsTwLHNHtlWDj39jPmck2CQkdnWUZgM=;
        b=r/yankOoXR3Wv7g1SJ45eKS0zYFymt1fKv/xl+5Cd58BfiIXAwlad979+aBz3rrmpC
         sUMHmeDSHxRilzvc8q2E3gu7NhUop6q9TnzeSIBPZA4i5hdXp7iWPtyQBinqo+JCDG8Y
         vMCnH37Z7X9jiGWjvxoblBHmPWvuIhZYDuiNuoKDQCZvaSXuFowtAMeVn13n4YahSPJE
         lgjLoBizUNQcEbTwsnotdXmO5WQkwyGkN5AKYiIyWCtJZj5nK1w4hT5xvmJLbalvemBs
         jL5vMg9tt7aASOORTZvyXuRkfkDtG0YdJs9cF9VmWoEF/v5i6lVGl6DZM6QUkCpYra4d
         IMtw==
X-Forwarded-Encrypted: i=1; AFNElJ9VE1X35DWS3skii7MIdB+NQkidBbmlp2PCKrRIFFQlyF/AOeIkeXGiVzkGzB9WDL1L4oOFa9mQ3AWqIC7Zl/zQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzNU69Agqsc7kY21qSPesCgzBI707gp90kS0npzhsrVGAf3y0e5
	rXHHIpaVeLwrZA+YFAI7NkDtPBNQoMxBce/BZ9BnyKsVufy091Rzp5a8ndpsAfC6GRhVkV4DNiZ
	+e4cm6OtC5w==
X-Received: from dlbvg7.prod.google.com ([2002:a05:7022:7f07:b0:137:ee83:5523])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:7488:b0:2cb:4b8f:b2bd
 with SMTP id 5a478bee46e88-3077af30ab5mr1102274eec.6.1780640663432; Thu, 04
 Jun 2026 23:24:23 -0700 (PDT)
Date: Thu,  4 Jun 2026 23:24:18 -0700
In-Reply-To: <20260526224241.4016312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526224241.4016312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605062418.1540615-1-irogers@google.com>
Subject: [PATCH v3] perf clang-format: Prioritize Python.h and expand other categories
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This commit updates the .clang-format rules for the perf tools.
It prioritizes Python.h sorting and expands the regex lists for C
standard library and OS specific headers.

- Prioritize Python.h by sorting it first (Priority -1), ensuring it
  is sorted before even the main header (Priority 0).
- Keep other header priorities (1 and 2) to maintain their relative
  order.
- Sanity check and complete "C Standard Library Headers" up to C23
  (added stdbit.h, stdckdint.h).
- Sanity check and complete "OS/System-Specific Headers" based on
  actual usage in tools/perf (added asm-generic, uapi, and various
  flat POSIX/system headers).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.clang-format | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/.clang-format b/tools/perf/.clang-format
index 902b2f7456f6..e4cff363a603 100644
--- a/tools/perf/.clang-format
+++ b/tools/perf/.clang-format
@@ -2,15 +2,18 @@ BasedOnStyle: InheritParentConfig
 SortIncludes: true
 IncludeBlocks: Regroup
 IncludeCategories:
+  # Python.h must be first
+  - Regex:           '^<Python\.h>'
+    Priority:        -1
   # Implicitly the corresponding header for the C file has Priority 0
   # C Standard Library Headers
-  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|is=
o646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbool|std=
def|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|time|uchar|wchar|=
wctype)\.h>'
+  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|is=
o646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbit|stdb=
ool|stdckdint|stddef|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|=
time|uchar|wchar|wctype)\.h>'
     Priority:        1
   # OS/System-Specific Headers (directories)
-  - Regex:           '^<(sys|linux|asm|arpa|net|netinet|x86_64|machine)/.*=
>'
+  - Regex:           '^<(arpa|asm|asm-generic|linux|machine|net|netinet|sy=
s|uapi|x86_64)/.*>'
     Priority:        2
   # OS/System-Specific Headers (POSIX/System flat headers)
-  - Regex:           '^<(unistd|pthread|fcntl|dirent|dlfcn|poll|sched|sema=
phore|spawn|syslog|termios|pwd|grp|netdb|sysexits|err|paths|pty|utmp|resolv=
|ifaddrs|elf|libelf|gelf)\.h>'
+  - Regex:           '^<(aio|byteswap|dirent|dlfcn|elf|endian|err|execinfo=
|fcntl|features|fnmatch|ftw|gelf|getopt|grp|ifaddrs|libelf|libgen|malloc|me=
mory|mntent|netdb|numa|numaif|paths|poll|pthread|pty|pwd|regex|resolv|sched=
|semaphore|spawn|strings|syscall|sysexits|syslog|termios|unistd|utmp|x86int=
rin)\.h>'
     Priority:        2
   # Third-Party Library Headers
   - Regex:           '^<.*>'
--=20
2.54.0.1032.g2f8565e1d1-goog

