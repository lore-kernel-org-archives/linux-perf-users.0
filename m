From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Building perf with clang
Date: Fri, 1 Apr 2016 19:16:02 -0300
Message-ID: <20160401221602.GH7115@kernel.org>
References: <2572584.yi1Xp0m2mb@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35841 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754081AbcDAWQG (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 1 Apr 2016 18:16:06 -0400
Content-Disposition: inline
In-Reply-To: <2572584.yi1Xp0m2mb@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-perf-users@vger.kernel.org

Em Fri, Apr 01, 2016 at 11:19:05PM +0200, Milian Wolff escreveu:
> Hey all,
> 
> I usually use clang to build my code, and have configured CC and CXX globally 
> for that purpose. When I forget to unset that before I run "make" in the perf 
> folder, I get into serious trouble as that is not supported at all.
> 
> So, can that be fixed, either by making perf buildable with clang, or by 
> enforcing GCC within the Makefile if clang is not supported? Or at least error 
> out early if clang would be used?

I never tried, but I have it installed to test perf + BPF, so I'll try
it, fixing things as I go, patches welcome, as I'll start this tomorrow,
at the earliest.

- Arnaldo
