Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="gpss7fs/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hR+arfHV"
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD2BFF
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Dec 2023 23:00:07 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 830413200A66;
	Tue,  5 Dec 2023 02:00:06 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 05 Dec 2023 02:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701759606; x=1701846006; bh=Ia
	LuBMUbt7Bq6MzW3x/Fa4v5CIE8FfyrZOGwykmrdHQ=; b=gpss7fs/8TqAz0mnjc
	ePlqe94cRe8/+7NvchDndFI47/mtjircKNfVxxl0zdtjFprD4MFGtQLBDcIvCcO1
	d2ETFZXcN18h2Eo8qMZxvXD/ZJDQi+UF6FdNpMvehXnz1/R/cMPnxqOCorTeZRRL
	2nr3N9WNYr8MvxsDZsw/k6E02t8VybFEVhON8MautrJI18u5SOSA+2EZQpd1yt9j
	ny0NuFyvL4Bf+yCVE0Zs+knYAja1Isk2aJCPSj7MFd5TNc2UG1NwbD6wpOqFtO8/
	TZEa0rmTbxesXuu6aNQUUz4d9ipCppTt+bzryrmw4iRDaQXsCdA/yrMS9iZdOt0l
	WEuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701759606; x=1701846006; bh=IaLuBMUbt7Bq6
	MzW3x/Fa4v5CIE8FfyrZOGwykmrdHQ=; b=hR+arfHVmyfVNJNNEiA+zYxpJGK38
	phH8sLYsStaiR087KNHHyIpNkNRSVKSFfN1z7i9WzmVMstGEOTFa+Vv4dCzxB/jV
	ADw7/w4J1T0ooMlcGjJKHVLt9lZZ1jONUuVQu1J5EBfEG2+LHifDH8W0ctXGFSB/
	agpIgt/WQ0ZFBN1NFSbkXwpjBLIxaYf8oOXsMobU3rO6pkghFafRvri+OjDFaIYS
	aBgc5nFpbzOaOZivg2dbgjf9z4bEVctGjqz950iuJNAEKb0+JDK6FNrzSSwh83r0
	Tu7nlAblu1G9yBNa8LBqNX2QDoStvf45H4rwRuMiSAnKq5+McWaF+XBCQ==
X-ME-Sender: <xms:dcpuZXSfqRXYqzENvljz1dQ494_gL4A0YyyubRQKaVt77bUoddTVAA>
    <xme:dcpuZYw4YX0DuCAzlhCq1HmKpV5N36hnLxZh8E2Je4gsdGRiGAkuDU2lNIe59jQfX
    Qapjh1hOdUn8XoIUQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudejjedguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:dcpuZc0zozvhc4CmC0Oay3gfWa45dfCBsN1nDzapvFZpQeOfq3vaXg>
    <xmx:dcpuZXCo5tDxT9GuXRXCOEbVtS-B07aEQcKh1GWJF3yMHRMt9NPjDQ>
    <xmx:dcpuZQgcDtGZjD2tCn-Tiq2LplZcEsiQMfel3gGD770Mvm8xVKWW_w>
    <xmx:dspuZcj9-akMesgombIX1dJaN4zN3X8aRNLx2MLFvqkRfufhlz6Xcw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A7F24B60089; Tue,  5 Dec 2023 02:00:05 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1178-geeaf0069a7-fm-20231114.001-geeaf0069
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <93cc5193-aa1b-4df8-8d00-c3149c33b7e7@app.fastmail.com>
In-Reply-To: <20231204-drop-11mpcore-v1-1-f96cd3938cf1@linaro.org>
References: <20231204-drop-11mpcore-v1-1-f96cd3938cf1@linaro.org>
Date: Tue, 05 Dec 2023 07:59:32 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Linus Walleij" <linus.walleij@linaro.org>,
 "Mark Rutland" <mark.rutland@arm.com>, "Will Deacon" <will@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>, "Liviu Dudau" <liviu.dudau@arm.com>,
 "Sudeep Holla" <sudeep.holla@arm.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 "Lubomir Rintel" <lkundrak@v3.sk>
Cc: linux-perf-users@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: Delete ARM11MPCore (ARM11 ARMv6K SMP) support
Content-Type: text/plain

On Mon, Dec 4, 2023, at 23:36, Linus Walleij wrote:
> This ARM11 SMP configuration was one of the first SMP configurations
> the ARM kernel supported, but it has the downside of odd DMA handling,
> odd cache tagging, and often (as of recent) completely broken cache
> handling on the ARM RealView PB11MPCore test chips. To boot the
> platform it was necessary to completely disable the cache.
> When it comes to the EB 11MPCore it is unclear if this ever worked.
>
> These reference designs are now the only ARMv6K SMP platforms.
>
> As only reference designs of purely academic interest remain, and
> since the special-cased DMA and PMU code is hard to maintain and
> doesn't really work, it is not really worth our time.
>
> Delete the ARM11MPCore support along with:
>
> - The special DMA quirk CONFIG_DMA_CACHE_RWFO that is only used
>   on ARMv6K SMP, and we are the last ARMV6K system leaving the
>   building and the cache handling is awkward, so good-bye.
>
> - The special PMU handling that was only used by ARM11MPCore.
>
> The following is left behind:
>
> - TIMER_OF_DECLARE(arm_twd_11mp, "arm,arm11mp-twd-timer", ...)
>   in arch/arm/kernel/smp_twd.c, this is still in use by Marvell MMP3
>   arch/arm/boot/dts/marvell/mmp3.dtsi
>
> - IRQCHIP_DECLARE(arm11mp_gic, "arm,arm11mp-gic", ...)
>   in drivers/irqchip/irq-gic.c, this is still in use by Marvell MMP3
>   arch/arm/boot/dts/marvell/mmp3.dtsi
>
> These are unfortunate but will need to be kept around for
> compatibility. New Marvell-specific compatibles should however probably
> be added.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

This looks good to me (one small issue below), thanks for the cleanup!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>

>  arch/arm/kernel/perf_event_v6.c            | 34 ------------------------------
>  arch/arm/mach-versatile/Kconfig            | 17 ---------------
>  arch/arm/mach-versatile/platsmp-realview.c |  2 --
>  arch/arm/mach-versatile/realview.c         |  1 -
>  arch/arm/mm/Kconfig                        | 18 ----------------
>  arch/arm/mm/cache-v6.S                     | 31 ---------------------------
>  6 files changed, 103 deletions(-)

Russell, this touches both mach-versatile and core Arm
code, any preference for how we should merge it (provided
you are happy with the changes)?

I'm fine with the combined change going through your
tree or mine, or splitting it up.

--- a/arch/arm/mach-versatile/platsmp-realview.c
+++ b/arch/arm/mach-versatile/platsmp-realview.c
@@ -18,7 +18,6 @@
 #define REALVIEW_SYS_FLAGSSET_OFFSET	0x30
 
 static const struct of_device_id realview_scu_match[] = {
-	{ .compatible = "arm,arm11mp-scu", },
 	{ .compatible = "arm,cortex-a9-scu", },
 	{ .compatible = "arm,cortex-a5-scu", },
 	{ }

I see that the arm,arm11mp-scu device is provided by
arm-realview-eb-mp.dtsi, which in turn gets included
by both arm-realview-eb-11mp.dts and arm-realview-eb-a9mp.dts,
so the Cortex-A9 dtb ends up with the wrong compatible
string at the moment.

The driver doesn't care either way, and we can easily
change the dtsi file use the Cortex-A9 compatibles
later, but I think we probably want to leave the
platsmp code to match the old string as well for
compatibility with old dtb files.

     Arnd
