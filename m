Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882A2137923
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Sep 2026 04:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789617899; cv=none; b=HVG4+MQVHYmc0602kNtP3OEkm68urWSykIhoTNKAYVs7y44Wgf3hzcWt5TjjRzwJoMHkZOQt6MUp06P0X4Wj7M5HvJrbWt3Zo0SxkInPGgLDgXwVbVLUYXeyj5vh/6qKYp4e2YMHlnKrvejVngOqZsORLKHSrzrUoCIeTN5Wl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789617899; c=relaxed/simple;
	bh=4x6GhmtGWZcDWlCsZP+Z6VHVWD16hV9/GAZe2iE0DSI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=A8wJs5NfMLsT8bcJCipHwM2f17wQfSUReTKMLl0gGyICpf76MRft21ytSrJcckjYubmu8Mt+9wL/39n8F/sXDGS+EpGNuadpBFEat8gB/E9GZOILGTBdS3g4fZANA128JJ0ojtx40UbYDBCWnNWPQk9VddBaSiv1vfDENhRDq3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u+5Pcpem; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u+5Pcpem"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-385d2703b64so398526a91.1
        for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 21:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789617898; x=1790222698; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6KOfG9uLmv3KAcRE/q/Ui3q169Q8pkPefjKGmb/vg0I=;
        b=u+5PcpemIF2jDcMY5A6mNtsXcO/qgB/W86vLEObrP42ygPPaKf+o1xzTLTWuNFh0Vb
         8cDTIMuDLRW7Qk2k62H4vkUH8iTtZH9CAAQj+LPASYN/pqIY4ZNWKF1q+JqRKg4DOAn1
         J7WnPyvG9qok1n2uNonzUoIPC92wO96RyMQGowuQ52/2mqf6Vppc3GL0fnJABh5kd311
         5NpDlgiueA/PtzekYI+QRlsn/1GKfIGUeqZPdBOAvawFk7gdYH27aSG52ALUJ63FhkoX
         MGUWPkvsC9GyNKaLG9qqhyJQBG8o658sSLinx8jMcMPGSS8OmFXTAEt+gsUpaC+Z9Y1o
         rPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789617898; x=1790222698;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6KOfG9uLmv3KAcRE/q/Ui3q169Q8pkPefjKGmb/vg0I=;
        b=O3n2NmA+KB6k/XmBpZ4rUQDf1jvNxAFaL5BSumJdzuvM3l3INlXd6xfNPSWor0czyD
         fFFfRAATI3QBZ/DuXRQ7KwOjUzBytA5cckIS+noVTVQOazRBv+Ug6FlUSvSnfYn1O8et
         +HvIYRlPiDFB0vNSn3ufV/DQS/Q5rsmN/mwowMzdIDP1hCmRGeYSmzRvzSkXVIC3qXZo
         4ExBkA0//lkzMBX+kre5DZcChumZ5pbiXDi9QmDdHHKM79w2NJ7rGoXdP2MsWWc1hb6I
         pSdsbXgLwBrn8RQkTw1p9kqa3uqeIey23blc2qpAVFYN4tKZ2YnnvsZWVepu6iH3UPju
         OoUQ==
X-Forwarded-Encrypted: i=1; AKwUvBw5zBKVTknx8ch7Dh+f5o5n3lPmACvG3yAtcVIP7C4vWc0JNkflukrX96FD3LHdJu0EKbvTyY1JiMHiDyTCddeX@vger.kernel.org
X-Gm-Message-State: AFuF++kbzdQUokehQ7X5IJgDUEeuj7YeVwwH8Nq4zral4QxHNkMteT4D
	PzubAsgNM8EtacYIM7IxP7BUEpaqUJbYgRFLYfgwo8yW4l2fRB2v76DPsUjXqYONjP0fTwp+nvU
	JN5Buxn5n/Q==
X-Received: from dlbur23.prod.google.com ([2002:a05:7022:ea57:b0:143:8d74:244a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:134f:b0:398:a649:8fa3
 with SMTP id 98e67ed59e1d1-39e361588a6mr3047399a91.23.1789617897624; Wed, 16
 Sep 2026 21:04:57 -0700 (PDT)
Date: Wed, 16 Sep 2026 21:04:54 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260917040454.32916-1-irogers@google.com>
Subject: [PATCH v1] tools include: Add missing stdarg.h include
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"

Header file makes use of varargs but doesn't directly include stdarg.h.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/linux-perf-users/20260916062233.192271F000FF@smtp.kernel.org/
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/include/tools/dis-asm-compat.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/tools/dis-asm-compat.h b/tools/include/tools/dis-asm-compat.h
index 70f331e23ed3..1e0586d8451b 100644
--- a/tools/include/tools/dis-asm-compat.h
+++ b/tools/include/tools/dis-asm-compat.h
@@ -2,6 +2,7 @@
 #ifndef _TOOLS_DIS_ASM_COMPAT_H
 #define _TOOLS_DIS_ASM_COMPAT_H
 
+#include <stdarg.h>
 #include <stdio.h>
 #include <dis-asm.h>
 
-- 
2.55.0.1082.g2b9226bbc0-goog

