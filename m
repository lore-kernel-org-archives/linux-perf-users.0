Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7FD225416
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 21:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741727801; cv=none; b=jc00gzB/mJ1avVGd38rENeYbuvDfVYoVPQJg9PGTAd9HA+3Y2ZOw3bAJvuradoQYWhm2abTTsBs8YMq34faMOi1shPAFMfl0UpOltFCLftExPn+EkLRJPTQ5TZ2gSUmIl2csSlUExKTBgHwc9wbBcTHiMjnXNkr1yRjphDs6kwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741727801; c=relaxed/simple;
	bh=lvscBsVv1/BjSIs7zpT9RlNNOLICQNjFW1jic6bfVUc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Content-Type; b=Tpe3eSeUIyQJr+8O/iUWKXMqJM9fcwtvtNFB89t+V+Gi2jEeVBW2oaF0MONQ0PnevZEGcUyUlhNxekILOsM54fkyoWrhLBLC3IBN7Y3gZ+eiKA3lK+ACAwmy8NlvNzz1S/0SvKzdDVdyX1r6wNu7mW7mV0R/tFAbpH/4iwkDo2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ccs//ZnO; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ccs//ZnO"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6f4348c854eso81127227b3.2
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 14:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741727799; x=1742332599; darn=vger.kernel.org;
        h=to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vIlk2s33Rrsc/qi+k6noUpBBdxrj900jkSndtjdrPWc=;
        b=Ccs//ZnOLuPo8WnUnXeqdmMvl0pVA0oQqEVbgPYYNctUErZqc45B+RNnUCz5zokzQb
         /L2+G16eUt2uN/vDyYHRPYDGKRsh6fCqlD7rzgSJuMJ1Wbs55ECIG6rnvuA/L1EQQQYX
         mrPrUCIjxYb3DDZjRi3wqR9Dq9a0LrJrPjERqgrPHibkSM1VBtpT08evLCp/38SiYMiX
         FTSAQwNKU6tOYmIjyzlXiwd41tzU/Ti1NDyQu+hYUDFFQqFqIGl2VNL7s8Fg2ihSu8bl
         42R8ljp6lxRNeVc7ad6NX5hhoL45xPJdbdOe+aZjvf+uJ88h1cYeCCtWIqj4vya+0UoH
         V2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741727799; x=1742332599;
        h=to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIlk2s33Rrsc/qi+k6noUpBBdxrj900jkSndtjdrPWc=;
        b=LXRJfnkX9Jh6qUK6OHfCKmMYpqarrGzPi9oCog8wh7GoZqKTVQvezrAFo69c6GRFOX
         Qb9DfLLXT92dibceQLgLTDBZ4J6i5B6UK09NVTeBtHWLR0NdLkdd/di02+jT+ysIH2YR
         yitOyV8KG5ez/MecjuKZXJGwZsACf9sHqU4kGvs4ZtFgZ1i/aa6TTfb4441n+/xPB0Yy
         eevDXrK3Gr15LEG8mtFoLSwrWVDB7qnoisEC4E1vZavdgc2p2pujliucqbJYzh9sXoXy
         9ickRHLdUDCbXrF8xmkEmBI/zNQSeGiaXXEzrM7+uQZ8AgLXLmujEN7Wq1HGvTrfejjV
         /UQA==
X-Forwarded-Encrypted: i=1; AJvYcCV1vocOLMVq9uvNIzO9EJLZ0kFOuEQjA/oqoNEZHwMWxujblg/eTyOngpv6bea+Z8+QgkveCSw4bfXZHrKggJ1w@vger.kernel.org
X-Gm-Message-State: AOJu0YwzuKXTIZQU/tEwLtkTPYDoVj43WkERR7Ck0fzwea6MtZz0rSy4
	LkaI1CoCdqFEdA2Bk3lX0V3aAHQzJ/5+mSSBVFQa6oaqppWguuM2SdW6O1hAkuV8GKvxz/9JYBk
	Dl/AC8A==
X-Google-Smtp-Source: AGHT+IGi854aNHtbZQDmiAeH6ZFKPYGEkZuVEj1mFXwtM3qpSHMvC6UHN+F6MLn8UeB8kPCPQvm1yenb94dz
X-Received: from irogers.svl.corp.google.com ([2620:15c:2c5:11:8bc2:942f:1b93:42dd])
 (user=irogers job=sendgmr) by 2002:a05:690c:4a0c:b0:6f9:8797:a247 with SMTP
 id 00721157ae682-6febf3bd171mr23216897b3.6.1741727799152; Tue, 11 Mar 2025
 14:16:39 -0700 (PDT)
