From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/3] perf report: don't try to map ip to invalid map
Date: Thu, 27 Sep 2018 16:07:44 -0300
Message-ID: <20180927190744.GF25764@kernel.org>
References: <20180926135207.30263-1-milian.wolff@kdab.com>
 <20180926141819.GD25764@kernel.org>
 <2962236.ln4BiC7fMR@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2962236.ln4BiC7fMR@milian-kdab2>
Sender: linux-kernel-owner@vger.kernel.org
To: Milian Wolff <milian.wolff@kdab.com>
Cc: jolsa@kernel.org, yao.jin@linux.intel.com, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Sandipan Das <sandipan@linux.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

Em Wed, Sep 26, 2018 at 04:41:23PM +0200, Milian Wolff escreveu:
> On Wednesday, September 26, 2018 4:18:19 PM CEST Arnaldo Carvalho de Melo 
> wrote:
> > Em Wed, Sep 26, 2018 at 03:52:05PM +0200, Milian Wolff escreveu:
> > > Fixes a crash when the report encounters an address that
> > 
> > > could not be associated with an mmaped region:
> > Milian, can you spot which cset introduced this problem? So that we can
> > add a "Fixes: sha" tag in this (and the others, if needed) to help the
> > stable kernel maintainers to find which kernels this has to be
> > backported to?
> 
> The issue was introduced by
> 
> perf script: Show correct offsets for DWARF-based unwinding
> 
> This in turn got backported already a few times, at which point the 
> 2a9d5050dc84fa2060f08a52f632976923e0fa7e sha was used when referencing the 
> "Upstream commit".
> 
> Is that enough, or do you need me to find all the backported shas too?

I think it is enough, and I hope that the stable guys already handle
fixes to fixes :-)

- Arnaldo
