Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C25818C358;
	Wed,  5 Jun 2024 07:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571386; cv=none; b=BahedciPErmU7ebwx5+Bf62HhJL3MPrPiwfbXhGdwW0Wnme/9viCe3NMs0/LIsQHhb/jCr817nU3D/Oo7XUlKfEY48M3ELvDHh/2t1ZOTELFttm12J8wALNw9Z/duh0YH/92YlbQ5MzrZ8KPFqWpW6L5hkNBA/VwnjgY42gWgUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571386; c=relaxed/simple;
	bh=3M0GTq5JlMYDdq9jvAZyw0hxA5KJ1tDF0oBT0jEW/14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJaiFOUZ+R8AD0+aTHTxYGHDO0keJy9q/Ku9Q6y/Y33+r533bykPJW8CMktAAxxHUywHT2nlrnfn3gw/HBbolnA+7eNwKJwD+MxGy+ECEjkjm2sBEaNeHRa7sI1Xgp9/AK06BSvMbTYBQlwWc3P/DvyaFmeqye03B1L2qnHcmuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XV3WmlQc; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XV3WmlQc"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68f10171bdso390001566b.0;
        Wed, 05 Jun 2024 00:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717571383; x=1718176183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf8WXRz3mghAyg61mToRoi3mY1JcwBbyp3d5uTmlT04=;
        b=XV3WmlQcFrVSJNTOTd6sMvj3iN1JpXhZj1gY5U4k01I25Jqb5Et1yFlUo/pTBJV2US
         7AlXVDVDpD1EsB4RBxByuCk0SALfjDML2zJvkuP6BB7kH8ibi3U3A0WoMWTGWm4QpkoQ
         No2Qjz2CM719qS5NX/R6SS4iNV81kanDIzqbBw7Hh/QvfzCjie1mV+YQCLvTTjhrWr+W
         SoXMznrZifdnDsRnWDdLLUS0L+EvAyz1eeJ+d+YZ36aWpb4QjTVs+6NaHLvlhePqMi9E
         uf8/V00sqI04noQ8NrJOH2F12oGn/O9eSv3aoX7yhBNsVHp4fYVnMC3b40sXS5MgkLt/
         0ubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571383; x=1718176183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vf8WXRz3mghAyg61mToRoi3mY1JcwBbyp3d5uTmlT04=;
        b=rvmC7DCRyaWJbps5aYmdvbUO0/yhZ8B7r0PR7DUaa/W622NnLcXXWyaDSoQtJGo+kb
         PbJ0UkJ3w6nxLSRKXkbocWoZzGZFXCWT1gWiHIBAUCgQ89CebKNXtULQKXpaxOWAlYCc
         Vyh4/Q7ZFa6FsyKJ7UqwwS+cI6IXTuGrjfvAbjg48UIQGkEee+chWnxiOhMKHmOqKH7t
         FJrlONM67/nTsfDCL42Zt6fuQLKrcH3Txg9KiiD0gM/OSMijLyZAcWuPkJK0B84gJ+Bv
         1zPwSHjk9VKE7ZBl2knS40GHTUbG8/gWr1a3tI0QgbDv/V2+OI866I1K7v6nIPPsPn0q
         VDDw==
X-Forwarded-Encrypted: i=1; AJvYcCVsWNnMGKIoY2Pcjv4JomlVGmW7iP2cKrkoKFPWnEiGYcVwIfZ97osxahGgK/4hLM4yVDzloy80yAeffhEbPxMA6SQZnJegn0e9ps8WLF/WnP/Se77PREPfH15e4KZGayrZrHpcbsPcZt0O9xhW0A==
X-Gm-Message-State: AOJu0Yzg4AGxaE38N++W+LvBGdUn/SDNypYbyn8/++po3ZnDKNHLzdK/
	bKIZ+B15pkPOx+4sWkSUZ197xSJedeyNf/vNOvIigRwNUJUBvcPT0+jaq7NB
X-Google-Smtp-Source: AGHT+IEohwK0j/DRj5fwblj3eVtFAQ8csC+QlmfrL1fzVbQgSSLk3+tjFNGh7oJcjwnzyFN8rslNtw==
X-Received: by 2002:a17:906:7191:b0:a65:c143:b3d3 with SMTP id a640c23a62f3a-a699f3639bamr120143166b.3.1717571382293;
        Wed, 05 Jun 2024 00:09:42 -0700 (PDT)
Received: from gmail.com (1F2EF2F4.nat.pool.telekom.hu. [31.46.242.244])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a68f56506dcsm469396666b.57.2024.06.05.00.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 00:09:41 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 5 Jun 2024 09:09:39 +0200
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
Message-ID: <ZmAPM27gkBNVinMT@gmail.com>
References: <ZjssGrj+abyC6mYP@gmail.com>
 <CAP-5=fUvLiCDVDFFfJ78ng4T1FZ8j2N9Yt1sGTeGsupkbFEEug@mail.gmail.com>
 <ZkG4LWr7w11wQ/PR@gmail.com>
 <CAP-5=fVHrKcqwczoU1uMD4tP5DTVhfQ1T_hXnm_y5Ji3M6K_ag@mail.gmail.com>
 <ZkJK3x3zQ9a4wp8E@gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkJK3x3zQ9a4wp8E@gmail.com>


* Ingo Molnar <mingo@kernel.org> wrote:

> 
> * Ian Rogers <irogers@google.com> wrote:
> 
> > > Was this regression fix propagated to v6.9 in time?
> > 
> > We switched to using the handwritten file in v6.4:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/tools/perf/util/bpf_skel/vmlinux.h?id=a887466562b425bd6183bf75b523c1477c9fd22d
> 
> So there must be some different regression then, as this is readily 
> reproducible for me on v6.9, as per the build log below - I simply 
> Ctrl-C-ed a build, and the next build results in:
> 
>   kepler:~/tip/tools/perf> make clean install
>   Makefile.perf:1149: *** Missing bpftool input for generating vmlinux.h.  Stop.
>   make: *** [Makefile:90: clean] Error 2
>   kepler:~/tip/tools/perf> 

This happens easily on latest upstream v6.10-rc1 as well:

  kepler:~/tip> perfi
  Makefile.perf:1173: *** Missing bpftool input for generating vmlinux.h.  Stop.
  make: *** [Makefile:90: clean] Error 2
  kepler:~/tip> 

What's going on here?

Thanks,

	Ingo
