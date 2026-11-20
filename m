Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795138383;
	b=lMNYz6tMJz8oUaz1jNaFIUMoCAbKJkjO4EqGWXoo8zm2igxwk+cv5Dd7P/x/WH0wCzoz
	 dMbiLSZfifMZYP+7Nqn/r+mI71SrS8pbBQFbqwa9wqql/v86enMGyY7Y4KnSwPEytkulG
	 427IBE7dAESk+13Rw74flxOyIAXFX1KXKH94lBGPhXI1oKFhVYcl4DGYQiTs++KUrrFJ7
	 KqAsJrIzrmekVBdIfcF6C6JHPwcioZw+CYaulx/0i67grPHgPryD5i9/lhs05ifJ+fYvK
	 9vqC+0cpJD6lVMyu0MyUSN60rY52BGttwOZbTiTIWZHWx5mE7P7UsrEEO4jE8T+gZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795138383;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2gpm1UxUzmoyh40qnSOyQEWaCYOdlmC3cCwN/wZvJAc=;
	b=1C+xjRNEqYGPgyNvm1KZIon5ukIaeZmRw7OlDqQD6leuRvQwLBei5p2Uhv8vhk65YwYY
	 ZLbYCF3lG47f38jjGn3daJ6XXCTu2fqQsFoHe72iQBLh5/cMOWkpC41zl3/4Tm40POfPx
	 q9W4Tl87qcab9M7+OzxzzaMlMp1iSXouWcb5ws4MGP5omERoNtaSSbT1PoZAwpn8e47T9
	 VRwyiBDgxK3SI0GEeLhwPDoqIgR9ArdNCmXnk50vANO6WvcS4/hG+3nrCk73zE0Tr5NR6
	 e8HIMDEeiGsOonjlEDYPUMZp1z/uqbPP3SVhIDGmRn3WfsLmttKi22HpmspT7lcofag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFAY6mWx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B962606A320
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Nov 2026 01:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VFAY6mWx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2981F000C6;
	Fri, 20 Nov 2026 01:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795138383;
	bh=2gpm1UxUzmoyh40qnSOyQEWaCYOdlmC3cCwN/wZvJAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VFAY6mWxfAelSNU8VDiGqdg1IEEEUZ8dTKhyAdb7qXA5XMWyuGCESSBMHpADcW+zS
	 dw//Sw0/v6liFTxsGRZz9f2befG9TXVA5tKDD9rp8T0RZIlXDEpuwnHbjIHscIy7ZX
	 2b2N4iOY3SYpTHkhg+NF1OVetzcxfMBWptArT0Vn0fDY0OZwTQ2PRkS31JVtIYhnhn
	 k6jISIwKEUICjX2kQE/SnwPyKkA0BGi8AI4MUmVTW+8TXJX9PBZ/l7ses0GziFs4G+
	 0Qeq/MCQdA/f+wZ6noz4iZrFWwT6LA/5AoOwSTgCNeDt9exTMpHMDmny7fkkkNGQjk
	 qncGA9hFUesEg==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v9 09/13] perf tests: Silence the libbfd probe in build-test
Date: Thu, 19 Nov 2026 22:32:04 -0300
Message-ID: <20261120013211.1510-10-acme@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120013211.1510-1-acme@kernel.org>
References: <20261120013211.1510-1-acme@kernel.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

build-test evaluates the libbfd probe at parse time and the compiler's
stderr isn't captured by $(shell ...), so without binutils-devel it
prints "bfd.h: No such file or directory" once per tests/make
invocation, five times per run.

Redirect the compiler's stderr; the empty result still skips the
nondistro tests as intended.

Fixes: 523471c5163659c6 ("perf build: Skip nondistro build test if libbfd is old")
Reviewed-by: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/make | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/make b/tools/perf/tests/make
index 7524de5228029e7e..e6d7ac49b5b1693d 100644
--- a/tools/perf/tests/make
+++ b/tools/perf/tests/make
@@ -128,7 +128,7 @@ make_minimal        += NO_SDT=1 NO_JVMTI=1 NO_LIBZSTD=1
 make_minimal        += NO_CAPSTONE=1
 
 # binutils 2_42 and newer have bfd_thread_init()
-new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - | grep bfd_thread_init)
+new_libbfd := $(shell echo '#include <bfd.h>' | $(CC) -E -x c - 2>/dev/null | grep bfd_thread_init)
 
 # Whether libLLVM can be built, which needs the llvm-devel/llvm-dev headers and
 # libraries of version 13 or newer, not just llvm-config. This mirrors the
-- 
2.56.1

