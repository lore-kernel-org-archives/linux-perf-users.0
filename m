Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415794;
	b=BgKDQx1qg1CWBpAks6Rpmr8vjPBQKrg773eZzjurwn6PV8dsncELSfBpAXhF0RSpCjo4
	 1x2/y8x13x/uVlXSAK5kmTVup4VjibAYe+/+FL4fs8809atALn8GuyXM63EG38uREuCkY
	 +gkcSAAvGHh8BvCsuENM1o3NxHjMj45z9+45HMo0ECSzQSv0TlbRMrLp67X+mpqYUa7+C
	 Ac34/IIO8iRCUZsf3MqgAP6fSxr+Ur0GRTy6O9jZqOCD+nGFo89lRGEGjWXD1c5x3P9Q5
	 gdJncU2Agfl+irwjnzyXQ1seqjH3c9Sej7XCb92EKN2i7J/bGLuteLGlR2LDKzpifeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415794;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=xSLMxigfHiElvNTq4OZHWTQNhnRMCNOvjMcC0F9+Qn8=;
	b=ONUEoJoHEvjoX5uRLW7/EeCjukXLx6f/4zagvye92xwCV5EjJui2migRsZh04Si27dVQ
	 oF+XOhe4KARFSNFlW3V8T0utafb5j5UXKxfiY6IvCfGhvOV1rfq+eEf8crz5R2KLBB8lX
	 6+sLNjivC2Q5+gY52ixRoxcHIaP7U1shjSpurh1Fs3CVzaTIjbR6huMdmuB6iszQ1Gw9A
	 sKLcTXnvGsDCGJ2sL/q11YGb3tXxkMcjqMhJ8VIg8qM55OabPu6fXWT4Q3/qfUj30ZRql
	 XuIQ9mL3Is/D4Ku2KLp9BjYJox3FPxmvMbYkG8pW99yzMcEgmGpAWW7YFcYpDf8iS8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hLaNO/9B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B200606A321;
	Wed, 11 Nov 2026 16:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hLaNO/9B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D00CC1F00A05;
	Wed, 11 Nov 2026 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415793;
	bh=xSLMxigfHiElvNTq4OZHWTQNhnRMCNOvjMcC0F9+Qn8=;
	h=From:To:Cc:Subject:Date;
	b=hLaNO/9BUpeOv9D9aqpLgjxrleOn9aGPxMWwROCjBmu/xsHE1FLIuxPpXZtu5Ku6S
	 hAhIMc8GLM9ymDg4qs+6/RD+6tBpI/Tu0KZZoXqTUlHbV+EZhejpHi/nTOKvwqg4CQ
	 asTs1DTh1EwcJImTJ+pacAlMVpDtpKzXIUQaBmdiHXSo317zc28J4v2pv95gYXMqkA
	 WL1y/N1Lo4gGKksslF2pmieqbqRldqKScX/HNWsbPN1tTwHaVcbZ/Y3zEBCaKasD+C
	 xIzsmE1jxwDkpeLNKMSZbHwrImm4V89smUo15oZZXWEVYn9xGldTZ40S+ipOhEX/Fy
	 g65QV/pYi31Tw==
From: Thorsten Blum <blum@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Cc: Thorsten Blum <blum@kernel.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND v2] perf/x86/intel/uncore: Use sysfs_emit() in uncore_event_show()
Date: Wed, 11 Nov 2026 17:49:27 +0100
Message-ID: <20261111164926.78234-2-blum@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1392; i=blum@kernel.org; h=from:subject; bh=4IKxVfu7TH5dedBA43Hw9uUyNRsxmNb2B5zxODIHE+s=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlf5kzrYv3OJ/RN0p710KaTL00zFddPyhdczemyrcLjv szvB5LbO0pZGMS4GGTFFFkezPoxw7e0pnKTScROmDmsTCBDGLg4BWAimc8YGa6afmFUj11YfPfU C4u1O5cI1IhuXeBcU+s5QVP20F/3FC2Gv6L9jJfWuMz+KXlSf/q/ri+2r737Xy/uLQnbuHXpPgv PJjYA
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

Replace sprintf() with sysfs_emit() in uncore_event_show(). sysfs_emit()
is preferred for formatting sysfs output because it provides safer
bounds checking.

Add a terminating newline as suggested by checkpatch.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v2:
- Add a terminating newline as suggested by checkpatch
- v1: https://lore.kernel.org/r/20260206194254.36105-2-thorsten.blum@linux.dev/

 arch/x86/events/intel/uncore.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index b2109b37ea7f..b35a779e9b17 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/module.h>
+#include <linux/sysfs.h>
 
 #include <asm/cpu_device_id.h>
 #include <asm/intel-family.h>
@@ -153,7 +154,7 @@ ssize_t uncore_event_show(struct device *dev,
 {
 	struct uncore_event_desc *event =
 		container_of(attr, struct uncore_event_desc, attr);
-	return sprintf(buf, "%s", event->config);
+	return sysfs_emit(buf, "%s\n", event->config);
 }
 
 struct intel_uncore_box *uncore_pmu_to_box(struct intel_uncore_pmu *pmu, int cpu)
