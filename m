Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471278;
	b=nSydXckiuCXEQwB8Q/sUyqXeGBakc/gwRD2ui5slPF1x6iE1uNxPRW1+xIoFXTjZWi28
	 k2JBgiS+5913WLHVYO5KCP+x9V/EUgT6GF/I/qp8ZVxaLL5MjE6RGmj81ezcRICKbG0iG
	 veHXnLJsmwwp7PCNLUBR4o2Cq3ITRCr4kl6tZHjPcdfNVgiGWXQP2cUVT1w5tOXiB1kwr
	 X9i1tRMUhIWg/HcYm7KHzumk0P/NgWD1GjJh/lRR2SrDYDZ54gWLE0Nx4QygrtZQw3Pd8
	 MpoXtumF60qxS/wjWVUnsCccW7bwtDWLfcOBIPmQLNs+t3iIc2xw2CJc5ddkf1GrGQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471278;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r9rkywW6iZzLXO5O3QcBEmkBRS6pLSLATvMPp7gmyB8=;
	b=OpczSqb7m1z57i6EKE2n7Hd0LN+Nxcyj1hqyhb6GcC80IfmECSKdLC5AhDgpPibqOe8X
	 85dVYKgG/R3ybKJn5XppV7k8nxVIWvbzXUW/ZLz2zxqIzRN57TtIBdhhLEdqQxr5NBs+6
	 NnoIz5WvrHV09utjzuNwSw4YZQioYHpuGkuwecg30j8SYOuYuTHzAuT4poKWVECtFSsf2
	 /b39i+VZe5oEX/56rXcfbOyKj55TnI/FcEWSCMyrqWZRo1dh8ckcoii/FdIC7G+pKvA7D
	 9xhqrkmwy6gnHnaE+LmSEN2kBfaHUxmzDzOmvOfx6Dj7x3Bslo4qlTFUGayZiJA7CuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1chD9g+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05052606A326;
	Mon, 23 Nov 2026 22:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1chD9g+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09A01F000C4;
	Mon, 23 Nov 2026 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795471277;
	bh=r9rkywW6iZzLXO5O3QcBEmkBRS6pLSLATvMPp7gmyB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1chD9g+O95J7V44dZvWUIs5N8lAx1MpT0wRTwkJ1BITvRtQ706miglZO4GexP2l3
	 nnIDsL/7dNiaLzWp+CxkKRD4rycIq0Pl/7+xj4gp1s8QBaY2HHueMVhejfAZEpaLCa
	 5PBJd2KtPdFXhCofaQw8Ct34Ln1QpbUMsKjIn6m3yYac4pBMr9WM0HxwVUMuPysHiG
	 FhrfIFYc37dP0FMGe+ol+0rF7Gj8RQwjgBNlir/mFvjgYKol10+Pvk4rjzFyNMMQLW
	 JCG+5MHdwdJea8+PbbbZXoWyO8Av5n9FTwZ6VWKCfdtjmLBiJqihRYNnwthPhm9suz
	 XsAVx/lErJ/Aw==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Clark Williams <williams@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH v12 14/19] perf test: Drop samples without an IP in the dlfilter test
Date: Mon, 23 Nov 2026 19:00:19 -0300
Message-ID: <20261123220024.14891-15-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261123220024.14891-1-acme@kernel.org>
References: <20261123220024.14891-1-acme@kernel.org>
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

Since v7.3 the kernel zeroes PERF_SAMPLE_IP when a user-only event skids
into kernel mode, so that kernel register state is not exposed to user
space: commit 166f10836a653dfa ("perf/core: Fix kernel register info
leak via hardware skid").

The test records without an event modifier, which is user-only only when
perf falls back to cycles:u for an unprivileged user, which is why root
runs never saw it.  The dlfilter keeps those ip 0 samples, and the check
that nothing but test_loop survives then trips on their lines: the comm
column reads "perf".  Drop them, as everything except test_loop must be
filtered out.

Fixes: 199d5e872a9ce737 ("perf tests script dlfilter: Add a dlfilter test")
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/shell/script_dlfilter.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/script_dlfilter.sh b/tools/perf/tests/shell/script_dlfilter.sh
index 88222280f6094fd0..797cd9ae84141f64 100755
--- a/tools/perf/tests/shell/script_dlfilter.sh
+++ b/tools/perf/tests/shell/script_dlfilter.sh
@@ -46,7 +46,7 @@ int filter_event(void *data, const struct perf_dlfilter_sample *sample, void *ct
 	const struct perf_dlfilter_al *al;
 
 	if (!sample->ip)
-		return 0;
+		return 1;
 
 	al = perf_dlfilter_fns.resolve_ip(ctx);
 	if (!al || !al->sym || strcmp(al->sym, "test_loop"))
-- 
2.56.0

