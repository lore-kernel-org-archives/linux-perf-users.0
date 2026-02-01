Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C50B3EBF07
	for <linux-perf-users@vger.kernel.org>; Sun,  1 Feb 2026 11:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769945693; cv=none; b=iqMFKgM3m4PeExlbOd+xghUi3JT9EUd+ehxVRTztbhCXyQ61E1nYu0jUjseReRUCi95Uz3XzX2GmqJvFTsDPHFdUqjWg6wjlP7mZgQlvA94P2cCfXRHqp1ijro8Z8NrQodwgaFLmzZOdEbZaLB+BLbN19XM55qagkd9VnQrAxdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769945693; c=relaxed/simple;
	bh=eZXo11M6bHHsqgdDRZ6nyiwm1HQFMosjdqmj0lsDnJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCd4QOGAA8aVXlpWv3mNSokjl4xjnLbtUmfOM/Zv6ENrneftR3dzmoAvhiD4v6yDYH+g880IIhxTqexEIdk+xl9uJvn9L1ldpuf23lN5ErKvJkJT2rTdhjP6Q7GD4VoF6YT/l3X451nwcJsemh2fvV6ltpEinMHgxoZFlHDLU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqRIX3/N; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqRIX3/N"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-c56188aef06so1702224a12.2
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Feb 2026 03:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769945691; x=1770550491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2mbN5TpWYvaDU6GwRvqVdLjXhGGLpqs5GSJMcsrbBg=;
        b=jqRIX3/NaQBKeHeNDcfQ7rBQr4+dASUbZb5ojbYqsFcPga8gyHHg7DMWDcW58HPzTD
         5DHbEWAjTB7Q2FMKWFc3uS3hgGcbqANrVQEsfQ3jL8s1MqVyQSteqQ97ni4bzRuhOIyS
         QLR/ePTr4HA7hSnP28pCMlsCH+Dd/9gvXoRbuSUd8enRg4RW/yOSz9nZ+3wcm4GLqOCK
         xFuJKY8kB+K2FF0Q5R5GX/6p9sd6wf36dG4xKB+V+erDgEGibBM/fM1M/5dRnLiHuQLo
         n+A2+LT3tYLvnP55nN7QlBgLpDBjOi38eKtncPBriotksgxLXrtKLJknH0EtgJeIeoH/
         nhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769945691; x=1770550491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c2mbN5TpWYvaDU6GwRvqVdLjXhGGLpqs5GSJMcsrbBg=;
        b=E/lmny9uB0Hu7HYxpACfn4o0D317rKOvvQNmhBqPGJmEg6L1M2IeZDddogOYG3BaRq
         5EiB9jA5N0uVnYzsZxior/Mu5C81TEF4ur4AeV0t5MbCU+g2MZkDjqddnfGHIc1UnG8j
         zXwOSMKoks723z+PkhIaCeR/dn+HwB+hGndvgjEkyB5B3zAYzTK+/84e+iK8h2jAyV0a
         iwdwruA4fb5/0/gRWy5tUqBHaEctdBDSb873/5Hn1zio00Noc4/Mv13QvmMgYfO5hYOS
         4IpnIjyjj65GtxmjADwmWQP5cdDjxqY/VFqbuEyW1cnElwkXnG9210zxW9XPAf5eQlgo
         NjZg==
X-Forwarded-Encrypted: i=1; AJvYcCWvgpcQceUv0ov4Pth+kkypP0roid8yHNbvPq7sHQ3GjypFB5oCbFRwr/U7CWhYJcyDx8Db8ZJkvA45R+ltjkFF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zzkb1HM6O/STODLDSqLZZcvihRDjzw/7cVNU+D7hXX8XUUnt
	atB2tL0VLzoknoU4vAYO4IYcCbKI0T0WF7lI4i7ewOFN1UWd5ArIf71yucNZJK9unFY=
