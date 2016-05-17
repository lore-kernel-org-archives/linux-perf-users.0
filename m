From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: perf trace: Problems initializing symbol libraries!
Date: Tue, 17 May 2016 12:06:17 -0300
Message-ID: <20160517150617.GA28790@kernel.org>
References: <2323271.hRPH2PSKxc@milian-kdab2>
 <1849423.FYp0BrzLMo@agathebauer>
 <20160516201359.GB3455@kernel.org>
 <27102286.6frB0TEpAH@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43288 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752785AbcEQPGV (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 17 May 2016 11:06:21 -0400
Content-Disposition: inline
In-Reply-To: <27102286.6frB0TEpAH@milian-kdab2>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Tue, May 17, 2016 at 09:51:44AM +0200, Milian Wolff escreveu:
> On Monday, May 16, 2016 5:13:59 PM CEST Arnaldo Carvalho de Melo wrote:
> > So, the problem is not with what is in my perf/core branch, its that ubuntu
> > 16.04's kernel comes with kptr_restrict defaulting to 1, I have to get that
> > warning emitted by 'perf record' into 'perf trace'.
 
> that makes it work for me. I'll include the line to set kptr_restrict to 0 
> into my "perf init" script that elevates the restrictions.

That will not be strictly needed with what I have now on my perf/core
branch, where it will just warn the user if/when symbol resolution is
needed and kptr_restrict=1.

Thanks for the report, tested on fedora 23 with kptr_restrict set to 1
and then again on ubuntu 16.04, default kernel sysctl values.

- Arnaldo
