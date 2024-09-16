Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB57515AD83
	for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495125; cv=none; b=ssrhw7S17ZkbB65UEi0qIQ7b3cymug74S/M61x6OpDH+rOISs7WDRjQF4slyGrhWRG/1CCLhotQh9pn7ggah8KcvfUOoFJ15lIt/n+3LkDhmF6zQdJuXwx7JuGIKZwBl+Al7bj1WUpiQhNzVe4HEaGSvllu+zqQqFb21QMmoum4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495125; c=relaxed/simple;
	bh=7C8D26xIfSeu12DrQ5Nvi9yW1AADGqbli210vQMd9w0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KIYmidZJuAkNdEjFwLLC55cUXGm1Nmq/PLlYSJgfTneRnMlyzB8pwZz0FSxR/ntWH4RZYiRbYHhfexgR+BRQlVaGccrFyFCff8cvEEZn3MOc5nu8rXvdBpKOiwwq4gqIMKgYoPfUiY1OIOYT/nZ2EJBQQh1BaKpLvh6cBJEYl8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DkZi46vq; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DkZi46vq"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-374c5bab490so3712701f8f.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Sep 2024 06:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726495122; x=1727099922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWq/62mWpUAFEk/gBjzNeVY0NoKYK+5WXUTV/6v1tA0=;
        b=DkZi46vqpHBdHfOn/TWX9vowjdlwFxiEYlpZYoes3uFiLMXA2YoHK8EbE+4vbgopM4
         1uPHxOL7hslKINTXrlaQfclPe5cqYjBVTq4JhAiBllsDq/fmOENZBFTJVpkCzad54f4/
         zxEDc5ow1r2C/fiQxdTHIIeVQ+Aog6jP2xsqAvl716GRC/88NNKYQJvR7aZhSJ4ddFol
         2iHSLmP2A3RSNaRA08wovge7nozXUuzG216LG8ZVxc7TZeBY/7eEgFcPb8otKWVsp+db
         AJMEIqqHitil7BY/vqJmVA+FDj9a+AtPk2pZWrDJdJx5mUXF3CBN3TBpDz6epg/Kzlsh
         gxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726495122; x=1727099922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lWq/62mWpUAFEk/gBjzNeVY0NoKYK+5WXUTV/6v1tA0=;
        b=Ud05ENrCWoKYLl1fIhdNUAcGex3el+qPCPaEG/gUrJcQKSiidJigoQULgWZRS2BEfy
         060DQQQdn/bTyYNxY2DKc0jTNKrZl0sRjezHwkfPRZIC2RqPNLMb6Ol8Mm4QIXf57fyO
         Toa4wmiXzBTr/WcYCKX5bjGjugZ6dJ3ttDGYiD/l4Hb28x7q5eoXs15t3xB7Z4XKYL/F
         cOHkvOvubHx+MxqpUL9voDGlcNU/K33c5Wvcbw64vIF0jYnN17zx/O1Qxqxw+t9rBPIb
         sdBXUFUuzX+hyLUME9pbgmquqAHoH+cLncloq6lEbBXl5ss3vRuqllysgMnRLZSGHBIc
         4MdQ==
X-Gm-Message-State: AOJu0YyZSvhbw4wRoz3XJWQp4vDRqPmRmPkDxAcG+WyJwJc4VIQPsyfz
	r+2ky3hF8cjMY/tsoa17eapp5fxZwvYURBsHOm3kZkVwTf4+yDMJ/v+A76M68T4ncM/dFBjHVMr
	xbr1s4A==
X-Google-Smtp-Source: AGHT+IGbvS6CYBCK4iQeg7G3Wj+J1fYZmYFe88jcm4ZQhuvkb+pN16rQGuWduTfP0xBqRl59dJ+Uyg==
X-Received: by 2002:adf:b50a:0:b0:374:d130:a43b with SMTP id ffacd0b85a97d-378c27a12cdmr9347404f8f.4.1726495121954;
        Mon, 16 Sep 2024 06:58:41 -0700 (PDT)
