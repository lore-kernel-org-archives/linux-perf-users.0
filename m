Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE4C2798E5
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Feb 2026 16:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049262; cv=none; b=RTRONUShF4HOrHRuaOxky1okUSHuaz6TOOCSaiEk1mXAxKr6NnB6obMqUuDskt4U4hayybYC/dMLmYQBSpup6mbo/zGhGk9lc625ACMDCkIC/WwtWX7lJ7+IjoYJR1L9kfHgX79j+e5yyYm5zDqT+D5eQ+kq+oolx8lMGFM4A78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049262; c=relaxed/simple;
	bh=2+sFTI4Twi70XgQ/Tit5ZeoczWokFQjiFzARk2LlBzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o7632KET95r93d9doS9WfQ5+z3b2DtyjSAIvjNUPPofbIbv57ca8zF7+m4m3uULm4uS+R5zYSDgOwPvICdui0mKQ/Xd5oXefv6dcPPbbxvSDEppW28ZfnMnur+U6Gy/WD8+CjIxWc1mxF21pXBv7iXoBg1UwcQlKESDX27yCKm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1pyoAbi; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1pyoAbi"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-81f39438187so2648338b3a.2
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Feb 2026 08:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770049261; x=1770654061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xzWCXgQVP39cSNB7GkVYMYPIhqlyfZ+BI+Aqz0QKBJg=;
        b=l1pyoAbixoiVq3D6q6JIiPmfzHtHtyw1mXOrT37B5P9ilgu4+CKjugVsFh0h0f8dBx
         vowAVu59E+LN+P403v2EoloH5mk+QXvF5pxcar4pgmUq5Xus1pOo17UJQ80G7QWsOB/t
         ftmpI5VJh/x/yo6FUWatMqe+3IeHMxmCATRRM0BEsrWG6EfBSpHXGiQ1IFTVJDcJpbNR
         wIOzPR1EikgBXAlqd1iSQlQrF02Z2sERBUYSyJuWXhHOied5/l7rg1nFg+oKcEasFiMh
         1UXGjQbANyNPCd1NeAo8rc2HadPDTx5owBKXaeiQ6dz9KcomBk9Ar00NsuA1NUvTg4b9
         LJtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770049261; x=1770654061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xzWCXgQVP39cSNB7GkVYMYPIhqlyfZ+BI+Aqz0QKBJg=;
        b=UVsTJYtOK1MvwoG5YlvC/8AssydOL3mTKYZFZ2+HvZ9rlwDwd13gXiRfZ7MgbVzSfC
         1Us82FPTG32Yd8cfN86yPLiICtcFRUkQPlzIDDoACKcZtvj2hO9yZtlzU+IaoMl3T0yk
         moa9wFwV+JDOvpv2L1kmbV+KSTHvdofpa4fGoHKyY4atOnC8MiqXowobMbyYCq2DPUG7
         XPq6f78jTG1S0SQ3DPhElADPZZUEKiiTAoeyWcR7EdyqxVnEOq+NJeGUygrAzhmAZoL3
         FB0QLYHsPcCPNRs2F+UwDpzkBMfZzN8JvUMo4M45JhRkKTVajOwq8AZKbobQZVIC0rlZ
         zdzw==
X-Forwarded-Encrypted: i=1; AJvYcCX/ctPoOqeGOT6RWZ/YZLMsem6SL/+6ligejXjggN8C9i2cUQfoXLZdKPKlF+7sxEC320uHwAkixVLcxNcmdgle@vger.kernel.org
X-Gm-Message-State: AOJu0YwRY0tZhN4fxMnau1Glur8NG/D7V3ZHHqEd5tapa3c5iXMVqWr2
	Tevz4eyLzdrkH/U//qyVqArZGIzjHpq8DUsxe4QTmjI8XaxcfaE+YLeKTc+urmdiLUsBTw==
X-Gm-Gg: AZuq6aJNq2XOElafvHArUidb+XoyaA0pgxnjy5b5JNZWY+eQvBPLRbTxDsN+DQs0ve+
	ldSrA+aBPmRwwzM4rHda17IF9U8czcMEd7/yVH4o8eZZo5TvnRV8lo04XU8oUseik/6hONXc8X0
	XHZTUhtFbCi35ltI5NQZRzgCxwhxdJsiT9eQ6n3EagCAgp/8TlW/UPQe5OJ41h/Vx3driaZeYp/
	cW1xUGuOM4DgjfVUMZyiqwKpR+S4XE4zlywqH+I8YUN3VeEgWqiGA2nTDWPQzJdArMt5sxFNiz7
	VuMmq4RIqr3/o/IxYYPeaUu7xuoxfW0T+k54QuyMSxtSOk8mxQJnm614mjL1307zVXqufhL/21r
	rkjTURSZ6SEcXIYFDIqLdmg5BNxMic9ZPuAbotCFgT6fbvSz7kB0aP64reY3QRBZ3HG0y4ILa1K
	cL5bcKTbxXXAY=
X-Received: by 2002:a05:6a00:240d:b0:81f:4e0b:324e with SMTP id d2e1a72fcca58-823ab66fb69mr10787422b3a.15.1770049260409;
        Mon, 02 Feb 2026 08:21:00 -0800 (PST)
Received: from localhost ([222.205.46.87])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-82379c5293dsm15821644b3a.61.2026.02.02.08.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 08:21:00 -0800 (PST)
From: yuhaocheng035@gmail.com
To: peterz@infradead.org
Cc: acme@kernel.org,
	security@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v2] perf/core: Fix refcount bug and potential UAF in perf_mmap
Date: Tue,  3 Feb 2026 00:20:56 +0800
Message-ID: <20260202162057.7237-1-yuhaocheng035@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
References: <CAAoXzSqHuQd7k9rp878YBG5gbChgOaProPQ6XBzKpy81JF5sKg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Haocheng Yu <yuhaocheng035@gmail.com>

Syzkaller reported a refcount_t: addition on 0; use-after-free warning
in perf_mmap.

The issue is caused by a race condition between a failing mmap() setup
and a concurrent mmap() on a dependent event (e.g., using output
redirection).

In perf_mmap(), the ring_buffer (rb) is allocated and assigned to
event->rb with the mmap_mutex held. The mutex is then released to
perform map_range().

If map_range() fails, perf_mmap_close() is called to clean up.
However, since the mutex was dropped, another thread attaching to
this event (via inherited events or output redirection) can acquire
the mutex, observe the valid event->rb pointer, and attempt to
increment its reference count. If the cleanup path has already
dropped the reference count to zero, this results in a
use-after-free or refcount saturation warning.

Fix this by extending the scope of mmap_mutex to cover the
map_range() call. This ensures that the ring buffer initialization
and mapping (or cleanup on failure) happens atomically effectively,
preventing other threads from accessing a half-initialized or
dying ring buffer.

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

