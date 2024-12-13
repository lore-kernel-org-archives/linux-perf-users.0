Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019D15B97D
	for <linux-perf-users@vger.kernel.org>; Fri, 13 Dec 2024 03:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062188; cv=none; b=TsLD4M+F4aM1/XwL7Sp5D4UQpqETCGcANMQ5TQPdaVsDNBBCByhuoDUCKeiVaUrWrbnOSIuwcSx3+e7SQWcFremixc0s/v584cK4P+m1vfXlctE8LsK9FQ9TK6e82cdjAj1Nl7CtFeEqoGMsNZpxhHYpK0iJCHmG45A8EFO/Pe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062188; c=relaxed/simple;
	bh=BeHtFePJfyc2ZXX+Pz1KMyierr7nozLLrITrdDd9u70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hhAT620suUYYASPuF85fD9CKvKaxKREaXQSHOzZL8HAzYzis48VclMn4+LhXEWoWsAdnWines5PC1JGcGdPAmLKjPsvBEcDtGRkm6wGqMezNrAzQAjPg9NoDcG62ucdcHCEx55XsIlM9ixdZX6OqyGyjKcs9WlxKU3HoRAgQ4Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com; spf=pass smtp.mailfrom=engflow.com; dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b=ZK2+XluK; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=engflow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engflow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=engflow.com header.i=@engflow.com header.b="ZK2+XluK"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-725f4025e25so1100403b3a.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Dec 2024 19:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=engflow.com; s=google; t=1734062185; x=1734666985; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0NBoThIqxIKKiwm3GomOJ/WljxVwVkbca9vdkXkgA30=;
        b=ZK2+XluK+j0h+xH4K5H2g4oCuSh7jRpMrQHtPWzd3Cp9gxzntuyAWwGEuHvWdFdXk3
         E3u6airokDt6g/T6oqUFVvlKFW4l8OuVfnlSrFlVP2EcDH9fMr5Q7mx5WQyIiGbC3gM1
         eRo2yGONYdgW8F+ipWfgaKrE+DWKbtbuBfX/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734062185; x=1734666985;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0NBoThIqxIKKiwm3GomOJ/WljxVwVkbca9vdkXkgA30=;
        b=jLkxcofKvZRH/Kt7EoZuALl2jhSGnjZbyDXMKapl+WuGyGZgZVxPwXAoCbmg0F2zPo
         KK4lq96H1dLlRDAEkJyxih0civ9vv5b4hFPqDYj2zO9es9/zO3CZsyYJ8kaFva1tsc+N
         uodw+MqXgqgtovzYPZmDRF7xwb3tIVPknwjrlEkk3v4rC446SfGl2DIuFUYZE0dfRn7S
         ZH02bJGORlUAiHiJUuoYWy1cETQrLMSi6Q9E2df+V4xajk6ulUQvC5jvEWZGAoRF0YMm
         bB/xdLx2zOyrhsHQehOxjFZ07N4yvHL9hbDeYdeimWo/NjpsPahCJ1uGlsAQmlOUwQ8V
         83OQ==
X-Gm-Message-State: AOJu0Yz0N7SPlDOdC4UfagMeM2oQim5bVk2ZPHGhVkomvaC2FypIiMt+
	e/cMO0kB9tp4mzqu6CvbJIqnVotu43uRNmd12ay8+G4cDReb/dWv+q0oWrD0pu8=
X-Gm-Gg: ASbGncuhEb5rhmJoxVURXMDHk2AEaZQ05CQeZqeZ5wScWQvZAtsppJ6p89DhG3ffRmv
	LkP9rsUhLAyxB1NA+5iSiggl9X6q1RH5I+IRv5mH93wRiZZnNXTBC7vOaALoaXfqY1gnizhUYtN
	/dqMXWRI6ikXwMeDj/uZaHT5qUaSgsmE0PwVABqXdGlcnYui7HVGV1kfnGs/BiNUPsbReFDr4+V
	sZPSk2fwhbcNbJM9IqAgkY9GrJX7CtviFJ0Eh1nWT7aVtPE4Sz4Kn+tqVBttMoRgrlM2xJZruUK
	evbMRJxqKstKckRO9Ab5hA==
X-Google-Smtp-Source: AGHT+IGTKuRX3MygaTiBOJeSJ+G2bErJRuqiMTRj8Zs31TJEgo6o5hS3Dy7Cma0QVKE0e+xy5pD3Sw==
X-Received: by 2002:a17:90b:2708:b0:2ef:33a4:ae6e with SMTP id 98e67ed59e1d1-2f28fb700b4mr2510834a91.12.1734062185080;
        Thu, 12 Dec 2024 19:56:25 -0800 (PST)
Received: from [127.0.1.1] (158-247-70-44.PUBLIC.monkeybrains.net. [158.247.70.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142e37cb0sm2137756a91.48.2024.12.12.19.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 19:56:24 -0800 (PST)
From: Benjamin Peterson <benjamin@engflow.com>
Date: Thu, 12 Dec 2024 19:56:22 -0800
Subject: [PATCH] perf trace: Remove return value of
 trace__fprintf_tp_fields
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241212-void-fprintf_tp_fields-v1-1-b0c23fff4c54@engflow.com>
X-B4-Tracking: v=1; b=H4sIAGWwW2cC/x3MQQqAIBBA0avIrBNySIiuEhGSMzUQJhoSSHdPW
 r7F/xUyJaEMk6qQqEiWKzSYTsF2uLCTFt8M2ONg0KAul3jNMUm4eb3jykKnz3p0zhGytWgZWhw
 TsTz/eF7e9wNSlJdbaAAAAA==
X-Change-ID: 20241212-void-fprintf_tp_fields-8aaae2f5525f
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Benjamin Peterson <benjamin@engflow.com>
X-Mailer: b4 0.14.2

The return value of this function was meaningless and therefore ignored by
the caller. Remove it.

Signed-off-by: Benjamin Peterson <benjamin@engflow.com>
---
This is a small followup cleanup to my earlier commit 5fb8e56542a3 ("perf
trace: avoid garbage when not printing a trace event's arguments").
---
 tools/perf/builtin-trace.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6a1a128fe645014d0347ad4ec3e0c9e77ec59aee..246be66fd59a4b9d76e4d3c42b68d0a444ca366a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3022,8 +3022,8 @@ static void bpf_output__fprintf(struct trace *trace,
 	++trace->nr_events_printed;
 }
 
-static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
-				       struct thread *thread, void *augmented_args, int augmented_args_size)
+static void trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel, struct perf_sample *sample,
+				     struct thread *thread, void *augmented_args, int augmented_args_size)
 {
 	char bf[2048];
 	size_t size = sizeof(bf);
@@ -3088,7 +3088,7 @@ static size_t trace__fprintf_tp_fields(struct trace *trace, struct evsel *evsel,
 		printed += syscall_arg_fmt__scnprintf_val(arg, bf + printed, size - printed, &syscall_arg, val);
 	}
 
-	return printed + fprintf(trace->output, "%.*s", (int)printed, bf);
+	fprintf(trace->output, "%.*s", (int)printed, bf);
 }
 
 static int trace__event_handler(struct trace *trace, struct evsel *evsel,

---
base-commit: eefa7a9c069908412f8f5d15833901d1b46ae1b2
change-id: 20241212-void-fprintf_tp_fields-8aaae2f5525f

Best regards,
-- 
Benjamin Peterson <benjamin@engflow.com>

