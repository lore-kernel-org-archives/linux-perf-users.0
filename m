Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41434193425
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 07:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732606472; cv=none; b=KwZhvwvF46ZAnsd8pXG026nfdTY9m6A+wx42uGH4zy1wO9BevfZwYFov8EUc4GEc+4LorLiiz3ixY0qPcvB9eDRL4VzTr3uZAEH23nXsTyiKCmKT9xq8xUZ3nWGEfEkaqeB+jtBgVkpexgB7n6B5M1dL+zVDbiynmm0uy1YV0HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732606472; c=relaxed/simple;
	bh=PiI8RDTnl0VVSARmgX/7a9HouH8vYFUEaT/rYTdhTAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UK4o1sSLO1VW+p/S0kZXTmElrG1tt4Mrp+ARQiGuJ/dD2yO5H3D/NBOq6lFnne2glN1EYlAr8YTSbYGme4EKODk2vtWonewhkDVv4sTlvHCUiC1Wx3LC8Z4An8SlDrNSnQyd3diWSwqGkYnu7TP5HzFmSp29JggNh35/4zhoymU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=J/KpQY64; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="J/KpQY64"
Received: by mail.gandi.net (Postfix) with ESMTPSA id D44D520003;
	Tue, 26 Nov 2024 07:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1732606465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4HIxDoTWJQXA0J35F6Ojzfhf71LHJ+sjxbgJWCPbHVc=;
	b=J/KpQY64fsA0ZcOXa0Vrkco0yhyoKINq9n+JpvATaDt6nF37sSWYV9bT9aPkt3r/1puEgJ
	L7BuSNiMEoiVjTALt2aoAn/jlfkoOkpxY8eWHpyYi2XjEns5M1nqgpFnHE5Ngg+QOUliCL
	u+KZ7em04AcRvOAHZNFgyMf+yStAGMzO/31XSMX0jGnjP70Uk7cISqw/Zgz3KqnyQEE6py
	nMUjfS8Tlt3EKjw9hPl0G+A3C718lH7oJnYK5UGe8Vr5SHemaQD54vbKdiq2IFZ7Q+TMEp
	DOsoRn881fKzNPRdot+Lf98CveS4Uyxo97neiBU7kNawx7FkPcPXQ8mqzzAftQ==
Date: Tue, 26 Nov 2024 08:34:23 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: namhyung@kernel.org, linux-perf-users@vger.kernel.org, "Yann E. MORIN"
 <yann.morin.1998@free.fr>, "buildroot@buildroot.org"
 <buildroot@buildroot.org>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v9 1/4] Create source symlink in perf object dir
Message-ID: <20241126083423.63591cbf@booty>
In-Reply-To: <Z0TMMouXlvhyk6j3@tassilo>
References: <20240807231823.898979-1-ak@linux.intel.com>
	<20241125182506.38af9907@booty>
	<Z0TMMouXlvhyk6j3@tassilo>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Andi,

thanks for the feedback.

On Mon, 25 Nov 2024 11:12:50 -0800
Andi Kleen <ak@linux.intel.com> wrote:

> On Mon, Nov 25, 2024 at 06:25:06PM +0100, Luca Ceresoli wrote:
> > Hello Andi,
> > 
> > +cc Yann and the Buildroot mailing list (see the end of this report).
> > 
> > On Wed,  7 Aug 2024 16:18:20 -0700
> > Andi Kleen <ak@linux.intel.com> wrote:
> >   
> > > Create a source symlink to the original source in the objdir.
> > > This is similar to what the main kernel build script does.
> > > 
> > > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > > ---
> > >  tools/perf/Makefile.perf | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > > index 175e4c7898f0..d46892d8223b 100644
> > > --- a/tools/perf/Makefile.perf
> > > +++ b/tools/perf/Makefile.perf
> > > @@ -163,6 +163,8 @@ ifneq ($(OUTPUT),)
> > >  # for flex/bison parsers.
> > >  VPATH += $(OUTPUT)
> > >  export VPATH
> > > +# create symlink to the original source
> > > +SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)  
> > 
> > I found that since this patch got applied in 890a1961c812 (v6.12-rc1)
> > building perf fails silently in some cases.
> > 
> > The cases I have tested:
> >  - make <FLAGS> -C tools/perf                       -> OK
> >  - make <FLAGS> -C tools/perf O=/my/out/of/tree/dir -> OK
> >  - make <FLAGS> -C tools/perf O=tools/perf          -> fails
> > 
> > The failure in the third case is silent: make exits with a return value
> > of 0, but there is no perf executable created.  
> 
> The failing case is incorrect arguments because the O= is relative to -C 
> and there is no tools/perf/tools/perf

OK. However I get the same result even with O=$(pwd)/tools/perf, which
is precisely what Buildroot does:
https://git.buildroot.net/buildroot/tree/package/linux-tools/linux-tool-perf.mk.in#n170

> But yes a error message would be good.

Sure, as well as a non-zero return value.

> Could just ignore the linking error, so that you hopefully get a better
> error message later.
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 9dd2e8d3f3c9..18f639ec853b 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -164,7 +164,7 @@ ifneq ($(OUTPUT),)
>  VPATH += $(OUTPUT)
>  export VPATH
>  # create symlink to the original source
> -SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source)
> +SOURCE := $(shell ln -sf $(srctree)/tools/perf $(OUTPUT)/source || true)

I tried this but I don't see any difference. What is the change you
would have expected in the build output?

I'm afraid I don't understand what the SOURCE variable is supposed to
do so I can hardly follow the logic.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
