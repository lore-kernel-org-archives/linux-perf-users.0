Received: from mail-pj2-f38.google.com (mail-pj2-f38.google.com [74.125.227.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE7E42A178
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121762; cv=pass; b=ZzMSjmZWCyTHieGAR0bq/96nAXTc4JYOHiOBNX9T8TnL8L9TUr5kgwbpx5HBQ3Jebf+pZiuzxkv1i3JCJ4d0Jf/HtFIcjXqaXbvE8Wh552GRU1tKrHhiy6PL1ZqbPyfs3CTrS/caUxrqZ+n9TYYWu9qr1ED+rRVsLjJ6b15FqA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121762; c=relaxed/simple;
	bh=LyXYJi1TmEPA7YN4VjpOXnC86f2Qy5TpD0Lev829kQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AqatUpjLCWJS8LK8t8DzgcbRHRO9/lUGLXom53ZzuOOe+pFIqfSBMGt9g/1n5O4Hc1JZ+Hcy3n8ufirPf/nUdKfcKnz7e3/C+9Jm1TagxjPlm3DhUFZfYG04XO9LaLAKGRH1p95Ll63/tbR1WcIqLn+WZgRUP2YRUvKcBlKb3G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+XPYcow; arc=pass smtp.client-ip=74.125.227.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+XPYcow"
Received: by mail-pj2-f38.google.com with SMTP id d9443c01a7336-2e2db9f927cso3310995ad.1
        for <linux-perf-users@vger.kernel.org>; Sun, 04 Oct 2026 06:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791121760; cv=none;
        d=google.com; s=arc-20260327;
        b=c2wfs0EZuRXuB3pJsXMRHQgKAvwPQCo1em53dTkmD8j2R0c5PUIVO8AJGBhAtPhp9d
         Aqa9stG+SWjmawzwCXk3e3t1Uf/zF6It4xRW5ENLtpzf5HwkX2plz56OhqIaqxSUXQJ0
         3bA+f5tYJQEA6cz104abk67kz8VTt04OzSzSsycwz55pBHqC1epQ7hkaDVaF/g4+0GDa
         JnRqnETLEBlHEY9lbWPYKWN2YHLMnDXuw1ShNqnEl05kRym86maoic1MzGr2E0xkMyut
         jqKRXOwy6ZclZYhie4Na4KrUM2EOOpBP7ngrO+MSWIzkoFywNYGwHa7tMAsfcVZ2kKl/
         i4nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=LyXYJi1TmEPA7YN4VjpOXnC86f2Qy5TpD0Lev829kQs=;
        fh=6svfyhKmd6N4spd2S2bOS9GKqNcYONQzkI2gh72+/vM=;
        b=Si8PSF+x5rO7YBRfDe3qjN+G7JCCcOYXhn7aJhTMZhiPcYuB9X0J4IgN/jxeRfBwvp
         gRlKk37JzO6sthVew8jxeUmyqv8NZMzl6NiNbNxFhi5prDOpj7iRCezyiF7p7NiWZMVP
         BCqCG+p75tIcfcDn2kSpQGIynV3s3pNLlCYuF9mRZ5Ja3wl1BNc0YZup70NzUpIkHSXD
         XZoOYP9iNI+1jd0weDGOoCvEZiHdv1G8QtfhLej3Sls9WJp2GhfEnublUXI3Vh8mcZbM
         E4Cp3hqMDTNmfUn9M3gIOjAcou0lSOEN00vt7VKAmQ4QMZ2g6gX82KkuNQsL8pSVqd0R
         QqQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121760; x=1791726560; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LyXYJi1TmEPA7YN4VjpOXnC86f2Qy5TpD0Lev829kQs=;
        b=T+XPYcow1Fp1qKBICG2GU7LbXClqksNRU4Mg1A6ABipnIdRJrx6GkNMyYy3mln3bRf
         uCKNxv0t0NXEXCnkIVofnH+tSi3FIlRj7rX8nmlpwTZoNHKtrVX7AFJ3kLdwl+6/fI5W
         HXh+iV4ERcvu5Ze6oy+XgS+zSlu5/MtUJZQJgy3AOVMZ3gkk92UdqF9ooQ6WXuzvQYD1
         DievlNO2hJdBWNjpkVdjVW6mLlAGaUF090BIkSXJngMeteY9aijasZE4MRCo3NnN33cI
         +7E5qeZJTrmRcRTZAHmI2r2ZmSKxIaBNQUUYx0Ls7DzbHhaOP2dEDD1qt/Tr2cqueNpN
         h2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121760; x=1791726560;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LyXYJi1TmEPA7YN4VjpOXnC86f2Qy5TpD0Lev829kQs=;
        b=Hr4juHAJb/hxTqjrDsSMHZNc2s10rRJr5TxtEaU5hCYfSCPHQL35LE3U+SP/bGLxk7
         D1DGOv2bxrwNUvEZX9SKrHzAjmjcwrKJi4PKsVtXVXV8BhKloGhixjNJbpP47ND0aEwM
         cdOv1vZOSXBSI3t/bXtSLWzWR8KgVxmbx2WY6YiDT0ndtRacAa1AhfBnBg/8dMXyMQ37
         Tt1w3fAuEEAaWBr/DYxcl2nbs88eGiznmHPc51EH871LNwCUHSkmajvXpj/dFW/rYCaP
         f7B5Cw2sD3NaR7+v5ltii9AIEujym7+YEqhCmqwXbYeFEuf5ijfbeeGXzhmjuCOWIMvW
         pU8g==
X-Forwarded-Encrypted: i=1; AKwUvBxbCh7dTnhNt67RuF6u3zbnKPlQclkKlAhIl4j6OFh1xyc78xUXZQkb8HRvswyWCp79ufDEbUCqqTvRVLHRuW71@vger.kernel.org
X-Gm-Message-State: AFq9FYJQ4YMROwWxMsOr3BOBMOud1yzj12i8bERb9tjEQJXkxPExQB9F
	R2eQEcppX5N079b0/GlRsJG1lcdFEWCNIvF3mh3NyJP7NfxWToz7EMq8VD8llW4BTETRnTsbwON
	+M3QzEmBHivEY+ekTIgw8g0G11Cf7UTw=
X-Gm-Gg: AYBFou27MkKzTBGmtgmRa0OaB2odgT8dwECyJKCvzC4EyzJkznOO+NMp/1rNyCPUZGe
	kaFSQLS7TxTXML9tEwKLAjBnwbklRNY8YQK5BM1Bayq0CN1N9aIGfddz2PJnHh1qqtR7TEutJEL
	JxB5x9qPGZoMmv3VPco9M3qPqHUmGcpRQTGNPB/JDmPZqOpdp0/Fh1Ifpex87Dx1XVgnc1ZthjJ
	rmmIRcNecXDINb1gz3KwQXK1z5NOnlxwLFnV6zhRqBV2A3Ocu5I55TcMyNsSG/QxBV8kiC1fk7d
	R9rbUFDcBvkgpTt6306d/f0niLGdvNIDJAFJBz77Cx/cPsb2hvBw87vAQSKL1W0F4DeDKLRymqO
	VAFL0h1TVn7LvOn3bpXkzrEBv4f94U+PGyVsyLAEqpZCMhfhepsnWRZFp6yPU7ZATu1+Zv3WWq+
	zkmF8iPy+zaAJJVsC1ZD9vfpRfnQ==
X-Received: by 2002:a17:902:cf0a:b0:2dd:ad74:6d22 with SMTP id
 d9443c01a7336-2e49b654fe9mr80221975ad.31.1791121760020; Sun, 04 Oct 2026
 06:49:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811041934.7609-1-phucduc.bui@gmail.com> <ar_fLAeFU4rmrwiH@willie-the-truck>
 <CAABR9nGqwTGcrr6bKsV5+0GYwkQoP0s_Tu6aTJrhJJW_ZRqFYg@mail.gmail.com>
 <asCyI2_CNSoDJy1w@willie-the-truck> <CAABR9nH3pkFB-htyrD-Z+iBBcYoVX4Z-hFa_binWCXg9_cHU6A@mail.gmail.com>
 <asISGdljsG86gUwb@willie-the-truck>
In-Reply-To: <asISGdljsG86gUwb@willie-the-truck>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Sun, 4 Oct 2026 20:49:07 +0700
X-Gm-Features: AclHuK-zrgBelXuI-I6swFhIOsgOnzrRzpoelrWImLhb29cQsM2UcUlf5WCmPxw
Message-ID: <CAABR9nFMR+D0j5kYR+HwLBOHG4WF7PUDrqjE4Bt0-VTUacxmBg@mail.gmail.com>
Subject: Re: [PATCH] perf/arm-smmuv3: Propagate errors from optional IRQ lookup
To: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-perf-users@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Will,

>
> Sorry, but how is failing the probe possibly better than continuing without
> the optional interrupt? Add a diagnostic if you like, but aborting the probe
> feels completely unnecessary to me.
>

My understanding is that the driver is designed to be generic and
support various hardware configurations, some with this resource (IRQ,
GPIO, clock, ...) and some without.

If a configuration describes the resource, it means the board is
designed to use it. For that hardware the "optional" nature of the
driver no longer applies, so if we fail to get the resource the error
should be returned.

A log alone is easy to miss, and the root cause still has to be found
and fixed later anyway. Failing the probe makes the problem visible
right away, when the board is being brought up.

Best regards,
Phuc
