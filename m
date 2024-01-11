Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5138E36A
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Jan 2024 00:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D9WPmE3I"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bb9d54575cso3782693b6e.2
        for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 16:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704933658; x=1705538458; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SKK/tTRBuavRCO0tKyYQaf5jC4NMYGmrRaJwy6HVSPU=;
        b=D9WPmE3IuUZw7zEKRYR6ioegSyHOy37Q4dv7s8umSrtPGlwq8NoPQyxWIZwvzRnuTW
         Y0SYISjHRDSpOsC74mSX41LSvKaAzI9bZRRPk0ku762WP1TodDVNWB6eHy7NJcnMsXwh
         znymz1MTwbCUbu+YdVc7rpySg5bBCzZ2ruFXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933658; x=1705538458;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKK/tTRBuavRCO0tKyYQaf5jC4NMYGmrRaJwy6HVSPU=;
        b=ipW2/LzU0j6szSFP/fq/OOeu3+dxeqxHAC/G4DtGJ0cijgc8oRuEcHuPaBGzxrruAo
         wps6TfsmcGpF1BHPUYudixFqPNTQJKpZAfN5fzIJXUYwx2O1J+jDfZ5xjSbLpGMBX3eI
         F4bMuB91MSMCZ8apoPqaHXFKmTccnGc/Q5MGRNapPQPPzDmlnYHX15Sxp3POqPYNzlSG
         zT82+rOsp7Lr83/KXhsABFALzzvVdYiBU7L7dLPHo4mcGKMiPF+aQ4DXOmioKwD4Os16
         E+j4hKCfozYI2hIG3FBHJWprRfvD/euIcACqQyRJMNTqGD3HB/nwzRjQn409KDsewxVI
         o3Ig==
X-Gm-Message-State: AOJu0YypgzMTGP/VJMk26LJPNBv91+vWIMA/0QOO3OyYrXRkLsu7+DoL
	5m4ahVUS256k24dSZDDO7XN4g4GCLqGO
X-Google-Smtp-Source: AGHT+IFea6zB7vekca2ldHeaLHOrf/AQDt2v60co7YDN+g4mnu1e2KuafvusxljN2A/vCGkxTMKnyg==
X-Received: by 2002:a05:6808:4489:b0:3bd:4c05:8744 with SMTP id eq9-20020a056808448900b003bd4c058744mr579102oib.99.1704933658467;
        Wed, 10 Jan 2024 16:40:58 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i18-20020aa787d2000000b006dac8b80102sm4067264pfo.203.2024.01.10.16.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 16:40:57 -0800 (PST)
Date: Wed, 10 Jan 2024 16:40:57 -0800
From: Kees Cook <keescook@chromium.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: Getting PMU stats on specific syscalls
Message-ID: <202401101640.21C835A8A@keescook>
References: <202401091452.B73E21B6C@keescook>
 <CA+JHD90kw0CX9=E18A7NBJrxdPDQuwrew355RV47oBhn_1s_QQ@mail.gmail.com>
 <01A077C8-95CA-4EBC-9504-CB971C284547@kernel.org>
 <ZZ32p0LRSt5-vFPX@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZ32p0LRSt5-vFPX@kernel.org>

On Tue, Jan 09, 2024 at 10:45:11PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Jan 09, 2024 at 05:04:54PM -0800, Kees Cook escreveu:
> > On January 9, 2024 3:30:32 PM PST, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> wrote:
> > >On Tue, Jan 9, 2024, 7:55 PM Kees Cook <keescook@chromium.org> wrote:
> > >> I'd like to get PMU stats only on specific syscalls. I haven't been able
> > >> to figure this out. i.e. how do I run:
> 
> > >>         perf stat -e some_syscall_name_here make -j128
> 
> > >> Try with the technique described here:
> 
> > >https://www.spinics.net/lists/linux-perf-users/msg09253.html
> 
> > >Using the syscalls:sys_enter_syscall_name and
> > >syscalls:sys_exit_syscall_name as on off switches.
>  
> > Yeah, I can get walk-clock time, but I'm trying to get much more
> > detailed stats (cache hits, cycle counts, etc).
>  
> > It seems I can only get PMU counts from a whole process. I was hoping
> > to avoid creating a synthetic workload that only exercises the one
> > syscall and instead get a view of the PMU counters under a real load
> > but only for the duration of the syscall...
> 
> This is the sequence I thought would do what you want:

Oh cool! Thanks for the example. I will give this a shot.

-- 
Kees Cook
