From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Cost in sym vs. sym@plt
Date: Wed, 31 Aug 2016 09:51:06 -0700
Message-ID: <8760qgrif9.fsf@tassilo.jf.intel.com>
References: <2472727.a3qg7mcsuX@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:38976 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935292AbcHaQvg (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 31 Aug 2016 12:51:36 -0400
In-Reply-To: <2472727.a3qg7mcsuX@milian-kdab2> (Milian Wolff's message of
        "Tue, 30 Aug 2016 13:54:53 +0200")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
Cc: linux-perf-users@vger.kernel.org

Milian Wolff <milian.wolff@kdab.com> writes:
>
> I'm asking, because I did not expect the cost of the @plt to be that large. Is 
> this maybe due to skid? I doubt that, since the above is from a cycles:ppp 
> profile on an Intel Haswell i5, which is supposedly accurate.

There's no such thing as fully accurate profiling.

-Andi
