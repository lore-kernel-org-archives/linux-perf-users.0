Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="aSgVg5oK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cifsw1w+"
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04BDEAF
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Dec 2023 02:32:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 8DE903200C5D;
	Tue,  5 Dec 2023 05:32:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 05:32:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to; s=fm3; t=
	1701772346; x=1701858746; bh=nvGWOwshOBazt+opmOLCQliDBsmwN3Z+bJQ
	Tzgce/dc=; b=aSgVg5oKfM4NPK33MpCaTFI95UNEkHut3aZ2MNaEC/GnkYgmxIf
	5jAIS9A2qQj5T5oWNX9ynaV8OuuxJyjzOuckhzQwowd0KVAQsQ60pJBC3UkFTw07
	sfrqSh/SCU7S2eGJhbXyXq8ywCLn5pUk+pivulY/hgbM163tZgp9uW3f71zL2Qta
	un7L97k+QZhk5BixG24//tRrIPrn2iG4jij3jfRUb68DvVHl71QddocGuS+KHORb
	pQ3rt2wkXPI/TYRcF5lJfu0AtL/iFsRf+fFarg1JZ57gDrddfot19rzhpha7qh4K
	T5SBGQkrbmuStT+JJqny1q6U9ipA5SjJXTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:sender:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1701772346; x=1701858746; bh=nvGWOwshOBazt+opmOLCQliDBsmwN3Z+bJQ
	Tzgce/dc=; b=cifsw1w+ehJM2ogAcMQ/hC4nEkatBo+t7fRhcf6qbwerwgFcBMK
	rSoq+vrPhM8hIwj/qcnypvoIdKesq+chj5BdLZJLzW1lDMr97VH9WKyqTGWk+B6w
	vPRNtOhXaKjBQ5Lu2MOuc78NIwbxNRu2Xc8fVVclvD6Lgeknf1bOOI8uY4lznZR9
	6uEKr7iHp1ZjojvbVI0KdZQvUG1uv3EIHMS6TLzglyc0LMDdxL39ISfj3B0Kp0vg
	xJNov38RdF4KxqqsmezgpqxQ1CabpTOimbpasnvwF8PpFZbOGbzKY6K0U9ea0BgY
	JjzH1Lp5aQQ5MrqlWlI5VbI4jEGcV8Ec0bQ==
X-ME-Sender: <xms:OfxuZTUkPuE3pXk3X_vAZ7UZGeG1d8YkoES2hUgbck6JO2LR3tRGuw>
    <xme:OfxuZbkkz1qmEwxO2vb29LsfGJ26hvDXkA5ckiABX2hjehfLLY4B9uLA50Tz-i3N4
    5iZN2CTnayXp9IkIt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:OfxuZfYwHQVh3KyLBxNayG77PIdi90lG1BOYqw3S-x_LQ-F2_EKJ-g>
    <xmx:OfxuZeVIFiOcoyogTPM6cCUC2ThMA2WTkgINYxi8MDYPJCduhLdlqw>
    <xmx:OfxuZdmLWvuvBft2569j0LEEMA1LIb6GyT4kTNBzbc0pRysQu_Uy8A>
    <xmx:OvxuZTVPH6P7pciU-ZRJZi4fpAYyMrZCJ_iJFdUuYL3H1_RFNHfSXA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7096FB60089; Tue,  5 Dec 2023 05:32:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5b0eb64c-fb0c-4bb1-a10e-733d496ac2be@app.fastmail.com>
In-Reply-To: 
 <CACRpkdYcCh8TNBW-UJ1WhH-7sQMAw6xjx1FV6+bWGi2VmsTQHA@mail.gmail.com>
References: <20231204-drop-11mpcore-v1-1-f96cd3938cf1@linaro.org>
 <93cc5193-aa1b-4df8-8d00-c3149c33b7e7@app.fastmail.com>
 <CACRpkdYcCh8TNBW-UJ1WhH-7sQMAw6xjx1FV6+bWGi2VmsTQHA@mail.gmail.com>
Date: Tue, 05 Dec 2023 11:32:03 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>
Cc: "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Lubomir Rintel" <lkundrak@v3.sk>, linux-perf-users@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: Delete ARM11MPCore (ARM11 ARMv6K SMP) support
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 5, 2023, at 10:47, Linus Walleij wrote:
> On Tue, Dec 5, 2023 at 8:00=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> w=
rote:
>
>>  static const struct of_device_id realview_scu_match[] =3D {
>> -       { .compatible =3D "arm,arm11mp-scu", },
>>         { .compatible =3D "arm,cortex-a9-scu", },
>>         { .compatible =3D "arm,cortex-a5-scu", },
>>         { }
>>
>> I see that the arm,arm11mp-scu device is provided by
>> arm-realview-eb-mp.dtsi, which in turn gets included
>> by both arm-realview-eb-11mp.dts and arm-realview-eb-a9mp.dts,
>> so the Cortex-A9 dtb ends up with the wrong compatible
>> string at the moment.
>
> Aha I need to make a separate DTS patch for that.
>
> As stated in the commit message I don't know if RealView EB
> is working very well on real hardware, I have only ever tested
> it in QEMU.

I think that is true for most users, and I see that
the Cortex-A9 variant of RealView EB doesn't even
have a separate qemu model other than possibly
"qemu-system-arm -M realview-eb-mpcore -cpu cortex-a9".

In this case, the easiest solution is probably to
kill off CONFIG_REALVIEW_EB_A9MP and its dts file
as well, since that is even less likely to have any
users.

>> The driver doesn't care either way, and we can easily
>> change the dtsi file use the Cortex-A9 compatibles
>> later, but I think we probably want to leave the
>> platsmp code to match the old string as well for
>> compatibility with old dtb files.
>
> The patch deletes the support for RealView EB ARM11MPCore
> Kconfig as well so it should go I think? Or am I missing
> something?

I was talking about EB_A9MP, not EB_ARM11MP here.

> The Marvell MMP3 is also defining the "arm,arm11mp-scu"
> but it's not using it for anything so I think it's just some bogus
> copypaste error (Lubomir can maybe fill in) and should have its
> own compatible.

Right, my impression is that these bits of MMP3
are all copied from realview.

> BTW is the Marvell PJ4B a descendant of the XScale PXA? I
> never manage to follow the lineage of these things.

Not really: while the MMP SoC design is a follow-up to
Intel PXA (using XScale), the later Marvell PXA and MMP
switched over the Sheeva line of CPU cores that
originally came from Marvell Orion/Kirkwood. The earlier
cores were ARMv5 and some even supported Intel's iWMMXt
FPU, the later PJ4 ones were ARMv7 with VFP but were
based on the same microarchitecture.

     Arnd
