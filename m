Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D353DDB0A;
	Thu, 20 Aug 2026 21:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261070; cv=none; b=CN8kaypeSlgn2/jDY+EcxGho3QtYttA3h/5Ruk3+N/CKhRtb4REJCGL34eb7OLixVPX/lYKdu2GxPQe1hGUyLSDgQPaMARuUlOQJ3DmPzPyYUzJU2XiHEYuh6WO+E/VRY695eL1ysbTNOeSR0QVV4KLjgNjm+nOgWc5DwyzCjK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261070; c=relaxed/simple;
	bh=wA0CT8WI38hZXYhxVdPNbW84E8ACUekVefIEIABW61w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHG2SEy6Ie5xvf/sviaBazIXU+WhjFMk0j+14cn1sqeL79DVDIfk55Kj6YuTpfv4DVVJzm00B0lfsgEFJnUJMeEMGKbeYIowq2yl36m4KCSnpWP8+L7CO7IGc9ajJ25gsxd+aAjNFQsmm4DfYQHeiortb5SCMn+tZmPL9++uNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4vM3FTg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4vM3FTg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1780A1F000E9;
	Thu, 20 Aug 2026 21:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787261068;
	bh=hFufmZrUux+PQcZ6hrn5BgZH93X9ilFmbWvBLOEbjn0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=E4vM3FTg3XRewtlYIyCl6t4PZStSWBXgaHI3wyS+xaAxkyjhgwwJdNuH0U4185Vnn
	 tr9N+jpR+S18lIYWgpayWi5Jv2tMNanHrh/HrkcvG+05/FbxOsFx6dnYiN0Ii2UT/T
	 ArVXJslJuPtLvHwXtzdBlSsUcDOhmMJdpr3yCMYBuvc6BsD2d6G5mKDfVv6o+RLUue
	 GXblfeFs31Ch0LX54uiluMtXFswyZCf2ium0DyFZ7ReSFPRKk3dzgJZTHvImAT4Kfd
	 azyHG6n/3Ma8jVpM0hZC754EhYMaTXPUW+zGHEyasFnrsk2BY/SK1mg31ZxLYnF6py
	 1388zBo4THrbw==
Date: Thu, 20 Aug 2026 14:24:26 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Falcon, Thomas" <thomas.falcon@intel.com>
Cc: "Rogers, Ian" <irogers@google.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"acme@kernel.org" <acme@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jolsa@kernel.org" <jolsa@kernel.org>,
	"dapeng1.mi@linux.intel.com" <dapeng1.mi@linux.intel.com>,
	"Hunter, Adrian" <adrian.hunter@intel.com>
Subject: Re: [PATCH v4 4/6] perf tools: Show memory region in perf-c2c
 subcommand
Message-ID: <aodwioqUb5vxdHJo@google.com>
References: <20260811173340.96013-1-thomas.falcon@intel.com>
 <20260811173340.96013-5-thomas.falcon@intel.com>
 <CAP-5=fX8fG6LUZUjHWKYqFeAhRW3XWmwuBUc=jqpAxde5mC2fQ@mail.gmail.com>
 <aoX2F0HrZzWhiEXn@google.com>
 <9762e0ab86bd30c9115b35fce312f7fdbf6f96df.camel@intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9762e0ab86bd30c9115b35fce312f7fdbf6f96df.camel@intel.com>

On Wed, Aug 19, 2026 at 10:03:58PM +0000, Falcon, Thomas wrote:
> On Wed, 2026-08-19 at 11:29 -0700, Namhyung Kim wrote:
> > Hello,
> > 
> > On Mon, Aug 17, 2026 at 02:35:44PM -0700, Ian Rogers wrote:
> > > On Tue, Aug 11, 2026 at 10:34 AM Thomas Falcon
> > > > @@ -2898,8 +2948,9 @@ static int ui_quirks(void)
> > > >         /* Fix the zero line for dcacheline column. */
> > > >         buf = fill_line(chk_double_cl ? "Double-Cacheline" : "Cacheline",
> > > >                                 dim_dcacheline.width +
> > > > +                               dim_dcacheline_mem_region.width +
> > > >                                 dim_dcacheline_node.width +
> > > > -                               dim_dcacheline_count.width + 4);
> > > > +                               dim_dcacheline_count.width + 6);
> 
> Do you think this needs to be handled dynamically too?
 
Ideally it should not change anything when memory region is not
available.

Thanks,
Namhyung


> > > >         if (!buf)
> > > >                 return -ENOMEM;
> > > > 
