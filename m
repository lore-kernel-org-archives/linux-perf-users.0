Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7726F7C6D4;
	Mon, 10 Jun 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718013321; cv=none; b=h69W+kTlrB10/EYEKjafGbA0vqN69+GfL7Jm9Mo7zKK5K5s+qcPUaTy22riW0ohf81/jiV2guwSD1M1ouM8IbuyU+DFmkt6QV15/B1onvrhzBH1UDpe6eXkmtAPtZOlbR6j3/EmqM3wq/O/ObJaITwC3KqKJXQglT+h5Pp1WHQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718013321; c=relaxed/simple;
	bh=THN5rLNVvIjNeAoyxyQQ+pJ8hTn9svBd8fM+nE5JKas=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O+/TEcjmBV7aWa5rFVSSfc3kz33NybYt0apA2j+CVNrq0wrZxSl4tS6K+mfgbn8CXdcG5dUPATtiA1/rDcz163MTAvCbXCy6MjZisoOiqPQVJeDWmJPoysqxr/v+vEuAlo0+hZ4ZdDT+gdUX9x59sixYBT48uUeoxv9knle22U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650771688;
	Mon, 10 Jun 2024 02:55:44 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 81DBB3F73B;
	Mon, 10 Jun 2024 02:55:17 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Nick Terrell <terrelln@fb.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	Quentin Monnet <qmo@kernel.org>,
	Changbin Du <changbin.du@huawei.com>,
	Fangrui Song <maskray@google.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Guilherme Amadio <amadio@gentoo.org>
Cc: Leo Yan <leo.yan@arm.com>
Subject: [PATCH v2 6/6] perf docs: Document cross compilation
Date: Mon, 10 Jun 2024 10:54:33 +0100
Message-Id: <20240610095433.336295-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610095433.336295-1-leo.yan@arm.com>
References: <20240610095433.336295-1-leo.yan@arm.com>
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

