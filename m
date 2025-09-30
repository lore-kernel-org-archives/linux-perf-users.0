Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57CE258CD0;
	Tue, 30 Sep 2025 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251323; cv=none; b=j2911bag7/i2BSqskhJciTr9nZUij52P8HPc4t4EihpYyMfekkloCg0NFddqyI3X441ABJzoQYT0YHEuMAhuFemQnZiwUDmcs/Kl9B62pLArwYueZIfWtobxqh0vQf5R7btwcpezltDY/+o897UEqxwRFpRg6fbAyNbmi3eMXPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251323; c=relaxed/simple;
	bh=H3wg4rcmLVUVzF6Navqmshn4de5zeGYk8fBYI7vbo5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JyC/PATEBE6rmfz2Ng5FecNnqJDNRZ8GunWVmLMUNcJokwXVrl4a5XqywBwfK6K3L10HRs4UeTwsC7Ib5FKNd7qCREZoBgRdH2YMpQ/SM9jo376VchZMMxn0QWC56EH06gDx1wK13EFTWuB4++4RWiOIUb5WYdV9nmXjwKrth6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE559106F;
	Tue, 30 Sep 2025 09:55:11 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 604F63F59E;
	Tue, 30 Sep 2025 09:55:17 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Tue, 30 Sep 2025 17:54:50 +0100
Subject: [PATCH v2 2/8] perf python: split Clang options when invoking
 Popen
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250930-perf_build_android_ndk-v2-2-2ea440b7ef01@arm.com>
References: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
In-Reply-To: <20250930-perf_build_android_ndk-v2-0-2ea440b7ef01@arm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759251311; l=2000;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=H3wg4rcmLVUVzF6Navqmshn4de5zeGYk8fBYI7vbo5o=;
 b=2vHDvyqlu2enxBTGiXwfLSV7xEVnSv8i37X0B+GoSrV88y/V3SsM8vL77Bnn6rQkXvu98RMsa
 ZuVM9X6VygdD4ewiXvtmQkHJ3eqY4AYznAQKuN7R3CLv6r6g84A+UoX
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

When passing a list to subprocess.Popen, each element maps to one argv
token. Current code bundles multiple Clang flags into a single element,
something like:

  cmd = ['clang',
         '--target=x86_64-linux-gnu -fintegrated-as -Wno-cast-function-type-mismatch',
	 'test-hello.c']

So Clang only sees one long, invalid option instead of separate flags,
as a result, the script cannot capture any log via PIPE.

Fix this by using shlex.split() to separate the string so each option
becomes its own argv element. The fixed list will be:

  cmd = ['clang',
         '--target=x86_64-linux-gnu',
	 '-fintegrated-as',
	 '-Wno-cast-function-type-mismatch',
	 'test-hello.c']

Fixes: 09e6f9f98370 ("perf python: Fix splitting CC into compiler and options")
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/util/setup.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/setup.py b/tools/perf/util/setup.py
index dd289d15acfd62ff058bbaed7e565bb958e3a3c8..9cae2c472f4ad4d9579e8528b8bb0152df6fe20e 100644
--- a/tools/perf/util/setup.py
+++ b/tools/perf/util/setup.py
@@ -1,6 +1,7 @@
 from os import getenv, path
 from subprocess import Popen, PIPE
 from re import sub
+import shlex
 
 cc = getenv("CC")
 assert cc, "Environment variable CC not set"
@@ -22,7 +23,9 @@ assert srctree, "Environment variable srctree, for the Linux sources, not set"
 src_feature_tests  = f'{srctree}/tools/build/feature'
 
 def clang_has_option(option):
-    cc_output = Popen([cc, cc_options + option, path.join(src_feature_tests, "test-hello.c") ], stderr=PIPE).stderr.readlines()
+    cmd = shlex.split(f"{cc} {cc_options} {option}")
+    cmd.append(path.join(src_feature_tests, "test-hello.c"))
+    cc_output = Popen(cmd, stderr=PIPE).stderr.readlines()
     return [o for o in cc_output if ((b"unknown argument" in o) or (b"is not supported" in o) or (b"unknown warning option" in o))] == [ ]
 
 if cc_is_clang:

-- 
2.34.1

