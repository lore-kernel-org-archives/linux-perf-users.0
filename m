Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FCD372B2A
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776200252; cv=none; b=SItkKx3Igm9+bPzBqK2BmZFPlbFD2WJKwHJpllM/Kjs94WeM7ibwwQlcGt81nFoiAPKcQliGe4x/JMTJAD63SgMfSTSO3cbdAbOSH16TaYOIqEftMaQlIgE2NFh2O0UTFPkxUjQfY5tkp5toPErg28NXcUFmzeR/rNDMRdWZGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776200252; c=relaxed/simple;
	bh=pFtcggkSnreuO7abd9zeWnsDQ3GUR2bcYtkELYF7a6M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OygUYI7wzfwqmqnv9cO5SU9oA2BRvJmrVavaHvEUsn0IRq/yYAjRQsuyjLzQv1gMa1FjB69lBZ+MIQ5rvNL+cPUNuHz92j76koZaofs8t8N5SZ1luFT31eeWFpfRiujzWPfheSEkcbz+rhyhb/FBRwZ8WlNruh1IP7/ivz6OqkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fomEuYBn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fomEuYBn"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b465bf993cso21044115ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 14 Apr 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776200249; x=1776805049; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KNlXiJpMMppCiC6dL8z4Fp8Wz8OMyENA8qMCcjv6v7A=;
        b=fomEuYBnwO1LTSj8cGx4NMFLUMkRRRbOGTjV3T8X5Fpgvr1qe4GzrRes9DTP4EG8H+
         0kemJRBujfnr0Ne2JCi5I8fECwFwXIDIhX5/yJiMlB/DneJkaEPJoSWhHL6k81UR/e2t
         SGdVSbWKqpkPLdG6bWh1x+nMPF3tKYZmK+YEClpk4aIuLIcWISJrAPHkeyIB4vJn2mnP
         kD/5o+8IFoPipji0yeyfWV7Qhut+Uv460/OmDQivsKZnvWApbj8jAHDFx9pfadxX+e5y
         V73ECEDtxUvfYePBxvAdxxtFGhMA0stI35ZycnfAhSaT64M+NZyLDbX7qKcCwQo0dz/k
         RDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776200249; x=1776805049;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KNlXiJpMMppCiC6dL8z4Fp8Wz8OMyENA8qMCcjv6v7A=;
        b=Eb+wQizA9jtY8N60jE6Y0rWk7quuYfo1VQE8co/RI0JOOPdjGmuFtuadLbOpABA8xt
         c5UB/2+3hJoUcj6lY1EVUT65ZyL60+9K9eClSO8EEM4WdOsp2GTjYFqAKppkJ81PtmdF
         bmPOJ9j/ae+xBAHeqVvHTDk+yEcnvDwqMOZNQZ+FYqwWBiqtL6bmV8EGw+uW5NBPayrA
         +YB9iKivX473UeUP+HuwZY7cbN8UkRs9j9YH9VOX1pZX7WNIc3WcA+hhzobJaIJMeVnf
         LOet5hTGPUq4Tqwd1D/hm3rxkluhlVvJ2Mg/z2bcL77lsWtD9NBQ3ocHD2UWv9mxlkKV
         PLhA==
X-Forwarded-Encrypted: i=1; AFNElJ9661SyawVUjc+kqZmwPACScP/SYuZ050+V1iU31sRHSrVxyQYyncXuxoZDsVXQPEE/J65CgYtujn9KUfe2smtn@vger.kernel.org
X-Gm-Message-State: AOJu0YyFPVOTub8a5YTnsRpDD7b1tnmEhsPQ6UuIIlH2m4syR3ceLdgB
	6Nxfck5Fkv3efxs6jVnlZ6KjGoNq7HeaYnConlGFXGnSkwAHCqzg5vkSwsSkKgwdXcZ54KOZxvA
	U7vq73fDC8Q==
X-Received: from plpr21.prod.google.com ([2002:a17:903:3e35:b0:2b0:4da9:9b34])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:fa7:b0:2b0:6e6a:8504
 with SMTP id d9443c01a7336-2b2d5a3033amr179829145ad.27.1776200249237; Tue, 14
 Apr 2026 13:57:29 -0700 (PDT)
Date: Tue, 14 Apr 2026 13:57:25 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc0.605.g598a273b03-goog
Message-ID: <20260414205725.2211169-1-irogers@google.com>
Subject: [PATCH v1] perf header: Ensure read strings are '\0' terminated
From: Ian Rogers <irogers@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Swapnil Sapkal <swapnil.sapkal@amd.com>, 
	Anubhav Shelat <ashelat@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sashiko reviews were complaining do_read_string didn't necessarily
ensure strings were correctly terminated. Add checking for this and if
a string isn't correctly terminated return NULL.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/header.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index f30e48eb3fc3..fa4f6d773874 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -269,6 +269,9 @@ static char *do_read_string(struct feat_fd *ff)
 	if (do_read_u32(ff, &len))
 		return NULL;
 
+	if (len == 0)
+		return NULL;
+
 	buf = malloc(len);
 	if (!buf)
 		return NULL;
@@ -279,7 +282,10 @@ static char *do_read_string(struct feat_fd *ff)
 		 * thus the actual strlen of buf
 		 * may be less than len
 		 */
-		return buf;
+		for (int i = (int)len - 1; i >= 0; i--) {
+			if (buf[i] == '\0')
+				return buf;
+		}
 	}
 
 	free(buf);
-- 
2.54.0.rc0.605.g598a273b03-goog

