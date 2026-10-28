Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793188864;
	b=v3LXaGfgCg1Emfq1l27+e35r/TzfeTukLPsluEcEPMbkrhrmqfk+b0pEWOuaO93G3ftv
	 6oKLjyHLdtcwz7fiicITi5U5qW4ZIijpXrl+801iE6yymb770FAN3QUJrSBj3bdOhggEr
	 lr7mRMI1CUxhn475rQuY4SadmVuzQof4ZOvaOI2x5KJc7P5MhynmwI5jGAK3hPMJp6Km7
	 gjuBVO4NS0e+rtxIMLsMW8r7zGs8LEaGnczix5T5X51VWSLKcmaxdZHEipPaUEjX/Hu46
	 wk0o9SjuuiSQ9W1PZ5n0xvWUdgR0rXb+RGWZfVCKdp/NOM+jBIsAlEikUyADJa6Lx9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793188864;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Jk9ja6pFw9H/pCHElM4lvoPR4YQqjz4WLvOdv5tiqaQ=;
	b=J7zDXrjTKJyrYQ9NHuUxe6W2w9bNlFC3+MwN9WE0f91PoiynV93Gt3uTa475+T/fruwl
	 GnCbwr8+HOxMJZrDGuYaq57d61TK1twUBz4Axzrm4yObL/qf2YCoJiWb5PdBGzn7u88yg
	 h7yUtqtP7nJ5l00r4IVdWM6e8ncKqkFV2XZlG7WLgIEeNPx+g8JzoZpE8eG8kwThq3/2P
	 SpYB3VXeD6jW95lj+RfW/9QFstewPJuj//fXPg01XEFJPj2RD7y3U8hYTYYJWUT18ffOy
	 NxiBvj6CmMCpFMqFVet2QC/fSkdk9kGo8s7W0mo4wsCBpPf9f74qZooMjtnqdsnvGtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlIlvS+n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A560A2607;
	Wed, 28 Oct 2026 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GlIlvS+n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 101701F031E1;
	Wed, 28 Oct 2026 12:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793188863;
	bh=Jk9ja6pFw9H/pCHElM4lvoPR4YQqjz4WLvOdv5tiqaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GlIlvS+nCmTyRK81bC41UjhM9uVuS8DejAY6k/QTqC7ezPRmPda3WlizVtl7f0zjq
	 HHqQO1uION0a2cc616A+VJfdfvvUzpXqP8kazgMtKsnGxOTT2abo0NcwwSa0ACcEGN
	 otHXu46M62u+FAJNzoZjs8L/qqs8sLFysVcbG1WcTtrC5TUPv2YAwwvlsvUO/YwWuQ
	 RCojZfieOsFTHc9AN9XHvdADkENP9zH2AebOPaKEqwX7lRhAx2EhTjhfsYgORADFmi
	 QPTQSQuecHXCvjD4nOQpUvBYgai4ycG5bacRpjqbaeXrGiSQI9RIAd9eWhJs0H1zWn
	 tZmoJCgzR/TxA==
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
Subject: [RFC PATCH 07/20] perf: Always inline the empty perf_lopwr_cb() stub
Date: Wed, 28 Oct 2026 07:59:31 -0400
Message-ID: <20261028120034.871983-8-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028120034.871983-1-sashal@kernel.org>
References: <20261028120034.871983-1-sashal@kernel.org>
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

