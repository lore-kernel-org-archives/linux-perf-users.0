Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CECE194122
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 13:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495139; cv=none; b=f6ITAqPqfhFYY+n4ONbj4DAja9rzXe1+nyTNbL9V06JtnF0SvEHdbItdA768/rouX2Esn9hJWpUWr8vLLEj0aNKqkLGJCak9DOQgz6F9e550VBPrtr7G1jdR0Xi/Bt66Qhl6Inm3Ab/vUuYz3SKfU0pmurf2WFumD7eH3/OTG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495139; c=relaxed/simple;
	bh=vdLgIo8GePp53xw04KnAQCJh5F4oiBViPbxwtI67iKQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tgh1r8AGW+55KCP9AeoLR54iBeR+EqR4DemFEoiml9eKuBnk2zUp4/skCosqpVZgcexFXYIyy6zKV5nXgJKPrR8qlZHlyKit3jA8Ipw4Uk/lCCWbUrr8PCUW9VETKY/HLv3Q3Aw7BcgYeivESOqizWhjpnseh6jDSomNik6Jyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EkoBby1/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkoBby1/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3787ddbd5a2so2690474f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 06:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495135; x=1727099935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AtH/7E9TP7UM5eLIlL+QC7O7RdXR/ljZ9YaSiv2f5A=;
        b=EkoBby1/YraoUcAQyMtJSNzAqzq+a9n+Icc4U5LlfHmDHRyzquT15WBT16uD4nUwUw
         /bE/kwGv001Q0CbpiArwV9dsqWJKv+mzN7PcvFTLPhjp7srShEgpunlU9Scxy5xoMxuM
         0UEw93nvowNhUdy4rsrJEbIjIzXgP6vDSLDIIefnbEwabgFp98Y7W1CyNQbRMnBwb1oM
         SxOlCi1nwNY93hYI4UcttC+B1oENgVC7KzDkNpRlQW5N1aMcta/aDrVw356xYnmy5eY7
         JnundSiLAbSfOTzScGJh4jPWYAEIEe1oKWwerPkbZ54eIRlr099ZGF2HBTdJ2H9VF9s0
         JFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495135; x=1727099935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AtH/7E9TP7UM5eLIlL+QC7O7RdXR/ljZ9YaSiv2f5A=;
        b=a6QtlqKr1gDzR2VoecFO/2QkEc6X0xNeJnGjKuazLfF9s8plxUvi3FoAN1rOIhhEck
         B2oDuR3v2g7TLYakvSrWOqCDGSjX5KYRrML87U2WuynehsNdbXSNOIhoVv3EzunDAX0e
         tvkFYz+7OGWbvkoS0rdNDQtY5tATNOtJpgZ/pDgiL6rFDN+TYjB25yu+k3wpCcgrFwUf
         TEJHVDbML9VP9zFwuK4BVPt3x5kT6tFhpb9w1YBzWHm9EwPSsW1FhQS4RKtEqJaF1ZXD
         srjhBCaF0ANLvwdtZtqOPZ4M1aK1RWvWDw8swXWyaXeEpz2p/8xnT9dmbqrUIItVZAIs
         tzuw==
X-Gm-Message-State: AOJu0YzZKSvFZ0n76fyjjNWBjeL2ZvPtWspSVH5Rsvqjt2SEN4kjYlKT
	3JbnOEtmMM8GyBrnRBcPofS1K3eLX2deR699euHLWVSvlnFB5yYoDrSN9J3CUxSkHZwTWlOTOIy
	hhud/9w==
X-Google-Smtp-Source: AGHT+IFAvOSLEn39dzXSrkked00cRci732/juuGdGaJTRnvElRy5+8Op6OR+biwvTP1c/MW380IWUw==
X-Received: by 2002:adf:e7d1:0:b0:375:c4c7:c7ac with SMTP id ffacd0b85a97d-378c2d6165amr7924044f8f.49.1726495135275;
        Mon, 16 Sep 2024 06:58:55 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:54 -0700 (PDT)
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
Subject: [PATCH v3 6/7] perf scripts python cs-etm: Add start and stop arguments
Date: Mon, 16 Sep 2024 14:57:37 +0100
Message-Id: <20240916135743.1490403-7-james.clark@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240916135743.1490403-1-james.clark@linaro.org>
References: <20240916135743.1490403-1-james.clark@linaro.org>
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

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 40 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 02e957d037ea..1128d259b4f4 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -49,13 +49,36 @@ def default_objdump():
 	return config if config else "objdump"
 
 # Command line parsing.
+def int_arg(v):
+	v = int(v)
+	if v < 0:
+		raise argparse.ArgumentTypeError("Argument must be a positive integer")
+	return v
+
 args = argparse.ArgumentParser()
 args.add_argument("-k", "--vmlinux",
 		  help="Set path to vmlinux file. Omit to autodetect if running on same machine")
 args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
 		  help="Show disassembly. Can also be used to change the objdump path"),
 args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
+args.add_argument("--start-time", type=int_arg, help="Monotonic clock time of sample to start from. "
+		  "See 'time' field on samples in -v mode.")
+args.add_argument("--stop-time", type=int_arg, help="Monotonic clock time of sample to stop at. "
+		  "See 'time' field on samples in -v mode.")
+args.add_argument("--start-sample", type=int_arg, help="Index of sample to start from. "
+		  "See 'index' field on samples in -v mode.")
+args.add_argument("--stop-sample", type=int_arg, help="Index of sample to stop at. "
+		  "See 'index' field on samples in -v mode.")
+
 options = args.parse_args()
+if (options.start_time and options.stop_time and
+    options.start_time >= options.stop_time):
+	print("--start-time must less than --stop-time")
+	exit(2)
+if (options.start_sample and options.stop_sample and
+    options.start_sample >= options.stop_sample):
+	print("--start-sample must less than --stop-sample")
+	exit(2)
 
 # Initialize global dicts and regular expression
 disasm_cache = dict()
@@ -63,6 +86,7 @@ cpu_data = dict()
 disasm_re = re.compile(r"^\s*([0-9a-fA-F]+):")
 disasm_func_re = re.compile(r"^\s*([0-9a-fA-F]+)\s.*:")
 cache_size = 64*1024
+sample_idx = -1
 
 glb_source_file_name	= None
 glb_line_number		= None
@@ -151,10 +175,10 @@ def print_disam(dso_fname, dso_start, start_addr, stop_addr):
 
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
@@ -216,6 +240,7 @@ def print_srccode(comm, param_dict, sample, symbol, dso):
 def process_event(param_dict):
 	global cache_size
 	global options
+	global sample_idx
 
 	sample = param_dict["sample"]
 	comm = param_dict["comm"]
@@ -231,6 +256,17 @@ def process_event(param_dict):
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

