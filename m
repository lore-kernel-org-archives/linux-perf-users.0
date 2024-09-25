Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F603D55D;
	Wed, 25 Sep 2024 13:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727270283; cv=none; b=JqMTnigPdlJw8Wr+v8a0PyuQib4cYVJLVweGU5a8oyvWaw02/RfO5FvN+KY40yQufUSgnva2Ij3i1pEnwVQMDQp23XJ5YOOx52kf6YFMgGUvx1K9a1PZ/wlNDTt0dvnt7zRC4ebiv7rp1o1H3C4GAdVINNPUhxTxTKTFKcvnBXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727270283; c=relaxed/simple;
	bh=l+FqVhW5+s0/xeUp3xEocj0sK23twX8gotI6OY452/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/ATRArxrO5gWzrdnfxVJli6ZEc8FhCIZ0OGSVbITIM44+ZChOET5pP63lynFZBZ7KNd0pCO1Vr9YJp/Br8ShZFk05sy8ZPVbjVYhqwX7hIdFLDXplT2vend3NNH0XIQr92ttWznxSODmwQwXxQqwyzEjsXH8uTbZeFab+n1Nec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A1wlngNn; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A1wlngNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727270282; x=1758806282;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+FqVhW5+s0/xeUp3xEocj0sK23twX8gotI6OY452/s=;
  b=A1wlngNnYDM07D3Mkzzw2pPFwCfMu9NeoYy7LXYJAodYhaVVfuTcYTiW
   K9F2IbIKcauKpQMp6FsGVdyfZBLveY8IN4UIcuLcHaDFwRPzE8TCUWL3B
   3lbOMy4UbafMNSPmo/ieLEXaAFQwJ9y5VqUeaLqgdvdf0xfQSvSCJh5tP
   T3vNKJ8uSIux6PSxYDTxf4DKWbz5yL4zVdcnlpPIQBslcLWQzqPplf0fZ
   SUnhOyYOhOwfGeAATsMq1cm/KS1OUYYw8xR5jzQ9mUp7zvBzBfDnnFWSl
   7e8LHCBR2UYGGG8jVgprU2wz3Utx7sn/TSlN1k7AmhnImZoIF9CpqtPfA
   w==;
X-CSE-ConnectionGUID: 8O+pCjBDQpyCoeUU6k+8vg==
X-CSE-MsgGUID: 0wkrFWBJTHGmAouy4Xp6Vg==
X-IronPort-AV: E=McAfee;i="6700,10204,11206"; a="26457484"
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="26457484"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:18:01 -0700
X-CSE-ConnectionGUID: nxyKvAZiRyyWGNd/UQM1IA==
X-CSE-MsgGUID: HbCZ6ISmTVu+ClNTOceiRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,257,1719903600"; 
   d="scan'208";a="71364347"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 06:18:01 -0700
Date: Wed, 25 Sep 2024 06:17:59 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Yeo Reum Yun <YeoReum.Yun@arm.com>
Cc: "peterz@infradead.org" <peterz@infradead.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"namhyung@kernel.org" <namhyung@kernel.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"irogers@google.com" <irogers@google.com>,
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"howardchu95@gmail.com" <howardchu95@gmail.com>, nd <nd@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/2] perf stat: Close cork_fd when
 create_perf_stat_counter() failed
Message-ID: <ZvQNh36COIpoOptw@tassilo>
References: <20240925110802.2620613-1-yeoreum.yun@arm.com>
 <20240925110802.2620613-2-yeoreum.yun@arm.com>
 <87msjw2al8.fsf@linux.intel.com>
 <GV1PR08MB10521644365A907A4301AABE9FB692@GV1PR08MB10521.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <GV1PR08MB10521644365A907A4301AABE9FB692@GV1PR08MB10521.eurprd08.prod.outlook.com>

On Wed, Sep 25, 2024 at 12:40:44PM +0000, Yeo Reum Yun wrote:
> Hi Andi,
> 
> > Technically 0 is a valid file descriptor. Check for >= 0
> 
> Right. However, when I see the event, evlist__start_workload(),
> it checks cork_fd with
> 
>     if (evlist->workload.cork_fd > 0) {
> 
> Would you like to change this with this patchset too?

Yes please.

-Andi
