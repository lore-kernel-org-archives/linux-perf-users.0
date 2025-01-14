Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8C122DC5D
	for <linux-perf-users@vger.kernel.org>; Tue, 14 Jan 2025 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847549; cv=none; b=hKGpX9Ep0FQ7tJpTodiq9S4PnPC0LTnIa5cWvXQS50ypc7P2MtKxjQTDX1+QPNI3wh5MgtNRxqXp0zSHTu/LcCubwNLN/p0wTUzgeSkngOhriX3HnV3Am039ulFTv8mrFEChpCd1TtGjYACe31ADU8ytzzHc1qfIGH/DEsqK9ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847549; c=relaxed/simple;
	bh=qN/VG+Vod9psIT7fu1eKG85gsEfAygoNSb9K1HrU1vI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOUSyy7h9H4bhWrTwcXTDqtn+Se4jiXJ55G2C9ZnZp7uhJuEf+7QG3OQWaJp2rt7iIYXp+WT+2J7xxHJit/1iFSTRYnW78vJG2cEeXW6haGUMLrhQwAYcNVsCW5R5Rx3+tJjN86paycJkArXmsrclUaDvYUxJMXQejLEFz5/2jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Z8ZC3qLl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z8ZC3qLl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=//cnz16QtxIeFxE5HuqqMlIHhp2wCbbIRFz56oeXV+4=; b=Z8ZC3qLlXFInCy0E8sMysmqZEG
	hcShwfX6HK1lK5fX2nr4BW747dyy2etYeC/0M+GoSIsfTMgbutXSFBGkEjISWHkDyo/rgNiuKwjzz
	CJlrLyk5lJlVFcqxnsBzRLLKCJrmATdE2ehINywT0BSZ48TWkr7ouN69/v+LPKQfO5fSHnVW11xF5
	AMs0o2qn3+HCEc60mtCJlNifvHipkuKBg2CXNdCAB62OWR+a8Kvx8DktJJ8GCAOkBmdSEuQdooke3
	lLx2U4jGmCxvM/eGcFBU4iegjXU4Z6jwO1wqyybLZQghUprUTPQzAxXFpvTAew0zRPpFYx/n4DnP4
	JHUKx5Ng==;
Received: from 77-249-17-89.cable.dynamic.v4.ziggo.nl ([77.249.17.89] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tXdNz-0000000DFaI-0Ijg;
	Tue, 14 Jan 2025 09:38:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id F23613004DE; Tue, 14 Jan 2025 10:38:57 +0100 (CET)
Date: Tue, 14 Jan 2025 10:38:57 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, vgupta@kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-perf-users@vger.kernel.org
Subject: Re: Fwd: Bug: Potential KCOV Race Condition in
 __sanitizer_cov_trace_pc Leading to Crash at kcov.c:217
Message-ID: <20250114093857.GL5388@noisy.programming.kicks-ass.net>
References: <4CB5EE98-DA69-4598-B08F-C9F432C68707@m.fudan.edu.cn>
 <F16B62F9-6F58-4503-AB8D-47087E973905@m.fudan.edu.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F16B62F9-6F58-4503-AB8D-47087E973905@m.fudan.edu.cn>


-ENOCONTENT ?

On Sun, Jan 12, 2025 at 04:51:01PM +0800, Kun Hu wrote:
> 
> 
> > 下面是被转发的邮件：
> > 
> > 发件人: Kun Hu <huk23@m.fudan.edu.cn>
> > 主题: 回复：Bug: Potential KCOV Race Condition in __sanitizer_cov_trace_pc Leading to Crash at kcov.c:217
> > 日期: 2025年1月12日 GMT+8 16:35:31
> > 收件人: vgupta@synopsys.com, Eugeniy.Paltsev@synopsys.com
> > 抄送: andreyknvl@gmail.com, akpm@linux-foundation.org, elver@google.com, arnd@arndb.de, nogikh@google.com, kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org, "jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>, Dmitry Vyukov <dvyukov@google.com>
> > 
> > 
> > 
> >> 2025年1月10日 20:13，Dmitry Vyukov <dvyukov@google.com> 写道：
> >> 
> >> On Fri, 10 Jan 2025 at 09:14, Kun Hu <huk23@m.fudan.edu.cn> wrote:
> >>>>> HEAD commit: dbfac60febfa806abb2d384cb6441e77335d2799
> >>>>> git tree: upstream
> >>>>> Console output: https://drive.google.com/file/d/1rmVTkBzuTt0xMUS-KPzm9OafMLZVOAHU/view?usp=sharing
> >>>>> Kernel config: https://drive.google.com/file/d/1m1mk_YusR-tyusNHFuRbzdj8KUzhkeHC/view?usp=sharing
> >>>>> C reproducer: /
> >>>>> Syzlang reproducer: /
> >>>>> 
> >>>>> The crash in __sanitizer_cov_trace_pc at kernel/kcov.c:217 seems to be related to the handling of KCOV instrumentation when running in a preemption or IRQ-sensitive context. Specifically, the code might allow potential recursive invocations of __sanitizer_cov_trace_pc during early interrupt handling, which could lead to data races or inconsistent updates to the coverage area (kcov_area). It remains unclear whether this is a KCOV-specific issue or a rare edge case exposed by fuzzing.
> >>>> 
> >>>> Hi Kun,
> >>>> 
> >>>> How have you inferred this from the kernel oops?
> >>>> I only see a stall that may have just happened to be caught inside of
> >>>> __sanitizer_cov_trace_pc function since it's executed often in an
> >>>> instrumented kernel.
> >>>> 
> >>>> Note: on syzbot we don't report stalls on instances that have
> >>>> perf_event_open enabled, since perf have known bugs that lead to stall
> >>>> all over the kernel.
> >>> 
> >>> Hi Dmitry,
> >>> 
> >>> Please allow me to ask for your advice:
> >>> 
> >>> We get the new c and syzlang reproducer  for multiple rounds of reproducing. Indeed, the location of this issue has varied (BUG: soft lockup in tmigr_handle_remote in ./kernel/time/timer_migration.c). The crash log, along with the C and Syzlang reproducer are provided below:
> >>> 
> >>> Crash log: https://drive.google.com/file/d/16YDP6bU3Ga8OI1l7hsNFG4EdvjxuBz8d/view?usp=sharing
> >>> C reproducer: https://drive.google.com/file/d/1BHDc6XdXsat07yb94h6VWJ-jIIKhwPfn/view?usp=sharing
> >>> Syzlang reproducer: https://drive.google.com/file/d/1qo1qfr0KNbyIK909ddAo6uzKnrDPdGyV/view?usp=sharing
> >>> 
> >>> Should I report the issue to the maintainer responsible for “timer_migration.c”?
> >> 
> >> If it shows stalls in 2 locations, I assume it can show stalls all
> >> over the kernel.
> >> 
> >> The only thing the reproducer is doing is perf_event_open, so I would
> >> assume the issue is related to perf.
> > 
> > Thanks to Dmitry,
> > 
> > Hi perf maintainers,
> > 
> > We reproduced the issue for multiple rounds. 
> > 
> > Does the frequent occurrence of perf_callchain_kernel in the call chain indicate a possible problem with the call chain logging or processing logic for performance events?
> > 
> > We lack the relevant technical background, could you help us to check the cause of the issue?
> > 
> > ————
> > Thanks,
> > Kun Hu.
> > 
> 
