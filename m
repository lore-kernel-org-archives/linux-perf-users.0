Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57FA145FF5;
	Mon, 13 May 2024 06:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715583027; cv=none; b=fFJxCVfO/WwXQvASCLqH9cXHCcnlBmeQFF5tkVy/Y1B2IzOjMJuj2j8x4oSnKPbrVyvyyyuMqbk0E8N14IHXCpCLhSvVnPmynVJuHJDY3HwZ+0y8styyqji1ljsrxBYaMWjKi/ekujmn560qu4Pojvw6a+mopzxmCrRTfn9Ho24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715583027; c=relaxed/simple;
	bh=QUOm7V4vSiSrgeSHZ2JKQI5LAjwW9licY9YU1aJmr+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVfUFq2OWLrJ6LubsKolyuzKbLHs86YvpIkhFbUFCEotSPweEvYykWdY47UTuCafx3x0BRg0buv+0VPiBo0XQ8D4eVVNuDS+IJCm6kQLu4+5XsHBZU1o7QnaApz+cesVyvnOdf1wrFqW/qx967sPULB6dnqBHkhlPO+NxT/h+jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFxE9Cix; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFxE9Cix"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-573137ba8d7so8860841a12.0;
        Sun, 12 May 2024 23:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715583024; x=1716187824; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1/vfuyDEB6iqKuXa6PXzq38FF7XS/WAj88oyZv8SIIU=;
        b=KFxE9CixvjzIs5wq0um0pTIN9i9A0dd2QMwZW0NRMn1az2ciNG+QjWgPUDvkskM1iN
         vjKuc0N60GuWQHuIpuQkaOhOmrSxpgjyjwFlJZHMqSvnC5JWGzin/6vaLSdBEK/9mM4D
         3bHs4qAHqpveuSl88+tvsKOFP+Lx4c4rL06nk/F66iC5E77MI3Ot5iy1wFPcF+2pQIcn
         yHvhY9wdqLLw+RGuq8hTVIjq1mQ7rjJETvKamonTfdVYYMSGgWcWFaFM238ZYrMtB9Vw
         xbAodHtJmArpVj9dWsV/0j0rzUm2aywr+NsY7UCJYM1AkRLZ3kDUaS46BUV+AbBFp7sX
         E48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715583024; x=1716187824;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1/vfuyDEB6iqKuXa6PXzq38FF7XS/WAj88oyZv8SIIU=;
        b=W3yQNSAbwZeFtGg2dHiWhTVt588ay9nrBM4BBtArLOnTCBm06z38NYHaL0m2TfpJqg
         Gfvp7QYjqCMFecEbl6E4/g2EhXYzQx3p1YPMBVQnV66LRlzZCdme864+a6pcYbEHAY6b
         hf/hYB3XG+/ZJuezWZEOky+D6Nx1XuGQAPLP3KupGWHIk54avZQpClrJiP4z7BBzWk4w
         nXyPMOTVPyW62m3SV6CqBbik+8HCqgPy/F1MgdGNiCzhAPbLppo+H9k0VEKRl2pyYQba
         BufCtBM+tSSZqP3rhUuwxX/MuA8wAY1Kr8JPIxbWH+3wCm/FL7lmk+ICvdGrgyH7Rb8f
         X7ww==
X-Forwarded-Encrypted: i=1; AJvYcCWijyAq+Pekm66BURC+PfOtce6Y8jHMoK+JhAuXRjUZMwmFsYOQstL6xzqfxfl+zOHWTH/sXFLZigYsDRKghpQz7rsBUNF7Xspguq/bKfidPnSlTB+VLlsCmd7927E1MyR5r30aELC+xAI0OYvkjw==
X-Gm-Message-State: AOJu0YwZjbu20EsplsOZLqlS6oI3iNEc4WFl2rawlWU/LbPmekZ0tJF5
	vheL23Nd5bnCY56DGiQEnLSmxvR9trNJeTo1b9J16xSpq20O9Ug3
X-Google-Smtp-Source: AGHT+IE29z436yi9DtGoFUwAyCxpuHZu1P2d5NfwIO/DP5PToFoaH+9LkiqaqoOCy9236I3XbPfOig==
X-Received: by 2002:a17:906:30da:b0:a59:aa1f:55bd with SMTP id a640c23a62f3a-a5a2d18c72emr760070166b.6.1715583023979;
        Sun, 12 May 2024 23:50:23 -0700 (PDT)
Received: from gmail.com (1F2EF402.unconfigured.pool.telekom.hu. [31.46.244.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781cdb5sm550453666b.29.2024.05.12.23.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 May 2024 23:50:23 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 13 May 2024 08:50:21 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: Makefile.perf:1149: *** Missing bpftool input for generating
 vmlinux.h. Stop.
Message-ID: <ZkG4LWr7w11wQ/PR@gmail.com>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>


* Ian Rogers <irogers@google.com> wrote:

> On Wed, May 8, 2024 at 12:39 AM Ingo Molnar <mingo@kernel.org> wrote:
> >
> >
> > So I've been getting this perf build failure for some time:
> >
> >   kepler:~/tip/tools/perf> make clean
> >   Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
> >   make: *** [Makefile:90: clean] Error 2
> >
> > ... but if I clone a new repository, it works fine, until a point.
> >
> > 'make clean' doesn't work - and 'make mrproper' in the main kernel
> > directory doesn't clean up properly.
> >
> > Only if I do a brute-force:
> >
> >         rm -rf tools/
> >         git checkout HEAD -f
> >
> > does it get resolved.
> >
> > The failure condition triggers if I Ctrl-C the following build a couple of
> > times, without it being finished:
> >
> >
> >    cd tools/perf; make clean install
> >    ...
> >
> >    LD      util/perf-in.o
> >    LD      perf-in.o
> >    CC      pmu-events/pmu-events.o
> >  ^Cmake[3]: *** [pmu-events/Build:43: pmu-events/pmu-events.o] Interrupt
> >  make[2]: *** [Makefile.perf:709: pmu-events/pmu-events-in.o] Interrupt
> >  make[1]: *** [Makefile.perf:264: sub-make] Interrupt
> >  make: *** [Makefile:113: install] Interrupt
> >  kepler:~/tip> perfi
> >  Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
> >  make: *** [Makefile:90: clean] Error 2
> 
> We have a checked-in vmlinux.h:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/util/bpf_skel/vmlinux/vmlinux.h?h=perf-tools-next
> so this shouldn't have been a problem for a while. bpftool is no
> longer on that line:
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/tree/tools/perf/Makefile.perf?h=perf-tools-next#n1149
> so I suspect if you use a newer tree then things will work.

Was this regression fix propagated to v6.9 in time?

Thanks,

	Ingo
