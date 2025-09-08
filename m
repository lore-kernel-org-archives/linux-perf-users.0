Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B401BC41;
	Mon,  8 Sep 2025 05:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309770; cv=none; b=X6/yMo7Ak+GBayzej8rT3hIyjba+RZKa5WN1dqH3J1YFlum1st+NqkYS2M727IzUAuYXuT+FjODqei6oF/0SbkoysKHsWkzWuRV62aX+J0kk9AZtgWMVxnI1ZfD1/aQfdK89qLBH81NfKISRcR3v5ZlTAxPGb/cz9t8LWcUfvgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309770; c=relaxed/simple;
	bh=Q8bq6QR8fWoVrzIi82l8zNRUP0tiZKLaZu2mc1Q2OTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfrZEY11Tu9bTLQKs/xHsIckrsayoeLHWgTdR/ZZMyUerhsWO5yGmo3al1lodw1Mm4k9cU+Y59GG+sVMOT5hLrv96shmpYfum263e77/UMIXV2OnVhmlg7ECoyr/4UJOpPQpbj8oXK/yTYu5qJz2tpOHE+wPMz5EWS+6ZyAmDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ybb1rBPo; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ybb1rBPo"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b4d4881897cso2744753a12.0;
        Sun, 07 Sep 2025 22:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757309768; x=1757914568; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O//184ekENNe7/TMMlx7LZa+w+2boPr1l5+lEZSHfQY=;
        b=Ybb1rBPoskB1zfBhedyXYEQT+jH43dV/Ge6dkNitDvgc6qzoPxXgSBhIemQ+IEfJ65
         7v4s5NoGALCxeS9apKuS9ze6C102VffcL/f0BsdiLXyy2Ltgcy1hVWKbrdXbqYXXa0yM
         QSNY5SAyibNSf5De7/QsMrl9OWE1p9UzydLv0aSKuwK30Dw7fz/6BGjRM61cqD4tQbkX
         cJ7DJjVSQPBTAo9DGERAQz4Jo/6nBgneZNEI5p/H07L53AOH03L5jdA6nMgON4702/k/
         jA5aXq4vgVu7Ae5dfKpPVM+iPuUtvS8uXskqS3TPz0bR+4aLDujZXkLyTCuBQCMEjsYd
         sWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309768; x=1757914568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O//184ekENNe7/TMMlx7LZa+w+2boPr1l5+lEZSHfQY=;
        b=YVa9lhJ/rG7eF4AVcEBNI9r4TgwgA6yvKyODW3/WC1k2dkai+L1yWlkUyqQFQnI3+H
         KZ9cBT9QP1PT8C9ynL+pWOxGg9OSyApzS06eEvqshImRSxEzsMu4FJFvltZwI8Zy6D1J
         i2l28QvL5OVl51pHaSCOk/+hzclbyaGujFmdr6mmzxveINzf+T5Twj20RCp2SsvyW81U
         EVTwHiCsSxcRH3b/t/4D9mZNwMd2rE3r3p4GnFWaR68IyJecNfF1ROgaJSat1eY3+lsl
         bK7BkYCzRRlp2joWisQiHRJR62PHnebyjDQCZSk0dINZRJeu/vHNE8V4NzNrzdV6/dqh
         BdXw==
X-Forwarded-Encrypted: i=1; AJvYcCVJayJBcORd768iW1ZIeZ0fNTSr4beDdUKtU7AtGeN0AYGmsr4OX0OGwkMjNeZJMPr18UlaanK+/PpTo1M=@vger.kernel.org, AJvYcCWnlAlbMhTpMQbcndeXZFBGnLOddx1Fi6LZQvOXkiaccTwkGUAn+zauR7ss19LaJDG5pg09OB6ByphjT/L3dzKYBf0l@vger.kernel.org, AJvYcCWuW1de792UhFjfbTVdTucOolbQ5ar4xBR8sKUltqbiRaPKp2VZkfuI/zmdSNubJzVfbohebwwWICdC0389b3Sd4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxEnSzyY1MLKKCy4F524+87CvwPr+rFXCGez9D0aYxbck0q5GjT
	VBrdYEiY+jhvnbA1lXeJ2sQ0Vthk3oOB2gR/LilwV8qEjcqOjM8Byi7h
X-Gm-Gg: ASbGncvITLzUkxgRXlpOZHSts+MAnLj5UQeitKvKAuq0tDJcALFhDZsAhs1Ue0O2Qn1
	mWYqxaoLt3VLRJ6xuXr60PPNWQzp9qOhrL5GdtQi2hr8sqebk1LJ4ATb2DUNvRLHZPPE3Ry+FQB
	uxMvoWLDV7UQ6cGG0Zti//jQdC1Dvbc22FEjiv/dCrvIc/G25ocG+2WRum463Wbr73PDoIVnjis
	NAqEM02Sr5tbhlnFPprJwhuULh3pPHuIw/uD07Rb/PifeUxlDZ2+NPfDOsxNIW0H1ZgMG4aZJM9
	4ClCpE2jkjfGFzrUTRDew2CTKr/hftMRYgRhaHOxr0AHSRT4O9hb0ttV0gy3eDIJ4rPvqZcQMTZ
	le3ThBA/VqunHMEK9rPBfcJ2DM9D2YPr8xNiNkowxAEPFBh4=
