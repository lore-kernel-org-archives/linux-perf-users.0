From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: help with porting perf lkm to later kernel
Date: Thu, 29 Aug 2013 08:59:06 +0200
Message-ID: <20130829065906.GU10002@twins.programming.kicks-ass.net>
References: <CANFySve_0Mw48knK-1ueWjibBQfzfgLQzOhJde5zWL9OZO3iYw@mail.gmail.com>
 <521E81FB.2030302@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:56810 "EHLO
	merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753872Ab3H2G7O (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 29 Aug 2013 02:59:14 -0400
Content-Disposition: inline
In-Reply-To: <521E81FB.2030302@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: cfreehill@alumni.utexas.net, Chris Freehill <cfreehill@gmail.com>, linux-perf-users@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>

On Wed, Aug 28, 2013 at 05:04:27PM -0600, David Ahern wrote:
> On 8/28/13 4:53 PM, Chris Freehill wrote:
> >>I am trying to get my linux kernel module that extends perf support to work
> >>in a later kernel version. The lkm had been working in 3.0.51.
> >>
> >>In the new target kernel to which I am trying to port, 3.8.13, I get
> >>warnings at the modpost stage complaining about symbols that can no longer
> >>be found. If I attempt to load that module, I get errors saying the same
> >>thing (those symbols can't be found).
> >>
> >>The symbols that can't be found are
> >>
> >>".perf_pmu_enable"
> >>
> >>".perf_event_update_userpage"
> >>
> >>".perf_pmu_disable"
> >>
> >>".perf_event_overflow"
> >>
> >>".perf_pmu_unregister"
> >>
> >>".perf_pmu_register"
> >>
> >>Does anyone have any tips or advice as to how code that calls these
> >>previously working functions should now be handled when built against later
> >>kernels?

# git show v3.0:kernel/events/core.c | grep EXPORT_SYMBOL
EXPORT_SYMBOL_GPL(perf_event_release_kernel);
EXPORT_SYMBOL_GPL(perf_event_read_value);
EXPORT_SYMBOL_GPL(perf_register_guest_info_callbacks);
EXPORT_SYMBOL_GPL(perf_unregister_guest_info_callbacks);
EXPORT_SYMBOL_GPL(perf_swevent_get_recursion_context);
EXPORT_SYMBOL_GPL(perf_tp_event);
EXPORT_SYMBOL_GPL(perf_event_create_kernel_counter);

IOW. how can your module have ever used those functions in 3.0 ?

Typically the answer to 'why did the export get removed' is simply
'because there are no users'.
