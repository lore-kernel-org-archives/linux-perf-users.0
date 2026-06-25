Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3827E35AC00
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jun 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782378642; cv=none; b=kIVTydfrAf53sIG+oj/HUEKjaEXsmYRwNveHEf70EZTCgt6ejXuSTfXPDbkjHOYAjO/YvJnztXKKoR9uMMh7DS/souk7RH2hhBeX12a0liL9TETiyvS0jZY2a0IgFVsx7j1+Z3PAiE1xw6EPz7hFd0HhdNGsmFC3xxQe7IRQiV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782378642; c=relaxed/simple;
	bh=G0vBagMm0ieFzup4YLfopFJNtJUW4rndd7e+AydHtO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZfa01actQwKH/RqKG7KgW1Y+VcYpgueziEL2/hYqrIukHfQoUasmY5/ywuM/AJCivFdrvBdRBYqoL2RjgiVe3K0a+otLuKgVfv3vQ64RPSgiEcUOWG9/j0ZCZAD1y2iD9cg/3OCoSa0xxogK29f5XsqhwENTUbznCven+2uauA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JBh67hq8; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JBh67hq8"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-46019b190b6so1669690f8f.3
        for <linux-perf-users@vger.kernel.org>; Thu, 25 Jun 2026 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1782378640; x=1782983440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MiLqXmBDb7ZWVjHCd2a5Lz+vJUTtAmbRgJLuU9Ruhcw=;
        b=JBh67hq8mddQ6mcUJpzD092VVC/3s+opTmR7Wg/gX8+s5w/MzKgD9dRFiDY7xEGhD7
         Z4y28HERPHI+r/znUsUscQuQRifPXxiY9jCR0wqQn8YSP++rh47wTQUUCI2iijLa241e
         aanltwTDq4Lg96AbuCbCsEBfIPnDqr5JRsX29CVPQQTOGkY+FopCZZ7wVKDksrwz1/hK
         lcrivgyInDpjX++AbETUUJ87rQlgDVRMZlSWQgigrrFZiWPtfnMoL5raoEB2Sb/2xOdw
         HS3wHf3An0ns2EsNUbrW/S8wwGhw8HAVk9komOG2axmmgK52XjGqSY/1iAJufRz/DsLd
         rdOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782378640; x=1782983440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiLqXmBDb7ZWVjHCd2a5Lz+vJUTtAmbRgJLuU9Ruhcw=;
        b=deB0rTEuAWLfEASvBPXYylS/9ceBGSk24hWuWsb3kvBUm7DpmfdhzxqoR6opQIl3/f
         trIVpJDjCGZGMIfWfiI6h3GVwcW/bTc6M4H0PuFF4a6jfe9SufxzokBo6dYsoIH2LEV1
         ZoYsbtGAHyi1Dmjoevm5DxUWJJmWBLYrti83aS15oXrFXl5KW5dfGQ72Jdp/U1tZAKSN
         vu8o9jHTaB+ghJHvk9F2TPT2Mnxm7wwPW/fdGOgaIBnlxnm1gEIuk/w209K5gX4TX2P9
         xEZ6Ew0tsZznm/LXNifXgKHhTNBoWe7cerArlJhCHN4487gIgMuLmQuBNneinxCW3c44
         6qdA==
X-Gm-Message-State: AOJu0YxZe8aAASiymrswLUsxgpCvYd/u14EfPuc+4mZ9KqkzKfWY0HM5
	sIVK/+UShqy7iYq5/nvd3ig+3yVB7+0XD9n0Y8fWjz84HxqX9crNGii9BK7Xbqx689M=
X-Gm-Gg: AfdE7clWF/3J4LUVNEn5peepuxxmcHrtCfBxCyfez5SUibQvANeiB1RB6OywkUvLEOc
	NJBIEDwXP8h73AzTCY6OZg9DZMnCF+MzckkoCD/zWo1bNS4G21Iy/sau9mO7mMNGEtiv9FXbrkn
	/EysBW9CVeWfHrkKjPnBgZNl9m1DiBH3EV04kyC/k9DVZZFCzh9e3YQJsk9ijnMTzgPyxQ3sJN9
	3XmxYoT0nelipRvky0lAVe7at6RqYbRcaTIIj9FJWefiMvzk2oDGZzhF7VDIuy4ucmpfJiUaJBI
	UvcsBMQ3T+Hv8l1Ob8hApjX8DwYKOLnjqEO7vK6U2DGlviipWfGpHYgDCydIjw+eD8tfVtrvRP2
	ONsoWInLCUWHW5zTM7VNq/Dyj7B+GI9rx5nOLmfUgt6kpmMxCC8U00yD+jwr6qZ3YJbCBwnicMZ
	12iBAU7ZAWbnf2rXs=
