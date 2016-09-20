From: Andi Kleen <andi@firstfloor.org>
Subject: Re: reading PMU counts with perf leader sampling and perf script
Date: Tue, 20 Sep 2016 13:16:25 -0700
Message-ID: <8737kupbs6.fsf@tassilo.jf.intel.com>
References: <etPan.57d2cbe0.548515bd.6188@cern.ch>
        <20160912200411.GH4897@kernel.org>
        <etPan.57e15392.6894e226.675c@cern.ch>
        <20160920191953.GF4973@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:57091 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751729AbcITUQ1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 20 Sep 2016 16:16:27 -0400
In-Reply-To: <20160920191953.GF4973@kernel.org> (Arnaldo Carvalho de Melo's
        message of "Tue, 20 Sep 2016 16:19:53 -0300")
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Omar Awile <omar.awile@cern.ch>, Namhyung Kim <namhyung@kernel.org>, David Ahern <dsahern@gmail.com>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>

Arnaldo Carvalho de Melo <acme@kernel.org> writes:

> Em Tue, Sep 20, 2016 at 03:19:47PM +0000, Omar Awile escreveu:
>> Hi Arnaldo,
>  
>> Ah that’s pretty neat. I will try it out. I found perf script really
>> useful to generate properly formatted CSV (after I finally understood
>> how to correctly use it). This might be something worth adding as a
>> feature across all perf tools (stat, report, script). I know that some
>> of the tools can print something kind of CSV, but it’s still just
>> kind-of and not properly formatted, which makes parsing and processing
>
> So, can you provide specific examples of things you think are wrong so
> that we can see if something can be made to improve it?

The main problem is that commas are not quoted (or rather not put into
""), and cpu events have a lot of commas. So -x, tends to output
invalid CSV.

However it generally works well enough with -x; and most CSV tools
can handle that too.

-Andi
