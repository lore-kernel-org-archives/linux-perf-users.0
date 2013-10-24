From: Nitisha Jain <nitishajain15@gmail.com>
Subject: Re: urgent help needed :perf record and report showing inconsistent results
Date: Thu, 24 Oct 2013 07:31:41 +0000 (UTC)
Message-ID: <loom.20131024T092558-537@post.gmane.org>
References: <loom.20131023T175255-294@post.gmane.org> <5267FA74.603@gmail.com> <CAJUy+oSrdAwiGVBZq-PPFB-U7gPzRwPCrFSucEyySCYqT+9v9g@mail.gmail.com> <52685A7C.6040107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:42662 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754292Ab3JXHcJ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 24 Oct 2013 03:32:09 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1VZFOl-0007j9-Rf
	for linux-perf-users@vger.kernel.org; Thu, 24 Oct 2013 09:32:04 +0200
Received: from 14.139.128.12 ([14.139.128.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2013 09:32:03 +0200
Received: from nitishajain15 by 14.139.128.12 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 24 Oct 2013 09:32:03 +0200
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

David Ahern <dsahern <at> gmail.com> writes:

> 
> On 10/23/13 7:30 PM, Nitisha Jain wrote:
> >
> >
> > I am not able to find 'perf kvm stat live' command , when I try, I get :
> >
> > usage: perf kvm [<options>] {top|record|report|diff|buildid-list}
> >
> > Is this subcommand still supported in the current version of perf ? if
> > yes, can u please tell the exact syntax ?
> 
> You need perf code from 3.12.
> 
> David
> 
> 


Thanks sir, I will try out the kvm stat command.

Although I still need to understand how perf report is calculating the total
no of cpu cycles and no of samples and why there is so much disparity
between the results for the same perf command. 
Kindly guide in this regard .
