Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968D62248A8
	for <linux-perf-users@vger.kernel.org>; Sun, 11 Jan 2026 04:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768104842; cv=none; b=Cz/gaN8EgIDAtbsKQ+efM3+1Mr4AbM7G8IyzoGfF8kLkivtsT9WxiChOdfwuAvlEsrp5JL45ZTmGaD75Ke9m6yEfQh90r0IDi6vvUBd0kkyZDJ5PXSqQmz4gOskh8eJgf71prXIr46TAz2Ve29wfPTTNrODjYmn8ZupCFABmYVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768104842; c=relaxed/simple;
	bh=p9yZjdPOVlIsrzsRvdNrHY7nRPFeaZefQijhYmOqz0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=eSR8BEYdEY3z4UWdgYMH3z79hXXdjAPkY2Z48kQwCc6VYFzZpvNeoHFhGH/NLE3VSURXI8rACrtN3C/E69yM8Ody1ElhgVR6eVZvfmFTSL+4AIz9rr+uJkI1u+UoEQpxp0gp/NErmQ/2BVRMgsvWDbrk8BfWqT6TItbfsAlZ3V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UdATJq/m; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UdATJq/m"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2b0530846d3so4776902eec.0
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 20:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768104837; x=1768709637; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1L+OOdkfbYNneXDpVeIu9zEur50u8G+yPfcpgNFE0M=;
        b=UdATJq/mfhkTPY2vUbXCll4Y8SaP/zd75+og9dM3mLie9urL58/PMh6L8VlCWFZutD
         awe20MMQg85FFXaYSidki8cNuxuV1zuVtyLCplGBwiPArtoHV7Afl11OMbmVedrYJidX
         ZI+bPX4oYaEoSz/c+gBL4KuVFdg0J/ml1gJ/FEO3vcneuCerLpf00ikL01wBpG+0EY/7
         gGMYxEhHDyqi8fiSqauKqWzCIdVX+oCts6pUT/jnECPOLKgoNDyVyc/bUBxw6Mu59MOr
         3VUidQNW7vUdBH2vH5RP+DAVIu1xt4glFwfyFRfxCloEGCoAVNl3FMQV56/iGQlaMrt2
         2+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768104837; x=1768709637;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1L+OOdkfbYNneXDpVeIu9zEur50u8G+yPfcpgNFE0M=;
        b=SJJneFCxTYwGZzHt+CQAawpsXbBGNimNDyRago+9XiFASQBZbrtkLHIpH6Q+D+7q9T
         Atcv7DAG+xyY1pLFVCMRXuhfGocxmKHVAITPtEDvw4mP58zYX7asdDPO99eyVgr69Bi6
         dlAz5+BlX+p1GgCmmsttG6mHKIni7cNNti2bGsPTsL164c7mYLhQjX9QMQ/DWN3iam43
         JsJVXLHmWoJEu4B6D75pWd/i9xdTkb0ZIzMmc9Unn2fZoW+/0x6ailTu873OB3Bl6krG
         z+t4lmkNxoRvJ/OWvkUn9znGQVW9NM6FcPmXx4p0nuLZ7QGS9kChwTCxcZ+SydGT+eE4
         ltcg==
X-Forwarded-Encrypted: i=1; AJvYcCVjRB2L1GP50PZCV5c6biIa5P2erWbvtAi0/0USc5geMq5ifIcVDBMBH6chwF9K2nA0OcGWbXigsfWaqqrlhamy@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8AyhbjquJ3gmd+eu+NfHOWggxUX9/MaCJrkwqqNoF4NO8anGu
	VlAxmf58EXz6FZVO7kPuQUHAu1beMD0NdHB/s1K/0xnQatp6VviNd7tTnJXvUmYC0hagc7sTeOx
	joYfeoxdAxg==
X-Google-Smtp-Source: AGHT+IG7oQJLlfvzPaq+7w4x6ycZ6l1X9tfmyrFcP81QUSW0dg2K1VCSEQsQrQ67Jgi2uDMIkWxDY+5WgVEl
X-Received: from dyhb22.prod.google.com ([2002:a05:7300:1496:b0:2ac:2c66:7180])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:160a:b0:11b:9386:8273
 with SMTP id a92af1059eb24-121f8b9aa3amr13458538c88.48.1768104836720; Sat, 10
 Jan 2026 20:13:56 -0800 (PST)
Date: Sat, 10 Jan 2026 20:13:38 -0800
In-Reply-To: <20260111041338.1817056-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260111041338.1817056-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260111041338.1817056-8-irogers@google.com>
Subject: [PATCH v3 7/7] perf test: Test addr2line unwinding works with inline functions
From: Ian Rogers <irogers@google.com>
To: Tony Jones <tonyj@suse.de>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>, 
	Stephen Brennan <stephen.s.brennan@oracle.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a test that seeks to see inline functions correctly displayed in
perf script from the inlineloop workload.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/addr2line_inlines.sh | 47 +++++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100755 tools/perf/tests/shell/addr2line_inlines.sh

diff --git a/tools/perf/tests/shell/addr2line_inlines.sh b/tools/perf/tests/shell/addr2line_inlines.sh
new file mode 100755
index 000000000000..4a5b6f5be23d
--- /dev/null
+++ b/tools/perf/tests/shell/addr2line_inlines.sh
@@ -0,0 +1,47 @@
+#!/bin/bash
+# test addr2line inline unwinding
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=0
+test_dir=$(mktemp -d /tmp/perf-test-inline-addr2line.XXXXXXXXXX)
+perf_data="${test_dir}/perf.data"
+perf_script_txt="${test_dir}/perf_script.txt"
+
+cleanup() {
+    rm -rf "${test_dir}"
+    trap - EXIT TERM INT
+}
+
+trap_cleanup() {
+    echo "Unexpected signal in ${FUNCNAME[1]}"
+    cleanup
+    exit 1
+}
+trap trap_cleanup EXIT TERM INT
+
+test_inlinedloop() {
+    echo "Inline unwinding verification test"
+    # Record data. Currently only dwarf callchains support inlined functions.
+    perf record --call-graph dwarf -e task-clock:u -o "${perf_data}" -- perf test -w inlineloop 1
+
+    # Check output with inline (default) and srcline
+    perf script -i "${perf_data}" --fields +srcline > "${perf_script_txt}"
+
+    # Expect the leaf and middle functions to occur on lines in the 20s, with
+    # the non-inlined parent function on a line in the 30s.
+    if grep -q "inlineloop.c:2. (inlined)" "${perf_script_txt}" &&
+       grep -q "inlineloop.c:3.$" "${perf_script_txt}"
+    then
+        echo "Inline unwinding verification test [Success]"
+    else
+        echo "Inline unwinding verification test [Failed missing inlined functions]"
+        err=1
+    fi
+}
+
+test_inlinedloop
+
+cleanup
+exit $err
-- 
2.52.0.457.g6b5491de43-goog

