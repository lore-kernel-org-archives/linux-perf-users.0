Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9EE2DC350
	for <linux-perf-users@vger.kernel.org>; Wed,  3 Dec 2025 21:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764798442; cv=none; b=WPKVtlQMboqvmDGc0QUmixZT1/+m20jSDlNYWMKbb1M5cE1x9J38OJHgOkwF0uWLA82kwUxjPf8/g4KFaABJ1f3MdD3BnfFEX3Ew0yoQhBCredQMkuDr942l/t+8K25Hv/a+iueX0PghnLPbx4rXrtj/FHLvYz94YEnz9tTIBwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764798442; c=relaxed/simple;
	bh=7EIPkt57mizIcizq27oR3v0Xbaf3b0skd0mBiDbL4lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Ceinp1cexf/xE4YQLZx46TryCvf4yOB/V/XNKYaiv71F6+i9c+xXio0vbvfVgKzQqyNIad1bWyiTIS4x4sDFhBO+2mIplf92ZDZXP75deTvqkUWXWxP8TFwxY3iQicpoUy1bn4BPbjNrVlqFik+pfGdVmiKs5YU1bjSqxsQiu9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4k9vtsWN; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4k9vtsWN"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b99d6bd6cc9so363077a12.1
        for <linux-perf-users@vger.kernel.org>; Wed, 03 Dec 2025 13:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764798440; x=1765403240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=waFYuL17oCw/gfl7ThqVJ2njN32XU6ljeSvAGuXSYL4=;
        b=4k9vtsWNBzcHrgUU3LfJi2YfXvSXHjrA/v8SE25b2KZO0TLQOHT5/9E4A527EkuSgC
         dZwcPTZJLjbej7bMMZD8afEy3jCKjj3Ukq/Tp1FuXdI4IV89dIQDrP7TqpQFFgJT6gRw
         +SggGq+PqQVWvh7I5BtVqPciJf7UoypyBVIvT6fNDKNUtysTvGyN1OBwT0WgYFd7Plnp
         5bfoRjMQtd2zJzPxIosJNyKvUh3d/jDkKr1txsVzshLWgmIT8dgfuGTHsajrHGaFxY83
         fZjPLB7arpb8ZAVmQglG4DEApRdhL3b0yfv/i9jx73Wdccu89fZa3iP4LKufpAg0Shwo
         YC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764798440; x=1765403240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=waFYuL17oCw/gfl7ThqVJ2njN32XU6ljeSvAGuXSYL4=;
        b=GlrI7O/aljSs9xBgz0xpVEVWv2jKpcvrPmXWtz70xBHQqCPveE65YHBTMy0Jprf6gI
         qUwylACYG2Xti0yWgxj/MS65ke3ra0i6rJogn+Wil8t73HIRkAj7XZJ9KlB4+o+055/e
         wz3zIxXWTGlzZbCY2pjNt6A9RgsRy1+6TJtcbcBMaMR06e+YHBq3vOHSzlzKOVbw+piK
         CzySJwWKttqO9KmDZlt0SbJeZG5HE6H4rq4nFYqjnSHuAXf9O2wzciscsmYolW7YU8g/
         eU92kBCinwrjj7bP9Hdeu77NMyKfgFbLlusyqkROinY93aRAqdlH6bZCUIXuxSgD1eaM
         picg==
X-Forwarded-Encrypted: i=1; AJvYcCXrLWRf8k5YuI/t//lWvMg4wEsWZewSgsiyFdnCOxZ/3m+T63ObQu4zeF1CEz3SKH4n60zF9lnGD13p1QWmVG16@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8EeIWD/MDDAtEW9zOdB2Fs95frP7ziAKprYZl9Jq38WbRN6JO
	bE9I5kwMgGQcOaSgRtlJx9t/P0etDMgeLfFNL9s3nlHlGGLKlDMTq/r0RuQaNpT3gWO/EavNvfv
	KPlOg5+JMhw==
X-Google-Smtp-Source: AGHT+IGVgYUemMQSQM+Wr/hzm5JJaEabH1iCca9VsSm++HtRNgqmw1d8vrPOBIlEK2BPXIh9yyFV1V09gTzS
X-Received: from dydu18.prod.google.com ([2002:a05:7300:51f2:b0:2ab:9be4:b136])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:8202:b0:2a4:3594:d54e
 with SMTP id 5a478bee46e88-2ab92e88b27mr1994859eec.27.1764798439706; Wed, 03
 Dec 2025 13:47:19 -0800 (PST)
Date: Wed,  3 Dec 2025 13:47:03 -0800
In-Reply-To: <20251203214706.112174-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251203214706.112174-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.177.g9f829587af-goog
Message-ID: <20251203214706.112174-5-irogers@google.com>
Subject: [PATCH v2 4/7] perf tests stat: Add "--null" coverage
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Richter <tmricht@linux.ibm.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Ensure "--null" does a minimal run.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/stat.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.sh
index 985adc02749e..7885e875caf4 100755
--- a/tools/perf/tests/shell/stat.sh
+++ b/tools/perf/tests/shell/stat.sh
@@ -16,6 +16,17 @@ test_default_stat() {
   echo "Basic stat command test [Success]"
 }
 
+test_null_stat() {
+  echo "Null stat command test"
+  if ! perf stat --null true 2>&1 | grep -E -q "Performance counter stats for 'true':"
+  then
+    echo "Null stat command test [Failed]"
+    err=1
+    return
+  fi
+  echo "Null stat command test [Success]"
+}
+
 test_stat_record_report() {
   echo "stat record and report test"
   if ! perf stat record -e task-clock -o - true | perf stat report -i - 2>&1 | \
@@ -212,6 +223,7 @@ test_hybrid() {
 }
 
 test_default_stat
+test_null_stat
 test_stat_record_report
 test_stat_record_script
 test_stat_repeat_weak_groups
-- 
2.52.0.177.g9f829587af-goog

