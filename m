Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1AC26CE25;
	Fri, 14 Nov 2025 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763107672; cv=none; b=jQOwSZUOwtTPCr1r9/rwJwYhf/qwi2ZO0QwMYS0Cd2REs/BkVgve8tzM2hli5yFdNUkt7/s7Fu8OwqG4WeLWcLgIi3FgROLGPxuYUDCTrSEJCn5SguoLF1DwvMZnGOr29uXcSts0K0S6MqtRUKehJmY25sh1MT58Zuf076nXB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763107672; c=relaxed/simple;
	bh=/UDmOgmrTSBOSNZVGiQrkY/E6AOxVYxscfsxhWDvuHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LFkTrAHL/opXa1wSj5RcU7f4CjlNMUm5za5R0bmpJrrfeCtLLDC+hgAXMDhPeZMrErttWFGckKI5ZMuEgvoDRxvPN/SCJvih16HNrD+W8c1oK0xmjmjAgNSsXg5SerkCohWkx4tFytykr6fUFfHR7uVW2kPqLH51EgJgihlG3qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb68trvG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb68trvG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FACC4CEF8;
	Fri, 14 Nov 2025 08:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763107670;
	bh=/UDmOgmrTSBOSNZVGiQrkY/E6AOxVYxscfsxhWDvuHU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sb68trvGIZFkRzHD5IRKW/oKkOfFm9z/sv7jyLvT4dQeaCOmnGt66rsDrkBmEN2Yq
	 3Fis2i48R0wckK54AMabj0xUAr+JPcbQQGgXnKbD8026J+OsCo+MaJnHquqVv8Dc5B
	 HWWhsi1LYZJaHo5IUaNTiBxTYzQdyIL8kI8U7XFEb+aAZpsULxe7ulGiwG65RNAuZs
	 p/vVuYCyXLy2Yg2LckjNk9VQ7yxomTZkXpxcj5jYeJM5IwSeYtY5w3vnSoC6aEgP6h
	 89uIReeeAFltewm8jLsQuA6uk22xlbozEzHcqlPg3tbJza0puSKHjhhGQIY9eUct/d
	 KnN+J1x6UT5pg==
Date: Fri, 14 Nov 2025 00:07:48 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH 1/5] perf jitdump: Fix PID namespace detection
Message-ID: <aRbjVG3q2kCOl8BJ@google.com>
References: <20251105191626.34998-1-iii@linux.ibm.com>
 <20251105191626.34998-2-iii@linux.ibm.com>
 <aQ1WiC3Id82pTHAI@google.com>
 <b02b6c7a1fcea87248a60ee9c94aaa6e078316d0.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b02b6c7a1fcea87248a60ee9c94aaa6e078316d0.camel@linux.ibm.com>

Hello,

Sorry for the delay.

On Fri, Nov 07, 2025 at 09:19:47AM +0100, Ilya Leoshkevich wrote:
> On Thu, 2025-11-06 at 18:16 -0800, Namhyung Kim wrote:
> > On Wed, Nov 05, 2025 at 08:10:24PM +0100, Ilya Leoshkevich wrote:
> > > perf inject fails to detect jitdump file produced by a process
> > > running in a different PID namespace if this process has not exited
> > > yet.
> > > 
> > > The PID namespace heuristic in jit_detect() compares two PIDs:
> > > 
> > > * pid: outermost NStgid of mmap(jitdump) caller from perf's PoV.
> > > * nsinfo__nstgid(nsi): innermost NStgid of mmap(jitdump) caller
> > > from
> > >                        perf's PoV.
> > > 
> > > The semantics of the in_pidns variable can be seen in, e.g.,
> > > nsinfo__get_nspid(): it's true if and only if perf and the profiled
> > > process are in different PID namespaces.
> > > 
> > > The current logic is clearly inverted: if pid and
> > > nsinfo__nstgid(nsi)
> > > are different, then the profiled process must be in a different PID
> > > namespace. This, of course, ignores that fact that they may end up
> > > being equal by accident, but that's not the point here.
> > > 
> > > Fix by flipping the comparison.
> > > 
> > > Changing just that, however, breaks the case when the process has
> > > exited. Add explicit support for that by adding "synthesized" field
> > > to
> > > nsinfo, which tracks whether NStgid was obtained from a running
> > > process (ignoring considerations of PID reuse or running inject on
> > > a different machine). When the namespace information is
> > > synthesized,
> > > assume the process ran in a different PID namespace.
> > 
> > I'm not sure I'm following.  It'd be great if anyone understand the
> > topic well could review.
> 
> Perhaps some data from the testcase from [5/5] can make it more clear.
> Here are the PIDs that exist in reality:
> 
>              unshare[a] perf-record unshare[b] jshell
> Host PIDNS:  1000       1001        1002       1003
> PIDNS[a]:       -          1           2          3
> PIDNS[b]:       -          -           -          1
> 
> In jit_detect() we deal with 2 of them.
> 
> - pid is jshell@PIDNS[a].
>   It is taken from the MMAP2 event, this is how perf sees jshell.
> 
> - pid2 is jshell@PIDNS[b].
>   It is taken from "jit-1.dump", this is how jshell sees itself.
> 
> - nsinfo__nstgid(nsi) ideally should be jshell@PIDNS[b].
>   This is jshell's innermost NStgid.
>   But perf can see it differently. This is the core of the problem this
>   series deals with.

Thanks a lot for the example and explanation!  I'm trying to understand.
:)

> 
> Why does nsinfo__nstgid(nsi) vary? Because the kernel does not record
> it, and perf has to guess it. I have a WIP patch to fix that [1], but
> it needs a lot more work at this point.
> 
> How does perf guess it? It looks into /proc/$PID/status. This is quite
> unreliable, but this is the best perf can do under circumstances. As a
> result we have 3 possibilities:
> 
> - The original process is still around. This is the buggy case. In this
>   case nsinfo__nstgid(nsi) == jshell@PIDNS[b]. IMHO this is a very
>   clear indication of namespacing, and that's why the condition should
>   be flipped.

So perf would look at /proc/3/status and the file would have the below

  NStgid:  1003  3  1

and *in_pidns should be true, right?

> 
> - The original process has exited and PID was not reused. I believe
>   this is the use case the current code has been extensively tested
>   with. In this case perf assumes there was no namespacing and
>   nsinfo__nstgid(nsi) == pid. That's why I need the "synthesized"
>   field: to indicate that NStgid is just an assumption and didn't come
>   from any real data source.

Ok, can you please put short comments on each boolean field so that we
can see the meaning of them clearly?

> 
> - The original process has exited ans PID was reused. I am not trying
>   to deal with this here, because this is rare and absolutely anything
>   is possible. The only concern is running perf inject on a different
>   machine, but I'm also not sure whether we should care about this.

Fair enough.

Thanks,
Namhyung

> 
> [1]
> https://github.com/iii-i/linux/commit/4b519b774eed850abe0757df39be13a704d2748e
> 
> [...]
> 
> > > diff --git a/tools/perf/util/namespaces.h
> > > b/tools/perf/util/namespaces.h
> > > index e95c79b80e27c..41ba2ea8137e5 100644
> > > --- a/tools/perf/util/namespaces.h
> > > +++ b/tools/perf/util/namespaces.h
> > > @@ -38,6 +38,7 @@ DECLARE_RC_STRUCT(nsinfo) {
> > >  	bool			in_pidns;
> > >  	char			*mntns_path;
> > >  	refcount_t		refcnt;
> > > +	bool			synthesized;
> > 
> > It'd be nice if you can put this along with other bool fields.
> 
> Sure, will do.
> 
> [...]
> > 
