Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7EB2E0407
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Sep 2025 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758765936; cv=none; b=tGm/PmsmRggMqK8LdQiEgsKCHpO2VRy520oS55keNUsay+InSaY9CoCscuPFDjVRucmuZLNGEUdNmiLztSyu5VBTKD/gRSgxnxXAoOvBPyNbVGcGrM2ZLoyi3QQ9Xdk5GDidHr1W+HIx7kPhu6vW8f+lkc3qKXHw+vTiOuLUonA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758765936; c=relaxed/simple;
	bh=c7OOe7lcw1oi9g6/DwjJWKSlU0/KgpD3/2hH1JCaeIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TmQyQMZBh4ZikEq3f5xckbmWseh/04O6TGY/iuPXXN20PAVV9MzpzmBwn14sfZgXOK+o6GHMGbjMktTeobuvbOCc8CZxSKiife6gtl7Buad0vt41qzcJEQWiQn+K7/Low+crt/Jzgv3JDP2MZ6hfHggdKZDa7nXCh4kdrcdE/WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imZee1bp; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imZee1bp"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b5565f0488bso327668a12.2
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Sep 2025 19:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758765934; x=1759370734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JHHL33LsFFZTfiqVPHubJTFh9Ll2HmMvlyBTNdInq0Y=;
        b=imZee1bppeV7lQeuJ63deUwCVif2AxKlwsUK8w6ovlwZ13BKv6xN5dzPtekCjtwSnL
         n0dPq0n84+Hi9ehqzipvh8a2WuGxBHkeNIXCmgN4+c7E6+RB8SXYehwaZDbdUZXRnHt+
         lTOb8heTuyOMaVoEFex4hTVpfiy82YYnXuwKz3yODJWQuPqehf+xbFTVPsRx54qqgRLf
         V8qprIzqmu4ViwChP1OHEPFwWYQhST9tg79FGDrux6R3zUJNvS/34S+d5kRqdHMXC41u
         VcnI0CJnGSAxbo6FZLFKlYYPYDO6dRWO6SqlFlmaOqw7PKlmT0Eql0ErzVPMHdSu0ohJ
         g2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758765934; x=1759370734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JHHL33LsFFZTfiqVPHubJTFh9Ll2HmMvlyBTNdInq0Y=;
        b=ILlXuV51RlZZPXy/Y8WoN5C6NOIWcSYPOsU1D7ZmDQ76ZuDQrP+J+oJbf/k6EYjSSL
         S6wG5ufMjK+c1iPpDfh6EmvqwhnNyv3U8XlRteRBg8vrJ4n6fMnSeIlVPb0fsHv/VBKd
         qV3rt49ncKt0LSR3aIdtcumurnpXha1simKpIOsA6q+YUincI7+6hZe2heoYzPn29Wvy
         VhZSYqiRkjUl9lVwGugrTY14es+/eO2Wyf3lVqK4J+AWSDiy/s6B3NkgbZPD+FW+L0KY
         O/4R31U2ioFojzLc7xQsOiHxAT/nGEuDOIor69zpALwrHDx9KHr+39PsD9/nwrPLn93o
         QAZw==
X-Forwarded-Encrypted: i=1; AJvYcCXP+a4ptdR+zvUGjUlpd1/nkq5sddd/FvETyJy3xlAQkh+1OctrCVO5cCZIwhrqaPUZ+kpwnjR0RNXUegzqkvhq@vger.kernel.org
X-Gm-Message-State: AOJu0YxVne8wWI8LWZLSTVHh07a6NQXyjiFChNpZg8SmSjA2yhkhK0AH
	h0oXqCfccm5/pMPeKACCuwnSpx9MUKgt+UReLUxnrDOXsQJ6MBIxjTt6
