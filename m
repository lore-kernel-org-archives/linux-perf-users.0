Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECC23E32B;
	Tue, 29 Apr 2025 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941992; cv=none; b=rMopbVuBClquvAjEZlrHp1E+3iUPGFT7g0Vg8nJQTDGqsaYbZVCruOF8UJCH/vO+NZSkP/N2zzGdQ76YIE40GyPz5LiCrZGrkLyrP/7Pbn3Ec79MduDEu+AVMP4UmyGRIgMz3+wBCsgnQzrjpGasoEZmj2+o72HPrVpNFNkxZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941992; c=relaxed/simple;
	bh=fhy9os8BTMHcWIRCqBCEWqXDLNgitiApEn7fpa3p0CE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=diA6HERNGdtTmxcX6VkS8E8ERf3oaQ2a6wZb691nMpyRqhq6Ht9tqxmuzJFjusfnrzqCSeVoi6lGi5Bgy50EGUhYhujbBKgeMkEo0Up787VcwnL9lDslUPuFavyMVtaKhlsdpaNrsARo5mTCiYOFG1AFhmmsghviXCUUU112pnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRA3Fy7j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRA3Fy7j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B67C4CEE9;
	Tue, 29 Apr 2025 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941992;
	bh=fhy9os8BTMHcWIRCqBCEWqXDLNgitiApEn7fpa3p0CE=;
	h=Date:From:To:Cc:Subject:From;
	b=CRA3Fy7jlM07QG/CguefqaxNEhhC4Fd5q1UGoUQFGZFXG0V2P6oDqrsHgZvqre1cX
	 JJPCv65L7fnj6n1qfAHLoXNQe+tGDWckhZjPleUQl5CT/+7n7xRzRFvXVBQ/qEFK+S
	 2vPz3wweO5e4Zy2NsaWl2C+6H+Lq+EKL7EQXKX+EShXOXwQdZa0O/Y0kH2G/j+p1bQ
	 L7qgVVG3e/g2vVrPHLZ0Vgv8cYTqSvVqGJdyqDH76DcTwBjLIM4gV7RCrY5+XNqopr
	 IyMyob7qbc2xxzLbM4OuhOY2bw3lsw9X1SKZBlzYgKYnaSWnZYPoD8/x4C16SSIlCV
	 D6gRDRp6yivSg==
Date: Tue, 29 Apr 2025 12:53:08 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1 perf-tools-next] perf symbols: Handle 'u' symbols in
 /proc/kallsyms
Message-ID: <aBD15IseHjrB77Uy@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I started seeing this in recent Fedora 42 kernels:

  # uname -a
  Linux number 6.14.3-300.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Apr 20 16:08:39 UTC 2025 x86_64 GNU/Linux
  #

  # perf test vmlinux
    1: vmlinux symtab matches kallsyms                                 : FAILED!
  #

Where we have Rust enabled:

  # grep CONFIG_RUST /boot/config-6.14.3-300.fc42.x86_64
  CONFIG_RUSTC_VERSION=108600
  CONFIG_RUST_IS_AVAILABLE=y
  CONFIG_RUSTC_LLVM_VERSION=200101
  CONFIG_RUSTC_HAS_COERCE_POINTEE=y
  CONFIG_RUST=y
  CONFIG_RUSTC_VERSION_TEXT="rustc 1.86.0 (05f9846f8 2025-03-31) (Fedora 1.86.0-1.fc42)"
  CONFIG_RUST_FW_LOADER_ABSTRACTIONS=y
  CONFIG_RUST_PHYLIB_ABSTRACTIONS=y
  # CONFIG_RUST_DEBUG_ASSERTIONS is not set
  CONFIG_RUST_OVERFLOW_CHECKS=y
  # CONFIG_RUST_BUILD_ASSERT_ALLOW is not set
  #

Looking at the reason for the failure:

  # perf test -v vmlinux |& grep ^ERR
  ERR : 0xffffffff99efc7d0: __pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_ not on kallsyms
  ERR : 0xffffffff99efc7e0: _RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_ not on kallsyms
  #

But:

  # grep -w u /proc/kallsyms
  ffffffff99efc7d0 u __pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
  ffffffff99efc7e0 u _RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
  #

The test checks that "vmlinux symtab matches kallsyms", so it finds those two
symbols in vmlinux:

  # pahole --running_kernel_vmlinux
  /usr/lib/debug/lib/modules/6.14.3-300.fc42.x86_64/vmlinux
  #

  # readelf -sW /usr/lib/debug/lib/modules/6.14.3-300.fc42.x86_64/vmlinux | grep -Ew '(__pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_|_RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_)'
 81844: ffffffff81efc7e0   524 FUNC    LOCAL  DEFAULT    1 _RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
144259: ffffffff81efc7d0    16 FUNC    LOCAL  DEFAULT    1 __pfx__RNCINvNtNtNtCsf5tcb0XGUW4_4core4iter8adapters3map12map_try_foldjNtCsagR6JbSOIa9_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
  #

It is there.

So lets consider 'u' symbols in /proc/kallsyms when loading it to cover this case.

With this patch 'perf test 1' is happy again:

  # perf test vmlinux
    1: vmlinux symtab matches kallsyms                                 : Ok
  #

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>
Cc: James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/symbol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 11540219481ba826..8b3975752553ff37 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -101,7 +101,7 @@ static enum dso_binary_type binary_type_symtab[] = {
 static bool symbol_type__filter(char symbol_type)
 {
 	symbol_type = toupper(symbol_type);
-	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B';
+	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B' || symbol_type == 'U';
 }
 
 static int prefix_underscores_count(const char *str)
-- 
2.49.0

