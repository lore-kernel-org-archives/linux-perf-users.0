Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23E514D6FC
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 23:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717545235; cv=none; b=OwNuZ/B09A5/sRti6a5WFQ0OeV7k9ali5SLo2+sfl2pM/U73w7lxOrHkGLqPiiCt/pQC8Efk3/BouBEafiXCCAZ/GUS5nCDiEQ8wNRMK5YCE5cfF5s36m7SWx+DDGn7QdYpkFeKdDSdJYOnVa6ds4+slGy2cjV7kFnd/I/cXq6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717545235; c=relaxed/simple;
	bh=TH50K4AVLCRJ9x0JcUUjkWd6fXDZInRnvzDvUjlNb4k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:
	 Subject:Content-Type; b=auxkHRpJhdggvJOP3AZ+M1Bn9wG7mpCtpjqpUIigjjuP7YgUnzU5qtNSGMMoJPP/O+hSB8v8pZGP6vlzQGUMWxClnxh0DaXnOcN8CjlRqUBOPrnrFsUt/TTqq1GrmGH8/HZRcC9YUvQBYJRyQtOvnCbtPVAeyiRz9oX2ogBlPaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuuzetsu.co.uk; spf=pass smtp.mailfrom=fuuzetsu.co.uk; dkim=pass (2048-bit key) header.d=fuuzetsu.co.uk header.i=@fuuzetsu.co.uk header.b=5Qh7Neci; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e4BEa4CS; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fuuzetsu.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fuuzetsu.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fuuzetsu.co.uk header.i=@fuuzetsu.co.uk header.b="5Qh7Neci";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e4BEa4CS"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id BE0831800130;
	Tue,  4 Jun 2024 19:53:51 -0400 (EDT)
Received: from imap45 ([10.202.2.95])
  by compute3.internal (MEProxy); Tue, 04 Jun 2024 19:53:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fuuzetsu.co.uk;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717545231; x=1717631631; bh=WVAyALYuHF
	ZBcXEEZrkUaYN1CbYlFlJRgzW9qN3mzic=; b=5Qh7NecimpMglJAKvWa/rlCNE/
	HgIcq3Qleoo/fJQftMyWcBEzszs6rfnPhzm5+ibkslGYeJAe4JIdxtJmwvjSslER
	sXejtRIVquBofcJxAbhaavByeA7GSmC7yPAu1QpuJQk7GHcStHe833b+FRZDkvYZ
	hzninTpC05WfkfEN3Yp+8ZWLGXhXvZyvx9a2Yy70i84jmdZb8xzehFVq3CnjouJI
	HMx8DQX1/HX69nOwSxT+gvaIB+NDlSxcdbPjvHQssM+Oh0RZPqjm+0rS8NGndcXS
	gOqvC2QHKsijHCtXC6L7pXqVMQ6+bB1qpbunnCrENG3h4QTCFsesE8fMmn9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717545231; x=1717631631; bh=WVAyALYuHFZBcXEEZrkUaYN1CbYl
	FlJRgzW9qN3mzic=; b=e4BEa4CS6AuyOzESnwrg2hJcub0+anU3nXR767sICrvG
	KetAdd+jCq38cvLLa9KG/SbaKmbhLYsVsRsRFT68A6pBDS+m6cILeIyvcFO2G7YW
	QKM2gF3gJ5Jvlx6pKWl/VDZC5EPDlL1a92fzm/DJX3WFQLRO+GBbjQklOXeI8RY+
	G+eOPYILoLR1QTNQxcrZzVTubQQ+uMQjasiHaNBwACk1RuFgUsPw8NhfHuwYNJdh
	sMSpPs/1KNjUmJfNLbjhsItm2Vw7Tstp+S5IhXw2G72QTIzGhlzenLuylWzuY7mi
	qR1SYIPvCtnv0Hww1hY0YzUr4GCqlxPzm3xHLBrpjw==
X-ME-Sender: <xms:DqlfZrgpOGukuImfeTeRviocSsndLjjKPdPhyABViptf7MeOHfQE1A>
    <xme:DqlfZoAv-2l_Q5ZKMQmjR-aABozh-vI6fyJ3R5HMWRkBK0KnYlbOuLP2faNipKHgC
    EPV1Qb-fudLvM3dUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelhedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfofgrthgvuhhsiicumfhofigrlhgtiiihkhdfuceofhhu
    uhiivghtshhusehfuhhuiigvthhsuhdrtghordhukheqnecuggftrfgrthhtvghrnhepve
    egvdduffehtdeuvdefhfefkeefkeeuhfeuheefjeeileefvdeuffejtdeludehnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehfuhhuiigvthhsuhesfhhuuhiivghtshhurdgtohdruhhk
