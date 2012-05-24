From: David Ahern <dsahern@gmail.com>
Subject: Re: Perf 2.6.32-220.el6.x86_64 problem when recording 2 counters
Date: Thu, 24 May 2012 08:57:13 -0600
Message-ID: <4FBE4C49.7060703@gmail.com>
References: <14480_1337789222_4FBD0B26_14480_3035_2_932AC94CE5A51243A6F091BAFB3EE3E0028AB9506D@THSONEA01CMS01P.one.grp> <1337819595.29765.9.camel@concordia> <25548_1337843693_4FBDDFED_25548_4972_1_932AC94CE5A51243A6F091BAFB3EE3E0028AB956D2@THSONEA01CMS01P.one.grp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:42090 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932287Ab2EXO5R (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 May 2012 10:57:17 -0400
Received: by dady13 with SMTP id y13so11425955dad.19
        for <linux-perf-users@vger.kernel.org>; Thu, 24 May 2012 07:57:17 -0700 (PDT)
In-Reply-To: <25548_1337843693_4FBDDFED_25548_4972_1_932AC94CE5A51243A6F091BAFB3EE3E0028AB956D2@THSONEA01CMS01P.one.grp>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: HUMMEL Michel <michel.hummel@thalesgroup.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On 5/24/12 1:14 AM, HUMMEL Michel wrote:
> I've written the test to run bad_perfo first, and then good_perfo and now only bad_perfo is in the report :
>
> $ perf record -e  cycles,instructions  -o perf.data.cycles.instructions2 ./test_perfo2
> $ perf report -i perf.data.cycles.instructions2 --stdio
> # Events: 8K cycles
> #
> # Overhead  Command      Shared Object                     Symbol
> # ........  .......  .................  .........................
> #
>      99.52%  test_perfo2  test_perfo2        [.] bad_perfo
>       0.06%  test_perfo2  [kernel.kallsyms]  [k] copy_page_c
>       0.05%  test_perfo2  [kernel.kallsyms]  [k] apic_timer_interrupt
>       0.04%  test_perfo2  [kernel.kallsyms]  [k] run_timer_softirq
>
>
> # Events: 8K instructions
> #
> # Overhead  Command      Shared Object                   Symbol
> # ........  .......  .................  .......................
> #
>      99.82%  test_perfo2  test_perfo2        [.] bad_perfo
>       0.04%  test_perfo2  ld-2.12.so         [.] _dl_lookup_symbol_x
>       0.01%  test_perfo2  [kernel.kallsyms]  [k] clear_page_c
>       0.01%  test_perfo2  [kernel.kallsyms]  [k] update_wall_time
>

Can you try an upstream version of the perf binary? It should be able to 
read the data file. You can use the perf-script command to dump the 
events and look at what was recorded and which type of event (cycles vs 
instructions). Adding -R to the record will get the timestamp added to 
each sample and look at the delta time between samples. Maybe that will 
give a clue.

David
