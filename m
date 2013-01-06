From: Andi Kleen <andi@firstfloor.org>
Subject: Re: perf top shows [unknown]
Date: Sat, 05 Jan 2013 22:54:58 -0800
Message-ID: <m27gnqdcn1.fsf@firstfloor.org>
References: <20130105085225.cfe28f3dad43a2148885c2f4@lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:32959 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750854Ab3AFGzW (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 6 Jan 2013 01:55:22 -0500
Received: from public by plane.gmane.org with local (Exim 4.69)
	(envelope-from <public@plane.gmane.org>)
	id 1Trk8m-00050N-F7
	for linux-perf-users@vger.kernel.org; Sun, 06 Jan 2013 07:55:28 +0100
In-Reply-To: <20130105085225.cfe28f3dad43a2148885c2f4@lavabit.com> (rh's
	message of "Sat, 5 Jan 2013 08:52:25 -0800")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: rh <public-richard_hubbe11-N9AOi2cAC9ZBDgjK7y7TUQ@plane.gmane.org>
Cc: public-linux-perf-users-u79uwXL29TY76Z2rM5mHXA@plane.gmane.org



rh <richard_hubbe11-N9AOi2cAC9ZBDgjK7y7TUQ@public.gmane.org> writes:

> How to change things so that [unknown] becomes [something known]?
>
> When I run perf top 
> I see [unknown] in the 2nd column. Am I missing a build flag?
> I specified vmlinux too.
>
> I can't find anything else about this, how would I go about discovering
> what that [unknown] is about?

I often see this when I run perf top as non root. Fix: run as root.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
