Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0561BE229
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153985; cv=none; b=t/A5NrGP5x8Uj00qjN9Ii5XdP+1ANsmwJIDigOqFZH6VD2PUBnWUXlajN1dNgVq+ZWRVXl8mMbSAXUnaQuuClVphX3+qfskqXVqGuCn2LID3FwIm7DF4L4WbPxl34lZIq+bH5FOtpuxJXz+6i8oMuNQcT6zOb3xbGOy1lIGC6Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153985; c=relaxed/simple;
	bh=M/SxxS1EV5YiH2L2D9PMSuM/xyixk2ltobd2ktIOQbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b+zsnilUMQxV0a7asaxzEc7ZpVBO/D+yhwolvgO3G2PtgTJAu6AaIvWrdtzR8i+Dx8w6KGenGC15YkOQXdnflbTBGV9msMAgPm0wYC/n0/G0mS9k1NNtV2lOfHwVLHYYXsA5bXNDBk6CGW9l0dIDXKPOh41vM6zBT0RPEpkWk6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QXzbLTPc; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXzbLTPc"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365b6bd901so1268210e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153982; x=1726758782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyScag8p5nZQgcpgovS0Br7oaCoB8CMogAdxSo53VSM=;
        b=QXzbLTPcq2Erda9zCSq4kqzXSrQSzAYZGcWKuaAoHMcA1InmEavdfH7gnWFDZhEzGB
         KmmDoXgUFhF1NXNRMBiofKvg1JR4cyW4/5AmAHujHCkdB5vs79ED49SkFXKMpibnSxC8
         7bJ0AELgOx5pVeyKBv4uuus0QmGUUmGKMJ18cLko3aXiTxiupNuX4gzA+D84Y6T3t4uF
         y/2rzMrkTtoqHdIFMeuOZbzc7u16JBnVZoQudB7o+IpjV4vUeTsa8lW2ew8562jCfjnZ
         HoZVmVuMiCx/cDq+rZHu6WIQRo7mys1dOS5dvdBPPsNQ77Tw7qjt6P/6nb85XgKDKJN6
         V0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153982; x=1726758782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lyScag8p5nZQgcpgovS0Br7oaCoB8CMogAdxSo53VSM=;
        b=lmH16/lAv5L2Zdfjp7a/1m43d8bWKE07QZ34zpJ3Zb8sqnHDK6zIq0Rvz+g+XnGPc0
         7QEnYzfEFyb5z/rNW9r6ZvLlGzgbYJRcCH2WK89hHkdqLcWSx+d3pJHeK3au8LoBgHNB
         iPxnpFkEZwBEOxGvnc+sTiXvJxN+I4A1YZ08hL3KrEM6znDs+FnTLa12farBDfqMlgNg
         /t02umAV4zeZ1y344cy9cT70HY4muc/AORsmUuxDFmtjPF6XZ/pQZiUAtDMCL5nFR+bD
         Gt9bHW/KJ7VGK5j8DwumniXQ5CgeN0jXNIGeHvKWsWfxEzNe9emKDCMXyWLnfiLarMrb
         Oj0Q==
X-Gm-Message-State: AOJu0YxyY9ZBCx3lsXsXjLjrUR6kDjc8xvp8oxCIOVyMXex1VtdqCNDx
	g9+XrBPpuaBWJdn5T9zIznnq2b0klqZ9CZR5o+VcY9XaU1HNHA+zziaM+GZjfHZnZBVbpvHmH8e
	HSvH6Yg==
X-Google-Smtp-Source: AGHT+IEU6nXG+B4QFLcwDCDs/5zj2w0oRrKPhJUxJ9n5pG2+xKrqgQBx/Dpn46aYZQ7Zt78NIeVlOg==
X-Received: by 2002:a05:6512:e94:b0:530:b871:eb9a with SMTP id 2adb3069b0e04-53678feb5ffmr1855771e87.47.1726153981495;
        Thu, 12 Sep 2024 08:13:01 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:13:00 -0700 (PDT)
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
Subject: [PATCH v2 6/7] perf scripts python cs-etm: Add start and stop arguments
Date: Thu, 12 Sep 2024 16:11:37 +0100
Message-Id: <20240912151143.1264483-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912151143.1264483-1-james.clark@linaro.org>
References: <20240912151143.1264483-1-james.clark@linaro.org>
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

