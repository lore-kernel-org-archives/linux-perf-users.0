Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9062594A0;
	Wed, 11 Dec 2024 22:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733957120; cv=none; b=VDERJI9w/kAOW/W09DB4fIS0PdpSZgEB4+KKnOSul0nvcFe3M36sFqsaTE/Qt2yXgHKfrEmMLdsFWvn4+OWBHZXMlOEvixKZoWgEFc2h27ZieqyfyZcG08i/3w/5Wh/cCesAxuqjZwiX7dSjVsRdk8e+NcGkeYImC0Ehqa5Q0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733957120; c=relaxed/simple;
	bh=ITtPRuDy1gsJnikZggNzc06nAqzDieg+tv9iyvHLaQM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5m0hXjfoiKgq79t4eD24OsvDStz+wywz4iW6DGZg9gCVeUQsfx4Yn2SXk3a8xqrgpZzGCfEzltyZbVkjG1pTl8ZcOOKOuTKFSWxQE7I2H/n6EWleWhBepPsH06gTaZI64GzmY1eyZbh/W/dbcdfnoCbe5w1B/Lo8g7rM3YkMQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fuk/Bj5C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fuk/Bj5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F8C4CED3;
	Wed, 11 Dec 2024 22:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733957120;
	bh=ITtPRuDy1gsJnikZggNzc06nAqzDieg+tv9iyvHLaQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fuk/Bj5CrF9WRI9N8vBKL1XBGo3MqAeQTDEe0ohVe1tJv/YseCRptsgpAkFief+BO
	 Fpwja1V4L/BDAZ//bLXlvqcVa6ObKvAZin6zND0Ih6H1daCLVDwvzARISCB2CUH3RZ
	 NiDv/KX6QlZB7B0Bvvx4OW7gkMDFibSevA+GAiVIxrXn++5JirQyHP7l30jnOX10Jm
	 J9bXy5gfK4BJxnyh6tWZRHVqfn5BU7J8gCUhSFAbtPdZd+o6j2G+81lm3qhpUe2u1X
	 QSiEkk66wPKISIiT3kIG8VScucfJY4uvRUYm9WB47RZepfy8apEKwZbDK5asZDfcvf
	 21Wzaneck8ibw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	James Clark <james.clark@linaro.org>
Subject: [PATCH 1/2] tools build feature: Add some comments to explain the FEATURE_TESTS logic
Date: Wed, 11 Dec 2024 19:45:08 -0300
Message-ID: <20241211224509.797827-2-acme@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241211224509.797827-1-acme@kernel.org>
References: <20241211224509.797827-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The tools/build/feature/test-all.c works in conjunction with the
tools/build/Makefile.feature FEATURE_TESTS_BASIC and FEATURE_TESTS_EXTRA
contents, so that if test-all.c manages to be built, we go on and
iterate all entries in FEATURE_TESTS_BASIC + FEATURE_TESTS_EXTRA setting
then to 1.

