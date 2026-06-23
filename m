Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93CC385D8A
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178113; cv=none; b=qas5PpsYblD3jHAtsraJ5UHXXUYZCK8vrVVOUkvDv53CIpALbjwHz0rD67OPgTHV3I0nMAkmGe9fYYIST8C9q20VeJHNN1XvfEkiaTNe1U2x8oHZOvLqusGwF4K7nwznEtGhl6o8CYuu2cvlPGSsU+tgVcVp0dLG/58Pygd+o14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178113; c=relaxed/simple;
	bh=zQZm98wSvUIx1B5DPzBZ40NPX43nGLkH1vrLeq5+opw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e9wA5OjffUlpeQqgzNEFTuz0USbq5PordEUxLvxyVEzI42jyNami149iVycn/tEWiG6rd65nwKsWLXIxkO5DpP0IcZfAnKuZFEBPDBLJiHarFMy2rupddIqM9ypOgbfyh6h+mSxx52eWcrAjUesNslQuqSDkeDQv2DznDU+EU5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GX4JPQqN; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GX4JPQqN"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-137f3465368so5030281c88.1
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jun 2026 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782178110; x=1782782910; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B+6ZyIR8v2HIOi8xAlmrbo77aTlP0GD5POsue6ZwGJw=;
        b=GX4JPQqNhcI5u03EbRC+8dXqTSeg7x2PICh8QcLu6ndsmpxN3sSPQ0QlBkJBRIYk5X
         xv7cf6AKfxfgYwOObgtPjappwqVtIWl3fYE8ZZJRkL204rxXlV2AiFCg/k7FoNNmAm4Q
         xKT16oEGxVXoAcs+xhidQIrbDb4BFOi/JeN0LHag7jZ9qCjRTwxvBZ9KqJsRCvWxVnLH
         tI/XvqdpQ24xOrhqurGp51WZsebxQnH0TrTNhsoJNHa3c3u1fZQKom5Qdyi2r13d8W1o
         HXL6aZEfOnMViB9b/pO4nNnZS97pNV1JTphX7gP57NrZSvy131PW/0e+L94u+YmWLkOk
         AHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782178110; x=1782782910;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+6ZyIR8v2HIOi8xAlmrbo77aTlP0GD5POsue6ZwGJw=;
        b=qexlDjoXIX0XkJIqQROdDLpiXenZnx1QmWgZJggbn5RuCpeZwZspsuR8oStExFvGDN
         pQ4GymE1mpduy07q52QAzNK4o+GVO2L14IoO7hI0kNXVMHFPjRM8ZzMtSFLfA34R4ZLo
         PDZHTe8AqFYONEtYbn3KTEh/+xDf3g1ABjlwNibvuTqdCodfSdPF5fRmsKHe7Y5xAmo4
         NsMe6bUusJ818EKsNPabnBiclYGHzkTHiQQbpf/pT1s6WvzghWH2YUFgXE1iEfI5mpPQ
         Cvfa6tR2Uqqf43QfEFAQRqRDSS0wrqR/5H7uxWyG8jBbiA8ChbvliLZQpGi/q0YuJJIF
         +Q2w==
X-Forwarded-Encrypted: i=1; AFNElJ/u2VywOoqkAsRI46JRv1AkS7nMHznhDUMZGiGknGbN3E5Gnr5HnIm0jnC6x/I/u1pHGKJSpp0Qlop247rTuoR2@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2wv5kC0AGdqKj/e/T0dXNK8v46GAS387tgO4AElAjiqGPJp3e
	/rCQkw7DrJ14pDvC6z0mTf1UxRooZW67EqxRT/5cJEJ24X8XgDIf3txEmn+WaEts3Rw99eyYVYa
	0GjKfLfddLw==
X-Received: from dloo7-n2.prod.google.com ([2002:a05:7023:a47:20b0:139:977f:dbba])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:90e:b0:138:5049:cb7c
 with SMTP id a92af1059eb24-139c70526cfmr224496c88.36.1782178109457; Mon, 22
 Jun 2026 18:28:29 -0700 (PDT)
Date: Mon, 22 Jun 2026 18:27:58 -0700
In-Reply-To: <20260623012758.2291858-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616164819.370939-1-irogers@google.com> <20260623012758.2291858-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
Message-ID: <20260623012758.2291858-14-irogers@google.com>
Subject: [PATCH v4 13/13] perf tests: Include error output for skipped tests
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
index 8b8f63f706d9..d115a19e5f0f 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -536,8 +536,14 @@ static int print_test_result(struct test_suite *t, int curr_suite, int curr_test
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
2.55.0.rc0.786.g65d90a0328-goog

