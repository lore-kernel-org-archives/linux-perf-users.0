From: Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v2] perf report: distinguish between inliners in the same
 function
Date: Mon, 8 May 2017 13:17:11 -0300
Message-ID: <20170508161711.GL2222@redhat.com>
References: <20170503213536.13905-1-milian.wolff@kdab.com>
 <11256670.HWKrRQARBr@agathebauer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58917 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750876AbdEHQRP (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 8 May 2017 12:17:15 -0400
Content-Disposition: inline
In-Reply-To: <11256670.HWKrRQARBr@agathebauer>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Yao Jin <yao.jin@linux.intel.com>

Em Mon, May 08, 2017 at 10:45:18AM +0200, Milian Wolff escreveu:
> On Mittwoch, 3. Mai 2017 23:35:36 CEST Milian Wolff wrote:
> > When different functions get inlined into the same function, we
> > want to show them individually in the reports. But when we group by
> > function, we would aggregate all IPs and would only keep the first
> > one in that function. E.g. for C++ code like the following:

<SNIP>

> Ping? Any chance that I could get a review on this one please? It works really 
> well for me and greatly improves perf's usability for C++ code bases.

yeah, indeed that would be great to have someone reviewing this,

- Arnaldo
