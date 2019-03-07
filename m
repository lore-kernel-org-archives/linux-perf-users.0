From: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Subject: Re: [PATCH 02/35] perf probe: Clarify error message about not
 finding kernel modules debuginfo
Date: Thu, 7 Mar 2019 20:58:23 -0300
Message-ID: <20190307235823.GD32240@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
 <20190307174433.28819-3-acme@kernel.org>
 <20190308083033.cd4aceb08983875d07cabc1a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190308083033.cd4aceb08983875d07cabc1a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, Marcelo Ricardo Leitner <mleitner@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Mar 08, 2019 at 08:30:33AM +0900, Masami Hiramatsu escreveu:
> On Thu,  7 Mar 2019 14:44:00 -0300
> Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> 
> > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > 'perf probe' supports using just the kernel module name, but that will
> > work only when the module is loaded, or using the full pathname to the
> > file with the DWARF debug info, but the warning was cryptic:
> 
> Agreed, this looks good to me.
> 
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks for checking!

- Arnaldo
 
> Thank you!
> 
> > 
> > Before:
> > 
> >   # perf probe -m cls_flower -L fl_change
> >   Failed to find the path for cls_flower: No such file or directory
> >     Error: Failed to show lines.
> >   #
> > 
> > After:
> > 
> >   # perf probe -m cls_flower -L fl_change
> >   Module cls_flower is not loaded, please specify its full path name.
> >     Error: Failed to show lines.
> >   # perf probe -m /lib/modules/5.0.0-rc7+/kernel/net/sched/cls_flower.ko -L fl_change | head -7
> >   <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
> >         0  static int fl_change(struct net *net, struct sk_buff *in_skb,
> >          		       struct tcf_proto *tp, unsigned long base,
> >          		       u32 handle, struct nlattr **tca,
> >          		       void **arg, bool ovr, struct netlink_ext_ack *extack)
> >         4  {
> >         5  	struct cls_fl_head *head = rtnl_dereference(tp->root);
> >   #
> > 
> > The behaviour doesn't change when the module is loaded:
> > 
> >   # modprobe cls_flower
> >   # perf probe -m cls_flower -L fl_change | head -7
> >   <fl_change@/home/acme/git/linux/net/sched/cls_flower.c:0>
> >         0  static int fl_change(struct net *net, struct sk_buff *in_skb,
> >                                struct tcf_proto *tp, unsigned long base,
> >                                u32 handle, struct nlattr **tca,
> >                                void **arg, bool ovr, struct netlink_ext_ack *extack)
> >         4  {
> >         5         struct cls_fl_head *head = rtnl_dereference(tp->root);
> >   #
> > 
> > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > Cc: Jiri Olsa <jolsa@kernel.org>
> > Cc: Marcelo Ricardo Leitner <mleitner@redhat.com>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Link: https://lkml.kernel.org/n/tip-q4njvk9mshra00jacqjbzfn5@git.kernel.org
> > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >  tools/perf/util/probe-event.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> > index 0030f9b9bf7e..a1b8d9649ca7 100644
> > --- a/tools/perf/util/probe-event.c
> > +++ b/tools/perf/util/probe-event.c
> > @@ -472,9 +472,12 @@ static struct debuginfo *open_debuginfo(const char *module, struct nsinfo *nsi,
> >  					strcpy(reason, "(unknown)");
> >  			} else
> >  				dso__strerror_load(dso, reason, STRERR_BUFSIZE);
> > -			if (!silent)
> > -				pr_err("Failed to find the path for %s: %s\n",
> > -					module ?: "kernel", reason);
> > +			if (!silent) {
> > +				if (module)
> > +					pr_err("Module %s is not loaded, please specify its full path name.\n", module);
> > +				else
> > +					pr_err("Failed to find the path for the kernel: %s\n", reason);
> > +			}
> >  			return NULL;
> >  		}
> >  		path = dso->long_name;
> > -- 
> > 2.20.1
> > 
> 
> 
> -- 
> Masami Hiramatsu <mhiramat@kernel.org>

-- 

- Arnaldo