To test this:

  $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump
  $ cat /tmp/b/feature/test-all.make.output
  $ ldd /tmp/b/feature/test-all.bin
	linux-vdso.so.1 (0x00007f2a47a67000)
	libdw.so.1 => /lib64/libdw.so.1 (0x00007f2a477cf000)
	libpython3.12.so.1.0 => /lib64/libpython3.12.so.1.0 (0x00007f2a471fe000)
	libm.so.6 => /lib64/libm.so.6 (0x00007f2a4711a000)
	libtraceevent.so.1 => /lib64/libtraceevent.so.1 (0x00007f2a470f2000)
	libtracefs.so.1 => /lib64/libtracefs.so.1 (0x00007f2a470cb000)
	libcrypto.so.3 => /lib64/libcrypto.so.3 (0x00007f2a46c1b000)
	libz.so.1 => /lib64/libz.so.1 (0x00007f2a46bf8000)
	libbabeltrace-ctf.so.1 => /lib64/libbabeltrace-ctf.so.1 (0x00007f2a46bad000)
	libcapstone.so.5 => /lib64/libcapstone.so.5 (0x00007f2a464b8000)
	libopencsd_c_api.so.1 => /lib64/libopencsd_c_api.so.1 (0x00007f2a464a8000)
	libopencsd.so.1 => /lib64/libopencsd.so.1 (0x00007f2a46422000)
	libelf.so.1 => /lib64/libelf.so.1 (0x00007f2a46406000)
	libnuma.so.1 => /lib64/libnuma.so.1 (0x00007f2a463f6000)
	libslang.so.2 => /lib64/libslang.so.2 (0x00007f2a46113000)
	libperl.so.5.38 => /lib64/libperl.so.5.38 (0x00007f2a45d74000)
	libc.so.6 => /lib64/libc.so.6 (0x00007f2a45b83000)
	liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f2a45b50000)
	libzstd.so.1 => /lib64/libzstd.so.1 (0x00007f2a45a91000)
	libbz2.so.1 => /lib64/libbz2.so.1 (0x00007f2a45a7b000)
	/lib64/ld-linux-x86-64.so.2 (0x00007f2a47a69000)
	libbabeltrace.so.1 => /lib64/libbabeltrace.so.1 (0x00007f2a45a6b000)
	libpopt.so.0 => /lib64/libpopt.so.0 (0x00007f2a45a5b000)
	libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f2a45a51000)
	libgmodule-2.0.so.0 => /lib64/libgmodule-2.0.so.0 (0x00007f2a45a4a000)
	libglib-2.0.so.0 => /lib64/libglib-2.0.so.0 (0x00007f2a458fa000)
	libstdc++.so.6 => /lib64/libstdc++.so.6 (0x00007f2a45696000)
	libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00007f2a45668000)
	libcrypt.so.2 => /lib64/libcrypt.so.2 (0x00007f2a45630000)
	libpcre2-8.so.0 => /lib64/libpcre2-8.so.0 (0x00007f2a45590000)
  $ head /tmp/b/FEATURE-DUMP
  feature-backtrace=1
  feature-libdw=1
  feature-eventfd=1
  feature-fortify-source=1
  feature-get_current_dir_name=1
  feature-gettid=1
  feature-glibc=1
  feature-libbfd=1
  feature-libbfd-buildid=1
  feature-libcap=1
  $

There are inconsistencies that are being audited, as can be seen above
with the libcap case, that is not linked with test-all.bin nor is
present in test-all.c, so shouldn't be set as present. Further patches
are going to address those inconsistencies, but lets document this a bit
more to reduce the chances of this happening again.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/build/Makefile.feature | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 80563154318601ac..52600e4d33af8712 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -28,6 +28,41 @@ endef
 #   the rule that uses them - an example for that is the 'bionic'
 #   feature check. ]
 #
+# These + the ones in FEATURE_TESTS_EXTRA are included in
+# tools/build/feature/test-all.c and we try to build it all together
+# then setting all those features to '1' meaning they are all enabled.
+#
+# There are things like fortify-source that will be set to 1 because test-all
+# is built with the flags needed to test if its enabled, resulting in
+#
+#   $ rm -rf /tmp/b ; mkdir /tmp/b ; make -C tools/perf O=/tmp/b feature-dump
+#   $ grep fortify-source /tmp/b/FEATURE-DUMP
+#   feature-fortify-source=1
+#   $
+#
+#   All the others should have lines in tools/build/feature/test-all.c like:
+#
+#    #define main main_test_disassembler_init_styled
+#    # include "test-disassembler-init-styled.c"
+#    #undef main
+#
+#    #define main main_test_libzstd
+#    # include "test-libzstd.c"
+#    #undef main
+#
+#    int main(int argc, char *argv[])
+#    {
+#      main_test_disassembler_four_args();
+#      main_test_libzstd();
+#      return 0;
+#    }
+#
+#    If the sample above works, then we end up with these lines in the FEATURE-DUMP
+#    file:
+#
+#    feature-disassembler-four-args=1
+#    feature-libzstd=1
+#
 FEATURE_TESTS_BASIC :=                  \
         backtrace                       \
         libdw                           \
-- 
2.47.0

