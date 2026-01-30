Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2B72FDC38
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 23:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769816085; cv=none; b=o0A1Kspc/csepAWMHy9nHN3GCJlID9dxo1gQi4Po6UNstwEw6IWvm9pnyA3M7vq0H3LhZNsmgVkN6KHZ+m4tRyl/7fEUEOJQHwrGsO145W0dmYfl13993f6SaiY+1oSwUPdPuBEQcRMY/aAjUZrvflLtSMvsH5nW1A22vJsAnoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769816085; c=relaxed/simple;
	bh=ulECtHp4Ium+Dfvm6HTcLmWw4lrXvXShpUyDj58xUjI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tTWY8oWaEAGzu83wp8pPiPIaKa9dSdh5baoUvucuVVOFrj4T4+o51gXbAwhmp+4E4tjhlr2p0oBJlxsYZV2IuZhA1sV4M1TlXqcOeU67ExPKoSoXSsLzvNzgcoq7RcRRcuSVne+Nc3FZ3pwGhXG2sevwF10n9cJeTOnu0r2BFXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FEhnBfM0; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FEhnBfM0"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-124743cf760so2541466c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 30 Jan 2026 15:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769816083; x=1770420883; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UbNzrAvZknto1XK2xvz0+YGQlJZ46WeHUdmn08kNX5g=;
        b=FEhnBfM0BXIonEobDFlbmrE8ODcL/XKglCNBwmZB0YI4fVEBrJ4r4iSjdZf3CKkFpd
         hMDBnGkoN5XZs0sFGjwjUtVR2wNBM24wljd53QgjOsmfHQOtsJzNw37qkR/LuwXblbjK
         RCgOP/tbzBmQ6CiWVxIPUN2FTQ4my0jw6eHjsKMB/XzHqOlw7EjHWu1ZFBCVNghlow5G
         VXTs7ej+kT9l5XBrHu/gWQcEqZRfllXjGdUzLIK0BuhoGNhqDI5h+Twfm5Zxx6j1FBCn
         Yh/ehoD3Q8d9dGb499WuTjHK7qjpVGkQh1jaLV3ER9oxw71Ct8PxlX0W5uxWsfrOUYrC
         N7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769816083; x=1770420883;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbNzrAvZknto1XK2xvz0+YGQlJZ46WeHUdmn08kNX5g=;
        b=ko4htio1uN13Aq8LZl45FqFrbc/MGAWiAgRc+t5YsgVYFYnzkexIFiMurTpvFagb4M
         ZfSWkkXs5UihlipEC8xZH45VRBomwP0Q38EApreR0opqKa7IGGcK8hHq+F4Rn8MWOpS5
         7iiOHKuTeyhuJhJ/OG3aCyhBj/hihXkHLwmnByoQ5L/9+jIF1hqwv/pbH+MmF4VqZl6y
         PQ+65DsM0kW3inuvdD+a0MBIBPJbV2OngqGWmu6+2J97FnuLCeV2mnmiZjwTwbX++8Iw
         vtBh6TK8T6vnjTmJgy3layUcjN7HMUo7YTsPz3c1CHFYLkF1sF/sxDjoAcLXplFKu6ml
         BtIg==
X-Forwarded-Encrypted: i=1; AJvYcCVuWP0u3ZBPpfIctPWxHbwLVk8hqKgRsnyVcZtDErehLb8R5WIuYpCdGotl8bpQvNRGI2B46CSLjgYblUAe76/8@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk08TXV81B1UnG7lIKY6LC8bTdh3CH9kGFZR2nJITE8aEcWYir
	hPvlL+Aqx6UenI4HMJWgAUSRnF8yztQuMFAckb9RlvgW5T/eWHedUL7tMHv2ZKUTaebeT/rSngb
	R7q+lT3gNwg==
X-Received: from dycok9.prod.google.com ([2002:a05:7301:db09:b0:2b7:b47b:2f37])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:2f8f:b0:2b0:51a7:509a
 with SMTP id 5a478bee46e88-2b7c88ed884mr1694274eec.33.1769816082871; Fri, 30
 Jan 2026 15:34:42 -0800 (PST)
Date: Fri, 30 Jan 2026 15:34:36 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260130233439.647447-1-irogers@google.com>
Subject: [PATCH v10 0/3] perf capstone/llvm dlopen support
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Charlie Jenkins <charlie@rivosinc.com>, 
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>, James Clark <james.clark@linaro.org>, 
	Collin Funk <collin.funk1@gmail.com>, Dmitry Vyukov <dvyukov@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

