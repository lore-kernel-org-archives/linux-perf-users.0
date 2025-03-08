Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0781632F2
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Mar 2025 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741393961; cv=none; b=q7t4zqO8BvgtpMhgMXG49lgaGuvcSA0L6+JQ1kmXajufTRF5sMoAuwjjKp11fwOL915oZ4AbPYeqN3xTBgojLnb0QmKcxt3w2STp0VGlnku5vlc0Tfc45gs9gjEihIboIM4jY0yIOitPYvsx53FiOtLPYcphsWr+tfAxiGYTkv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741393961; c=relaxed/simple;
	bh=UEng1UvNcxBEzMZu5jvHA5kePc7WHOW16EAvxAQg2lE=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=qPE6l3mrbtZD3XQxkQur6ev19L+05b02xH+/QJifw9y8Fc02aTihYU5N+dWnG3kLio0LZRf0/WNVhpTz3cHF274kw3ulquMUoVmLuyp+uIBaV/NSuPgbz42bleuZOnf1UbnvzI7exP1Im2qj/g+3nqRCvPqa8gK/syhZWHRXlkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GmJIw2Yy; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GmJIw2Yy"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6fd43b37dc3so35425647b3.3
        for <linux-perf-users@vger.kernel.org>; Fri, 07 Mar 2025 16:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741393958; x=1741998758; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aBag0ZTpgw2jBnuqcdEe2ctv9zQnS+6XrNEn3QpM0IU=;
        b=GmJIw2YyeBFsPoRpSIaVT0gjQKdKHea+7u5LlD8scSty83ZvGEAwXyf1phUmrkcpMJ
         0rLKKeBTJd9SSzRNH6C3ijPhxYhUlALJhy6QfnW3f+2GaiT/xyW0eYkI47r9+Wqy0uSM
         pANRMszXymrgX1UPKFhhAceSaF/gKYOgScPuj/EOI+rTd/WTLjWKcGwjU1i+iB3sC0eO
         Lkz1XUI49T6TmfZuRkZmBayKvYk+M1VyZOGVG7bIFkN3HjTUz78UAMPtNCQLMQ7AjzRX
         QxLBxq6DBmvAiJSBG9gWvTzQjtZFDtK6T7A+h0l5VnedxvUwC5/zLujR+X3ZB8lUCYhE
         EUKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741393958; x=1741998758;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aBag0ZTpgw2jBnuqcdEe2ctv9zQnS+6XrNEn3QpM0IU=;
        b=R5mS6xPLaN5r4//6aSRBlTvUcI6RiNB9O6IPLoApZhZZ+boHVFs3eYAvAC1TlOHixu
         Uj+fzTFlrtsnrwWh/6U6TLhhcjIqFPTrVjBq4kmDwZQARzfEWd1j4obBi5pgDpPDCpj5
         c6Rc8trqjFYmCP/Xqhwb/iNJUQSXDjEenA9zhcs9YOnotQNzyof2LslaVnTXuacwcCxS
         udN22sZxN50AYvDjoTBkxRRqDwuxAzlOkTW9iEL31CRu0IbMfIWG03+FAj4/mXp+LVD5
         HACxeLXqtINw+qTUnGemHgwddiGnRUODEBTz1Z+QC2zCSy7WsM6/Qj/XKhDDphcHMT4v
         tHag==
X-Forwarded-Encrypted: i=1; AJvYcCUGLwnjnUGuD08Q9p3WVLp18mkMq4Jve2eUSOALxKshLCMQK0i1U6J5CGj+m9mrm5/p44+q+I6YM6dPwtZOIj/Z@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd3JpEdjvE/sp5p40jS2ue5Wd3slqJZDK7XLYfAyVT4uIfUN5V
	KA6slmIV321EZPuEnRA53vukM6T912AD/gcY8nfqVSJVT/13GfMilOtbffCVro8kDlKcuUE7Axo
	KYLfGxQ==
X-Google-Smtp-Source: AGHT+IGhJSVrXcuIauCCTdcdrck6v986JR4xLPN3EKMbWJDNglYuGen8NURA01YPhhzdv9BlJdEWKZRc9pFA
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:1541:e490:aa80:5766])
 (user=irogers job=sendgmr) by 2002:a05:690c:2901:b0:6eb:ac7:b4bc with SMTP id
 00721157ae682-6febf2a661cmr5088337b3.2.1741393957696; Fri, 07 Mar 2025
 16:32:37 -0800 (PST)
Date: Fri,  7 Mar 2025 16:32:09 -0800
In-Reply-To: <20250308003209.234114-1-irogers@google.com>
Message-Id: <20250308003209.234114-12-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250308003209.234114-1-irogers@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v5 11/11] perf syscalltbl: Mask off ABI type for MIPS system calls
From: Ian Rogers <irogers@google.com>
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	John Garry <john.g.garry@oracle.com>, Will Deacon <will@kernel.org>, 
	James Clark <james.clark@linaro.org>, Mike Leach <mike.leach@linaro.org>, 
	Leo Yan <leo.yan@linux.dev>, guoren <guoren@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Charlie Jenkins <charlie@rivosinc.com>, 
	Bibo Mao <maobibo@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@rivosinc.com>, Howard Chu <howardchu95@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, linux-riscv@lists.infradead.org, 
	Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

Arnd Bergmann described that MIPS system calls don't necessarily start
from 0 as an ABI prefix is applied:
https://lore.kernel.org/lkml/8ed7dfb2-1e4d-4aa4-a04b-0397a89365d1@app.fastmail.com/
When decoding the "id" (aka system call number) for MIPS ignore values
greater-than 1000.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/syscalltbl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/syscalltbl.c b/tools/perf/util/syscalltbl.c
index db0d2b81aed1..ace66e69c1bc 100644
--- a/tools/perf/util/syscalltbl.c
+++ b/tools/perf/util/syscalltbl.c
@@ -46,6 +46,14 @@ const char *syscalltbl__name(int e_machine, int id)
 {
 	const struct syscalltbl *table = find_table(e_machine);
 
+	if (e_machine == EM_MIPS && id > 1000) {
+		/*
+		 * MIPS may encode the N32/64/O32 type in the high part of
+		 * syscall number. Mask this off if present. See the values of
+		 * __NR_N32_Linux, __NR_64_Linux, __NR_O32_Linux and __NR_Linux.
+		 */
+		id = id % 1000;
+	}
 	if (table && id >= 0 && id < table->num_to_name_len)
 		return table->num_to_name[id];
 	return NULL;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

