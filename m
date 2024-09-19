Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F87EF9CB;
	Thu, 19 Sep 2024 01:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726709387; cv=none; b=NYkyz+cPPMcVSeBoOzg+QOaiQMMwdv5PIxoJpBt98v/NcLB210yszZ785OTQFihKHlnuNRAmLyFMLo5B3LAWewS07esTHIfd/avuIhObt2wFTveYRVq3FSEzudACymnKzyxwFG6Jyn/HlIsUIj6bhzat9ULbf9SX7lQjnwA67h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726709387; c=relaxed/simple;
	bh=No17i7pIxA9JTVP8LxQMt5chUyRmaEBBA0H5upGzXOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lw4j0ctuoyXHOBGF3mjkHXVe9Q0F7Byrs8QM4TDfv9SiIAoPYbu8yu0Unt6FZ12Bdaco6Wi7nb57wU2Sv+476Do3joanhC7Z8gYDwJGXIdnSSG9woHlkLLJ0WRd05zH3n4mFtyHk6z/Tc7XhcGw6TeDrsQ/QyQGewTnCnYeDEl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JliZ4piX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JliZ4piX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726709386; x=1758245386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=No17i7pIxA9JTVP8LxQMt5chUyRmaEBBA0H5upGzXOY=;
  b=JliZ4piXbKq0e9/t49PZHPde1C6pSm8PkZSZ80jU/A+tjxJhJIC4iSeS
   Ryq5l9JmC+4hXPASAM1mU2R5GHlG2e+/0r3dN5RBZh8EFQMZ+pAGx8ov/
   mFGPn2hAUPguphD77oEWAgGTQF9gIvMRXawLoBD+ddUbDdkVVpQvzxOVD
   KIF3xqBZzdisL8hb/JSZ/TQ/HgfYZJBtSTfv/kbHjs051HHt1LzBTPwcR
   5W5vpDqvv/CqW4t9aTO9ikJfztYORUthGVR3l0HBilcP4Mv2cTSUJvubn
   jOOjqTpfGrHaHfMP0tE2MTyp0zUxUDQOXXLMJDiE9FpO48JYb9/3zc9jq
   A==;
X-CSE-ConnectionGUID: Hze0Rl0xSYyoxoUXuSXq8A==
X-CSE-MsgGUID: ZEvuX1aKQbOzyMiyU9xiwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11199"; a="25476676"
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="25476676"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 18:29:45 -0700
X-CSE-ConnectionGUID: vCdy1wC0SyCAPd4Xhi+sKA==
X-CSE-MsgGUID: B8DIPn3aS6KXhJaK+oGu2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,240,1719903600"; 
   d="scan'208";a="70597582"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 18:29:46 -0700
Date: Wed, 18 Sep 2024 18:29:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
Message-ID: <Zut-iM3v9rJHehxJ@tassilo>
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918225418.166717-2-irogers@google.com>

On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> Python2 was deprecated 4 years ago, remove support and workarounds.

Nacked-by: Andi Kleen

I don't see any advantages of breaking perfectly fine existing setups
for no benefits.

-Andi
