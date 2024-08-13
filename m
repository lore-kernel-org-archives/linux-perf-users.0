Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18351A0715
	for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562271; cv=none; b=bTAjgM+J5vKiSXHiVeJ9wHHupBDP1XwV8CT0Oe6raGzzVjkH4T5Wnwr0AIxVSIsbeYRHGKIWyx6Jop4mxZsF6uVkqHBwIqeIXTwNV6+5/KSRi9o3bE5pMEaGCtGZnX3fZQgUjWXeyfNqGcaJllBjREvGiixGM1vnm9NMALVA9vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562271; c=relaxed/simple;
	bh=9Chp8Kdbu6SYoSV/XqRtuBNB0Ulomj1BCqRJZlB19WI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nzGR1xVtDFEkj6Q9IwSnxBtmasEt2te+PQsNzVIuyi1HOVBBe+zRsE3n8IstieHlzBmicJSnhwBx/146zau6i/nIs/1rjH2oSnfSCLYFh/g20ZbpeuZCAQC1lGgnm/8Ox0apQlZbfEljQOxOQon0zKF1A9zoHLQKPXBVbZXSh7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PAuH7uDl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PAuH7uDl"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d1fe3754f4so2034322a91.1
        for <linux-perf-users@vger.kernel.org>; Tue, 13 Aug 2024 08:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723562269; x=1724167069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w4KRY8X4IunmA74dEqtckpgjQWJ1kH7nl8/HPopsHUI=;
        b=PAuH7uDl5Gl7xTwu3yB3F/xF/ZurbydAsWO1VBqxwxjmGmgpo4iKptv04vQgblewf2
         FH03WSdbcIu7ypdvF/Ea8W7XLXEU1Ozj9mTc+Ma0lTkG6li7XN+JV9/pw8Ys5hcmNLgN
         vrSwZ/3mjaQuX07k5vGAD8Pleq4qu7hCNXzm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723562269; x=1724167069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w4KRY8X4IunmA74dEqtckpgjQWJ1kH7nl8/HPopsHUI=;
        b=v8l9p1fGQgk7eiPMDoWpiUTfWNGh5fLzDC9kJAJWtFc6BBrAVytl8NvgfiCw229OnC
         aADHQxS2uO4LXtw+RD0tTDMm144PLD+2BFWfCVLN+US5OyBQKeVvhDfR8g2tw+5oIHuj
         sIYp3I8ahBhXSQBTkHFhftQv+iFyY5LiWFB8LeCo7KBakKbQPZH+DzGNwjrTBEIAEEUv
         jpbe08K/K/NYQw6Nu0xsQdGmIIA3kGKHxlGkrhLOE3yzsyJFLCdOnDBLTXiGBGr+BVI1
         hnz6fFKQGHgZvLfAJqVwzMTZ+UUoWgjBYnwt6CE88ydIEAX6o4d7qWt6kSxl2WqAlicy
         X+0w==
X-Gm-Message-State: AOJu0YymimonGMNWZcwwIUuSc/3V8NkTrpbTNauuGnXIIiH2gJn520gX
	yi9QmZ6kzav05/4djWrix0YkOf22U+omcfEe+N5M1QBtSuDAmaDUfDoNoz/zc2YvNEhHAnFQLij
	8J5rzq8TXpq8fuAeGHo07xl8yJfhwsFJn5n3nHkGDfkhgr2hYsUS/d8kkyDniXLquO9QyR2YQ3C
	LvQiF2cvvxsf469C2BgE66XKG9Y6leg4YNq8d1Z5iUFrSpyoNaeLY=
X-Google-Smtp-Source: AGHT+IHXm0x6rVFLg4sEMfOVNl/u+rp1s8fKEkxeX/qIQGEqM6BLnURVvMM4eI5C7/juC0jCPJ61ww==
X-Received: by 2002:a17:90a:cf08:b0:2c6:ee50:5af4 with SMTP id 98e67ed59e1d1-2d3924d8178mr4202148a91.6.1723562268440;
        Tue, 13 Aug 2024 08:17:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d1fce6cfc1sm7409649a91.6.2024.08.13.08.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 08:17:48 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: peterz@infradead.org,
	andrii@kernel.org,
	mhiramat@kernel.org,
	olsajiri@gmail.com,
	me@kylehuey.com,
	Kyle Huey <khuey@kylehuey.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Joe Damato <jdamato@fastly.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] perf/bpf: Don't call bpf_overflow_handler() for tracing events
Date: Tue, 13 Aug 2024 15:17:27 +0000
Message-Id: <20240813151727.28797-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kyle Huey <me@kylehuey.com>

The regressing commit is new in 6.10. It assumed that anytime event->prog
is set bpf_overflow_handler() should be invoked to execute the attached bpf
program. This assumption is false for tracing events, and as a result the
regressing commit broke bpftrace by invoking the bpf handler with garbage
inputs on overflow.

Prior to the regression the overflow handlers formed a chain (of length 0,
1, or 2) and perf_event_set_bpf_handler() (the !tracing case) added
bpf_overflow_handler() to that chain, while perf_event_attach_bpf_prog()
(the tracing case) did not. Both set event->prog. The chain of overflow
handlers was replaced by a single overflow handler slot and a fixed call to
bpf_overflow_handler() when appropriate. This modifies the condition there
to check event->prog->type == BPF_PROG_TYPE_PERF_EVENT, restoring the
previous behavior and fixing bpftrace.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Reported-by: Joe Damato <jdamato@fastly.com>
Closes: https://lore.kernel.org/lkml/ZpFfocvyF3KHaSzF@LQ3V64L9R2/
Fixes: f11f10bfa1ca ("perf/bpf: Call BPF handler directly, not through overflow machinery")
Cc: stable@vger.kernel.org
Tested-by: Joe Damato <jdamato@fastly.com> # bpftrace
---
v2:
  - Update patch based on Andrii's suggestion
  - Update commit message

 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index aa3450bdc227..c973e3c11e03 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9706,7 +9706,8 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
-	if (event->prog && !bpf_overflow_handler(event, data, regs))
+	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	    !bpf_overflow_handler(event, data, regs))
 		return ret;
 
 	/*
-- 
2.25.1

