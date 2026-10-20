Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511466;
	b=KQSmPXvPbH5Ng8Av54ymYfTyfaYsbgq6++3SpsvdlZPiy6C/vlob583u4Gol3FnpGMsF
	 Bk6O88ftiuDCpVKq4SnuO1BBy0LWCOCcrBK3z1Uyxpm7mneeldyHVIOqIKryYh49YINc/
	 73BpfWCrZrBKHVIU7UsxxxeClNIiWtYH3DcpxIj2X7Qz1tViWLMmey38z19J7bg1p6tUK
	 vi4unxtVnPzURkIvP7xg+ByJWRdw+oy/N4Ct1cT8K2DEtq+uF4UPm+C4tQMxLr4UMXGJs
	 ossYGy2hONRMqGV8u0rveJJLVFxHPq1z8A0AUg93JsJRD05YxvQ0A9ED0zuVkYKa6og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511466;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=OFVAQrFmT1oDNxMyfNklZUb3FR+1d06U5iKfR+KInKQ=;
	b=woHVPJZVcxBZfdQFzUXCrXuV8yBZYi0CSPo2mIjy0AB0bHZ6qUXFSevFSMYYfgAxgHa2
	 ukeZbRoIiPYU7lFr/8AxVH9La15hnOTgxKgmt0lYT0qiKVLGMofgGAkzCV+bYMpu436hY
	 N64f1idO4XjDtszhC+XTwf0bnECEBk4/sU91zHROME3EusrSF6/PCTCa72XCtmWaUwbkp
	 2+4B7NmqFVYPeKC1O4arKWLx2iHLJnVnnjWrPxcdwwR7YfC4fD3E7i4cIq0XvheFBXRrR
	 Dzkq52WDEmZs/EIgmpp/XPzd2r2pTI5Xid4FIvVmU0ALcCSTwBsaKkIW5Wwz4oFaSLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdXm5k0F;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B944606A334
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:51:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B944606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UdXm5k0F
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a1e477fe16so17801965e9.1
        for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 08:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792511464; x=1793116264; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OFVAQrFmT1oDNxMyfNklZUb3FR+1d06U5iKfR+KInKQ=;
        b=UdXm5k0FNyZfN1sNLifVL0+kQdEAmh7EVCH5isCKWhxJZ8NJHVqhWP2qY37Ziokfj6
         ltSycZDGUgHv0pfaahQTzIU+bgvmZXw85k+CcxsN7PyZtcyV1WoPFx/xya/CJdheYab/
         Q1G2ZOuAHUCdJvb07+x6CuVqY6hr5xMF99nm99sXFpU16KsTRefsH2O6MWDl4kZhQ9WO
         NnGL1PeGYNngt9Sr/LAWadFNLz3/J7R63nbQZncs9hLXYy8bBoOMuzBVoUvlbkPR4jHm
         kEpgVs84qXzIjaksQcp2Uk9LOiwV0ykPuYUWai8HLQ1Mj3xCLplteSaeUMp8lmI7Ru5d
         SnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792511464; x=1793116264;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OFVAQrFmT1oDNxMyfNklZUb3FR+1d06U5iKfR+KInKQ=;
        b=bkGZZJW6kgFuD7Ub6Xe2YQFJvh07AGW+T2XfSHylYtpQP/+GmvrGMmaWcm2E/1IReg
         WwKyDk+dTYfYj+y1QHXxg1R3mv52Dasl2TBHxbpBGzdB4G0W//BOr+HirfdI4BJyMLZ9
         cMC9lH2W6hUos45NX9PNQR5op24Yc4zVW3pO2I/GsQkanzZDx9uv2iSQ9K5wardvfwyv
         tLh61ICODJNPwetf+6ZWATDA75O23isidaObKBZ2A2QeJaTQPxo1JR+HecC0mdKPqorm
         La3VDgd6+FAJXHR0DHnt1eI3fECDZwyZJxyi/BsNxbYWBgVWSb7fSs+ccw8tTFzHKf8M
         dIkg==
X-Forwarded-Encrypted: i=1; AKwUvBxAuKpgHolcRQkmmt5p/WPr01zuqdtPiEZ/w/BiIcusTTcZYocrq/qY8/zIxMkZzzblyi+MV0Vsbjs/5m+bCpYw@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+x8s3vvq0/GXvI6PyTJ8xSO5VU/Rld87uK/EWS+ek2/fslKmn
	nslgPyOoBQ6SO0wqKrTvDfGPTqPgmgiAoIjp6ZAGZkI5Wy4EB971Uwpc
