From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 11/36] tools build feature: Check if pthread_barrier_t is
 available
Date: Thu, 7 Dec 2017 08:24:41 -0300
Message-ID: <20171207112441.GB16781@kernel.org>
References: <20171206144115.15097-1-acme@kernel.org>
 <20171206144115.15097-12-acme@kernel.org>
 <CAOFm3uFr62eP7drBcm4U_91qH8=WTC_kd-8XFH7MfEia6gU_Jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752491AbdLGLYo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 7 Dec 2017 06:24:44 -0500
Content-Disposition: inline
In-Reply-To: <CAOFm3uFr62eP7drBcm4U_91qH8=WTC_kd-8XFH7MfEia6gU_Jg@mail.gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>, James Yang <james.yang@arm.com>, Jiri Olsa <jolsa@kernel.org>, Kim Phillips <kim.phillips@arm.com>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

Em Wed, Dec 06, 2017 at 10:31:50PM +0100, Philippe Ombredanne escreveu:
> On Wed, Dec 6, 2017 at 3:40 PM, Arnaldo Carvalho de Melo
> > +++ b/tools/build/feature/test-pthread-barrier.c
> > @@ -0,0 +1,12 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <stdint.h>
> > +#include <pthread.h>

> Arnaldo: for the use of SPDX ids in the hwol patch series, thank you very much.
> Acked-by: Philippe Ombredanne <pombredanne@nexb.com>

Thanks!

- Arnaldo
