Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31799455621
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147696; cv=none; b=tmZWvfXbFZasoa/0wggSJXXMTvHCk23TPbHXLGyZDxG8UfMrd3IOSYK6W2ClhfWve5gb37RPTK67rh76msQ+C+dsy3ld8t0gDq7q+Uw4n66lIrE3IVpHFoi7Db/ogY2rVG5j6T+I3lfVeKXCPcks264d/xR+iPxRmIPjChRs+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147696; c=relaxed/simple;
	bh=/vtMrX6kKbRn4D0NVcAOubZG8b0SLqkHopqx6PWtzsU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nfxew7mdd92UMytmtZyJ63yUFublgbIAWNb2G1OOK7xjTWBhDF4AMGUOju0nhgjGWRwxfRq38xDOvsrF5qDSLB+3IF/2Q0aOGQL3pn+U6lwbGDuwqFM8EdQlhYA9F+r4K5px+J/545hV/nm2GPmeBQjyijr+ErLFV6PCwZhSj4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QwfotuYC; arc=none smtp.client-ip=74.125.82.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QwfotuYC"
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3282d5302ffso654153eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147694; x=1790752494; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ckd6M0/kQaXv4EzKStJvjOPHWYUMstEuXJOS0IsTFYs=;
        b=QwfotuYCiCvb6Wp82FQQE2y4Vle13dZaf3kVy66L9RzDyJKLNFTxfWtvDyCq0QO22c
         hWMChlmrBsDd6bu9fhXMpidIue6g7TwKIGrdaGVnagP7oaR6E7fTsrJn+tsaUPlj3KyS
         DQePXkCukUWaxcXwpHEH1ZsrBkffOnUF+Oaa9bIdH8s4vP96nh5e4K/IiF9v1dCTYsvC
         RCtF6ehRE5shaMVRJW8Kb6+dg5ydfOX4TAQQpV4WlPXNqbzPRVDMFvsBotBqIGUm9Hlq
         WfF9Aiz0klOuPcG1z88JNtx8JI43PdvZq9HmPDe8p554DopSJYV17B4v8+2HSMixcvIZ
         gXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147694; x=1790752494;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ckd6M0/kQaXv4EzKStJvjOPHWYUMstEuXJOS0IsTFYs=;
        b=XKE5AOCW0XUthyQb4d0VAkdALqSMi+OvXysPXlJDGxqY56IttvVbwZJIJYVQN26Z3f
         ZWs4e4vccGUBtQfbFQQ5tzasz6O/Q4V6W3COADjOJlvCB47CNq7kEFk5ZHj1+ZozKdEk
         Ph8xKsnESZZBTkQc9xcYocn6/P8YRNzPxAWLnJGP1eriBqPOdg8Bo7bq205aTlFW4gV7
         2WbqQeWHPEApj87lx5V4fo7hvYq1Vi9JBVMsWie9ut/yvoEIOxiZg+oKvLyZ+gJ4wAVP
         WT6tfABDsdLalfLubdUPGQKzX2PoyfxNTfeKCBrxD6sLtSBs6VgZj8flpztM0IH1bhTB
         sO7w==
X-Forwarded-Encrypted: i=1; AKwUvBx3pUa6SrEksnFi7gY8xrrs0fNZJhLq8jsic33QwPI0hqmYAmF/3LFVA3Ei1BgltTX8JBng4xRrEIYabdIurFua@vger.kernel.org
X-Gm-Message-State: AFuF++mB12xHS5FINwZxDz9kfjwzSj6b2A7o0gd4FzqfnPwUoRtIkz29
	UKtmRRpd6GKaI3QP0aO1FHcq9lFQdqYmtmcuL348v3C7eAUxG8lFemoIpPFaNu4PpzpqIA4MYLt
	tzsMcODqnkQ==
X-Received: from dymj19.prod.google.com ([2002:a05:7300:6b13:b0:33e:51c3:47b8])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:693c:810c:b0:33c:1449:bfda
 with SMTP id 5a478bee46e88-33e7a9b03a5mr2125812eec.7.1790147694066; Wed, 23
 Sep 2026 00:14:54 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:14:01 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <58ce3260eeba03521a8104db96dea1756a4c00e8.1790145937.git.irogers@google.com>
Subject: [PATCH v5 21/23] perf test trace_btf_general: Drop --max-events=1 and
 make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

trace_btf_general.sh used `--max-events=1` with `perf trace` on
commands such as `mv`, `echo`, and `sleep`. When background activity
occurs or tests run in parallel, `perf trace` can capture an event
from an unrelated process and exit prematurely before recording the
target command's syscalls.

Drop `--max-events=1` and let tracing run until the command completes,
checking for the expected output with grep (matching trace_btf_enum.sh).
Remove the (exclusive) tag so the test runs in parallel.

Running perf trace in parallel is only safe now that the probe tests no
longer name their probes "vfs_getname...": perf trace opens everything
matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
those probes and make their cleanup fail with -EBUSY.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_btf_general.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/trace_btf_general.sh b/tools/perf/tests/shell/trace_btf_general.sh
index 7a94a5743924..4d654b687a4e 100755
--- a/tools/perf/tests/shell/trace_btf_general.sh
+++ b/tools/perf/tests/shell/trace_btf_general.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace BTF general tests (exclusive)
+# perf trace BTF general tests
 # SPDX-License-Identifier: GPL-2.0
 
 err=0
@@ -27,7 +27,7 @@ check_vmlinux() {
 
 trace_test_string() {
   echo "Testing perf trace's string augmentation"
-  output="$(perf trace --sort-events -e renameat* --max-events=1 -- mv ${file1} ${file2} 2>&1)"
+  output="$(perf trace --sort-events -e renameat* -- mv ${file1} ${file2} 2>&1)"
   if ! echo "$output" | grep -q -E "^mv/[0-9]+ renameat(2)?\(.*, \"${file1}\", .*, \"${file2}\", .*\) += +[0-9]+$"
   then
     printf "String augmentation test failed, output:\n$output\n"
@@ -38,7 +38,7 @@ trace_test_string() {
 trace_test_buffer() {
   echo "Testing perf trace's buffer augmentation"
   # echo will insert a newline (\10) at the end of the buffer
-  output="$(perf trace --sort-events -e write --max-events=1 -- echo "${buffer}" 2>&1)"
+  output="$(perf trace --sort-events -e write -- echo "${buffer}" 2>&1)"
   if ! echo "$output" | grep -q -E "^echo/[0-9]+ write\([0-9]+, ${buffer}.*, [0-9]+\) += +[0-9]+$"
   then
     printf "Buffer augmentation test failed, output:\n$output\n"
@@ -48,7 +48,7 @@ trace_test_buffer() {
 
 trace_test_struct_btf() {
   echo "Testing perf trace's struct augmentation"
-  output="$(perf trace --sort-events -e clock_nanosleep --force-btf --max-events=1 -- sleep 1 2>&1)"
+  output="$(perf trace --sort-events -e clock_nanosleep --force-btf -- sleep 1 2>&1)"
   if ! echo "$output" | grep -q -E "^sleep/[0-9]+ clock_nanosleep\(0, 0, \{1,.*\}, 0x[0-9a-f]+\) += +[0-9]+$"
   then
 	printf "BTF struct augmentation test failed, output:\n$output\n"
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

