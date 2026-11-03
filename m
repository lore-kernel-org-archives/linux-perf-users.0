Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793670778;
	b=Do0mKDiGzG4jDgmQbwJ4KCi59IBjb9Y97OTxGs8O1YvPlmEDdcEs1kfnBnLdOAUrQ3tT
	 LWhE50eQEOUP4ujLsQhrwhIXwYelBWfsdWhnCV+rySZQWp3dt8LvS2CThn8i21xpvUHn2
	 lM26swSBPrYn8hgJUsEb+dGsKR/jm4n2qT3BzjpTc962bBU9+9Qm4YdQ3TE5QjqTmN6MQ
	 Y7jN57Wew5JnzunF2/JHlLjHMRc8omPIWkfA3/62/5lNMQiX0M4Bw1OZ2AEFwhupiK9bU
	 IE9TV1PmeOgdC+HeWUkZ4WRpGQ7i7ijfhKDNUhQkkzbb1ghMZUZogsMqpvNUgFpPG7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793670778;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jk9ja6pFw9H/pCHElM4lvoPR4YQqjz4WLvOdv5tiqaQ=;
	b=kswHAJLBMJuqT3V9jxzzD25nPFwkVzE0Uyb1PS7AP6awc9Tn2UoMF0mGfHi9SBbA2EFs
	 FwR1LiVAboJM+MezCR17RQ+MK81tk6PD+n7ZbaMPtlOdcnu6k+ij5cSuwTzTlw5YyFOqb
	 Ysffgt7C96K6aLv2m24C7MJPjYRJdL63XXrfURMhTGyThZKodvDjaN2kIsoQ3RztdBu/Z
	 eWlHZIdPJEVqTNjb0pXjctgJg2Os2ZVBAlTClKEBbOenZr9P91C1jhqN6zuD9GAnUKBDc
	 50m/IUKbhEoHz7F5+03Vg6ASZGgNSqwmnPmiTsnp2Cm1IWD04IPixHuXPwgvM6GEyrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieZ8mjgl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BAA606A338;
	Tue,  3 Nov 2026 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ieZ8mjgl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 716F11F00A1B;
	Tue,  3 Nov 2026 01:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793670778;
	bh=Jk9ja6pFw9H/pCHElM4lvoPR4YQqjz4WLvOdv5tiqaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ieZ8mjgl1kJ+qhIlackYcDn4YQPJ5AK/nrP4yNlVqj9wwEds1WlViDZYJW3sKEVSH
	 R+gKDwezVYLPogxqnSxLJhXKZD6f+x5NKoBMFDY0tRd1w5/eO11S3q7zQCSLp3A8/z
	 qVGvYHfGyGRuC6VV+QTB+BzcaCTn36WUGFVnWWIgV6TnL7bIU4DJn8KDYnRSL06Vsu
	 qgFW/thxcj/Uw4okCYsp1iNEITB3SLsZLvkdMbC/No+Piem8JQQ0dvCH1/JdJIwnkd
	 8Hp4KDuT0un97+Lj4VomPbr+CUSx8oCSZMEder7nI9OewFN9IvLH6d6Opyh8MEFDMP
	 /sKvQ897kmZ9g==
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
	linux-perf-users@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v2 07/20] perf: Always inline the empty perf_lopwr_cb() stub
Date: Mon,  2 Nov 2026 20:52:25 -0500
Message-ID: <20261103015238.3780910-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103015238.3780910-1-sashal@kernel.org>
References: <20261103015238.3780910-1-sashal@kernel.org>
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
index eb3f7bab498ca..dcda92526b78c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -2137,7 +2137,7 @@ typedef int (perf_snapshot_branch_stack_t)(struct perf_branch_entry *entries,
 DECLARE_STATIC_CALL(perf_snapshot_branch_stack, perf_snapshot_branch_stack_t);
 
 #ifndef PERF_NEEDS_LOPWR_CB
-static inline void perf_lopwr_cb(bool mode)
+static __always_inline void perf_lopwr_cb(bool mode)
 {
 }
 #endif
-- 
2.53.0

