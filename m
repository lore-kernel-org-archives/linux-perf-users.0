From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH RESEND] perf unwind: Report error from dwfl_attach_state
Date: Tue, 20 Mar 2018 13:18:26 -0300
Message-ID: <20180320161826.GA4229@kernel.org>
References: <20180318175053.4222-1-jpmv27@aim.com>
 <20180320080633.10e8414475a534ce9cf26c28@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180320080633.10e8414475a534ce9cf26c28@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kim Phillips <kim.phillips@arm.com>
Cc: Martin Vuille <jpmv27@aim.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Mar 20, 2018 at 08:06:33AM +0800, Kim Phillips escreveu:
> On Sun, 18 Mar 2018 13:50:53 -0400
> Martin Vuille <jpmv27@aim.com> wrote:
> 
> > In verbose level 2, errors returned by libdw are reported in most cases,
> > but not when calling dwfl_attach_state.
> > 
> > Since elfutils v 0.160 (2014), dwfl_attach_state sets the error code to
> > report failure cause. On failure, log the reported error.
> > 
> > Signed-off-by: Martin Vuille <jpmv27@aim.com>
> > ---
> 
> Reviewed-by: Kim Phillips <kim.phillips@arm.com>

Thanks, applied.

- Arnaldo