Date: Tue, 11 Mar 2025 14:16:35 -0700
Message-Id: <20250311211635.541090-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Subject: [PATCH v1] perf tests annotate: Add pipe output to output testing
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Thomas Richter <tmricht@linux.ibm.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Parameterize the basic testing to generate directly a perf.data file
or to generate/use one from pipe input or output.  To simplify the
refactor move some of the head/grep logic around. Use "-q" with grep
to make the test output cleaner.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/annotate.sh | 56 +++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 16 deletions(-)

diff --git a/tools/perf/tests/shell/annotate.sh b/tools/perf/tests/shell/annotate.sh
index 1590a37363de..16a1ccd06089 100755
--- a/tools/perf/tests/shell/annotate.sh
+++ b/tools/perf/tests/shell/annotate.sh
@@ -35,54 +35,78 @@ trap_cleanup() {
 trap trap_cleanup EXIT TERM INT
 
 test_basic() {
-  echo "Basic perf annotate test"
-  if ! perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  mode=$1
+  echo "${mode} perf annotate test"
+  if [ "x${mode}" == "xBasic" ]
   then
-    echo "Basic annotate [Failed: perf record]"
+    perf record -o "${perfdata}" ${testprog} 2> /dev/null
+  else
+    perf record -o - ${testprog} 2> /dev/null > "${perfdata}"
+  fi
+  if [ "x$?" != "x0" ]
+  then
+    echo "${mode} annotate [Failed: perf record]"
     err=1
     return
   fi
 
   # Generate the annotated output file
-  perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null | head -250 > "${perfout}"
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf annotate --no-demangle -i "${perfdata}" --stdio 2> /dev/null > "${perfout}"
+  else
+    perf annotate --no-demangle -i - --stdio 2> /dev/null < "${perfdata}" > "${perfout}"
+  fi
 
   # check if it has the target symbol
-  if ! grep "${testsym}" "${perfout}"
+  if ! head -250 "${perfout}" | grep -q "${testsym}"
   then
-    echo "Basic annotate [Failed: missing target symbol]"
+    echo "${mode} annotate [Failed: missing target symbol]"
     err=1
     return
   fi
 
   # check if it has the disassembly lines
-  if ! grep "${disasm_regex}" "${perfout}"
+  if ! head -250 "${perfout}" | grep -q "${disasm_regex}"
   then
-    echo "Basic annotate [Failed: missing disasm output from default disassembler]"
+    echo "${mode} annotate [Failed: missing disasm output from default disassembler]"
     err=1
     return
   fi
 
   # check again with a target symbol name
-  if ! perf annotate --no-demangle -i "${perfdata}" "${testsym}" 2> /dev/null | \
-	  head -250 | grep -m 3 "${disasm_regex}"
+  if [ "x${mode}" == "xBasic" ]
   then
-    echo "Basic annotate [Failed: missing disasm output when specifying the target symbol]"
+    perf annotate --no-demangle -i "${perfdata}" "${testsym}" 2> /dev/null > "${perfout}"
+  else
+    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
+  fi
+
+  if ! head -250 "${perfout}"| grep -q -m 3 "${disasm_regex}"
+  then
+    echo "${mode} annotate [Failed: missing disasm output when specifying the target symbol]"
     err=1
     return
   fi
 
   # check one more with external objdump tool (forced by --objdump option)
-  if ! perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null | \
-	  head -250 | grep -m 3 "${disasm_regex}"
+  if [ "x${mode}" == "xBasic" ]
+  then
+    perf annotate --no-demangle -i "${perfdata}" --objdump=objdump 2> /dev/null > "${perfout}"
+  else
+    perf annotate --no-demangle -i - "${testsym}" 2> /dev/null < "${perfdata}" > "${perfout}"
+  fi
+  if ! head -250 "${perfout}" | grep -q -m 3 "${disasm_regex}"
   then
-    echo "Basic annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
+    echo "${mode} annotate [Failed: missing disasm output from non default disassembler (using --objdump)]"
     err=1
     return
   fi
-  echo "Basic annotate test [Success]"
+  echo "${mode} annotate test [Success]"
 }
 
-test_basic
+test_basic Basic
+test_basic Pipe
 
 cleanup
 exit $err
-- 
2.49.0.rc0.332.g42c0ae87b1-goog

