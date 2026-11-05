Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863039;
	b=frl9P6PcvFgHY2C2ZNmf/W8FPoz9E/SWV0iy/+xO2LAd++Eic6svkZbjN2YvJobEjCGo
	 7AZhFjD31nqPbnhyP/C4k1JuBkZHUbtBhZK58rv1u7wtxhpK0XGRc5CuhqJ3afqH3mYGU
	 7UCT/YeGlUW90LA+q+2CAeGkWOgHPtiwqVr97k5/6YWLMaeXSdrsBxnVa6q835gsdkbqF
	 oeRTOPBTtSZn5CzHhIwhFG0nIYoiBpxK8Oq3mZl349lyOQjLGc/98TtGU8Af7hvmH0rs7
	 5o++Qx07x7lUmQrTSe1FNbc4XWxhuSVKRUB5Ly4FgnAJbTDSozN9V/DyaA1TdEgPO5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863039;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=avddGhkW23kzNtokkMPF81ogBtCrM46V69m4Fzmqx5c=;
	b=aRwthFUfhrWf6nJVUoQwQ3YxVt9pdqdCDHh+tjAKiyOAsulWiRNrWTJqRAes2e7EyU2Z
	 oPxg0Y5Pt0pUpbbTBepXdj6rlUuhcKrqVfxh+yj57AhoDgJaE1SnJfe5V7p6v8y8xOSSy
	 wELtxiJDLjqLVkTROwPtEOwJZLgZdny1V4rd5zUOseJtWnnH41Z2t3OORKXDfwg6waz2N
	 ncrHC+nJxGL/VWs9fl1cg8Pk+WrQynkC+83vpmbqaGFV49ktNYuFpRdDA1y5b1j4Nl9ZC
	 Jdy8NeTLGoealiqvXob3XB1LmvtAe/1dVKpW8L7ktkDaVt0V3bw5KHJsEP8B9SGb1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCzYtxyH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB6B606A31B;
	Thu,  5 Nov 2026 07:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KCzYtxyH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517191F000C1;
	Thu,  5 Nov 2026 07:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793863038;
	bh=avddGhkW23kzNtokkMPF81ogBtCrM46V69m4Fzmqx5c=;
	h=From:To:Cc:Subject:Date;
	b=KCzYtxyH8rZiM8L1fPJx78xGVRsd4tq3adheQe9eyUZUJSfQigJuHOdy1my+vCk7t
	 DqgIedQuVucz0/OTVquSTPatAAFoUHCadzDMKRShmlfJIs2s0KoyrqM0bdCnVde1Qr
	 cw7Wm1THSO1NnGsGqPBCwipmvsT6pNEOmTpeq5Cb9VEcd7o7oVFJSmSGr/jN2SMwoF
	 J1ApHsbwbmH4+5SSaFg5pyIfbmAHxgJdrei6JLSmeNvMB5FkRBiS6sWIsqvP2aME0P
	 Z0Auf65HMxc3AULVvul+2CwpF2xuVp9aSTovWaFA2n6NJ6BLyDlarVZn0mekR3aDdu
	 qH0fsFDNQaXxQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Jakub Brnak <jbrnak@redhat.com>,
	Michael Petlan <mpetlan@redhat.com>
Subject: [PATCH] perf test: Fix perf probe testsuite
Date: Wed,  4 Nov 2026 23:17:11 -0800
Message-ID: <20261105071711.31086-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The perf probe test suite fails on my machine.  It seems it's because
the kernel debug info is not available.  Actually NO_DEBUGINFO is to
check the condition and skip affected tests.

But it didn't work well as the skip_if_no_debuginfo function misses a
new error string for v7.0+ kernels.  Internally it uses the
add_probe_vfs_getname() to check if perf probe handles debuginfo and
check the error string.  But it didn't add the new error string.

  "Could not find probeable line"

With that added, it now passes like below:

  $ sudo perf test -vv 189
  Not taking turns using the perf mlock budget: nothing can exhaust it
  189: perftool-testsuite_probe:
  ---- start ----
  test child forked, pid 26135
  Probing warn_thunk_thunk
  -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function warn_thunk_thunk
  -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
  ## [ PASS ] ## perf_probe :: test_adding_blacklisted SUMMARY
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission ::
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: -a
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: --add
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf list
  -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due to missing debuginfo :: testcase skipped
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (should NOT be listed)
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: first probe adding
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (without force)
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (with force)
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
  Regexp not found: "probe:vfs_mknod"
  Regexp not found: "probe:vfs_create"
  Regexp not found: "probe:vfs_rmdir"
  Regexp not found: "probe:vfs_link"
  Regexp not found: "probe:vfs_write"
  -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due to missing debuginfo :: testcase skipped
  Regexp not found: "somenonexistingrandomstuffwhichisalsoprettylongorevenlongertoexceed64"
  Regexp not found: "in this function|at this address"
  -- [ SKIP ] -- perf_probe :: test_adding_kernel :: 1 1 Skipped due to missing debuginfo :: testcase skipped
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: add
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: record
  -- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument probing :: script
  ## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
  -- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
  -- [ PASS ] -- perf_probe :: test_basic :: usage message
  -- [ PASS ] -- perf_probe :: test_basic :: quiet switch
  ## [ PASS ] ## perf_probe :: test_basic SUMMARY
  -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -a
  -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -d
  -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -L
  -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -V
  -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -F
  -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -l
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -d xxx
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -L foo
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -V foo
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -l
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -F
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -L foo
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -V foo
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -l
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -F
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -l
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -F
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -l
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -F
  -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -l -F
  ## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:10
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:0-10
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:2+10
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c:1
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1+1
  -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1-10
  -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:foo
  -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1-foo
  -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1+foo
  -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func;lazy\*pattern
  ## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
  ---- end(0) ----
  189: perftool-testsuite_probe                                                          : Ok

Fixes: 92b664dcefab ("perf test probe_vfs_getname: Skip if no suitable line detected")
Cc: Jakub Brnak <jbrnak@redhat.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/lib/probe_vfs_getname.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
index 57a59ae7d4ae3d71..c091cd208beec056 100644
--- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
+++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
@@ -64,7 +64,7 @@ add_probe_vfs_getname() {
 }
 
 skip_if_no_debuginfo() {
-	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information)" && return 2
+	add_probe_vfs_getname -v 2>&1 | grep -E -q "^(Failed to find the path for the kernel|Debuginfo-analysis is not supported)|(file has no debug information|Could not find probeable line)" && return 2
 	return 1
 }
 
-- 
2.56.0

