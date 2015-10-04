From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: Perf Hardware Counters Android
Date: Sun, 4 Oct 2015 17:43:17 -0300
Message-ID: <20151004204317.GG20515@kernel.org>
References: <loom.20150921T094733-948@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36673 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751718AbbJDUnQ (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 4 Oct 2015 16:43:16 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 561A020769
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2015 20:43:15 +0000 (UTC)
Received: from zoo.infradead.org (unknown [181.213.62.138])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A0FA420767
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2015 20:43:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <loom.20150921T094733-948@post.gmane.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Harris <mhmughees@gmail.com>
Cc: linux-perf-users@vger.kernel.org

Em Mon, Sep 21, 2015 at 07:54:49AM +0000, Harris escreveu:
> I have compiled AOSP which includes perf tool. 
> Later I pushed this compiled perf module into 
> production build on my MotoG device. 
> Now I am able to run perf command however perf top 
> command only shows empty layout of table with no entry. 
> Similarly I found I can to record and 
> stat for software events only. 
> While hardware events like "cycles" are not recorded. 
> 
> I wonder if it is not possible to use perf with production
> built android or do I need to configure something.
> Please help me out.

Please tell us the versions of all the components you mentioned, i.e.
what perf tool? What AOSP? What kernel?

- Arnaldo
