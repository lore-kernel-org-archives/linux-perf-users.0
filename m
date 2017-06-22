From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH] perf probe: Fix probe definition for inlined functions
Date: Thu, 22 Jun 2017 13:16:12 -0300
Message-ID: <20170622161612.GE2170@redhat.com>
References: <20170621164134.5701-1-bjorn.topel@gmail.com>
 <20170622190138.b9fdfaada8da0af1b8cf6990@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170622190138.b9fdfaada8da0af1b8cf6990@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@gmail.com>, LKML <linux-kernel@vger.kernel.org>, =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>, linux-perf-users <linux-perf-users@vger.kernel.org>, magnus.karlsson@intel.com
List-Id: linux-perf-users.vger.kernel.org

Em Thu, Jun 22, 2017 at 07:01:38PM +0900, Masami Hiramatsu escreveu:
> On Wed, 21 Jun 2017 18:41:34 +0200
> Björn Töpel <bjorn.topel@gmail.com> wrote:
> 
> > From: Björn Töpel <bjorn.topel@intel.com>
> > 
> > In commit 613f050d68a8 ("perf probe: Fix to probe on gcc generated
> > functions in modules"), the offset from symbol is, incorrectly, added
> > to the trace point address. This leads to incorrect probe trace points
> > for inlined functions and when using relative line number on symbols.
> > 
> > Prior this patch:
> >   $ perf probe -m nf_nat -D in_range
> >   p:probe/in_range nf_nat:in_range.isra.9+0
> >   $ perf probe -m i40e -D i40e_clean_rx_irq
> >   p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2212
> >   $ perf probe -m i40e -D i40e_clean_rx_irq:16
> >   p:probe/i40e_clean_rx_irq i40e:i40e_lan_xmit_frame+626
> > 
> > After:
> >   $ perf probe -m nf_nat -D in_range
> >   p:probe/in_range nf_nat:in_range.isra.9+0
> >   $ perf probe -m i40e -D i40e_clean_rx_irq
> >   p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+1106
> >   $ perf probe -m i40e -D i40e_clean_rx_irq:16
> >   p:probe/i40e_clean_rx_irq i40e:i40e_napi_poll+2665
> 
> OK, I've confirmed it. This bug also affects -D option for
> offline probes...
> 
> $ ./perf probe -k ~/kbin/linux.x86_64/vmlinux -vD vfs_read:11
> probe-definition(0): vfs_read:11
> [...]
> Try to find probe point from debuginfo.
> Matched function: vfs_read [28b211e]
> Probe point found: vfs_read+90  <- here vfs_read+90
> Found 1 probe_trace_events.
> p:probe/vfs_read vfs_read+180   <- here vfs_read+180 = 90+90
> 
> So offset to be doubled...
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Arnaldo, this should go to urgent/stable. 

Thanks for checking, I'll get it into tools/urgent and CC stable, the
Fixes tag should be enough for stable maintainers to figure out what
kernels should get it.

- Arnaldo
