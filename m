From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: perf record regression?
Date: Thu, 10 Mar 2011 11:49:28 -0300
Message-ID: <20110310144927.GF14438@ghostprotocols.net>
References: <AANLkTikcz=_HX7Ws2Ojmky+JgQhk1cj2YW=uxSkYkXBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:24388 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137Ab1CJOtk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 10 Mar 2011 09:49:40 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTikcz=_HX7Ws2Ojmky+JgQhk1cj2YW=uxSkYkXBQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arun Sharma <arun@sharma-home.net>
Cc: linux-perf-users@vger.kernel.org

Em Wed, Mar 09, 2011 at 09:59:39PM -0800, Arun Sharma escreveu:
> I pulled the perf/core branch in
> git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux-2.6.git today
> and found that:
> 
> perf record -ag -- sleep 1
> perf report -D | grep dso:
> 
> was returning:
> 
>  ...... dso: <not found>
>  ...... dso: <not found>
>  ...... dso: /boot/vmlinux-2.6.38-rc5+
> 
> i.e perf report was not able to map IP addresses to the correct dso
> for anything in user space.
> 
> Using git bisect, I narrowed it down to these two commits:
> 
> commit f60686f71f4afec7b2925b4682f33c70c0a7eb17
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Wed Mar 9 07:48:24 2011 -0300
> 
>     perf evsel: Assume rest of perf_header_attr functions
> 
> commit e62e48df064b431029658089ab1f8b529ff6da3d
> Author: Arnaldo Carvalho de Melo <acme@redhat.com>
> Date:   Tue Mar 8 09:05:57 2011 -0300
> 
>     perf session: Simplify evlist creation from perf.data header
> 
> perf built after these commits is able to symbolize properly for
> perf.data collected using an older version of perf. So I believe, the
> perf report side of things are ok. But perf record is not.

Thanks for bisecting, I noticed some problems yesterday and was trying
to bisect it, but run into another bug, will investigate now.

- Arnaldo
