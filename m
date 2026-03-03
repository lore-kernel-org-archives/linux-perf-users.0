Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D192FE074
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Mar 2026 23:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578854; cv=none; b=QcQfUX8WIpUVOnTMR6YuOA9zjpJx62cKuF7ycWK5xd4ySUleXwMC+EA2klV3Sg0o5coWwD/pTtidxdfupIFAnZ1E5yHi6Pw/OLSnqmlIu/uddtKcs3DuPVH2PxRdP0IX1YYNyJj/zmWQyBgJU+jmo50GQkvbgVry6Oo+z0F0L+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578854; c=relaxed/simple;
	bh=FnCAM1M4bmOhgdVpm/AhNaTkpp8rO9NC0C89NQYqFhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bL0I3ys/ao3g99dtjcI9bkZH39FIakres/a7jdi/eOAKMlCjwDeNY6NXMS0LyMKaFRNCNZE0773nOIvDxZIJbL+iHyqRMdFsv+qfh2hU03gKYTjndWnnK7XmPpyPZaIiBvJtK3cEQitcpbGmLiK1R0JDshy6g/DuDplSOFEgZNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lLDzFxRi; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--pcc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lLDzFxRi"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1279637cf55so106452909c88.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Mar 2026 15:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772578852; x=1773183652; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iyeIncQFxH1HTyb8/kfTMSd0Ur9Ybipusnwm7N3vzvc=;
        b=lLDzFxRieiIAfbH/LePeeFoMIclssvrArfi/kYDF46LihUeQNbbl20qidpryZqGv1U
         5DSzNajSelZcNECsot/FDEDhY5i4cQYDCArWymqbJHarVt9jbt5gFLw9oktpjuZIw88G
         iq3EHYT/UdlDw8TguZjhPb3limlLJGZXfdevleOG8o4ovKd+mCREj8ojLyOikHSa8NG6
         d/pZpZD9J8LDp76okOTrPhSwY4f5PXtWoDVraZA26qVlUwb0ZUIV0a9WpZK8ZyfaKEWe
         ZvMsJudj3hxEBiIRk3BNLAhRPWWR/zc4uqkO0c7x4mrf4w3XWr582iGznaWq1ArLGLfI
         sVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772578852; x=1773183652;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iyeIncQFxH1HTyb8/kfTMSd0Ur9Ybipusnwm7N3vzvc=;
        b=H2lAKTm+ZDn5+rp/sXuQoWgUsi0FiQG6pmBpwy8ET5NoCEThxPEYDFOZClrsEuR2dK
         9gLwD1JmZWBGUYs8EfJH1CUYpsw3W0jGA0B/Npld+NcWFMey2GHcj1RYGPVkh41QLIz1
         TgSVB/MEQQ6LN3N1cdEsQLLzihbUxAawa/z04Rpcu+FHAVoerxWXZt/gNlBuvOSvoMFn
         yVS1FpHzYR8z5EyuqpfgztD44fnyknVYwZJGa9ZyKiLHruxShYv8QE2VpJHpU2Vc5kvW
         0YEapLfoGkegoMDaUWuRobFbZKXDy4c0CavyHB6lTucm/SP+o5Z8+rJkYm4ulu27HBzV
         oZFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0hmzclxsVMmCi8owG1nuK5ujdVmebnyUlFr1yZo/MiC9jzMRk0TYO7YXAVg9zSU1/hmw3pcmDLBVw0QCZZwIw@vger.kernel.org
X-Gm-Message-State: AOJu0YwjtQ2ejAKf3AgKLLV8aUqlopj6YgM1g3QIcXG+ILXc2IWKSdYh
	G+b60g3XbnCaw5BofNfXInMr6QbaTmwWjlZNd7ib/uPdiNsPbgjMtKEbzyCrjEblQpZ/PA==
X-Received: from dlbsj2-n2.prod.google.com ([2002:a05:7022:f902:20b0:11d:cd2a:4c1b])
 (user=pcc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:fa5:b0:127:7893:b1de
 with SMTP id a92af1059eb24-1278fd5f760mr8720159c88.32.1772578851579; Tue, 03
 Mar 2026 15:00:51 -0800 (PST)
Date: Tue,  3 Mar 2026 15:00:42 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260303230043.2074593-1-pcc@google.com>
Subject: [PATCH] perf llvm: Clean up after a failed disassembly
From: Peter Collingbourne <pcc@google.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Collingbourne <pcc@google.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

An error returned from a failed backend will cause perf to call the next
backend. If the error happens mid-function, e.g. due to an unrecognized
instruction, we will end up with duplicated instructions in the output
unless the backend that failed deletes any instructions that it created
before failing. The capstone backend was already doing this but the LLVM
backend was not; fix it.

Link: https://linux-review.googlesource.com/id/I377eef3cd662ab98fbcd69e5004a259fa3d7aa06
Signed-off-by: Peter Collingbourne <pcc@google.com>
---
 tools/perf/util/llvm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/perf/util/llvm.c b/tools/perf/util/llvm.c
index 0d126d233c019..87fceae8488a7 100644
--- a/tools/perf/util/llvm.c
+++ b/tools/perf/util/llvm.c
@@ -261,6 +261,15 @@ int symbol__disassemble_llvm(const char *filename, struct symbol *sym,
 	ret = 0;
 
 err:
+	if (ret != 0) {
+		struct disasm_line *tmp;
+
+		list_for_each_entry_safe(dl, tmp, &notes->src->source,
+					 al.node) {
+			list_del(&dl->al.node);
+			disasm_line__free(dl);
+		}
+	}
 	LLVMDisasmDispose(disasm);
 	free(code_buf);
 	free(line_storage);
-- 
2.53.0.473.g4a7958ca14-goog

