Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A1A144D1D;
	Sat,  6 Jul 2024 18:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720290588; cv=none; b=IEOV7CHbux3191X8aAw6t7X1DqfsOP3HiM2rE5PbWyXwid0UrOKZA9txRKLRZlQVxLtFIQCKPXGkGBQicxJZu8gkcB3GsFJIRn7WXdYu7t+yR7kbTiRd5QwE3ZOzPUDnOAnj6x8EmW+uJOaAkmEnyD5gSm1iHhPGEuWsCRgNvdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720290588; c=relaxed/simple;
	bh=THN5rLNVvIjNeAoyxyQQ+pJ8hTn9svBd8fM+nE5JKas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s00y+LYEaau/Fau3v+x+/SlZe2Bu+pdhufhxQjMYPfrKAeozryKUkQIG5iMtrRHeUyleCLVZMU4HtqGLn2ININMBk42Z+yUYPfap8Cc3V0oh8kHwlALnIJ4UgxIdPM6n8wHInNU6/AcCwNy832JqbZIVbnalya0JPXmI51uep7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1EFDA7;
	Sat,  6 Jul 2024 11:30:11 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EC773F73B;
	Sat,  6 Jul 2024 11:29:43 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Changbin Du <changbin.du@huawei.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: Leo Yan <leo.yan@arm.com>,
	James Clark <james.clark@arm.com>
Subject: [PATCH v3 6/7] perf docs: Document cross compilation
Date: Sat,  6 Jul 2024 19:29:11 +0100
Message-Id: <20240706182912.222780-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240706182912.222780-1-leo.yan@arm.com>
References: <20240706182912.222780-1-leo.yan@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Records the commands for cross compilation with two methods.

The first method relies on Multiarch. The second approach is to explicitly
specify the PKG_CONFIG variables, which is widely used in build system
(like Buildroot, Yocto, etc).

Co-developed-by: James Clark <james.clark@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/Documentation/Build.txt | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index 3766886c4bca..2237ceee74ba 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -71,3 +71,40 @@ supported by GCC. UBSan detects undefined behaviors of programs at runtime.
   $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
 
 If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
+
+4) Cross compilation
+====================
+The perf tool can be cross compiled in below methods.
+
+As Multiarch is commonly supported in Linux distributions, we can install
+libraries for multiple architectures on the same system and then cross-compile
+Linux perf. For example, Aarch64 libraries and toolchains can be installed on
+an x86_64 machine, allowing us to compile perf for an Aarch64 target.
+
+Below is the command for building perf with dynamic linking:
+As Multiarch is commonly supported in Linux distros, therefore, we can
+install multiple architectures libs in the same system and then cross compile
+the Linux perf. For example, the Aarch64 libraries and toolchain can be
+installed on the x86_64 machine, based on it we can compile the perf for
+Aarch64 target.
+
+Below is the command for building the perf with dynamic linking.
+
+  $ cd /path/to/Linux
+  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
+
+For static linking, the option `LDFLAGS="-static"` is required.
+
+  $ make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
+    LDFLAGS="-static" -C tools/perf
+
+In the embedded system world, a use case is to explicitly specify the package
+configuration paths for cross building:
+
+  $ PKG_CONFIG_SYSROOT_DIR="/path/to/cross/build/sysroot" \
+    PKG_CONFIG_LIBDIR="/usr/lib/:/usr/local/lib" \
+    make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -C tools/perf
+
+In this case, the variable PKG_CONFIG_SYSROOT_DIR can be used alongside the
+variable PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH to prepend the sysroot path to
+the library paths for cross compilation.
-- 
2.34.1

