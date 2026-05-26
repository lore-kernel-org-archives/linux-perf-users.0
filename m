Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DDE316199
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779831596; cv=none; b=Uu6IEsfrW4ekp0YpE1skhAcB99uRTlRJ3Hd81yGE9xvGikq63CmKCdf76AkTU2+o5xFx//gyxYaXfGYz9Y605+wPQTNrwuu//lesmFAydH0IzzU11A06ZcpMV3V4KQQSmsm+hG9ehWIKTUX3va0psROTXn37H5zy/Ehrfwrbdys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779831596; c=relaxed/simple;
	bh=h6ShnP6MKYxorbn1a2yL9QK8oOZ+2yzFT5Cfy8f9klw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=tDWcrpmQ9cxaOnoPGoOhcA+clejMlTG1ztNOxjQL/H6J/+DCaONTJslEpik4260j1BsVd7xNsbuH+qFLuC+g2vDCiP7VqymiOfYiSvvYMmlVPIjNelxZznmqJ8TgN7mGBhjk/M1m8PFHgV0nC0a5usXnDo7Kq6D3HQrV+U9P+nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vV3O43Wc; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vV3O43Wc"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2f2d983d109so4153048eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779831594; x=1780436394; darn=vger.kernel.org;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/ulwypvoCRwiDkM4FEnHj+iOdPbIEoLGxlls4snsVLs=;
        b=vV3O43WcE4GsdJ0VFzclspy6DA2p2DNtX7mDIszvsr/6UCv4SsGjkwLmbDEjmYYtCc
         eDET4atRHQ0Kb9mwAfBe83CD9bK1Y7ZBW0EfIQrEnDhMB94bO28B1U8KYklVIo8TnNs8
         ncyVDvLwuREYkPtAZzy/vn0+/JBQbPfNhoT5ZvVRRkJ7rIoJBkmIyCCAJGErVBOrDshL
         0w2cgXW7fUB78qOmobaKhR6nBBwMx+k4QZqYdDJmCBgWbSEBzVSV/J06EKazmsLWghf4
         IPkEYQDwETvWCRy8tLlyqIp8kmEdG9/zWZ8w+MODWdJa/Wf4PCamNp2aM2u7wUCkbED6
         K3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779831594; x=1780436394;
        h=content-transfer-encoding:to:from:subject:message-id:mime-version
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/ulwypvoCRwiDkM4FEnHj+iOdPbIEoLGxlls4snsVLs=;
        b=MiQZBxjHxuYI/1+ic7ZpO/a/N7208r38onIh4nUVrc3kWz4GDRqvFn5q85EY4puEdy
         7Zj4MENPL4z/rWi3EUNpkmK1Ad7E47KqDX4CDGgJ/PasqB0mvomD0Gpvb5q36c6/jiaP
         MjArM5AKRwnt7vr4d0aHCq7vTXAnHB8TYUZPfwarxLt2Ees95H1skKFZE1ZSETWkNCRv
         ai8tZ2Zt44hZMLjPK/Z1RhmZOL5TsAT2xnc51a0kI27fpH7Hn93o5lLVjqWnP7g/7T1I
         CJk1LF8S5O2YIaEcdoReDFFPSf8mucBFFxJiP1nfQGJNu7yNmpZWsp5/4SkYdfNCE2ZN
         mzhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+PZGh+rpjAc2aYyBA4de91YBZ2Ic2TkOGWBGX6biLC7X0j5tgLh4R8nmZuqtBxc67YZqL9FKLnuF2YVPUKScGO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DxpeeJ02m+r0jjPGySAMrQZVJrx6Vx4lf7o6bK24DOyJjbta
	I4RYIWOlkgGNVoXwaQW1/cFw6oDm0rLIemlDZUBw0iEuig9TnUwNKKDzEvSHko0BRqZESGQhRqa
	8YuFuE0LLzg==
X-Received: from dyjk24.prod.google.com ([2002:a05:7300:2718:b0:303:93ec:5fc5])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:fa8b:b0:2ca:8099:ffc0
 with SMTP id 5a478bee46e88-30448ffc59emr9016292eec.7.1779831594131; Tue, 26
 May 2026 14:39:54 -0700 (PDT)
Date: Tue, 26 May 2026 14:39:11 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260526213911.3993710-1-irogers@google.com>
Subject: [PATCH v1] perf clang-format: Prioritize Python.h and expand other categories
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

- Prioritize Python.h by sorting it first (Priority 0).
- Shift other header priorities down to accommodate Python.h.
- Sanity check and complete "C Standard Library Headers" up to C23
  (added stdbit.h, stdckdint.h).
- Sanity check and complete "OS/System-Specific Headers" based on
  actual usage in tools/perf (added asm-generic, uapi, and various
  flat POSIX/system headers).

Signed-off-by: Ian Rogers <irogers@google.com>
Assisted-by: Antigravity:gemini-3.5-flash
---
 tools/perf/.clang-format | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/perf/.clang-format b/tools/perf/.clang-format
index 902b2f7456f6..68b1c073d070 100644
--- a/tools/perf/.clang-format
+++ b/tools/perf/.clang-format
@@ -2,19 +2,22 @@ BasedOnStyle: InheritParentConfig
 SortIncludes: true
 IncludeBlocks: Regroup
 IncludeCategories:
+  # Python.h must be first
+  - Regex:           '^<Python\.h>'
+    Priority:        0
   # Implicitly the corresponding header for the C file has Priority 0
   # C Standard Library Headers
-  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|is=
o646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbool|std=
def|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|time|uchar|wchar|=
wctype)\.h>'
-    Priority:        1
-  # OS/System-Specific Headers (directories)
-  - Regex:           '^<(sys|linux|asm|arpa|net|netinet|x86_64|machine)/.*=
>'
+  - Regex:           '^<(assert|complex|ctype|errno|fenv|float|inttypes|is=
o646|limits|locale|math|setjmp|signal|stdalign|stdarg|stdatomic|stdbit|stdb=
ool|stdckdint|stddef|stdint|stdio|stdlib|stdnoreturn|string|tgmath|threads|=
time|uchar|wchar|wctype)\.h>'
     Priority:        2
+  # OS/System-Specific Headers (directories)
+  - Regex:           '^<(arpa|asm|asm-generic|linux|machine|net|netinet|sy=
s|uapi|x86_64)/.*>'
+    Priority:        3
   # OS/System-Specific Headers (POSIX/System flat headers)
-  - Regex:           '^<(unistd|pthread|fcntl|dirent|dlfcn|poll|sched|sema=
phore|spawn|syslog|termios|pwd|grp|netdb|sysexits|err|paths|pty|utmp|resolv=
|ifaddrs|elf|libelf|gelf)\.h>'
-    Priority:        2
+  - Regex:           '^<(aio|byteswap|dirent|dlfcn|elf|endian|err|execinfo=
|fcntl|features|fnmatch|ftw|gelf|getopt|grp|ifaddrs|libelf|libgen|malloc|me=
mory|mntent|netdb|numa|numaif|paths|poll|pthread|pty|pwd|regex|resolv|sched=
|semaphore|spawn|strings|syscall|sysexits|syslog|termios|unistd|utmp|x86int=
rin)\.h>'
+    Priority:        3
   # Third-Party Library Headers
   - Regex:           '^<.*>'
-    Priority:        3
+    Priority:        4
   # Your Project's Other Headers
   - Regex:           '^".*"'
-    Priority:        4
+    Priority:        5
--=20
2.54.0.823.g6e5bcc1fc9-goog

