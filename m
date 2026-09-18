Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F051B4FE2E9
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 14:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789740460; cv=none; b=WYLolAjmhEmKmSGZuApt1qQwiGOTgEunRW/xJrSMlQs+AZp1iWgIKt7gn2l8qAZqdNczvMLz82cafUq8XlsHECSLS61IRdonF+jhlCBc2KQ5DnIiGLoODR91ZZEKDOfpslWeDnESSeLjq9p6dU6WWC6UVMRzycJQ15Ln9YATQIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789740460; c=relaxed/simple;
	bh=cUOLtOGC1sSr8NqERNj02XhiosC+nBk1W+33Ik/UsHw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VScoGdk8IohWzbCuN2L3pcTOJteDex+kAd+lDT1qKJwehErvzMzTQDP2nMUrtDCFtTkCWsc9wNOB+liaaT91h7lix3CukAjfgpBR20+YOLotuKg3kuOGUWFO24Z5wCPptP4JP2Euz69VlRRR3uy60V1z4+43s5RHdKYgyeq+d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvm1jm8W; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvm1jm8W"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-39b6416441eso1430120a91.1
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 07:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789740458; x=1790345258; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y1WBF+lhdsNyuuMsRQ/q34du1kWAD6BuZOicdGwPzPk=;
        b=mvm1jm8Wt/spPluT38kpO8IhrpiMJ/An1PYxdyUnItUpnEj/3yamQ3cgYeMEjAyD2G
         kA5Rjqbewlow4rlTCaq9eNIZNt6/a6a0Dxbs3pD51YyOYj0GbMIINX4jvZ+eo3yXi92B
         WHyuhEJDnkUXxjwEeHVSWbgbhlhoUOVQPw7tqPp28jYzi6GJpLYZhbYHmdCAugiP5Zhc
         Qf4cGHOpV9PXtQV/MufxGbIz2ItDUySP6Hwc+wJNQKWPyQj++ErG+Cz/1G8VTHowmwnP
         zmPv2qQoRXOIScOPGGyZW6OKKXskHbbBxAcqqfd9lNGiILN9jm/RBxCGeioESzuuV9BJ
         QTtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789740458; x=1790345258;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y1WBF+lhdsNyuuMsRQ/q34du1kWAD6BuZOicdGwPzPk=;
        b=NNjzYPBcVvTwz5OsnuT65dK9gOJKExI3CPZGsFir2OVU7bXHs9mIyUn9R2xjoQSLV5
         jl/Ud8kdCPLMNwlt8bSXdJsB0zQvDZ3b0tATYAZ46+p3dTcvXmyQpqUe4k77eoptipT7
         yz6t7AqO/XzBtyxWj7rZFT65dg+8SAmRVS1GbNHfwg2CNIRx9oib/h/fApTYRZE2IrR0
         q0jLi2XK5B3YLCMDoVnzansMqTXhaMFTD+93cS0VNh/EW/oYcZSO+3pcj49BwHcjVpph
         SIEMiVoThR0CWKRv/lvGdtDLP9QzDI0eLzs/e95J23pcSe+WPfDLtTM9eFa6VQrPFfLd
         BJMg==
X-Forwarded-Encrypted: i=1; AKwUvBxO99WVJELpc6g0cj4vI6EGYSSop/grXk87NLvGi686TfmTMOLYiEYDtMjqcOeeK3va7+rTojRTqOby422zscgz@vger.kernel.org
X-Gm-Message-State: AFuF++loYkjICiHbkfZchz3VRRBMUBT+JqVfdh1u70gXHHFv2EKDrvVv
	Pcj9L/fLgc800zwWGK3k2tdnMLRomf/29EUDvGxtWZkGYEM0kcpQMV3SvyFCVl2v4Dld6meeL4f
	pjLo/f2m8Vw==
X-Received: from dlzz18.prod.google.com ([2002:a05:7022:492:b0:144:c0e8:a153])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2d0b:b0:39e:4c7e:f044
 with SMTP id 98e67ed59e1d1-39e54fd5f69mr6217390a91.33.1789740458080; Fri, 18
 Sep 2026 07:07:38 -0700 (PDT)
Date: Fri, 18 Sep 2026 07:06:58 -0700
In-Reply-To: <20260918140659.2501976-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1789662556.git.irogers@google.com> <20260918140659.2501976-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260918140659.2501976-16-irogers@google.com>
Subject: [PATCH v3 15/16] perf test trace_summary: Make non-exclusive
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, namhyung@kernel.org
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
2.55.0.1082.g2b9226bbc0-goog

