Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3F3B5821;
	Tue,  3 Mar 2026 14:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772548517; cv=none; b=afvAhK/6nRAly0I8tnxTX9/BT+HB3V8griuQPMB2kz4YYtvGpR4p2WZeR9gUWoS/mdTdmFBnPtTTJkJfVTUaEO0LE6l3j37ECbffuovwEKsYbf27aw0nOsHFX+tw34Kbo+6md4pDdHX6uJNs9H/woqbYVP2o9d9upQZGuJd+l/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772548517; c=relaxed/simple;
	bh=yMxEEW7c1Q6pS5+Td8dMJB1IBtwEK2Szzq+cXsPpN4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKup6myUOz6v6UGJIpY6Kw0yUwUEBhEfH1yVnbVxUAffxTOUYgOOFW9wg2wQByUj7Tf/ZErEkBk0GR1XIQYymwBXE9sVQ/8iRk4y03dNJSA7ZXJCMpD0xWFLS3KIldxDm6u44qMu6VX0Wrws5QwKccuJqhVT1DjERHHn+kCA7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XdXdbdXe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XdXdbdXe"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mUHH7TGmqfSf4cD93nXWR9+jVFPtqYvk8wVFeKNEiSk=; b=XdXdbdXeewlXzHAEBT02jZZG5a
	Kl2u8QNtHiGOEk+5a5LSDtSXqDQzN1Iy4kQbnOdESOorf9VYAdg9u3Y3w0DUOHpFYvEP93PP1VfQy
	okYWe6ENMhCBiCEBJHgNrGCl6PxDTVwvAKFEhj+YuNFd2+PZd/e4o/1kV8sNdOsymorsN+ue01opo
	kLFnUuV4ZXizkLUxWmihUXnEwx+3NLaaA99zuu/d5gwJplgGvFbb5T64Oo0ls1of7aDaNdkvf26vs
	HYJW1qLBMRvvq/PgzSpy2Wy+tbMKcan5bWpknsrB6OrqlMmKgqx9fMwHH5tcq8s5MIpXveylM3lkg
	eb4SCSrQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxQq5-0000000BeQt-2K4P;
	Tue, 03 Mar 2026 14:35:09 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0F6D2300462; Tue, 03 Mar 2026 15:35:08 +0100 (CET)
Date: Tue, 3 Mar 2026 15:35:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Zw Tang <shicenci@gmail.com>
Cc: mingo@redhat.com, Arnaldo Carvalho de Melo <acme@kernel.org>,
	namhyung@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [BUG] WARNING in __perf_event_account_interrupt
 (kernel/events/core.c:2797)
Message-ID: <20260303143507.GB3698720@noisy.programming.kicks-ass.net>
References: <CAPHJ_VLapzvWHz_ot4uvxSJ_Z3ubtCCp=_ZVReh7KAwjxu5uFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPHJ_VLapzvWHz_ot4uvxSJ_Z3ubtCCp=_ZVReh7KAwjxu5uFQ@mail.gmail.com>

On Tue, Mar 03, 2026 at 08:37:54PM +0800, Zw Tang wrote:
> Hi,
> 
> I am reporting a WARNING triggered by a syzkaller reproducer on Linux 7.0.0-rc1.
> 
> The kernel hits a WARN in perf events interrupt accounting:
> 
> WARNING: kernel/events/core.c:2797 at __perf_event_account_interrupt+0x485/0x530
> 
> It is triggered from the perf overflow path while closing a perf_event
> fd created for a tracepoint (PERF_TYPE_TRACEPOINT). The call trace

Could you try -rc2, I suspect that commit:

  c9bc1753b3cc ("perf: Fix __perf_event_overflow() vs perf_remove_from_context() race")

will have also fixed this.
