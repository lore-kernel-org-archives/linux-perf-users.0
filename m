Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795572385;
	b=a5KHGkVGkWLFbEWM54F5/siUcdL4GGWj0OKoPOGQxB+l88pL0mNYd7mWSbBuBGnZldMH
	 iHINVjZxe8KRbCY3AVQFBqh4JECGi55WV/XWnOoPPB5J4GhlpzEMSh7DHIAN7JRNgpV7F
	 c24P+2OirbE0vUyLWkUvCV0SNCKaMQWOafvC6FMnL4e7SKBIwJibwfzAjTSG/gLcyCfZl
	 RVELGT/OQ+4Uk3OzeS0kx1iN4C3/5GxmcGIwI/uDhbKe2f6eGkAq//vX0rADgFsmkzXMd
	 TNGwwcX+timfpKdX92LdqI+jikSo09mLLfmNtnXN9eP/ZHXJqUlO8TiXFql+GTZX7rw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795572385;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UBTUjaVtS7K/5PWz3SSwOCRiC5A8W60WnjfBb608/1A=;
	b=tOURSE1RjC3p5qPmOsgevcZd7kA4ZFVjmtZ54WhQtbr02CEE32Z1qCJi/b8WWM3udsZw
	 ld2vi2YPcYEQ2FvwK2aB0p8pYVUu0SKo/Nj5ZHvJm6peqtI+OPR83zzv0d/K3pP5qob43
	 7oKBReuYFP8vAeUbVYcLxNmhyPz9YZy/4jLMAKmIdjdvjXdijCFNKYZ8OraIeFzYLVspz
	 GoNYKdmcm6RJxkkxBSa91ersUU2bNEt5MGe1hOIrs4NWxjvbr/QyG+IcI3s79I1ZXXKcX
	 09KgMXmBMt7ORRdmplrxD4jDQi3XqNdUBhf03Dd3F5UrpCwcGqCdZgXiRd2zmYGd71w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEz1POMX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C95606A337;
	Wed, 25 Nov 2026 02:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gEz1POMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3173E1F000F2;
	Wed, 25 Nov 2026 02:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795572385;
	bh=UBTUjaVtS7K/5PWz3SSwOCRiC5A8W60WnjfBb608/1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gEz1POMX5Ws6cMVWR6CtvoMEoSorRkKmNYgHEXR3+Q0nQENhMWDpDgZkiN8JboT1O
	 GqYniRxaSPQr1aWqHMynv+TnBeBqmGOwXLY1ZRBvZH5/4330JS9IXbdgC9eUqCBMHs
	 mmJUOiIAibyuqtVAKK23v2UeOt+zm2KJZV0zGtr9UoIJTQ15gJLUCmtppThAg9uUNJ
	 6qTV5ycWH3n6KbRthpMvMqrRe6eq7V84yJPoYwmOWAal5wg0lCAF7PgRQgibdmqLcw
	 gw30V/Yv73bolEHnKtqH+ydtCiYt1IWfH2DsYfl8mFWdowyI15rdBOisO+dn9GpTda
	 19RSX8ppZTFcA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Chuck Wolber <chuck@wolber.net>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	linux-perf-users@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v3 06/19] perf: Always inline the empty perf_lopwr_cb() stub
Date: Tue, 24 Nov 2026 21:05:50 -0500
Message-ID: <20261125020603.3934222-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125020603.3934222-1-sashal@kernel.org>
References: <20261125020603.3934222-1-sashal@kernel.org>
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

perf_lopwr_cb() is called from the noinstr acpi_idle_do_entry(). The
x86 implementation is __always_inline, but the empty fallback is a
plain static inline function, which the compiler won't inline into
noinstr code when building with code coverage instrumentation:

  vmlinux.o: warning: objtool: acpi_idle_do_entry+0x4: call to perf_lopwr_cb() leaves .noinstr.text section

Make the stub __always_inline as well.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/perf_event.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index e1e11500df097..09e4d780288e6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -2142,7 +2142,7 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
 DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
 
 #ifndef PERF_NEEDS_LOPWR_CB
-static inline void perf_lopwr_cb(bool mode)
+static __always_inline void perf_lopwr_cb(bool mode)
 {
 }
 #endif
-- 
2.53.0

