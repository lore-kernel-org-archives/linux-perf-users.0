From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: User defined metrics for perf stat?
Date: Wed, 3 Feb 2016 08:48:04 +0100
Message-ID: <20160203074804.GA16045@krava.brq.redhat.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <20160201171540.GB20817@kernel.org>
 <20160201172755.GA27366@krava.redhat.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
 <20160202085802.GA4257@krava.brq.redhat.com>
 <CAGz0_-0HtuVf9XV1NZduHEtwz4nKJb8+Jib6_AksgAdG=pL=TA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36347 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933379AbcBCHsH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Feb 2016 02:48:07 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-0HtuVf9XV1NZduHEtwz4nKJb8+Jib6_AksgAdG=pL=TA@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Tue, Feb 02, 2016 at 05:24:16PM +0100, Andreas Hollmann wrote:
> Jiri, how do you handle raw counters with this python stat__*
> callback? What is the name of the callback?

you can use 'name' term like:
  perf stat -e cycles,"cpu/config=0x6530160,name=krava/"

and use following callback in your script:
  def stat__krava(cpu, thread, time, val, ena, run):

> 
> Is there any documentation on that? Thanks!

no.. ;-)

I'll try to come up with something.. meanwhile please just ask,
I'd be happy to help you

thanks,
jirka
