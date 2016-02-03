From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: User defined metrics for perf stat?
Date: Wed, 3 Feb 2016 15:09:57 +0100
Message-ID: <20160203140957.GA31974@krava.brq.redhat.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <20160201171540.GB20817@kernel.org>
 <20160201172755.GA27366@krava.redhat.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
 <20160202085802.GA4257@krava.brq.redhat.com>
 <CAGz0_-0HtuVf9XV1NZduHEtwz4nKJb8+Jib6_AksgAdG=pL=TA@mail.gmail.com>
 <20160203074804.GA16045@krava.brq.redhat.com>
 <CAGz0_-31qWb_0B2T_fpBwxGQkeg+PSATPS=uS5Ui1fKc8sVyiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46466 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751824AbcBCOJ7 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Feb 2016 09:09:59 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-31qWb_0B2T_fpBwxGQkeg+PSATPS=uS5Ui1fKc8sVyiQ@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Feb 03, 2016 at 12:43:48PM +0100, Andreas Hollmann wrote:
> Thanks! Now it works.
> 
> Are there any other callbacks specific to the new functionality?
> 
> I saw this:
> 
> def stat__interval(time):
>    ...
> 
> The name suggests that it is called once for each interval event entry?
> 
> Anything else?

there was explanation in one of the patch changelogs, attached
I'll make it appear in some doc soon

> 
> Would it make sense to extend "perf script -g" to generate the callbacks?

yep, I thought about that.. will make it happen ;-)

thanks,
jirka


---
Add support to get stat events data in perf python scripts.

The python script shall implement following
new interface to process stat data:

  def stat__<event_name>_[<modifier>](cpu, thread, time, val, ena, run):

    - is called for every stat event for given counter,
      if user monitors 'cycles,instructions:u" following
      callbacks should be defined:

      def stat__cycles(cpu, thread, time, val, ena, run):
      def stat__instructions_u(cpu, thread, time, val, ena, run):

  def stat__interval(time):

    - is called for every interval with its time,
      in non interval mode it's called after last
      stat event with total measured time in ns

The rest of the current interface stays untouched..

Please check example CPI metrics script in following patch
with command line examples in changelogs.
