Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C6B23B1
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 00:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721781416; cv=none; b=ipCptol0YKv3cy/LyaeK9ZSaNHSc165e3edr7RHcB0i6KkNA4yqx+APdZj6fNW3TgAyb5VeTwPHL3gcO97xgAzWoOOPl8puU/LDSSbhuHLW+ExlsLZ+uj7RpdvRoONrp7A2lp5O/SVh+lHBKKnAQSvxv5T593ULXMUVsygFa6sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721781416; c=relaxed/simple;
	bh=gtfHQ2OuCWRE0Ft2tAM8Kv9/vbKVJ6lObTRhiDwnb50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWzlQqBlg5HfLsfSzSIyE4SOGOZpocdvISKMie61BBRjE/FUpNCbStnNkh02YBnZbYho29YB+HtBepTF3RzOWK/n8AZhl56mWYY8sn/tL4hDKN4yH4J6+V+yqs6kF68K/UfEpU3rn9A0CFz2rf77vUsGA7q9uxuU2IOWo1dJeUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/N8csE0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/N8csE0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721781415; x=1753317415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gtfHQ2OuCWRE0Ft2tAM8Kv9/vbKVJ6lObTRhiDwnb50=;
  b=a/N8csE0+5pgYZaGxfXA3+OEhYqHeVu82APmV8Hqs5uKiXDa+zxUPkYd
   10Am5nqM8XOZxYw+fyGZnYOXzU/2qhkKvd/YtqGTyjBH9hJKZE4bl1u7L
   2sl/b9t/ssWXvVz156DdGnPRPFzAlMBVZ5s3eXw5FHP8duCNOp2/Zuzds
   vn1VotZgF7F5ZDK4klkgG/WZZcbzXgZm5ibf4qRya1bC/CtI8UKoBOQeR
   zu31DUHQDKFIKAWCQru3YrC1HguVKnuVR3Z7F5UH3woA0a7BFC1n92152
   VDnDEbF+iie4BMqyF+M+Rxx08A4SK4bhWr+kj+anfHTHdGcQGZMzLkYoA
   A==;
X-CSE-ConnectionGUID: sXJybJ5oQKKW64H/p1t21Q==
X-CSE-MsgGUID: xfipzPI8Rr6jsFZeCuXYbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11142"; a="19241687"
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="19241687"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 17:36:54 -0700
X-CSE-ConnectionGUID: uLfXo/WMRwyV4FEuPY2iCg==
X-CSE-MsgGUID: n+iqyEGETzanq1OXmjNDXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,232,1716274800"; 
   d="scan'208";a="75627094"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2024 17:36:54 -0700
Date: Tue, 23 Jul 2024 17:36:52 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v6 3/4] perf script: Fix perf script -F +metric
Message-ID: <ZqBMpElyYfjyf8xq@tassilo>
References: <20240723204834.3617647-1-ak@linux.intel.com>
 <20240723204834.3617647-3-ak@linux.intel.com>
 <CAP-5=fU8=gTatcHkvN8jv72_dJvaAb3FE+pnWB2LSN=SM0dRxw@mail.gmail.com>
 <ZqA88FMUcDFwrobi@tassilo>
 <CAP-5=fUrw3W-v53zi4xo9NVh=-fjXrNr3FC=KQFWj1E+ckZN9A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fUrw3W-v53zi4xo9NVh=-fjXrNr3FC=KQFWj1E+ckZN9A@mail.gmail.com>

> The main reason would be so that perf_stat_process_counter could work
> and update the aggregation accordingly. Then you can dump out the
> aggregation, be it per CPU, per core, per socket, per cache-level,
> etc. as appropriate. 

But there's is none. It's only for a short time on a single CPU.

> If you follow the perf stat convention you are
> also much less likely to be broken in the future, as perf stat would
> also get broken. It is complicated spaghetti to work out how this
> stuff works, but that's why I fixed in the patch I sent out.

Hopefully the regression tests will prevent future breakage.

> Or let it set the aggregation mode and just let the aggregation code
> handle it when computing metrics? I think getting the STAT events
> isn't typical, so this is an academic argument.

I don't see why users shouldn't use perf stat record. It makes
sense for any large scale count collections. And it's tested by
the test suite at least.

-Andi
