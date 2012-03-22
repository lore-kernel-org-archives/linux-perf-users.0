From: Yipeng Huang <yipeng@gmail.com>
Subject: Re: perf stat: Doubt about stall cycle support
Date: Thu, 22 Mar 2012 00:43:24 +0000 (UTC)
Message-ID: <loom.20120322T013621-317@post.gmane.org>
References: <loom.20120321T054053-857@post.gmane.org> <4F69E9C4.8060108@gmail.com> <CAB_n8zK5b0jWA=retCX12DGmrb19gMd2UxJGWkn6HD9nFrdiAQ@mail.gmail.com> <4F6A00BC.8070705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:41128 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab2CVAnf (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 21 Mar 2012 20:43:35 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glkpu-linux-perf-users@m.gmane.org>)
	id 1SAW7p-0003U5-Il
	for linux-perf-users@vger.kernel.org; Thu, 22 Mar 2012 01:43:33 +0100
Received: from cm231.omega17.maxonline.com.sg ([218.186.17.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Mar 2012 01:43:33 +0100
Received: from yipeng by cm231.omega17.maxonline.com.sg with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-perf-users@vger.kernel.org>; Thu, 22 Mar 2012 01:43:33 +0100
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

David Ahern <dsahern <at> gmail.com> writes:

> 
> On 3/21/12 9:32 AM, yipeng wrote:
> >
> >     What does perf --version show?
> >
> >     Should be fixed by 2cee77c4505fc581f41b44e18ffc09__53b67a414c.
> >
> >     David
> >
> >
> > I'm not sure what version that hash is. I'm using perf version
> > 3.0.22. Is my version that too old?
> 
> That's a commit id for perf-stat to discriminate unsupported events from 
> not counted events.
> 
> It was committed around 3.0 timeframe. Try compiling a newer version of 
> perf and see if it addresses your concern.
> 
> David
> 


David, you are right, it consistently shows "not supported by the kernel" on
3.2. However, I am still unable to read stall cycles. 

Since I am on a much newer kernel, could it be the case that reading stall
cycles is not supported by my hardware rather than by the kernel?

Thanks, 

Yipeng 
