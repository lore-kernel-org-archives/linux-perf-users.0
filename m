From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: eBPF counters for 'perf stat' e.g.: Re: User defined metrics for
 perf stat?
Date: Wed, 3 Feb 2016 11:18:18 -0300
Message-ID: <20160203141818.GA8193@kernel.org>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <CAGz0_-0k93OvSNgtnDMMTwYWxQuVnABqjfKC-KdmhGqv5H=C3A@mail.gmail.com>
 <20160202085802.GA4257@krava.brq.redhat.com>
 <17343448.BlG9640ky3@milian-kdab2>
 <20160203141157.GB31974@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40503 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752534AbcBCOSX (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 3 Feb 2016 09:18:23 -0500
Content-Disposition: inline
In-Reply-To: <20160203141157.GB31974@krava.brq.redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Wang Nan <wangnan0@huawei.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, Jiri Olsa <jolsa@redhat.com>, Andreas Hollmann <hollmann@in.tum.de>, Jiri Olsa <jolsa@kernel.org>, linux-perf-users@vger.kernel.org

Em Wed, Feb 03, 2016 at 03:11:57PM +0100, Jiri Olsa escreveu:
> On Wed, Feb 03, 2016 at 01:39:20PM +0100, Milian Wolff wrote:
> > How does this compare to the ongoing eBPF effort? Will we be able to do eBPF 
> > based in-kernel aggregation for perf stat in the future?
 
> hum, not sure what you mean by that, however this is
> all user level scripting support to allow user defined
> metrics/ratios from perf counters, more info ine here:
>   http://marc.info/?l=linux-kernel&m=145207742329050&w=2

I would have to check, Wang may help here, but perf has been getting
more and more integrated with the eBPF facilities in place in the
kernel.

To the point that yeah, I think that loading a C program that would hook
somewhere in the kernel and would then create a counter that could be
named and used with perf stat is something I think should even already
be possible if you use what is in Wang's tree, being reviewed to get
upstream, Wang?

- Arnaldo
