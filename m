Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF4469D
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730724753; cv=none; b=hEIxZ7tQ1SsOzRsBuhptQUIfXDwcorDhRa1mWwmF1QoPXDi1AVFTm2CffBm5UdsWu59x4GIE69KsM83SA0AR9s7xTovgR6NaFnNxxssGwoBZod+st4r2iu87nGg7uuRNZV1+ApBGB7qWLNvVsatRMkMJiyTaAfu0mindu2cyhoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730724753; c=relaxed/simple;
	bh=/X5qMQl+b+7ZDZnqY3Oj1147GF2XAn0lYxetlt0KjIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpNJaVZNqPtxchOrWj9KTsgYprkzZT9HElJp2soZJcQX4jms+q9oF0h2YWYk2++HZK6QvC83cvipnl1oFtqXEIn9+4RVZlE8iZNcmEZT4807pXv0jrr1VSIt+HQj/+XnqXME9KN4fh2CEllWu/sUSqmZmYFCxkqJlLZvzolK8go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Date: Mon, 4 Nov 2024 13:51:54 +0100
From: Guilherme Amadio <amadio@gentoo.org>
To: Leo Yan <leo.yan@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>, Yicong Yang <yangyicong@huawei.com>,
	yangyicong@hisilicon.com, acme@kernel.org, peterz@infradead.org,
	mingo@redhat.com, linux-perf-users@vger.kernel.org,
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
	jolsa@kernel.org, irogers@google.com, linuxarm@huawei.com
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
Message-ID: <ZyjDatxYxoIg0R5J@gentoo.org>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
 <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
 <20241030110458.GD24446@e132581.arm.com>
 <ZyXFX-8SnakeuZrl@google.com>
 <20241104104741.GA14610@e132581.arm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104104741.GA14610@e132581.arm.com>

Hi Namhyung,

On Mon, Nov 04, 2024 at 10:47:41AM +0000, Leo Yan wrote:
> On Fri, Nov 01, 2024 at 11:23:27PM -0700, Namhyung Kim wrote:
> 
> [...]
> 
> > > > Checked how we handle with libtracefs currently:
> > > >  ifeq ($(feature-libtracefs), 1)
> > > >     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
> > > >     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
> > >
> > > The libtracefs.pc file claims requesting libtraceevent, as a result, it
> > > returns the header paths for both libtraceevent and libtracefs:
> > >
> > >   $ pkg-config --cflags libtracefs
> > >   -I/usr/local/include/tracefs -I/usr/local/include/traceevent
> > >
> > > I checked the packages libtraceevent-dev and libtracefs-dev and either
> > > can be installed independently. Therefore, it seems to me that this
> > > patch is correct for finding the traceevent header path, with no
> > > dependency on tracefs.
> > 
> > I'm ok with the patch itself.  Can I get your Acked-by, Leo?
> 
> Yes.
> 
> Reviewed-by: Leo Yan <leo.yan@arm.com>

I agree that this was a mistake I made in my patch. I added the cflags
to the feature check in tools/build/Makefile.feature, but in Makefile.config
I added it only for libtracefs and missed it for libtraceevent. The fixes tag
is correct. This patch fixes my mistake.

Reviewed-by: Guilherme Amadio <amadio@gentoo.org>

Best regards,
-Guilherme

