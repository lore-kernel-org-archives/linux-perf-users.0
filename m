From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v6 0/6] generate full callchain cursor entries for
 inlined frames
Date: Fri, 20 Oct 2017 12:43:04 -0300
Message-ID: <20171020154304.GF30002@kernel.org>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
 <87wp3sgjqo.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751857AbdJTPnH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 20 Oct 2017 11:43:07 -0400
Content-Disposition: inline
In-Reply-To: <87wp3sgjqo.fsf@linux.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: Milian Wolff <milian.wolff@kdab.com>, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Em Wed, Oct 18, 2017 at 03:43:27PM -0700, Andi Kleen escreveu:
> Milian Wolff <milian.wolff@kdab.com> writes:
> 
> > This series of patches completely reworks the way inline frames are handled.
> > Instead of querying for the inline nodes on-demand in the individual tools,
> > we now create proper callchain nodes for inlined frames. The advantages this
> > approach brings are numerous:
> 
> Except for the comments on the one patch the other patches all look
> good to me.

I think I addressed this concern by always using absolute addresses,
right?
 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>

So I'm adding this to the patches, ok?

- Arnaldo
