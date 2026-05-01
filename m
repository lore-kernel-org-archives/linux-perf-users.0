Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A0F3DBD7F
	for <linux-perf-users@vger.kernel.org>; Fri,  1 May 2026 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777655268; cv=none; b=ZRi/IGSctmnJUk9me48bwC3YuZ+Y2HBEuFCShfW845Tm4MGUOMIfxrtBGIZwS8ZHE6AR5w60Rrbk2gxPEncDsybhmb/kWGCjQylMZN/T2p7nW775GsTcksQXpKDzUBZstlGlQ8Cje7C4iR8MnoSRb0Ywuj5+XBLRSJj2fcXlgwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777655268; c=relaxed/simple;
	bh=mop/kyAOgpSMnNRpUTfsSk5B/TGe5m3N/kD7JflX7u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwX8kvjuqtrmnCz4oEMkaqNqCeGQSQ17GbHHEyzAsaNkR1uUvBGclDju3V3B4yeRgdXMgmZowhKc3N/qNPdZxK4ZJ9UqNEzjKOpIpKELhl/MZO4AI48KfvAp83XSvn0yNMQ1emUgcuB/TuRAD721RdWji4QDKWYAqdkcIV/yDVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Mzwi2jYk; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Mzwi2jYk"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-12c726ef332so3374144c88.1
        for <linux-perf-users@vger.kernel.org>; Fri, 01 May 2026 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1777655266; x=1778260066; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pjhLD46GgrwFtrW+Cu8bCL4s0pfPi6Irc1pFrdpBOcQ=;
        b=Mzwi2jYkzz1V7eRPIlJ3kA04Ze4JdSbOM4jXBnpiw/o1t7sDoqXMiJePnpt80Z6G5s
         JbZcgFPzwv6iL1nS3ThRTt5zwVrBXMxGBFPEM8Gzc+IC1T4Ckn1bYXH6VTUt/Zpm4BD4
         U1ROSI4+uSetPCpln/RnvVHcHnvTQlIvSmSSq9tdJofFOy9XPcakdecGLS6cw2qV+F8K
         56rqDwxlRGz8tb4V3kuCURIk7Te7WHMekgxCHhm2THc5CtWw7ucTi1hsIIraU9fM4DQQ
         OsKIIjcZuXbsODCISjTL/x6mawK/UxQY0Y5NmnnnPKf160vddLMerG3BJ2CblLZi3TW1
         R7cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777655266; x=1778260066;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjhLD46GgrwFtrW+Cu8bCL4s0pfPi6Irc1pFrdpBOcQ=;
        b=LY2moJiWwEbCeXy/Rapo31HdZ+l1kHQVxGmaF3/aCYHt+ItErgzs+DfAPlaDBE5EAo
         t+0KLtKxHE+/vwSyHTQEZPNk3VEbuTd/KC76uZIKWJghVyVPz+SyRm0cDSaHzUQ3twKh
         5IrbtsfLFChnykRwEwqu6pk/cvnTS/h8ixhp76Jo/J/XFwN8oEH6nhNvjkeTlDvTXc7k
         sfAtLupxZGQimza4C3HCkWKgUMP9jvuAId49uOi9Pnxz8H9HErlgEbSeOVoK05nmukoW
         9VxSHjnXCm8t8IecHMgS/m59slvW5Yl0G/k5haUcY+GCG/tBDauQxA+/hVu/a6MTBj4O
         YkDg==
X-Gm-Message-State: AOJu0Yyn6x/dQzdwsa+z4Fi+v0rEDDqQhMDMRkr/JjWWshdlPcoP7Eud
	YYl9LpFqg2HUSkdVV5XD2cOFXKeFi4SF+vKS6gwiovBfen9mWXdOlmkmWN6H9xpskzo=
