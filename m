From: "Vuille, Martin (Martin)" <vmartin@avaya.com>
Subject: RE: Records call-graphs on ARM, reporting on x86_64
Date: Thu, 8 Feb 2018 17:09:44 +0000
Message-ID: <30C2D590D16A5C46ADFE6521910377989262C1A9@AZ-US1EXMB02.global.avaya.com>
References: <30C2D590D16A5C46ADFE6521910377989262C15B@AZ-US1EXMB02.global.avaya.com>
 <2197547.58bztnllri@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from p-us1-iereast-outbound.us1.avaya.com ([135.11.29.13]:63381 "EHLO
        p-us1-iereast-outbound.us1.avaya.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752010AbeBHRJy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 8 Feb 2018 12:09:54 -0500
In-Reply-To: <2197547.58bztnllri@milian-kdab2>
Content-Language: en-US
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

> Afaik this is not yet implemented in perf report when you use libunwind.
> When
> you use elfutils instead of unwinding, it could work if I'm not mistaken.

I rebuilt my host perf with NO_LIBUNWIND=1 to use libdw. I don't see any difference
in the results.
 
> Independently from that, hotspot [1] should support the above usecase just
> fine.

Will give it a try, thanks.
MV
