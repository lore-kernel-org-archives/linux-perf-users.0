Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511730;
	b=XnBET2x+oWY5xsQJjP/lPvA+e/uaQdOusIULKCTs07W3dLbErW1TSWLJb48dQrUAULcG
	 zoMvxpua/CtykCCDy2Q5oU+2vDW9xUCWftVYHUcj74XaX97aBS3Syq4EAq5kTqzVrtevQ
	 2CnrI2OIhkb2YTD/IbLyd6NKdG69piSFt3Esuja+6N58OR25Pzch7jg7ZfQdXNl2hTyRW
	 wxc6oNoK4Z4T0hgiSMeq8JG45N7r7XUV0oyatTXuxHb6GV+uNAryzOivGRfFT4buZdgHX
	 wmJKCALjeUaTE/1LxxXEyAhvVix1Dmr7HdsBEYPqt6XmhFaa5nSzcp2ofMA3TsjveEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511730;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=YJsbVGHweRHxz+pzHfjXXj1fkrhbsYB8BP0nKBtOGeM=;
	b=uEBKMbE5aOfcC4BPsYiO0Gop51vWHe6FeQlOshaakH0mOEBV4Qk7CookzcTVlMi1vha6
	 oA8atyVPAM54ht+45xPVdE0OLwiu8U7z6/bG0tnK+dBvFMxkT4ppDgeVl4gr5Dyijit87
	 1alU+8l+qEFx99hpbE+ZrYCROw07RHEdiX5cLlgjWPAO7irVFJG3351wfC8AmyAxwYfDK
	 ufU1nydpiFDDIOMWHcAHFaukrFXgfyQHllOxl2O3kR9d1f/vLn0GGik7HXRoqCN0dLB/U
	 Z1d3MIXK/cWake0JP/up03ra+hyHU7ZaNfhe6on/ibTm6CjL0s/hrWvscQuUCjh+XIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=iMGuu2KX;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ObBFphxa;
	arc=none smtp.remote-ip=103.168.172.158
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB79C606A330
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 15:55:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB79C606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=iMGuu2KX;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ObBFphxa
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E128C140010D
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 11:55:28 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 20 Oct 2026 11:55:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792511721;
	 x=1792598121; bh=YJsbVGHweRHxz+pzHfjXXj1fkrhbsYB8BP0nKBtOGeM=; b=
	iMGuu2KXkp8vJ8BU3fGHIOUccTamuAJ/CvHYcAFXGvSikxnmCECeP1U4M2qqP8AA
	BhzZnORWe6FkjXnrMn00HawA/FA/ekYr5SK0NJ+Ec2MvWzyHG4JBJcI7mcmvl0Fv
	IatcKEHVft+g2swkIQndgo0Tuvi3qQVWNIBTJCP2NjmKUdZ4Dk6TGv+VGH+YxrUq
	3wbsdlRZqrjYpcuykxwkDMViYf+3q6yOLPeXuXO3XjREeDvMdUnyZBhACIOmAwgv
	jq8k/PMJ+pClprtcGGk7xaphAR503Etc4DRTbXEkNkCIRNk/oPoXXRAmTbKuTmaL
	ksuy3wuvTwcs50V+kTsjcA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792511721; x=
	1792598121; bh=YJsbVGHweRHxz+pzHfjXXj1fkrhbsYB8BP0nKBtOGeM=; b=O
	bBFphxawUjFZ33873twU36J9yKD+Y2jlwzH+mhqsNv+KurNlZLoBihlqnEa9P8ME
	5eA0QAxl4qAolYQAqrfz8GSPw6XLLmTz+TNGooLUkf3Gkva4hXwm8Se2dDI1L2iL
	ZEJ/k06f5fLxd+kY6CAMjpwtFcBZWid91tYlk2y0p/k3hucWZ0LWoCHJwrGGx0nZ
	C1j2mPS85bvJdTJNIPfhl+6KroMyZ9UvLbz9r3RhzhL9SQSBn+PxY0fcWNP0DGpw
	8pLhxTLEyXFHu298kFCvarvOrdOSnOjeNJcKuDOQ7Yk6RslVuXYVX8pegs0bp2Bl
	WjUgqOtAESqz2PptFRcnA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792511721; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:HX4dYmYuZ66KNvuHeKAoP1PZpos6NUJt1XAsNzSBx17DOjr
	MLEoTubGDnhfGJjc3gGVOYnJj30Dn9S9TjnXx+4Nn5SHD7YnzcGB8cYYLibkjaMS
	KKAvjqmiF/IRL+wwcD7dMz+DPxYg8+bpRWwF4nMNJSAFQ6AguX7J6fTErI6C7Ccb
	OqdveM6Thaqun/NIH4uWx0hXlY69cB7qc7Ax7W5DT4Po4k+9vMNFPyCWRRv28GSb
	yZI2oSUe6+M6ZKZoTSyA7SkB4ivZQNrJS7ih+lM7H/WX/PrSsYQ9Mlm5XUUJ7tG/
	a+QF2Oecw0S9JNsuINYGO1v6e8JvuOiPGD3OoIQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:wZQON0IzJv28dgK0aA9d312wJRPvMMGsTHqBMRM3g9I=:3aXA+zKnVL2UPOJf+qiGu+atcUd1/V7VGJg1tbSeCGI=;
