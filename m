Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2AE634
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Jun 2025 00:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750292689; cv=none; b=XGjs6hKqHe7Bpegodxy4FOwqSmMBvWkhmzitmL8b4vqwncqNhvvliHg422b4DP+toOcG0n3Ye4PXaCej+eeVVx50HGUq16giLOCZlbrkSctfnkarJCUMApId+iTuswk19ZIUREpG43bo2s3amoW5OGfYkgBUmnFharCXANvNm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750292689; c=relaxed/simple;
	bh=NewwN4RPE7BHdcREEHS9Gp9Bq8qzjxUMrwfsyM2ngTc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Content-Type; b=Bnleacv34h6Dk3byUo/o049wTsi0EMBcF/0vghTOnXkqQxs1djnA49eZ+FMCtbzs6Y15qDkxcNVoLelPNVuocBpdQ0pTcfTo2QA7K6zm1syc2vvOrdgEc6G8aIqxRzxBIOhf+5qOLHQ9sz9nQxZ5EAeoSSiOoIIcc2Wv1L9Fqp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fyACvprE; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fyACvprE"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-748f13ef248so180968b3a.3
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Jun 2025 17:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750292688; x=1750897488; darn=vger.kernel.org;
        h=to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GR416osTWevjir5IPTUtOXKt4AGP7e4u/2bT2JOfmqk=;
        b=fyACvprE3nDRZIByesNRPqr7h+leucotS032elwx7SxW2zv/aKRvZQ5J/cnIvmiqTc
         o0zF/HpiurJg08AD//d1A4eFzrtavVtNfo+KxoWddPAzAeBzfoVd0775CtLll2Q4s4tS
         8AXN9IMjqPbcYhfVBh4WVFxb4yaTdM2npYtObVMTJbhiQteSkxEG9/5qLZu0oN1LVN5k
         JxyA5RiTsJke7iWGrS8MU8CIZHeNbNdwXWb/Mxzw46C7lL0ujfRkCmsKfsVHp/xO6Czb
         HweyY7HY9wd4G6/4uR1sQUeE7MYLs0wmHFnLh0v/r+rn4DFJA4Z612TZYlbfSpaTA4H1
         gHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750292688; x=1750897488;
        h=to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GR416osTWevjir5IPTUtOXKt4AGP7e4u/2bT2JOfmqk=;
        b=idZlo6HHsDYznmj3NiffluuG2cGQXfNXSXYFr2TM3E36f5rgAin1y+9iX5KpCQHjBd
         cp1H3uEvn9+8pobMo0Ske+mQhEjUt9wDS5pL8wp0ghNfHjfnTeRvkmmm7XQfAKpfOHkr
         SMiTOnkzqQx78af7ZLsx5IhOejfP7NcE0KYcHWLiC8HeQo3IODzT6LShyCMA0l2JEwLt
         awednNyibgcPTWi330AES5YjDL3ZGDEPcSWMYtP9Rx6Un3SRgZIIM7js8fWDS3eSzO5C
         NV37hsfPy1g1ctt12LV1ddGySxVwvAnJQ3KSLpX/suZacjfKkCIJaYSeF/QSvBOB36vm
         BAFw==
X-Forwarded-Encrypted: i=1; AJvYcCWgfWqt0aSbFXWWLH4Smg8kHWBLZ08NrmZmjCDE6Edg8ibume7uYUCZsDZvgjbn1NEUKLSJ2RhQXfc+CUjeF05J@vger.kernel.org
X-Gm-Message-State: AOJu0YwwW5tZAed0TFBMCrckvukp0JIavvhNsM6DwCcjhOOIU0hCz5Ex
	sobtxmo34hjof0Q7xjGGeFe25T9VCKeAAVRDsyNDjJzhR/PJ83s4InxnSp2KKg4V4CO2TQcMx60
	l0lUWiKHP2w==
X-Google-Smtp-Source: AGHT+IHLowUPcLb1AsoedloUBtGHZIvYsXFAHsudDPVaZi3qGGgXzLTZOOecHMUjXB8s/QSKjkglN4btCO8q
X-Received: from pfqf15.prod.google.com ([2002:aa7:9d8f:0:b0:747:9faf:ed39])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:418d:b0:748:e9e4:d970
 with SMTP id d2e1a72fcca58-748e9e4de0emr5691992b3a.1.1750292687648; Wed, 18
 Jun 2025 17:24:47 -0700 (PDT)
Date: Wed, 18 Jun 2025 17:24:43 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc2.701.gf1e915cc24-goog
Message-ID: <20250619002443.100301-1-irogers@google.com>
Subject: [PATCH v1] perf test: Add basic callgraph test to record testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Richter <tmricht@linux.ibm.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>, 
	Chun-Tse Shao <ctshao@google.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Give some basic perf record callgraph coverage.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 2022a4f739be..603fa6b79b5d 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -12,8 +12,10 @@ shelldir=$(dirname "$0")
 . "${shelldir}"/lib/perf_has_symbol.sh
 
 testsym="test_loop"
+testsym2="brstack"
 
 skip_test_missing_symbol ${testsym}
+skip_test_missing_symbol ${testsym2}
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
@@ -359,6 +361,23 @@ test_precise_max() {
   fi
 }
 
+test_callgraph() {
+  echo "Callgraph test"
+  if ! perf record -o "${perfdata}" -g perf test -w brstack
+  then
+    echo "Callgraph test [Failed missing output]"
+    err=1
+    return
+  fi
+  if ! perf report -i "${perfdata}" 2>&1 | grep "${testsym2}"
+  then
+    echo "Callgraph test [Failed missing symbol]"
+    err=1
+    return
+  fi
+  echo "Callgraph test [Success]"
+}
+
 # raise the limit of file descriptors to minimum
 if [[ $default_fd_limit -lt $min_fd_limit ]]; then
        ulimit -Sn $min_fd_limit
@@ -374,6 +393,7 @@ test_uid
 test_leader_sampling
 test_topdown_leader_sampling
 test_precise_max
+test_callgraph
 
 # restore the default value
 ulimit -Sn $default_fd_limit
-- 
2.50.0.rc2.701.gf1e915cc24-goog

