Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793585591;
	b=KNYW2uS81xG9tNjP2q9uT7pHWtNuU50g1hJsgss/FsIDj/74B5AJnj1TlCBeyEI8K3ZR
	 vO8GDkdGaWk5PTcrs80xrGr7+9SjXkClDrp9KcIv0zzy4MU0PFunHvCNgau1T6CWU4F43
	 9RY3HyQVywpY2BmbQqNi90j/bHRoEQ/WzkG+KmgLlFzpiAKZUU0VmMTGpY1uTy/PPlEkB
	 UBvjVdbB9osH/oJbusKL2IK/JdC4aVx7ZwEijb575htwSnhBoTbOPhbSoJpiuZ6UDuWH1
	 ec8ifSz4oKbbq0uZJ5gJSJpJIePd1IgFYPlKl1qTjBJ5jumjbkK2TxagMaper+qniQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793585591;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Gb8+2Cm7VYc21mGqZ8Jc3XFCiBtua3HpjtI5IyisGDE=;
	b=b00pd8cw0If1Qu/QzZMeAL5Glhy/puXvQkYyktrmoft9TwZ+BA3IjO44iJVSnXkOS9Ix
	 KkKIAyF610LEWMH2gNBHGs8t5moZY3qEBItiGiMPjIbT942MP7mpC2Jj4eds3dMGzbqEV
	 J4kq5DqgFVSaVILAaRaUY80/SD5SW+FV/mddVec6WvVeJKTXCDLDZixZXCN6AP60cV3VD
	 yjzVc5Su5dhrUtQNK8bY3qNE17XhKk6bVpV0eqYUzHFfVtcDog/m1ASICBaltffJiA5U6
	 hov0jBQjBZBdfwvIXHZrZjrvtw3f5nSTC7yOAQgYpLwPtClQsaizZSq9YMNSdhmxslQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htRQ5HTe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028BE60A2639;
	Mon,  2 Nov 2026 02:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=htRQ5HTe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A01F1F00A26;
	Mon,  2 Nov 2026 02:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793585590;
	bh=Gb8+2Cm7VYc21mGqZ8Jc3XFCiBtua3HpjtI5IyisGDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=htRQ5HTeEM61lO+9MuVd9btX+Wz5McO/KLw82OE02m07NiPJQjsWOCgYFulsY8aiY
	 3iGDeELhM/X4JhTkEeaIe0W6LbFTa+2wdCNqIEm+l1oruKF9xjwZA39awLh+DM6rk0
	 BDLEHbVeOpCwIOg0jId+iBhWQwwv7PJzhwCVuuuzh8cBXhhLPE971AhNoosykZGR04
	 rbDx2H4BXOjdS8XHx+N/JMRTNbZsFtafq2r1dXQx5wXbSVEWt1MdlrqCLoKXi8186o
	 yYzjHKreKCivnR7KwTLHLLSdnnSWoNI4k8mYHPU1wrqiBhx8JpKSyErzQUAPxvyNzD
	 Fs36O3NtTVitQ==
From: Sasha Levin <sashal@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	linux-kbuild@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] kbuild: build the tools selected in tools/Kconfig as part of "make all"
Date: Sun,  1 Nov 2026 21:12:52 -0500
Message-ID: <20261102021253.2545235-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102021253.2545235-1-sashal@kernel.org>
References: <20261102021253.2545235-1-sashal@kernel.org>
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

With CONFIG_TOOLS_BUILD set, make "all" depend on tools_build, so the
selected tools are built with every kernel build, and allmodconfig and
allyesconfig builds catch changes that break them.

"make vmlinux", "make modules", single target and external module
builds are unaffected.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Makefile b/Makefile
index 7919263484f0a..2a69f4c73a641 100644
--- a/Makefile
+++ b/Makefile
@@ -1650,6 +1650,10 @@ PHONY += tools_build
 tools_build: headers
 	$(Q)$(MAKE) -f $(srctree)/tools/Makefile.kbuild
 
+ifdef CONFIG_TOOLS_BUILD
+all: tools_build
+endif
+
 # ---------------------------------------------------------------------------
 # Kernel selftest
 
-- 
2.53.0