X-ME-Proxy: <xmx:DqlfZrGRAI6RZTotYsKMlYWVk8dQ4ZFFerhaOdHtz4hNM1FcxsIeTQ>
    <xmx:DqlfZoR6Mgtcu2oyGJI7fDFcqnRN5wu0sL9VJQl8DDNBxu_FXgqEDg>
    <xmx:DqlfZoyGhMRIXwfecM8t4A401BuCpzFawfo0qYf2Jt7owTTfLg1Eqg>
    <xmx:DqlfZu6tRa9ToS5cGM-jXYXMRRxCENegv07bCb3WOHRzB0ET_cfcog>
    <xmx:D6lfZlrSBJiLoEO0Iq4VY6Y-qJXg-ovz7xQojZzdFdtb4F6x2lI0m2iG>
Feedback-ID: ia5d440cb:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CF061272007C; Tue,  4 Jun 2024 19:53:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-497-g97f96844c-fm-20240526.001-g97f96844
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1d63aa77-4809-45f1-8827-cb1ed6613f23@app.fastmail.com>
In-Reply-To: <f34d5d79-5d44-4a54-8e36-2720f4b25d4e@foss.arm.com>
References: <cfcaf804-d7b1-4d55-8465-12e1d238aca1@app.fastmail.com>
 <f34d5d79-5d44-4a54-8e36-2720f4b25d4e@foss.arm.com>
Date: Wed, 05 Jun 2024 08:53:30 +0900
From: "Mateusz Kowalczyk" <fuuzetsu@fuuzetsu.co.uk>
To: "Leo Yan" <niayan01@foss.arm.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] Why does libtracevent pkg-config detection wipe PKG_CONFIG_PATH?
Content-Type: text/plain

On Tue, 4 Jun 2024, at 10:26 PM, Leo Yan wrote:
> Hi Mateusz,
>
> On 5/27/24 01:56, Mateusz Kowalczyk wrote:
>> Hi,
>> 
>> To build recent perf, I'm having to apply the below patch.
>> 
>> ```diff
>> ---
>> diff --git a/tools/perf/Makefile.config b/tools/perf/Makefile.config
>> index 7f1e016a9253..b70fef12a977 100644
>> --- a/tools/perf/Makefile.config
>> +++ b/tools/perf/Makefile.config
>> @@ -1181,7 +1181,7 @@ ifneq ($(NO_LIBTRACEEVENT),1)
>>       CFLAGS += -DHAVE_LIBTRACEEVENT $(LIBTRACEEVENT_CFLAGS)
>>       LDFLAGS += $(LIBTRACEEVENT_LDFLAGS)
>>       EXTLIBS += ${TRACEEVENTLIBS}
>> -    LIBTRACEEVENT_VERSION := $(shell PKG_CONFIG_PATH=$(LIBTRACEEVENT_DIR) $(PKG_CONFIG) --modversion libtraceevent)
>> +    LIBTRACEEVENT_VERSION := $(shell $(PKG_CONFIG) --modversion libtraceevent)
>>       LIBTRACEEVENT_VERSION_1 := $(word 1, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>>       LIBTRACEEVENT_VERSION_2 := $(word 2, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>>       LIBTRACEEVENT_VERSION_3 := $(word 3, $(subst ., ,$(LIBTRACEEVENT_VERSION)))
>> ```
>> 
>> I don't understand why `PKG_CONFIG_PATH` is overwritten this way. `grep`ing for PKG_CONFIG_PATH reveals that this isn't done anywhere else in the kernel tree. All other uses of `$(PKG_CONFIG)` in the file simply invoke the tool.
>> 
>> Of course, I do actually have `libtraceevent.pc` available, it's just that `LIBTRACEVENT_DIR` is empty which stops it from finding it.
>
> When I was fixing the cross compilation issue for perf, I also 
> encountered the similar issue with you. I have sent a patch series to 
> resolve the compilation issue.
>
> It will be appreciated if you could check if the patch [1] can fix your 
> reported issue or not.

Hi Leo,

I applied the linked patch on top of latest kernel tree checkout and I can confirm that it fixes the issue for me, thank you!

> Also thanks for James' reminding.
>
> Thanks,
> Leo
>
> [1] 
> https://lore.kernel.org/linux-perf-users/20240604093223.1934236-3-leo.yan@arm.com/T/#u



--
Mateusz K.
