From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 2/2] perf/bench/numa: Handle discontiguous/sparse numa
 nodes
Date: Wed, 15 Nov 2017 15:13:57 +0530
Message-ID: <1510738564.k2rtmh3mkn.naveen@linux.ibm.com>
References: <cover.1503310062.git.sathnaga@linux.vnet.ibm.com>
        <67b88aa2de6dd199d57bacdecf35d26958780feb.1503310062.git.sathnaga@linux.vnet.ibm.com>
        <20171031151658.clq6qmdfw3gj6afg@naverao1-tp.localdomain>
        <1510663562.24275.38.camel@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510663562.24275.38.camel@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Cc: acme@kernel.org, bala24@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, mingo@kernel.org, srikar@linux.vnet.ibm.com
List-Id: linux-perf-users.vger.kernel.org

Hi Satheesh,

Satheesh Rajendran wrote:
> Hi Naveen,
> 
> 
> On Tue, 2017-10-31 at 20:46 +0530, Naveen N. Rao wrote:
>> 
>> >  	}
>> >  	BUG_ON(nr_min > nr_max);
>> > -
>> Looks like an un-necessary change there.
>> 
>> - Naveen
>> 
> I had hit with this compilation error, so had to move the
> initialization above.

I suppose you intended to reply to Arnaldo's comment about the 
declaration being moved, since my comment above was about a blank line 
being deleted in your patch. It's preferable to not do any un-related 
changes/cleanups in a patch.

> Please advice. Thanks.
> 
>   CC       bench/numa.o
> bench/numa.c: In function ‘calc_convergence’:
> bench/numa.c:1035:3: error: ISO C90 forbids mixed declarations and code
> [-Werror=declaration-after-statement]
>    int processes = count_node_processes(node);
>    ^

Not sure what changes you made, but from the error message, I'm guessing
you placed the above statement _after_ the check for is_node_present().  
What Arnaldo recommended is to retain the processes declaration within 
the scope where it's used - in this case, the for() loop - rather than 
moving it out to the start of the function.


- Naveen


> cc1: all warnings being treated as errors
> mv: cannot stat ‘bench/.numa.o.tmp’: No such file or directory
> make[4]: *** [bench/numa.o] Error 1
> make[3]: *** [bench] Error 2
> make[2]: *** [perf-in.o] Error 2
> make[1]: *** [sub-make] Error 2
> make: *** [all] Error 2
> 
> Regards,
> -Satheesh.
>> > 
>> >  	BUG_ON(sum > g->p.nr_tasks);
>> > 
>> >  	if (0 && (sum < g->p.nr_tasks))
> @@ -1027,8 +1029,9 @@ static void calc_convergence(double 
> 
