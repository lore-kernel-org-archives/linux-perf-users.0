Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9ED1E47C5
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Jan 2026 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769481400; cv=none; b=QHY2cdVxK/hfsWTQCvqdY5mkM/9ExTsayWYgy/Dd929WA02eTjhohs/5kb38VN7f21jxtBMGu9ERs9xqgQgMKPiErBft7J/RmU+3Xdn+ovOsaIsUBQIn7YdFkG3uQ2LAuNTG9FctDz9DABWz70WiKRlDWfI3Sn+llqI0n+d+XSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769481400; c=relaxed/simple;
	bh=F+tzoUQk3ifomcW051GLKp8+ajGqt+EUPGJocn7TrUc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qSABfzxGgQAEKlguuMOI+hLlrWYpaBvtbE07ajWGdxHjX4hzXa35pfJYEpk1y0UdtPHiF5LPYBL2qowvp7UM8VQqpAVjf0LlapuFuNehl9JG1sfs6cV+VFnkEviuquhapZwjH6XWmN9uA+tKXCLygv+CB/uUbQEgFV1SH7YJn4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dkEgzRPD; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dkEgzRPD"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8c5386f1c9fso746200285a.1
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Jan 2026 18:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769481398; x=1770086198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=THmO4JQj7bPj4giF36DhKbwUfPigH//3N5yIhvXZn8k=;
        b=dkEgzRPDIJysibH3nUHXPhFDrzy1XodkrTfJWZe5yih8CZylf4ueCyhwGmNDNsU7cV
         6b9xqiMg7OquQ+d8pK37bww6phegAS3X1gDTSmeFqB3m+Z0DbtqxrfR2l3wu8XwtJTWW
         Sv6x+WHhX18dEV0YErExDACLJFZXOBrH7uVERQFZ42cqCM9gNH8sr9v9cbhGRPtd4LBQ
         pkUeu7mJlLdSPg+VQM/K+Lyma8k8nViBt/WDee7cqbV+vNTO7PzrmZp3JPmbtz2DCq/0
         V11B3xY01Y1RwOUCsVKiJyAQebCjrXRpgthKCms6t7LBftNdS0DMsdPrpYDKPpnYfVlb
         CnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769481398; x=1770086198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=THmO4JQj7bPj4giF36DhKbwUfPigH//3N5yIhvXZn8k=;
        b=nC5bXfYSKhfXvvQ9SL7MSzSudFkNaB3HyAqUgQnkMSWdL92zT58fKd8va6IgVMgH6I
         amJkO8LmWb5wDWv2iiPUULYJtCAszXTSYh5uRbVYAfmiWt1ON7kLlKe2p/QpDb+kCkqq
         O4t7/8WGBDXlDmMO1tRLTrdBBOqHichKiBbZwcSftHhyaQgHvqCEVjl6VmqyzQw6KNo6
         3OL3radOpp92gss2yi0iJPF8cYaxg3tq6ESP4DkU8mt7W2kQcfmcwFcAy7le76g1Hz6C
         hVnlwBZ0ZeU1E72ixy2C7vH99fkZ14xqijfByTUipGILM9/Az60D83KUWBDC1kf4KkFE
         wDlA==
X-Forwarded-Encrypted: i=1; AJvYcCVmwn4g2RpykKcvJizmBw/HCCThku+O4m23PL+WhxCp4Tc2IFrqGlQ2zzncP3QzWbp7aFNhy7/gq67fn67otLcz@vger.kernel.org
X-Gm-Message-State: AOJu0YzbNpRHQiNwb3WSW43wsf5w1stYqM3IEyzpIH/DIIzoXGy6jsIV
	Sqojd/8Wxeqhx4qrOKOUzY5HgG+WR/BbJMuJeNidokxqg7pSHc2n1kwl
X-Gm-Gg: AZuq6aKuEf5KKGmHGO1T0pX0Hycg1sxQIidb0EUdhdLfKPDb+vRWqlOYAgLvaMkE9ax
	WsQ0czIYhCmXi4saFcvGPoe5WsnFH4iHHhOd6xdVFsDpR0/RdOvQiBnOAnIAE/H8dNeRNikPjhD
	HWkq8MY//tOu6CC77iESXNgl0eOemL9Jp3CdAlKvbm8X8/AurrlNCuWIVhe35DnxPc0R8o7fOJr
	5X4U2fOxCZwhtr25rcQEY8PKZt6Z772grU7VpwAgPZ3OOgsFbM0KEMRrrno/bYxthKZT2zB5YYt
	8PW8iLbPH97LJozwYSgnmhoQzjGvp8buJzIwcO0JbFqJ0rkFk9idwzNSuumV+oJvYgwz7EoTG4H
	b6FCQN2ly3QpHuTg3PdwVo8AErrDjOMCqYHwGEMAF24QM16Tco3usAcdVf1ccIk8T4B2nFlQ=
X-Received: by 2002:a05:620a:d89:b0:8c5:33bf:5252 with SMTP id af79cd13be357-8c70b914e57mr32022585a.70.1769481398335;
        Mon, 26 Jan 2026 18:36:38 -0800 (PST)
Received: from r730.. ([46.110.19.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8949183272csm105024566d6.13.2026.01.26.18.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 18:36:37 -0800 (PST)
From: Henry Zhang <henryzhangjcle@gmail.com>
X-Google-Original-From: Henry Zhang <zeri@umich.edu>
To: peterz@infradead.org,
	mingo@redhat.com
Cc: acme@kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Henry Zhang <zeri@umich.edu>,
	syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com
Subject: [PATCH] perf: Fix data race in perf_event_set_bpf_handler()
Date: Mon, 26 Jan 2026 21:36:18 -0500
Message-Id: <20260127023618.1469937-1-zeri@umich.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KCSAN reported a data race where perf_event_set_bpf_handler() writes
event->prog while __perf_event_overflow() reads it concurrently from
interrupt context:

BUG: KCSAN: data-race in __perf_event_overflow / __perf_event_set_bpf_prog

write to 0xffff88811b219168 of 8 bytes by task 13065 on cpu 0:
 perf_event_set_bpf_handler kernel/events/core.c:10352 [inline]
 __perf_event_set_bpf_prog+0x418/0x470 kernel/events/core.c:11303
...

read to 0xffff88811b219168 of 8 bytes by interrupt on cpu 1:
 __perf_event_overflow+0x252/0x920 kernel/events/core.c:10410
...

Annotate event->prog access with WRITE_ONCE/READ_ONCE.

Reported-by: syzbot+2a077cb788749964cf68@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2a077cb788749964cf68
Signed-off-by: Henry Zhang <zeri@umich.edu>
---
 kernel/events/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a0fa488bce84..1f3ed9e87507 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10349,7 +10349,7 @@ static inline int perf_event_set_bpf_handler(struct perf_event *event,
 		return -EPROTO;
 	}
 
-	event->prog = prog;
+	WRITE_ONCE(event->prog, prog);
 	event->bpf_cookie = bpf_cookie;
 	return 0;
 }
@@ -10407,7 +10407,9 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (event->attr.aux_pause)
 		perf_event_aux_pause(event->aux_event, true);
 
-	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
+	struct bpf_prog *prog = READ_ONCE(event->prog);
+
+	if (prog && prog->type == BPF_PROG_TYPE_PERF_EVENT &&
 	    !bpf_overflow_handler(event, data, regs))
 		goto out;
 
-- 
2.34.1

