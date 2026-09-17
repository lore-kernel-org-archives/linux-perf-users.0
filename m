Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861843D4E0
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789627391; cv=none; b=kTkjOmArBGNV7i8pLpG7ZFSMBSnkVaV50YpV/lIAHFb7qK/e5s+NyJ1DPDx2LlSVqkz/0OiPWRx1WgY+vuzalukL8x4zEvzaxhLFie313OxxbyBClvT//h8hnNvk0/p7nX/Q1EVUklMhL3JtQ518U41zmvoYpWUhjA03eWrn0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789627391; c=relaxed/simple;
	bh=P+avWqg0YJ5z30ktLMdV7Tr+I207Djb9tMMIgwKH6dY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U95UyWuPreU7Hp7EYoOhGE8QvWtvFeQY4uFBT2a8pKphUdQaj9sjza1FpidkD5o+vpj9QyYHq3bRjokX0zJq9KwW9/+gvX0LD17W2BwdJ65a65JtRNrJ32I7jftTVPOp3oIui8GMROM9q+FuZKqVzriAr7WdTmeJFvLlFlymycM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUTVsA9R; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUTVsA9R"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so828509a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 23:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789627386; x=1790232186; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SxRrlx2WvAT37qZTLQX7yxCGnnR8nCXcvNsM0kQ33yc=;
        b=nUTVsA9R+E81pBlr2gl971MNdsIh1jAELoaCeleqB9N+HlsZnOxnOg6BI9ml8j6cpF
         IUK5SaQaSNp8nGTV+glAsGukXt7PLOAtOQA+eRy4NTVv+wnkOdw6YsNHtqcypwncudAg
         2xQpq/zmGHzk6VSZZIZkwqvVJnQXW4Ty0nV0laCU5v/U/x9ir3E0c8vbEkla/qbR1ZXK
         Vt8Nzw0MOEpgumJIvi15C7r/ir4LWE/VdQCuMEv/IQc7EYRuxOq2RG38A0/qW51vqwTf
         0su4dzs415ioRPG+4CZqLqNQGJvJSPwbkESQYvXdA3jr15xet5meGdKcQ6LJOrwE7xpL
         pIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789627386; x=1790232186;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SxRrlx2WvAT37qZTLQX7yxCGnnR8nCXcvNsM0kQ33yc=;
        b=rzTLtbIc9xJCvAdF138CQuCph7HpedtXixmG2TfM0wI5mwV4Y1I89EsuKtbs8XZ6tP
         57F5E+gWsSseFAK94Shge75GSF279jRkZdoB00ApBXyhXQsIbiA0duK1Pk6ZULNgsXAK
         NfjdBMksBTZ+hcSnZjNL4gvLiZpMoTs1NDdRxaxY9cxrlfzirRj/fogw0AsyZc8W5Tfn
         98oP7g78U0jLKS14glKznstXGjUfqNSjbzR+fmbzup+8atCeUIorVGN/a/6vIrNX3EJM
         yTa/ySzb0weFhcpVCEYXY7OyVFbO0UsJmHiIzR62mJsTy9B0H1wIaambGd3Thrz3EaaW
         4KfA==
X-Forwarded-Encrypted: i=1; AKwUvBxpoJ4PipPsjynvuLMHjuRh0bzurU/xqeO36XtcwqqcL/veiYodf2sVqi/0p6vZvoUQTkv1BAEwEpK8x7WCO1Lr@vger.kernel.org
X-Gm-Message-State: AFuF++ktX40Iez6bQfyF76Gi526cAwoo+ivsnXjeXs5FfBiigodYDdKR
	2r4jUu6lXUO8AQIDfgV0CcKRWy7aOvu2b8M0HO0ih0OUnKiz49ajuokmfYCBZe1lbyD3msJrgpT
	kjBC2onT61Q==
X-Received: from dloo5.prod.google.com ([2002:a05:7023:a45:b0:144:bba4:7daa])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:e7d2:b0:398:a145:5d3d
 with SMTP id 98e67ed59e1d1-39e1e2daa81mr14993947a91.6.1789627386022; Wed, 16
 Sep 2026 23:43:06 -0700 (PDT)
Date: Wed, 16 Sep 2026 23:42:32 -0700
In-Reply-To: <cover.1789626977.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789626977.git.irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <048255184fea635f244bc8af71c34339085150b7.1789626978.git.irogers@google.com>
Subject: [PATCH v1 10/13] perf test trace_summary: Improve error diagnostics
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

When pattern matching fails in test_perf_trace(), print the command
that failed along with the actual match count, the matching lines
found, and the first 15 lines of output to aid debugging.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index b80dea77cec6..f975176247b5 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -28,10 +28,14 @@ test_perf_trace() {
 
     count=$(grep -E -c -m 3 "${search}" ${OUTPUT})
     if [ "${count}" != "3" ]; then
-	echo "Error: cannot find enough pattern ${search} in the output"
-	cat ${OUTPUT}
-	rm -f ${OUTPUT}
-	exit 1
+        echo "Error: cannot find enough pattern ${search} (count=${count}) in output of:"
+        echo "Error:   perf trace ${args} -- ${workload}"
+        echo "Error: matched lines:"
+        grep -E "${search}" ${OUTPUT} || echo "none"
+        echo "Error: first 15 lines of output:"
+        head -n 15 ${OUTPUT}
+        rm -f ${OUTPUT}
+        exit 1
     fi
 }
 
-- 
2.55.0.1082.g2b9226bbc0-goog

