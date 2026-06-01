Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D9345731
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Jun 2026 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780294496; cv=none; b=d4uaBdJdh+G+5UAxGWtxiPFiA9Nn0NssZPyv0fnrcN7Inb7OlLt/zgcQEH1Tb9qgrArgK7sk4ZSVYVe7QMwd1K3ObyTXq/UEyeXP1+JPGOu4eE0n20qDY0DbFrnW20my7mddxPoRY2ohsq+GfHFRcNgo7CRbb+xhZVDNZmTcpns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780294496; c=relaxed/simple;
	bh=/azyC5haL/dW3FyM5Jqt2igHjHSKZJUmmyQs5uzvvOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RiKRfpitKqnlw2TixYaBtDLYP9YUE5yJtIez6siyT/8k811lTvWJ0iMaSzksJGm4b1qb5PGX0UVxT2yAIduQon58cUhdT0qK51Dtf1/gc1Lf/7opRQXMZ5ZzXVMjm2xp7Q6/6uqfZENhp5C9/VAHyMZm9wSPIyYuWJnT2Y4T/50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YavIPaDC; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YavIPaDC"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1353bfdbf99so2143258c88.0
        for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 23:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780294494; x=1780899294; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=YavIPaDCXFU0t9IwESNwccnsYS/UzGF9/xX/7FhuzsbA2QCq8nLTmsQ3L2AaAMI/h+
         eRGcKoNDUHE7ws91kxCM1yivYLbB2eb0WpK6tFfppeYVNsfi8SfYfT8mZ58pq3B1jfEx
         YRgeYYq9yIAf5UfaQKJGfMB31qnyX0aY6Vn1ye7qMhU/CRlInu3Rcw4tIZNlYIfPMqTC
         UZCEgQelQvLwMkELw/VsYzGzuNgFn9lcQkNUQL6/wjwJuLh2zeJfVltyJPcACIP6HTlt
         65Y80ucIjr4bFqX3Zalp9jPY7p/1KUKNOdL0B1Js5camF8bu+xVOrCtqSFreuLbCIYwK
         h0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780294494; x=1780899294;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=gWQOQkh99mGVC67tIYGkMsDGfVm/QtopDJzqUDerF/WrJrcwzIn6FVpx2P95IBQuF0
         9TKaEMVRlUX0ESBLNtLED8sf82TaYztsAE/JOlyuXMU4nwi/djhe5HeUcH/rqj+Rn3fY
         wouWzqAlIWvDEcw4wnqFotaaDaCcI90E0GwYsN19R2/DUsLWqhVDAA0Dg4cMYUEKOEXc
         hRW1v6vXuiYyMgF6iP1NoI8TphgTXTvesMvANE/2Um1wiqnG570f2/hAIjtt2J1gZ+fl
         DlYyl9k7MlQJkSbj+cUO2BIL9NjNPMjZnVRZ+IpWK2Ed55vt+mYBPlqdX3NdpWJhOGY4
         Efcg==
X-Forwarded-Encrypted: i=1; AFNElJ/ez87xxH+Qef0slzKqHgLuSkcVyfM3rZ4Tw6CcaZ3QSvYjZDtq0gHGQFtaDFLbDxtqtQ67yStstW39/uWVrxOH@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw70G8CKzLXhw5yCC4F9ULZ+nnL8izLRPc2F95AfGlFhdDh6Ln
	oxpBFVApnLgDU7XWj/OQKemz1D0EpDFO/UphV9V5er31qHmNbTrh4jWhtoonoUxWcC95wtIce88
	bHF8oUsrMKQ==
X-Received: from dlbvs5.prod.google.com ([2002:a05:7022:3f05:b0:135:66d8:351c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1e0a:b0:137:ea56:361
 with SMTP id a92af1059eb24-137ea5606a2mr61150c88.30.1780294494213; Sun, 31
 May 2026 23:14:54 -0700 (PDT)
Date: Sun, 31 May 2026 23:13:49 -0700
In-Reply-To: <20260601061401.1541457-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601000548.1195604-1-irogers@google.com> <20260601061401.1541457-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260601061401.1541457-4-irogers@google.com>
Subject: [PATCH 03/15] perf test: Drain pipe after child finishes to avoid
 losing output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, adrian.hunter@intel.com, 
	namhyung@kernel.org
Cc: alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel, the parent process reads output from
the child's pipe. However, it might exit the loop as soon as the
child is detected as finished, potentially missing data that arrived
in the pipe just after the last poll or before the loop terminated.

Address this by draining the pipe after the main loop in finish_test.

Assisted-by: Gemini-CLI:Google Gemini 3
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index f2c135891477..7946878195b7 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -483,6 +483,16 @@ static void finish_test(struct child_test **child_tests, int running_test, int c
 		if (err_done)
 			err_done = check_if_command_finished(&child_test->process);
 	}
+	/* Drain any remaining data from the pipe. */
+	if (err > 0) {
+		char buf[512];
+		ssize_t len;
+
+		while ((len = read(err, buf, sizeof(buf) - 1)) > 0) {
+			buf[len] = '\0';
+			strbuf_addstr(&err_output, buf);
+		}
+	}
 	if (perf_use_color_default && last_running != -1) {
 		/* Erase "Running (.. active)" line printed before poll/sleep. */
 		fprintf(debug_file(), PERF_COLOR_DELETE_LINE);
-- 
2.54.0.823.g6e5bcc1fc9-goog

