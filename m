Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AA132D0DE
	for <linux-perf-users@vger.kernel.org>; Sat, 28 Feb 2026 07:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772262010; cv=none; b=UMavhlF842EJF0OsDYathwNXBooO/N8Er1HWrBK7Zln8mNn3hpoUDlqYp20j5S1ixOde2rO+iSwgJkwWvDHBA2MYMXm6K2Tdl0Vsbp6Yw2f5exBnZ0+InvRxjOSjYc6+u9vNpeLKZyDb0kSjHp653NrlfKk+sOLHwVr9Brix4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772262010; c=relaxed/simple;
	bh=AI+pLYY33VHhLKqPIpo/nh1kToqYssuz+yXMwLog5cc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=Pnxs1083VdVWCiJwlzlXukjtQmwRmmlPiV8u6Z1xVxymhMdopG5M5Epmjmwg5awT7vBGNmsBeLYFvKKaz274hCoD09/U/0/dX4+zAtZcMieROS93r3yWujJa8ZXKldzDO6e/mzxPU+XoX0EjzLmuTu1xAHV4GKX0z62pf5+8gHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HbIkH2xZ; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HbIkH2xZ"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-12776bebeb3so17149101c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 27 Feb 2026 23:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772262009; x=1772866809; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JeIqAOB1U7ToKo6N6NlWrg8Op7bhAW0stIlENTqWOLY=;
        b=HbIkH2xZL1XYtRqzZyEOtrlsZFqjg6sOLxNUE0YuAS/k7b1XEsjhL3jQXUo/ESM+2c
         SF/yFrWNfhukmexEEz3AKzs9wJhX5A6+DS7rGjwRW+RYXlzh7fMsjivGZpORC0w55V9G
         EVZq3y04+TJg+aoNbDaux3/r2Oe9CmY4j0yp2HwBtFrY8ND/prshguqw2wo5Wp/f421E
         dqn5cnUr4gIseO+CHJWWHkvdplpiW5K7A4wwIKvFEuHy0Xb0xK1N2Hrlm8FcibxD+Cf4
         Xzk+CgSLtTZdAbGGpaYFNO6fSSr4yRO9GcjXQ3I5r6pZ7krYw44tdMAOOdc3yT6sJQzq
         Ggkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772262009; x=1772866809;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JeIqAOB1U7ToKo6N6NlWrg8Op7bhAW0stIlENTqWOLY=;
        b=KFgTU5jYLrusZvZaYakOuGa4i9JY/5SaxvWwFTj+xPOwvCgOA4TItQEUhpc+NyqI6z
         F3P0Ws6D9uUiXWj1VcqVdHMhpF4iIedIjHqZ+tUz7rE8s9QngvKIDVY4DAeam0dcCcb7
         kqKdsYKP4SFZGgFDQLaNAyUhQ77TkUGOavXk5RNib5DIwEJ6q+KdlZUonh6O5a180NPr
         KN/hdSrDloyFlktxkJp6bUnNSi7LfCBNdE/Rfo6zDPLBJzs0Ps6kDWsJybtdtZ/91/mm
         VpHskBam2NNkhGhkmSUalqdz2meqt3+YednNnz4ky+lU9UQQJU998yS3psAyWwCI1AmS
         ch3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUHxpuMOyVunMq0CtPR4tw9kYRR0FTVlZ4e1nxmeBk8tBVw/QAEg3DDNxA+Cb+63+1V4vjeqwXzD+o6sTI4wzMz@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlMh4mPEynagpmblXiJ5/SpHa3Q04a6ppRFE3KRkBIRPxs/cd
	z3oLd/b8wz/IGND3yIRM7LXTh07gHuntmKBNML+s+htEUYlkfqJ8x6G8rHja4lMnmC56BFNn04P
	Fs0zRHJ6r7g==
X-Received: from dlbbz39.prod.google.com ([2002:a05:7022:23a7:b0:127:c11:f47a])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:2485:b0:127:5cfd:785
 with SMTP id a92af1059eb24-1278fc28856mr2523985c88.4.1772262008510; Fri, 27
 Feb 2026 23:00:08 -0800 (PST)
Date: Fri, 27 Feb 2026 22:59:47 -0800
In-Reply-To: <20260228065953.3226283-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228065953.3226283-1-irogers@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228065953.3226283-2-irogers@google.com>
Subject: [PATCH v2 1/7] perf clockid: Add missing include
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Derek Foreman <derek.foreman@collabora.com>, 
	Howard Chu <howardchu95@gmail.com>, Thomas Falcon <thomas.falcon@intel.com>, 
	Swapnil Sapkal <swapnil.sapkal@amd.com>, Anubhav Shelat <ashelat@redhat.com>, 
	Chun-Tse Shao <ctshao@google.com>, Hrishikesh Suresh <hrishikesh123s@gmail.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

clockid_t is declared in time.h but the include is missing. Reordering
header files may result in build breakages. Add the include to avoid
this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/clockid.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/clockid.h b/tools/perf/util/clockid.h
index 9b49b4711c76..33dbd8673c1c 100644
--- a/tools/perf/util/clockid.h
+++ b/tools/perf/util/clockid.h
@@ -1,8 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-
 #ifndef __PERF_CLOCKID_H
 #define __PERF_CLOCKID_H
 
+#include <time.h>
+
 struct option;
 int parse_clockid(const struct option *opt, const char *str, int unset);
 
-- 
2.53.0.473.g4a7958ca14-goog

