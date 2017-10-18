From: Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v6 0/6] generate full callchain cursor entries for inlined frames
Date: Wed, 18 Oct 2017 15:43:27 -0700
Message-ID: <87wp3sgjqo.fsf@linux.intel.com>
References: <20171018185350.14893-1-milian.wolff@kdab.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:63098 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750932AbdJRWn2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 18 Oct 2017 18:43:28 -0400
In-Reply-To: <20171018185350.14893-1-milian.wolff@kdab.com> (Milian Wolff's
        message of "Wed, 18 Oct 2017 20:53:44 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: acme@kernel.org, jolsa@kernel.org, namhyung@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:

> This series of patches completely reworks the way inline frames are handled.
> Instead of querying for the inline nodes on-demand in the individual tools,
> we now create proper callchain nodes for inlined frames. The advantages this
> approach brings are numerous:

Except for the comments on the one patch the other patches all look
good to me.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
