From: Andi Kleen <andi@firstfloor.org>
Subject: Re: How can I get timestamps of samples in perf
Date: Fri, 09 Aug 2013 21:43:30 -0700
Message-ID: <87li4anojx.fsf@tassilo.jf.intel.com>
References: <CAEuYUeqSbcMiszy-mZBROobsHv1Ohr4n2rVNXr_penhux3Dy4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:43484 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750847Ab3HJEnd (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sat, 10 Aug 2013 00:43:33 -0400
In-Reply-To: <CAEuYUeqSbcMiszy-mZBROobsHv1Ohr4n2rVNXr_penhux3Dy4g@mail.gmail.com>
	(Peipei Wang's message of "Fri, 9 Aug 2013 22:35:13 -0400")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Peipei Wang <wangpeipei.90@gmail.com>
Cc: perf group <linux-perf-users@vger.kernel.org>

Peipei Wang <wangpeipei.90@gmail.com> writes:

> I am trying to understand something about perf record. In its guide,
> perf record could use option -T to generate sample timestamp, and then
> use perf report -D to get them.
>
> However, what I get from perf report -D is something as follows. Does
> anyone have an idea what content of perf.data  means?

Use "perf script" to display the data instead.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
