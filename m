Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12CA28C5B1
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 20:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791059166; cv=none; b=SiZX67MfO9YmLvmexz9ynZqSV38aluUAgmehvf6vw3XhjG0FXrgpfOizk79OtMxMH5yiSg9ad/zftwAtQyWXRWUCzdGXHno2Y4PC7QBe6DS1oRD8eh6envQvio3/FBogcU43R20UilGp6ObesEkQBovu+fzxCwoEZf5cPPo6q80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791059166; c=relaxed/simple;
	bh=bHHYTKEvhy497h0vRpKlx+gnm0E4LBYa9PJg3HjQC0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m8UC7X9kKhuWXzINSJ+wr5eMAxLZAvVqdHJmUXrY0A32XvSov55MlGKY0gIZ5GLVqOmm8WNJP8/RTdi5vRq5zYWCbug3+9YH8N54sOHuvtObFbvg/miVKZTkGW7DHq93/PjGxnblV6ySPO6x0ujwge2MMQ1wNBdSd7UHrLS0BEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdTWfu9r; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdTWfu9r"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3115c4451c8so373507eec.1
        for <linux-perf-users@vger.kernel.org>; Sat, 03 Oct 2026 13:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791059164; x=1791663964; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0s5XHLtBaD6L82b8Uf8sUDVp1ZRpLMtNkprMH1cijPE=;
        b=kdTWfu9rkwVDLI+lMIZEXsAUjcugbS/nHc5o2eozf1y22P3gUUxtgZJcZaL1NivXbi
         1TJ+WsZ4AW8lh8ufxccWA5GJz5Ruxpedzx/DiCpTTxrTRawBtSKEcrv606k84cPsrU70
         hTo5cT2X/LNgWdxYZ6bai+y6jIfzsoUV6mL96nUSVWCnpp+qN8u50TDsaV9Q2KkdPE/p
         osBbN+EJC01qt0YNMW59tG8xFhs8k+rijYuMhlK/qg0RbN98muzoSHfAcnfvv3kPwKE2
         1GtddUDMh1ZaDEEaujO8OgAkxl8ufqHXvlZI3IhsOu86GvnCO8BqkWEP2dLu7i0ux++l
         Nu9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791059164; x=1791663964;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0s5XHLtBaD6L82b8Uf8sUDVp1ZRpLMtNkprMH1cijPE=;
        b=1JSn8a9LQtK7TSzJYRXDkhkrwpVBoc6NnnjAJvo2e/YQCXTqcFrbi/rDnLNKHXLUk9
         iWbUOzAfodxwljoxah5XhjZQb1cz4Mhz8f6kZMQERbHGCSfcr+sNZzN4N29JAWIJVkHO
         fCZsCApuazenbKbzkvE+33znfE7kjNEdJPwgSQQ25UpNZmeQ9pug1WJTzU/D7X0Lyoiv
         Ieh9EDkr8ZylQTTt/ydGxcsLjYusX4XRWU0yGink0jvbm4+fwzsvtSneGaYSmT7SrGfy
         wsJ2PkPLXq8ArBrif3qlHEeXbMxhIFP+rp+AWioysUOvM4PDCB06zwGp1o1wOVa/klym
         wJ4w==
X-Forwarded-Encrypted: i=1; AKwUvBwfFdxLvMKASXy30XQcGC9wXnJ7L+Y7tm3+3tHt8A9AOPoeYXlHoFyNRpfWCC94itiwOCHo6Zi48QhWhNybIgSk@vger.kernel.org
X-Gm-Message-State: AFq9FYKDucF9kDqXYSoJDYUXyJDmxXtEOYud2e5jVmuO5HvZblX9o+UQ
	bUdbg99klg0HT9zd2aPRH20QBnguI/8psP3v2zsRUxQsGcJmy563U7Fz172u/wFU
X-Gm-Gg: AYBFou2MIqfCKkK6sTADLatj3OSKQdxhu30jYtWJlNx1P8629bsTPKcIskNVyxDG3pY
	iee9orNT6SlNIQbdmWgcM40MzIjnc5gBsvpgeCBXGrudTGQytftaqrJAin7qiASwK5DBiC5JquJ
	YrAKK5CoSXSghltQz5IM4ujPAPTo+76/wskeiG82Ys4Gk8CQis6ewGnhPVu1lzLsi/xHvzI0soA
	yB3Rb3siuFP9TpounzO19UkykPaal2ElYXWicCcAzvhX2hv39m1seGnqP/dEftZmx1Wj+AtDAuD
	GUdHGpc1yFXRRS3o6icXDKQBe8kDxyJjEB1AlWhanFRFrIcKJP0R+Oo65SnBPsMJYS4Gzv/iO+D
	HjVC6yPJ3M3S157e4/UAMYOnKf6VI94QiQuyIjSaa0juxdh08+KP6xnBW1cumzoTuVk+d+W6bn9
	QIXLOrLxv2Y0ePVFg5aJ1MYe5v242kfNd/w2xtIJ5WXwaIhrDy9tVNqv7icHmcGzWoG51a03q8c
	lfGE54zB6s=
X-Received: by 2002:a05:7300:c393:b0:351:2394:cb33 with SMTP id 5a478bee46e88-3512394ce9dmr449338eec.27.1791059163705;
        Sat, 03 Oct 2026 13:26:03 -0700 (PDT)
Received: from [127.0.1.1] ([2602:ffe4:407:363:fd57:5fed:bd71:7a74])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f0672c739sm19011641eec.3.2026.10.03.13.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 13:26:03 -0700 (PDT)
From: vineash <vineash30640@gmail.com>
To: stable@vger.kernel.org
Cc: penguin-kernel@I-love.SAKURA.ne.jp, linux-perf-users@vger.kernel.org
Subject: Request to backport "perf/core: Fix WARN in perf_sigtrap()" to
 6.12.y, 6.6.y, 6.1.y and 5.15.y
Date: Sun, 04 Oct 2026 04:25:31 +0800
Message-ID: <179105913174.1859134.5466929391582828993@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Please consider backporting the following upstream commit to the 6.12.y,
6.6.y, 6.1.y and 5.15.y stable trees:

  3da6bb419750 ("perf/core: Fix WARN in perf_sigtrap()")

It was picked up by AUTOSEL for these trees on 2025-07-14 and nobody
objected, but it never got into any of them. As of 2026-10-03,
linux-6.12.y, linux-6.6.y, linux-6.1.y and linux-5.15.y still have the
old check order in perf_sigtrap(). linux-6.18.y already has the fix.

The WARN is still reachable on 6.12.110. A syzkaller C reproducer
triggers it from the exit path:

  WARNING: CPU: 1 PID: 1904 at kernel/events/core.c:6908 perf_pending_task+0x368/0x430
   task_work_run+0x14e/0x250
   do_exit+0xb5d/0x2ca0
   do_group_exit+0xd3/0x2a0
   get_signal+0x2791/0x2800

This is the scenario the commit describes: exit_task_work() runs after
perf_event_exit_task_context() has set ctx->task to TASK_TOMBSTONE.

Testing on 6.12.110 (QEMU/KVM, x86_64, same .config for both kernels):
  - unpatched: the reproducer triggered the WARN in 3 of 3 runs, each
    within about 30 s
  - with 3da6bb419750 cherry-picked (applies cleanly, offset only): no WARN
    in 3 of 3 runs of 240-300 s each

I only tested 6.12.y. For the other trees I only checked that the fix is
missing.

I found this while triaging syzkaller crashes. An LLM-based assistant
helped with the analysis and ran the tests described above.

Thanks,
vineash