X-Gm-Gg: AeBDiev0vpZ2I6Vxssz2fSplOGm6gyOb+CqKSDHwS82ajnj1FxNkrrPULAE8WJbHcEn
	wMVuXYPl+HVn8xeXjuY/wCuIEeT0qoXXreXcNJAHTKjSDgpb9RLO0xj7vbO/0Lq77/fJKbPFKwY
	9O6hHIbWtbGBmMoBMJtjTT/GE0pI1p4KgUdvRmi2jWP5v1DAIs1znIf2hfyJ+R9Hi2UVZjHw9SE
	pjMF52ecavnhJ/p60+GKKKcXWWU4q7T3pdrmD1GirWZJYEuoeOJdtDIlYGTpWrt6MzpPwhkaDpg
	uN+F33I/PlqF0ncrktoABPY7dx3GEpmH7fCQortLScMVGs8iRkuib+GK5dNrzpSVdlio2T1m4wn
	mENlze4FPHrycjJ/8oQAs2jOV08pXxzNnX/PFretA08ZS4MwzfQ3HwRYJNeAJ1+625EtCJIHgqg
	qHx6u8Y5GSGlUjGhTtoumuEgPRi1hmBUYB2og=
X-Received: by 2002:a05:7022:e994:b0:122:3a5:fc42 with SMTP id a92af1059eb24-12dfd81a4b8mr64380c88.20.1777655266224;
        Fri, 01 May 2026 10:07:46 -0700 (PDT)
Received: from mozart.vkv.me ([2001:5a8:468b:d015:427d:9211:132e:5a0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12df8288c07sm4118335c88.6.2026.05.01.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 10:07:45 -0700 (PDT)
Date: Fri, 1 May 2026 10:07:42 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] perf: Don't throttle based on NMI watchdog events
Message-ID: <afTd3iBqKjrypQVo@mozart.vkv.me>
References: <cover.1777483573.git.calvin@wbinvd.org>
 <33d87384aa5f96af76949d1399476779dd4f4fce.1777483573.git.calvin@wbinvd.org>
 <afKBd87b4AKbCYuL@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afKBd87b4AKbCYuL@mozart.vkv.me>

On Wednesday 04/29 at 15:08 -0700, Calvin Owens wrote:
> On Wednesday 04/29 at 20:38 +0000, sashiko-bot@kernel.org wrote:
> > > @@ -636,6 +639,19 @@ void perf_sample_event_took(u64 sample_len_ns)
> > >  	if (avg_len <= max_len)
> > >  		return;
> > >  
> > > +	/*
> > > +	 * Very infrequent events like the perf counter hard watchdog
> > > +	 * can trigger spurious throttling: skip throttling if the prior
> > > +	 * NMI got here more than one second before this NMI began. But
> > > +	 * never skip throttling if NMIs are nesting, or if any NMI runs
> > > +	 * for longer than one second.
> > > +	 */
> > > +	now = local_clock();
> > > +	last = __this_cpu_read(last_throttle_clock);
> > > +	if (__this_cpu_cmpxchg(last_throttle_clock, last, now) == last &&
> > 
> > On 32-bit architectures, is it safe to use __this_cpu_cmpxchg() on a 64-bit
> > value in NMI context?
> >
> > For architectures like 32-bit x86, the generic fallback implementation
> > achieves atomicity by disabling interrupts, which does not mask NMIs. If a
> > nested NMI interrupts the sequence halfway through reading or writing the
> > 32-bit halves of the u64, could this result in a torn read or write?
> > 
> > A corrupted timestamp could cause a massive wrap-around in the time gap
> > calculation, perpetually satisfying the > NSEC_PER_SEC bypass condition and
> > silently disabling PMU throttling for all events on that CPU.
> > 
> > > +	    now - last > NSEC_PER_SEC && sample_len_ns < NSEC_PER_SEC)
> 
> If this is a problem, isn't it also a problem for the 64-bit store after
> updating the EWMA just above this?
> 
> I guess last_throttle_clock could be a u32 and use the low clock bits,
> that's sufficient with the one second limit... but I would appreciate a
> real human opinion :)

Andi, since you had looked at the original patch, do you have any
thoughts about this?

I think the LLM is splitting hairs and wasting all of our time: I don't
want to waste more of my and everyone else's time on the autofeedback
unless a real human being agrees it matters. I feel like I've already
been far too generous to it TBH...

This dynamic throttling only exists to prevent users from shooting
themselves in the foot and losing the machine. All the edge cases the
LLM has described only transiently delay throttling when they occur,
and I don't think that matters at all.

Thanks,
Calvin
