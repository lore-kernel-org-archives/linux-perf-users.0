From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: User defined metrics for perf stat?
Date: Mon, 1 Feb 2016 18:27:55 +0100
Message-ID: <20160201172755.GA27366@krava.redhat.com>
References: <CAGz0_-1EMt=mBSyrJPSQ_rg4f0tEf+PasAH-4A8sPWDnSm_JPw@mail.gmail.com>
 <20160201171540.GB20817@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47881 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754294AbcBAR16 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 1 Feb 2016 12:27:58 -0500
Content-Disposition: inline
In-Reply-To: <20160201171540.GB20817@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Andreas Hollmann <hollmann@in.tum.de>, Jiri Olsa <jolsa@kernel.org>, "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Mon, Feb 01, 2016 at 02:15:40PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Sun, Jan 31, 2016 at 05:53:49PM +0100, Andreas Hollmann escreveu:
> > Hi,
> > 
> > is there any way to create user defined metrics in perf stat?
> > 
> > Many hardware performance counters make only sense if you relate them
> > to other counters, so it would be nice to have it in perf.
> 
> I think what you want is the 'perf stat recording' feature that was
> recently merged, contributed by Jiri Olsa, that I am CCing this reply.
> Jiri, is there something still to be merged in that series?

heya,
nope.. everything is in ;-)

Andreas,
please check on the series changelog:
  http://marc.info/?l=linux-kernel&m=145207742329050&w=2

it describes the scripting usage together with
stat recording/reporting

let me know if you have other questions,

thanks,
jirka
