Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3EC3749EF
	for <linux-perf-users@vger.kernel.org>; Fri, 21 Aug 2026 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787282950; cv=none; b=kTNvvNoT5wqM+vzdp6a0cpL+vqunmJ1snWlV4nJA53bUUs8lwP/+8SDvGOoRTlvk4I9tT+PVaRkyXZTxuJJRcgEktHHzhOwq7AJQxqk4i2vYaB9DXBXkAWev+ZwGku01D0AjosY4iHqmtvcw5CndogTxPPrt7HdsRSJ+oyLkIeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787282950; c=relaxed/simple;
	bh=MVswPW0ImM4I38bFgy87d8WVzTdnYOUFvl7l/nkBZGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlA31pU8TZQG0gXYRwAn9lqCK5lrkPoy/vQVx/DWVUsNyLTba8ckxT8ct9ZvHfj909VyyUJsf0LmwlTwePJ8UmWb6GX6+GKohd+qZlBxocwXuD+ImmtRykrfQM2hgoJuSy+iAAo2gGTNBReh1oG1W2fhiP9iUn0rrO7RLwx9rkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6vYb+4s; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6vYb+4s"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38deea72eebso479409a91.1
        for <linux-perf-users@vger.kernel.org>; Thu, 20 Aug 2026 20:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787282948; x=1787887748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yiTS9UrmoBrDPpC0trCnmUAqEmBXDf+UybIjZa54OgY=;
        b=U6vYb+4sBGtguBt2Der3LmhLE3ETuuTvMKv/XLB8xMFvrzhaFNBJS639ZGb1xqpeY8
         wdx465bCBeAT6LHYdIwjKJuzmvynHdCEFiSbEjiNta4/k+2njw/CLKS7ioGxNHloc31e
         mbV0m4G5XAwqMDqbQpl1DWzmozi2YgdnkGdRudxs5aT16eXLBAMXRF5SZwO/KiSF5AWV
         qSIzDY0tq+kaUIDTxLv0wQp+4STZLzrXUurNZCiG77zSQWelo4R+QGT5gaVxwbRmPrg1
         f75l9mSP5Lp0WwMZ1N7No2JHt0/+l6X6d+mvnr3Nfz61uMlXdLslIJU8MgiJ9KVoVaT9
         8/rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787282948; x=1787887748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yiTS9UrmoBrDPpC0trCnmUAqEmBXDf+UybIjZa54OgY=;
        b=qYC/7qLWEWud5BoFA05ckOze7hlI1XVuw4aI21QofF1vXlTzVRyv9iQCJVWSEG52ZA
         WRPr5PvmO/uyCcG7igNW2pugLFPISAIhe1YJanB7dBhbskReQ3yvDYLGa4aUys6td125
         bigxuFcd7IDtTXoyZzNDfxHnpqJzBMfocG6F94SpTT3YJsSTyOpu+m7V01W0y+2MJSCE
         dHHN3VAiRDT5O0E9cxBxqg13jtFis17iFBdrzXDzUR4QcBFSzw4J0s8tCmXA66uPZ+nj
         cdnw9D0bjlDu6fKVDQKNFKW4WDqqzGp6Zqy/17UyYrpn+I1mwClHpHoA3612dCMjirYT
         CmXQ==
X-Forwarded-Encrypted: i=1; AHgh+RoXFc3eY2kSlUrV87HZpKd/qmcdtSb9WBX10iX3M2FHIufom1bGXsl80nyjcGRrC07/TCvy5iu5iyM6TyjcjD3M@vger.kernel.org
X-Gm-Message-State: AFuF++mJ9gMVPOsiEyi1rxy28JfKW4mgt3Krk+TA59zpSuqRljCLKLvm
	V9ctghuomvbSk08a6bKL/6vfGajMLEz/Bq40MqHYi9m7p9/bz7T2qzIU
X-Gm-Gg: AR+sD10nL1kwGcstuywoSuDdtsKzZup8mqeADHmvwTdjPhaGqfyd2P5s55T1zmSEHyp
	MeYfj2e4U7jLTGgQ10yCGK3w4EU20I85NQ4VOmxomFQrQfLjIVtBZQnPBZhcskCae8icLjtlRKK
	DntNJ3m36h320COrcM0BCgF6zlxRPmZp/r5vWT03AxzfLJ0oFxMhAU5WXjfnyZ12F+RkgWQENwM
	z+XN79h5d04UAEH1MCwwRE7s6AZcaLOb85okUz0NS5BLL+3Opo0/7dBHPHpG7tUHuF1TiOMKSjy
	KcZBSYJ1/RBHY/FHHEzJi9hbZ27qGB1bhU6tjUWRIrEyqk98EKjDzVj0JwW9Oq+5htPRhI7l0bE
	W1V6ywoPcnc+kA0GcshNoHs8Skfro2IznhHyp/0VCiEKhOFhNBci50uhdV+H8Kb/HmLoxqTk4KV
	wmNbGMMNdyxzpZgM+gbF/nUxISulU29x8RxnE0NImf/MX07N6xKlJi0RjC/WEKKfIsVqA7LYri6
	m+Z2A==
X-Received: by 2002:a17:90b:4c41:b0:380:7688:fbe9 with SMTP id 98e67ed59e1d1-395c354ec51mr5213544a91.8.1787282947629;
        Thu, 20 Aug 2026 20:29:07 -0700 (PDT)
Received: from localhost.localdomain ([2408:8406:1941:17d:accf:ab29:4a32:29f1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4570e63sm1319318a91.4.2026.08.20.20.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 20:29:06 -0700 (PDT)
From: Li Fangxu <lifangxu22@gmail.com>
To: acme@kernel.org,
	namhyung@kernel.org,
	chenhuacai@loongson.cn
Cc: peterz@infradead.org,
	mingo@redhat.com,
	git@xen0n.name,
	linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	lifangxu <lifangxu@kylinos.cn>
Subject: [PATCH] perf build: Add rust target flag for loongarch cross compile
Date: Fri, 21 Aug 2026 11:27:02 +0800
Message-ID: <20260821032702.4258-1-lifangxu22@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: lifangxu <lifangxu@kylinos.cn>

Based on commit 30f998c992c9 ("tools build: Fix rust cross
compilation"), add rust target flags for loongarch cross tool to fix
perf compilation error:
*** Unknown rust cross compilation architecture loongarch. Stop.

Signed-off-by: lifangxu <lifangxu@kylinos.cn>
---
 tools/perf/Makefile.config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
index 0ba307e78fe1..42c0ef213750 100644
--- a/tools/perf/Makefile.config
+++ b/tools/perf/Makefile.config
@@ -1149,6 +1149,8 @@ ifndef NO_RUST
     RUST_TARGET_FLAGS_s390	:= s390x-unknown-linux-gnu
     RUST_TARGET_FLAGS_x86	:= x86_64-unknown-linux-gnu
     RUST_TARGET_FLAGS_x86_64	:= x86_64-unknown-linux-gnu
+    RUST_TARGET_FLAGS_loongarch := loongarch64-unknown-linux-gnu
+
 
     ifeq ($(RUST_TARGET_FLAGS_$(ARCH)),)
       $(error Unknown rust cross compilation architecture $(ARCH))
-- 
2.43.0

