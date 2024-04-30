Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3DA199E88
	for <linux-perf-users@vger.kernel.org>; Tue, 30 Apr 2024 19:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714505580; cv=none; b=W6LFovmuw+vHSrGpNwOc+AzwUSbczk98bkrZEkkKAm3uRsNswye8drTnXDlUhsCZZEwV6WgLBZkBXhH/ZntTo9/NSJ6YKMFb04klOUco0Ba+NQ3DH5LPRr+1TtfpnxUAIAxaD2/OVIbrK+NkA+RggkmqhSy8Y5ed4I6qVx+EjsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714505580; c=relaxed/simple;
	bh=ZQ1oMUBTwxcdIs4FlFp86Z2Y3cV91YhkLRluiKVg8/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYTfIdNyu35VX/UFxHEsD4K5gY2HdBUghvBgu9a1MvKUekNbb6qBU3F430GPa4BLd9z3mmqxhzU5WmDw2aCaAYXyKxWBwRipXY6BUP/EOPIvyB2+GjEDNPjKhY2sLkWUzOf8v+rftYpCY7ZA/JmFgu2YMVQFBfyq1Vf/ZiG5h5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l/aQPeGJ; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l/aQPeGJ"
Date: Wed, 1 May 2024 03:32:50 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714505575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fQjnNv6XDcUqIkBYRrAmMHtnhjRpNuJYdDVXg1pXxdg=;
	b=l/aQPeGJ21VVxyJLdBYErtmi9log3P/u+1nn9OCBSg7onyHC1CQbnuOYbk82K2dAWzIZVB
	4ZBXDToyIryxI4q1Q+u5J0jfDXsXhaqfabFnJKvNn/Yxhv/Hm3y74ozs1DozJmNA1SJS+1
	bXnPe3yiqST037rznLlii2/LUpooTRI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: James Clark <james.clark@arm.com>
Cc: Ian Rogers <irogers@google.com>,
	"?????? (Baisheng Gao)" <baisheng.gao@unisoc.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"???? (Hao_hao Wang)" <Hao_hao.Wang@unisoc.com>
Subject: Re: Question about using the perf c2c in UMA system
Message-ID: <20240430193250.GC125@debian-dev>
References: <80f723d230744bc299044cfd4f8c4d92@shmbx06.spreadtrum.com>
 <20240429214321.GB125@debian-dev>
 <CAP-5=fUdVHu6a8TLi_HYOZv3Ur_Sr4nvx92rkSaxxKJummPzKw@mail.gmail.com>
 <40bd4bb1-a2fa-4173-aea8-8ccd3ca23df3@arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40bd4bb1-a2fa-4173-aea8-8ccd3ca23df3@arm.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 30, 2024 at 03:36:02PM +0100, James Clark wrote:

[...]

> >> On Mon, Apr 08, 2024 at 10:52:59AM +0000, ?????? (Baisheng Gao) wrote:
> >>> Hi linux-perf-users,
> >>>
> >>> My perf tool version is 6.6, and I compiled it to run on an Android system.
> >>> The problem is:
> >>>
> >>> # ./perf c2c report
> >>> Failed setup nodes
> >>>
> >>> According to the articles on the Internet, it seems that the perf c2c is only supported
> >>> in NUMA system. However, the cache false sharing does not exist only in NUMA, and
> >>> the UMA system has also the problem. So I wonder how to support perf c2c in UMA.
> >>
> >> The log above is related with parsing NUMA nodes, but this doesn't
> >> mean 'perf c2c' must run on NUMA system. My understanding is both
> >> x86_64 (memory event) and Arm64 (SPE) support 'perf c2c' not only on
> >> NUMA.
> > 
> > The lack of SPE on most ARM hardware really is a pain. Can we add a
> > better error message to make it clearer to users that they need a
> > neoverse CPU? :-)

We cannot stick to Arm Neoverse CPUs as Arm SPE is supported on more CPU
variants. On the other hand, I think we need to dynamically detect CPU
feature for SPE to replace current code for binding specific CPU
variants.

> This issue seems to be about report rather than record, so I'm assuming
> that the record worked and SPE is present.

Yes, this issue is for the report command.

@Baisheng, do you mind to share the steps for reproduce this issue or
drop the perf data file with me? Sorry if I missed your sharing.

> Having said that, the error message for no SPE isn't great, but it's not
> that bad either:
> 
>   $ perf c2c record
>   failed: no PMU supports the memory events

This is better than nothing ;-) I will check a bit for a better log.

Thanks,
Leo
