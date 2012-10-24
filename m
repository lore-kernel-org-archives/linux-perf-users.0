From: Vince Weaver <vincent.weaver@maine.edu>
Subject: Re: perf and uncore events
Date: Wed, 24 Oct 2012 17:21:00 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210241719510.17832@vincent-weaver-1.um.maine.edu>
References: <alpine.DEB.2.02.1210241627360.1411@vincent-weaver-1.um.maine.edu> <20121024204857.GA1018@krava.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-vc0-f174.google.com ([209.85.220.174]:36430 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161188Ab2JXVUF (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 24 Oct 2012 17:20:05 -0400
Received: by mail-vc0-f174.google.com with SMTP id fk26so1092873vcb.19
        for <linux-perf-users@vger.kernel.org>; Wed, 24 Oct 2012 14:20:04 -0700 (PDT)
In-Reply-To: <20121024204857.GA1018@krava.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: linux-perf-users@vger.kernel.org

On Wed, 24 Oct 2012, Jiri Olsa wrote:
 
> by quick look, it seems you're missing closing '/'
>    ./perf stat -a -e "uncore_imc_0/event=0xff,umask=0x00/" /bin/ls

thanks, that was indeed the problem.  

It would be nice if perf gave a better error message for this, but I guess 
the parsing is tricky enough as it is.

Vince Weaver
vincent.weaver@maine.edu
