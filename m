From: Bram Stolk <b.stolk@gmail.com>
Subject: Re: perf utility question: "Sky high iTLB-load-misses"
Date: Thu, 9 Nov 2017 11:12:50 -0800
Message-ID: <CABYXEkuMqU=EXZ8h7x7BK+_rX-fB7SHMNHm4LBV+V7kH2kcQng@mail.gmail.com>
References: <20171108163440.GA10004@redhat.com> <alpine.DEB.2.20.1711081152280.1975@macbook-air>
 <20171109135325.GJ4333@kernel.org> <20171109143838.GY2482@two.firstfloor.org> <20171109185047.GC10004@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ua0-f173.google.com ([209.85.217.173]:52808 "EHLO
        mail-ua0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752637AbdKITMv (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Nov 2017 14:12:51 -0500
Received: by mail-ua0-f173.google.com with SMTP id p33so1551968uag.9
        for <linux-perf-users@vger.kernel.org>; Thu, 09 Nov 2017 11:12:51 -0800 (PST)
In-Reply-To: <20171109185047.GC10004@redhat.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: =?UTF-8?B?SmFuIFBva29ybsO9?= <poki@redhat.com>
Cc: Andi Kleen <andi@firstfloor.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Vince Weaver <vincent.weaver@maine.edu>, Peter Zijlstra <peterz@infradead.org>, linux-perf-users@vger.kernel.org

Vince mentioned that two values are compared which do not relate well.
I would say the two possible approaches would then be:
(1) report absolute numbers only, no percentage.
(2) don't report it.
