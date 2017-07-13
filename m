From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: perf report does not resolve symbols on s390x
Date: Thu, 13 Jul 2017 22:02:08 +1000
Message-ID: <87iniwk0jj.fsf@concordia.ellerman.id.au>
References: <eb00bf70-936d-e405-5867-015d4067202f@linux.vnet.ibm.com> <20170705155007.GH27350@kernel.org> <67eb6f70-fc34-95cd-b43c-349bbc24ee5d@linux.vnet.ibm.com> <5ead7c5a-5b91-107a-51ca-ea464fe8cfba@linux.vnet.ibm.com> <20170711190304.GH27350@kernel.org> <20170711193828.GI27350@kernel.org> <20170711194853.GJ27350@kernel.org> <87pod6kkee.fsf@concordia.ellerman.id.au> <20170712140412.GK27350@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:43723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbdGMMCL (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 13 Jul 2017 08:02:11 -0400
In-Reply-To: <20170712140412.GK27350@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Thomas-Mich Richter <tmricht@linux.vnet.ibm.com>, "linux-perf-use." <linux-perf-users@vger.kernel.org>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Zvonko Kosic <zvonko.kosic@de.ibm.com>, Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Wed, Jul 12, 2017 at 08:40:57PM +1000, Michael Ellerman escreveu:
>> Arnaldo Carvalho de Melo <acme@kernel.org> writes:
>> 
>> > Em Tue, Jul 11, 2017 at 04:38:28PM -0300, Arnaldo Carvalho de Melo escreveu:
>> >> Em Tue, Jul 11, 2017 at 04:03:04PM -0300, Arnaldo Carvalho de Melo escreveu:
>> >> > Em Fri, Jul 07, 2017 at 02:17:25PM +0200, Thomas-Mich Richter escreveu:
>> >> > > On 07/06/2017 02:35 PM, Thomas-Mich Richter wrote:
>> >> > > It determines the kernel starts at address 1<<63 and loads the kernel address mapping.
>> >> > > On s390x
>> >> > > - The kernel starts at 0x0 (value of map->start) and thus all checks in function 
>> >> > >   thread__find_addr_map() fail and no symbol is found for the specified addresses
>> >> > >   because the kernel starts at 0x8000000000000000. Which is wrong the kernel start at 0x0.
>> >
>> >> > Hi Thomas, really nice debugging session!
>> >
>> >> > I'm trying the one-liner below, Adrian, can you please check this and
>> >> > provide an ack? I think that that comment about the address that it will
>> >> > default when map__load() fails needs rewriting in light of Thomas
>> >> > comments about other arches (see further below)?
>> >
>> >> > I did a quick check of machine->kernel_start usage in Intel PT and since
>> >> > on x86 that assumption about partitioning the address space holds, no
>> >> > problem should be introduced by the one-liner fix, right?
>> >  
>> >> Argh, this is also broken:
>> >  
>> >> static inline bool machine__kernel_ip(struct machine *machine, u64 ip)
>> >> {
>> >>         u64 kernel_start = machine__kernel_start(machine);
>> >> 
>> >>         return ip >= kernel_start;
>> >> }
>> >> 
>> >> We can't judge if a address is in the kernel like that :-\
>> >
>> > So, this is used by:
>> >
>> > [acme@jouet linux]$ find tools/ -name "*.[ch]" | xargs grep -w machine__kernel_ip
>> > tools/perf/builtin-script.c:	kernel = machine__kernel_ip(machine, start);
>> > tools/perf/builtin-script.c:	if (kernel != machine__kernel_ip(machine, end)) {
>> >
>> > That is just for "brstackinsn", would that make sense for Sparc, S/390?
>> >
>> > tools/perf/util/intel-bts.c:	if (machine__kernel_ip(machine, ip))
>> > tools/perf/util/intel-bts.c:		if (!machine__kernel_ip(btsq->bts->machine, branch->from) &&
>> > tools/perf/util/intel-bts.c:		    machine__kernel_ip(btsq->bts->machine, branch->to) &&
>> >
>> > Intel specific stuff, so should be ok.
>> >
>> > tools/perf/util/event.c:		    machine__kernel_ip(machine, al->addr)) {
>> >
>> > For this last one, that affects all arches, I think we can just remove
>> > this check and look at the kernel when not finding it anywhere else?
>> >
>> > diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
>> > index dc5c3bb69d73..8e435baaae6a 100644
>> > --- a/tools/perf/util/event.c
>> > +++ b/tools/perf/util/event.c
>> > @@ -1432,8 +1432,7 @@ void thread__find_addr_map(struct thread *thread, u8 cpumode,
>> >  		 * in the whole kernel symbol list.
>> >  		 */
>> >  		if (cpumode == PERF_RECORD_MISC_USER && machine &&
>> > -		    mg != &machine->kmaps &&
>> > -		    machine__kernel_ip(machine, al->addr)) {
>> > +		    mg != &machine->kmaps) {
>> >  			mg = &machine->kmaps;
>> >  			load_map = true;
>> >  			goto try_again;
>> 
>> Am I reading this right? We have a sample that claims to be in
>> userspace, but was not found in any symbol map, so we try looking for it
>> in the kernel map.
>> 
>> And the change is that previously we checked if the address was >= (1 << 63),
>> whereas after we don't bother.
>> 
>> Seems harmless™.
>
> Thanks, will take that as an Acked-by:, ok?

Seems-harmless-but-will-probably-break-something-obscure-by: ... :)

Sure.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
