Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210319AD4F;
	Tue,  1 Oct 2024 11:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727781773; cv=none; b=fu88VLxU4aGXpxuxq3aPSbmVJU29mzzxb0Z8n+6qJ8zH+Ibl6/lcYmYaHw3vU7B5Kwf2vxmZl3PfNJooOASqhFmEvhfhsml2tMWfaeGZNpJ0v6/WhTq/5mKtisnCBYR8xTkhnxbQFKRsJsOQnAGLb+8FUt19I4nNEFtpYG0puEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727781773; c=relaxed/simple;
	bh=kKlCtttj5grsNN/Jx7uzaIm+cydJ5OKLDY1FBn4CgAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6BSMP/L055cJzKpHvyRtVSfyRa55mM3OLerDyfu3yIJWvg6gOC5ENjcZhvDbXVFH/QCQ3M97cWaqhzQYngCLAyvNCbVgweskZkrSTRNkXeKq312bhbVSrwN3IGagkTezCCS8IEpK5sBbYsgzDz2DOfTabs1N4vF9TJ3WZEMdzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hyat6lsj; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hyat6lsj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727781772; x=1759317772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=kKlCtttj5grsNN/Jx7uzaIm+cydJ5OKLDY1FBn4CgAY=;
  b=hyat6lsjearHMqRrSMPMiBdGofZAEUDKLgqvS21eGQI3ctW1i4zoXXWQ
   drOsun3ewCR9tLX2MSIAphQyuU9X55hvYTUDOhMayxRl71ly3FvZPvy8m
   3prkckSGUWYhsKRP9e1H9vixbWbHIIzb0Cj7YfeSDkas2rIVIi8BqqAxK
   ewzE7PGDd9Y5f2n8gv1Bu9SsqhYf3/QYfMkIxyDL7batqwvTbGXl/CRG+
   huRSuLxm2ZgT+l50c5oqDc+nOue9dG3qwKycSO1nxsOo6w1897JRB+UUv
   7KZNeTFZyT4KFasvHKmfJ8rHABAbNiKWWLAipr/f8AiwihLg+W3XbpDN/
   Q==;
X-CSE-ConnectionGUID: vIyBsJRzS+6Jy8PoDa61Cw==
X-CSE-MsgGUID: FMkSgo48QiiiMBycA44jMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="37587615"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="37587615"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 04:22:51 -0700
X-CSE-ConnectionGUID: db95yWcdQ2OBoyHxKztBkw==
X-CSE-MsgGUID: 8ukN06LsThKLFkGpyBQdMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78049199"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 04:22:51 -0700
Date: Tue, 1 Oct 2024 04:22:49 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>, Xu Yang <xu.yang_2@nxp.com>,
	Zixian Cai <fzczx123@gmail.com>, Paran Lee <p4ranlee@gmail.com>,
	Ben Gainey <ben.gainey@arm.com>, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf python: Remove python 2 scripting support
Message-ID: <ZvvbiY1NjTZxWvG7@tassilo>
References: <20240918225418.166717-1-irogers@google.com>
 <20240918225418.166717-2-irogers@google.com>
 <Zut-iM3v9rJHehxJ@tassilo>
 <CAP-5=fWS-xOPurApZpMA=Zzukt5PQDYjF_7otCPTAL33PYmXAQ@mail.gmail.com>
 <ZvsXl2g6kYDi6F9o@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvsXl2g6kYDi6F9o@google.com>

On Mon, Sep 30, 2024 at 02:26:47PM -0700, Namhyung Kim wrote:
> On Thu, Sep 19, 2024 at 06:45:23AM +0200, Ian Rogers wrote:
> > On Thu, Sep 19, 2024 at 3:29 AM Andi Kleen <ak@linux.intel.com> wrote:
> > >
> > > On Thu, Sep 19, 2024 at 12:54:17AM +0200, Ian Rogers wrote:
> > > > Python2 was deprecated 4 years ago, remove support and workarounds.
> > >
> > > Nacked-by: Andi Kleen
> > >
> > > I don't see any advantages of breaking perfectly fine existing setups
> > > for no benefits.
> 
> Well, I think the benefit is in the maintenance.  The EOL of Python 2
> was 2020/1/1 [1] and we are targeting this release (v6.13) in 2025.  So

AFAIK it's still widely used, and supported by third parties. And even
if not it's not that the python usage in perf needs any external support.

In Linux deprecation is generally tied to nobody using something
anymore, and that is clearly not the case here.

> I think it's reasonable to consider removing Python 2 support now.

That's code that practically never changes, so I don't see any
maintenance benefit. I mean it needs to be compile tested / perf tested, 
but Arnaldo's container collection will do that practically
for free.

-Andi
