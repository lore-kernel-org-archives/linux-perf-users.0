Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4125C818
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788077617; cv=none; b=eWG6XDUvqh14DHV5A6i6WSZsRcj80byZtwtjS2fAbRkWHhvkeLmjSSFfhyAsLMlFwBNKjhcMPNVBknCZr2rvXGfGPlNBHphAo9qp9WtYcUXarPxrvllY79VCiaTJd8ZCYhFaHGjYHwIX8ykpXcHNXN6BicHU2nHXwronovlzu30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788077617; c=relaxed/simple;
	bh=ShQJEB8cv5Zrfc3UuBgw8Kin5pLXDEOo/ululN/tc+Q=;
	h=To:Cc:Subject:Content-Type:Date:Message-Id:From:Mime-Version; b=Rj6osYJiZRD3fUWpq12BP00CR+rNcoBQsQBIYyAXLTx1Ng9v10G9OEIluh4wpnPJ4GBi7g7j3Fr7wNojqPCYl8yoJjBj4SJF3sPDDswFkaStNE6cQG3it9zdmv/GmQqSm0WHoaRp7FRwb+CtwRl9EpajS6e+3tFKVx2HZB67lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=iCZBsWr7; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="iCZBsWr7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788077603; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=ShQJEB8cv5Zrfc3UuBgw8Kin5pLXDEOo/ululN/tc+Q=;
 b=iCZBsWr7m/GiACZ9WW7QdiMSYx283dKkxwou/Nzejk/Nce4d5NlSNrHEMHijRwisyxA7NO
 o97ZRFxreqztuyZ5xOEAgr9fFEGvMmdI79fpnboe6abLynabKjIVn+6Hh/eYUTivBp5taJ
 hd3xIjcE1KXbDkiy3nWJ3P5KMuDxwr/j6VGvB83dALzzAU/pEo3CZ8QhdqTEmBkaDoOail
 RLzvbkCPwsKnvoyfV4BWKFe1uLbbAnw07ESpnZcO2Q+RqurM8yseElgwoGv6d5scT++na8
 Syu5DzTKchdPbEbcbuZI2OTaBs7zAIJkyBMykk1tuimtrdSAwucEdn3JzdIoFQ==
To: "peterz@infradead.org" <peterz@infradead.org>, 
	"mingo@redhat.com" <mingo@redhat.com>, 
	"acme@kernel.org" <acme@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: [PATCH v2] perf: Fix use-after-free when perf mmap() revival races with the last munmap() 
X-Lms-Return-Path: <lba+16a93e621+778538+vger.kernel.org+bug-report@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 30 Aug 2026 16:13:21 +0800
Message-Id: <91825d0335d2f7cc017ee23886ffeef44c1cc633.f061f277.0045.493a.937e.53242f19a7de@feishu.cn>
From: "Security Team" <bug-report@moonshot.ai>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

perf_mmap_close() drops rb->mmap_count *without* holding
event->mmap_mutex (the refcount_dec_and_test() right before the
refcount_dec_and_mutex_lock() of event->mmap_count). A concurrent
perf_mmap_rb() can slot its entire "revival" path into that window
(perf_mmap holds event->mmap_mutex for its whole duration, including
rb_alloc):

=C2=A0 munmap side (perf_mmap_close) =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 mmap=
 side (perf_mmap_rb)
=C2=A0 ----------------------------------- =C2=A0=C2=A0 -------------------=
-------------
=C2=A0 rb->mmap_count 1 -> 0 =C2=A0 (no lock) =C2=A0 =C2=A0=C2=A0 (holds ev=
ent->mmap_mutex)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 inc_=
not_zero(rb->mmap_count) fails
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ring=
_buffer_attach(event, NULL)
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rb_a=
lloc() + attach new rb
=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 refc=
ount_set(&event->mmap_count, 1)
=C2=A0 lock; event->mmap_count 1 -> 0
=C2=A0 ring_buffer_attach(event, NULL)
=C2=A0 ring_buffer_put() -> frees the *new* rb

The revival's refcount_set(&event->mmap_count, 1) is an invisible
1 -> 1 write: the close frees the just-revived buffer although the
other process still has it mapped -- a page-level use-after-free
allowing local privilege escalation to root by any unprivileged user
(default kernel.perf_event_paranoid=3D2).

Serialize both counter updates of perf_mmap_close() under
event->mmap_mutex, so a concurrent perf_mmap() always observes a
consistent (rb, mmap_count) pair: it either aliases the live buffer,
or finds event->rb =3D=3D NULL and allocates a fresh one.

Fixes: 59741451b49c ("perf: Identify the 0->1 transition for event::mmap_co=
unt")
Cc: stable@vger.kernel.org # 6.18+
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
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
