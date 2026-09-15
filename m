Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B904E4C4F7C;
	Tue, 15 Sep 2026 18:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789497807; cv=none; b=A+i4V7MvPoO+TbiVJBuRfFgfZI5qELwa1WIhJQBvSNH98L7yKJ+uoBSA2FfDREXR8V90WRxHZ3H8R94xp3QkcEqTIy1HdvjqotCMMBt2fI+KMpO0skBE3Zz695uGb8TIuqFI54+tUGtRn/hVBwLl9XEZNclQ0qfaHWuUpCB+js4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789497807; c=relaxed/simple;
	bh=/dIazRIjw4I+09Yy6gtE4cbjra2g1GCXOKQikqvST/4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TX9/veF+ypR6dYOK8m3wmPQW1lTLeCmAj0acqjrMc+QDo4vvg9DUjumxx/xNY3lcJYd9r7wAnR/MFf7KjnsjlJKjZs7ENkwDR1JSMG+etn2TiYiiIlGo/cWmlawPx8EVjqyN21kH3C+rAHqMIT3bRIYDIjAJav8r0GjPFikSkMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgZUUUie; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgZUUUie"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5FE0FC2BCFB;
	Tue, 15 Sep 2026 18:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789497807;
	bh=/dIazRIjw4I+09Yy6gtE4cbjra2g1GCXOKQikqvST/4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CgZUUUieTH+mI//2+iZhDk2c7hZv07VPljAUCx5S7yF/E/TqLdxD99Yo8blDJXdra
	 7Zs/FcovmbqfXiZ32imeTRxYersaBDlufapcWXU4gkDG+GCWKpErLnIFjzmY8xjtJO
	 6zEc0oH1s4purt2pv/K8gc4D8SIB8ftN2lCO4GbX2XFloMK44gshUvYOzB5aXudHve
	 T2n8gmhf9OFvpb1rumMXWeUyZ9iiHYHfcmIv7tWjp8AFombStRgchfdvsiu0b2+VBL
	 ymTtjnbyEEdmiBIGjAjCmi9bZApKVi5WUaaBkRUtMKvmQfNd8/sb7JaDB0bklbbORM
	 qpqT9YfCyJR6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFDFC88E75;
	Tue, 15 Sep 2026 18:43:27 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Tue, 15 Sep 2026 11:42:43 -0700
Subject: [PATCH 1/4] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-perf-symbol-memory-send-v1-1-1d3360e21f07@uber.com>
References: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
In-Reply-To: <20260915-perf-symbol-memory-send-v1-0-1d3360e21f07@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Andrii Nakryiko <andriin@fb.com>, 
 Alexei Starovoitov <ast@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1591; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=LDEl2QVI/AYSvnwqi8o+0DSPTV8sI0VoVdKogCTfNxc=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBqqZHNgzZ/cAO9jMToADlL/aGKgYXyBbsp9BakV
 5moWgzgEWuJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCaqmRzRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtj3vg//bgjLUD0a+1mbY4GQoeHz8tP0yt8Y1ga
 DPd5KO7zFi2SKSwsK0o0ihKCjDVd3nKlRY/PDIBsLR8oEsxrwVHvEgjZRPj1Wve7JxFmLicVMfR
 wgp4eeQKuUUdpEgjpLXn9RQyhMQwzScdN3vDp61c11P3QKoU9Dclo5TV2Yrz8I7SdeOAnrzqp95
 XCEZ/RdvfZ5s3oNEs37vUtOzGEzX2rnZlwT7bzfK8geqoO+hmJZhPm+ujfcf8animO06VuuS9Ij
 OhmIiPS4ZfGt1OuKsnrqESGe2pjU+l2e6IDfFOhqdoosgzpXBUIguWVaNI5aztI0yzAyRrZqK2+
 BxHzhFMfHkzsAf3gaOrWTrQK8YzZWgndROKRQ3lLb8z/FWhF1i6xW/9vkdRWuV1xhjUU4NYtrXG
 KoCWe0OYjMZD0W8FcpCcjRS9uVAJniwGRrCm4oK4B6i2b5q7bMhP9ktzi44lGyKbbvhD22+AvMt
 Ahe4aqrN1BvT0DIRhUdijzNxIWggIHtaq16t8hZkaP3ofsz5BrS3hMIqxokHpGJgbgqhgppo8WI
 0e0DDUKyW7BKmDzxKecmxOdNdVuxaJJBtTh4FbIEzMmyOYWiGbZRsIAlqJycHv4KQMjtxYAMD9j
 arcBqvJk4BffF5iCV/AxuJODGqx8tf2TB/rPP+kTaA7ZqWYdYQ6c=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com

From: Alireza Haghdoost <haghdoost@uber.com>

This patch makes perf mmap ELF files.  This was the intended behavior,
regressed by commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap
feature detection").  ELF_C_READ_MMAP is an Elf_Cmd enumerator, not a
preprocessor macro, so the #ifdef is false on every libelf that provides
it.  objtool uses ELF_C_READ_MMAP without an #ifdef guard and has been
fine for five years.

elf_getdata() still allocates when translation is needed (32-on-64 or
cross-endian), and libelf falls back to internal reads on non-seekable
fds.

Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
Assisted-by: Kimi:K3
---
 tools/perf/util/symbol.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d0bac824c79c..e5cef16b240d 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -57,15 +57,8 @@ static inline bool is_livepatch_symbol(const char *str)
 	return strstarts(str, KLP_SYM_PREFIX);
 }
 
-/*
- * libelf 0.8.x and earlier do not support ELF_C_READ_MMAP;
- * for newer versions we can use mmap to reduce memory usage:
- */
-#ifdef ELF_C_READ_MMAP
-# define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
-#else
-# define PERF_ELF_C_READ_MMAP ELF_C_READ
-#endif
+/* libelf falls back to internal reads when mmap fails (e.g. non-seekable fd). */
+#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
 
 #ifdef HAVE_LIBELF_SUPPORT
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,

-- 
Git-155)


