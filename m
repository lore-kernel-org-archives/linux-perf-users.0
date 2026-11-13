Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794582389;
	b=BYZNSjFuPN7v7fKgYKoBtS41rk5DinSd/9enNtMkPguMnNzqOMbcM0+EEUMWrwSoJkh1
	 QhqdlBZ/Aw4FA/jWJKf32byRnY5twOrVCqBwNDdEtcf9dCKV1WlWy2tbR1QMvY49Ktivq
	 4Qk/K2IByLckcYqEBpFlXOHsulx5gW5dUi5xnnNB5VABjbTDrnmN2CT7I4AD967JOE9Ob
	 mbybFTE/1PVvN42Sx+lN8qC4dYKmsuzqXbWXOcUNz5psL2elDPDF1MCyIgrCftuaMFdUp
	 khQni22+hZfEIP8TDtF1esC0QyHqktyY5X/c3FGs8M3Z96G0EQa9KcLxnI8+Dn0SSfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794582389;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=6HGWkCDBHmlGJfJwDjjX0Ph1nyw6UI7RFOL+RhCg8RY=;
	b=sy8wmxHClDjKsupfD370auiAhHDf9Kz6yQR1onoyTy1qAhg4D6Hkn3a2G/MwIaFMQjzK
	 HGL03BItr+Wq10V3n7qtMMsqNu/oecqEvsdCtA71697CCnPQug7Nrtq10WNGeudzgJr06
	 /tJxJrIzNGKtet68Xxj3Xj51Q4M/KqXla+B7V7S3QJo783MYjhojvHeNJS9u6QO8c/Vih
	 8wAsBdIaW3SgSzWCXvysMqJrvSq4F7AeJtKph4sqNGkhH/7AgxiCgdjjfZ+h+WGWdSW24
	 EGZzUcb9DIq5jhGCw4phS2pGQFw8JaxX7PwHg771aV+QM8KPLtas/mBSJlrSvVfG21A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLU3byo1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3FE606A89F;
	Fri, 13 Nov 2026 15:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OLU3byo1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0A21F000CB;
	Fri, 13 Nov 2026 15:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794582389;
	bh=6HGWkCDBHmlGJfJwDjjX0Ph1nyw6UI7RFOL+RhCg8RY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLU3byo1mdgmz/XiNroAWEmhpC9vNhR9qoz7+z/VUH0wXtPe1lRj1oKCw0teXreqx
	 Xs805ovqFWTJNCywUghr3gwOLstucn8dyGzP18SGVZIInnx4fwm/20dZCtnJpV+wpN
	 ZkNiqX8Oavin41KF7T6AGwgawdaXpMSKlmV21OYIowhqNLnvnzCC/qD/SxIfwnLa57
	 DbfYFueNfB9YUkxZuvpQO1UGLFfySNAxqhYymwpmVTgCsY4ws1elaff7HUJcURAPvq
	 jFhpLEbq2zwF5t6LInOjMrVCSMZkyvse6hnLXHy4zvSe+6LmdSfeudTeZF9Y2zb4mi
	 Vsd6g3OhzElsQ==
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
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Leo Yan <leo.yan@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Robert Walker <robert.walker@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 09/12] perf cs-etm: Fall back to the recorded instruction size on a failed read
Date: Fri, 13 Nov 2026 12:05:50 -0300
Message-ID: <20261113150555.1163049-10-acme@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261113150555.1163049-1-acme@kernel.org>
References: <20261113150555.1163049-1-acme@kernel.org>
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

cs_etm__t32_instr_size() reads the instruction bytes from the traced
program's memory to tell a 16-bit from a 32-bit T32 instruction, but it
ignores cs_etm__frontend_mem_access() failing, which happens when the
DSO or its debug data is missing, and then reads the uninitialized
buffer.  GCC 16 warns about it and build-test fails with -Werror.

Use the instruction size recorded by the decoder, as the A32/A64 path
already does, when the read doesn't return the full two bytes.

Fixes: a7ee4d625ede4f62 ("perf cs-etm: Support for ARM A32/T32 instruction sets in CoreSight trace")
Cc: James Clark <james.clark@linaro.org>
Cc: Leo Yan <leo.yan@arm.com>
Cc: Mike Leach <mike.leach@arm.com>
Cc: Robert Walker <robert.walker@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3e01b401ca6f3a08..5d53ed74ae8835a9 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -1370,9 +1370,12 @@ static inline int cs_etm__t32_instr_size(struct cs_etm_queue *etmq,
 					 struct cs_etm_packet *packet, u64 addr)
 {
 	u8 instrBytes[2];
+	u32 len;
 
-	cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
-				    ARRAY_SIZE(instrBytes), instrBytes);
+	len = cs_etm__frontend_mem_access(etmq, tidq, packet, addr,
+					  ARRAY_SIZE(instrBytes), instrBytes);
+	if (len != ARRAY_SIZE(instrBytes))
+		return packet->last_instr_size;
 	/*
 	 * T32 instruction size is indicated by bits[15:11] of the first
 	 * 16-bit word of the instruction: 0b11101, 0b11110 and 0b11111
-- 
2.56.0

