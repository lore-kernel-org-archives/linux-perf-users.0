Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C204E189F5E;
	Mon, 15 Jul 2024 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721044108; cv=none; b=IqKsFSkEKHsiMNP+rneqDD9Z5bMsoS+AIHo5mw1K2wUeI0cE4s1s+AfCxY47OClQsHVwDlScf7kw70tRc5/VNMAk5aglj00mCykJEkAb0KTy/zB98ldJPXrbnjLtGe60bYO9WbZm0JhA9Q6+YZFTa/s/ff+DdSJLHxvAhO62YdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721044108; c=relaxed/simple;
	bh=FLWtFfdvvrNFy/+e+9BC4sdPIHWNO5XdMDInFcTzoDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc9KEi7w1dloY9a3ul0tFc0bR5G1+j4KxcMrQIjbrHOhhCn4I1MknRVNh48VRrakS0G63F/u+QUQEw8T3C1Ev5YouYC7K8EQI9TpBC38DNUDOGDnajDX3GGlGZIvdC4ogNI0lvyunDboXXtiew001Oo9SePBpK+vifQWhZAt1Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CpuyZT7n; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CpuyZT7n"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=GdN1/Drp1xef2wC63rTQRFwwYJdTm9BYYeLA8lGrLY4=; b=CpuyZT7nFh6H8fzJI25Mdrppq+
	ABSmYmXMrfzENzYSdEVE7x44QDIZu5EsOq5UdE93SX3FjKaafcToa6w3gX72syp1TUh0O3sLF2W+X
	lm9XgFktS3N7Z3AtlXNFT0WLaVq1OLipYS8Kv9hxQApr4nJn2Tg1ynjHgQ+LafL8197dG+pBYUZk4
	Ak3dzxBwQlvYe/i+Q4JnuKvMnNaW5KTuaHqijXxA/74AK6b+gd8yND90aH+HqaQcvJnZqPw/XxU/z
	2uGmdAAbiZCbnkfvAZGbZemSWm0oasFblpu9DCpk2qJ47nu4mJjxytnew9STbelI8/mZqVMD7758L
	s+CqXXWw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sTKBZ-00000001maL-2aKQ;
	Mon, 15 Jul 2024 11:48:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3FD723003FF; Mon, 15 Jul 2024 13:48:05 +0200 (CEST)
Date: Mon, 15 Jul 2024 13:48:05 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Ajay Kaher <ajay.kaher@broadcom.com>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org,
	mark.rutland@arm.com, rostedt@goodmis.org,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, yangjihong1@huawei.com,
	zegao2021@gmail.com, leo.yan@linux.dev, asmadeus@codewreck.org,
	siyanteng@loongson.cn, sunhaiyong@loongson.cn,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	alexey.makhalov@broadcom.com, vasavi.sirnapalli@broadcom.com,
	Vamsi Krishna Brahmajosyula <vamsi-krishna.brahmajosyula@broadcom.com>,
	nadav.amit@gmail.com
Subject: Re: [PATCH RFC 1/3] perf/core: add logic to collect off-cpu sample
Message-ID: <20240715114805.GF14400@noisy.programming.kicks-ass.net>
References: <1720700179-22839-1-git-send-email-ajay.kaher@broadcom.com>
 <1720700179-22839-2-git-send-email-ajay.kaher@broadcom.com>
 <20240711214936.GH27299@noisy.programming.kicks-ass.net>
 <CAD2QZ9YQ6n_6J+bq+wNxS5bGuAOsLkSiicigan84qaD+xrjS3Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD2QZ9YQ6n_6J+bq+wNxS5bGuAOsLkSiicigan84qaD+xrjS3Q@mail.gmail.com>

On Sun, Jul 14, 2024 at 09:53:10PM +0530, Ajay Kaher wrote:
> On Fri, Jul 12, 2024 at 3:19 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Jul 11, 2024 at 05:46:17PM +0530, Ajay Kaher wrote:
> > > following logics has been added to collect the off-cpu sample:
> > >
> > > - 'task_pt_regs(current)' has been used to capture registers
> > >   status off-cpu sample.
> > >
> > > - off-cpu time represent the time period for which the target
> > >   process not occupying the cpu cycles. And calculate as:
> > >
> > >   off-cpu time = swap-in time - swap-out time
> > >
> >
> > I have absolutely no idea what you're trying to do :/ The above does not
> > constitute a comprehensible Changelog.
> 
> Sorry Peter, it’s sched-in/out (not swap-in/out).
> 
> 'Perf record' captures on-cpu samples at frequency which is specified by
> the user ( i.e. time period to collect sample is NSEC_PER_SEC / freq).
> 
> This patch is to collect the off_cpu sample and time period of off_cpu
> sample is calculated based upon the time when target task was sched_out
> to sched_in, as:
> 
>  off-cpu time period = sched_in time - sched-out time

But but but... you don't need anything new for that. The sched_wakeup
tracepoint should generate an event in both the task/cpu that does the
wakeup *AND* the task being woken.

So sched_switch + sched_wakeup should get you all this already. What am
I missing?

https://lore.kernel.org/all/1342016098-213063-1-git-send-email-avagin@openvz.org/T/#u