X-Gm-Gg: ASbGncuuCf/ph83Nv4XB5mmNx+0IFsZLLS6NZUiERG78H8WHSEuLZcFTcEW5cmd93Po
	QN9S+yHMW+AxuBlHmkrRT2vnJx+pTPvdHoGgYasYkDQPRHf1QD4ccw/zoj3Q3pr3/GL7Z5Sw4VO
	TPHw5M4sQymXjn/9SSbod9NjGB5dbhkujSjQKd5Pr64Hod1tIw7kK+xuyMKRWIvMlVu19Kvf46e
	cfM3y8wx0cNg8Jy0Ewn7AQbswN7mJVUFcbfDAQ1vTFnulYBMAFXwGaWLFGJlOaieGrtWluFeXAG
	rNq/76axsf0jrmYlZ+5lgxDvH/k5x9nUtgn99tKjbRr4QDikjCWLTeKSiW5SSa6So2/0ElrT7ls
	ew/gbOfYheeOKByQnAPuwUTTCIO3jZGs2tw==
X-Google-Smtp-Source: AGHT+IH7ui9TJXKQ2pJIcwuIZvxvX8PqduYqo+2cQ68cM5ywCGeSLrO3GT6IefQ6CqCfyu2awBs3nA==
X-Received: by 2002:a17:902:d50a:b0:267:da75:e0f with SMTP id d9443c01a7336-27ed4a06dd7mr20974665ad.11.1758765934070;
        Wed, 24 Sep 2025 19:05:34 -0700 (PDT)
Received: from localhost ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c26faasm387777b3a.93.2025.09.24.19.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 19:05:33 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:05:22 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>, Rong Xu <xur@google.com>,
	Naveen N Rao <naveen@kernel.org>,
	David Kaplan <david.kaplan@amd.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Nam Cao <namcao@linutronix.de>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, llvm@lists.linux.dev,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	kasan-dev@googlegroups.com, "David S. Miller" <davem@davemloft.net>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 04/23] mm/ksw: add build system support
Message-ID: <aNSjYrXXO2BjYA87@mdev>
References: <20250924115124.194940-1-wangjinchao600@gmail.com>
 <20250924115124.194940-5-wangjinchao600@gmail.com>
 <3504b378-4360-4e55-b28d-74aabd4308d7@infradead.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3504b378-4360-4e55-b28d-74aabd4308d7@infradead.org>

On Wed, Sep 24, 2025 at 10:06:10AM -0700, Randy Dunlap wrote:
> 
> 
> On 9/24/25 4:50 AM, Jinchao Wang wrote:
> > Add Kconfig and Makefile infrastructure.
> > 
> > The implementation is located under `mm/kstackwatch/`.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  mm/Kconfig.debug             |  8 ++++++++
> >  mm/Makefile                  |  1 +
> >  mm/kstackwatch/Makefile      |  2 ++
> >  mm/kstackwatch/kernel.c      | 23 +++++++++++++++++++++++
> >  mm/kstackwatch/kstackwatch.h |  5 +++++
> >  mm/kstackwatch/stack.c       |  1 +
> >  mm/kstackwatch/watch.c       |  1 +
> >  7 files changed, 41 insertions(+)
> >  create mode 100644 mm/kstackwatch/Makefile
> >  create mode 100644 mm/kstackwatch/kernel.c
> >  create mode 100644 mm/kstackwatch/kstackwatch.h
> >  create mode 100644 mm/kstackwatch/stack.c
> >  create mode 100644 mm/kstackwatch/watch.c
> > 
> > diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
> > index 32b65073d0cc..89be351c0be5 100644
> > --- a/mm/Kconfig.debug
> > +++ b/mm/Kconfig.debug
> > @@ -309,3 +309,11 @@ config PER_VMA_LOCK_STATS
> >  	  overhead in the page fault path.
> >  
> >  	  If in doubt, say N.
> > +
> > +config KSTACK_WATCH
> > +	bool "Kernel Stack Watch"
> > +	depends on HAVE_HW_BREAKPOINT && KPROBES && FPROBE && STACKTRACE
> > +	help
> > +	  A lightweight real-time debugging tool to detect stack corrupting.
> 
> 	                                                         corruption.
Thanks, will fix in next version.
> 
> > +
> > +	  If unsure, say N.
> 
> 
> -- 
> ~Randy
> 

-- 
Jinchao
