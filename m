From: Feng Tang <feng.tang@intel.com>
Subject: Re: [PATCH v4 07/15] perf tools report: Use less for scripts output
Date: Sat, 9 Mar 2019 15:52:25 +0800
Message-ID: <20190309075225.6bfmj4vofatiy4md@shbuild888>
References: <20190305144758.12397-1-andi@firstfloor.org>
 <20190305144758.12397-8-andi@firstfloor.org>
 <20190308134754.GD26260@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308134754.GD26260@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Andi Kleen <andi@firstfloor.org>, jolsa@kernel.org, namhyung@kernel.org, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-Id: linux-perf-users.vger.kernel.org

On Fri, Mar 08, 2019 at 10:47:54AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Tue, Mar 05, 2019 at 06:47:50AM -0800, Andi Kleen escreveu:
> > From: Andi Kleen <ak@linux.intel.com>
> > 
> > The UI viewer for scripts output has a lot of limitations: limited size,
> > no search or save function, slow, and various other issues.
> > 
> > Just use 'less' to display directly on the terminal instead.
> 
> I'm ok with this, CCing Feng tho since he contributed this browser, to
> let him know.

Thanks for the note!

> 
> - Arnaldo
>  
> > This won't work in gtk mode, but gtk doesn't support these
> > context menus anyways. If that is ever done could use an terminal
> > for the output.
> > 
> > Signed-off-by: Andi Kleen <ak@linux.intel.com>
> > 

Looks good to me.

Acked-by: Feng Tang <feng.tang@intel.com>

Thanks,
Feng
