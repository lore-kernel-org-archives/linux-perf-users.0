Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1DD388E70
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 07:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775634038; cv=pass; b=NIX7vGnKJWM8z+Kyvfo8gHQHC2HVbRjzYKA24PcF+lx8E79RzxXtRsvPKamVKlz+EpBbJEX0i90PV3JrfV6qbRvTXfalVsaWYFpQmD9dM9w1a/nI982QK/BpFSp1wOxaIpiQ/oa9zzivuxFZ2Bavu3EQT5kM2KBQ9Pe0+u/jbRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775634038; c=relaxed/simple;
	bh=6ST/R7Mk1K/C0LynZuCp/NcTwkp98+62E209MH/LQGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=lpyE8aSBD3v6mMAOyqYouGU71+m8dnnELoxgSxyZpnpK8aZZJDtQLehk87Zk5tCBARS1pWsV7OUC/gk5pgAVi71uyyC9Brfl3ubKsdcR+ogwurlzl8ZdcZaW+qZxwqU4zyUw5m5AcbKaRbSV7LOoqZEeywvh8fBFiM3nHq/uJgQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fQwtRJmd; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fQwtRJmd"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b243198058so39845ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Apr 2026 00:40:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775634036; cv=none;
        d=google.com; s=arc-20240605;
        b=TxhxjwcfmXoIhyHkNlM5hHuF0KtabRb/6uLsnzYilgDJ8AABMw8UkCpPZJgt4DlY3S
         bibOLikA74a1UgCqPdVRQQGLz8zjOcqXBjKKj9UpGHajGi7nMByq1EG7CD76FVW/Y3fb
         9lTBGAqBm7t5fTfY/VO/e56XuBupw3KaSyWS+6zQWX95mh5NxnlxiuLZeXycvjZjGY0C
         i69Ecp2NirAvjM11AIsChMEAImh5cOQFuBArWe9rAehejmUwZ1jRBj2a1IWTqCwnsUXE
         Xmo+0EWhR3HsDEYkVDtu6WZh5O4Mbn9pTDWdhrxGSpnte+44/FVctlSa6bHPJxgWkXKW
         R32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fiFn/sYC81v1MyshTmOkdEUOVKYnKmD3k50YuysEBMs=;
        fh=gIcXGLotfzO2ZmnEhSjFNq+ft2UaQ90WGwRr7ybmEa4=;
        b=S2x+n+9tAwm6BfDnDtdvkPBdE/zrr37ItkiPhzOIHrLuluXjL6bengPSc4RYLlBoUt
         LHPDU2Imkye7za4LjKQgsDVq4O+meIVHkmcSsezI8YVo7gvy/8KnWw3hSuJXlzYKUkzK
         tQK2s0kLA2rneKhPduwszPFFwz8fU/lXhfIy0/1QBSr1obic7LSpJoo8qz/sJm1eEJ2C
         LheevSrVwqwc7nRzONoxaU/UxtDwbKtDfceER2QTjPXU0zSkl5hZy0MOzgJV4KvCemRr
         fz9MSQwstRJnYlj2TsRAxuZ6OQOAeQ/YLHoGo7PlnXrvvZacokQQ/SLROM4TmeZ3QK3a
         oxBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775634036; x=1776238836; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fiFn/sYC81v1MyshTmOkdEUOVKYnKmD3k50YuysEBMs=;
        b=fQwtRJmdLsZXtd8YIDeZnULZTxzZdG8gOe012uKrfxeBJVpurNYqgw2CyeXPS/hNt4
         7EYqI+m5FPLU7xS9Qlm4m1ub1FTbdqRzl1gupGt0AZ4ABOQ4ZgEpl+D9M8Z0Lv/9ZzkW
         kd2mAIPOYhrZF+fHsBB6CZu1YIuR37Qt2f2lTklg4T+kryaqSycchfULnLQ8jOxiK6SH
         yZ4CK8IZbP27LuZebZVdpK8t1FJRTBWv+kh/399z+WNtXPzohh/WZpqVpjtGp7s8L5xF
         y0bEm2EzQ8eKsfwc5rE/8uJR7tiAniq4jkawDntL7xkPbu2zg05E3geDWwCSV9FUWiW4
         hTWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775634036; x=1776238836;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fiFn/sYC81v1MyshTmOkdEUOVKYnKmD3k50YuysEBMs=;
        b=p2haeovt7GD/Sk4GJz2Zu0fIVNP/qI39Ak9cHnjB86IpPVRh5rBMniQ7KHGlwIwIPM
         RdscB0KvU2ldzR/I4thiYPRdpLYoFV6v/lzKcdl/4Yh5+Rk9TwjshPbmG5AxGtXPn5gN
         FeafNALswP4m6S7jc3kp3ElesDHReW/ZflNuti2JSCiKoPmIbuaM4qKMvzUTpsJUPPlP
         w5oKLzi3jq0/YeNMIBEjnFI9rpa45jJdEZOUlCUllfrkDEBs8UMynySarSSVjamXfZI0
         kOTOTx+Aw/XE9PZo0JEqGtbQ/XpSGMByGeU/BtN+g9f+xyFujKOMtieS+we3X+5ReY2O
         Hcmw==
