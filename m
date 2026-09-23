Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1164F44E052
	for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 07:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790147698; cv=none; b=BWdYEG5dM5M97UpKmSgvsDlq8+taAtmwzrTEXjHczd7LPxpSv49tRfQfYPKqGfaz4lrKaE3b8pNkrOR6UN1rj6NEIGKa8Lcq+yNNBa8bqftEqMuUtTnrzknpBUangQSdnIlqOddZO6XLL5UVOQ55UHIRyn3HjGqeqUUC78bs3LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790147698; c=relaxed/simple;
	bh=HXPRvYjfzayd9k3WeILA2fGzkmHxlIg55xw4JorqTvE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Iz64KarQ1sAbDwBNoOOTQU9TRhDz95Lst6s1s2sikMVZkWyBginwMSKLifih7mfXunQyhn8wJog1kagrsUHEygF9lm/dh7kxkga8f46H8J3xWGOuWFFFmF1bCq3oSiIOi7LCxNxugVfui+FbKBPQ1JGR85DEi3sMNc5iMkOW5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oqdw4uWi; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oqdw4uWi"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-33baaba6371so1165463eec.1
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Sep 2026 00:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790147696; x=1790752496; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NE2Z5tiC9+s9sK2gJilhCuDRbiG/ftNGrhIItwaECA4=;
        b=oqdw4uWiN/8ce85VGL6vlldti9UxiC1zF/f0x7GVwQmqkOnbxnomY87R8qC38LMm9G
         qKAmGKDtNfLRlNBLh3Gr+GuVLRJ0+/myt/0cTyaIeCnT0QfmGQ9stqZgaXW84Z7dR9ol
         gA0WXv6q4+cuHttg5xbLkbR5jdX7qrtFT7SJQ+rqMiq/yzBQuFdIMN3X4a+Zx643lcSL
         oEC4X3ewJEG9ckgXrHm6gB7PTfYSFs5/xeOi1Mi70sKhmW0DBe8A+o9jlA2fo5BfxVg6
         jGhUZkWlxuar1bQtug+YdKLCX4kDNZ020Y1350wfSMRaulq4WFk8L5fw5lSUoX6uxeqf
         wOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790147696; x=1790752496;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NE2Z5tiC9+s9sK2gJilhCuDRbiG/ftNGrhIItwaECA4=;
        b=Lktr2nX4XBuqYMxSNPoZHRw7y71AAFmhRCtvZCrLIAVl3NJa64TdiOIZa0E+c/+NPY
         5irG4hYqQt3ia81QPBTffUKRANnnzz8H/YrMnk4BmsZatNathlQGVDJ6jTSFU4NHNlRm
         WDFEQKyGb3zw9D6I0igfEBtBkwf1AouIxtBNS5jk5aU6nVxPv9MZ9IpwGflJplNW2FZO
         UrUI33dGYcIy9Z+ZOsSjCbigmN38F95l8f+ijRpxYsDDvFqsGliyIqmdyZ1Sz4NSQzEx
         wqNtxporJ40XCnQ6udKCcgDWiumGk6WuYQDDhk6ql+fSHZlmTOlf6LiGcdzHgG7+CDat
         asrQ==
X-Forwarded-Encrypted: i=1; AKwUvBxEN8qCEjhlkdhcN39t17TIhiPt5CChJUXTx3aEBcC5CBQff7/Ifk4Vfgk6l5KdEKpucUwgz9K9keuS/8m0ACnD@vger.kernel.org
X-Gm-Message-State: AFuF++m988h0Q7A9uEvVl/Pq0ch7fr253MlpX92H/PjIwA43DiveCB8I
	CV/H4PP3I3aqvNvClxecyad7xC+XBZwN9OBj+APZb1+YxKcT7HvQD6CIDY6EU50KtrvZoghYDKX
	05G2HL2jt5A==
X-Received: from dybut1.prod.google.com ([2002:a05:7301:e0c1:b0:33c:3034:dd11])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:de4a:b0:33e:6a58:b03
 with SMTP id 5a478bee46e88-33e8d6cff72mr1692094eec.21.1790147695744; Wed, 23
 Sep 2026 00:14:55 -0700 (PDT)
Date: Wed, 23 Sep 2026 00:14:02 -0700
In-Reply-To: <cover.1790145937.git.irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1790145937.git.irogers@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <68b5cb9502935fd5bfa3acd5332bb78fe8793388.1790145937.git.irogers@google.com>
Subject: [PATCH v5 22/23] perf test trace_summary: Make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, howardchu95@gmail.com, 
	namhyung@kernel.org
Cc: adrian.hunter@intel.com, james.clark@linaro.org, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"

trace_summary.sh tests various summary modes of `perf trace`. It already
directs output to a unique temporary file without polluting the current
working directory.

Remove the (exclusive) tag so it can run concurrently in parallel test
runs.

Running perf trace in parallel is only safe now that the probe tests no
longer name their probes "vfs_getname...": perf trace opens everything
matching a hardcoded "probe:vfs_getname*" wildcard, which used to pin
those probes and make their cleanup fail with -EBUSY.

Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/trace_summary.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/shell/trace_summary.sh b/tools/perf/tests/shell/trace_summary.sh
index 4589b4581419..d0196351243d 100755
--- a/tools/perf/tests/shell/trace_summary.sh
+++ b/tools/perf/tests/shell/trace_summary.sh
@@ -1,5 +1,5 @@
 #!/bin/bash
-# perf trace summary (exclusive)
+# perf trace summary
 # SPDX-License-Identifier: GPL-2.0
 
 # Check that perf trace works with various summary mode
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

