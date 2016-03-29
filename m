From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/9] perf test: Adding an entry for the perftool-testsuite
Date: Tue, 29 Mar 2016 21:39:08 +0200
Message-ID: <20160329193908.GA19392@krava.redhat.com>
References: <cover.1458134357.git.mpetlan@redhat.com>
 <alpine.LRH.2.20.1603161450230.13911@Rudolf-RHEL-7>
 <20160327122447.GM4015@krava.sund.root.ku.dk>
 <alpine.LRH.2.20.1603290206080.7107@Rudolf-RHEL-7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:60791 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190AbcC2TjN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 29 Mar 2016 15:39:13 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.20.1603290206080.7107@Rudolf-RHEL-7>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, acme@kernel.org

On Tue, Mar 29, 2016 at 02:19:17PM +0200, Michael Petlan wrote:
> On Sun, 27 Mar 2016, Jiri Olsa wrote:
> >On Wed, Mar 16, 2016 at 02:50:59PM +0100, Michael Petlan wrote:
> >
> >SNIP
> >
> >>+	ret = chdir("..");
> >>+	ret = ret;
> >
> >hm? ;-)
> 
> That must be there, otherwise the compiler would complain about unused
> variable 'ret'. When removing 'ret' at all, the compiler complains about
> ignoring return value of 'chdir()'.
> 
> Well, ok, there could be something like:
> 
> if(!ret)
> {
> 		fprintf("FATAL: Cannot cd to ..\n");
> 		return 1;
> }

I dont see a point of having the ret variable at all then..

jirka
