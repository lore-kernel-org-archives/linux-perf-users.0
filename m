From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/9] acpi: Use ACPI C-state type instead of enumeration
 value to export cpuidle state name
Date: Wed, 12 Jan 2011 01:36:17 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120130110.19140@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
 <1294396190-23031-2-git-send-email-trenn@suse.de>
 <alpine.LFD.2.02.1101071529100.20609@x980> <201101091330.12027.trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:49212 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752112Ab1ALGg0 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 12 Jan 2011 01:36:26 -0500
In-reply-to: <201101091330.12027.trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> > But some systems may have more than one state of each type...

> Exported through ACPI tables?

Yes.

It is quite common, for example in the Pentium M
generations, for a BIOS to export C3 and C4 -
both of which are ACPI  C3-type.

> > also, the state->name is somewhat arbitrary.
> > 
> > You'll notice that intel_idle uses the hardware C-state names
> > such as NHM-C1, NHM-C3, NHM-C6 - to match the (arbitrary)
> > names in the hardware documentation.  We could call those
> > states Moe/Larry/Curley just as well.

> That works out with HW specific intel_idle.c driver, but not
> with the generic acpi/processor one.

Actually, C0..Cn work out fine for the acpi/processor driver.
the names are unique, and they also correspond to max_cstate
if somebody wants to use that.


> I restore the ACPI type info as exported by ACPI tables
> with this patch, should be the same as done with
> /proc/acpi/processor/*/power
> Do I miss something?

/proc/acpi/processor/*/power had a type field.
Per the example above, the type field didn't always
match the C-state number.

> Do you want to export additional ACPI table C-state
> info?

I have a 1 line patch someplace to print out the type
for debug info when needed, that should be sufficient
for debugging, which is the only time we care about type.

> Something else, but related:
> You recently said that it might be a good idea to get
> C-/P- state ACPI tables which are often in a separate
> SSDT loaded at runtime via "load" ACPI command, dumped
> with the acpidump  tool. This would be a cool feature.
> Does dynamically loaded SSDT dumping
> via acpidump work already or is/has someone looked at this?

Yakui fixed this a while back.
acpidump in the latest pmtools in
http://userweb.kernel.org/~lenb/acpi/utils/
picks up the dynamic tables from /sys/firmware/acpi/tables.

cheers,
Len Brown, Intel Open Source Technology Center
