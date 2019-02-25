From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 07/11] perf tools report: Support running scripts for
 current time range
Date: Mon, 25 Feb 2019 14:35:31 +0100
Message-ID: <20190225133531.GA14757@krava>
References: <20190224153722.27020-1-andi@firstfloor.org>
 <20190224153722.27020-8-andi@firstfloor.org>
 <20190225125635.GL19795@krava>
 <20190225132858.GK16922@tassilo.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190225132858.GK16922@tassilo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, acme@kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, jolsa@kernel.org, namhyung@kernel.org, eranian@google.com
List-Id: linux-perf-users.vger.kernel.org

On Mon, Feb 25, 2019 at 05:28:58AM -0800, Andi Kleen wrote:
> > can't see the time ranges in the menu.. what's the path
> > to get them listed?
> 
> You need to use --sort time,overhead,sym
> 
> Without time sorting there are no available ranges.

I did, must be those hacks I put in to compile it,
will check in new version

jirka
