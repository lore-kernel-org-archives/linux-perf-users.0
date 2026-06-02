Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5E31E845
	for <linux-perf-users@vger.kernel.org>; Tue,  2 Jun 2026 07:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780385511; cv=none; b=K8LFQrM+TkDieezU/XDiKpdKBXDSpmW3weETWaSKwh6sF3aPsZJKaZ75F0k+CtOCR5X+Y57L12zltXf0h+3qbUx/s4CQ60srLCD5VUpajVK4rG9ggMbXhBHfj5bu6dw4Lo7X+em93iUrUWPER7rwSEU9GH4vmmw0be0z5pRIRTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780385511; c=relaxed/simple;
	bh=64S2aayJ99hXOemnhzucwrwM0vOILIeQ2ZILfYR6sJU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DbSF/1vSXU52aX+BVSgMHPk3PI6rVP9rWywbLJ0hqp2V/tLGt5NgFRSJDPwHDldHp8t5ed6Cf31vhcicICjJ6wYdXyMP5LJ3AIUg3vsawZDco3tZNcZSWTF4SseNnHLZ93u6zafYZduM3fOjtBKPUUrTIX6r2R1SvRM2fjG/tCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mhEvFuE9; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mhEvFuE9"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304b8d0ee63so9008000eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 02 Jun 2026 00:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780385507; x=1780990307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=inYIMUya0beoL7FJV5FWOzzAQLvU+uxd6nfrd81kpuo=;
        b=mhEvFuE9lPk2mznxqC3TwPVJUr6G0xA7wvrCSkc9bz0WBPAkyDrfKzVuJf55jc96+A
         5MNws5exXAQvtP5Co8dF33G1ymbf0OSO06zdv0qG1CxB91F5uUm55ZLv5+xAVdyIj9Wd
         MT+W2J7CC0kDqtTpbcawYZwpZHtkHD6bgKVfXzpU9eXZ55T/0zIas0iTgwItYQvb8T5W
         7IJL42iIKWI3nJWr8r5sHXya2QGU/JmThj+R4//fwSC9NYfOLtZRagBo643wkoyIegPa
         m9RDP2ZtyIvwsrptu4+unZYvaPTqOUPA6taGGQ1y0A4VbttKMsERCyPEbgdPfFFOnHRt
         7auw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780385507; x=1780990307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=inYIMUya0beoL7FJV5FWOzzAQLvU+uxd6nfrd81kpuo=;
        b=VZnZhepfPyfozMQ+xzZWnyWVpdmozEirpg6EzKxIC3YBEVIuRC82SKfSnTinHyDKTA
         ZfK/tv/3gWryUSWTE5wJGxSKDizolqNOe+dQV2zpqHR9UnfcUrdjmmOStcx1NsWfO4f3
         JNm8wQ/rXyHQZWfRKyObR+T4V0NvbbnIxoJXb2FE+faCsORkS/92VuXOrqp6z6TJza+O
         jmmFA2VVsedn215le52SikkzCIU4AKF4tUvF+3l5wsQMhIQIe2GTfIwlFRBL00Z6QRxt
         2N0S5InLgxsnZkUAH1U0eTpNSSzyqSGdEQv38Aa8agQ5TiYQyH6gaY7mR7VfB173B8Pr
         atPw==
X-Forwarded-Encrypted: i=1; AFNElJ+rsfqwRzo/G9cRnE4ZwIgPQb4bm75jiTnPWL4l0FJ1D8VTCiIFfJy5qJOV+KNJzZn2kX5wz5kYpnT2rbV0w8le@vger.kernel.org
X-Gm-Message-State: AOJu0YwkpZR+lCAzDAWIjlReeGgLhMH2Y1FSxRJl32CYHoCL7bBvcQAa
	Kiq6YWWXf3olIV/mu5YZoZ7/9TXyuT9xUktE18TVoZxMfxg6N8BvFDnygjIjeXity1S+2AhAcD3
	+h41EjEwkhQ==
X-Received: from dybtx1.prod.google.com ([2002:a05:7300:f281:b0:304:dc92:9a62])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:a44c:b0:2da:a813:a5fd
 with SMTP id 5a478bee46e88-304fa5a7ac4mr6717364eec.22.1780385506875; Tue, 02
 Jun 2026 00:31:46 -0700 (PDT)
Date: Tue,  2 Jun 2026 00:31:19 -0700
In-Reply-To: <20260602073132.2653307-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260601061401.1541457-1-irogers@google.com> <20260602073132.2653307-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.929.g9b7fa37559-goog
Message-ID: <20260602073132.2653307-5-irogers@google.com>
Subject: [PATCH v7] perf test: Drain pipe after child finishes to avoid losing output
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
2.54.0.929.g9b7fa37559-goog

