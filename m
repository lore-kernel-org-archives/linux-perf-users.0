Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3701D18890E
	for <linux-perf-users@vger.kernel.org>; Thu, 12 Sep 2024 14:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726151909; cv=none; b=BCOcB029KXDHRrXq2liAHot3UCze7NuJgN5ttd/P+JFUfvEjU4Yx7EwDZ8ZTP3SxI0Pqv73zuMxnLXOoYL5jgMtSFVsIJBosFxQVdS3WGDzI3yFPvye5XO6etBFweuhr1GGeLtRWBURAHhkS0Jy9EEfhBGNhth1sbmNcSSsERmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726151909; c=relaxed/simple;
	bh=4oOOY3YK0urQv04VanAjjpzoPGa/0G46xeM+TJ2AvoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lom2Y0hRE96HyeYKIUsoHoXZl1e2fuMyZQS/Ueulf41bT4bhpZ0aaZDXsuQKhQG2ftZL0AcjrlBgeoapFKC6hjxRnDtllmGigy4ekCNHcM4wcGgYv5DfIr+aP9ICMpcxpqSLIUS2WKSnDKO5m4TbWIl1xh8HvVJM4CVvx84qDJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lu0UPDU4; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lu0UPDU4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726151908; x=1757687908;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4oOOY3YK0urQv04VanAjjpzoPGa/0G46xeM+TJ2AvoY=;
  b=Lu0UPDU4Lhfh+5qYm/U2YzX+irYll3/kbXoYEq88r86SOZ0bLLKSILTX
   X/vf5W2XtCBc6eeCJDqZmVG1ShfGTVA/m2N0H0C/4RThvIyK3B1j047hz
   NJM/5TURu6uIIio/8wnLPZ4+KcDIl2sh6OpsSuFXazWAqICk07AubRapY
   L9KZEZ8rAphZm/o1k9+ZPUnTVyXZ1oXDob7Twmk0bpUwOV/2pZlgB2ugb
   LY/t/eQOGZBmTiabqZq5GPVbDU3UmW8tZuVEmFcNkWBQgTWzJwIyN+HY9
   ZjEaYD8Sj/TmoYv8Z5jX69qSmpkLvDEGkltRKekFYA5vTTlPIzeUXe72x
   w==;
X-CSE-ConnectionGUID: UfO3kPenTNe+f4mgJ5dcTw==
X-CSE-MsgGUID: PFq7o7I6QSWNipDqmavc6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24831685"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24831685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:38:23 -0700
X-CSE-ConnectionGUID: EWWfbTp1Tf+Gi4Gt3VkIYg==
X-CSE-MsgGUID: i5/BzXoaQ9qI4Ro7M3rZEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="105173555"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 07:38:23 -0700
Date: Thu, 12 Sep 2024 07:38:21 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, adrian.hunter@intel.com,
	namhyung@kernel.org
Subject: Re: [PATCH v1 01/10] perf: Avoid buffer overflow in python register
 interface
Message-ID: <ZuL83U3PsOl44bvJ@tassilo>
References: <20240905015300.2124798-1-ak@linux.intel.com>
 <20240905015300.2124798-2-ak@linux.intel.com>
 <ZuLhk6yGrr2HET6d@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuLhk6yGrr2HET6d@x1>

On Thu, Sep 12, 2024 at 09:41:55AM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Sep 04, 2024 at 06:50:09PM -0700, Andi Kleen wrote:
> > Running a script that processes PEBS records gives buffer overflows
> > in valgrind. The problem is that the allocation of the register
> > string doesn't include the terminating 0 byte. Fix this. I also replaced
> > the very magic "28" with a more reasonable larger buffer that should
> > fit all registers. There's no need to conserve memory here.
> 
> I applied this one already.
> 
> But you used the wrong list address, perf-tools-users@vger, I'm fixing
> this up now to linux-perf-users@vger so that the message reaches the
> mailing list.
> 
> I waited a bit for reviewers but then realized the problem with the list
> address when trying to use b4 to fetch it from lore :-\

I sent it twice. The second version had the right address.

But you were in cc and got both versions, sorry.

-Andi
