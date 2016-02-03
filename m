From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: User defined metrics for perf stat?
Date: Wed, 3 Feb 2016 15:11:57 +0100
Message-ID: <20160203141157.GB31974@krava.brq.redhat.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
 <20160202085802.GA4257@krava.brq.redhat.com>
 <17343448.BlG9640ky3@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37527 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368AbcBCOMB (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Feb 2016 09:12:01 -0500
Content-Disposition: inline
In-Reply-To: <17343448.BlG9640ky3@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: Andreas Hollmann <hollmann@in.tum.de>, Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Wed, Feb 03, 2016 at 01:39:20PM +0100, Milian Wolff wrote:
> On Tuesday, February 2, 2016 9:58:02 AM CET Jiri Olsa wrote:
> > On Tue, Feb 02, 2016 at 12:33:51AM +0100, Andreas Hollmann wrote:
> > > Thanks, this is what I was looking for!
> > > 
> > > Why was the formula language abandoned? To restricted?
> > > It would be still useful for interval prints.
> > 
> > yea the python script interface is way more powerful
> > then whatever we would come with
> 
> How does this compare to the ongoing eBPF effort? Will we be able to do eBPF 
> based in-kernel aggregation for perf stat in the future?

hum, not sure what you mean by that, however this is
all user level scripting support to allow user defined
metrics/ratios from perf counters, more info ine here:
  http://marc.info/?l=linux-kernel&m=145207742329050&w=2

jirka
