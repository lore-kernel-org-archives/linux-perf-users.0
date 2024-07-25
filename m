Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC9913A40F
	for <linux-perf-users@vger.kernel.org>; Thu, 25 Jul 2024 22:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721947808; cv=none; b=FtA5jR41BDC+uFgC4RCkjPZmwUZygF5LBO1xpQr7lhm64T1TAUSEOGBozzNqbyD+0rmoqGhONgwmadFCxekdJzzW1SnFPGa/WYlJWf640g3LwVRU0KmkbjV3n98qI+VzdL2pfcTqzoO+GrH516MXFvO6298GU4zIagowZcDWtzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721947808; c=relaxed/simple;
	bh=HzeaarMUh2qZhxt5+X6gzUM3VKmveKlU3eOm/U5mA3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXfaSYzrI56kz5+1dUCuZoZ6fTO42jqpwvLRZoPDQEZtLIayqewwD5i2RuqODUKvMMDg9GX8YNJN4V+48Afsp/OmcZIeD3l39EtRfNnEocy4abD2SP39j0qicYbjVGAq5VgzmQvF2PI1KZdW+Q+alfF3UisRyrcrAUXbYCP5tyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FETRb7Gg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FETRb7Gg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721947806; x=1753483806;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HzeaarMUh2qZhxt5+X6gzUM3VKmveKlU3eOm/U5mA3w=;
  b=FETRb7GgdYMEnBh/hrZbfle3O/u2Xfh+iy4ZxCQc6Ah3lzDknYNN2ohi
   kxa0b5SiU27tVsFBgir7bQKUtK0tHP4udLNxhaHlNIhBjPFm56LeNG+pz
   NZn7M2HvRrm/u/BTv8KECxRsNlRdr3uOZInwZ2N4lNekTh5+KzEO4YkFm
   0QFkjU1IGUVA0xzjINwAlOowaZsQiGL0g7bBT6G8GBiZAWIymIoR24L0l
   9dUQj1WsLeJgWOJ+GZJ4ve9VNgInjvYPvFSvW549gRULqLDnpzQbkuRVm
   k0pWDqPT22EtjgSUaBi+/8SqGrINGzYhmcsdNK+rofvyIYj2scGUxTqNN
   A==;
X-CSE-ConnectionGUID: yRbsU1e1TlyRMTD+DGEH/g==
X-CSE-MsgGUID: UKOdUrJQTd+MvrK/f9jwvQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11144"; a="30340758"
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="30340758"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:50:06 -0700
X-CSE-ConnectionGUID: lEEySGVSQ+edCD2QAL0qQQ==
X-CSE-MsgGUID: h7FtzpyGSf23FkYEMoGaPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,237,1716274800"; 
   d="scan'208";a="57649236"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2024 15:50:06 -0700
Date: Thu, 25 Jul 2024 15:50:04 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Create source symlink in perf object dir
Message-ID: <ZqLWnO8bj2SVGv3f@tassilo>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>
 <ZqF2xhZuchmnq3Bc@tassilo>
 <CAP-5=fXh4P64Un9CMnoA-RrYGg9LNUw+zwkY9qAYyJdKa9WTEw@mail.gmail.com>
 <ZqH-lAF_ztetHZIH@tassilo>
 <CAP-5=fW7n3Zn_-FZBcorvAg1cgk+rPb700uV=0r+QUyoeH4sSg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fW7n3Zn_-FZBcorvAg1cgk+rPb700uV=0r+QUyoeH4sSg@mail.gmail.com>

On Thu, Jul 25, 2024 at 02:18:15AM -0700, Ian Rogers wrote:
> On Thu, Jul 25, 2024 at 12:28 AM Andi Kleen <ak@linux.intel.com> wrote:
> >
> > > > On some reflection your changes went into the wrong direction
> > > > because it ignored the (useful) single group property. Aggregation
> > > > on time really needs to be in perf report not here.
> > >
> > > Still don't understand this. You are sampling, that's why you use the
> > > period, how can both samples happen at the same time? Why can't
> >
> > It's leader sampling ({}:S) , so only one event samples and the others
> > in the group get collected/reset at the time the sample happens.
> > So all the events in the group measure the same time interval.
> 
> No, here is your test:
> 
> +       perf record -e '{cycles,instructions}' -o "${perfdatafile}"
> perf test -w noploop
> +       perf script -i "${perfdatafile}" -F +metric  > $scriptoutput

True. I don't think it affects the test functionality in this case, but it should
be using :S.

> 
> notice that you aren't using :S. You are grouping the events which has
> no meaning other than for multiplexing, which for 2 events you won't

Any use of {} means they are in the same group, so always contiguous in the
perf.data as the script metric code expects.

-Andi
