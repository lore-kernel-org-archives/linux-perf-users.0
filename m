Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFC63624B2
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Mar 2026 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773044794; cv=none; b=dyWn036Ta+NeJCGd7JZAiQF2CgMTYQw4eC3fDnQYiQBybxXkHudUEOJGfQMeaZXUSN+zSr1ltL+yJBpedeLwwLOBMmIR3qxWoEDa5a+bpoIGOkAfSkDiV4AQeSfw1yTLulKQVdSCkTDWj8cqvyxJ9MAT4L822LJhysFfspG/9GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773044794; c=relaxed/simple;
	bh=gUhojlT5KDkN7eNJVQcpoU+8+ujUhm7ZVIQk0Zwq/Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Fxx7tpVAhKHMlQS3yOdw5glVLdaL+mq7pAA0sNkfhuwIJgoeRXCsxtipflrhzzxepIqCV6NYao3QwsZUpwvPDWG+VP6JoT68ALLjsWO5BX9D886naJemusKC/N8cNv+ihiqWJp8SR6tzejYUgUk7kJ6GVZ/Lt/rvKNdi7Eney8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAO7UTnH; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAO7UTnH"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso21721645e9.2
        for <linux-perf-users@vger.kernel.org>; Mon, 09 Mar 2026 01:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773044791; x=1773649591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NmOcdVPgN2N8Fuv9BcJChf06LFR3HrNs47FwnTPrSQo=;
        b=cAO7UTnHMaFo+JKhzWysjSKxVMMaLvKa1vZQwi8SoNm5WRIxoZiS5Wbo+l8y7KEAmX
         oU3ZPJTmEHfuKTJeg5KCLrO4cf2By2o9NEWI4ufCpmxnXHWNKnlQtAVYpx9PV+0xBUyb
         xUEPoQ7reJ/I5eEzLN6kcpJItB7djRXLSN+bDIAMq4pzlQPc1Wq59Z9mgmyMFiy/j1iZ
         ABIs8aOBn08V+dQcWuKyDSThy8LOOBO4oqKk2owdvHRV8dzG4cio79oyuly7NdM7k2EI
         xIsqObv2OEmIZfmIj9tx16lUnfOvbbwDZh2BodOoTVLLQnuGwPFzjgGidhqWg/qQ+FPu
         n+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773044791; x=1773649591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmOcdVPgN2N8Fuv9BcJChf06LFR3HrNs47FwnTPrSQo=;
        b=YhEh3hEssXTa2WeHvIDQ/jYm3HKam8mvVfJfVIOhCWxisvfJGleWAfHdEIqy9TOlqd
         tlymFmZJ7nSvdFsMbTHrX/viixByTvoaYJvjkUXLhmUTPKxxMK1wCjr+GpETR5rITXem
         +r2E4x4rBuQmbXfeIqoSV0IFKawZmKHoU7gPJTIGkg2dRqeT2Jz+brUeZsn633Qdf66m
         BW4QIXtcLpBYHkrGYAbtBQ6Jhcd1bX5UKggbzOvYDS4R6pUBUc/r+IVA9MepiQ2ImY01
         Td2QFjnU+hEGWThAAoFTyYkVuu/w285PszofTdz5wq9LzPnLTIM2DXUsTI5L3lsHbxCC
         BvrQ==
X-Gm-Message-State: AOJu0YwG8WxS2/mnXifF+oK/FvfmEnD7eKN6hp+K0Buayl4f8hLt3IIh
	Xp1Dw34yTUiadXIM5uLZnQctdVyknEKgCHuRxuNAJGSCvQWEQyyjl8Hv
X-Gm-Gg: ATEYQzyLJQJCQtd35z20ACqavhWrY0BpwWr9t7CFL8c/VYbzMF9fTQt6aLYKUVvt0Ny
	uP8AdbsaGMQYsyUSwb6D1TAtuFVv6V3nY9K8kzqDsjmtTqfWLHxdEYktsWex3t3d9wCUkziVnnM
	IsBsCcZ5OyhYlrDUQpjSalhweRlR+p0NVrtG6biaCcoThdsK84kbgbGZYCUxM7juWvsK44siL12
	HNH955IW5qB3k/WTIjm3ABWeRu52mQoOuu3IEONY+A7hUGYC1ySjqehmkP/w7PHqodpfN+Be1Qb
	EzdJsS8oFzjhDCmwsJocN9hvIS5FenZjOgZjYeVbL/X71NzjsKtTNbZWD6iqeLCtxXTq2V0Lggo
	4+a26sFlhWznXq9KyS5+Z1pCEeIdAZCCJh07hu6lJXO52+I6RHAsBT2iu9ZMRZoT4vOrDjRn53O
	vWO/gjZVOHftM1NPXTnN1qqzy/yB0Eo3ItLZpR2TOjE1MAn2fmoI5BGWzTq5vT
X-Received: by 2002:a05:600c:3e11:b0:485:3a22:69b9 with SMTP id 5b1f17b1804b1-4853a226f66mr48113415e9.29.1773044790994;
        Mon, 09 Mar 2026 01:26:30 -0700 (PDT)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485276bc6bbsm235489635e9.15.2026.03.09.01.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 01:26:30 -0700 (PDT)
From: Qing Wang <wangqing7171@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Haocheng Yu <yuhaocheng035@gmail.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Wang <wangqing7171@gmail.com>,
	syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Subject: [PATCH] perf: Fix deadlock in perf_mmap()
Date: Mon,  9 Mar 2026 16:25:48 +0800
Message-Id: <20260309082548.3084264-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a possible deadlock in perf_mmap() if mmap_range() fails then
perf_mmap_close() is called while holding event->mmap_mutex. Since
perf_mmap_close() also acquire the same mutex, this result in self-deadlock.

Fix this by moving the cleanup(perf_mmap_close()) outside the scope of
scoped_guard(mutex, &event->mmap_mutex).

Fixes: 77de62ad3de3 ("perf/core: Fix refcount bug and potential UAF in perf_mmap")
Reported-by: syzbot+196a82fd904572696b3c@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=196a82fd904572696b3c
Signed-off-by: Qing Wang <wangqing7171@gmail.com>
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 1f5699b339ec..e5ce03ce926d 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7485,9 +7485,12 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 		 */
 		ret = map_range(event->rb, vma);
 		if (ret)
-			perf_mmap_close(vma);
+			goto out_close;
 	}
+	return 0;
 
+out_close:
+	perf_mmap_close(vma);
 	return ret;
 }
 
-- 
2.34.1

