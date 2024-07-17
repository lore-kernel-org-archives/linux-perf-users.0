Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C1A04D8B6;
	Wed, 17 Jul 2024 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721204592; cv=none; b=nw5QROMW77VaZiNzXkVXtRhSofZ/8+fwEdYdbrXxK+pYGIKy719+veSeGgHd0Z1m4yOYGfAztdoCd1pJJQkS0KIRzqbDTlD8jQGkx7saxxK4NFCMYw13mFzOtpesocp08w+8lBzE5+NAjN0JWv/7DlRPH8WW766yG/OEhOnQE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721204592; c=relaxed/simple;
	bh=7w8d4hF30cPl3B1WLOUMU9Qsqcr231BJGYZiaEO85Mk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUm2tQcBmCNgs88NafkcofdozyUo/+cFreVwvQbAcNjZC1g9G6bSt9Fdtiw+nRUfNz4U+3q0NmLlNMpxYCcVGKviowJB/ptYVXi7QfnIaEf4UEzVWAdqMVkGF7iYUtNLOKdZczrMzAvY+wfdXQ9OT8g7lfZfS9fASE7Wl3nZPHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 97576106F;
	Wed, 17 Jul 2024 01:23:35 -0700 (PDT)
Received: from e132581.cambridge.arm.com (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4F42C3F762;
	Wed, 17 Jul 2024 01:23:08 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Leo Yan <leo.yan@arm.com>,
	Thomas Richter <tmricht@linux.ibm.com>,
	James Clark <james.clark@linaro.org>,
	amadio@gentoo.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: James Clark <james.clark@arm.com>
Subject: [PATCH v5 6/6] perf docs: Document cross compilation
Date: Wed, 17 Jul 2024 09:22:11 +0100
Message-Id: <20240717082211.524826-7-leo.yan@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240717082211.524826-1-leo.yan@arm.com>
References: <20240717082211.524826-1-leo.yan@arm.com>
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
 tools/perf/Documentation/Build.txt | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/perf/Documentation/Build.txt b/tools/perf/Documentation/Build.txt
index 3766886c4bca..83dc87c662b6 100644
--- a/tools/perf/Documentation/Build.txt
+++ b/tools/perf/Documentation/Build.txt
@@ -71,3 +71,31 @@ supported by GCC. UBSan detects undefined behaviors of programs at runtime.
   $ UBSAN_OPTIONS=print_stacktrace=1 ./perf record -a
 
 If UBSan detects any problem at runtime, it outputs a “runtime error:” message.
+
+4) Cross compilation
+====================
+As Multiarch is commonly supported in Linux distributions, we can install
+libraries for multiple architectures on the same system and then cross-compile
+Linux perf. For example, Aarch64 libraries and toolchains can be installed on
+an x86_64 machine, allowing us to compile perf for an Aarch64 target.
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

