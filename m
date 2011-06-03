From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: Not able to profile a 64bit application
Date: Fri, 3 Jun 2011 12:35:45 -0300
Message-ID: <20110603153545.GB23265@ghostprotocols.net>
References: <20110511010305.GA4324@dev1756.snc6.facebook.com>
 <20110602192018.GA21739@ghostprotocols.net>
 <20110602192249.GB21739@ghostprotocols.net>
 <20110602192427.GC21739@ghostprotocols.net>
 <8CB5FB7FBAFD274A8E92A53BBAFE339D0D33F4@039-SN1MPN1-003.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-yi0-f46.google.com ([209.85.218.46]:44566 "EHLO
	mail-yi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab1FCPfy (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Fri, 3 Jun 2011 11:35:54 -0400
Received: by yia27 with SMTP id 27so796864yia.19
        for <linux-perf-users@vger.kernel.org>; Fri, 03 Jun 2011 08:35:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <8CB5FB7FBAFD274A8E92A53BBAFE339D0D33F4@039-SN1MPN1-003.039d.mgd.msft.net>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Kumar Ranjit-B04060 <B04060@freescale.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

Em Fri, Jun 03, 2011 at 09:21:41AM +0000, Kumar Ranjit-B04060 escreveu:

> I am able to do profiling using perf record and report for a 32 bit
> application but for 64 bit application, its not able to resolve the
> symbols.  Anyone faced similar problem??

> I am doing this for e5500 core.

Can you provide some more details?

. Which distro
. readelf -s /path/to/your/64-bit/app output
. elfutils version

should be a good start.

- Arnaldo
