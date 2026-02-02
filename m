Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63FA2874E9
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Feb 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770018689; cv=none; b=Bxlzuzh4o2ttcoyo6DlcSdUOYVREZofytPZxtu7ISEECDNiwPlFEara9q7pDld5aZivzqcObz+k+vTziaKD2TJggc+LBk/WHkvs+f8wav/hUjN/TqgjSvGxUtZqHw2C3oGiziqnFZpzRiaiQ/Pc5+4/MwgSnjBDPZ9QBF5G+LXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770018689; c=relaxed/simple;
	bh=9VdcutY/1HtuM0eOblIVyvBoIezSx1Mw/CCfmtVy3Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BwQCxE2Wq3bAYwu3a57J9POggSvw75UlMlLVX9GbRLPlQ9/2BohZSGov1NX2XX9z+d2brQRT27oudG/DUF8Zb+qGt6FVG1lj1PKOt3kgX+aDwsgLdLzNK5ZdUG7E/GZ6y328x2NmHJCrvxTChYc+6bc59pTRRhEgjdFwgFw4Yrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gdFW3wb2; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gdFW3wb2"
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-82318702afbso3479710b3a.1
        for <linux-perf-users@vger.kernel.org>; Sun, 01 Feb 2026 23:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770018688; x=1770623488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oiA8iwxfevRzDtj5meYZoNEt0fOR2pKNa2ks4Nm0b2o=;
        b=gdFW3wb2F4xYmBr1spYhAOHN+ARLh9s/0AZbF0sGvmUFfDYfY0vrdCGopN+3a8pUph
         IhKgyzE0EOGU8kQLD405N2S8mSQIg0eXDkyCdEcVuOMrTyavJMu9UgZIDz5pi+UqCkcZ
         2Ii+vvPxJKgjLkocXyqjwtEA91/lLh+gqLHLj1G6xEvuvWdMe4iMJzf+tY6WkgB7t0at
         T2ecVzXbEG8W2fuh1OUlFEpGBLu9wzMhxbnfmlE+ZfqHM+ChsNze5bumVrc0RgfXKmWa
         Ckc5OOF3h1WqOEx+FFGQJNivua6NSbyf0IBX07u1EiZedkUhv3Qmztx8I+4oO765DO+H
         q18A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770018688; x=1770623488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oiA8iwxfevRzDtj5meYZoNEt0fOR2pKNa2ks4Nm0b2o=;
        b=mWn98T64Pr2mPNYb/9LTcgtK17ckTERsUxqfJ7C2oQGNre+nBKtayCGwvTtbodv8+s
         zVPA7pXOqXvnZhA4C3ynkPQpuqaWZlf0U1KVhb0dIYT1ieBblOoeXUq8et4VwCmVA15z
         BQFa6hiyiYlTiXhX4DnjHL68ixeftShqNQGtb/cLTkzl9bJkYxY3kn7mTjpBdRfo69fi
         FKjKheuWOkqq1775t/B1zCseZemyK+uJ3dQj8EoNB77d9XOq/+NU8LxoT2ceeM/Lpyxh
         Fd9tWLg9ydM/toYXqMKdVL+cRx7M92wo1Re/Zez6wErTCOB5S23+DX6kklpZd/RCg92L
         dB5g==
X-Forwarded-Encrypted: i=1; AJvYcCXrPekkCSrJHIcv95tMdPb9q0N8tjAdCVQvEFZY/nKUWmsAfrr/ybLXUhyY+x6Ngn3ztxhaXIBVWjdACdZLSET5@vger.kernel.org
X-Gm-Message-State: AOJu0YzXq62Ds5o9b+U/nhXmnN8+IKeEH8tU8aLxaOAxhcJCSv21k2FE
	2Tzn4I9FjjHQY6AWpIKvsABV3Vo3HZ6BIo8rxI3yVc18lPCXO9OG0Ts6
X-Gm-Gg: AZuq6aI4u74/nMg/VHVuw2D/ecPi80aCYgqji+vnbHOF1vVmcaDKwwwtn/uO3lS/3Ce
	jdKInktL4NTECzIGF4omRuhbPjEDYUbT1pfMuNsYl+fvf1YNBGcQ9H2dgJfAVRsk03/iVGo38I7
	XO17QngSBQ1+5WYIja00hZr4lyjUPrrjFRlTBFv39YKTOXPbPpb+W1d8jTkliBQBn8XhyhOrkkv
	4CSC+aRcMMHojW6lM690nu8AuCwN67WG5sdqC4HgM9nUc5cZcJJnypqTIZRfgic5CnK9C/9SBEF
	J0gvkbpA+vk6AdLXdmaatm99DA9XUGlRk2q53jgw8hZr9x4tTpBJs2fDUscPHAUjVe7nr06WzGt
	SpRe8nY1xqsUqFckME2tZj90Ng4recIKBI6QK0tkc5Xyou/4P1KgyfDfRHtlIAiQhrkoPwbf/mh
	fpkyecy4toEG43eloF9InjgUIwWJ/cZKQYaLU=
X-Received: by 2002:a05:6a00:1c88:b0:81c:785e:1216 with SMTP id d2e1a72fcca58-823ab317d52mr10655676b3a.0.1770018687976;
        Sun, 01 Feb 2026 23:51:27 -0800 (PST)
Received: from LAPTOP-1HUHJV8R.localdomain ([222.205.46.87])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b1d024sm15299686b3a.12.2026.02.01.23.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 23:51:27 -0800 (PST)
From: Haocheng Yu <yuhaocheng035@gmail.com>
To: acme@kernel.org
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Mon,  2 Feb 2026 15:44:35 +0800
Message-ID: <20260202075120.4005-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026020157-crayfish-distract-7da1@gregkh>
References: <2026020157-crayfish-distract-7da1@gregkh>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reported a refcount_t: addition on 0; use-after-free warning
in perf_mmap.

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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202602020208.m7KIjdzW-lkp@intel.com/
Signed-off-by: Haocheng Yu <yuhaocheng035@gmail.com>
---
 kernel/events/core.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2c35acc2722b..abefd1213582 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7167,28 +7167,28 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 			ret = perf_mmap_aux(vma, event, nr_pages);
 		if (ret)
 			return ret;
-	}
 
-	/*
-	 * Since pinned accounting is per vm we cannot allow fork() to copy our
-	 * vma.
-	 */
-	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
-	vma->vm_ops = &perf_mmap_vmops;
+		/*
+		 * Since pinned accounting is per vm we cannot allow fork() to copy our
+		 * vma.
+		 */
+		vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
+		vma->vm_ops = &perf_mmap_vmops;
 
-	mapped = get_mapped(event, event_mapped);
-	if (mapped)
-		mapped(event, vma->vm_mm);
+		mapped = get_mapped(event, event_mapped);
+		if (mapped)
+			mapped(event, vma->vm_mm);
 
-	/*
-	 * Try to map it into the page table. On fail, invoke
-	 * perf_mmap_close() to undo the above, as the callsite expects
-	 * full cleanup in this case and therefore does not invoke
-	 * vmops::close().
-	 */
-	ret = map_range(event->rb, vma);
-	if (ret)
-		perf_mmap_close(vma);
+		/*
+		 * Try to map it into the page table. On fail, invoke
+		 * perf_mmap_close() to undo the above, as the callsite expects
+		 * full cleanup in this case and therefore does not invoke
+		 * vmops::close().
+		 */
+		ret = map_range(event->rb, vma);
+		if (ret)
+			perf_mmap_close(vma);
+	}
 
 	return ret;
 }

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.51.0

