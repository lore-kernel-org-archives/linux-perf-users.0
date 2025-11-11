Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2985434C830
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833888; cv=none; b=Z8HkYzw1vRMOyoY4Qui81DcljfVMb2u55glUR3yVoAPuonf2EnJOi51gEhiu9DnwGWy/Oh3apcBzfDmVE3Q4YkPPb3VKIggxrv06TXyQEwPeX9pN+qspNowGO141Aj43L4Fb2FemhIi/4o8nAFhYAGWIbDArkD27ToG2+V82Rq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833888; c=relaxed/simple;
	bh=vsAC+bALI30qElPFV06AjAurdz8WlWhRwpAQxUMz2cg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=BJoRtYWCPwSAudcufsg8hCMVxzgOmfRBwdEUVJgerU5GpbfV8tA3b8GSnw+EsCV68lG8s2D2hhpOgY7VvYd1sCbFuS9Y5Flv1TCDhvyuAqAu/PuCRvFP15ArCkXkK3WNexaz7XuNZMtZtCbPxYgphwK5HaFAUah1OH+qromysCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wU4usRMc; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wU4usRMc"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-297b35951b7so62948305ad.3
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833887; x=1763438687; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=wU4usRMclFPGhyRk83oPZ20LdUbM0GM8bbgRkdodS1ww6DFB1mZGwDUNt5mDThKzAI
         f7NhS4bVhbnR0KjLM7mO1xX7CmQA45/ypUnF/diVHwRuO/R9jK4qxTupq1MFxM5timRN
         7qMH3E3xlxHys4MCGB5vXllRtmYFk44GCgyUOliyk7yhYfM9A+s66tGOIf0rsxX27vBR
         BBbzMfBqxHxoV0ExdK50HIOiRcA+dOVscZeBCCxiM2NHOY1qXrir4PkKYp+u7ObuKh3B
         kywE9LhiKw3m8DgEykIRzpK3o2RyxGY4dvAGke+Y5IY/2gVM/1yFS0cIFb2ElJLEsOrB
         NPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833887; x=1763438687;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ScLENsyYSFxSsSXeHlp0LDfphHjWjgXO0/fUWwSEsxM=;
        b=Cy2qoOS8eHHjUFdQ3UQitWqcILIGsLPJ24EJW9OAWRqjgKVmEcMwnouKOpiGfJZNH+
         Qv+OwxBfEBShYKsz2oC+1cHpCEQRRxqaBludhzS5U3rp/Nr5Fz948cpdPBAF+EsLj+HS
         RMvBwtK/XFvZkJaQ5x3mrIxeiCL8dxNXS5Dp4AGLT24TmbVhfvQ/NwZgW1NNVZ6qm+q7
         zFZf6JGpe/RY46d4yXoI3UhgHzJPypLOQ+kozmtRc4P5RRn30xW007WColbkKbpDTmQB
         DDAF5dJMq8qjzj7SE6GscGs8k8+FoI0KTtx8Futw4zXuyfPgwNt/d+MPmRKsjVTkyM20
         5QYg==
X-Forwarded-Encrypted: i=1; AJvYcCXKjlnQTd4WA5IUJO8GFZ7vyNbmrgIJWcuYrMKyVpO0w3N1sPCJ9M7PDDwcErfKsO1L1OOOjWIcR6uLkR9ia1Gd@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjrsu332IApYye3WDHu+SvLkim+6dB5k/RrjI3Iums5DGrlqvA
	MbhdZ1lNNgGyqy1cdpzr9JJ8s6JFRpDgEsB/jk59PJdhliNiq0kuMqFfSGceSQObxexPEsgS7+q
	0+gGeb3Z4Ag==
X-Google-Smtp-Source: AGHT+IFq2mZoiOME+cl0yg/05U1bbEZzMY6aSFKy7XGWVIioRgl1uICIEeUsh828yUm7ED7z/hVL/j+JnmQJ
X-Received: from dyu22.prod.google.com ([2002:a05:693c:8116:b0:2a4:7453:cd4e])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:40c9:b0:295:275d:21d8
 with SMTP id d9443c01a7336-297e4bff754mr140263145ad.0.1762833886687; Mon, 10
 Nov 2025 20:04:46 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:10 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-12-irogers@google.com>
Subject: [PATCH v3 11/18] perf test stat+json: Improve metric-only testing
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

