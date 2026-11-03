Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721318;
	b=i9ZbL30t35cliehFr1sEvG9xt2R630meVTxTkpZZghAg6uF5ibyo4560pouvrv6BwfBW
	 l2jN91/MQmdXwRtVF2qbJTr6s78fPMl+xPaboehXvnP1/u2GZ/Orw9G59BXKJ6zbhc4eY
	 alZhedm3o+cC2ht7RnsKS9kDVdGhxL78BuhZnaoLqx7V+2T4RijjgoXcv11VO0ICb31of
	 yqdBMytwVBCTojkgNI2Qltd/EHlPOeN+8Vu3YEdR72Ytmy2w5FdqHRUAaFUnk6CAqf7b6
	 KvD9yA/wBkdvrQU7p8SK7VTM+5jY7S+476SaH4YNVMG92O3EdD4sHMjN+jgXSO6tzkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721318;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4fImzfbtewSDlw3aOU4hnHhQwuzzQup7a7LaOymAdO4=;
	b=VdlajLIG55GEYVi5frhn+JbYqLUz+1svyEle7dazttho71oYdNg1f0UXMXydQoHeWAea
	 pSgob5ip7FNJhh8RIelVAjbQl4wiIa+rnqBOJ6Vi555ZZg0tIuTIoUIDvd2yo1MtekS1j
	 n7H027d7t0FrnxIo/jiexeu1xYgQblQlJFJcFDEPhCqsVTFtBpsQpioN+z+r8S2EyA8fB
	 Uum5/laDpF+Y7NVb2uXu4VEnd7X1JvNlaB7f+40JClvwBvGn39Dg0UpeIsEUeFB3dRa5W
	 J7937hg5ZpXcyqpEhNWMQLwz1DWpVNUcb1Kc3ATqN/+VFyqoU+jtNOhQAzkaw2oQTOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="THQ+5WN/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706D36083614;
	Tue,  3 Nov 2026 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=THQ+5WN/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FB21F00919;
	Tue,  3 Nov 2026 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793721318;
	bh=4fImzfbtewSDlw3aOU4hnHhQwuzzQup7a7LaOymAdO4=;
	h=From:To:Cc:Subject:Date;
	b=THQ+5WN/0wlZMkd2MUFoxWuNRmT6Rq5184fsAW2kFKTmC77+0Uk5EZ+g+Rjtinigo
	 dcFezDpZzCYXCMQ0EFskCDUMMouvKBL2b8a17inOMb8XDY+XYVCuBaUiRggXRO2WhT
	 cxL9PxbAZXuCyypHbBZU2P+Q9YwUw4R+rayP9wA3TmkmOcddSThSL83UI4zZjqS1mP
	 ljQAjGyaSDod1QPVWCOynWjTrbXcnYwmPq/Xw6ZULItOe0AW3E37Y3WEYYY1/SNn5l
	 zuyLq5w3Pp++Do9v1/eTnVN4KJ3WRt5H7SuUThDozf4KMDTiaG4BLnxRy7BMlCzywi
	 BJzZPSyonIrig==
From: Sasha Levin <sashal@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Kyle Huey <me@kylehuey.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-perf-users@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/perf_events: use the ll64 types on powerpc64
Date: Tue,  3 Nov 2026 10:55:16 -0500
Message-ID: <20261103155516.535193-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

On powerpc64 __u64 is an unsigned long unless __SANE_USERSPACE_TYPES__
is defined, so printing attr.config with %llx warns:

  watermark_signal.c:85:58: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' {aka 'long unsigned int'} [-Wformat=]

Define __SANE_USERSPACE_TYPES__, as other selftests do.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
KernelCI's powerpc kselftest builds show this. The define makes the same
change on alpha and mips64 and none on the other architectures; the
x86_64 and 32-bit builds don't change.

 tools/testing/selftests/perf_events/watermark_signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/perf_events/watermark_signal.c b/tools/testing/selftests/perf_events/watermark_signal.c
index a84709cabd8be..abff011f63161 100644
--- a/tools/testing/selftests/perf_events/watermark_signal.c
+++ b/tools/testing/selftests/perf_events/watermark_signal.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
 
 #include <errno.h>
 #include <fcntl.h>
-- 
2.53.0

