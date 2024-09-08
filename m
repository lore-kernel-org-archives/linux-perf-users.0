Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9D2B9CD;
	Sun,  8 Sep 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725821241; cv=none; b=sLdkwA2rydE9tvgc5QWxdasAgCZ70WaeMK20rv6BBP5M51NDxrHCjoaCal5NfUPorDeUHWmeLI/rHbjBkQxqTa0ThgJs6KhL+pUwjL/UPW5UOuxwGtDP6YqVNuKivS/REawr8bUlNoBwXLHpf84tY4oq7yIDE/a8q+p1GXY3Sgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725821241; c=relaxed/simple;
	bh=gxfttsqh7OsEGsyHzIJRp1REN8ioJ4jHnjZwFibSk9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aSEmulJtBlnzNKOfQPulGY3Ml3IR4+fqgOKeuIeDZHLkUfMH4XbX9JzEs6vTly3kW3ZgC7CopoDQ6a6UiIx2yZgwj3i0jSzscZm9BQolTtloSXzCe/+mFt9Pbvn/d6n7IfHvDYj58HSkIAp4Ea0xk3edBTsK9T/A7LD3X97XIRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>
Cc: Sam James <sam@gentoo.org>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] tools: drop nonsensical -O6
Date: Sun,  8 Sep 2024 19:46:41 +0100
Message-ID: <4f01524fa4ea91c7146a41e26ceaf9dae4c127e4.1725821201.git.sam@gentoo.org>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

-O6 is very much not-a-thing. Really, this should've been dropped
entirely in 49b3cd306e60b9d889c775cb2ebb709f80dd8ae9 instead of just
passing it for not-Clang.

Just collapse it down to -O3, instead of "-O6 unless Clang, in which case
-O3".

GCC interprets > -O3 as -O3. It doesn't even interpret > -O3 as -Ofast,
which is a good thing, given -Ofast has specific (non-)requirements for
code built using it. So, this does nothing except look a bit daft.

Remove the silliness and also save a few lines in the Makefiles accordingly.

Signed-off-by: Sam James <sam@gentoo.org>
---
I promise I'm not completely humourless, but given it's caused
actual workarounds to be added for Clang, I don't think this is worth keeping.

Plus it sort of propagates a silly myth that -O6 does anything.

 tools/lib/api/Makefile     | 4 ----
 tools/lib/subcmd/Makefile  | 4 +---
 tools/lib/symbol/Makefile  | 4 ----
 tools/perf/Makefile.config | 6 +-----
 4 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/tools/lib/api/Makefile b/tools/lib/api/Makefile
index 044860ac1ed1c..7f6396087b467 100644
--- a/tools/lib/api/Makefile
+++ b/tools/lib/api/Makefile
@@ -31,11 +31,7 @@ CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 CFLAGS += -ggdb3 -Wall -Wextra -std=gnu99 -U_FORTIFY_SOURCE -fPIC
 
 ifeq ($(DEBUG),0)
-ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
-else
-  CFLAGS += -O6
-endif
 endif
 
 ifeq ($(DEBUG),0)
diff --git a/tools/lib/subcmd/Makefile b/tools/lib/subcmd/Makefile
index b87213263a5e0..6717b82fc5876 100644
--- a/tools/lib/subcmd/Makefile
+++ b/tools/lib/subcmd/Makefile
@@ -38,10 +38,8 @@ endif
 
 ifeq ($(DEBUG),1)
   CFLAGS += -O0
-else ifeq ($(CC_NO_CLANG), 0)
-  CFLAGS += -O3
 else
-  CFLAGS += -O6
+  CFLAGS += -O3
 endif
 
 # Treat warnings as errors unless directed not to
diff --git a/tools/lib/symbol/Makefile b/tools/lib/symbol/Makefile
index 13d43c6f92b4a..426b845edfacc 100644
--- a/tools/lib/symbol/Makefile
+++ b/tools/lib/symbol/Makefile
@@ -31,11 +31,7 @@ CFLAGS := $(EXTRA_WARNINGS) $(EXTRA_CFLAGS)
 CFLAGS += -ggdb3 -Wall -Wextra -std=gnu11 -U_FORTIFY_SOURCE -fPIC
 
 ifeq ($(DEBUG),0)
-ifeq ($(CC_NO_CLANG), 0)
   CFLAGS += -O3
-else
-  CFLAGS += -O6
-endif
 endif
 
 ifeq ($(DEBUG),0)
diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index fa679db61f622..5d6b08a896150 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -238,11 +238,7 @@ endif
 
 ifeq ($(DEBUG),0)
 CORE_CFLAGS += -DNDEBUG=1
-ifeq ($(CC_NO_CLANG), 0)
-  CORE_CFLAGS += -O3
-else
-  CORE_CFLAGS += -O6
-endif
+CORE_CFLAGS += -O3
 else
   CORE_CFLAGS += -g
   CXXFLAGS += -g
-- 
2.46.0

