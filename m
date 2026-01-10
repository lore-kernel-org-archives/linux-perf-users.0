Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82C2E1F08
	for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 08:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033636; cv=none; b=Ti7DrX4UPZnp+d8J/A09tyvK1E6VVVFsUKG3FD6x8Kg8jAmrW37fVqatCPcjki0LPv39+E2sVyZSmPxADuoS//EtMAQMyuyyx3NO/ynayANTV/1N9Ax/DvS1IEFUV/QL8dh6KcLAw5tggwV/+EB8L3Jy0xhwmCci8SPkV7hrq8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033636; c=relaxed/simple;
	bh=p9yZjdPOVlIsrzsRvdNrHY7nRPFeaZefQijhYmOqz0Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=pLB5++MvYVCAqDkdfZLC/M6CN2MYIh/ohPdFFg/tTLEMNqSkWzoEXR49baht05naXnY63RlJUCsChq5e8ngeCoYAPvU3+idEuwP+3D4cFkPYtMdxB8Ojv7Fib7ERchi7FoP+rTRDASIpsQyXn+zD9s+d+1hgcGdCzQdHJqYH1yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G2F1m2gQ; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2F1m2gQ"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2adc3990fecso1941808eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 10 Jan 2026 00:27:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033634; x=1768638434; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y1L+OOdkfbYNneXDpVeIu9zEur50u8G+yPfcpgNFE0M=;
        b=G2F1m2gQ5llrW6r8Ck9XryuzdA9HXVhxJovvxbXwkTN5EMct+l8C82baYDB30YiBku
         mmv69tSJfTf0gonbWAD+nyBMAbykNOD7SdE/yUJe7ko4pP2gXYtE+X3xnUkd5bXUqjhA
         d0K+oAS4rL7UQ/gj8Elj5MK2b01VOdPN9/9fH6xKh6I3kYjPI0yken8pNbzFiam8OtK0
         dqHCnh3uIwbgz47CCzBYT8EOu24uNEGqHCEapAIdFD6gNoz4JNTDqwujlojqUuPAlmCp
         9Wm90NluZ+mnQX15WjIiI/0aW8HTTm2H+87tGP45z8Cf19xUTyYOMKV2DsElqGM/gyoY
         FNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033634; x=1768638434;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1L+OOdkfbYNneXDpVeIu9zEur50u8G+yPfcpgNFE0M=;
        b=DlvbRoef+UPjkOznkgjo641aSab0OJHl/kkk3k1PIZwrmkIZNKw03Ikz0ajZ/4LmFe
         uqGpCBDgElqacuUBf6bltwCVM2x/4Rr77w86jHNYXS1Lyx/OIB+JlP0PwVVK1EyhZebz
         o1xpOK/qYVEO4QdxNTiZJkx6sqz7azy/eMz2KJaeUjppoihoYBJild68o0HpjuigLZxz
         l94gtu4XJ4Wu6Tauv2A6NLsDbgIwbNTYexssJP/0bYA1Dy4WEhbdU0tAtOGsKsfLX4fv
         IWep+fU0VwS8TQBKpvojNG2Mw/24ruUK9PZ7Ifp6bne/Az6dUmnIYIyRRLbAkYPUQ6HO
         gF1A==
X-Forwarded-Encrypted: i=1; AJvYcCUcCvVSBPTiScokCaRrafE/cMKahXgEgcWnyxAWXp0v2APQ2ES4Ngp/srQeHlo1+bG8ovWvCoFDTBkcgD6m8y6B@vger.kernel.org
X-Gm-Message-State: AOJu0YwRNCcgZ4qc7F7yg53t0j1slGOIGVUoPSHlnJnoPRihjzFxvqk8
	ynHQlsYusv/kySHRSmzMuDtfgZ843l4HkaGmLtXYL5HSdbjxpxnLw675UNv33bEhgCndnJdBxdQ
	n3+YaAuKFlw==
X-Google-Smtp-Source: AGHT+IEQpnrv5YMXhTRF34W6qbcoh5juNyS5pLjmdu4Lo09vc0suzL8frFCFCE9E1+rfz8s+Egg3NdjQpUBL
X-Received: from dlii15.prod.google.com ([2002:a05:7022:418f:b0:11b:a892:80ac])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:11c:b0:11d:fcc9:f225
 with SMTP id a92af1059eb24-121f8653d54mr12079194c88.14.1768033633833; Sat, 10
 Jan 2026 00:27:13 -0800 (PST)
Date: Sat, 10 Jan 2026 00:26:47 -0800
In-Reply-To: <20260110082647.1487574-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082647.1487574-1-irogers@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082647.1487574-7-irogers@google.com>
Subject: [PATCH v2 6/6] perf test: Test addr2line unwinding works with inline functions
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

