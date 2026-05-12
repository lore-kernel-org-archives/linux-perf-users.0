Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836B3BD64E
	for <linux-perf-users@vger.kernel.org>; Tue, 12 May 2026 05:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778564160; cv=none; b=UtcZS86NNjVsTuE+L9FfV6oJ4j4eQLeErZb/X8UZ62luLIToKt2Yubun40NaFoX7WChcsHIbY4DQnFMfXDQx9e2ddu03FTemrxxnLsQN2NtWZxSiAO1PGiDRUgViOIqsa+Wvkbenq6cXWBUIWRu1H1+WhAezct1ZpI7gjw1TY1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778564160; c=relaxed/simple;
	bh=OgiEHTDvlnjDwAnt8D7vN3GVVcgaWORi0mYYfrGwUPQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=S31S1qqNB9hDVzcNvXQNcQEjWNHcvnwA1e1HqmbcQGyaaXx77VLq0dri0WHMOZdhs9tc/54MdICQu2aEGPPRa2KS/wSk0rmUZ3cn3OCx2YXH6GDMS7V+ND7QkZAj4prEjbc0UPqTNhLxX6P26tr5Gu0s06F4CYew6vTrTYRRgHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USYTXy3M; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USYTXy3M"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2bda35eab74so4182312eec.0
        for <linux-perf-users@vger.kernel.org>; Mon, 11 May 2026 22:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778564154; x=1779168954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6KfIzB2u4c7CPeAYRPyQWtREqIUzywUqx09MBuzY/eE=;
        b=USYTXy3MhGJqCNzDj+x6N66V1R3na95Wye55Oi8sQtGR6Y/RbTO+xwJTfZb99aTja/
         zqWDMeCNxqX7BARZlcgSL+c52L6iVaAzw9L27IfIbqPzsS6RYjJ5Tj2yTLsk7tD6kd0C
         72+/nvbjJ1sPJ61yO8JpOT77qqCyZ0RHErFxkfEsdrD9AzLX6D1wZGkP5kW9FY9XbFls
         GMFI3hU0CgmW70IZC5N3RlGO1uXd0901ipNRet5v//bXvft6apGUbJaIuLn2NVfyO3Se
         oMf5dqfOScjuE842ld6349rpTjhBfNmM2TFwh/ksWUUU3sYlJcCHhJsjd4mWlDIAWms0
         0lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778564154; x=1779168954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6KfIzB2u4c7CPeAYRPyQWtREqIUzywUqx09MBuzY/eE=;
        b=GznRwww0etVx0vgoEx9AoA8n4mWYfYcVwi8Q8Z7BJ9gBRIu/doFCqpCvlh87/wlNqH
         t4lzCEXUeEC9nTcxSB0s5n2ZBsT8WgJw29jiRFLQazWgo7fsG020aDD775W2idErk6kz
         IFQhbd6tenTcdzw/6nAbq82Fm6iov12I9WjH3CZHk4/7IALJFoSK5hJ+XiyDyjYElAEf
         k44m/axuzL+5t6ng+jH3m4qrYxWH8imwzfBoETNG7wmFE/bnw+Va2m0ekBA/gr8vewLZ
         RZYZbyIDM1LOGA911/jqI0Jbc/3rv3UIxfMv6WWa/SZE4Mca6hQ3cbJD18E+MSqIyMAX
         6MHQ==
X-Forwarded-Encrypted: i=1; AFNElJ90oKrDXCB2cKlPupFqoSaB0jeuuu3FcNFKZVLAC0q6AafpjMRaLzHtQedAeHRhDK1FR09dW/OcTpB0Su3k2L1j@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ8tPyILrt2+g09sDXxNYEvKEWpes7q/wSMAfQW207pRLOr+dA
	Drxkftzq3YnF5nTvCI0qN6ZTboA1mWb70DUhpow/JFTX/Had7gYO85rb7HD+eDhA/38zkSNgWZi
	ePU6sW5u5tQ==
X-Received: from dyt2.prod.google.com ([2002:a05:693c:8082:b0:2f9:af7:503a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:687:b0:2c5:c532:1fe1
 with SMTP id 5a478bee46e88-2ff9362f9d6mr1342788eec.3.1778564153362; Mon, 11
 May 2026 22:35:53 -0700 (PDT)
Date: Mon, 11 May 2026 22:35:26 -0700
In-Reply-To: <20260512053539.3410189-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512053539.3410189-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260512053539.3410189-2-irogers@google.com>
Subject: [PATCH v1 01/14] bpftool build: Restrict feature tests during
 bootstrap compilation
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Dmitrii Dolgov <9erthalion6@gmail.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Yuzhuo Jing <yuzhuo@google.com>, 
	Leo Yan <leo.yan@arm.com>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Markus Mayer <mmayer@broadcom.com>, Collin Funk <collin.funk1@gmail.com>, 
	Howard Chu <howardchu95@gmail.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Ricky Ringler <ricky.ringler@proton.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When bpf_skel.mak executes 'make -C ../bpf/bpftool bootstrap', bpftool's
Makefile unconditionally evaluated feature checks for llvm, libcap, libbfd,
and disassembler libraries because the bootstrap target was not exempted.

Since the bootstrap bpftool strictly compiles minimal AST parsing and C
code generation logic without linking LLVM or disassembler libraries, these
feature check sub-makes are completely redundant.

Exempt the bootstrap target from non-essential feature tests to eliminate
unneeded sub-make fork overhead during Kbuild startup.

Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64..8f50bc163bb2 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -106,6 +106,10 @@ ifneq ($(SKIP_CRYPTO),1)
   CRYPTO_LIBS := -lcrypto
 endif
 
+ifeq ($(MAKECMDGOALS),bootstrap)
+FEATURE_TESTS := libelf-zstd
+FEATURE_DISPLAY :=
+else
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -122,6 +126,7 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+endif
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.54.0.563.g4f69b47b94-goog