Received: from localhost.localdomain ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f62dasm7285098f8f.49.2024.09.16.06.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 06:58:41 -0700 (PDT)
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
Subject: [PATCH v3 4/7] perf scripts python cs-etm: Update to use argparse
Date: Mon, 16 Sep 2024 14:57:35 +0100
Message-Id: <20240916135743.1490403-5-james.clark@linaro.org>
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

optparse is deprecated and less flexible than argparse so update it.

Reviewed-by: Leo Yan <leo.yan@arm.com>
Signed-off-by: James Clark <james.clark@linaro.org>
---
 .../scripts/python/arm-cs-trace-disasm.py     | 28 +++++++------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/tools/perf/scripts/python/arm-cs-trace-disasm.py b/tools/perf/scripts/python/arm-cs-trace-disasm.py
index 7aff02d84ffb..45f682a8b34d 100755
--- a/tools/perf/scripts/python/arm-cs-trace-disasm.py
+++ b/tools/perf/scripts/python/arm-cs-trace-disasm.py
@@ -11,7 +11,7 @@ import os
 from os import path
 import re
 from subprocess import *
-from optparse import OptionParser, make_option
+import argparse
 
 from perf_trace_context import perf_set_itrace_options, \
 	perf_sample_insn, perf_sample_srccode
@@ -28,19 +28,11 @@ from perf_trace_context import perf_set_itrace_options, \
 #  perf script -s scripts/python/arm-cs-trace-disasm.py
 
 # Command line parsing.
-option_list = [
-	# formatting options for the bottom entry of the stack
-	make_option("-k", "--vmlinux", dest="vmlinux_name",
-		    help="Set path to vmlinux file"),
-	make_option("-d", "--objdump", dest="objdump_name",
-		    help="Set path to objdump executable file"),
-	make_option("-v", "--verbose", dest="verbose",
-		    action="store_true", default=False,
-		    help="Enable debugging log")
-]
-
-parser = OptionParser(option_list=option_list)
-(options, args) = parser.parse_args()
+args = argparse.ArgumentParser()
+args.add_argument("-k", "--vmlinux", help="Set path to vmlinux file")
+args.add_argument("-d", "--objdump", help="Set path to objdump executable file"),
+args.add_argument("-v", "--verbose", action="store_true", help="Enable debugging log")
+options = args.parse_args()
 
 # Initialize global dicts and regular expression
 disasm_cache = dict()
@@ -65,8 +57,8 @@ def get_offset(perf_dict, field):
 
 def get_dso_file_path(dso_name, dso_build_id):
 	if (dso_name == "[kernel.kallsyms]" or dso_name == "vmlinux"):
-		if (options.vmlinux_name):
-			return options.vmlinux_name;
+		if (options.vmlinux):
+			return options.vmlinux;
 		else:
 			return dso_name
 
@@ -92,7 +84,7 @@ def read_disam(dso_fname, dso_start, start_addr, stop_addr):
 	else:
 		start_addr = start_addr - dso_start;
 		stop_addr = stop_addr - dso_start;
-		disasm = [ options.objdump_name, "-d", "-z",
+		disasm = [ options.objdump, "-d", "-z",
 			   "--start-address="+format(start_addr,"#x"),
 			   "--stop-address="+format(stop_addr,"#x") ]
 		disasm += [ dso_fname ]
@@ -256,7 +248,7 @@ def process_event(param_dict):
 		print("Stop address 0x%x is out of range [ 0x%x .. 0x%x ] for dso %s" % (stop_addr, int(dso_start), int(dso_end), dso))
 		return
 
-	if (options.objdump_name != None):
+	if (options.objdump != None):
 		# It doesn't need to decrease virtual memory offset for disassembly
 		# for kernel dso and executable file dso, so in this case we set
 		# vm_start to zero.
-- 
2.34.1

