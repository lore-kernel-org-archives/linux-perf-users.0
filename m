From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: perf and uncore events
Date: Wed, 24 Oct 2012 22:48:57 +0200
Message-ID: <20121024204857.GA1018@krava.redhat.com>
References: <alpine.DEB.2.02.1210241627360.1411@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15497 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757672Ab2JXUtF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Oct 2012 16:49:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1210241627360.1411@vincent-weaver-1.um.maine.edu>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-perf-users@vger.kernel.org

On Wed, Oct 24, 2012 at 04:32:00PM -0400, Vince Weaver wrote:
> 
> So has anyone actually ever used perf to measure uncore events?
> 
> I have a 3.6 kernel on a Sandybridge machine and the uncore directories
> definitely show up in 
>   /sys/bus/event_source/devices/
> 
> But if I try
>    ./perf stat -a -e "uncore_imc_0/event=0xff,umask=0x00" /bin/ls
> I get:
> invalid or unsupported event: 'uncore_imc_0/event=0xff,umask=0x00'
> Run 'perf list' for a list of valid events
> [...]

by quick look, it seems you're missing closing '/'
   ./perf stat -a -e "uncore_imc_0/event=0xff,umask=0x00/" /bin/ls

jirka
