From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 4/9] cpuidle: Introduce .abbr (abbrevation) for cpuidle
 states
Date: Wed, 12 Jan 2011 01:56:45 -0500 (EST)
Message-ID: <alpine.LFD.2.02.1101120150570.19140@x980>
References: <1294396190-23031-1-git-send-email-trenn@suse.de>
 <1294396190-23031-5-git-send-email-trenn@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:48155 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751368Ab1ALG4w (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 12 Jan 2011 01:56:52 -0500
In-reply-to: <1294396190-23031-5-git-send-email-trenn@suse.de>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Thomas Renninger <trenn@suse.de>
Cc: linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, j-pihet@ti.com, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org

I'm not fond of inventing a new 3-character abbreviation field
for every state because display tools can't handle the existing
16-character name field.

If the display tools can only handle 3 characters,
then why not have them simply use the 1st 3 characters
of the existing name field?  If that is not unique,
then re-arrange the strings so that it is unique...

Of course the ACPI part of this patch will not apply,
as it depends on patch 1 in this series, which was erroneous.
For ACPI, the existing name field is already fine,
as C%d fits into 3 characters.

thanks,
Len Brown, Intel Open Source Technology Center