X-ME-Sender: <xms:5I7XaiAOXHTf4VRn0ownrfmAjsnRG86mnS7pjNvlnozNfn8zWnkt2A>
    <xme:5I7XanWX8eB3gd2DpKAnJhIzsjHX4-NAz098IyzBbxDx2P69GXnrvjeIXZ0Vtacz9
    Z7UecXInG7pn3kHF9dNDKvG-b7H5J-Rlsz8-juUVxZckoEsaO64OcU>
X-ME-Proxy-Cause: dmFkZTFUYE/iftp4JIqAJC5i8VTKXj1D8SOEE/gupcR4/K/WAhj2icEcZ28P5V4T+Y5EuS
    ojOThRjYp6NSUdJ/FEUrSZOq/m1lT0XsO3mQqHnomgGus5tI58SYjhuzH78AyRliwctknB
    F479WwRpPhE9PvvYi7C7Tnr2a1981eHnVzMV9EiAidlE/mbUd2rK5/7RxePrCsCFsBqH8v
    n4s15YMbSd40ZFJs1f77JXs4HEFxamt8i4cY5X+YwhFav6a4eBKMjfW+WT/XXkUgLL67KZ
    df8eW1WJeF82VW/XeRv+LHALEru7D51/F717jMkXQjWlRkFtFMaKHIzwoKFHcNkflLkODy
    8eLAAntPk8fDYEfxJzZlLAZe2pZIIoVnvZ6OfQHn1BHt/O3KW65lRtTAJxeVbFnNwnMHXc
    WcQk1HxYGn5J89KWypDssfZzK8hC1Qhs3Pv7Zv6SKnIxS7RNVCRpMb88gLZrhIZnEg9VeR
    kLmxxYxpQGzEJBnHVL2nLYb3SiGOW6Kt1b3jntG79/DoGyaQ8sTn/DlTkOy7z0Df6maSNN
    4Pl46CScjR8C/BOFtj+lu86ZiB7ibwdxAuem/ZoQbT/GZeen/gT8y8ssuTs17bxwuuUimU
    a0lPvedltfDI0tGOPzySvDO2VBz9yBBbYIRZU0bkOhiNu8xQZ1KTu1FwH9Zw
X-ME-Proxy: <xmx:5o7XaoJYl0vulsN000OXT5OiyMxn_B9xJ6XS6LZKqAgty_r_dJa8Gg>
    <xmx:5o7XapH5BbkXCiSvVaH-uLFtaqGS-aOt3uGWk-EttsqhewS11pGe0A>
    <xmx:5o7XapCOHNTP7NdwtK6wRTzP9Od-iKIR6_g98NYIZWPuCKRv3TVuDQ>
    <xmx:5o7Xaj3df_LTF0ENrYxL48KBRz487LhBk_lEoTtZzj7048IaFlD3RQ>
    <xmx:6Y7Xak92dvOsvO6GS37sAA0WQMzUQAbbfE1enNe4RL3GsdhCho0tbZfv>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 0802532A008F; Tue, 20 Oct 2026 11:55:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: ATLhSvAouVZo
