From: Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH v5 11/16] perf report: properly handle branch count in match_chain
Date: Mon, 16 Oct 2017 10:27:41 +0200
Message-ID: <9374748.RpdCs5g2ed@agathebauer>
References: <20171009203310.17362-1-milian.wolff@kdab.com> <20171013140834.GO3503@kernel.org> <5f4372e7-8e75-bf34-3947-4b38036241a4@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kdab.com ([176.9.126.58]:60420 "EHLO mail.kdab.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751196AbdJPI1p (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 Oct 2017 04:27:45 -0400
In-Reply-To: <5f4372e7-8e75-bf34-3947-4b38036241a4@linux.vnet.ibm.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: ravi <ravi.bangoria@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Jin Yao <yao.jin@linux.intel.com>, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, David Ahern <dsahern@gmail.com>, Namhyung Kim <namhyung@kernel.org>, Peter Zijlstra <peterz@infradead.org>

On Montag, 16. Oktober 2017 06:18:17 CEST ravi wrote:
> On Friday 13 October 2017 07:38 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Oct 13, 2017 at 10:39:03AM -0300, Arnaldo Carvalho de Melo 
escreveu:
> >> Em Mon, Oct 09, 2017 at 10:33:05PM +0200, Milian Wolff escreveu:
> >>> Some of the code paths I introduced before returned too early
> >>> without running the code to handle a node's branch count.
> >>> By refactoring match_chain to only have one exit point, this
> >>> can be remedied.
> >> 
> >> Fixing up this one now.
> > 
> > Millian, this is all fresher in your mind, can you please take a look at
> > my perf/core branch and check if the change i made to ]PATCH v5 09/16]
> > "perf report: compare symbol name for inlined frames when matching" is
> > ok wrt Ravi's fix and then, please, rebase v5 on top of what is there?
> > 
> > Ravi, please take a look at this as well, to see if with these changes
> > your fix remains valid, ok?
> 
> Yes Arnaldo, my changes are still valid.
> 
> Milian, Can you please change this patch such that it incorporates dso
> comparison for CCKEY_FUNCTION.

Arnaldo has already done that.

> ( Also, will that be good to change macro to CCKEY_FUNCTION_DOS ?)

Personally, I don't think so. The DSO compare is, imo, just an implementation 
detail.

Cheers

-- 
Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
KDAB (Deutschland) GmbH&Co KG, a KDAB Group company
Tel: +49-30-521325470
KDAB - The Qt Experts
