Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 019F42DCC1F
	for <linux-perf-users@vger.kernel.org>; Sat, 22 Aug 2026 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787377602; cv=none; b=DeUIU4oB72Eec1ObbWbXVcijp0oeV+7MEWoSziwbq/k7FSgUmSm9e1lWaLkK401S1xo2TvIoMxuPUi9B+8ORL0kORO+hbByGXJJkRjBUKuvVS+Lt9hsA3wVIZ1AbZdv7IBKdvPdM/Z78JCvC5um9zbur8HsB/Bl0IH/qU+F9IEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787377602; c=relaxed/simple;
	bh=rsxYMIIl9lejcQNSt8h8g+hgwmROpp3hO3YGy6eR2+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLdmzr260tu2lebDautodb4367mfrjJr/6vFnYQ9PK/nyRUKgqIqBs30JkY56QJdPWYjBDnayr5LHC177hPJLL8dRfAqc7nRQR44NfPcEgfOLXYXlOeo3fZjlFL9h/FVPOL8kUwbO/pvX35Ey+khBBjZZdI1TZqVzCavXCUiNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdFWYa/R; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdFWYa/R"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38ea87caafeso1230998a91.3
        for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 22:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787377600; x=1787982400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VwddFd+9ThQQoTgktfYP5DV/IA+A8c1RRw87x6cYdlE=;
        b=AdFWYa/RY3QUUQTgG7Z+DAklc9Wtv++4qwWWyjOr5JqgYJJedJ9/FqOIOBFaiOUsM4
         W3awfsah9b3iB4UZlj4LvURRi90JGOcwPXb1m8MGcKEb5xuM9G/0IVwwP+dlAbJhfHh4
         2Ns/X1ASsQk75k4TjCkQbJNKsZDJA0O30YhLioBpQZwC165XtZs4IYIzBRyDWIL6qJ+V
         LgykSgPHrHO1xFma2z37yisZXvLdN/GSZmcSQVpxDNq8YBT8IER7vqd2oZL0GG0pSMIm
         /1R+xloq3VvIqHc1C5uoh6OOVpdHTyYNRR3bLTIBMvcJUlpqKw6O8z+UtxK5NgQwCf/u
         rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787377600; x=1787982400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwddFd+9ThQQoTgktfYP5DV/IA+A8c1RRw87x6cYdlE=;
        b=YKqlc/bUzvEz42gNkz43sArvmq6ZHB2M89gN/V1oO9gflao2jtb4HAzaVqk1oESaZF
         Fn9d24s+fxq60lY+KZrmgVawMUVrFX/qOqd2QQG4e1bdK3aYQV6jGKKf9c1m7RJpAERF
         8vyofm0vRUMfGQfFH3NxAZYVG5+i4/CxvASICvYz3U7F4760Yo/15sA7Hx0JtNSHMcNG
         Z7Gy6G6tTmWXawivUIsGt5NYuGIFYV+QHUlonRR3v7Ye8cc4BPx9dsFYueN616fdEp5H
         B2lQXAQVN8x5IL848mKeXYG8Rg16XwD57RUUWRRWsgZyMzuknCO+dDOLa0B/tY4cojGh
         ZFng==
X-Forwarded-Encrypted: i=1; AHgh+Rq7rIElC5+FNoS1nOO67aGnc0nCy5qXaXS9KQ6iB/RyeaHQzycWmatyemySiuvnlv6oyHRA0sjShuzyttc8d0EE@vger.kernel.org
X-Gm-Message-State: AFuF++m2kzCJy5bKlBX3J9wk+u/EgqM0i51ouUac3H6lvNsZsjKiXtqa
	lYDg1lZKrYaQGs5whvYp6oS4sUcumm6JVMeIK2rYAjkqEJR/DcmCEN1z
X-Gm-Gg: AR+sD13gGPLEEyl8xdowJMb4tiEVHxi8VF2dONjqRERFilfyhtn/tzfWdxuYMmuzYLX
	p/YNQIcEzpPC/epMRS0e34GuZywCQhDzT7Ls/9XZHbnhBRooJItEdueRHbqCqvjbEVAg79XZ+Oy
	xLmbCD2xFI2bhIyQIAzjFRsnXaP3+ZWIv1Pzl6uM1jKQqF/7pF3UvujXSCsd74nTtgS0C0ONkmc
	HWSV6UDI0y2ZtcIz9lfv4ZzVzv2EnQjZ88GU1OzgcKv2LuJ3n7Bg8Q19tqVbuWYcT6tpqib4vYL
	m/oLhHMIhkTw+Fp9IW4nRMCSdKBd9YEM/7C66ZEWfCNaIgCoeK3HWGhCr0L5IhvyQkFX6aPhItB
	wLh1nNBct1yETOjCnyNDMWkHc/59tcmY8nzQ8QACY80vFAIEV+ict5PedW3uEmHjkA1qbYT18cI
	zfQzSVBXiu7QqhqVvu5jl6e7ZelKvRgZPxeYeThlb96xQcEirofqJ02sjt6mbp6hdkhL856VmzC
	kzAn4O3/4ieGbI=
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-395c3a43766mr23532416a91.15.1787377600292;
        Fri, 21 Aug 2026 22:46:40 -0700 (PDT)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([117.172.231.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183f31sm3444592c88.13.2026.08.21.22.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 22:46:39 -0700 (PDT)
From: Keke Ming <ming.jvle@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH] uprobes: Free utask on dup_return_instance() failure
Date: Sat, 22 Aug 2026 13:46:20 +0800
Message-ID: <20260822054620.452262-1-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dup_utask() installs the new uprobe_task in t->utask before copying
return_instances. If dup_return_instance() fails, the partially copied
utask is left attached to the child task.

Free the partially copied utask before returning -ENOMEM.

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
---
 kernel/events/uprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b25531331902..0c8a664a0fe5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
 		n = dup_return_instance(o);
-		if (!n)
+		if (!n) {
+			uprobe_free_utask(t);
 			return -ENOMEM;
+		}
 
 		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
 		uprobe = hprobe_expire(&o->hprobe, true);
-- 
2.43.0