X-Gm-Message-State: AOJu0YzWRwqPfTz7s7vKswUqxyI4ktp8fheGTZfubltdqS5x9akI+32L
	PuWV9ijM8kk+sPM4qPkOWBtoeYr66Ao2wnE9AfR03KlVObkuvdp2GODpLLhPxVegmwRYyK3H7Nw
	0Z77ifzW0BaBzHvHB80hllbTR/8SPckG6Qmt1yoxbtoXpW6LD7IeJss05
X-Gm-Gg: AeBDietPn48KdmncxHv23+tw+eq88EhzOF2RpbudJbBdckijtuvp/lSegrdLCiRzZDO
	t9bl3uLDnEHf51HFBlAzF+LAeGvSmkHI9yKRFlgPWhmyo9+iCfh8OuGA01cx5Hn0T3682bFKMY1
	m0gawF1kX/RiZEH4EkGEfg5x/yYqn9oKkuT/1fb1OnfJD6yt5q92I0Tt3drm31QYgQPUNCgz7pr
	92c3VeA3szSUg7rVy/avvtKfBiRnaYFCElDLSqQlTVug0DFRN5k8bMk9V/hVWSreQVkE+XPHq0t
	svD9UDoEp3v+j/wMukI=
X-Received: by 2002:a17:903:90f:b0:2ae:4808:bd99 with SMTP id
 d9443c01a7336-2b2b96ea173mr1688755ad.2.1775634035323; Wed, 08 Apr 2026
 00:40:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408065841.165393-1-irogers@google.com> <20260408071648.389A6C19424@smtp.kernel.org>
In-Reply-To: <20260408071648.389A6C19424@smtp.kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 8 Apr 2026 00:40:22 -0700
X-Gm-Features: AQROBzDVvDpGYL0NTSNVZ1onC1ehpFI8yicVhhmzVAgiq7qtDq4u8u1cZH2vJEs
Message-ID: <CAP-5=fXOCeKvAe1jxKALy_yM5F76hjsYzYzngOTT9c0JFkoW-w@mail.gmail.com>
Subject: Re: [PATCH v3] perf test: Fixes for check branch stack sampling
To: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 12:16=E2=80=AFAM <sashiko-bot@kernel.org> wrote:
>
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Incomplete regex in `test_kernel_branches` misses user branch =
target addresses that don't start with 0-7, causing false negatives.
> --
>
> commit 81a20991ebd7cf4f6e494b9b81ee11052acea653
> Author: Ian Rogers <irogers@google.com>
>
> perf test: Fixes for check branch stack sampling
>
> This commit fixes and expands the branch stack sampling tests in perf.
> It updates user and kernel branch filters to properly check source and ta=
rget
> addresses, increases system call sampling duration for reliability, and c=
leans
> up test output.
>
> > diff --git a/tools/perf/tests/shell/test_brstack.sh b/tools/perf/tests/=
shell/test_brstack.sh
> > index 85233d435be63..025ed9d3d1105 100755
> > --- a/tools/perf/tests/shell/test_brstack.sh
> > +++ b/tools/perf/tests/shell/test_brstack.sh
> [ ... ]
> > @@ -73,59 +75,80 @@ test_user_branches() {
> [ ... ]
> >  test_kernel_branches() {
> [ ... ]
> > +     # Look for no target addresses without top bit set
> > +     if grep -q -E -m1 "^0x[0-9a-f]{0,16}/0x[0-7][0-9a-f]{0,15}/" $TMP=
DIR/perf.script; then
>
> Does this regex reliably match all user space target addresses?
>
> Because perf script prints brstack addresses without zero-padding, a vali=
d
> 32-bit user address like 0x8048000 begins with 8 but is much shorter than
> 16 characters.
>
> Since the regex strictly requires the first character after the prefix to=
 be
> between 0 and 7, it seems like it might silently miss shorter user addres=
ses
> that start with 8 through f, potentially causing the test to pass when it
> should fail.

Expanding the test to support 32-bit and 64-bit addresses in the
regular expressions is out-of-scope for this series.

Thanks,
Ian

> > +             echo "Testing kernel branch sampling [Failed user branche=
s found]"
> > +             err=3D1
> > +     fi
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408065841.16=
5393-1-irogers@google.com?part=3D1
