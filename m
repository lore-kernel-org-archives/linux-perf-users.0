Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687618872B
	for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 17:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373095; cv=none; b=jhvHqG1ebgcoZSoEDWMGg8fG/aoNrQ97IpxPHQLORSo8mUhx6/G0fUIW7MXgm8734HZnet+vpySW55+deuhND+7+OiG6ix2zQSfmTDNhhkcRxPUWynItTKJzTikmmZIyypdrtkKrm8eLca2k3NtHPjCSjB3Z50Leh6Ak7xyeIlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373095; c=relaxed/simple;
	bh=gERZzLCzc2fWcCvVz8qmuopBQ0MicZBfE0/WEjrEEsQ=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Content-Type; b=Z5K/YbVTPg64CLkL+F8ZWlRPJQNoDbGSyg+KU4iVVxYilLywNrYPjgwviN2S5ChK7EzWEBcSkMD2WqNaDsItq+Bi1xk4f5BbEobh29xnfes9n5i5/Bjmoqq3rFKstG1iOuLvnrbmL//Xy/h7DyTXDmegjdMcM9Qfi+R8TaAiwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2Z5fSAY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2Z5fSAY"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e0082c1dd0so30039137b3.3
        for <linux-perf-users@vger.kernel.org>; Thu, 26 Sep 2024 10:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727373093; x=1727977893; darn=vger.kernel.org;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dJ+kNXYQ6ijjlJjPvv7tl9Ibe8Ne8BhermJ+ZjD0JCw=;
        b=e2Z5fSAYENS8f0XEDgpJqXzGNozBI6/wuWGb/vJUu+GyguBHov6fUoVnutlIH1uzsw
         53lqa2OxD9eC+EPqcyd6igiTisLp2tHHRjoWTtqA6ypNt/DOGP/eKQecVGTB1OcCtPXw
         KCs/VIim232LSxMXYQvLkXdAg2PqwEt6VNaLGfquacH/52U+1XePFlzIC2Qk/bhweTTV
         qQBCVV6bKbg2dzNTplz7LVTjja4c00sgP47knASFCzcQfzyEnHaPPsmQ/K8VjrIkPxfH
         AomiD6+trmIZqsF197l9kTsJl4upFx7OItTDtmFSAtEhe/HMAPZ12bomqJl6PVQWUQQ5
         qpNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373093; x=1727977893;
        h=to:from:subject:references:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dJ+kNXYQ6ijjlJjPvv7tl9Ibe8Ne8BhermJ+ZjD0JCw=;
        b=IBtRnh1wwnCcK4Cz9peGwtPEUSpRjlf8UwLS7THZjZNmRpZwDzojtDvvFyxM/3+lG0
         5SqaYVUbKRJwlc1P5Q6k5NtdUj8SictXV70gIoDBKigFlGlN80Hf2C5YrhbxZr9nGFvd
         Yi7/ar/Uvs6/k6n7F7MGcwETENElEn4CG/xyYawi5aCp8zalxT4OsmcLeYY72Vc2dK1z
         gsIVXuTgx0ZIvK3ZrhM/lSb/8dT5S9ExPWFvQXkifXXeBskAXxrHlVhc/zMNVP42QkIy
         XodMo1E62b9GuY0JuX8pv5VCoZJYMftWP2lX6VJtZxTfcJfuqtyKaFib0r3SoP0xs9XB
         X4Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWgLaiTso0W3wacZnkF8GrClEoaH3H7VYqHmqKOpFP0+LoV8QOxGoz0rL/O5kV9VDFX0GqAGabDMhMsF9Ohpogy@vger.kernel.org
X-Gm-Message-State: AOJu0YzV2xBeVpf5qhrSOxg9SCUNsxWc+GG/BMi/ar/18/xI0XTRt7ey
	jx5vf3895VclxCbs1RTP6WZ+6s537Ba086xEsW9YcgRZrDr6YWl/fCL55ONiiz0D57ZHSBLIBNx
	bGAUV7g==
X-Google-Smtp-Source: AGHT+IF76900gFgipr9S/AeWEr7e87McD4QtSxG6frbbqn+BrqutYPpn4+Qbx6r73jI9yX+PrPpjA4Fl2z72
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:6894:6d8b:d227:e5d2])
 (user=irogers job=sendgmr) by 2002:a05:690c:4810:b0:6e2:ef1:2551 with SMTP id
 00721157ae682-6e2475dd143mr27147b3.8.1727373093569; Thu, 26 Sep 2024 10:51:33
 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:50:34 -0700
In-Reply-To: <20240926175035.408668-1-irogers@google.com>
Message-Id: <20240926175035.408668-22-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240926175035.408668-1-irogers@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Subject: [PATCH v4 21/22] perf jevents: Add upi_bw metric for Intel
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Perry Taylor <perry.taylor@intel.com>, 
	Samantha Alt <samantha.alt@intel.com>, Caleb Biggers <caleb.biggers@intel.com>, 
	Weilin Wang <weilin.wang@intel.com>, Edward Baker <edward.baker@intel.com>
Content-Type: text/plain; charset="UTF-8"

Break down UPI read and write bandwidth using uncore_upi counters.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/intel_metrics.py | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/perf/pmu-events/intel_metrics.py b/tools/perf/pmu-events/intel_metrics.py
index ec15653e2cb6..8e1c0bc17b8a 100755
--- a/tools/perf/pmu-events/intel_metrics.py
+++ b/tools/perf/pmu-events/intel_metrics.py
@@ -990,6 +990,27 @@ def UncoreMemBw() -> Optional[MetricGroup]:
   ], description = "Memory Bandwidth")
 
 
+def UncoreUpiBw() -> Optional[MetricGroup]:
+  try:
+    upi_rds = Event("UNC_UPI_RxL_FLITS.ALL_DATA")
+    upi_wrs = Event("UNC_UPI_TxL_FLITS.ALL_DATA")
+  except:
+    return None
+
+  upi_total = upi_rds + upi_wrs
+
+  # From "Uncore Performance Monitoring": When measuring the amount of
+  # bandwidth consumed by transmission of the data (i.e. NOT including
+  # the header), it should be .ALL_DATA / 9 * 64B.
+  scale = (64 / 9) / 1_000_000
+  return MetricGroup("upi_bw", [
+      Metric("upi_bw_read", "UPI read bandwidth",
+             d_ratio(upi_rds, interval_sec), f"{scale}MB/s"),
+      Metric("upi_bw_write", "DDR memory write bandwidth",
+             d_ratio(upi_wrs, interval_sec), f"{scale}MB/s"),
+  ], description = "UPI Bandwidth")
+
+
 def main() -> None:
   global _args
 
@@ -1031,6 +1052,7 @@ def main() -> None:
       UncoreDir(),
       UncoreMem(),
       UncoreMemBw(),
+      UncoreUpiBw(),
   ])
 
 
-- 
2.46.1.824.gd892dcdcdd-goog