X-Gm-Gg: AZuq6aISUONjXR4maDBnNdL2WnmnI63VbWpNpf2gvAgMGSe4Ppv/5FcKom96myrO447
	Mi4aU0Ie3tNJgv57L5k+DPAyWQHdC3Scr6jXjr5HEE1K/8ldsD+GJIzJdtwWMzWZa+vbkZFbZn3
	C2okMP6GmXbTJYeHjPwaXIAR0CZZHS40VmFA1Ke9FBReI+tVB5FYrwj+grePMbPaiDtAu7LmxwV
	AtJTYDi/NI5eabs2jyT41L8PyrSZFXmqEPI9fP4PBAJlkuyST/rh129zEZm5qc1Q9E6ITiM/ln8
	2gSO6iJHcn1GDqbgIfmP9g+bFuLdJm1U+q/Cf7PtfGcXK1iVXj8WWsUX0ehVQFOQZ3c3O2Ly2F9
	nuMiqDvIxjxev3R+trL/EkRJTWVAG7zrkp2DaACEvV9UgXdKSVwllhnzu/pZmLiOBJt0Zd4ZA4k
	5ggyfWwsJOq+3sMPzDIi01hN1Wigak9PtsELE=
X-Received: by 2002:a05:6a20:43a1:b0:366:14af:9bbb with SMTP id adf61e73a8af0-392e019922amr8124082637.69.1769945691281;
        Sun, 01 Feb 2026 03:34:51 -0800 (PST)
Received: from LAPTOP-1HUHJV8R.localdomain ([222.205.46.87])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b346de2sm115208875ad.0.2026.02.01.03.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 03:34:50 -0800 (PST)
From: Haocheng Yu <yuhaocheng035@gmail.com>
To: acme@kernel.org
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Sun,  1 Feb 2026 19:34:36 +0800
Message-ID: <20260201113446.4328-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020124-flashbulb-stumble-f24a@gregkh>
References: <2026020124-flashbulb-stumble-f24a@gregkh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue is caused by a race condition between mmap() and event
teardown. In perf_mmap(), the ring_buffer (rb) is accessed via
map_range() after the mmap_mutex is released. If another thread
closes the event or detaches the buffer during this window, the
reference count of rb can drop to zero, leading to a UAF or
refcount saturation when map_range() or subsequent logic attempts
to use it.

Fix this by extending the scope of mmap_mutex to cover the entire
setup process, including map_range(), ensuring the buffer remains
valid until the mapping is complete.

Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
---
 kernel/events/core.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2c35acc2722b..7c93f7d057cb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			ret = perf_mmap_aux(vma, event, nr_pages);
 		if (ret)
 			return ret;
-	}
-
-	/*
-	 * Since pinned accounting is per vm we cannot allow fork() to copy our
-	 * vma.
-	 */
-	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &perf_mmap_vmops;
 
-	mapped = get_mapped(event, event_mapped);
-	if (mapped)
-		mapped(event, vma->vm_mm);
-
-	/*
-	 * Try to map it into the page table. On fail, invoke
-	 * perf_mmap_close() to undo the above, as the callsite expects
-	 * full cleanup in this case and therefore does not invoke
-	 * vmops::close().
-	 */
-	ret = map_range(event->rb, vma);
-	if (ret)
-		perf_mmap_close(vma);
+	/*
+	 * Since pinned accounting is per vm we cannot allow fork() to copy our
+	 * vma.
+	 */
+	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
+	vma->vm_ops = &perf_mmap_vmops;
+
+	mapped = get_mapped(event, event_mapped);
+	if (mapped)
+		mapped(event, vma->vm_mm);
+
+	/*
+	 * Try to map it into the page table. On fail, invoke
+	 * perf_mmap_close() to undo the above, as the callsite expects
+	 * full cleanup in this case and therefore does not invoke
+	 * vmops::close().
+	 */
+	ret = map_range(event->rb, vma);
+	if (ret)
+		perf_mmap_close(vma);
+	}
 
 	return ret;
 }
-- 
2.51.0

