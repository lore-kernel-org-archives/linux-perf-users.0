Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1912018F2CE;
	Wed,  5 Jun 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571919; cv=none; b=qzBsT2bHQDRkA7nUwIpn3MYEMKDSdZJq1NWJGS/ouVTa80K0CxBTFf5j7SsGCp5+vKYR4KTAVmChhKLALr/d1drx7jOoTXn13CdERIrGBzPMwWu1MKfImjspD4u4SG0QLBOYJo7qAPP97kATl4zvZVfJxvNYW8fGgtjhoqNbcTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571919; c=relaxed/simple;
	bh=m+UuNv/WLkgRzQQ99MoqMzHOaOLAkbVmyBLCmcQ8WCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d29oK/YXN+8sTm6ptX/RLBDOeMpoViQi6G6+4aotQJ27NB+huHgrPLReHCkOZlfc6xd/K06LyNnt7tC4/KimYwloNUMAj2ZKwiVNTZTk3lskq7wETyljfbKG1LQgl9RDXmU0ZTEvy/2HBCLAUhvGE33+AgYFEBKOF2lMLmisoPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4jGj/6i; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4jGj/6i"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso963005a12.1;
        Wed, 05 Jun 2024 00:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717571916; x=1718176716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJkV49/e3kmyn+mnJ4dZBH7P5g4cBR8xr3PBj28hycs=;
        b=h4jGj/6ifVgo2KKW1Jw+HMoculC++ffKWBT2m3nreJFR9xKIF7Mxcs6vMP2M164Of4
         w08aWhXkhHifBJnrhsb0NuAd9vnT2bKe+kChvjAN1L+S14a6yyDe0YpiplZiaVUxK+7z
         xPl52UXrIMIC1Fk7tTn7XM7HimI7L8GuTT7oAqSOFyzDhaqcq4KIn56IK1f0fbZPqauv
         kefQjsA9QJcZ1b0qPfDceySA9fIpRM5bTxwHdumqzt1i5rx83eEscVGn46jgYl7Wwqzl
         cUrV8aoZ9/0ayLb1OZsz6Ekcki/iK+8MkM2m0Cra91L9zxZn7qsuPIBidTkrC/76MnJH
         D6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571916; x=1718176716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJkV49/e3kmyn+mnJ4dZBH7P5g4cBR8xr3PBj28hycs=;
        b=gSmGumXqyNfrIE0M4VuKFYcDl4tRtZDU5+VhIuZt6fIYvIjcESf4fT88hUaAVPXMNt
         X/QHNsSPmu8CS363DRxjV+7J9oyHqgUoTImwjXbSEbUHEssRJ/aseIPha5b5E2U7+bgx
         bnu3mzxGb+AbZx8i4eaktBLqGNtjPgs08JMDp5wI+CDckJFURGTufgaCPDICknxkKFaB
         PZR7m9jrwP/Lc3Wcw+Bl0b3+zHulzf0N0D2y8r82U3bR41XOJ4SaDR1o7FditnV9ePAy
         jE+0L4ImE2X15JnMYg2TO85iCMlR10hbeRQ9gY+V+XuOWGkGk9ewZyDq0fw1fTlSB+mP
         ypyw==
X-Forwarded-Encrypted: i=1; AJvYcCXK59qH6/Yrdqv8zrUPChB+xeBtcQCpZsnq6HxmzBvvOrfhVD/eReU0c5m5XpfN7E/lmj4KbtIA+dsRAkG6AyHTqYtUhz5bfqOotJbMGejUpFsyP8+LeSpZs1DrdFE4e2N24EpkrkQWXAMkNTalHg==
X-Gm-Message-State: AOJu0YzEKswws4Hz2LEY0NzRrQpX9qWoD1luQU8dsp9ZlVBZVdv32tVP
	puN1Exi60NGDX4KFEbN35axO//hF4wsIWGd2A8sxU3ALKThois7J
X-Google-Smtp-Source: AGHT+IGOFcO+w/4SaxPdpsa5MvQWd+I4ouHSyUWNUhrQ4Ip+e0D+UR5X93+Gt0Pgs4rJaQ/x3K41HQ==
X-Received: by 2002:a50:99c9:0:b0:579:cd1c:8d69 with SMTP id 4fb4d7f45d1cf-57a8b676eb6mr1422889a12.2.1717571916153;
        Wed, 05 Jun 2024 00:18:36 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31bb8230sm8802547a12.26.2024.06.05.00.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:18:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 5 Jun 2024 09:18:33 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
Message-ID: <ZmARSXB0Wqp6wMpr@gmail.com>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
 <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com>
 <CAP-5=fUh+GoqERAF-qf8zx4kwq2uzwR2Ugop5XOkPexYGAqF3A@mail.gmail.com>
 <CAP-5=fWXDPfNqLz6DHYe9+dev_e6X5TcTe_xzOOz27yDkT7o7A@mail.gmail.com>
 <CAM9d7ch5HTr+k+_GpbMrX0HUo5BZ11byh1xq0Two7B7RQACuNw@mail.gmail.com>
 <ZmAQfJ9C5fFQdjQM@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmAQfJ9C5fFQdjQM@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Namhyung Kim <namhyung@kernel.org> wrote:
> 
> > Hi Ian and Ingo,
> > 
> > The failure happens when you don't have vmlinux.h or vmlinux with BTF.
> > 
> > ifeq ($(VMLINUX_H),)
> >   ifeq ($(VMLINUX_BTF),)
> >     $(error Missing bpftool input for generating vmlinux.h)
> >   endif
> > endif
> > 
> > VMLINUX_BTF can be empty if you didn't build a kernel or
> > it doesn't have a BTF section and the current kernel also
> > has no BTF.  This is totally ok.
> > 
> > But VMLINUX_H should be set to the minimal version in
> > the source tree (unless you overwrite it manually) when you
> > don't pass GEN_VMLINUX_H=1 (which requires VMLINUX_BTF
> > should not be empty).  The problem is that it's defined in
> > Makefile.config which is not included for `make clean`.
> > 
> > Can you please verify if the below patch fixes it?
> > 
> > Thanks,
> > Namhyung
> > 
> > ---8<---
> > 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > index 5c35c0d89306..e6d56b555369 100644
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -214,6 +214,7 @@ NON_CONFIG_TARGETS := clean python-clean TAGS tags
> > cscope help
> > 
> >  ifdef MAKECMDGOALS
> >  ifeq ($(filter-out $(NON_CONFIG_TARGETS),$(MAKECMDGOALS)),)
> > +  VMLINUX_H=$(src-perf)/util/bpf_skel/vmlinux/vmlinux.h
> >    config := 0
> >  endif
> >  endif
> 
> Yeah, this appears to be doing the trick here - judging by a couple of 
> tries of interrupted builds:
> 
>    Tested-by: Ingo Molnar <mingo@kernel.org>

Specifically I also tested it on a failed tree, by merging in your fix the 
build now progresses as expected. So this is fixed for good.

Thanks,

	Ingo