Linking against libcapstone and libLLVM can be a significant increase
in dependencies and file size if building statically. The dependencies
are also quite cumbersome if bringing perf into a distribution. For
something like `perf record` the disassembler and addr2line
functionality of libcapstone and libLLVM won't be used. These patches
support dynamically loading these libraries using dlopen and then
calling the appropriate functions found using dlsym. Using dlopen
allows libcapstone and libLLVM to be installed separately to perf and
when that's done the performance will improve as separate commands for
objdump and addr2line won't be invoked.

The patch series adds perf_ variants of the capstone/llvm functions
that will either directly call the function or use dlopen/dlsym to
discover and then call the function.

For capstone if there is no capstone.h then the feature test will
fail, there is no capstone support and HAVE_LIBCAPSTONE_SUPPORT won't
be defined. This is necessary as the libcapstone structs and enum
constants vary across releases and perf cannot know what to use
without having the header file. If HAVE_LIBCAPSTONE_SUPPORT is defined
and the build made with LIBCAPSTONE_DLOPEN=1 then dlopen is used to
open libcapstone.so, etc. If LIBCAPSTONE_DLOPEN isn't given to the
build then the build will try to link against libcapstone (as with
before these changes).

For LLVM if the feature test succeeded then HAVE_LIBLLVM_SUPPORT is
defined and libLLVM is linked against. If the feature test fails, or
NO_LIBLLVM=1 given, then dlopen is used to open the library. Five
constants and three pointer types are declared to avoid having a
header file dependency - ie there is no case where the LLVM support
won't try to at least dlopen libLLVM.so.

The LLVM addr2line ABIs are written in C++ with no C counterpart. When
!HAVE_LIBLLVM_SUPPORT the LLVM addr2line support is compiled out
except when a new LIBLLVM_DYNAMIC build option is given. This option
builds a libperf-llvm.so that contains the LLVM addr2line
implementation and that creates the dlopen/dlsym calls to use this in
the regular code. Ideally LLVM would extend their C API to avoid this.

v10: Make the libcapstone code use capstone.h and conditionally use
     dlopen as the constants and structs libcapstone declares vary
     across releases.
v9: Rebase.
    https://lore.kernel.org/lkml/20260127062302.544809-1-irogers@google.com/
v8: Rebase down to 3 patches. Update commit and cover messages.
v7: Refactor now the first 5 patches, that largely moved code around,
    have landed. Move the dlopen code to the end of the series so that
    the first 8 patches can be picked improving capstone/LLVM support
    without adding the dlopen code. Rename the cover letter and
    disassembler cleanup patches.
v6: Refactor the libbfd along with capstone and LLVM, previous patch
    series had tried to avoid this by just removing the deprecated
    BUILD_NONDISTRO code. Remove the libtracefs removal into its own
    patch.
v5: Rebase and comment typo fix.
v4: Rebase and addition of a patch removing an unused struct variable.
v3: Add srcline addr2line fallback trying LLVM first then forking a
    process. This came up in conversation with Steinar Gunderson
    <sesse@google.com>.
    Tweak the cover letter message to try to address Andi Kleen's
    <ak@linux.intel.com> feedback that the series doesn't really
    achieve anything.
v2: Add mangling of the function names in libperf-llvm.so to avoid
    potential infinite recursion. Add BPF JIT disassembly support to
    LLVM and capstone. Add/rebase the BUILD_NONDISTRO cleanup onto the
    series from:
    https://lore.kernel.org/lkml/20250111202851.1075338-1-irogers@google.com/
    Some other minor additional clean up.

Ian Rogers (3):
  perf capstone: Support for dlopen-ing libcapstone.so
  perf llvm: Support for dlopen-ing libLLVM.so
  perf llvm: Mangle libperf-llvm.so function names

 tools/perf/Makefile.config         |  21 ++-
 tools/perf/Makefile.perf           |  24 ++-
 tools/perf/tests/make              |   4 +
 tools/perf/util/Build              |   4 +-
 tools/perf/util/capstone.c         | 176 ++++++++++++++-----
 tools/perf/util/capstone.h         |  33 ++++
 tools/perf/util/llvm-c-helpers.cpp | 120 ++++++++++++-
 tools/perf/util/llvm-c-helpers.h   |  24 ++-
 tools/perf/util/llvm.c             | 273 +++++++++++++++++++++++++----
 9 files changed, 591 insertions(+), 88 deletions(-)

-- 
2.53.0.rc1.225.gd81095ad13-goog