X-Received: by 2002:a05:6000:25f1:b0:460:64e8:2553 with SMTP id ffacd0b85a97d-46dbf303509mr2291377f8f.4.1782378639570;
        Thu, 25 Jun 2026 02:10:39 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d9405sm15939403f8f.22.2026.06.25.02.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 02:10:38 -0700 (PDT)
Date: Thu, 25 Jun 2026 11:10:36 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	live-patching@vger.kernel.org
Subject: Re: [PATCH] perf symbols: ignore livepatch symbols
Message-ID: <ajzwjNncrI3Bob_o@pathway.suse.cz>
References: <20260624201254.472576-1-joe.lawrence@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624201254.472576-1-joe.lawrence@redhat.com>

On Wed 2026-06-24 16:12:54, Joe Lawrence wrote:
> Livepatch modules contain special symbols (prefixed by ".klp.sym.") that
> act as relocation placeholders.  Once resolved, they point to the same
> addresses as the original kernel symbols they reference. [1]
> 
> These special symbols confuse the 'vmlinux symtab matches kallsyms' perf
> test as kallsyms may report multiple symbols sharing a single kernel
> address.  For example:
> 
>   kallsyms (without livepatch)
>   ----------------------------
>   ffffffff81a41110 T __pfx_arch_release_task_struct
> > ffffffff81a41120 T arch_release_task_struct
>   ffffffff81a41140 T __pfx_exit_thread
>   ffffffff81a41150 T exit_thread
> 
>   kallsyms (with livepatch loaded)
>   ---------------------------------
>   ffffffff81a41110 T __pfx_arch_release_task_struct
> > ffffffff81a41120 T arch_release_task_struct
>   ffffffff81a41140 T __pfx_exit_thread
>   ffffffff81a41150 T exit_thread
> > ffffffff81a41120 w .klp.sym.vmlinux.arch_release_task_struct,0  [kpatch_5_14_0_570_94_1_1_3]
> 
> When perf loads kallsyms, both symbols are inserted into the
> symbol table at the same address, corrupting symbol end-address
> calculations and causing test failures.
> 
> Filter out symbols prefixed with ".klp.sym." when loading kallsyms, as
> they alias existing kernel symbols.
> 
> Link: https://docs.kernel.org/livepatch/module-elf-format.html#livepatch-symbols [1]
> Reported-and-tested-by: Ben Procknow <bprockno@redhat.com>
> Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
> ---
>  tools/perf/util/symbol.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> >From Ben's tests:
> 
>   Without patch:
>   ./tools/perf/perf test 1
>    1: vmlinux symtab matches kallsyms                                 : FAILED!
> 
>   With patch:
>   ./tools/perf/perf test 1
>    1: vmlinux symtab matches kallsyms                                 : Ok
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index fcaeeddbbb6b..eeaed3f5cf50 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -774,6 +774,10 @@ static int map__process_kallsym_symbol(void *arg, const char *name,
>  	if (name[0] == '$')
>  		return 0;

It seems that the above checks has been moved into is_ignored_kernel_symbol(),
in the current Linus' tree, see
https://lore.kernel.org/lkml/20260522082604.89447-2-qirui.001@bytedance.com/

> +	/* Ignore livepatch symbols */
> +	if (strstarts(name, ".klp.sym."))
> +		return 0;

I guess that this check should be moved there as well.

Nit: It might be possible to include <linux/livepatch_external.h>
     and use KLP_SYM_PREFIX instead of ".klp.sym."

> +
>  	/*
>  	 * module symbols are not sorted so we add all
>  	 * symbols, setting length to 0, and rely on

Best Regards,
Petr
