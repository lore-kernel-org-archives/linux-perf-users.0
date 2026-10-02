Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68112264CA;
	Fri,  2 Oct 2026 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966759; cv=none; b=AsRYwDlL2yYB1DvilFXCpFmvFlX4lZQ4xWIOWZjkgyuyDmiA+8gn8GrkhqrTbfmvh/dpS0rnZdJKtDQF9TfrUCythVy8K6f3s48n+9BQhvNFeSLuOk3TfucP6TPDjPPuYajiHDUlciL0PCfdWMTQtkbI9F9cDU4cn+KEeiJOwzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966759; c=relaxed/simple;
	bh=02i0M9cQVcI4OzfL9ZRzbIOSN6ZwbmiBZLNmG6nxo3Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SVqzNVqZNeaph151waE7ZksPFu26LPC3xm0AAR3pMSOM6A9Uem8eEM35USN08YT1q+ZZB9cMEvIt+ibin76Y8VYicobv0HzLnD6KmqdqB2HLIWBLsQ8SFB+lwoOhts1kW7RCc/rwd7zIdioudZwZq4ImDxv0Nw5VjpsYwNS4vyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3hBnNtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3hBnNtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51586C4AF12;
	Fri,  2 Oct 2026 18:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790966759;
	bh=02i0M9cQVcI4OzfL9ZRzbIOSN6ZwbmiBZLNmG6nxo3Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=S3hBnNtZ9O/qZq82bc+X9VLxfgrG8FsY0M3Uru2HjU8qgA2Syf0VDpQeEcwvvP53b
	 gsbg4bXQTWSyzjthDQuEOD6mLm8LwAeRkMksuVyqXxkYtghqSgIOiUb9oZMmfYiSBx
	 ihkQD3z4HTun7FHr0qY9XzI+6sTxQlfFwbgpUnzcCbjC8DtWZDket+svTrMMqqyrHT
	 L9upOfCg/AyOpAUSbUaqgajJq2cVBfLGp0u4wgNJ8z8XO+RsEWu9HnOuCbOlnJypmF
	 C4Scboh8iLBSVyuGMnKmol+antpZrBiNV6BhA2nPmHKu/HE9oPJB3njaBTotKCqkGO
	 zH3+amnmUBHkQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A28FCA5FE0;
	Fri,  2 Oct 2026 18:45:59 +0000 (UTC)
From: Alireza Haghdoost via B4 Relay <devnull+haghdoost.uber.com@kernel.org>
Date: Fri, 02 Oct 2026 11:45:33 -0700
Subject: [PATCH v4 1/5] perf symbols: Fix broken ELF_C_READ_MMAP fallback
 guard
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-perf-symbol-memory-send-v4-1-0a592bb2539e@uber.com>
References: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
In-Reply-To: <20261002-perf-symbol-memory-send-v4-0-0a592bb2539e@uber.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andriin@fb.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alireza Haghdoost <haghdoost@uber.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501; i=haghdoost@uber.com;
 h=from:subject:message-id;
 bh=Fie+m8uDrnEku3C9hTHPEiLsQANbwK1zFduANx60M6s=;
 b=owEBiQJ2/ZANAwAIAVNlBDxl2ALYAcsmYgBqv/vkFLIf4inrlYhbSjNrLcejy/dUHW7jHb3DY
 MtjWy68uzCJAk8EAAEIADkWIQS5+sFL3gX/8PrA0S1TZQQ8ZdgC2AUCar/75BsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwwLDMACgkQU2UEPGXYAtj7sw//QG/Td0j0BGXRT2vPRe/HJeSG+Hl84Qb
 nuqrP4uB86oV7rlLrPdjrwL4xdY4mlVKmQBKE5Dbtm1rCGocKj3XnonvDFhWHUZok/cnSEJteDv
 jc30hlEf+9yW75ICbhOaFHHTjBPFkitBE2VUXI6rjlx5nbFl+QBQkSyZANEq37Y072v6sdxeEuf
 YzUGrN+qbufdVT4a9E/n7aKD42XyR8c7sYFk42r221HeV/ksEAByaAUAuSR0hN39IVMqCpXWAwj
 orQ0LR5EUfAr2NazAk0aVdei6wwNNNMUIqaOh2IA1kOhUW/nlelFykMFpyI0rhG7+fGWBsZk9B8
 D2+8jbYRqv1soVIxD8wWFXSsYYJvLQYCpqaOlE29rbY2EXNvZopEfmk6jLYNW+PfHvAkIqe8QKK
 lu8KOTuwVeK6S75afgLvqxMrkYoXf5+U4a4QtqLCiAhw/v66CCoDJvdIqcl8YChyWxKc6yOTBfY
 cuvCOfY92IIYKu8D/SgGI6Bsh812Z9TffmEL4GRba2E71J0zLamyD9pSgUdMGYe//E7XZmY65+k
 yq34XAohenh29OxgNghZCZGxGuB+MtBWxaToHA8YI6OH58fI4KaUbL3wwhwIIAtnBRQnYM6qOs1
 uNyoZ5w3oH+/PpddiB5sJxgC8ncK/rRRu95+I4r/SHvQMJuXlqWY=
X-Developer-Key: i=haghdoost@uber.com; a=openpgp;
 fpr=B9FAC14BDE05FFF0FAC0D12D5365043C65D802D8
X-Endpoint-Received: by B4 Relay for haghdoost@uber.com/default with
 auth_id=764
X-Original-From: Alireza Haghdoost <haghdoost@uber.com>
Reply-To: haghdoost@uber.com

From: Alireza Haghdoost <haghdoost@uber.com>

Commit 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature
detection") replaced perf's compile-time feature test with an #ifdef on
ELF_C_READ_MMAP. ELF_C_READ_MMAP is an Elf_Cmd enumerator rather than a
preprocessor macro, so the condition is always false and perf silently
uses ELF_C_READ.

Perf already requires a sufficiently recent elfutils version that
provides ELF_C_READ_MMAP. Use the enumerator directly instead of
restoring a feature probe or retaining an unreachable fallback.

Fixes: 22dd1ac91a77 ("tools: Remove feature-libelf-mmap feature detection")
Signed-off-by: Alireza Haghdoost <haghdoost@uber.com>
Reviewed-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/symbol.h | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/tools/perf/util/symbol.h b/tools/perf/util/symbol.h
index d0bac824c79c..46b1649c64fc 100644
--- a/tools/perf/util/symbol.h
+++ b/tools/perf/util/symbol.h
@@ -57,15 +57,7 @@ static inline bool is_livepatch_symbol(const char *str)
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
+#define PERF_ELF_C_READ_MMAP ELF_C_READ_MMAP
 
 #ifdef HAVE_LIBELF_SUPPORT
 Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,

-- 
Git-157)


