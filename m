Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD69313543
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 05:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780205272; cv=none; b=TW1/NqTw4TE2F3ZXq/q4f7q1B8XedzEOv7eB2LC1ul5BGozyVL8/c9oHzvT32g9ObHdeqjm9PQ2clah3RSLhTleicqF/3yo+Yhyd/PFaiPMHQDhz/GyoxpxO2ZfinWGYRIjuyXpRcRMx2f2Gk62LX5CwyuZnsfE5Mga9WCyu+WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780205272; c=relaxed/simple;
	bh=/azyC5haL/dW3FyM5Jqt2igHjHSKZJUmmyQs5uzvvOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ioyWAuVeKvEOmVAgEPGTsV2rt7vXGDZFj9i6ZEhp5ZZmQlwY0T9cZIKY7TsCXy/jTNghbu77RpP8ueOszcjNhKuykaANBPI86GncCDAGXGvArChcV9KFVg2f6mRAjajYisOWetIRcRaXGFdeQ0ITZngb2c+T4oGJFTxOlkRnAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N2tcYugM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N2tcYugM"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304e4636205so5940646eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 22:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780205270; x=1780810070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=N2tcYugM9gf7RDa0jMC/T17O8ads43nVPKrjtlI/DVjU+cS4xZRd9JIiSKXNIPKEjn
         HOL7LqeX28txSiLQEO+vFAuHXGy3Jkl4PEMWpjpQqEzbOBdSuFdR9Psn99OLOGIwDPx2
         HOl4LnTIhUWvTzjb9gnkTekL+7Pi9Gs3/cEyH1r5/ZakVuFsgZVoV4nVuduv1r60vqem
         MRkWaQiLEuQfynsNEVa41H/VVhFzXmqnYmVyD/2qfg8QDz38AxR7QQYWlQBaF5mTMlt6
         86FuNXltRsdgUymjvGsZa90n2DvCY9CTFYV1RpnfdieTy6y/jqaL9D+dWtrb7awYKseh
         DsyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780205270; x=1780810070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=qalULDMFc4WErcGTv4AQm3LKWMWABEDnK6W51+HejnZv3V/CSESshVOfs6mGR9hEVi
         tDtvlvZ6+c07bghkLkJaF90JZ+2zLeqtAmNgHd26m8KLbkpc7zXE/4ggeaHNoi0Ximfg
         S92e5XXERDycLWxEhshL/XwCpSHBaaTiA/iZgItpv+0pvMUiwIPAx1mmeHbzBg696QXx
         vkOmci7QO2J3fi+llq/IMfl6J42BEQyAq9XDwDrwMAdVcpiJ4sJvSprwkPr5Gouqn+GJ
         /3SJ+SWsLNazY3clU6lJQESb9fpRlpIP3ESA9i+u9zKmvnAcVTWEnjdm/AIhD1AKcISW
         /Uog==
X-Forwarded-Encrypted: i=1; AFNElJ/WCf3Ds7iCCXB2wSzmHt4X6Wepp/OFZMI815MJL2IPoHHe0X8EY7WkpTqJNZwEo44q3P4I4/f44/0QMTufBTmt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9uO69W3RYfp5hmsI0iTHR0dJDxvagPgzZdsOL40Qe92QPPB+r
	W0YJD0ndlm09A4SKrXCVPtEqptYclQ2u/FTEuWf+hlbC0a2MO27qyynY5TJPSJ4gyqVd+IYrn/7
	P3IPIyIJT5w==
X-Received: from dlee6.prod.google.com ([2002:a05:7022:6286:b0:135:7fdc:4c00])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:11f:b0:128:ce44:be8f
 with SMTP id a92af1059eb24-137d3c10cd3mr3154246c88.2.1780205270057; Sat, 30
 May 2026 22:27:50 -0700 (PDT)
Date: Sat, 30 May 2026 22:27:29 -0700
In-Reply-To: <20260531052740.796087-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260513230450.529380-1-irogers@google.com> <20260531052740.796087-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531052740.796087-4-irogers@google.com>
Subject: [PATCH v2 03/14] perf test: Drain pipe after child finishes to avoid
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

