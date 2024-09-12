Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2121BBBE2
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 15:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726153980; cv=none; b=tm3Gg1cAuwVc8MKY+HYZR0+fFvsGiItt3HNLOaH8EvveCaIQw6DjiII7GTvXIm1YMzZMKQUsi5TWY+gJMqkyBuIPCmFoYXqYSB5GNGc9A4alu9x43A3vQOFdMgc1I5zuyJI38IOcoZlSofSJLpVYPADtdWjNgYMLeMd5UulBses=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726153980; c=relaxed/simple;
	bh=bR690mMXw1GA2mO1jEEJOauZ9J/eD8W1OUd3Hv1VNaI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uQYl8QDjiHtt14w2XhKdOos6ToXbfFhGr0VPWcyfEgfsuHbVKUc97mi7wdCDMi7uoY4yvHwmReyH9xutFiia/LAIjtzJTXxdZNTfqfNbpoH/tvH9dyrRH+n7KZgRD1M0CF5MNgkf5wXSPBA2lrn3fmEVAvT63Cp1oWtRU2BhHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=q91+z1+b; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q91+z1+b"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53661a131b4so1495608e87.1
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 08:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726153976; x=1726758776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1UQpIycFZTbpTomhD0ThkQ/OGwgElG8NTd5wS8H1d7Y=;
        b=q91+z1+ba1auBukQsrVJ/V9Fjav32n6sVB4gWduRiJ4i6tGw8zUFOLAG+4EsvjGGrd
         YyZR3td5kqhiX+SrT3cCp6XurSuUrCUVHs99rAaUzcASxCzk0Qn1UMaCFxksHaarM+ph
         e/bvSMH0XiaLkxWVchGO2batFGVTCRbNzZEIJFCpcaeYqaRpUdW+2CAopzMe4+Bb1ZwQ
         bgrghFSON8kBg3c7CIv9K0fc62UI5q2vR/J0QTzcOxydOXKbTCB+7JvlnzFGbIat8Lrv
         oxz+4n6o0ljJiiIUHo7bwXK4cBZlEuEVutd7vis18hU+iCEyTvRhYHm+QwXlicZDNx3W
         EoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726153976; x=1726758776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1UQpIycFZTbpTomhD0ThkQ/OGwgElG8NTd5wS8H1d7Y=;
        b=coI+2hDJcFRg944qBROO20u62dbkv6jAKl6T+J+qCFvZ6rEzGbVvFx8+Pz0oP6J6fF
         RKa2Euos7JasrXQX2av82r1rDsL/W5ZE7Yw2OwRbLrs/03R9tqzIe4QUYczgo6H/iANr
         uXGUMYsDo8M+wOGcOtEwtlpBSkKmqAQAvXnIY5uv37B/xIXN0Vz+k24K8+/qz05Ro+sW
         w3N8qVFIY5R3gcGaiB8yvyWxJT/5YK+kKyzxM4c9AZ378Pnkxa0tdRoiseUTDg0Ls4dK
         sUG4ZdTYHCttvgmI1Yr0/VH6/CVqDcwbzqh+p5yVaRnmVw0aWvtuqbMQLjk0b6cmLt2G
         rbOw==
X-Gm-Message-State: AOJu0YwqEmaYqUZcWLS41wifsve/tMoxzMErrvZAg06xLPrGnp+6aGr1
	uJ8UXfI5MEi4u/gpxY4cBHhsB8yauvkuvpc8bGIOR9lDUOo2C8Eyw29emV8DiygBZRXxv8tuy3/
	mnPuKDA==
X-Google-Smtp-Source: AGHT+IFgAMjvK9UCvsSa2ENtMA8fugJX5vUx4oGnluWZ4OiPoY/eCDU/q7/1d1etbgQS9qcJkbcEyg==
X-Received: by 2002:a05:6512:2256:b0:535:68ab:7fdd with SMTP id 2adb3069b0e04-53678fb7170mr2044442e87.19.1726153974955;
        Thu, 12 Sep 2024 08:12:54 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42cb0dbcb6bsm171928845e9.30.2024.09.12.08.12.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 08:12:54 -0700 (PDT)
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
Subject: [PATCH v2 5/7] perf scripts python cs-etm: Improve arguments
Date: Thu, 12 Sep 2024 16:11:36 +0100
Message-Id: <20240912151143.1264483-6-james.clark@linaro.org>
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

