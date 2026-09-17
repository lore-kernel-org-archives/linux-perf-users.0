Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602C33ED3BA
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789620836; cv=none; b=G+O+GsK3ZG3B22Aw+BCBZ30c0jcwaiMzEwQoIUvhnWF8IkMybtz0dRpCNeDZNYMXhoHlwJUAZnir6yqQODpz4UXZVDbpnljGrb/GjRTjJE64WO08JGk/wCn9tkN3FfO5JAMikAYq34fro2FLgeAhQ2inVQyspmjn5fWOOKxmGPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789620836; c=relaxed/simple;
	bh=bomL0Fes29NNGiiCY3TzkSQ4pBsviafH0dPzLu651Cw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jbj1+vgFgVytzFEGdjocZRrMsDFXa7PLvua4/hXXdbEv+JQw1FUVUBmkTS0h/FsglnO9rRp0wH2UVAoqj17x5cWU+G9vIxXBk/gKkr4qpNoy86/LJu1blE4KhMn0R1y3VFKLR/w1OpFCvkXK2jV+8DHmpWyvpgEy0UmlaHpx3Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E4YsR1Rc; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E4YsR1Rc"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39deb05ef51so711869a91.3
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789620834; x=1790225634; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VNSDlL+6jb41+CT06vw9CimUr/EO1PFanx+ib8Alnn8=;
        b=E4YsR1Rc5VwddVLfFcCKLvVQ4n3fXwzmolbJo/U0heOXZdxP7l5r/VWJ7i2XotH2hp
         u5OUxouki2xXj8uT7P6m/bnfEYGcslH5eYKnkbPlWU0zVZUO+5d4aR+jiBwzloYvZ5Js
         pu/Y+ugk7ejLNr4aT7nXG3uaHQphHY+gk/IL7KL7QRryXIAg6NPYa1MDP3Mm+qI5ZdZ5
         OHE3vGfWRL+S90wYyuNnFIbybT2F8dxE9xGolIXySHHLmoc+OcSTdWwg0K/F5vofeNvp
         LK8MJcb29UXGHd3Q/xWefhSN0gSTCMvnQqzI8UxHy5wz5sF1C630ZC+hxO+VDJmkQBHr
         0pvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789620834; x=1790225634;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VNSDlL+6jb41+CT06vw9CimUr/EO1PFanx+ib8Alnn8=;
        b=VnhVOHS/O52ji1J++Virb0Xb+Iskl7Wh9Jtbb0l9DX+Mv3ONNxzUameqx8okLdeM6S
         Ycq3ObbQv3DHURwi+cX6LN/ecIb6uXTsg+OXfNEizzycF33ByeX6lindjkzBSr3t1nc2
         7gHuaSIVIJRyCkUN9zJgx5nCAsRSUYfqGvn4tOuBePI4BJ7ynFJM1jDSUkDa+XBTGwcw
         udvNNMtCcqM6DbXGShtGGxfVMxKLCLLzYBadYBeU4/QwLI1kMpGpMKxyGpiGmvanUMdC
         IWfkAPAKhaegxJEYYV/VEJFw9aazbWdhwY6y5mOZYXRrijsCBvtijIKVx8+dOr9bgXl7
         AuMg==
X-Forwarded-Encrypted: i=1; AKwUvBzEksLfvmHBHBFTpbKix3eHIVRJ4DUhzszFBNVWmzLtPPZAo6aZuMU8L6nH8AIbO9SbMHzad5zQSQ1JWRej11BK@vger.kernel.org
X-Gm-Message-State: AFuF++n6A19LblT6YOJrRtDe7QFzqyNVQ6SAlDWyNcfyCSimX6Uz7oTU
	FyrzkVvX4gR07yVDZRv8+cga2poxt8wfgca83lBVSjhMfy+hxIBA2DS/ifOeF2dnA8y14Gbl9UH
	xkHpVanjy5g==
X-Received: from dlbqq12.prod.google.com ([2002:a05:7022:ed0c:b0:143:6e21:5b07])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:544e:b0:39e:35e4:d31b
 with SMTP id 98e67ed59e1d1-39e35e4d992mr9190203a91.5.1789620833545; Wed, 16
 Sep 2026 21:53:53 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:53:25 -0700
In-Reply-To: <20260917045326.63601-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260917045326.63601-1-irogers@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917045326.63601-10-irogers@google.com>
Subject: [PATCH v1 10/11] perf config: undeclared PATH_MAX due to missing
 <limits.h> inclusion
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reported:

  When compiling the perf tool against a strict C library such as musl
  libc, a build failure occurs in home_perfconfig() and
  perf_config__set_variable() due to an undeclared PATH_MAX
  identifier.

  The PATH_MAX macro is defined in the standard POSIX <limits.h>
  header.  Because tools/perf/util/config.c does not explicitly
  include this header, build environments that lack implicit header
  inclusion fail to resolve the identifier. This causes a compiler
  error when evaluating the size of stack-allocated path arrays,
  stopping the build.

Add the header file.

Reported-by: sashiko-bot@kernel.org
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
index b2972c35c1ec..5d0cfd86ede6 100644
--- a/tools/perf/util/config.c
+++ b/tools/perf/util/config.c
@@ -12,6 +12,7 @@
 #include "config.h"
 
 #include <errno.h>
+#include <limits.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
-- 
2.55.0.1082.g2b9226bbc0-goog

