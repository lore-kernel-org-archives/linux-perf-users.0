Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2CC47DFB9
	for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 16:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781628536; cv=none; b=Bpvljk/r8Iek6R8rAYmgLo9lOr3l8/U/FC27hIi58Uek33Sy+OgWJm3YqaDyEUDRA4q9z2DMdSbdsBCv/PCPGHx+ACwZl0EXtwT6iUiWUoy8aNxCmd8TdxeN+TEOn1Rc3JSuVQLnuPWarqcmSPHMSnQrnP/98lj7mTokLLwM0eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781628536; c=relaxed/simple;
	bh=becZPqflAesR2kXzSHypKcnASO0+GLGZhEyXtyFZGHA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p96re2hPr79415IyRp8emNYOuvGQ8767UkF8DCyAZv+88ao1IRIEkZP0Ht87F32NtdlEJAtN8MjrdqvmytQxujscDteBil9ZOjM7bpLM1rGqI5ovgDroZ6WzhJGXuYwbdRlxa0mxG4v0tfYjqrgTFEZePAuU8qUxCUFuHDCVJM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BO9urdtK; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BO9urdtK"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-30bc7296c59so295104eec.1
        for <linux-perf-users@vger.kernel.org>; Tue, 16 Jun 2026 09:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781628534; x=1782233334; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fAunF619cmpnVWUmxEBR8sBIH6wNNPRFerb4qiyheLI=;
        b=BO9urdtKV710DVXQ9lVovixflkiuG1Glzovh71JWWd5dimtg8Qw3J4rhgG+TRDjhTX
         FRvQF5wMfN6KRt8Jw3DOUV0sRB0HMHjwQaW9QJUegosQF1QhNiyRSc+md0Ln8I1EzSbv
         VEG3wXA9enhBPVGGD73y2UNxnHQLWNv9NFebGvPBmLWuivT9v+C+4oOnQSohwpsoqsU4
         L/o/JNosUrOe+Ayhz7Su3nQlI/KyYTcXqUsOtVc4nUAxvZYwm0jOYZFHv3xjEAbK7lBU
         tUn74nXHpIAUO9ba64T+ryilZqmemNhPFI9rEcYSMZ5ImgjPGivN/tP9bVSHp4H+ANwp
         8CJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781628534; x=1782233334;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAunF619cmpnVWUmxEBR8sBIH6wNNPRFerb4qiyheLI=;
        b=cHw8rzwIuBgYMux2IFpON81Ish7sIu13LFwDMGjTwk/qpewsZOU7XZ5lhkF0Fi/qwI
         Mmd5WKlqPxjVQ0siwv3XUbErk0TwGBYiPRFamgrVEsNg4U0OvpE8kZNx27+C9xRHJbFt
         r9lR4Dpo80Qy/9t99ejwizYhR6aZG7YdXbEOv+BE6nGtgDIAD5IpNvqPTs7hcVPUmvFR
         VT69MIC17cs1ZolnL3m3fD9CTmnmpRtA/Y5Q2XSoyQjqthLgMn/d4UFsNg6tcIeQdxdK
         IyfLFXr4jt98dRVfOoMR+kjLBi0AmKf2GZ+SagwNO0zFJ6L4znQrzuUivh4O8y5rnPr3
         Y36A==
X-Forwarded-Encrypted: i=1; AFNElJ98KgkomB+LZ6w+OnBx0qBU6bV3oV/p3rQ3NFCxyJN/Ncz4p7wsfLrpTsslV1sv9a76xX8e5XembpL2EuNJFNb1@vger.kernel.org
X-Gm-Message-State: AOJu0YxetQjbplr1iUO9wKCqPefbng5devSUavl33cZDnFtrpq82IH8Y
	GMMX9CDfrttjYSI09UNCeXtP3PbkdhFgUPrgaApckYCFPRSYxOQLJUO5eIfh66GqKQE2QhG4TC4
	OtyGSY9Epfw==
X-Received: from dlbrn3.prod.google.com ([2002:a05:7022:1503:b0:137:eebc:f134])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:68a4:b0:137:f4ec:29ff
 with SMTP id a92af1059eb24-1386f39385bmr7857436c88.22.1781628533544; Tue, 16
 Jun 2026 09:48:53 -0700 (PDT)
Date: Tue, 16 Jun 2026 09:48:18 -0700
In-Reply-To: <20260616164819.370939-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616061404.41929-1-irogers@google.com> <20260616164819.370939-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1189.g8c84645362-goog
Message-ID: <20260616164819.370939-14-irogers@google.com>
Subject: [PATCH v3 13/13] perf tests: Include error output for skipped tests
 in JUnit XML
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	thomas.falcon@intel.com, tmricht@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

The JUnit XML output correctly captures the stderr/stdout output of failed
tests inside the <failure> element. However, for skipped tests, the output
was completely discarded and the XML only received a self-closing <skipped
message="reason"/> tag.

This expands the <skipped> element to include the test's err_output when
available, which is extremely helpful for debugging why a test was skipped
(e.g. diagnosing missing prerequisites or unexpected environment states
that triggered the skip) directly from CI systems parsing the XML report.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 1dcaeb8505b7..02a80efcdd66 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -535,8 +535,14 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
 			const char *reason = skip_reason(t, curr_test_case);
 			char *escaped_reason = xml_escape(reason ? reason : "Skip");
 
-			strbuf_addf(&junit_xml_buf, "      <skipped message=\"%s\"/>\n",
-				    escaped_reason);
+			if (err_output && *err_output) {
+				strbuf_addf(&junit_xml_buf,
+					    "      <skipped message=\"%s\">\n%s\n      </skipped>\n",
+					    escaped_reason, escaped_err);
+			} else {
+				strbuf_addf(&junit_xml_buf, "      <skipped message=\"%s\"/>\n",
+					    escaped_reason);
+			}
 			free(escaped_reason);
 		}
 		strbuf_addstr(&junit_xml_buf, "    </testcase>\n");
-- 
2.54.0.1189.g8c84645362-goog

