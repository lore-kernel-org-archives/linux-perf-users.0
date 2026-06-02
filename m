Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2693437474A
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 17:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422113; cv=none; b=AmVrKtp+oOIaaQ/xC78x7usL1sdD2G8tlerzKWhtvlDaaF48E8ovm1JJpkhWfqc/WfGiL9xdM8Z97zWyUFsiSchdq6DbHvswlpELPAIfASajhyylUBKpbXHpX6jSsRvbHGxuVUHoG9H7+za6Fq8MGDHqB4XcPmzcOSJG1k7DRXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422113; c=relaxed/simple;
	bh=8Cp6tfqGWTFhWExeGsYxcou9jCkjuY/pbSu35xpSeIQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c2ENhUf0dSqGi1QTiW4vNqUFVkDG9u/7qWG9lbjvEoeHiaMbb6HfMYYZcwI70MgQhnFRygsxtVaHX0FKTNwnlFrsywbSzc0WH45SLuljJ2ht8gLJc26xy/ysNchklIaoLsrhfRVXdhEAL6dVTrL1ggBU2q6x7NU/F/kHl6/jHY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CWIA9pCB; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CWIA9pCB"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-304ec73b015so6934807eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780422111; x=1781026911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uRh7YrUtUvZHSOndotqK3qCSXixoQsmQcwU8hrUEz+U=;
        b=CWIA9pCBE6IAXLzONZoRfNNRbP/aKA+o6A2tk9URhA4JLqkGwqRKkeI1Ot2HEyjRWb
         4ZlGiE30gzOPGbiRRi67761hH4jsUuKxfeOiQ0lwW/0d6wRPluTIAFS4hH3CsnDraXN7
         2vBw+Yd4tGDxgeFpyJwShOOW+DVrHbJ6hgKD0a1twHoAmG+fRbQY2ec2ufzDnn1QiBT4
         CcdVXRY51CIcnVBL3TdBuIBJk+6dcwXplY+ycWrzZSIZwFxF+sUjwo7zkot6VvgRd5CV
         PeCUoPzhZR1Lh3e8GQfYPkMk5YNSd5xD8ENsqePtqyZ6hyTcOmwCsB14+xdgAfuZRzaK
         WLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780422111; x=1781026911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRh7YrUtUvZHSOndotqK3qCSXixoQsmQcwU8hrUEz+U=;
        b=ARsIsG4h9wVzzKhwzkHMl3xbq5iYutvdGFr8o6/Zk8g55qdTjYjR9VU1RmTroyVLKR
         R+jRmLpUaSmDsjgbPwyd2M6izJAhSkbvjPUhQcduNGEWjgBd0mkN7ZOvGu3gJ1vtNAHN
         trZNX7b80VW6Mb5srdvq+X6kLf6WmA+M8V0j+vnHusMK6ShMcUxiP7NN2vd+Nm9Z0QxO
         XVtOhW2F2slr6FFwz5P16KphpvQ8xhTrAHNPz/qjGg75CtyimiJOSN7pgWwW83paq/TD
         CUQ/djPzLC7wN0FkGedgXVIHhtx/NXYop3UYtdZndpTenaerHs48BLlEgwk8zf5e2V/U
         QFEA==
X-Forwarded-Encrypted: i=1; AFNElJ/FlsyeTFdVA2ruAoLTyoBL+3rNa1tEUz9jJWRVRmofTlsyo57UmFXLFfk9Zy5wEjaVZWXn9bslkjU2EbUXdskO@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZYUgIgkhasoOGoNYvyC9gaQGT3SgWOduNr09KygnwnZq7bSe
	rdoGI6tblkxluJZkbVHkiMxLk0uYGb8HeO0em9SlfYenYgu4Js+XLxDUgLy18Jj6Zdq9unKSreI
	snVnII/fVKw==
X-Received: from dybpe6.prod.google.com ([2002:a05:7301:4586:b0:2ee:2c3a:8aaf])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:ef83:b0:2c5:b972:b436
 with SMTP id 5a478bee46e88-304fa647572mr7578431eec.23.1780422110916; Tue, 02
 Jun 2026 10:41:50 -0700 (PDT)
Date: Tue,  2 Jun 2026 10:41:15 -0700
In-Reply-To: <20260602174129.3192312-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260602073132.2653307-1-irogers@google.com> <20260602174129.3192312-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1013.g208068f2d8-goog
Message-ID: <20260602174129.3192312-5-irogers@google.com>
Subject: [PATCH v8 04/18] perf test: Drain pipe after child finishes to avoid
 losing output
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, alexander.shishkin@linux.intel.com, 
	james.clark@linaro.org, jolsa@kernel.org, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

When running tests in parallel, the parent process reads output from the
child's pipe. However, it might exit the loop as soon as the child is
detected as finished, potentially missing data that arrived in the pipe
just after the last poll or before the loop terminated.

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
2.54.0.1013.g208068f2d8-goog

