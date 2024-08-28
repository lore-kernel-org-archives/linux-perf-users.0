Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE6D768FC;
	Wed, 28 Aug 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724864541; cv=none; b=faay4redMBYhtYSCIzQFBgvfXyJhk7Wm0sOGtGDZvtS3AkQxRdpJtcsEU1FXLsfPVwvILGVTYHYK4vgiVP4A+o9UyfOChV6n/nOLEAdH4gVsvmu3wq0WtSBtf01xLGFURCod0BUerjBNUx1xgoxUbPn2gm3OXRcj8vQBwVw3/ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724864541; c=relaxed/simple;
	bh=d9jrs1TkJucUTZDoVN8NpJX7fWNl5Stq9MMeZWjHGJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXHpFw0+S+IjY+TRQHQElVeTGunvkxjIySGQcdIFGrLJNIhO+hruubpEKGPV2FTLF9NpfJvcji5TXywWuDNRdvABZq5mZU1TDnS50TIX0E8Pf2Y2UW/cRWziwWzlsC0e5bl591Y0sHzQiQTwkFUx4RMFcRcEihmdECylDZtMhFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ggQwAVgK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ggQwAVgK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724864540; x=1756400540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d9jrs1TkJucUTZDoVN8NpJX7fWNl5Stq9MMeZWjHGJI=;
  b=ggQwAVgKaQ6kwrLOzATZlsyQsDU9OAcPQhf9MF1H7cUsszx7f6PxTGiM
   G7KDQC1zm/0RWs0XR08OUYrR9AjgB+hHoMrMk4gAu0b59Srkp5I36ZU7s
   XibEZLbqzP7JST028D6DJMJQXD0fPkdZFxOhpU/eD5NGuaGZ1r6QSP8TT
   WPvl1lMZxHe8Bp3CD4AfJE0V5Wi8M/zIgw57ATxENRdiZ1xoimQ3hnPjL
   jhQrdm8GROi6TTlQxi/IxOoGE8f6bNN3Yzb0j5wFibsGrDCjdjG6Namdx
   lxy8aVrETb7dG3Y7cWxrjhqQU6nOrzyk7vE30I1WOj9RQhjuciOR5Gdz6
   g==;
X-CSE-ConnectionGUID: 84a666ADT5GXId7JEc31Hw==
X-CSE-MsgGUID: +7QfYd4tQm6dCIwB9vJkkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23218129"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23218129"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 10:02:19 -0700
X-CSE-ConnectionGUID: 9zj+glU8SrGQjSR1jwnwiQ==
X-CSE-MsgGUID: 8Mpa8hCYRYyg8emb2Azf/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="62925332"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 10:02:17 -0700
Date: Wed, 28 Aug 2024 10:02:16 -0700
From: Andi Kleen <ak@linux.intel.com>
To: James Clark <james.clark@linaro.org>
Cc: irogers@google.com, linux-perf-users@vger.kernel.org,
	kan.liang@linux.intel.com, John Garry <john.g.garry@oracle.com>,
	Will Deacon <will@kernel.org>, Mike Leach <mike.leach@linaro.org>,
	Leo Yan <leo.yan@linux.dev>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Yang Jihong <yangjihong@bytedance.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Ze Gao <zegao2021@gmail.com>, Yunseong Kim <yskelg@gmail.com>,
	Sun Haiyong <sunhaiyong@loongson.cn>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Yicong Yang <yangyicong@hisilicon.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/7] Event parsing fixes
Message-ID: <Zs9YGP4d0_QanpoA@tassilo>
References: <20240828140736.156703-1-james.clark@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828140736.156703-1-james.clark@linaro.org>

On Wed, Aug 28, 2024 at 03:07:14PM +0100, James Clark wrote:
> I rebased this one and made some other fixes so that I could test it,
> so I thought I'd repost it here in case it's helpful. I also added a
> new test.
> 
> But for the testing it all looks ok.
> 
> There is one small difference where it now hides _all_ <not supported>
> events, when previously it would only hide some selected subset of
> events like "stalled-cycles-frontend". I think this is now more
> consistent across platforms because, for example, Apple M only has
> cycles and instructions, and the rest of the default events would
> always show as <not supported> there.

I'm not a big fan of hiding all of <unsupported>, when they are explicitly 
specified on the command line they should be absolutely shown.

I do have tools that specify events on the command line and expect
the same order/events in the output. This might well cause breakage.

-Andi
