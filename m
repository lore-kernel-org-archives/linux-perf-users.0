From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Problems with perf
Date: Tue, 19 Aug 2014 06:09:14 -0700
Message-ID: <87tx58mxs5.fsf@tassilo.jf.intel.com>
References: <CABooUW2QDE_zRMyNzSEvWMEy+c-yrMvm+rSoASsx7ctBTijvFg@mail.gmail.com>
	<loom.20140818T205057-420@post.gmane.org>
	<loom.20140818T221806-241@post.gmane.org>
	<20140819080852.GA12435@krava.brq.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:21258 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386AbaHSNJx (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 19 Aug 2014 09:09:53 -0400
In-Reply-To: <20140819080852.GA12435@krava.brq.redhat.com> (Jiri Olsa's
	message of "Tue, 19 Aug 2014 10:08:52 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Tommy <tommy24@gatech.edu>, linux-perf-users@vger.kernel.org

Jiri Olsa <jolsa@redhat.com> writes:
> hi,
> we switch off event inheritance for multiple events in group
> with leader sampling. That's probably why you see less samples
> and only one thread. 

If that's the problem then a short term workaround would
be using -a

-Andi
