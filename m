Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD0783C3C0F
	for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835367; cv=none; b=eqSJpA678fbxEM+jcEWL+VB/aNGh59ySmovF+fCFpZ71SnjACvWnVQ8lFCtoRHuf315qAa24l9Bo92H86SU6QCXhBI+xj9tU0X1yExhyqHFJlAlcQJQxUy8sFTAGFiaLZpUmUuaap/rHXWplntLl6kyKbZ7EE+65GQuLywKWxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835367; c=relaxed/simple;
	bh=vww+rjEciI/jnuHVolvlPKNoqynwRPmfdwRnigpNjsk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MNg+wqQ2EuABPssW6H0zZxTp9vqTRJMkmIIlWO/KTxn/Cb9LIVCMazNIvPzRBL765S6D9DDvt+Ui06IAcEi1ctTJJ9mTakajiJ4OguEe32N1vnRVpjF+9FDMzmcOuscGBxLVOQxsKKYvmfDaIyhcnkd5NxF/znX17kd/8FZlt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ggb7Y3dl; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ggb7Y3dl"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304448ab58cso2579645eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 26 May 2026 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779835366; x=1780440166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xQxE4m0y/g/kyGF/YyzHUqc5QrloWGxY2+46+x6obQ0=;
        b=ggb7Y3dlE8NfzVzoUuJthES1VJClQZZplhbfZgKCwDz6yRnQ4FdcOwm+Q35tl1JCdS
         WbTdOEs5r7fgwQq/KNwZG5ioYHcrLvunEU+r2rjWw1ON31BitsXtwsLUElgQuHQ2k/vW
         3+n8931En6RSjdASGgqCZe+NSoiKx00D9zlAXAEyXNkyzVprHw1cATKKGwqkt8n0ae5j
         A+AvmNSRp7IQQHD7ImyRsaWcFOMZD2CQ16sOKeM5RkN3CyHi6f8EGVnmTbm/mE1jEAUY
         SCD1FcPLwoXvzV3fGb12cuHPiIHPU/PX2r46oipze4JrS46ab4N52irtem+XVCS58F8l
         ARuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779835366; x=1780440166;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xQxE4m0y/g/kyGF/YyzHUqc5QrloWGxY2+46+x6obQ0=;
        b=H4M+zaJ42d+3m5ScOMyCobcrn+fDA6bWqMpEV6yAomRioEX4o3xkg6/Ba7XQ2qJaoN
         SS3s9hDqrY0dpTO51B034s8LdWDvwrCozyV08dt//7QN4+rNM9UCUcRHlUV88PHLo8/e
         ZLttpIwcg5No2kY+k9RMq944Yrnfa3VMD2Aaka0YSCs9uYn1RHhGwyW+bPv/Jms+Ifzf
         Sdzf4Wnu9e4lrcMH387j0sMarlK2IZhtp0gGETdzQ3yL5yqCcQnB+aWq6AG4Cu8mjqP4
         7wNE0c8RamJrII0x22IsAjaHezkQu9JpoJ0ojWBFE5fikqIW17/dxow3SwBisCEj03uP
         V+0Q==
X-Forwarded-Encrypted: i=1; AFNElJ88TPkLJzWWN0L7ZjtOAhDJ68iMyahEt1keOiT0W1a+BHDG/SfMMUEDeUpUWZJzdx2eamyxJZ/gouinpHDxfKIc@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz0CIkk3aM4p0AH6TvwTLNGERjSpO6nHVHsILFNPpNezWyIdem
	qo5KbSUJErEB3DlgjNJkC1BSvAg2ZDb/jFd8IyXtER5TKSqbLjiRGhghF72vliBQrQLKaQDfxg9
	CcGhmpwKRmQ==
X-Received: from dybup7.prod.google.com ([2002:a05:7301:c087:b0:304:997c:c43e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ef83:b0:2f2:b544:2fd4
 with SMTP id 5a478bee46e88-30449201503mr10361396eec.34.1779835365521; Tue, 26
 May 2026 15:42:45 -0700 (PDT)
Date: Tue, 26 May 2026 15:42:41 -0700
In-Reply-To: <20260526213911.3993710-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260526213911.3993710-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260526224241.4016312-1-irogers@google.com>
Subject: [PATCH v2] perf clang-format: Prioritize Python.h and expand other categories
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
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
2.54.0.823.g6e5bcc1fc9-goog

