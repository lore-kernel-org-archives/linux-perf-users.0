From: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: Using a new perf tool against an older kernel
Date: Fri, 24 Jun 2011 02:11:48 +0200
Message-ID: <20110624001145.GE8058@somewhere.redhat.com>
References: <4E026123.4060208@fb.com>
 <4E034C2C.30509@gmail.com>
 <4E03968A.5010008@fb.com>
 <4E039BC7.4050802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:61995 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759835Ab1FXALw (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 23 Jun 2011 20:11:52 -0400
Content-Disposition: inline
In-Reply-To: <4E039BC7.4050802@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: David Ahern <dsahern@gmail.com>
Cc: Arun Sharma <asharma@fb.com>, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Jun 23, 2011 at 02:02:15PM -0600, David Ahern wrote:
> 
> 
> On 06/23/2011 01:39 PM, Arun Sharma wrote:
> > On 6/23/11 7:22 AM, David Ahern wrote:
> > 
> >> I have not seen issues like this using newer perf userspace against
> >> older kernels. For example, my laptop was running Fedora 14 (2.6.35) and
> >> now Fedora 15 (2.6.38.8) and I typically use latest perf builds (e.g.,
> >> testing patches).
> > 
> > I narrowed it down to PERF_SAMPLE_RAW:
> > 
> > perf record -ag -- sleep 1
> > 
> > is fine, but:
> > 
> > perf record -agR -- sleep 1
> > 
> > fails for me most of the time. The reason I needed to use the -R in the
> > first place is that "perf script" fails on older kernels with:
> > 
> > Samples do not contain timestamps.
> > 
> > With the newer perf, I don't get errors, but the timestamp field is
> > invalid. So I need to use the -R flag to get valid timestamps +
> > stacktraces out of "perf script".
> 
> That should have been fixed.
> 
> And -T on record gets the timestamps.
> 
> David

Right, it would be nice to suggest that from perf script when timestamps
are not recorded.
