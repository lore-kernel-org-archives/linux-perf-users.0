Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794364435;
	b=CKYYHifGdIC6dpsRblhj8XbpZaXehAu/LHm4LBcmyJLPURsfhSk5VPxktQReANGZ6ogZ
	 jx70TLQorM3+xux3M4H3j1Nh+ZAPLO2ydNcLjiAzYlNBjDH2hPLdTIEZA9FxU5TFRFssB
	 k3YcCFebai/X4n4s1SDH8kkKBPEvUgbllOYa+t14AmUkgkK5IgyNWr5aLMHzVvBgRwsx+
	 d/J+hTV4D0YRmLJPKSieCnXmktQ1tzBFfZBnjOm2iLY6NpwXVO4kwYkI+dlG/zBr34UjE
	 gRWDARo0sttxLuux60IAnaSFv0HZ9te8c24V+aN2yFzAtHCn4YuricNX/Gsd73+iMKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794364435;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=eAup7Rg6nL23iOJh2dz/V9hzsZjc+nJsJVeNswqECtU=;
	b=NQ0dktuqVJeLDQHS2thCk2QbS0LixP39PlWgekzgmS0fYu4ziTtQwUDZtDLUCuIoka03
	 kKfdcvK7DXlGVubQqRsCWS5fKxpEDseR0+X2134+QnrhzCKU3MSYNdNIlN1Q54rYMPAOU
	 NctAVxUBltMmkG1+/6K/M3xcctXYgKI6ExyZM1h7LhMdc0NYTdhEKQBWtXj/E2ISByL1N
	 nU2WPzfOhwZENL5RfxGUQFpN5FcMdkLHNu332WdJc3Q/7mjAk5D6M4piumxSwT3BKl1Hl
	 2hpFBUxnWdbn3nfODSKdoLZmICS3JMLv+pxmLo4SKiNOL/F9cOTwha5dzRWD7vb66og==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqrMr8Sj;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBDB606A31C
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Nov 2026 02:33:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBDB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qqrMr8Sj
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso200594eec.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 18:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794364434; x=1794969234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eAup7Rg6nL23iOJh2dz/V9hzsZjc+nJsJVeNswqECtU=;
        b=qqrMr8SjrPIDwHJB9WYyp70Ipj80NGrcSdL+TmYRSFxlWEq3COkbf52eOuauRrhbOB
         j+RfiuezpgAe1E5i+dAgL/90/4N8GxqRDXa1hBSqHGFUe9jKHSCoPgL4T54h+rFbHbzm
         HsO2fFp1I2h52tiZbCDMoR0D0O6HUQGPURdPZ02G00kzkRZIsDr4cyje/Y1Bpf99pCtT
         n4whCw5z6IAbRi8EkK4AvXLNJHcyHN3x+MUXDxTmhvAFYM9S+Gq1sRB3a4LPRkY6LlyS
         klZ9Z0c62b13OmM3/M9dlbLabPm1resZVJTlezaiDRDR2My3Pwr37A0WfFM3FYr0bw1T
         X8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794364434; x=1794969234;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eAup7Rg6nL23iOJh2dz/V9hzsZjc+nJsJVeNswqECtU=;
        b=Fs9h7rUQWAXA/5AcjORqCopphL5kFJ6h6DsHbN2uMMgw1VeeadeofY+jMv1kdhTt0i
         rN6IUWUARTXSlnpb4mDpjBNiR2i2+MHb1fiszxfgEttif3zK8uMHvmQeEVbvyKgIw0Ef
         1hrllyjq0ip4LPFEt8RA0YCNssqmD/xfsm8uqbBVyjU9Vv+ysISVYPXKq00rEnhMHVue
         zF5m+PNbGOw7g6z8fZBLyJxzT3TPsjg+rYped2I9xtHmHXrBZCwZ0HXFXGklKPRIzjjl
         UscCohXBUg7oSIg8iOJ2ULK/k+JzIQvmVYNVyjccT61s7ai9HwrFBjv3ZG2mPOZq6nVq
         OVsg==
