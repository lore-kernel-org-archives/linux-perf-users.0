Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C069D4F5E0
	for <linux-perf-users@vger.kernel.org>; Sun, 31 May 2026 06:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209477; cv=none; b=rsJ8jXjt3FdpEG4olIB4biCxWcN79J+56wMr2HeElBc2gLv5HqjmDTApOjnmG7u2SiifeJPDCBcII+GuwEuOlQ7sjGEmJ8Q5KqAHO7dCcOccLHh6ny4VnrYglv578JMQwkpFBo/7oUa7T+qA8YGs3sbA0jAlll1N/NUfTc75tYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209477; c=relaxed/simple;
	bh=/azyC5haL/dW3FyM5Jqt2igHjHSKZJUmmyQs5uzvvOk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aNcGxa5dGWV6KcWxxEW2ny8xnx3RcRegTCZR+NTIAbdBeppBbtJ/scTpc3jNygJXhDSFlWjOATcyMv5NAh+C4G3tpOVhrV5/LzCMNktC+5m62+vbLW8ddP4w2/WPBo1vhsDEiiUrpVJdzKo0nB13wr07m+lmrbt5SiTXdupOnBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ILbUJg3O; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ILbUJg3O"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-137dd5171feso443645c88.1
        for <linux-perf-users@vger.kernel.org>; Sat, 30 May 2026 23:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780209475; x=1780814275; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=ILbUJg3OFxppkKSMHSVwneTsuSS6+Rk6YzMqnEEZRyt9IyqWQQ/86ABpQQmZmt3I2Y
         gNoeVIv7OhnQoZnPL6m6EMGLEuelODUoZPOVQgXvP571GkHXiYT4D7mHIySbaCwS3bBp
         YmjBgcFBdOdKTmsMa0Rva29TV+8ma5GP71RmS/2zTsqvwhpcoKYrr6XxTtYoZd8YjZYK
         yecusTRu+qsxtHld2fb8Jkw+nd4PqNNmsana1Rqezf33xyGxjLgG8pN5HiZ6KjEETM7g
         3rH5Luvma+KUYiXVDGs7S8yU05Nq3kyG7s6jiXPacTz2H6q78STUa24iYMfuJFFuw63l
         T7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209475; x=1780814275;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+GhNtvHRszsHjww/0M7hnUe+VTtWAqYrR6ygiuNBHE=;
        b=Qz6rUMuzkD3sh8f+IUnYxBTl+0m8hOeG8zp4tCLhXXxF3fqSKXLtjqm+7qapITAjCN
         pnFQbEGlHu8FGGl8xGcyxDdLOlQ1a4sJ0ugw1q1yIF6Xh57oxKk/DRV++f7BIMYjSf4L
         dI/1bjYPHTChY8JB5Vxim1YSAwzwXhwXo+LYewQ7oJv+7v09R1J72PUKKx72YGR84eAf
         /rJttwUfS14U0YUWo5khgW0oK5Mi0A3Gr78rDQwT6GgyspeFKW7OaHO1qWCXWkFsY8Tp
         hD6VTHND5ds+ClHFGcfGkFzy6Z0tyMtZQakiVmtC6obimLkSqxdtTrI0m84tleqW11Yo
         KuVA==
X-Forwarded-Encrypted: i=1; AFNElJ/g7uLIbUsHUqj2QEHaEJgNPBzNmM0wvyG7aEnhLNZNj5Bta0ScVHNvQ7sW+cBx4ohPhRM6TiKioDpaE3fE32BC@vger.kernel.org
X-Gm-Message-State: AOJu0YyddzyBDvVvoeT/hlCRuBpNYizrRax2k4db4NvQHS0SN5OGGhaU
	YMDvjCtArji56LZlFxtDZxFcGFrPSv4Rq1Gz7INMPPGSSY+ryu9/2ZQf3LY79yk/A9GBXKWYnA4
	ehFriBwKBag==
X-Received: from dlam17-n2.prod.google.com ([2002:a05:701b:2091:20b0:12a:7dc7:7b04])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2513:b0:12d:ca31:f1b6
 with SMTP id a92af1059eb24-137d423c4c5mr2444341c88.18.1780209474748; Sat, 30
 May 2026 23:37:54 -0700 (PDT)
Date: Sat, 30 May 2026 23:37:25 -0700
In-Reply-To: <20260531063736.871777-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260531052740.796087-1-irogers@google.com> <20260531063736.871777-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531063736.871777-4-irogers@google.com>
Subject: [PATCH v3 03/14] perf test: Drain pipe after child finishes to avoid
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

