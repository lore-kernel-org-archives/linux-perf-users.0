Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484736;
	b=uRoCfvRouirsQEnvcBMjJhumcA+QD+0Ca2v/wPGHrDJ+AIxfQLWi5zGu6hsXHEauJhmY
	 r/2Mhb3b6zQFO90XLAwPJb61mO0ItQOaiZzL71RerekInUdl5yjz3qFQDQp0oGtsfw/py
	 wjxaXcSIp3i+1p9XjHkPnftiH9Tl2SjosH2yrb0zSyg2r83DEFEtw67I7mS/g3iilz7cv
	 yMDTxk8i1B49XPSPKlZHQy3g3sQsQg5vt0EphRI3UGW8ydHX7khwnlG3Bsarnq6ZUswpn
	 6TIF/T5th08ItQBOrI0l+2CeK6GSBI73EdN1OW4gP3uwxWjqbBmv/zflYq3TxWdPwfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484736;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=OOWziecHO99tmLi2InK5sCFNWlNwHdhEH/JAdyr5Svw=;
	b=EgTwfBrmTbYySTYcMuYdXt4M3Hf+TQ9oQjBPjvi9d8CTD+aYoC0Q4djmwLaZ2EYhFza2
	 /v4vTUgeXh14i+CcBUj8BhpcdQoDbQIYR58ogmS1AnLzkPo6kiySr2IqevIO9zcy/BwTg
	 vcjm84/3DA7ZbWV/fw7fBekn2j7ZpJKrgZLa1jD8oGqL6VQmcdSk/V5WUwH7NmVG6tnFP
	 +L3J6e37jPfrrcSCLMgFOK8XSymWUby6e8+kZhtDNQC8m4SxJ3CSfwCI6A5vUwhPiErLB
	 ll5qBJ2PNUFwcYbXeo9nwzLRNtCix1XqeZfeCe/jKKkLghCdIg9oc2fO+PkFEdO0YtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=gVsMzc4p;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IBiQG7Ut;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DB606A31B
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 08:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D3DB606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm1 header.b=gVsMzc4p;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=IBiQG7Ut
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfout.stl.internal (Postfix) with ESMTP id 4D9801D00169
	for <linux-perf-users@vger.kernel.org>; Tue, 20 Oct 2026 04:25:35 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Tue, 20 Oct 2026 04:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792484726;
	 x=1792571126; bh=OOWziecHO99tmLi2InK5sCFNWlNwHdhEH/JAdyr5Svw=; b=
	gVsMzc4pE7RXb0PD1PFSe7U9KAKo+LOfnrpCZ9bGvHxQed7bfXRPVZaXFO6RI0rE
	gYqVssJtY3XpYADIXLgRBcAivyYUTqSu8/U6eyNyRwp83RN01jMkBsdi3XSrhfGn
	kcF6F5coIfSOKgdgbd85wqMKYqRaJnkQlyeHKPGzHIqseXyjDgBaqtDhCRjj46g7
	68UwP3Q+PH2S8H6mzo0CE9icu1ZVRb4prOaDAupmoyxVSNeCP69TfOUMleKnhNMm
	8ENYBcOnJ+sGDMOlWdebTCqj9MCTkHYw6M9FqX6TSr5+advz0T/TTmuGuAPIkXsn
	kVpNl96YZB5Kp92uAuC5HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792484726; x=
	1792571126; bh=OOWziecHO99tmLi2InK5sCFNWlNwHdhEH/JAdyr5Svw=; b=I
	BiQG7UtPpvPCySro50zQU5JqtAIrUz0JrU5gJXsRkNxCic3ZY8SiKef5exwqvb5B
	vp49UBM4fWL/diBc3NpoeR29xdBei4dSPQj9oYTlEQEgveGPxzhNmuRKE7uwiL1n
	pyXdAjkvfkJkSUpax6c/pNurM+2SXECpBDAJYjS5Sa/2kL/U/12swZ0ZUb2v0JDY
	vTembThXwFHx2QUSa0abSxxuX4NFFPzN0hKVXFvsRCv82DbGTr5AF3LpmeZN43VC
	0XvFd3hjxHZMmRm0gs3K2Y/TKq4TRz/cEIdcuXJJ+56HNYZjjvoxWpsqbCORpA4V
	P69rs+rDWFvNO/FEHUeGQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792484726; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+;
	rt=PGxpbnV4LXBlcmYtdXNlcnNAdmdlci5rZXJuZWwub3JnPg==;
	s=fm1:rsa-sha256:nqlCiPLOmU5d/xsa/Vy6qrpKhFEUSqAqwGZeQca6CvRkUyx
	Sw+bUC1Agk37icGMqapo0tSm4X1J3bnhOcDdytGXlHRMSPtjam82/8u4kZO7Qzjt
	r1+EZqWZ/CPW7m9UYWMMgKWHfA/yc6sxqloNQmpRWDONcwqIz8sbPZ2UmirEU4gE
	mNGTRvQeCfTBdRm8XXFpFo7jpfe27L5je1P6yKNoj22aog60gtL8pHaGchVNkbMK
	Vs9yldnqgwVlVjSY3JbjFMZj2yQ43CQTwo0+nqo9ATQsEMyjCawYhK0Apbl6B5lR
	4hpFs60PtVWTDsh6FHBKPOVGy3RYVY3SXTmrA7Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cNtNee0u9nf0BQwKITDllCmw839Es7Nzqxp6USKMn7I=:zjOrROw10opHbIrx9y1YCbZGw8cKUW0tmJxEUPyp5KE=;
