From: Vince Weaver <vince@deater.net>
Subject: Re: Perf feature?
Date: Tue, 26 Mar 2013 14:02:08 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1303261358560.9710@pianoman.cluster.toy>
References: <CAG=jzgBF7qVc4LE=cMrMp3+_8h8HuRaMi3OHn510vJSGd1YN-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from fbr03.mfg.siteprotect.com ([64.26.60.138]:53895 "EHLO
	fbr03.mfg.siteprotect.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300Ab3CZSKE (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 26 Mar 2013 14:10:04 -0400
Received: from smtpauth05.mfg.siteprotect.com (unknown [192.168.33.144])
	by fbr03.mfg.siteprotect.com (Postfix) with ESMTP id F344B880CC3
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Mar 2013 13:02:33 -0500 (CDT)
In-Reply-To: <CAG=jzgBF7qVc4LE=cMrMp3+_8h8HuRaMi3OHn510vJSGd1YN-w@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: kernel kernel <kernel@kenobrien.org>
Cc: linux-perf-users@vger.kernel.org

On Tue, 26 Mar 2013, kernel kernel wrote:

> Is it possible to use perf to record the performance counters of
> specific lines of code instead of the entire program?

If you want exact counts (i.e., these three lines of code had exactly 
20 branch misses) you'll need to instrument your code using a library like 
PAPI, or else insert raw perf_event calls yourself before and after 
the lines of interest (see the example at the end of the perf_event_open 
manpage).

Doing self-monitoring like this introduces a certain amount of overhead 
into your program and measurements.

Vince
