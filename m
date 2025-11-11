Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41BA326946
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 21:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762896161; cv=none; b=H1jF1ne6Hr9M3952Qfk33/P+e6vzSAm9dEyzJXgs1Yg0jFvW0AYz6+Yc5IV8vbF3Pi3RTGBnRtYJ0p18kYTRofShhbHISzMiCuNKLypv2q09PMesTQ6hAuyaqunvVtgshjcVL9oNwc8e21+DBsJ62hBZy6hWj3unTiq8bzNsdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762896161; c=relaxed/simple;
	bh=vsAC+bALI30qElPFV06AjAurdz8WlWhRwpAQxUMz2cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Eex2MdYkRPejWVcCjAbvXEeHFn9l5r0w5aUrIykt2W4gNz7NmLOEDPS3RRJk8LFTCixxTXI7cQoFl+TCRqPmUejbmEe/JBpSeYgBofMpHgBwHdiVVpYKuLmexbrvqx/SNAWSKm+YHz/gZC0EoPICt1gterVfLYP760iwN66jA2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=coniG3pH; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="coniG3pH"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-29846a9efa5so3834635ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 13:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762896159; x=1763500959; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=coniG3pHJaGgCepR4lYGUulN7vqvFxpIT6o57Dlz/j7voUP+4mFUiDLvtt+ztPo2y9
         qu0XdU2KNBWJvBm9iulY1L1xTdhuGwhHY5NuMJNIvYUW7DlbELoxtrsh3pyINic9DiXH
         OEshMbjYSxF/LGbloZfHqeThDDzEQ8zQWGvFSJvcZRkXJ1JjNgN/QNd4KK/C7ObK4Jzy
         6Mw9q+xli2M5nsgxvu9FsbK4cfLR7SzcW6GYm7dNkIHQTlfFau7ZkG8kjfPIuE60TIB0
         iwLgUN/ggLAyRxPzFpdNw+KV/0oWQT6aGFBfiohUDeuqw/er9O8Q6rgSpC2mAhPwAy7y
         w4Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762896159; x=1763500959;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=bYb0Y3vM/98+ZwhLjPJ8Pr70kblgIdBh34wD/nJaRjlwm17zgixBplOOwu0cQ2FJ8U
         iE5MNelAdxqaMeExuT8mCPM3v0ROtptrARjtviX8TaPlK+lGza8ek+X/min7ki6BAaLC
         fYETS79qsPLVDSTVB602oI9us/+T1ZKod2AzM6ZTm2Ck4dpFpUcWjWxG72qDOjvjMFNy
         UI+oURDrNke/jinOQPk7h4qybqq9nj/jtZiPN9jtTfWZEf9LoAyukDHwV+k9ej8Khohw
         6/Do2H5LIOiYFfmU/lod6iuUAgtuQulhpU+fExxFrjb13euG1gi5iABP0fzl3AzjPR6C
         Q3ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXehRLz18oK5w7sc4hvxHOywnxvkoWRDPAeordfxSO4G7NGEMBD3Yhrdxt8RSJgBwKb5bkM0ZW3kONbAFECn1Tj@vger.kernel.org
X-Gm-Message-State: AOJu0YzyMeWUh15aKw/gleOoFapIVr0j+WEgADKwbhczq9TY8u26fV3s
	aLSjZ+keK7zbZcVR84NjDkeQSWuHVf3FpBScjxMDEwZsN/fwtBpjBsfn4lAkBLeNlW6TxQzayDw
	7X7N9elnh2g==
X-Google-Smtp-Source: AGHT+IGyBb3NWbtlDfa779ZrbxRMqg57a9R7F/3vf9mUBNem1tkTuWomktDqMFzF0JhAPH3WqspGueo1CvY+
X-Received: from dlbsv8.prod.google.com ([2002:a05:7022:3a08:b0:119:9f33:34ae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:dac3:b0:297:c04b:3a3c
 with SMTP id d9443c01a7336-2984ed2578fmr7507915ad.9.1762896159007; Tue, 11
 Nov 2025 13:22:39 -0800 (PST)
Date: Tue, 11 Nov 2025 13:21:59 -0800
In-Reply-To: <20251111212206.631711-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111212206.631711-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111212206.631711-12-irogers@google.com>
Subject: [PATCH v4 11/18] perf test stat+json: Improve metric-only testing
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

