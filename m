Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F81E39DB21
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 21:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769117761; cv=none; b=oZ0IbUa2yNDy17UuckrFAfQybovGDtbYG6eteKRaw+3AWz+PDTCtSvmncGUzoH8Kpt3U+iREzwNJ77sfwuotv+epuzeaiUNNvFOBWcQMC0kymlNdbTGYy9ekqpqrSvf/7GwcH6ZPrr3pzgjWy6yE2MRFqhARzHihPyhuP9LCzWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769117761; c=relaxed/simple;
	bh=DNIcWZ9QKgcap8GIm+HHaS7sytvjKF8lN4kZaGLyU7M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=iRJaRurDq2miYfat5l4+TWUw9uoyIdVtGs+2LrFonWXXIxGkz4foD/WK+0SK1Fvi7jXqSP6edsbrjjSA2Q1CFkNHuZ17yjvDpk4jsjtZ/opqzOkU1zfrMJapKvkRxjIJ5QFtL3Y/2t9TzFt2EbmcNbMYoBAh+MCbuXzClPMYQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wKWmKvYz; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wKWmKvYz"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b72a9a9715so4558164eec.1
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 13:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769117746; x=1769722546; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6zuXMW9ePaQZdk+//RX5ln7bDZ0bQbPZ3cyiYbZ9aMU=;
        b=wKWmKvYzy3/ctOsKHoZ2kONjlphKfLXMcsQbDkvqq0IffuJy0sKZsJ8X/3YiEOCSnj
         NEaGOx0tMtCnJAMGHU/6KXRhFcuBfKP5iuAMncm0hQGF7RGOYWGLQbZhlJjghPGAuFPA
         2Wj2fzdPdSyDw1K1t6po3kCUlNKH9bgPZKuXE2IHvR4oi90QGyEKGxgGCc7fDFidVorE
         VOMGdDCT4JSClpBN6C7zxKpUdhYN2Iq1E2ZdtQnW4jKVgIoy/3jynC/Bg6CUTDc6zmZJ
         TBvlSQ6aHP5D1wqMK+ADHcbW5kJ7HqL/7Kk6IY43Gmcus9jLqjMd5RR0nZbTgFudBzWH
         pwhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769117746; x=1769722546;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zuXMW9ePaQZdk+//RX5ln7bDZ0bQbPZ3cyiYbZ9aMU=;
        b=Od3lzshI24HOAttjJ+W/AlqYSg76/F5banPmIkvbnNL9EDLLkUmZjK1DV82Hg8oPbM
         /+Pq1MoxlznJItac7n66YOx9ViEXNEaTQ7PA5IlMoeFR7+TeyuA0UaRWdxNQRepETQ4a
         42qHq0FLPYb2yIaUUBX0HdVChXGhSLIiu28ItwI4pT0mqr2YyB7z1CZgCvrbqZdzd2Mx
         p/MnwIrTyiEDfNIrWMdMBMf5Jl5e1Mz4VS/tDk/EKWQVYxfk1ntZLjPRLjHmGGCrjeQU
         DSd10SgyPK1Yui0zmePP2bD5t7pLYG7dZmlSoTQKRgO8wpJ2M2TaACad5AoR37JodG1p
         7Sfg==
X-Forwarded-Encrypted: i=1; AJvYcCXw4ZuWO8sJ9LIqiQ4E4sR2DU+MXQIKtmbo9Rqy2vP2e2AX6o4jBq9C3WP3FTv4t6KdFdN5SdjA7VYDuwpe4r9R@vger.kernel.org
X-Gm-Message-State: AOJu0YyTDxHX/WfzXFJB70TS5Qt0a6iZkpa1zsFwf3vzpxKHh1Bmd7ys
	oWhtnwUedFAgFXZ5JM2/2AAYtMfa7h2OshWc0GurdGAUxgNLS3vVEwRS5lEIkDCOqSGr+HoS1A3
	fopJPjq3Ddw==
X-Received: from dlzz28.prod.google.com ([2002:a05:7022:49c:b0:123:360b:d5f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6981:b0:11a:4ffb:9825
 with SMTP id a92af1059eb24-1247dbad26bmr458271c88.6.1769117746365; Thu, 22
 Jan 2026 13:35:46 -0800 (PST)
Date: Thu, 22 Jan 2026 13:35:16 -0800
In-Reply-To: <20260122213516.671089-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260122213516.671089-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122213516.671089-13-irogers@google.com>
Subject: [PATCH v3 12/12] perf disasm: Minor layout tweaks for struct arch
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, John Garry <john.g.garry@oracle.com>, 
	Will Deacon <will@kernel.org>, Leo Yan <leo.yan@linux.dev>, Guo Ren <guoren@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Zecheng Li <zecheng@google.com>, 
	Tianyou Li <tianyou.li@intel.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, Suchit Karunakaran <suchitkarunakaran@gmail.com>, 
	Athira Rajeev <atrajeev@linux.ibm.com>, Aditya Bodkhe <aditya.b1@linux.ibm.com>, 
	Howard Chu <howardchu95@gmail.com>, 
	"=?UTF-8?q?Krzysztof=20=C5=81opatowski?=" <krzysztof.m.lopatowski@gmail.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Shimin Guo <shimin.guo@skydio.com>, 
	Sergei Trofimovich <slyich@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

Pack some holes to bring down the overall struct size from 96 to 88
bytes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/disasm.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/disasm.h b/tools/perf/util/disasm.h
index 2793d48aa04e..6a1905f9d4fc 100644
--- a/tools/perf/util/disasm.h
+++ b/tools/perf/util/disasm.h
@@ -18,22 +18,22 @@ struct type_state;
 struct disasm_line;
 
 struct e_machine_and_e_flags {
-	uint16_t e_machine;
 	uint32_t e_flags;
+	uint16_t e_machine;
 };
 
 struct arch {
-	/** @id: ELF machine and flags associated with arch. */
-	struct e_machine_and_e_flags id;
 	/** @name: name such as "x86" or "powerpc". */
 	const char		*name;
 	const struct ins	*instructions;
 	size_t			nr_instructions;
 	size_t			nr_instructions_allocated;
-	bool			sorted_instructions;
 	const char		*insn_suffix;
 	unsigned int		model;
 	unsigned int		family;
+	/** @id: ELF machine and flags associated with arch. */
+	struct e_machine_and_e_flags id;
+	bool			sorted_instructions;
 	struct		{
 		char comment_char;
 		char skip_functions_char;
-- 
2.52.0.457.g6b5491de43-goog

