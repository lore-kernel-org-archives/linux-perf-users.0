Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CAF13049E
	for <linux-perf-users@vger.kernel.org>; Mon,  4 Nov 2024 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717265; cv=none; b=t8lwOz6zC+abN9Rb48t6no7jOYvln6Jpf2yN2CbBqkW57Ip5ZAm3PozNHtRZzcSRyD+NuXHKBgVE01E6Nro4SzCdsX2nrIHAEDVsA+CBUT62keeqwMhUO2GYnmKZOeQQEXwTe+0hd+Tv2hImvWB7rFxvBRXbjUQalVY5M0Li3lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717265; c=relaxed/simple;
	bh=sTly4Xc9qOsAuE7K2i+dDte2HmBHd+l/rda/36lD1tI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SefNFdWx00pG4rdY4RT+mX5WzPFXnF2Hp50mr/mD3pxrpXBmYfywZb+ff8BlhpCY75JXUHNqYgOA3LvwoMg4V6QkKKdKNa2XTYBUqQt7j8Jqwv8R0DWnJ2Tiexa/HFk5PrziPsULZ+Jd2qj1ivf1xHNsCtD9eUiDjkj4o7hbQAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12D4FFEC;
	Mon,  4 Nov 2024 02:48:13 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DE4283F66E;
	Mon,  4 Nov 2024 02:47:42 -0800 (PST)
Date: Mon, 4 Nov 2024 10:47:41 +0000
From: Leo Yan <leo.yan@arm.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
	acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
	linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, amadio@gentoo.org, linuxarm@huawei.com
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
Message-ID: <20241104104741.GA14610@e132581.arm.com>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
 <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
 <20241030110458.GD24446@e132581.arm.com>
 <ZyXFX-8SnakeuZrl@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZyXFX-8SnakeuZrl@google.com>

On Fri, Nov 01, 2024 at 11:23:27PM -0700, Namhyung Kim wrote:

[...]

> > > Checked how we handle with libtracefs currently:
> > >  ifeq ($(feature-libtracefs), 1)
> > >     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
> > >     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
> >
> > The libtracefs.pc file claims requesting libtraceevent, as a result, it
> > returns the header paths for both libtraceevent and libtracefs:
> >
> >   $ pkg-config --cflags libtracefs
> >   -I/usr/local/include/tracefs -I/usr/local/include/traceevent
> >
> > I checked the packages libtraceevent-dev and libtracefs-dev and either
> > can be installed independently. Therefore, it seems to me that this
> > patch is correct for finding the traceevent header path, with no
> > dependency on tracefs.
> 
> I'm ok with the patch itself.  Can I get your Acked-by, Leo?

Yes.

Reviewed-by: Leo Yan <leo.yan@arm.com>
