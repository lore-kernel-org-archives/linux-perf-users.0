From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf and uncore events
Date: Thu, 25 Oct 2012 12:18:11 +0200
Message-ID: <20121025101811.GA995@krava.brq.redhat.com>
References: <alpine.DEB.2.02.1210241627360.1411@vincent-weaver-1.um.maine.edu>
 <20121024204857.GA1018@krava.redhat.com>
 <alpine.DEB.2.02.1210241719510.17832@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39078 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935163Ab2JYKSU (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 25 Oct 2012 06:18:20 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1210241719510.17832@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

On Wed, Oct 24, 2012 at 05:21:00PM -0400, Vince Weaver wrote:
> On Wed, 24 Oct 2012, Jiri Olsa wrote:
>  
> > by quick look, it seems you're missing closing '/'
> >    ./perf stat -a -e "uncore_imc_0/event=0xff,umask=0x00/" /bin/ls
> 
> thanks, that was indeed the problem.  
> 
> It would be nice if perf gave a better error message for this, but I guess 
> the parsing is tricky enough as it is.

it's in om my TODO list ;)

jirka
