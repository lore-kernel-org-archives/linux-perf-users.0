Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141521D31AE
	for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 22:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684254; cv=none; b=S8rDXWCjLBfPC5++3wmDjsDbuWM3kthyzhPzI51aNXFMd7YtuPknR8181h3F8P3crQsu7+vm+uCHm7JnQqImqOEHAEnUMY2v7pjNabR7bavRiwvIcv8+/mUlcuKYX+NwIaVf1j1L6dtKsF0xoDpMejLIV053nmGKITxMgK3IagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684254; c=relaxed/simple;
	bh=ayFLEkZZxvRFtfh6rbDKgn18fu4jJI/W7wgdr0IoZZA=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=ftUFLAXIdquHqt3LfWe4enUQD2zY6ouz6am/GURT7ZAXcMPaPuX50ZUBNLwTNL+hkeYzajbVSXWXm0aU0ej/+2F9JVROuCzm9Au3Z1wcSnwZWp6JsZg7PqTOkWDOKMpAnT6gdpDRq7NvMbqBGrjobVNbvTd8tfBubVv9HQObRLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EhONqIVL; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EhONqIVL"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6d9e31e66eeso49305647b3.1
        for <linux-perf-users@vger.kernel.org>; Fri, 11 Oct 2024 15:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728684252; x=1729289052; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lNrioubmXeLjE0G20Z4Gp3VHKZoRwxqkvbcLs4LSREQ=;
        b=EhONqIVLt+wav07/C3dbXenSbGmuaCdlXrHKR/be8tEXk//9oBtdBfrE84Ak0DgAZ0
         37bcXHwqWE4WWK3F/3duEmOKmbzpd2EFbt3OoJTagJ81axm6CJuqZ07n45f3OjFX9dC0
         oseFVsA/uAZ/obsCD1CdpVc3bFVoODhBsGxlduIL0wTqu7zQMV7/5dm/jqYUSb+bT8R4
         KJzGXjox5tyU9Y6r0SsN7EwFVJh9lksT+Bv8/Kt516hH8iymBnEOjFZwNZ97ChvHeHsv
         gs9l2qmU6KYmMSzp6Fz9J96nRjlCMCGiYNyLDLy3Z/V5rFBw+AoUSv3qPhd1Peu8h9uu
         hSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728684252; x=1729289052;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNrioubmXeLjE0G20Z4Gp3VHKZoRwxqkvbcLs4LSREQ=;
        b=eyyh6FCuiMw7htoIY8WZ4CXY6+V972xgV22y9TX3rl0LEzTptVMIUQYKijdzUmGWWm
         r133sx+PIpkj0thsX0YHHjMXBBvyButzmPTpY3DlC/31K+Tn/JINZqHXlEl0veZawsBp
         Za60uKzFVrTcaRx7EimOUnYvgKShz98JmQyk1yd0GMLqf+MtQEC2uYME+/zzEtefdgKx
         WXVPKRB1wGVxFY1FJHnjJ6+GsC4oZcJ4LK4RMIVDYEplPSIviqlwCQC69wo1GlLqo3B3
         P79aqKMQCWmcyv1ZNckOQMV/KS0a584SjYn/QxQEq1qVpxnKAlMGvvvxCc4oKWvL0lGb
         fcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjrwxJaFsmqCBp7es9waFBV++uMy7SlYhgtftpSeKmiOT6Pj376RAMlV7CqCH8H9x7+ClOHVq6rdMeGD+ruZJB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+aN4iRK7OtHIEH8p6uTIE70/cBqP6QgA5RgGEmgu5CnpYYR2S
	zyXpLFX6OD3+TjDLY1mSsf/PcLCIUnSSYSvE9rh8l6/J4BHz5oCb4nD6opue/BTw3ufcCFdNbs9
	XKPgXLQ==
X-Google-Smtp-Source: AGHT+IH0cp7lEpJ+EU1fmq4BdA4UVq+vSksmc8806woiaMmF0NZBEKmS+zYZPslDPH3bhtxl8VmxpOa34DTG
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:8144:56f:2e1e:4db])
 (user=irogers job=sendgmr) by 2002:a05:690c:906:b0:6e3:189a:ad65 with SMTP id
 00721157ae682-6e347c71baamr1540377b3.5.1728684251913; Fri, 11 Oct 2024
 15:04:11 -0700 (PDT)
Date: Fri, 11 Oct 2024 15:03:49 -0700
In-Reply-To: <20241011220354.756798-1-irogers@google.com>
Message-Id: <20241011220354.756798-4-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241011220354.756798-1-irogers@google.com>
X-Mailer: git-send-email 2.47.0.rc1.288.g06298d1525-goog
Subject: [PATCH v2 3/8] perf test: Reduce scope of parallel variable
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Athira Jajeev <atrajeev@linux.vnet.ibm.com>, 
	Michael Petlan <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Ilya Leoshkevich <iii@linux.ibm.com>, Colin Ian King <colin.i.king@gmail.com>, 
	Weilin Wang <weilin.wang@intel.com>, Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The variable duplicates sequential but is only used for command line
argument processing. Reduce scope to make the behavior clearer.

Tested-by: James Clark <james.clark@linaro.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/builtin-test.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index bf03fb42420b..88ffc0feb51e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -41,9 +41,6 @@
 static bool dont_fork;
 /* Don't fork the tests in parallel and wait for their completion. */
 static bool sequential = true;
-/* Do it in parallel, lacks infrastructure to avoid running tests that clash for resources,
- * So leave it as the developers choice to enable while working on the needed infra */
-static bool parallel;
 const char *dso_to_test;
 const char *test_objdump_path = "objdump";
 
@@ -565,6 +562,12 @@ int cmd_test(int argc, const char **argv)
 	};
 	const char *skip = NULL;
 	const char *workload = NULL;
+	/*
+	 * Run tests in parallel, lacks infrastructure to avoid running tests
+	 * that clash for resources, So leave it as the developers choice to
+	 * enable while working on the needed infra.
+	 */
+	bool parallel = false;
 	const struct option test_options[] = {
 	OPT_STRING('s', "skip", &skip, "tests", "tests to skip"),
 	OPT_INCR('v', "verbose", &verbose,
-- 
2.47.0.rc1.288.g06298d1525-goog

