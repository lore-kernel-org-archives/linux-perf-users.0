From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH 03/11] perf tools report: Support nano seconds
Date: Mon, 25 Feb 2019 09:34:08 -0800
Message-ID: <20190225173408.GV16922@tassilo.jf.intel.com>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-4-andi@firstfloor.org>
 <d90b76f2-8d53-05ac-1526-9f0ddc4a0328@gydle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d90b76f2-8d53-05ac-1526-9f0ddc4a0328@gydle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastien Boisvert <sboisvert@gydle.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 25, 2019 at 11:40:45AM -0500, Sebastien Boisvert wrote:
> 
> 
> On 2019-02-24 10:37 a.m., Andi Kleen wrote:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > Upcoming changes add timestamp output in perf report. Add a --ns
> > argument similar to perf script to support nanoseconds resolution
> > when needed.
> 
> Is this a ISO-8601 date with nanoseconds ?

No. 

-Andi
