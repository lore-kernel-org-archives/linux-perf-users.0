Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C69156C74;
	Thu, 24 Oct 2024 17:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729791770; cv=none; b=lZSBiZ5LNAZgA0pTwg4AYYzNQ/5xhoZ2WQyuDLl7kB4mgaMS1nQSFl0CA5aHcTuSrSGW/AmQX0T2zpUHM28VzwvLYo9HKZm6jZF0e/gIPtk5FrItaPVA22y2JyWw/xZdUuilH7sDaLfsC4zJgWJZxr8U5O7B4F+YkCmT4HyovrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729791770; c=relaxed/simple;
	bh=TaKapZwak4BVam/KofY6ElrQvdzM/R0vylL5BtkxssE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p8Cj5+WkefzVG88lk0Qgkeh/mkoXztQZ48VqdLOaJVRIUlrqCWfKogG+8L6Ut2UegY/VPBR8bU2oxLXF598aYh0/2IOx17yxWIA8cSCx0stIBpSOowBuGlVsLTnNb1TVksxn5t4SDIde1R4v7zXa53Bl/Oi1SbJO2DXej56iM3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJWba+HV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJWba+HV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-207115e3056so9944365ad.2;
        Thu, 24 Oct 2024 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729791768; x=1730396568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cD2/32uLGilrXvalwAEGOVb/wAuf03tRfDdXDbDcjyc=;
        b=iJWba+HVPJOZZj2lHcAgCtxYC3l2t1tdjHq0Gh2vyMU7sy90Il5eGhJeIIJ7s7GbTi
         iTsWg6sNGXHwkkoxbvgbN+fntzu84GR1W26Zs60LSGY6gY8UT81CEP/MFeLg8uLNYhea
         FgI9tTWxjgdGNBry+JnPcuGbHNG+ElTSaCzwhqa0rTJOwFq+F4KOx1rrlEEC94O1gP6s
         ARDSre2jrCgRAgCT96cZWdKq0cSP7LNXNTYzLLt7rt2PrDXzqY5HaF9oGmyXJJRho+Wv
         dy6aedideRFWV3T5wsJ1WjGcW7AAYAz/A8gglyxY2DsP9Ivgl28FH8PLcyZH1gMc0Ndb
         WHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729791768; x=1730396568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cD2/32uLGilrXvalwAEGOVb/wAuf03tRfDdXDbDcjyc=;
        b=gJkQaNhSHUplAVALfB5a1//C718Vb3NKTRjemO6igrl7PnamPSLoqS2xb1n0vWxF31
         r2LCnwpZqf1o8v0IVwHXTXUp9HBxuaL3Hl89K4X4DMBkAC1/KLdXUkSZ//HjD7u7bkQo
         nHDvFKi1QqiRnpi/c70Mu7Ozovp5/FdbzvXka/CR3c1kPOTIN7Xfo7QSnDbn+3VlKL3j
         yPgmy8xGrt9GjH0839R/ZYUEzctcIoFN2TySLXn82hdH7X1GICUBzhl7yhNgeWq8KLyV
         aldVdMC+rkFwU5HQCtfJHXLGyB16gj/Q8lkORHakWl/BNxM38zU3dSwHYabNBzSQhx+W
         6eJA==
X-Forwarded-Encrypted: i=1; AJvYcCX++vqyjA4EETWHl8oyL6myHm2SvZiKzm0++P9jYq6Eitz8D+qD++7XAGQF/EyDj5Ul6kjAmeTpzwxZOf363UBEXQ==@vger.kernel.org, AJvYcCXJ6rVEzstlPH4s0VEVKg1YQVPJUHPmf13IIdICG315CwKcRmUMHrM7aduqJ2Lc+cNZJV8Xiyy5Kzpr+TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YytEF1COeMT8ImkEcMGOo/hVRivFBMG5KnJ/FOL7yE9z6Z11SUq
	VGrweYpf2Q5IRiUjHyRbUl3a6MLi/7BklDEEEZ/RuSL4WfcxlgNeVdGYEdTM
X-Google-Smtp-Source: AGHT+IHC/HPQWUGXaSFyPLYxUCFDQIXh4UHoUVXQC2dJxCztCzjhtqPcIOZx4+/4BLpR/BM5L/KObw==
X-Received: by 2002:a17:902:dac8:b0:20c:f39e:4c15 with SMTP id d9443c01a7336-20fb99ac248mr34286275ad.22.1729791768132;
        Thu, 24 Oct 2024 10:42:48 -0700 (PDT)
