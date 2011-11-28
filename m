From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [PATCH 7/7] event: add tracepoint for accounting block time
Date: Mon, 28 Nov 2011 06:43:35 -0800
Message-ID: <4ED39E17.7050807@linux.intel.com>
References: <1322471015-107825-1-git-send-email-avagin@openvz.org> <1322471015-107825-8-git-send-email-avagin@openvz.org> <1322480531.2921.107.camel@twins> <4ED39473.9080600@linux.intel.com> <20111128143140.GA12377@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:57186 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878Ab1K1Onk (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Mon, 28 Nov 2011 09:43:40 -0500
In-Reply-To: <20111128143140.GA12377@infradead.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@infradead.org>
Cc: Peter Zijlstra <a.p.zijlstra@chello.nl>, Robert Richter <robert.richter@amd.com>, Andrew Vagin <avagin@openvz.org>, linux-kernel@vger.kernel.org, paulus@samba.org, mingo@elte.hu, asharma@fb.com, devel@openvz.org, dsahern@gmail.com, linux-perf-users@vger.kernel.org

> 
> perf_evlist is what you call perf_bundle and perf_evsel is what you call
> perf_event in powertop.
> 
> That part of the API should be ok for wider use and is in fact exported
> in the python binding.

I don't care about the snake language.

frankly all that's missing is a "safe" accessor library as Steve has
promised will appear.

that library really needs to be a proper shared library and not come
from/with the kernel package, so that distributions can independently
package it properly.
(and this obviously needs to at least look at the things that the
systemd guys pointed us at at the kernel summit)

I'm not interested if the code for a library is somewhere deep in the
kernel source code, not installed by default in distros (or tied in with
loads of other mess) and/or uses the kernel makefiles/etc like perf does.
