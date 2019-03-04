From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v3 10/11] perf tools report: Implement browsing of
 individual samples
Date: Mon, 4 Mar 2019 10:13:06 -0800
Message-ID: <20190304181305.vrauc44yxv43rwir@two.firstfloor.org>
References: <20190228183550.14126-1-andi@firstfloor.org>
 <20190228183550.14126-11-andi@firstfloor.org>
 <20190304144855.GL30476@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190304144855.GL30476@krava>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, jolsa@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

> > +--samples=N::
> > +	Save N individual samples for each histogram entry to show context in perf
> > +	report tui browser.
> 
> maybe we could set some default value (50?)

50 wouldn't fit on the screen.

I turned it off by default intentionally because it will increase the
memory consumption of perf report quite a bit.

It might be possible to set some small default though, but right
now I guess whoever wants it can enable it.

-Andi