Received: from mbp.lan (c-67-174-206-244.hsd1.ca.comcast.net. [67.174.206.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7ef0c439sm75268095ad.94.2024.10.24.10.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 10:42:47 -0700 (PDT)
From: Howard Chu <howardchu95@gmail.com>
To: acme@kernel.org
Cc: namhyung@kernel.org,
	irogers@google.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Howard Chu <howardchu95@gmail.com>
Subject: [PATCH] perf trace: Fix perf trace tracing itself, creating feedback loops
Date: Thu, 24 Oct 2024 10:42:42 -0700
Message-ID: <20241024174242.2816126-1-howardchu95@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently when tracing system-wide, perf trace will trace itself,
creating feedback loops. This patch fixes this problem by setting the
correct BPF map for filtering pids.

Before (here perf/2807067 is the tracing process itself):

perf $ ./perf trace -e write --max-events=10
     0.000 ( 0.007 ms): tmux: server/2299109 write(fd: 4, buf: \17, count: 1)                                      = 1 (systemd)
     0.060 (         ): perf/2807067 write(fd: 2, buf:      0.000 , count: 11)                          ...
     0.072 (         ): perf/2807067 write(fd: 2, buf: (, count: 1)                                     ...
     0.085 (         ): perf/2807067 write(fd: 2, buf:  0.007 ms, count: 9)                             ...
     0.089 (         ): perf/2807067 write(fd: 2, buf: ): , count: 3)                                   ...
     0.094 (         ): perf/2807067 write(fd: 2, buf: tmux: server/, count: 13)                        ...
     0.099 (         ): perf/2807067 write(fd: 2, buf: 2299109 , count: 8)                              ...
     0.103 (         ): perf/2807067 write(fd: 2, buf: write(fd: 4, buf: \17, count: 1, count: 31)      ...
     0.108 (         ): perf/2807067 write(fd: 2, buf: )                               , count: 41)     ...
     0.113 (         ): perf/2807067 write(fd: 2, buf: 1, count: 1)                                     ...

After:

perf $ ./perf trace -e write --max-events=10
     0.000 ( 0.030 ms): sshd/2725386 write(fd: 4, buf: r\148\133\163\17\167\194\172bF\231\192\227\194\215\251kBLE\167(\10WY\22\138^\233\28\248\249, count: 36) = 36 (idle_inject/3)
     0.622 ( 0.019 ms): sshd/2725386 write(fd: 4, buf: \177"\251\159\244)F5\224\250\135Y\1865/\30\191\171\140Q\213\182\133\145\224\148\190L\210{\143D, count: 228) =
     9.510 ( 0.014 ms): dirname/2805386 write(fd: 1, buf: /root/.tmux/plugins/tmux-continu, count: 43)        = 43 (kauditd)
     9.788 ( 0.007 ms): bash/2805385 write(fd: 1, buf: /root/.tmux/plugins/tmux-continu, count: 43)        = 43 (kauditd)
    13.865 ( 0.020 ms): :2805390/2805390 write(fd: 1, buf: 1.9\10, count: 4)                                   = 4 (kworker/R-rcu_g)
    15.183 ( 0.015 ms): tr/2805391 write(fd: 1, buf: 19, count: 2)                                       = 2 (kthreadd)
    15.715 ( 0.009 ms): bash/2805388 write(fd: 1, buf: 19\10, count: 3)                                    = 3 (pool_workqueue_)
    18.755 ( 0.014 ms): tmux/2805393 write(fd: 1, buf: tmux 3.4\10, count: 9)                              = 9 (kworker/0:0H-ev)
    19.737 ( 0.044 ms): sshd/2725386 write(fd: 4, buf: \188\197;\82d.1k\197\30\165[L@\153\139\192\173\247k\179kT.m\150\223\216\31\251\255, count: 316) =
    20.173 ( 0.008 ms): bash/2805396 write(fd: 1, buf: tmux 3.4\10, count: 9)                              = 9 (kworker/0:0H-ev)

Signed-off-by: Howard Chu <howardchu95@gmail.com>
---
 tools/perf/builtin-trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 748b061f8678..74a5a3b9183a 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -4326,6 +4326,9 @@ static int trace__run(struct trace *trace, int argc, const char **argv)
 					sizeof(__u32), BPF_ANY);
 		}
 	}
+
+	/* For setting pids filter */
+	trace->filter_pids.map = trace->skel->maps.pids_filtered;
 #endif
 	err = trace__set_filter_pids(trace);
 	if (err < 0)
-- 
2.43.0

