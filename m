Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9721D3E8
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Aug 2026 04:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787633123; cv=none; b=aCORCe1+WG7TSCJpIPWFMmyhCJEWHvDLdB4TrI9hSJ5FHHxVD9iUCZS+wq76hNrNjYDTO0zMM+5Vw98j1yiCzU7JSFzWyj7BDWTAN0oeLISrIc8uyIY4DKaWKic7K37ulE8pI+S+ev+jcHXQEq9E/D9C5PNwI8Wxbi4SWIDnMlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787633123; c=relaxed/simple;
	bh=U3WFWv1FAa4YBLRdz1h9/idaX2U2peMLstx9oXrCK/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a9Evm+qEj5uiTXGwatALiz31f5wkegRJtFHkDqx53cfEUjjN2qFkjGHjKxUgqwBitjTAytc8G4bR/2W2qcnXCChRXx9Y1X5oV6AFJY5a/ffGLekxwpMq1O4fjJthEThsz8G8ZDfRfz7Z5TZ7yIJiWm3zoHuNlaTq+dwnrnqbE/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V7P3Qbia; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V7P3Qbia"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cacb8416a1so37405155ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Aug 2026 21:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787633121; x=1788237921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4h747TT8VehQ9CV4fksBaimDjY6TKEjNHbtfJohstY=;
        b=V7P3QbiaGC4KMQsYpMtpIGUH6GZf2mfhyNIHARPc37Yt/lI4j7rP4JGxdy73Um/yxk
         Vi+ZDb7ena/sN/D5vH0DZKTncZJRWDz3l6TJusrbmVkUQT6KGjix+7sfPzJ8UJciiJnx
         erNL6igCNU8EEaeq8LZmfPKNUQD+py+6v/MQWk9DxaixihVd9wFmnjbLqwduSFZVqwpu
         uXK1pWApFIU1wrnV4um/rkuUjxGo3P2gb3X58bpPzKnprqi09lGutMNWN9cJ7UB96hsj
         hhU87+FRk2hkIfyUE/fD9UYnOQRp4vJuFqLW3twBthqZCc57JiMRbCC8iDW4Z7bBkt2n
         VdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787633121; x=1788237921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4h747TT8VehQ9CV4fksBaimDjY6TKEjNHbtfJohstY=;
        b=Y9RYFPBnPQkwUIpgEAls235v2Y/5X9j1x0V52Coi2skYNQByb8KJ4c46Aug16yCzwU
         PZOtLSc3yd4gS8KrjiROl1nDZXElpa7enCKgQwcpV/Bl6MIsBJ4vQjw4XlS+OeGGueuC
         JIOlZMWeLAyTbNmbqdwPkHZ4cAVtquy7wZ+92OyOf8FdKZU7LTTx0Vw8+PY8uyq+6PGf
         t46nox3TePKWMd1FGExsReSYOY7B+JrDJTUz8KX4OF0neexEUz/esQXEsHhMPN+5uoi0
         p615ocAWNL8+Q2clq3C8PmE3N5FI9Go/YVQ8ZzYG92rVF+KzNS/xS9SO5lOFX2YM3a2x
         mC8g==
X-Gm-Message-State: AFuF++mipKhUslSkUfj/ZZl9bTZLqu4hJfn5FCImi4dl4bUgcznaNkNC
	TM6862mN2AhUtVP70/s5jW1X+xspMl95i5TV2IfV6ablJIvcv5PgKXO8
X-Gm-Gg: AR+sD12zEwbRr4JXPRYLAhorTfETWGoE4cZuQspZ2Nl/SHZyhvB2CEOeD3+zQYoyfsc
	S/KAsTxkoVW7AFlH9x/XbQec8gZJYnksvl7h/5G2TVIFxxe3KegM+sJrouUboIHZWfj3JbnUHc/
	hICEcepfoFp+KFewoqQYN1al/lyvznEn05AZEFVftpNA8X23HOv7+acWjeSeQVlMa/2krmXeWkF
	0F3xikding525IxMAV6I07Rvo/fiVdymQlFmRsLYZSJ/ci8NKw5T9VUciOLn1osuGLBh3rnHhp0
	va9hy6bwJ5IIdsgQ8+okZZOw80A+/ZfUZzxTgvIO54nWwZ6vLNGRy4whoaasdtS8rCe9akJAMWw
	+7s8Ny5tyGnrqe3yP7oVsUNfEVUKt2v9bpAJLVRN3om/a0wA1I/tJ3To3D0H148A1TArK0Uh/L9
	41O1+zuczNNsuU6yWnVOnMstuq7sMgjZ4ysBPUuirx1zCiRrGGI64iOActPHq2WhnzgW5sNsrKn
	JcCqX7bZhveB+dBF9omZSX1z78p262QyGLxR9sRTHp0w9KCGdnM
X-Received: by 2002:a17:902:f647:b0:2cf:afa5:b19a with SMTP id d9443c01a7336-2d6dcbc9385mr79767655ad.11.1787633121117;
        Mon, 24 Aug 2026 21:45:21 -0700 (PDT)
Received: from deepanshu-Legion-Pro-5-16AFR10.. ([2405:201:682f:383f:a40b:24a4:97db:bc6])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32801d7f812sm29372091eec.1.2026.08.24.21.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 21:45:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	daniel@iogearbox.net,
	andriin@fb.com
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH v2] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
Date: Tue, 25 Aug 2026 10:15:07 +0530
Message-ID: <20260825044507.15217-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During fork(), perf_event_alloc() reads parent_event->prog locklessly
which can race with concurrent detach clearing and freeing the prog via
perf_event_free_bpf_handler() or perf_event_detach_bpf_prog(). This
can result in a NULL pointer dereference or use-after-free in
bpf_prog_inc().

Fix by using READ_ONCE() to atomically read parent_event->prog into a
local variable and bpf_prog_inc_not_zero() to safely increment the
reference count only if the program is still alive. This handles both
tracing and non-tracing event types without requiring any additional
locking.

Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
v2:
- Drop bpf_event_mutex approach which was wrong for non-tracing events
  as perf_event_free_bpf_handler() operates locklessly
- Use READ_ONCE() + bpf_prog_inc_not_zero() instead which handles both
  tracing and non-tracing event types safely without any lock
- Remove extern bpf_event_mutex from perf_event.h (no longer needed)
- Remove static removal from bpf_trace.c (no longer needed)
---
 kernel/events/core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index ba5bd6a78fe7..39755bfacc55 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -13433,11 +13433,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		overflow_handler = parent_event->overflow_handler;
 		context = parent_event->overflow_handler_context;
 #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
-		if (parent_event->prog) {
-			struct bpf_prog *prog = parent_event->prog;
-
-			bpf_prog_inc(prog);
-			event->prog = prog;
+		struct bpf_prog *prog;
+
+		prog = READ_ONCE(parent_event->prog);
+		if (prog) {
+			prog = bpf_prog_inc_not_zero(prog);
+			if (!IS_ERR(prog))
+				event->prog = prog;
 		}
 #endif
 	}
-- 
2.43.0