X-Gm-Message-State: APuU4Z/3cq4C1M0FFgEtSIiuqKMy+nZZigwCREpP98ETMR3oQwvWozHN
	CExta7T7SBtsAb8MQOhUluRKov/NiJJgXMvaaujo4U9GvrUwkMvpRNA5
X-Gm-Gg: AYBFou2EbHHmy1tcqSXSTsUB6GrR50kDbVqu5tuIE0hzyVa3Dv/bEkfRGzHhHVSlXKc
	9ayl8OF6pwwS+Rf3O09FmlnVz5DYcpmBgywQtiCIyA8tG0RarztdTls0eycJvmv5lfxnM8pNoN0
	z7ZuZS5xhqcBZ8ytpZj7ZvG59wRukMRcHlRSUngaz2WTOKDEa2gFPUhwWjiJMusz08L87/fQC6O
	qmQSQquL6o35HK1vGWmdHnGhS8kmoFxQ7QMm1dmenaZLUCiWgaHRypqudFiDFuw/LBI2JXI13Uy
	4clawi6VMm4Lf6UY+PncIPPgqa0oFkYpSxeCxEYBx1iOQuvJ086pOYO/Z/k3U5e1KnjSDPYClq8
	5FiS5Z0k0YmSP6XJYkB2dDU4B4+hgPuWZ88daVeXFzMHO0+61xgczOfzshVQw8+6MI8cg2pPb6e
	TJV+b0fXYqs94mCrQnX3BRNck67MEEMrzwjypy0hQ+6F6IxDQHqXhgWvez88YqfiVOiSnxjltAE
	bZ1+Mmo2y5Y3Q4r96CbNT640ZclqAScjikw0RtBC2Mcya5/UHZ5gksuDfVmb2yC4ZyvCTgiT4xh
	CXsa4z/0/s1FXVgY8g37S1mpGp0=
X-Received: by 2002:a05:7301:2901:b0:36b:d3dd:2e9d with SMTP id 5a478bee46e88-37686278c31mr2218552eec.19.1794364434137;
        Tue, 10 Nov 2026 18:33:54 -0800 (PST)
Received: from [127.0.1.1] ([161.33.196.121])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520bfb58dsm20466251eec.18.2026.11.10.18.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 18:33:53 -0800 (PST)
From: TAKANO Mitsuhiro <takano32@gmail.com>
To: Hang Zhengyang <hang.zhengyang1010@gmail.com>
Cc: linux-perf-users@vger.kernel.org, TAKANO Mitsuhiro <takano32@gmail.com>
Subject: Re: [PATCH] perf evsel: Skip group members without fds when walking a group
Date: Wed, 11 Nov 2026 02:33:52 +0000
Message-ID: <179436443230.1969401.16257974217570748224@gmail.com>
In-Reply-To: <20261110030832.3060145-1-hang.zhengyang1010@gmail.com>
References: <20261023085629.1694941-1-takano32@gmail.com> <20261110030832.3060145-1-hang.zhengyang1010@gmail.com>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: kpatch-send.py

Thanks for testing this on Zen 3, and for the EBADF detail: it says the
member is being grouped against a descriptor that is not a perf event at
all, which is what the patch stops the walk from doing.

On the counting improvement you describe, I would rather not fold it into
this patch.  Returning -1 from get_group_fd() for a leader that has no
perf event changes what the kernel is asked for: the members stop using
PERF_FORMAT_GROUP and start being read on their own, so on top of the
patch that stops the crash it becomes a change in how the group is
created, and it needs its own explanation and its own testing across the
PMU types that can lead a group.

Would you post it as a follow-up on top of this one?  You have the
measurement I do not: the "{user_time,cycles,instructions}" case counting
on Zen 3.  If you would rather have it here, say so and I will post a v2
that carries your diff with a Suggested-by, but then the changelog is
about a behaviour change rather than a segfault fix and I would want a
run of the group tests on a second host before asking anyone to take it.

