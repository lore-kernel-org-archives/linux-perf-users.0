Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E433529BDBA
	for <linux-perf-users@vger.kernel.org>; Mon,  1 Dec 2025 23:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630573; cv=none; b=l7DYAi3Qwd0ox0/xQmCecLm1qUPpb5cQ5F+MQ3ApT1OQPA+EoibxDriCaj6VinA/j+C8XGwpd0ttb6iiBLYhP+u4S9P6Ia2UiRya5FurRgvjfPhCY58mJ7/GDETty6Pywz8oMTJPbIoYehzxMFa5haa65gYwQr/Zuoy0WdLw3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630573; c=relaxed/simple;
	bh=bs+lM3G+cCyYN4AJM+u/lhCfVaMcq+xr0erZJa1aK00=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oUcwOwYj0e9omu3zJF+ZyBW+JJnORNZhAU4a2CZH0py98hHO5nyLTSPFh242pin3mAy46B4i8RpjAFPO82dNeAAo9M8x7NttNaKMzX4N4/6xCqCABL43BHmeF9fS3lXhyUuL/Ioho3MMa2Hyla0Z1sMV8x8yWSFuQIoNIbEzMUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JgxdMhPM; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JgxdMhPM"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2a467c4e74bso6746651eec.1
        for <linux-perf-users@vger.kernel.org>; Mon, 01 Dec 2025 15:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764630571; x=1765235371; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/vlSVnfnZ5RURjvxqhk5bv2/Z1MK+fyLH8B2mfV6IVw=;
        b=JgxdMhPM3WDNb+8RoWT6m4nxwsn5LiaWln16STdiIu6JP13u4utGNLnjkeBTTHtVHX
         fwOAyy9MIwHohADO7bopoKZyC6xySmgUNdoTV15+c0Ev6UP2fC2hDAW45wCOHZcIMfs/
         gpYzrwz3CbzOx24kV2qixiY7MzK+CM7LTuxp44xUtt+GYZKwG878wk9mj1Z+ddOwHqn8
         3Efi00U2Pz87LFVgZun5BATsEdtO+MbaFlQN0ViiyHgWhHPP2zEdLn/LlmF+BwgABmlc
         5Hsg9N6gLRd5HIYgSpnw00CruMxGob5vqF98nFIv2vpdmE4938kRMAfbgEgKkFVX21qd
         Alaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764630571; x=1765235371;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/vlSVnfnZ5RURjvxqhk5bv2/Z1MK+fyLH8B2mfV6IVw=;
        b=Q2eqzR4HRnCAl9bqNGDXfsTTOz1jbfhfoTGwO+rZ1cTajc3ivFuX9ipAMGovF/HRVM
         yGhRHUcDsoXu7bEQcYFvutXGqTqlbzhlC5jyy1GG++MTlinp54fKu+bv0vrhbsFOoBv5
         u+J+J1RiXRViS7p9GrNzoJRCX9bjDeK0oWzhiXSLxq+H0Tu5jFpT60l2LzR+dwJPuLTz
         oX3STtpBxGo71Wdj9tbzGDwJoNGZkiyLWDdpK91ARsO/fWYu4+uYunLPwZOglppK0mRO
         58NWDxK0ZIbCZ0aCQfsNkt9Cs9AtUgcnO331JxhI64xHReLLRcoYrrFRDUIk6cCyYxmQ
         6ORQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/BqiKDpgCzWMuwzstGwJcm0vi20qxujDXEjH3zbnubnRy5uTXt2EKaG9LkyluXY20aAfVuLz8iMkRg0DePjP/@vger.kernel.org
X-Gm-Message-State: AOJu0YzddprXjJS1zSBGhWEgIqLfTO7g6/yk65sXL5PZi/58TxiFkXYP
	/MG1UrVwkbcu8bIlccirEKInhMu2F7J6+lGb37SZIfVZmiqUugTvDkJqiwCBWFpwtM+0FClFev8
	vZU8VvgQvgw==
X-Google-Smtp-Source: AGHT+IGvnMzD0oax+41u2hDGGzEzynniiwfUDte3IVkta4K7uxgKHGHAjbZ53IBSkVXuVoGCV/nPLk8u2FW1
X-Received: from dlee21.prod.google.com ([2002:a05:7022:6295:b0:11b:d4a7:e833])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:cb15:b0:2a9:9837:233b
 with SMTP id 5a478bee46e88-2ab7e658176mr194746eec.7.1764630570840; Mon, 01
 Dec 2025 15:09:30 -0800 (PST)
Date: Mon,  1 Dec 2025 15:09:04 -0800
In-Reply-To: <20251201230904.290733-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251201230904.290733-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.158.g65b55ccf14-goog
Message-ID: <20251201230904.290733-4-irogers@google.com>
Subject: [PATCH v1 4/4] perf tests stat: Add "--null" coverage
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Ensure "--null" does a minimal run.

Reported-by: Ingo Molnar <mingo@kernel.org>
Closes: https://lore.kernel.org/linux-perf-users/aSwt7yzFjVJCEmVp@gmail.com/
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
2.52.0.158.g65b55ccf14-goog

