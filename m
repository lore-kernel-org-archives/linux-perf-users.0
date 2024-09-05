Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D91990C1
	for <linux-perf-users@vger.kernel.org>; Thu,  5 Sep 2024 10:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725533505; cv=none; b=B7YbIhAcqkMJFfKAT4ihh22Ba2c+a/1nEva3PYjquJHbo2YvB8ucD41n87G8KHKMjSjaqC1UlTvcbtGghOhKyEhDESZkVFZO7QFSSv294se06OHjfkNgsR4PMNrrMPdyKIflDn86+OF2OS40Wq11yK2oSGUlmNifRSaerwBSVbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725533505; c=relaxed/simple;
	bh=M/SxxS1EV5YiH2L2D9PMSuM/xyixk2ltobd2ktIOQbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uSrWd69XvzkFqkbB78O0KbY/+waZnlmpbL+QZ98gHw7cYtdrHAgCCLQ5vNbtliGeS92XuW1p3piEX5scwJ7bhoTZ4IR3NrsqmWksxSZPTGPrNRQHrx1eXZReXnDG15JT2ZX7dmI4e+9+cWO5jSnD5h9//eqv59bpRYDsugx9Bgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mQRK0RMK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mQRK0RMK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d18666so4679565e9.3
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Sep 2024 03:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725533502; x=1726138302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyScag8p5nZQgcpgovS0Br7oaCoB8CMogAdxSo53VSM=;
        b=mQRK0RMKOxy2TQWQVPVccrs7/rIWe0HYrHOUTjDC0ZR4sm8sHREFys4xLtElvwrDfv
         YgBk5mq7s8UaiUvWEnF8BbL62LRAJFhD9Tx64u4vairLnup6TsjqeNK3k5HLQln7zgby
         qod5v6eF3QEBGUpJCJeGiRaxwZGQdh6HOAEfsPnpDyWzIAOjapfiswYlLNgUPKkrd/p9
         fynitVzMGJIJiHlw3SeE/cyfmIugwUDIdoPWFYSjwofNf8n2cblltTpAYTwKEm4zs5XV
         1Zq+t6cEUSOYZ//VviV9NK0grfd6izIWxNibzCKZV2T+vwRGv2AkR5ue5g4O+60ilb3j
         c5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725533502; x=1726138302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyScag8p5nZQgcpgovS0Br7oaCoB8CMogAdxSo53VSM=;
        b=XBMi75RQEnCuHdIR4iEgiXTY/trfYf4aYTfDr7LgvSRIverq522p73nHneGdb18Qo/
         0DgrA0PEpaE/+v2rmQlLJxh9ZNekx4pATav0KDuaXoiailZlSL9ZaQ7FowpVi6Gzvna6
         3zkoPjXji8npeQ3hIvxiBT2lf8G4tQBvt5u2qR2upQuxVLExRz3BGmj+nmAKjP/rlSTg
         +VJvjAXq8DQio+x0dJOdmCWZPZm715Jg62S8BwpWxaOponQlRcCl8DKei6+6V4JjzoyK
         hKiO6s34hqBBYkIfgXsg3cPkrR+/mU/c+rX3T825jSXkXXiOfbtkYh5uEP4NvlebFW/z
         BP8g==
X-Gm-Message-State: AOJu0Yx5Vd2ucbK6efQsN7/MeJm/sHf+KrKRCVmFnwc2eTDpjHrt9D5W
	BQwf+3zfnx6OE91h0A4V14NH7dp2NjSWwpWzDsE02697OIcYcQF2V1W/kPzqyJUQTTqCDl0hi4j
	JKk8=
X-Google-Smtp-Source: AGHT+IGfFJqAayaXo8MfaP4LB16SCu3PZkqeamC6wY0GLppIU48zgj0W6/Wqg+hZrLLyTod8T3h8wA==
X-Received: by 2002:a05:600c:4fd6:b0:426:60d7:d299 with SMTP id 5b1f17b1804b1-42bbb10d27dmr151939485e9.7.1725533501983;
        Thu, 05 Sep 2024 03:51:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6df0dbcsm231089965e9.17.2024.09.05.03.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 03:51:41 -0700 (PDT)
From: James Clark <james.clark@linaro.org>
To: linux-perf-users@vger.kernel.org,
	gankulkarni@os.amperecomputing.com,
	coresight@lists.linaro.org,
	leo.yan@arm.com,
	scclevenger@os.amperecomputing.com
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
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>,
	Leo Yan <leo.yan@linux.dev>,
	Ben Gainey <ben.gainey@arm.com>,
	Ruidong Tian <tianruidong@linux.alibaba.com>,
	Benjamin Gray <bgray@linux.ibm.com>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 7/8] perf scripts python cs-etm: Add start and stop arguments
Date: Thu,  5 Sep 2024 11:50:38 +0100
Message-Id: <20240905105043.160225-8-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905105043.160225-1-james.clark@linaro.org>
References: <20240905105043.160225-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make it possible to only disassemble a range of timestamps or sample
indexes. This will be used by the test to limit the runtime, but it's
also useful for users.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 22 +++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 02e957d037ea..a097995d8e7b 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -55,6 +55,11 @@ args.add_argument("-k", "--vmlinux",
 args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
 		  help="Show disassembly. Can also be used to change the objdump path"),
 args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
+args.add_argument("--start-time", type=int, help="Time of sample to start from")
+args.add_argument("--stop-time", type=int, help="Time of sample to stop at")
+args.add_argument("--start-sample", type=int, help="Index of sample to start from")
+args.add_argument("--stop-sample", type=int, help="Index of sample to stop at")
+
 options = args.parse_args()
 
 # Initialize global dicts and regular expression
@@ -63,6 +68,7 @@ cpu_data = dict()
 disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
 disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
 cache_size = 64*1024
+sample_idx = -1
 
 glb_source_file_name	= None
 glb_line_number		= None
@@ -151,10 +157,10 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
 
 def print_sample(sample):
 	print("Sample = { cpu: %04d addr: 0x%016x phys_addr: 0x%016x ip: 0x%016x " \
-	      "pid: %d tid: %d period: %d time: %d }" % \
+	      "pid: %d tid: %d period: %d time: %d index: %d}" % \
 	      (sample['cpu'], sample['addr'], sample['phys_addr'], \
 	       sample['ip'], sample['pid'], sample['tid'], \
-	       sample['period'], sample['time']))
+	       sample['period'], sample['time'], sample_idx))
 
 def trace_begin():
 	print('ARM CoreSight Trace Data Assembler Dump')
@@ -216,6 +222,7 @@ def print_srccode(comm, param_dict, sample, symbol, dso):
 def process_event(param_dict):
 	global cache_size
 	global options
+	global sample_idx
 
 	sample = param_dict["sample"]
 	comm = param_dict["comm"]
@@ -231,6 +238,17 @@ def process_event(param_dict):
 	ip = sample["ip"]
 	addr = sample["addr"]
 
+	sample_idx += 1
+
+	if (options.start_time and sample["time"] < options.start_time):
+		return
+	if (options.stop_time and sample["time"] > options.stop_time):
+		exit(0)
+	if (options.start_sample and sample_idx < options.start_sample):
+		return
+	if (options.stop_sample and sample_idx > options.stop_sample):
+		exit(0)
+
 	if (options.verbose == True):
 		print("Event type: %s" % name)
 		print_sample(sample)
-- 
2.34.1

