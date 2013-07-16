From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf documentation: update format and events ABI files
Date: Tue, 16 Jul 2013 10:32:25 +0200
Message-ID: <20130716083225.GB1098@krava.brq.redhat.com>
References: <alpine.DEB.2.10.1307151656050.6555@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753151Ab3GPIdA (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 16 Jul 2013 04:33:00 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.10.1307151656050.6555@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org, acme@redhat.com, Stephane Eranian <eranian@gmail.com>

On Mon, Jul 15, 2013 at 05:04:50PM -0400, Vince Weaver wrote:

SNIP

> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> index 3c1cc24..43aae08 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> @@ -1,30 +1,51 @@
> -What:		/sys/devices/cpu/events/
> +What:		/sys/bus/event_source/devices/<dev>/events
> +
> +Date:		2013/01/08
> +
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +
> +Description:	Generic performance monitoring events
> +
> +		A collection of performance monitoring events that are
> +		supported by the PMU (performance monitoring unit)
> +		specified by "<dev>". These events can be monitored
> +		using the 'perf(1)' tool.
> +
> +		The contents of each file is a list of attribute names
> +		(as found in the corresponding
> +			/sys/bus/event_source/devices/<dev>/format
> +		file) separated by commas.  Each entry has
> +		an optional value (either hex or decimal).  If no
> +		value is specified than it is assumed to be a single-bit
> +		field with a value of 1.
> +
> +		An example of what you might find:
> +			event=0x2,inv,ldlat=3
> +
> +
> +What:		/sys/devices/cpu/events/branch-instructions
>  		/sys/devices/cpu/events/branch-misses
> -		/sys/devices/cpu/events/cache-references
> +		/sys/devices/cpu/events/bus-cycles
>  		/sys/devices/cpu/events/cache-misses
> -		/sys/devices/cpu/events/stalled-cycles-frontend
> -		/sys/devices/cpu/events/branch-instructions
> -		/sys/devices/cpu/events/stalled-cycles-backend
> -		/sys/devices/cpu/events/instructions
> +		/sys/devices/cpu/events/cache-references
>  		/sys/devices/cpu/events/cpu-cycles

missing:
		/sys/devices/cpu/events/ref-cycles

> +		/sys/devices/cpu/events/instructions
> +		/sys/devices/cpu/events/stalled-cycles-backend
> +		/sys/devices/cpu/events/stalled-cycles-frontend

SNIP

>  
>  What: 		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> index 77f47ff..4f7ee5e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-format
> @@ -15,6 +15,12 @@ Description:
>  			attr2 = 'config:0-7'
>  			attr3 = 'config:12-35'
>  
> -		Example: 'config1:1,6-10,44'
> +		Example: event = 'config1:1,6-10,44'
>  		Defines contents of attribute that occupies bits 1,6-10,44 of
>  		perf_event_attr::config1.
> +
> +		In this example, the events file would have the value 

nit, whitespace at the end of the above line 

> +			event=0x7f
> +		to set all of the specified bits (they will be split up).
> +		You would not use 0x10000007c2 (which is what the bits
> +		actually passed into config1 would look like).

thanks,
jirka
