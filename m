From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: symbol addresses are wrong when kcore is used
Date: Tue, 29 Nov 2016 14:20:19 -0200
Message-ID: <20161129162019.GE2361@redhat.com>
References: <7ab497c9-7b56-1fa2-2c7d-98f2199df993@gmail.com>
 <17c50821-7155-e90e-15ed-94350e7c63e5@intel.com>
 <427a792d-ef76-327a-419e-168c3142cb73@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35242 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753188AbcK2QUX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 29 Nov 2016 11:20:23 -0500
Content-Disposition: inline
In-Reply-To: <427a792d-ef76-327a-419e-168c3142cb73@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Perf Users <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>

Em Tue, Nov 29, 2016 at 09:08:14AM -0700, David Ahern escreveu:
> On 11/9/16 2:44 AM, Adrian Hunter wrote:
> > On 08/11/16 18:54, David Ahern wrote:
> >> Hi guys:
> >>
> >> I have been meaning to ask about this for 2 years now: perf script shows the wrong addresses when /proc/kcore is referenced. Here's an example with perf from net-next tree (4.9-rc3):
> >>
> >> $ perf record -a -g -e fib6:* -- sleep 5
> >>
> >> $ perf script
> >> vhost-7489  7491 [018]  2314.004488: fib6:fib6_table_lookup: table 255 oif 0 iif 4 src 2100:1::3 dst ff02::1:ff00:64 tos 0 scope 0 flags 0 ==> dev br1 gw ::
> >>             7fff8155f49e ip6_pol_route+0x80007f00249e ([kernel.kallsyms])
> >>             7fff8155f77a ip6_pol_route_input+0x80007f00201a ([kernel.kallsyms])
> >>             7fff81588515 fib6_rule_action+0x80007f0020c5 ([kernel.kallsyms])
> >>             7fff814c2676 fib_rules_lookup+0x80007f002116 ([kernel.kallsyms])
> >>             7fff815886b9 fib6_rule_lookup+0x80007f002059 ([kernel.kallsyms])
> >>             7fff8155c77e ip6_route_input_lookup+0x80007f00204e ([kernel.kallsyms])
> >>             7fff81560a98 ip6_route_input+0x80007f0020d8 ([kernel.kallsyms])
> >>             7fff81550a92 ip6_rcv_finish+0x80007f002082 ([kernel.kallsyms])
> >>             7fff81551344 ipv6_rcv+0x80007f002334 ([kernel.kallsyms])
> >>
> >> The 7fff addresses are completely wrong. If I compile perf and disable use of kcore:
> >>
> >> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> >> index aecff69a510d..0debd7e96aa2 100644
> >> --- a/tools/perf/util/symbol.c
> >> +++ b/tools/perf/util/symbol.c
> >> @@ -1285,7 +1285,7 @@ int __dso__load_kallsyms(struct dso *dso, const char *filename,
> >>  int dso__load_kallsyms(struct dso *dso, const char *filename,
> >>                        struct map *map)
> >>  {
> >> -       return __dso__load_kallsyms(dso, filename, map, false);
> >> +       return __dso__load_kallsyms(dso, filename, map, true);
> >>  }
> >>
> >>  static int dso__load_perf_map(struct dso *dso, struct map *map)
> >>
> >>
> >> Then the addresses are correct:
> >>
> >> vhost-7489  7491 [018]  2314.004488: fib6:fib6_table_lookup: table 255 oif 0 iif 4 src 2100:1::3 dst ff02::1:ff00:64 tos 0 scope 0 flags 0 ==> dev br1 gw ::
> >>         ffffffff8155d49e ip6_pol_route+0x49e ([kernel.kallsyms])
> >>         ffffffff8155d77a ip6_pol_route_input+0x1a ([kernel.kallsyms])
> >>         ffffffff81586515 fib6_rule_action+0xc5 ([kernel.kallsyms])
> >>         ffffffff814c0676 fib_rules_lookup+0x116 ([kernel.kallsyms])
> >>         ffffffff815866b9 fib6_rule_lookup+0x59 ([kernel.kallsyms])
> >>         ffffffff8155a77e ip6_route_input_lookup+0x4e ([kernel.kallsyms])
> >>         ffffffff8155ea98 ip6_route_input+0xd8 ([kernel.kallsyms])
> >>         ffffffff8154ea92 ip6_rcv_finish+0x82 ([kernel.kallsyms])
> >>         ffffffff8154f344 ipv6_rcv+0x334 ([kernel.kallsyms])
> >>
> >>
> >> Or if I cat kallsyms into a file and pass it to perf it works:
> >>
> >> $ cat /proc/kallsyms > /tmp/kallsyms
> >> $ perf script --kallsyms /tmp/kallsyms
> >>
> >> vhost-7489  7491 [018]  2314.004488: fib6:fib6_table_lookup: table 255 oif 0 iif 4 src 2100:1::3 dst ff02::1:ff00:64 tos 0 scope 0 flags 0 ==> dev br1 gw ::
> >>         ffffffff8155d49e ip6_pol_route+0x49e ([kernel.kallsyms])
> >>         ffffffff8155d77a ip6_pol_route_input+0x1a ([kernel.kallsyms])
> >>         ffffffff81586515 fib6_rule_action+0xc5 ([kernel.kallsyms])
> >>         ffffffff814c0676 fib_rules_lookup+0x116 ([kernel.kallsyms])
> >>         ffffffff815866b9 fib6_rule_lookup+0x59 ([kernel.kallsyms])
> >>         ffffffff8155a77e ip6_route_input_lookup+0x4e ([kernel.kallsyms])
> >>         ffffffff8155ea98 ip6_route_input+0xd8 ([kernel.kallsyms])
> >>         ffffffff8154ea92 ip6_rcv_finish+0x82 ([kernel.kallsyms])
> >>         ffffffff8154f344 ipv6_rcv+0x334 ([kernel.kallsyms])
> >>
> >> So there is something fundamentally wrong with the use of /proc/kcore.
> >>
> >> Adrian: I seem to recall you added support for kcore. Any ideas on why the addresses are wrong?
> > 
> > I took a quick look at the kcore code and it seemed to make sense.  Whereas
> > the problem seems to be related to callchains.
> > 
> > perf works with MMAP events that map memory addresses to file offsets.  So a
> > memory address is passed to thread__find_addr_map() and you get back a file
> > offset in al.addr.
> > 
> > perf adjusts symbols if necessary so that they are also file offsets.  So
> > perf can use al.addr to find the symbol.
> > 
> > I don't know why, but there seems to be some confusion in the callchain
> > code.  If you look at add_callchain_ip(), it is putting al.addr into the
> > callchain node.  However if you look at sample__fprintf_callchain() it seems
> > to expect the callchain node to contain a memory address and it maps it again.
> > 
> > Other callchain consumers like fill_callchain_info() also seem to expect the
> > callchain node to contain a memory address, and also map it again.
> > 
> > Note, in cases where the maps are identity maps (e.g. kallsyms only) then
> > the problem would be hidden.
> > 
> > At least that is what I think is happening.  Maybe someone else can comment.
> > 
> 
> Arnaldo, Jiri, Namhyung - any thoughts on this? The addresses dumped by perf-script are fundamentally broken when kcore is used without vmlinux.
> 
> I could send a patch to disable kcore or give an option to disable use of kcore.

I planned to look into this, but so far couldn't, I think that an option
to explicitely disable kcore would be good.

I will take a look at this as time permits, what Adrian found warrants
further investigation to get this fixed.

- Arnaldo
