Received: from va-2-39.ptr.blmpb.com (va-2-39.ptr.blmpb.com [209.127.231.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E8B33344A
	for <linux-perf-users@vger.kernel.org>; Sat, 29 Aug 2026 17:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788024954; cv=none; b=sKvQQ9oR6uO1Yiw6dfgxNj9xjE0XHW9yTzM8dW4AouGI0cbz9EB00xI7ZhJ7qBmhg3TK5xsZTqGXMEoao+XEEg57QNgXhnxAmprT+LttDf3DuUvUB7cCzIy99qMqnahyOU4csUqnkDuW+9IY/BMefIKIGsLEmrHqWdJdauCTdN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788024954; c=relaxed/simple;
	bh=WeTvT36hdL9T5wdUC3yaj6p60df+h2t3e9ntGmnYlpA=;
	h=Date:Message-Id:To:Cc:Mime-Version:Subject:From:Content-Type; b=IKuYOWKrdA9zo+/5QQDeutEhTZnn4Zjx1l35N2QhoHuQN9HwOrBvcfFOqhTlUlemvhQi2vqSG5bwX8h9uj5b6mVa2vrzUKLq8A05Z4neR7Hntoh9TCLzAuAyKmjw26LKpnOZM7D3+uDWT7EMbgscdunNtIpM5lmqigyg7GSoeHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=fbFnPiph; arc=none smtp.client-ip=209.127.231.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="fbFnPiph"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788024940; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=WeTvT36hdL9T5wdUC3yaj6p60df+h2t3e9ntGmnYlpA=;
 b=fbFnPiphSLZ12/bz8tTkEczQP1ChL/lQsA6XApHy90c+K2RvMJhIV/BkRX1Qhc0PcFW5BB
 A5miPIIPl9Iob72DpYdMHCU1IfkXlcMDpQiX2KVV42/hIzBuQP3lMTreTA4NoMDdHY6oao
 uPrpcHYiX5TZKajUeA8Ph+xWMtPHvyoM6KshDJZ1YDudFFtD+FQrZvNKHJ4f+smQtPnQ6q
 DS5UNEEFy74Bl9MPPtA/Wlxk30LCeVn35XdUfuzaJPs85kX0PfJr25rClC58UGoVDaowzJ
 LDQEGbxySkpy2veLe6Xk+Lh/26wzjNbTPkqFq81CNYPhHYzfmXxgtxrJdryaPQ==
Date: Sun, 30 Aug 2026 01:35:38 +0800
Message-Id: <91825d0335d2f7cc017ee23886ffeef44c1cc633.d3b5acd2.2451.4a87.a396.716f586392a4@feishu.cn>
To: "peterz@infradead.org" <peterz@infradead.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"acme@kernel.org" <acme@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [PATCH] perf: Fix use-after-free when perf mmap() revival races with the last munmap() 
From: "Security Team" <bug-report@moonshot.ai>
X-Lms-Return-Path: <lba+16a93186a+815a28+vger.kernel.org+bug-report@moonshot.ai>
Content-Type: text/plain; charset=UTF-8

perf_mmap_close() drops rb->mmap_count without holding
event->mmap_mutex, and a concurrent perf_mmap_rb() can complete its
revival path (detach old rb, rb_alloc, attach, refcount_set) inside
that window. The revival's refcount_set(&event->mmap_count, 1) is an
invisible 1->1 write, so the close side then decrements to 0, detaches
and frees the ring buffer the other process just attached and still
has mapped via remap_pfn_range(): a page-level use-after-free,
triggerable by any unprivileged local user with the default
kernel.perf_event_paranoid=3D2.

Impact: any unprivileged local user can escalate to root on a
correctly configured system. Introduced in v6.18-rc1 by 59741451b49c,
present up to current mainline; v6.12 and earlier are not affected.

Serialize both counter updates of perf_mmap_close() under
event->mmap_mutex, so a concurrent perf_mmap() always observes a
consistent (rb, mmap_count) pair: it either aliases the live buffer,
or finds event->rb =3D=3D NULL and allocates a fresh one.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_co=
unt")
Signed-off-by: Kimi Security Team <bug-report@moonshot.ai>
---
=C2=A0kernel/events/core.c | 8 ++++++--
=C2=A01 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a6c8e38a3110..0d5b1f3c1cae 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7060,11 +7060,15 @@ static void perf_mmap_close(struct vm_area_struct *=
vma)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(=
&rb->aux_mutex);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 }
=C2=A0
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 mutex_lock(&event->mmap_mutex);
+
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (refcount_dec_and_test(&rb->mmap_count=
))
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 detach_rest =
=3D true;
=C2=A0
- =C2=A0 =C2=A0 =C2=A0=C2=A0 if (!refcount_dec_and_mutex_lock(&event->mmap_=
count, &event->mmap_mutex))
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 if (!refcount_dec_and_test(&event->mmap_count)=
) {
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 mutex_unlock(&even=
t->mmap_mutex);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto out_put;
+ =C2=A0 =C2=A0 =C2=A0=C2=A0 }
=C2=A0
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 ring_buffer_attach(event, NULL);
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_unlock(&event->mmap_mutex);
--=C2=A0
2.43.0
