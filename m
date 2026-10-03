Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FAB70836
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 00:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790986048; cv=pass; b=ob46Ti4sL7ubmrLprXI8y9ITmvP0M6UdaCSqB/IhtMcMTb6ZyPDom/+26bRRfk48a/tt+y+gAQWX+0zayZG2hoBqMbKsUwQSWM1SrVszwlYzsXOO6ho+hFdJQHRJonsKfWZ6JIGl1SrVKkkuzaInKMHFx3SwA2S0epSAd1CC13U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790986048; c=relaxed/simple;
	bh=HfcvLuUEPFWe2mOv6aQ2IkNlSkoxsO/iYToWb+ipXsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szI4fZZHVm6qU73e68h51iiM3gk6cihBgzVpvrQ/PuLj85bI9quxZPv51BOpiKB7ib6IKSi84R05MHhL8sBB7OwYWGzYy0HurNRrLq3CyP3ZsWqE8I5+QckUKdsOrhbgOqgAsOMogsnPHtKRqLwM9pPxbNuGleLVWm1nf09nKHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Svl+yngK; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Svl+yngK"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2e2e064b932so578365ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 02 Oct 2026 17:07:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790986045; cv=none;
        d=google.com; s=arc-20260327;
        b=HySMTmCuJIBVTSTz/e8ACwIU/dDBOqvLvbDwYNqvBZGWtntIVm0EEct8YbAO7372pN
         58aEUR9ymXxDGX3JLeZUKpthSsDx0Nb8+S15dBIdMVufM4vgTD8sXCJXJl/AuGD2t6W0
         86GLTwIpkRCVNq1+rk89osrL12Jybyh2fZuGXcVGvh9Snfb0QSJ3qvB9+x4h1Rbbu2tK
         jnZJgMGBBcK0Jnb6vChrLleujwqX7x9y27yVJl5l2oyCxNLyPUGd7V3W7KqE4XILg10S
         txLOCWK1r6xgDAiGreq+qAU0/xrSIDveSl2d1XMvXcPdFKKjJ2vi6iME7UtUtoMOdp6T
         sLwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HfcvLuUEPFWe2mOv6aQ2IkNlSkoxsO/iYToWb+ipXsQ=;
        fh=ig29Kia9Z8biduLHEWZU/hDBvY3ePY3Cwmvf5YZpjyA=;
        b=l5k9p8xIVBcpe/EZ1/IuOTMn2qKxJfE6Zv+QexMH9XCUROGJCayGGJ5EMxPgKAJ/lD
         lB0h5i+kXJvk0ranmFsH3XLd1aDe7zbU2XhMUHRUl8Z+n0LlJwSHpykMT7hIVm++kXED
         skQ+/sorIRJ8Dt6bsmHbePKOaiEkADCSs8Cfvd4feTXw2WNMN7NB1cnfYVfQYKspCpV+
         RAYXOPTDn5MuVrSUH8ACc4MpKFz6qcgd+umip8yfRoBRnIeY/q6tLThFyHruynkYeRhl
         BJvI7pbyXZYGFqNjliVvhMaIgT2xpHT3/KFDzBL7E+7lZbyhgMRsWsqerzYoJYYIX+y4
         Msgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790986045; x=1791590845; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HfcvLuUEPFWe2mOv6aQ2IkNlSkoxsO/iYToWb+ipXsQ=;
        b=Svl+yngKNLlH1gIMC0XAl/iJHdHc3SgRv/KoV2f/tG77MqV0CxFFSzskpf9Ofo8K8X
         TOWZzSS/e58+MBYguen4hp2H2uR2l4DqnmLHNidyJBqmV3MGMPKqTMlP+Z1PQ0lvERvm
         o2z85XtyL9UmNvEtA6cKIDgkgPS/4Tz970VCWW8cxREiiKpp5ALGMR4gV0RHTLIaomZh
         huNqXsgSq9DvA40ex7XE9huucLXF+ZE8T+b9B7DkbBOQJg9ZkF72Bgn2pqUHPgLG6yjq
         phXN26CKwKIAWJHl8GUQB2gnG9kAYZE9xutxEsEbBfdytsJNSc0K4uqLUITGjmiE8F6f
         Gtbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790986045; x=1791590845;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HfcvLuUEPFWe2mOv6aQ2IkNlSkoxsO/iYToWb+ipXsQ=;
        b=kgEQwoaf7EOcVf8TElSatDl2YpOgZeOsd7dkuEiD7EdBy0sBBMw79KthPMsgvJh8TU
         qQ6v9u05aLEuUeZlb6ZPWgJmPpLkhZBkAx4LiyTOKQBvbMwcMerbrLE0fgnKlHMzHoLv
         sXJbdjhrKY9BKPt1mO1Iq1thx/VKravtD0/ugMGg0kEN7lsorP0ZfyOs7N2QM29siE1e
         lFpjyB4sJ+gCjygtvVFNSr/V62JnFNaHQCsD5631B5wRo8j40urojAQmnYdblEkKk+OJ
         HyPZB3dMf2TMvsIPYpAk9CcmoZO9aLB4bP0L7/IPJ+6SXGiqmWx0UjkPe++rhXS5LNdd
         aUcg==