X-ME-Sender: <xms:cSXXavuXr_oR9TttEhY3jnM7ek0xt-zPp5V24wUYJ-hsvYHZ8QYjJQ>
    <xme:cSXXarQLQiAu_-g06K-OFmt7RHvAPdIS3mou4Q2pW8Q5GH_FkCLZtw1ekTO4-RSIo
    48fwg0FvnC4EySl8wGi3Aw-D_qbWXrj8BG2Pmb71WI0CLm_Sm5u-Ck>
X-ME-Proxy-Cause: dmFkZTGzVLg4yuouvFwz5PrOMh7i8iS+/9vnsYEjZvv91aX0C/a0or3CnXqR+7HkqrsIiK
    +hbffc7OOTeXxTe1v9gFoS8U9vff/jgK4QFpfy8cbkxv4eAUv56tiyScm/QBvbm4RDlUyy
    iWngEYpMK7gGQjp61AP6vkDvTpqlvIdEIHhJOIc0z/80tKwxgojEYw36ffUsZT7g5//AwT
    mWBIWSvEfnJN3aqM8IxjtEndMLYwKs1m7VhEVf6nLsTvrWFLY6G1zP4njgQwR1UJVpZuXf
    FqFDYDwlN5ARRFzRFZcVaO0tsI1F6BzU94OxKNK+hUUOqwGbZLmaqQa8pcE/xQtRMO5apF
    7dE8Sgl5caMJsXZpb6zjnBgWORBsiJsebqBq2oMbYzsbUZh0DMQYBoe795+nrObGTFmxG7
    uj6oNWndAeqc8k22aR8UNBzzmGn62bA0KLJ6ImNBLOFZfM7I7Fq7xLkqJ3OoIFIjaoVs9P
    cZFunWvqyrM8QPQm+6EVIKsKAGO/U2n6r8fpt5HwpV6E7hQ8aUUsimkyZXc8ullR/9cAbS
    yldvWHI9p7AMheF9F3ruGAsVVMA/pGhcbPS8JFgiel5WbD6XbntgbTEPdwN/vDezQ7Ss63
    M06F6G0F1gCQsadzsoRaGkAY+M3aoYyrR3oBcz3NGBYxjyN3wnnGLAl0pNTw
X-ME-Proxy: <xmx:cyXXaiBEe6m2VyR1-2qmJUdiZyq2c0jIqKNI95ZZU7EsXIf-HAECqg>
    <xmx:cyXXanPH3VQ4SyHaeVYkVBEa3wV4P8G1aU4o9eL5me7WzKXmABtmSA>
    <xmx:cyXXauQHJakWwnfhTPMAJ5IHUPAIq5R8hCl7RMp6Rrb-3o-T9-ZEqw>
    <xmx:cyXXan7WAAK-b5pSlQRTzRNSjuNrbupUP5PyhKJFXGYAHB2gGSbB_w>
    <xmx:diXXatkkvVghptf4jn_4AAkjBNPb2wpqxtasfqzSdthrDUdky69a8qTu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 44A6232A0093; Tue, 20 Oct 2026 04:25:21 -0400 (EDT)
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
Date: Tue, 20 Oct 2026 10:24:51 +0200
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
Message-Id: <d2afb4cb-145e-488b-8f6e-c83e38735526@app.fastmail.com>
In-Reply-To: <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
References: <20261019201257.3805356-1-irogers@google.com>
 <31fe09f6-0a14-40fc-8ad8-c03998fb1f5c@app.fastmail.com>
 <20261020-succinct-zebu-of-vigor-6cb2cd-mkl@pengutronix.de>
Subject: Re: [PATCH v1 1/2] vdso: Add VDSO_UNALIGNED_PACKED config option for ARMv5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, Oct 20, 2026, at 08:44, Marc Kleine-Budde wrote:
> On 20.10.2026 00:12:57, Arnd Bergmann wrote:
>> On Mon, Oct 19, 2026, at 22:12, Ian Rogers wrote:
>> > +
>> > +config VDSO_UNALIGNED_PACKED
>> > +	bool
>> > +	default CPU_32v5
>> > +	help
>> > +	  Use packed structs rather than memcpy() in include/vdso/unaligned.h
>> > +	  for unaligned memory accesses. Enabled on ARMv5 where GCC may emit
>> > +	  out-of-line memcpy() calls instead of inlining byte accesses.
>>
>> As explained, I think this misrepresents the problem as Arm specific and
>> isn't the correct method for -munaligned-access targets on Arm, which
>> include CPU_32v3, CPU_32v4 and CPU_32v4T along with CPU_32v5.
>>
>> I still hope we can use a version that just produces the intended code
>> on both -munaligned-access and -mno-unaligned-access targets like the
>> old version did.
>
> FYI: there is the kconfig Symbol HAVE_EFFICIENT_UNALIGNED_ACCESS. Can we
> make use of it?

That would be better, but I still hope we can just get back to the
portable code across all architectures for the in-kernel version.

I have one more request for you: can you check /proc/cpu/alignment
on the system that shows the performance regression with and without
the patch? In your original report, you have shown that Ian's patch
caused the drop in performance and that it caused the added function
calls, but I don't see any sufficiently hot code path that would
actually explain the scale of the regression, unless there is now
also a case where get_unaligned() ends up doing the wrong case and
running into a fixup handler. If this happens, you should see a
nontrivial number of fixups listed in /proc/cpu/alignment. On
a working system, the numbers should all be low but likely nonzero
because there tend to be callers that still lack get_unaligned()
wrappers and just access misaligned pointers directly.

      Arnd