Date: Tue, 20 Oct 2026 17:54:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>
Cc: "Ian Rogers" <irogers@google.com>, "Thomas Gleixner" <tglx@kernel.org>,
 "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Stefan Kerkmann" <s.kerkmann@pengutronix.de>,
 "Christophe Leroy" <chleroy@kernel.org>,
 "David Laight" <david.laight.linux@gmail.com>,
 "Arnaldo Carvalho de Melo" <acme@kernel.org>,
 "Namhyung Kim" <namhyung@kernel.org>, "Eric Biggers" <ebiggers@google.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Jason A . Donenfeld" <Jason@zx2c4.com>,
 linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <a34133df-224e-4cea-b574-097ad37a791a@app.fastmail.com>
In-Reply-To: <20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
 <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
 <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
 <d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>
 <20261020-nice-turquoise-dinosaur-3079bc-mkl@pengutronix.de>
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for ARMv5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2026, at 16:56, Marc Kleine-Budde wrote:
> On 20.10.2026 10:24:51, Arnd Bergmann wrote:
>> > FYI: there is the kconfig Symbol HAVE_EFFICIENT_UNALIGNED_ACCESS. Can we
>> > make use of it?
>
> Just noticed that sashiko's review contained the same remark, but the
> bot only posts to the linux-perf-users@vger.kernel.org list, where I'm
> not subscribed:
>
> https://lore.kernel.org/all/sashiko-outbox-178182@kernel.org/
>
>> That would be better, but I still hope we can just get back to the
>> portable code across all architectures for the in-kernel version.
>>
>> I have one more request for you: can you check /proc/cpu/alignment
>> on the system that shows the performance regression with and without
>> the patch?
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

That is usually a bug in the ethernet driver, which should take care of
aligning the IP header in the rx skb. Many drivers do this using
netdev_alloc_skb_ip_align(), but I see that fec has its own buffer
management, so it may not be that easy to address here but would
boost performance quite a bit if you do.

> Comparing v7.0.12 with mainline "unaligned.h" and reverting commit
> a339671db64b ("vdso: Switch get/put_unaligned() from packed struct to
> memcpy()") brings no difference with respect to alignment problems. But
> I see the increase in I/O performance (measured with "fio" [1]) on a
> UBIFS/NAND file system:
>
> - v7.0.12 NFS root
>   User:           0
>   System:         573956 (tcp_measure_rcv_mss+0xe4/0x1e0)
>   Skipped:        0
>   Half:           4
>   Word:           573940
>   DWord:          0
>   Multi:          34
>   User faults:    0 (ignored)
>
>   WRITE: bw=272KiB/s (278kB/s), 272KiB/s-272KiB/s (278kB/s-278kB/s), 
> io=32.0MiB (33.6MB), run=120532-120532msec
>
> - v7.0.12 NFS root, reverted
>   User:           0
>   System:         574214 (tcp_measure_rcv_mss+0xe4/0x1e0)
>   Skipped:        0
>   Half:           4
>   Word:           574183
>   DWord:          0
>   Multi:          27
>   User faults:    0 (ignored)
>
>   WRITE: bw=343KiB/s (352kB/s), 343KiB/s-343KiB/s (352kB/s-352kB/s), 
> io=32.0MiB (33.6MB), run=95439-95439msec

Ok, so about the same improvement that you saw on ubifs.

> Booting from UBIFS, so only the lab background IP noise...
>
> - v7.0.12 UBIFS/NAND root, reverted
>   User:           0
>   System:         164 (rawv6_recvmsg+0x114/0x3b4)
>   Skipped:        0
>   Half:           0
>   Word:           127
>   DWord:          0
>   Multi:          37
>   User faults:    0 (ignored)

At least it seems fairly safe to assume that your original
finding is correct and my worry about adding more faults is
unfounded.

       Arnd
