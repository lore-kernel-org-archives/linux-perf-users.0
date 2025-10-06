Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4042DAFBA;
	Mon,  6 Oct 2025 16:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759767714; cv=none; b=UEWF1jszal5qahXYkkOVfPjUxHyQd87TfWFieBwFWkvEv4gBcbtKBYGBqYWqfmYrsmzRYpi3PUmaAra29zD8/Bbj/ssPgqHyr2YydeKIoFxKhLNEXZKwkIBJwdhdeMojSkkrlEKOdgqTSGN2x2Lm5CCy6g0vO5o0qoPgh5H0nmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759767714; c=relaxed/simple;
	bh=GGldtNXc0oaGS+19NwZcOJHDnYTkrkTDgLmVwE6QIUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cZWB8sd/WO80mDvvrci09Pu98pGJyCXnheBEvUsKCXGqTAAZYudEqLRNmAGXpplANwOpMbK0lGJmP7NTFuHwoYGL32pPap7AAg4M4fNpE9w6WwCQpGvGAPmVwZHFWEUfmdUbzYHUSFWAEbqGFLlUmzJ5Og3rjCOVEQZ3FFp8eaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBEB51516;
	Mon,  6 Oct 2025 09:21:42 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 353C43F738;
	Mon,  6 Oct 2025 09:21:48 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Mon, 06 Oct 2025 17:21:26 +0100
Subject: [PATCH v3 4/9] perf build: Disable thread safety analysis for perl
 header
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251006-perf_build_android_ndk-v3-4-4305590795b2@arm.com>
References: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
In-Reply-To: <20251006-perf_build_android_ndk-v3-0-4305590795b2@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>, James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, linux-riscv@lists.infradead.org, 
 Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759767696; l=3588;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=GGldtNXc0oaGS+19NwZcOJHDnYTkrkTDgLmVwE6QIUo=;
 b=BLRY4IQuw/VxHRszeUvciM005PXecD/Bpj2Ky9vCsY5uv8Ib9vT/VmGHqkK1GNR9GAJBP4QN8
 xANHFi217g6DS5VGu8aRy97l0WLYgW3InDhYVvxol2e1vlfLRqysy/y
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When build with perl5, it reports error:

    In file included from /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:7933:
    /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/inline.h:298:5: error:
          mutex 'PL_env_mutex.lock' is not held on every path through
          here [-Werror,-Wthread-safety-analysis]
      298 |     ENV_UNLOCK;
          |     ^
    /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:7091:31: note:
          expanded from macro 'ENV_UNLOCK'
     7091 | #  define ENV_UNLOCK          PERL_REENTRANT_UNLOCK("env"...
          |                               ^
    /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:6465:7: note:
          expanded from macro 'PERL_REENTRANT_UNLOCK'
     6465 |     } STMT_END
          |       ^
    /usr/lib/perl5/5.42.0/x86_64-linux-thread-multi/CORE/perl.h:865:28: note:
          expanded from macro 'STMT_END'
      865 | #   define STMT_END     while (0)
          |                                ^

The error is caused by perl header but not perf code, disable thread
safety analysis if including the header.

Though GCC does not support the thread safety analysis option, this
negative warning flag is silently ignored by it.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/scripts/perl/Perf-Trace-Util/Build | 2 +-
 tools/perf/util/scripting-engines/Build       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/perl/Perf-Trace-Util/Build b/tools/perf/scripts/perl/Perf-Trace-Util/Build
index 9b0e5a8b5070f1a1640518fae75557f824ef21ee..01a1a0ed51aefd721b4bc7eba728c29a8ffcd551 100644
--- a/tools/perf/scripts/perl/Perf-Trace-Util/Build
+++ b/tools/perf/scripts/perl/Perf-Trace-Util/Build
@@ -2,7 +2,7 @@ perf-util-y += Context.o
 
 CFLAGS_Context.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
 CFLAGS_Context.o += -Wno-unused-parameter -Wno-nested-externs -Wno-undef
-CFLAGS_Context.o += -Wno-switch-default -Wno-shadow
+CFLAGS_Context.o += -Wno-switch-default -Wno-shadow -Wno-thread-safety-analysis
 
 ifeq ($(CC_NO_CLANG), 1)
   CFLAGS_Context.o += -Wno-unused-command-line-argument
diff --git a/tools/perf/util/scripting-engines/Build b/tools/perf/util/scripting-engines/Build
index 2282fe3772f3bdc35056cb5e66efb3462dc1c2e3..24f087b0cd11b3e06a338c394dc2c650bc2c60b1 100644
--- a/tools/perf/util/scripting-engines/Build
+++ b/tools/perf/util/scripting-engines/Build
@@ -3,7 +3,7 @@ ifeq ($(CONFIG_LIBTRACEEVENT),y)
 endif
 perf-util-$(CONFIG_LIBPYTHON) += trace-event-python.o
 
-CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum
+CFLAGS_trace-event-perl.o += $(PERL_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-nested-externs -Wno-undef -Wno-switch-default -Wno-bad-function-cast -Wno-declaration-after-statement -Wno-switch-enum -Wno-thread-safety-analysis
 
 # -Wno-declaration-after-statement: The python headers have mixed code with declarations (decls after asserts, for instance)
 CFLAGS_trace-event-python.o += $(PYTHON_EMBED_CCOPTS) -Wno-redundant-decls -Wno-strict-prototypes -Wno-unused-parameter -Wno-shadow -Wno-deprecated-declarations -Wno-switch-enum -Wno-declaration-after-statement

-- 
2.34.1

