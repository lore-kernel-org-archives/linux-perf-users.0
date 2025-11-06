Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33259358D21
	for <linux-perf-users@vger.kernel.org>; Thu,  6 Nov 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470961; cv=none; b=jg13mDR94Vldf5RVnWwmSY2M6daJqB9zzc9wgmb+SbU6tEj8tWy3XMizNjjebxHjIlIV5hTMRjmVnlO0ctrMVqPQup7QoPGhfspPTogHEs6snAtczwyIdh5E8lh4UunNe1+jCnXWv7KpNA/2byPrT5lg8q16bQf9/rgbsWch238=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470961; c=relaxed/simple;
	bh=vsAC+bALI30qElPFV06AjAurdz8WlWhRwpAQxUMz2cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=kxGD4d7R1cx6xTJz7D4+pXXG62G1YuM3zcdZ/K54tIo0DxJEBRX0ymU9EKarKQak/YtcKAjFNk01cA9Id6+g0s7QLaWMcUDTwBP4ZGH0HCtLhnjlw5FDHeshxzvbwCaz50+H0up/YBI2ARXc/DFFSOEhLD0L1cylot/qHjGyiq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MvbgYCNX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MvbgYCNX"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-27c62320f16so2204595ad.1
        for <linux-perf-users@vger.kernel.org>; Thu, 06 Nov 2025 15:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762470960; x=1763075760; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=MvbgYCNXDgx6Kez59C5aClvU6tiGpApTI4UK9WJEE8bE11buT/K3A9GSB6z2MMLcWI
         XP2uj20eENuvWWaOkN9Rm8ahGTVQxXs36dLVp+BkGV1Rf6Pckbv2sqFYzwbz65+ej8bz
         XZH0ZcorUrFmcmBOB6DtA9bYgrS22K30rs6IJj0MkwL4+bYw6vc5J7lXtYLej3KbMnED
         H7s7wIax7lEphBxryMNMxdBeN7CdZANKeX/2x0TGqYTkKTClglepRJc/ojeiVPr27sq1
         eqh+47W/6KUrP3g93oXwPpoX9ZpNs8UzUY5GyMdoNPPQvQ67+kNpzhK4M1172DKAEA5V
         r7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762470960; x=1763075760;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=Qp0RqUgAwGYrlkKTVncpqf/zwnC6M2jab8XWhkuAh86AKr1Z4NpfeqvOgGljNnMqdW
         gaf9vK9fhVQr1mGo+wqF7cYdod1/2CPH76koTm4+5HbRp5EjD21e687Dp5nrTxFo2SKE
         h8DZNWWeQDzJwiVHOkFj2fMZqk6seuAMLjhV1QI6CHWZtmgFqSpvhd1Scod0Ev65CF42
         4ZhtRs4d8lLsHBs3HvaH9kcsPXQg0u5Xhtd3WKVeE0pjo3by6QCibj2Z9F40Ttzkufg3
         wd53QGf1TXwCdjjHRS//FoYqGKvFbxlhq8xhc790osh8SoqpLuB7Xhw/S8rZaA9gvjB8
         7cYA==
X-Forwarded-Encrypted: i=1; AJvYcCWh07zeB5g7g3O/dHP/Fzsdp6OuKa/4Gh6lqOiUAetC013PQjH9WXjqIHE1fY3NWEzOVz9nFJg4rAyt6mi55K8U@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRWeQ+xYzRsfOLcridPGl4v3uca8SFj1B94+XSoh8t+xIr8ol
	iGKr3KKBB8TU+F+ki8reF56DyETwQvIU19BUnV7VeETw+XqtGuR1fS09SX1PYhx6k9bCIGlS6Mh
	/FCi0Y7Fm9A==
X-Google-Smtp-Source: AGHT+IF7+Q0cPmYHz5/abpijevA/om0VtU1+3MKAlA1OEDRxVqteWbaXmduw+smzYLuvecGGWKpEaTo9uj7A
X-Received: from dlai18.prod.google.com ([2002:a05:701b:2712:b0:119:49ca:6b9c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ce82:b0:295:5a06:308d
 with SMTP id d9443c01a7336-297c03a84a8mr14347725ad.14.1762470959559; Thu, 06
 Nov 2025 15:15:59 -0800 (PST)
Date: Thu,  6 Nov 2025 15:15:01 -0800
In-Reply-To: <20251106231508.448793-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251106231508.448793-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251106231508.448793-12-irogers@google.com>
Subject: [PATCH v2 11/18] perf test stat+json: Improve metric-only testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Xu Yang <xu.yang_2@nxp.com>, 
	Chun-Tse Shao <ctshao@google.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	Sumanth Korikkar <sumanthk@linux.ibm.com>, Collin Funk <collin.funk1@gmail.com>, 
	Thomas Falcon <thomas.falcon@intel.com>, Howard Chu <howardchu95@gmail.com>, 
	Dapeng Mi <dapeng1.mi@linux.intel.com>, Levi Yun <yeoreum.yun@arm.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>, 
	Weilin Wang <weilin.wang@intel.com>
Content-Type: text/plain; charset="UTF-8"

When testing metric-only, pass a metric to perf rather than expecting
a hard coded metric value to be generated.

Remove keys that were really metric-only units and instead don't
expect metric only to have a matching json key as it encodes metrics
as {"metric_name", "metric_value"}.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/perf_json_output_lint.py | 4 ++--
 tools/perf/tests/shell/stat+json_output.sh          | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/lib/perf_json_output_lint.py b/tools/perf/tests/shell/lib/perf_json_output_lint.py
index c6750ef06c0f..1369baaa0361 100644
--- a/tools/perf/tests/shell/lib/perf_json_output_lint.py
+++ b/tools/perf/tests/shell/lib/perf_json_output_lint.py
@@ -65,8 +65,6 @@ def check_json_output(expected_items):
       'socket': lambda x: True,
       'thread': lambda x: True,
       'unit': lambda x: True,
-      'insn per cycle': lambda x: isfloat(x),
-      'GHz': lambda x: True,  # FIXME: it seems unintended for --metric-only
   }
   input = '[\n' + ','.join(Lines) + '\n]'
   for item in json.loads(input):
@@ -88,6 +86,8 @@ def check_json_output(expected_items):
                            f' in \'{item}\'')
     for key, value in item.items():
       if key not in checks:
+        if args.metric_only:
+          continue
         raise RuntimeError(f'Unexpected key: key={key} value={value}')
       if not checks[key](value):
         raise RuntimeError(f'Check failed for: key={key} value={value}')
diff --git a/tools/perf/tests/shell/stat+json_output.sh b/tools/perf/tests/shell/stat+json_output.sh
index 98fb65274ac4..85d1ad7186c6 100755
--- a/tools/perf/tests/shell/stat+json_output.sh
+++ b/tools/perf/tests/shell/stat+json_output.sh
@@ -181,7 +181,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat -j --metric-only -e instructions,cycles -o "${stat_output}" true
+	perf stat -j --metric-only -M page_faults_per_second -o "${stat_output}" true
 	$PYTHON $pythonchecker --metric-only --file "${stat_output}"
 	echo "[Success]"
 }
-- 
2.51.2.1041.gc1ab5b90ca-goog