X-Gm-Gg: AYBFou1WtDxAhimItOgCGEzkZ5huov496IxPVr3ssKwiTaxhxGOYoG68V+XWupr60uQ
	meF5ddG4cwcAzUCdQvS0Xx88RfRgKgwil6kW4HxB+f642ND4emyX+T6g8+a109AeWrCq6OYeub/
	UKA3KAeSH8FBZSk4KsXj6YEtkIrNTjMsYzhv9D3z1WjwKBKcvSYcPO0aTx4zeWKoNMW71XTDnQr
	z8eT9QqpDRtONEitPrM4K/+3RQrOAD3Wd2nX16gWxqMxE477MDOkd0JZJr4JNnIcUl9f8f0YNf6
	KcqGWAfvdCdhgqJqjBTOJgdln7z26jFL2e1C6ZTfQTZIRnDAx58t1mcuzVQBWwQNEqCL8UG3LaB
	mepC2zLOcJhjLXfEL/KWwSxhcaiy8cM30fCSEWFrnQlDc0lD+U9Vu9N/o1su6/sStuoNWPlIDW+
	reIJQYjH12Dzrj6BSBeV0HgyaOjdstR+DdMcDN4MKJPxEZznd39nuoUFAcvUVjpjOgGM/mU1gHq
	jNbCSSqH96Q6NnM61yBPE76yIoJuzCMPk8=
X-Received: by 2002:a05:600d:82e1:b0:4a1:f377:5c50 with SMTP id 5b1f17b1804b1-4a1f3775e78mr82090745e9.30.1792511464096;
        Tue, 20 Oct 2026 08:51:04 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d817f8dsm6788859f8f.23.2026.10.20.08.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:51:03 -0700 (PDT)
Date: Tue, 20 Oct 2026 16:51:01 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Ian Rogers <irogers@google.com>, Thomas
 Gleixner <tglx@kernel.org>, Andy Lutomirski <luto@kernel.org>, Vincenzo
 Frascino <vincenzo.frascino@arm.com>, Stefan Kerkmann
 <s.kerkmann@pengutronix.de>, Christophe Leroy <chleroy@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Eric Biggers <ebiggers@google.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option
 for ARMv5
Message-ID: <20261020165101.5e74ab2d@pumpkin>
In-Reply-To: <20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
	<31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
	<20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
	<d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>
	<20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Oct 2026 16:56:40 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> On 20.10.2026 10:24:51, Arnd Bergmann wrote:
> > > FYI: there is the kconfig Symbol HAVE_EFFICIENT_UNALIGNED_ACCESS. Can we
> > > make use of it?  
> 
> Just noticed that sashiko's review contained the same remark, but the
> bot only posts to the linux-perf-users@vger.kernel.org list, where I'm
> not subscribed:
> 
> https://lore.kernel.org/all/sashiko-outbox-178182@kernel.org/
> 
> > That would be better, but I still hope we can just get back to the
> > portable code across all architectures for the in-kernel version.
> >
> > I have one more request for you: can you check /proc/cpu/alignment
> > on the system that shows the performance regression with and without
> > the patch?  
> 
> When booted via NFS-root to the login prompt, we have about 570k System
> alignment fixups, all in the IP stack: :/
> 
> __udp4_lib_rcv+0x78/0xc6c
> icmpv6_echo_reply+0x160/0x504
> ip_send_unicast_reply+0xf0/0x3f8
> ndisc_send_skb+0x15c/0x40c
> rawv6_recvmsg+0x114/0x3b4
> tcp_rcv_established+0x3ec/0xba0
> tcp_v4_fill_cb+0x70/0xec
> tcp_validate_incoming+0x540/0x868
> 
> Comparing v7.0.12 with mainline "unaligned.h" and reverting commit
> a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to
> memcpy()") brings no difference with respect to alignment problems. But
> I see the increase in I/O performance (measured with "fio" [1]) on a
> UBIFS/NAND file system:

So the nand fs is hit by the memcpy() but there are misaligned transfers
in the network stack.
 
> - v7.0.12 NFS root
>   User:           0
>   System:         573956 (tcp_measure_rcv_mss+0xe4/0x1e0)

I can't find __udp_lib_rcv(), but that looks like it could be from expanding
tcp_flag_word(tcp_hdr(skb)).
Which would rather imply that the network driver isn't correctly aligning
all receive packets (honouring NET_IP_ALIGN).

When I were a lad the kernel just paniced and userspace core dumped :-)

David
