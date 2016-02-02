From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: User defined metrics for perf stat?
Date: Tue, 2 Feb 2016 09:58:02 +0100
Message-ID: <20160202085802.GA4257@krava.brq.redhat.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <20160201171540.GB20817@kernel.org>
 <20160201172755.GA27366@krava.redhat.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55761 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754356AbcBBI6G (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 2 Feb 2016 03:58:06 -0500
Content-Disposition: inline
In-Reply-To: <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andreas Hollmann <hollmann@in.tum.de>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Tue, Feb 02, 2016 at 12:33:51AM +0100, Andreas Hollmann wrote:
> Thanks, this is what I was looking for!
> 
> Why was the formula language abandoned? To restricted?
> It would be still useful for interval prints.

yea the python script interface is way more powerful
then whatever we would come with

> 
> perf stat record und perf stat report work,
> but I get with perf script the following output/error. (Kernel 4.4,
> perf 4.5-rc2)
> 
> $ perf script -s scripts/python/stat-cpi.py
> Display of symbols requested but neither sample IP nor sample address
> is selected. Hence, no addresses to convert to symbols.

hum, what was the record command? so I could recreate..

thanks,
jirka
