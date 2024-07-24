Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D46D13A41D
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jul 2024 21:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721857747; cv=none; b=EdL+HXZmXLqRplputh+89wui1kBfwyPorR+maRCHVmQQCUQPkQAnAPdaU4UkyCqXIG4atknG0ABm4dyl7KZnBe4UbKA7RhDm3GVeD8FUG5QK5fQfFUK9L7t3QhHIb1R0s77tSKRYlFFlnJwguJ9LQzH8epwzORlqWzOKyfTyxXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721857747; c=relaxed/simple;
	bh=K8raDULlON0xJPj90x3zuK5PJfemO3JvtEB0RF2X2ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JsJI2gkd5G15hq1JoqHLGbOx6MN6NTfCijMYSlX5v6WMDftU2X7NhGCEyGdWQLYKzSV51GO5YcJDigsrqqhNQrnL6T6rjQu149RUTCm/DrOJMjyZu57RAyMyYbX1Wu9hOiq+cEBLW2DX7GDp6aV0yeYYOdYMBkb7GRvmXwIspKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zn2fFhnj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zn2fFhnj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721857746; x=1753393746;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K8raDULlON0xJPj90x3zuK5PJfemO3JvtEB0RF2X2ik=;
  b=Zn2fFhnjFfjLCCGAzs3LP8S/rjUKHai0Sl1YjSEEOcIooWkNHqi6m8ql
   rbxsA/pzsVdlRxLH8nAOJcKWwUBBfAmGGmAeimG42NnXF6l3eX0Jb86+I
   MfIf6X49Bt364RlxUnEAVH3TPSB7wBuqxZmcsNcQLF6pRyCMEbs68I19P
   34k542pmKIJQGfj9Ii7IQJ+x2jb+gENsBIqGruK0Ei1ehvEHPuuaA4B2C
   nJmjII3WPunnAZUAkRdczytDAyEPzSc1EI98YBm+KUCGJDzH+y9FJsC9C
   6jHIEPkH3daL8roS2rA58kXxA2B7JocbXvIJlUXQKMMOElSA9Bp+dbO7T
   A==;
X-CSE-ConnectionGUID: +gAFqNnyT3G0uUQWxjfrYQ==
X-CSE-MsgGUID: dxLPGg9LRiSvvicW4baFiA==
X-IronPort-AV: E=McAfee;i="6700,10204,11143"; a="30983757"
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="30983757"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:48:56 -0700
X-CSE-ConnectionGUID: Cvt5QuYUSva4dO36AqOJSg==
X-CSE-MsgGUID: /adFRkwvQlCHoT70EALUMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,233,1716274800"; 
   d="scan'208";a="52394752"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2024 14:48:56 -0700
Date: Wed, 24 Jul 2024 14:48:54 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v7 1/4] Create source symlink in perf object dir
Message-ID: <ZqF2xhZuchmnq3Bc@tassilo>
References: <20240724190137.3810429-1-ak@linux.intel.com>
 <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fU+ADbxVwPzEof2FmZ6NKgyVB2cfTvQWqx3jrTpO9P7nA@mail.gmail.com>

> For patch 3/4 the aggregation logic doesn't look to work well with the
> patches I sent:
> https://lore.kernel.org/lkml/20240720074552.1915993-1-irogers@google.com/
> I'm not a fan of it, but I don't really understand the aggregation
> metric logic here - periods of different samples from potentially

It's a single contiguous group, so it is by definition only from one CPU.

> different CPUs being combined as if they are counts, zeroing of the
> counts.. I'm not going to rebase my changes on these, and if later

On some reflection your changes went into the wrong direction
because it ignored the (useful) single group property. Aggregation
on time really needs to be in perf report not here.

> code removes the hard coded metrics for json metrics then this code
> will break at which point it is reasonable I think to disable the
> test.

I don't think it's up to you to unilaterally deprecate features.

But that's a good point, the json metrics got broken too :-( It worked
in the original version. You really were a wrecking ball here with
all these regressions on stuff you don't use, Ian.

I guess that needs to be fixed too, but that can be a separate patch.

-Andi

