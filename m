Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E41015F31C
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 00:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970177; cv=none; b=MzhFSXbxxUmJLAfGr8+gJGYf8g9jYs10mkSjbegP1wK5pqFuspgWV6ClzGwqnJqFmMle5zWOOgIy7jyoIvxbPuNnZSHd/Abh8qaonm7KjsMrKLCd6MyXOWB792TfUfuzjScNr5XMP8wb8k641ob6LCF1DsflmKdXz/uuR0KFKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970177; c=relaxed/simple;
	bh=ISxb0EX289Hm6r/C1D5v5yNh7MxoLH57ssbQ8ckbm+8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Et+EDWJWQvfn4Qu9nBuQfs1EmV5m7vCuul4egskOv8Px7nhB8cHK2UykUoaeakwpzHI3QoY2kemXOpVn0T7+qO+73Fa2+64CXnexDZEb1xvMMnnA6AxwmM2ULVtsi2WB+C7KzD4GfJ9hznp2inOyGTCQg+jY6bUwVUt1B5GtJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hpL79Dbq; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hpL79Dbq"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d751bc0c15so13287335ad.2
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 16:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970175; x=1706574975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXaD2uRSXjbWvCISCAsK9PvXAhuUUaV/f9FkaBUIbgc=;
        b=hpL79Dbq0yRyAO4E5UL+btj2Huh/LAHlMiAwcSNUwaoSyDXeipYNy0ryyPoJeYJrXn
         CQjE3PRMgh5J9Xsbl54XIbwycSdoOAbXIl+A9fzkPrza4Fa031Wy/2RNToGMeCDszRzv
         0Mrg2fFGgkgBkbHCl+6AmNd79YCeySXI0n8YU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970175; x=1706574975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MXaD2uRSXjbWvCISCAsK9PvXAhuUUaV/f9FkaBUIbgc=;
        b=iJFh7Fu+XFV82nRO6g+YDLDMdxXcDtBZ/AH6p6smtXFtbSWoOIfa/ce1737td6G4fZ
         Xh3qQXAUJ9Y4Wg9B6td8dI2U4vmxS8g3Yte7XhBCir4Zub9X6S5dKIc24lroH6RP6Iaa
         fHqNw6uR0MOy8RlSCvzxmRIcMxxfB3MV4ck7hxDtLBJhNGIs5lF6mmf3ASaXgVYGwp8D
         mDiliGhPwxFGdXNkAe6Jw8Ec97hXCsrdpX7iQZjTw/By5yl0YQZhu6Uoyx4JGuPAuMcS
         +bHKuAmol+vPAUNqNjaIge9mrxUBezNL5KXVf0k+Se61tk7YirUIH3DbQS44gXjGrBIy
         ioVw==
X-Gm-Message-State: AOJu0YxBPgFw1YUDpF8xMz3jIVZo6BtTu6ULHnpxPUEzHI4hMESXAORt
	BNoZ32jiHPHXWC5i6YqQA1JcSzRVN9G7udI0va7vio48EurF11/EHJRaCcIOKw==
X-Google-Smtp-Source: AGHT+IGWmDZtRBX8t4DIu1G+/5DAGjQKMndSmo0VI+PUTi/ec2cucVkWCjGhYE9pTAFe4zoXAskPqg==
X-Received: by 2002:a17:903:1cf:b0:1d7:2b14:2af6 with SMTP id e15-20020a17090301cf00b001d72b142af6mr6463789plh.123.1705970174843;
        Mon, 22 Jan 2024 16:36:14 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902e9cd00b001d403f114d2sm7788749plk.303.2024.01.22.16.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:09 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	John Garry <john.garry@huawei.com>,
	Fangrui Song <maskray@google.com>,
	linux-perf-users@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 69/82] perf tools: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:44 -0800
Message-Id: <20240123002814.1396804-69-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3386; i=keescook@chromium.org;
 h=from:subject; bh=ISxb0EX289Hm6r/C1D5v5yNh7MxoLH57ssbQ8ckbm+8=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLpFNG1APqWmXvdolDfH8+mocaXwk0HgcGM
 VNIE3sBBkiJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JqWsD/4gHfuTTgS+0XmICb2SSlqKOGKBXK1LMgEpx9me/IY6PVtyCZIG+VUohcpdnaICiQtsFUU
 mImtzAjxoLI2Irht7ZKE6PZszQWlu//xBiu4J2tjYEiRBxzNLndGImZ9xkpLWcf+MOQ2fJ6CtXT
 x0EzQFGUiWY+pSAmxMzmbG/F43IXjMBKDpCrc4Kl2LgtSOf+vRh/hXGXy1G5U2LxXag7qpxaPYe
 GX30l9A5JiqF1VckkWguaIT/rLugkXZAV9gEAqKhMDgsuCYm56vVEHX3Sze++BjQwZntch3wQ03
 JI2FYzS++gQePJNhK7jY5Rfld2a2JIMlegBz+Hu3QqB0n2qt536h7AVvtInr9/Rwo9vxfb2mRkS
 DNeNvD0hpJMJaT+nnq60lc5TJcP7Iv/YakS8XosoMNvu13dzSu0LrOe5YWv6kkK8VEoBA5gHcfj
 tf+mG2bFptvj7Z6sCjfkONfPSe3FDMT8Pzcu2qTHVKl0WmmcQ1rXFGuYFlkIb0L+aExtRwUzzo4
 UOLOdmnPsOyKWxDwTG7NxbT7ryzP5PdjYN02A8pg+p5fPVExzAMKqaJR74bicaMbNL+yLAUzeeJ
 Qdvf1XAOObDb6ftvw5Bh0jKlLorh6wRY7+sJnokpHlgswERulKf6CcNyMY3q7BkoW4MUjYHoC2M X7XHeWzYBiFCDZQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Fangrui Song <maskray@google.com>
Cc: linux-perf-users@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/perf/util/dso.c                    | 2 +-
 tools/perf/util/unwind-libdw.c           | 2 +-
 tools/perf/util/unwind-libunwind-local.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
index 22fd5fa806ed..470a86f1cdfd 100644
--- a/tools/perf/util/dso.c
+++ b/tools/perf/util/dso.c
@@ -1122,7 +1122,7 @@ static ssize_t data_read_write_offset(struct dso *dso, struct machine *machine,
 	if (offset > dso->data.file_size)
 		return -1;
 
-	if (offset + size < offset)
+	if (add_would_overflow(offset, size))
 		return -1;
 
 	return cached_io(dso, machine, offset, data, size, out);
diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 6013335a8dae..45a89cbb2c8d 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -198,7 +198,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	end = start + stack->size;
 
 	/* Check overflow. */
-	if (addr + sizeof(Dwarf_Word) < addr)
+	if (add_would_overflow(addr, sizeof(Dwarf_Word)))
 		return false;
 
 	if (addr < start || addr + sizeof(Dwarf_Word) > end) {
diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
index dac536e28360..ac71cc7f53b9 100644
--- a/tools/perf/util/unwind-libunwind-local.c
+++ b/tools/perf/util/unwind-libunwind-local.c
@@ -587,7 +587,7 @@ static int access_mem(unw_addr_space_t __maybe_unused as,
 	end = start + stack->size;
 
 	/* Check overflow. */
-	if (addr + sizeof(unw_word_t) < addr)
+	if (add_would_overflow(addr, sizeof(unw_word_t)))
 		return -EINVAL;
 
 	if (addr < start || addr + sizeof(unw_word_t) >= end) {
-- 
2.34.1