Make vmlinux detection automatic and use Perf's default objdump
when -d is specified. This will make it easier for a test to use the
script without having to provide arguments. And similarly for users.

Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 63 ++++++++++++++++---
 1 file changed, 55 insertions(+), 8 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 45f682a8b34d..02e957d037ea 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -12,25 +12,48 @@ from os import path
 import re
 from subprocess import *
 import argparse
+import platform
 
-from perf_trace_context import perf_set_itrace_options, \
-	perf_sample_insn, perf_sample_srccode
+from perf_trace_context import perf_sample_srccode, perf_config_get
 
 # Below are some example commands for using this script.
+# Note a --kcore recording is required for accurate decode
+# due to the alternatives patching mechanism. However this
+# script only supports reading vmlinux for disassembly dump,
+# meaning that any patched instructions will appear
+# as unpatched, but the instruction ranges themselves will
+# be correct. In addition to this, source line info comes
+# from Perf, and when using kcore there is no debug info. The
+# following lists the supported features in each mode:
+#
+# +-----------+-----------------+------------------+------------------+
+# | Recording | Accurate decode | Source line dump | Disassembly dump |
+# +-----------+-----------------+------------------+------------------+
+# | --kcore   | yes             | no               | yes              |
+# | normal    | no              | yes              | yes              |
+# +-----------+-----------------+------------------+------------------+
+#
+# Output disassembly with objdump and auto detect vmlinux
+# (when running on same machine.)
+#  perf script -s scripts/python/arm-cs-trace-disasm.py -d
 #
-# Output disassembly with objdump:
-#  perf script -s scripts/python/arm-cs-trace-disasm.py \
-#		-- -d objdump -k path/to/vmlinux
 # Output disassembly with llvm-objdump:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py \
 #		-- -d llvm-objdump-11 -k path/to/vmlinux
+#
 # Output only source line and symbols:
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
 
+def default_objdump():
+	config = perf_config_get("annotate.objdump")
+	return config if config else "objdump"
+
 # Command line parsing.
 args = argparse.ArgumentParser()
-args.add_argument("-k", "--vmlinux", help="Set path to vmlinux file")
-args.add_argument("-d", "--objdump", help="Set path to objdump executable file"),
+args.add_argument("-k", "--vmlinux",
+		  help="Set path to vmlinux file. Omit to autodetect if running on same machine")
+args.add_argument("-d", "--objdump", nargs="?", const=default_objdump(),
+		  help="Show disassembly. Can also be used to change the objdump path"),
 args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
 options = args.parse_args()
 
@@ -45,6 +68,17 @@ glb_source_file_name	= None
 glb_line_number		= None
 glb_dso			= None
 
+kver = platform.release()
+vmlinux_paths = [
+	f"/usr/lib/debug/boot/vmlinux-{kver}.debug",
+	f"/usr/lib/debug/lib/modules/{kver}/vmlinux",
+	f"/lib/modules/{kver}/build/vmlinux",
+	f"/usr/lib/debug/boot/vmlinux-{kver}",
+	f"/boot/vmlinux-{kver}",
+	f"/boot/vmlinux",
+	f"vmlinux"
+]
+
 def get_optional(perf_dict, field):
        if field in perf_dict:
                return perf_dict[field]
@@ -55,12 +89,25 @@ def get_offset(perf_dict, field):
 		return "+%#x" % perf_dict[field]
 	return ""
 
+def find_vmlinux():
+	if hasattr(find_vmlinux, "path"):
+		return find_vmlinux.path
+
+	for v in vmlinux_paths:
+		if os.access(v, os.R_OK):
+			find_vmlinux.path = v
+			break
+	else:
+		find_vmlinux.path = None
+
+	return find_vmlinux.path
+
 def get_dso_file_path(dso_name, dso_build_id):
 	if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
 		if (options.vmlinux):
 			return options.vmlinux;
 		else:
-			return dso_name
+			return find_vmlinux() if find_vmlinux() else dso_name
 
 	if (dso_name == "[vdso]") :
 		append = "/vdso"
-- 
2.34.1

