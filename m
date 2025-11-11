Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC7C334DCF4
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Nov 2025 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762833900; cv=none; b=BZHW7Xb2hYNvaUYMrU0ywbB+yeMRl5gnndx5splp4kXVAq+huDSvQTsscVIbMD1zzE3gvkZ+IpNWfMaDS4SJLmHByhsoBI1ezKTclEi81VX8rt0S+9TrxMbnM7/8yN7WY38v1vwx4rivnw9a5qwf9p4PlgNSa/Ve5YyrOGpOGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762833900; c=relaxed/simple;
	bh=sWmDIev9bpAFqHQEit38MtJHcI5r4PnZTO5Rq4PESvU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pXOCeHj44tKzrhWfecyBv5dndfTcMbIpRTJtkm4S6pJP2deonnZn41xXceKD5KQO21cKXyVrj4zXrR+gF7TedZIARE8Lb2TPgz8f5WYaiNPFpw09RoA0RwN4+GyIRzfOAGvOHADOWXaQX9Y8+MiV/fAzkF/WRveGyVpwqH5jVQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOJjg4s2; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOJjg4s2"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-295592eb5dbso34303015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Nov 2025 20:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762833898; x=1763438698; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=TOJjg4s2uUYgXGYo57ZGDTu+pwW+z8Wb52s2YHvyROvAMg1XM+DUW6IFpMMhqtrEbT
         b24oVaLLjP8pRlgBxbtO1heHthVgZ89m7+lOm4+ULVjQeesW3vYfx25uOv6cZ8ZfOKbU
         2XVBXN0aFFw1ZRWIYNpwU52YbMAhVSsK8p1t/08zvzENk3nBYlJyjBCDaUX3/U1mU2gg
         Dbq8yJHWkuPvHsF5303wM2ut8fHnJMSwAyM5hc941XpHqyPzVDbOaJk8Pi3xF7Yi4H5H
         ZdtPEVTNnA9xHBMZX9nu73fN14Bfy7uwO2LJ2fMdvH7g3bCY8bnvBWdK3tKaV7aCLFPF
         jt/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762833898; x=1763438698;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rrubnbGxO/GZTc54MaEZH3FM5tqPTfV8BFx99302Q0=;
        b=gbXRS6b7Hdkd6pkRxOkXvuPBBCe3nlOER21MGP0jT3YEHj90v9d2H0xLD9xTaukNKm
         IfjmwBP1JV5DiD7MnL6QNSEZJ4jPU7MUGEPkRUGSXOUpN7AoCGB7/7FsdhnmyskEt7iK
         r1urENyUFZFyUZK6pB6Zv0SQuDSlr1eaM13x2G2WOnL5L8FB6uJggwYslARI2303f6Dx
         MTHNqT0KUcyrjDdAv8iWqeo5EujlfAvT+Vd2eA9jFRm8eeWysBSv4TPS3h7T1EusFnGa
         TmMCjUqSHL/NyLlP0GIQH1TjswKuCgCuFL+iJyXep0oY5/PfsMokbphimHNdwK+JRgVG
         MXlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMLpLoavwIAR2jEq1sy+SWjqIQRJx338HAhs5R5FPC4hwlDXzzvXrR0ueP2AbWdhqjVDbpgTm6cMT/oX1lzTGz@vger.kernel.org
X-Gm-Message-State: AOJu0YypEJcjBAtTGd4NPPEMLd1drxi2fMRHe6Y4mdVhCyWKAiTaUiOp
	3aa1l6SWKOwce2LNeBX9W9K0cWArdtnaJaRXhEe1OBZ7kNnpxnzYKZGtGY9NebzXhdOx4anpwG1
	dW8xjsrlabw==
X-Google-Smtp-Source: AGHT+IHBUjhm1HAHK4fknr5+U2WBmlW8IIK5MxW46rm68+SMCCxdxu4P7aNsuW9rnpZloIRA3zNCNzCWCDVW
X-Received: from dyctx7.prod.google.com ([2002:a05:7301:5f87:b0:2a4:612e:b41f])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cf42:b0:248:ff5a:b768
 with SMTP id d9443c01a7336-297e540d533mr131917455ad.10.1762833898118; Mon, 10
 Nov 2025 20:04:58 -0800 (PST)
Date: Mon, 10 Nov 2025 20:04:16 -0800
In-Reply-To: <20251111040417.270945-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111040417.270945-1-irogers@google.com>
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251111040417.270945-18-irogers@google.com>
Subject: [PATCH v3 17/18] perf test stat csv: Update test expectations and events
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

Explicitly use a metric rather than implicitly expecting '-e
instructions,cycles' to produce a metric. Use a metric with software
events to make it more compatible.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/lib/stat_output.sh | 2 +-
 tools/perf/tests/shell/stat+csv_output.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/tests/shell/lib/stat_output.sh b/tools/perf/tests/shell/lib/stat_output.sh
index c2ec7881ec1d..3c36e80fe422 100644
--- a/tools/perf/tests/shell/lib/stat_output.sh
+++ b/tools/perf/tests/shell/lib/stat_output.sh
@@ -156,7 +156,7 @@ check_metric_only()
 		echo "[Skip] CPU-measurement counter facility not installed"
 		return
 	fi
-	perf stat --metric-only $2 -e instructions,cycles true
+	perf stat --metric-only $2 -M page_faults_per_second true
 	commachecker --metric-only
 	echo "[Success]"
 }
diff --git a/tools/perf/tests/shell/stat+csv_output.sh b/tools/perf/tests/shell/stat+csv_output.sh
index 7a6f6e177402..cd6fff597091 100755
--- a/tools/perf/tests/shell/stat+csv_output.sh
+++ b/tools/perf/tests/shell/stat+csv_output.sh
@@ -44,7 +44,7 @@ function commachecker()
 	;; "--per-die")		exp=8
 	;; "--per-cluster")	exp=8
 	;; "--per-cache")	exp=8
-	;; "--metric-only")	exp=2
+	;; "--metric-only")	exp=1
 	esac
 
 	while read line
-- 
2.51.2.1041.gc1ab5b90ca-goog