X-Forwarded-Encrypted: i=1; AKwUvBwzYY5AGo9+xXpowBKcYuOiknSNF09z+Ib/rkNBtUlWiYdguAISzbHPQQjn8NjjPTLDIJr7Jp0uoyv1xt13I1QE@vger.kernel.org
X-Gm-Message-State: AFq9FYKwI/wx+m1p0YCs03P50l+LOtlo5Rz1uFKIMKLvtghgcr/Tcw6O
	Scgplfa/0606HCysn/7cuAzs7qwrL4GGzPU+R2RlezOewezVu6L4yhm6MxIYVuIu1ZFYur+s46O
	Wz7akp73X0ZebhBAeZw1Bo03nP1ku+Mi08c7Y
X-Gm-Gg: AYBFou3vOKXuvZL6tjbAhrFnhNEh5eG8sLztkx6BuYQmgKOfgpHNUiE3RaVznD0nzCd
	QTZlh382Ebr3nqHR/qcY3+9J5PMDQptaK7+jVstP09MmJUfWcywJNN0wHI/p2YA7JvZVO3zj6To
	r0IjTrRGtr8c0aoc/nJZiCuB8cft7uHUfl0zHT9qlkmcfJZnlgmKIdNuyOWIuonlnS7ZHsBCRi/
	YnV6P9Mf8vZTQ6+TzmRNldeEtBySlarlmwCOqkTbqkFLF4LVYQs6f/XFBt/uBchPnyJgjS725b8
	tBS/2vNTTbJ2U5EHZTz3nytm7vVT/iRO+oX18n253gUpBl7gwDusX/kvBjasIlDGC2Ly0wcZotC
	fGO8kSI2sQaQANUY5QTuJ0WfVpy0SV0iGcCrd77lM0AsWhe6EAkr+ZFJQLVfBgQoW8Uz+WwckV6
	PxUj+vSUrNPVXBpEIdnl+05xWKhw==
X-Received: by 2002:a17:90b:5108:b0:3a6:e5ee:52c with SMTP id
 98e67ed59e1d1-3a7877615bcmr603948a91.63.1790986045194; Fri, 02 Oct 2026
 17:07:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811041934.7609-1-phucduc.bui@gmail.com> <ar_fLAeFU4rmrwiH@willie-the-truck>
In-Reply-To: <ar_fLAeFU4rmrwiH@willie-the-truck>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sat, 3 Oct 2026 07:07:12 +0700
X-Gm-Features: AclHuK-xDRj275wrNIYauFmD4ArHDsq6qQwz8Qk8YquS81RnLrT5xbVpnSPRvtE
Message-ID: <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ lookup
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Will,

Thank you for your review.

>
> Not sure about this. If it's optional, why should we bail the probe if
> we don't manage to get an irq? Surely it's better to continue without
> the interrupt in that case?
>

platform_get_irq_optional() returns -ENXIO when no IRQ is available.
Other negative return values indicate errors, including -EPROBE_DEFER.
In the case of -EPROBE_DEFER, we should propagate the error so that
the probe can be retried later.

Best regard,
Phuc