X-Google-Smtp-Source: AGHT+IGJU9Rvc1SQDq43MWndwlklSyYn9Rwd+n1UlZjvW/FMqOjBhAEM/Cn8qNaaRO6JuHkBkj2esg==
X-Received: by 2002:a17:902:e881:b0:24c:ed9f:ba53 with SMTP id d9443c01a7336-251734f2f80mr92370065ad.29.1757309767705;
        Sun, 07 Sep 2025 22:36:07 -0700 (PDT)
Received: from localhost ([45.142.165.62])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccd655823sm99646425ad.114.2025.09.07.22.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:36:07 -0700 (PDT)
Date: Mon, 8 Sep 2025 13:36:04 +0800
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
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
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-perf-users@vger.kernel.org,
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/18] perf/hw_breakpoint: add arch-independent
 hw_breakpoint_modify_local()
Message-ID: <aL5rRIXYiFd8_Tz6@mdev>
References: <20250904002126.1514566-1-wangjinchao600@gmail.com>
 <20250904002126.1514566-7-wangjinchao600@gmail.com>
 <20250904064448.GU4067720@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250904064448.GU4067720@noisy.programming.kicks-ass.net>

On Thu, Sep 04, 2025 at 08:44:48AM +0200, Peter Zijlstra wrote:
> On Thu, Sep 04, 2025 at 08:21:03AM +0800, Jinchao Wang wrote:
> > Introduce hw_breakpoint_modify_local() as a generic helper to modify an
> > existing hardware breakpoint. The function invokes
> > hw_breakpoint_arch_parse() and delegates the reinstall step to the
> > architecture via arch_reinstall_hw_breakpoint().
> > 
> > A weak default implementation of arch_reinstall_hw_breakpoint() is
> > provided, returning -EOPNOTSUPP on architectures without support.
> > 
> > This makes the interface arch-independent while allowing x86 (and others)
> > to provide their own implementation.
> > 
> > Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
> > ---
> >  include/linux/hw_breakpoint.h |  1 +
> >  kernel/events/hw_breakpoint.c | 18 ++++++++++++++++++
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > index db199d653dd1..9453b5bdb443 100644
> > --- a/include/linux/hw_breakpoint.h
> > +++ b/include/linux/hw_breakpoint.h
> > @@ -67,6 +67,7 @@ extern int
> >  modify_user_hw_breakpoint_check(struct perf_event *bp, struct perf_event_attr *attr,
> >  				bool check);
> >  
> > +int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr);
> >  /*
> >   * Kernel breakpoints are not associated with any particular thread.
> >   */
> > diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
> > index 8ec2cb688903..ff428739f71e 100644
> > --- a/kernel/events/hw_breakpoint.c
> > +++ b/kernel/events/hw_breakpoint.c
> > @@ -983,6 +983,24 @@ static void hw_breakpoint_del(struct perf_event *bp, int flags)
> >  	arch_uninstall_hw_breakpoint(bp);
> >  }
> >  
> > +int hw_breakpoint_modify_local(struct perf_event *bp, struct perf_event_attr *attr)
> > +{
> > +	int err;
> > +
> > +	err = hw_breakpoint_arch_parse(bp, attr, counter_arch_bp(bp));
> > +	if (err)
> > +		return err;
> > +
> > +	return arch_reinstall_hw_breakpoint(bp);
> > +}
> > +EXPORT_SYMBOL(hw_breakpoint_modify_local);
> > +
> > +/* weak fallback for arches without support */
> > +__weak int arch_reinstall_hw_breakpoint(struct perf_event *bp)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> Again, so much fail :/
> 

> So we have:
> 
> {register,modify,unregister}_user_hw_breakpoint()
> 
> and
> 
> {register,unregister}_wide_hw_breakpoint()
> 
> And you choose to extend this latter with hw_breakpoint_modify_local()
> instead of sticking with the naming scheme and say adding:
> 
> modify_wide_hw_breakpoint_local().
> 
> Also, again, that EXPORT is a fail, these other interfaces are all
> EXPORT_SYMBOL_GPL().
> 
Thanks for your patience.

I was misled by another family:
  - hw_breakpoint_add
  - hw_breakpoint_del
  - hw_breakpoint_start
  - hw_breakpoint_stop

Since this logic was also added in the wprobe series by Masami, I will
adopt his version instead.
> Also note that modify_user_hw_breakpoint() doesn't seem to need new arch
> hooks. Yet you fail to explain why you think you do.
Thanks for feedback, I will study existing code to better handle the arch
dependencies.
