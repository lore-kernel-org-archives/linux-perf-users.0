From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: Why "perf stat" output more memory load/store counts?
Date: Tue, 10 Mar 2015 09:02:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1503100901230.5471@vincent-weaver-1.umelst.maine.edu>
References: <CA+MhoaMshSNRS1RD0Dq6dXY_XZtEnryfRq6Hvm+Ntf_Gs67h=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-qg0-f49.google.com ([209.85.192.49]:44559 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752756AbbCJM6R (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 10 Mar 2015 08:58:17 -0400
Received: by qgfl89 with SMTP id l89so1380123qgf.11
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Mar 2015 05:58:16 -0700 (PDT)
In-Reply-To: <CA+MhoaMshSNRS1RD0Dq6dXY_XZtEnryfRq6Hvm+Ntf_Gs67h=g@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Nan Xiao <xiaonan830818@gmail.com>
Cc: linux-perf-users@vger.kernel.org

On Tue, 10 Mar 2015, Nan Xiao wrote:

> I can't understand why there are so many more load/store operations
> from "perf stat" output. Could anyone can explain this? Thanks very
> much in advance!

there are a lot of reasons you might get overcount, but in this particular 
case it looks like you are probably counting kernel events too.  Do things 
get better if you put ":u" on your event names so that you only count user 
events?

Vince
