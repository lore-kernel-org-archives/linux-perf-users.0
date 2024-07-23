Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A81514DA
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741402; cv=none; b=CjpXqqs6IXWrz+jQaXpOLMw9q5H1VH27WD+O6Rqf65qajZ1vlosqhTmWH4VkXhth8gI1Y17oHBCQXkgYddaDGDWKmsU90j/V8bvi2LV54WA59tjiNTr5tWuGiYBAQOn1Ow5C3yYUPqo6ZYYpwlJO5P8kkg08zZmt8QllGj3aExk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741402; c=relaxed/simple;
	bh=lRZmalkeED0KsWnjAtNEkpaePLI01kZSC6setsBqClE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jE36TnQ9WPAEBTE4v6GmVev0Xbfd2U+7jMyIBmUp6mLCIrW2gxAf9QemPz/HLcU2bqPjE2YUYHJStdbKqhOjuuctGVvuI730BqIeh0nwJiEX2Tov89ThZAT0LxZurCpX0tdUWl5M2lApO7ZoMbuM38+FvBSxul40S/bnBNmJ5Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x12E1e9o; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x12E1e9o"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4266b1f1b21so41012975e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Jul 2024 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721741399; x=1722346199; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hT/gzCHhf+qVfp/KGByTrnu2rADn9gzgQeI0FZbkXbY=;
        b=x12E1e9o7rm1jFLSvq+jqSo/BHDGWkcdfGf2W1dYkox36mSMW+fR6uMfcW7Y0M6Hv2
         0ml8L0oXqb3Xu9h5Kab7sRibZkqMtxzRx11t/ljF29e75yz+50OaqHOEULEkRrfEy+rd
         pJSZ5ObWIIlLX+oTRg07zXqfGzvOZboppmGe0mF/w7iwhOC967Ukn1m6lUCKBB27FsYh
         TLpBuB/CiSJ7YLQ25WzVLB3sKV8bKtvMJPFpraYUna14jKL2IalEHeE/SJNv6m6FyYEf
         6g1AS0uEEbdsIYMhWmF8ubDuuISQ/5FAlOVjHgvjwNCjjC3jRYY8SSwSV/WLZ7JsYwnk
         U/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721741399; x=1722346199;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hT/gzCHhf+qVfp/KGByTrnu2rADn9gzgQeI0FZbkXbY=;
        b=MrP1UGZvXkFBnyK+JwUk28r6u8CSfCTUrZlK90ddZjxUl7BSjxWyQ+7GeMllQR+N0t
         Hthv/zRIfIZIOmn3xih97m2DyQDp7NBNzxiilKhX0eXdq0Luk6Bq54tiv5rAbYLF3X8U
         Kae6Mu6dJlHXMn+bm6D8WsZzJimpROY81nOg7wXhCHEJwaj7aaq9Q2hh91lADO1qD1KS
         NjfWTT3LgLTf6Kc5Rx1mIPDSThlVhb2ZO1uxh313/hwY50HyLbgfc4AXp7KmCo1kbSa+
         apaFZg+hgd6mIAapp/V67nH7tZiKLAj8KBSBkZQ6epHfUvVS+xpedcBi24fC+46SY9DO
         qgWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDpip/g3kD9IIaRl40c8ktK63x38El4AozPJbxb90CQrll3EqGvkX71vyuNCkME8PQeKopLoWk9G3MQhWjnWV9WJtJRxk0FKvNhZJTkwgW4A==
X-Gm-Message-State: AOJu0YxkE+dbdI0zQFGmz9m3rASSzDTNsF7E7Psye5vlWYSx6i+dCvdN
	ALLvoNLsrWVqqgucN6uzvz7oEppOKDp+ZMoPep/guzSArUP6k6qqchuI8dKlnWw=
X-Google-Smtp-Source: AGHT+IHg9yxdq/FSvEEy5p0c/Y+4KCXIFv69webYYsBkh1Jhzsy+DT8KFMnM69flKDYyhbRcmlNbLg==
X-Received: by 2002:a05:600c:5487:b0:427:9dad:8063 with SMTP id 5b1f17b1804b1-427dc51d315mr54599965e9.12.1721741398620;
        Tue, 23 Jul 2024 06:29:58 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d68fa9b1sm176277485e9.8.2024.07.23.06.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 06:29:58 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: coresight@lists.linaro.org,
	gankulkarni@os.amperecomputing.com,
	mike.leach@linaro.org,
	leo.yan@arm.com,
	suzuki.poulose@arm.com
Cc: James Clark <james.clark@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf scripts python: cs-etm: Restore first sample log in verbose mode
Date: Tue, 23 Jul 2024 14:28:58 +0100
Message-Id: <20240723132858.12747-1-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The linked commit moved the early return on the first sample to before
the verbose log, so move the log earlier too. Now the first sample is
also logged and not skipped.

Fixes: 2d98dbb4c9c5 ("perf scripts python arm-cs-trace-disasm.py: Do not ignore disam first sample")
Signed-off-by: James Clark <james.clark@linaro.org>
---
 tools/perf/scripts/python/arm-cs-trace-disasm.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index d973c2baed1c..7aff02d84ffb 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -192,17 +192,16 @@ def process_event(param_dict):
 	ip = sample["ip"]
 	addr = sample["addr"]
 
+	if (options.verbose == True):
+		print("Event type: %s" % name)
+		print_sample(sample)
+
 	# Initialize CPU data if it's empty, and directly return back
 	# if this is the first tracing event for this CPU.
 	if (cpu_data.get(str(cpu) + 'addr') == None):
 		cpu_data[str(cpu) + 'addr'] = addr
 		return
 
-
-	if (options.verbose == True):
-		print("Event type: %s" % name)
-		print_sample(sample)
-
 	# If cannot find dso so cannot dump assembler, bail out
 	if (dso == '[unknown]'):
 		return
-- 
2.34.1

