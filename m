Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA23F9263;
	Mon, 12 Oct 2026 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791800522; cv=none; b=Wxh6CagJMaS3cElPpK9U1d3GLOX2ODceEZC/N+qAGRzrvQ6Owq0hLAKs41+3lbJ3dNQplL4dXXoKwkbnasmk6ZhRMJUWOP3GHfL6lI8AGWGZk1aZxEgjuEqHEtg+sDx0GsWuSpbPLWYiLE8oK/TWw73bY4KhRBBO9z4RMCs3mJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791800522; c=relaxed/simple;
	bh=ryGcQFkXrp4eIh5B0BOLKz7Mmz9rcgC99kX3em/qqoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsqrTBUIWL5mSoEGpb2JZMF8BhFFA9RkTCiUfBSkg1K4epSXfwkUAqGyf+DnuCldFua2RvNmGK6ft9GGpM3aOUsP0rPDNrbrniXDps26Fv2VW5D5L+ou0G3U8OmZc4EEcYCSRO4DjA8B4PM1v8LaOq+cQ+ducQnpD5/33vJ1cXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EPf2wkUn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ROIpfpfC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EPf2wkUn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ROIpfpfC"
Date: Mon, 12 Oct 2026 12:21:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1791800504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeExXDFsSsDXoVieXWwNbhti6P2jB2qH9KovDmOCgIU=;
	b=EPf2wkUnii4Bo6dKs624vNS73b09GrSNLdGYyDpW8TTFlt+I3vg50rqcK66Z+B0Xqvsg7/
	rtm8ja4Pn/az0KHpP7T9zLU+Y1Lk+fdeTdyU0Blb0xk1SL0X6sl6bMsZm6SPg32//uiczM
	2CQg/3IwPk/xTwLdgikv+XBgQJSx8turDYA0O/EpAq6jixkW+MM9SuoJ7TbYbISzWRmpdW
	LmNm17RXcwDrrwi7lzDd3yOLPA2Qj+Th7k9yRza/vNswvrADCYTCZS3bnsmgIvu7wKx1hF
	3zEGZt50Fza13LP08QkyAi+NsyYqJQAq5BOHY4j2c7P+vcDJwP6J7ZmdP+A9lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1791800504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HeExXDFsSsDXoVieXWwNbhti6P2jB2qH9KovDmOCgIU=;
	b=ROIpfpfCZfohTWgaJ0XyH+2DOhlGL3FnkcnWoK1JRg6wmtUiJxJd4vKQozbPb15q0KBOpJ
	p8kkqcZa0DX1EeBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, linux-perf-users@vger.kernel.org,
	loongarch@lists.linux.dev, Mark Rutland <mark.rutland@arm.com>,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oleg Nesterov <oleg@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Waiman Long <longman@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	"Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
	James Clark <james.clark@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH v4] ARM, ARM64, LONGARCH, XTENSA: Delay HW BP
 notification to task_work()
Message-ID: <20261012102143.lpVrHb9R@linutronix.de>
References: <20261012090431.TF3iVDsk@linutronix.de>
 <CAAhV-H4=nnhbJS4srmt7dNdgpkEZ8_RQ5Z+0baYMiXF1UrJ3KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H4=nnhbJS4srmt7dNdgpkEZ8_RQ5Z+0baYMiXF1UrJ3KA@mail.gmail.com>

On 2026-10-12 18:15:51 [+0800], Huacai Chen wrote:
> Hi, Sebastian,
Hi Huacai,

> > diff --git a/include/linux/hw_breakpoint.h b/include/linux/hw_breakpoint.h
> > index db199d653dd1a..91e8d80220c54 100644
> > --- a/include/linux/hw_breakpoint.h
> > +++ b/include/linux/hw_breakpoint.h
> > @@ -85,6 +85,9 @@ extern int register_perf_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_hw_breakpoint(struct perf_event *bp);
> >  extern void unregister_wide_hw_breakpoint(struct perf_event * __percpu *cpu_events);
> >  extern bool hw_breakpoint_is_used(void);
> > +extern void perf_arch_hwbp_send_sig(struct perf_event *bp);
> > +extern void perf_hwbp_notify(struct perf_event *bp, struct perf_sample_data *data,
> > +                            struct pt_regs *regs);
> Maybe this declaration can be put in one line because there is no 80
> characters limit now.

We don't save much, do we? It looks more readable. Maybe if the perf
maintainer requests it. Looks like waste to repost it just for that.

Any comments on the looong bits?

> Huacai

Sebastian
