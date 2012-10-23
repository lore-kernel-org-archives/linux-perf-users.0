From: David Ahern <dsahern@gmail.com>
Subject: Re: perf top -z not working?
Date: Tue, 23 Oct 2012 10:10:07 -0600
Message-ID: <5086C15F.9020109@gmail.com>
References: <507EA40D.60206@cs.utoronto.ca> <507EB776.9030304@core.kaist.ac.kr> <20121022014618.GA7924@ghostprotocols.net> <50853311.3040707@cs.utoronto.ca> <50854633.30206@gmail.com> <8762617mi6.fsf@sejong.aot.lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:59343 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754731Ab2JWQKN (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 23 Oct 2012 12:10:13 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2858740pad.19
        for <linux-perf-users@vger.kernel.org>; Tue, 23 Oct 2012 09:10:12 -0700 (PDT)
In-Reply-To: <8762617mi6.fsf@sejong.aot.lge.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Ryan Johnson <ryan.johnson@cs.utoronto.ca>, Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Cc: Chulmin Kim <cmkim@core.kaist.ac.kr>, linux-perf-users@vger.kernel.org

took a minute to bisect it this morning:

$ git bisect good
ab81f3fd350c510730adb1ca40ef55c2b2952121 is the first bad commit
commit ab81f3fd350c510730adb1ca40ef55c2b2952121
Author: Arnaldo Carvalho de Melo <acme@redhat.com>
Date:   Wed Oct 5 19:16:15 2011 -0300

     perf top: Reuse the 'report' hist_entry/hists classes

     This actually fixes several problems we had in the old 'perf top':

     1. Unresolved symbols not show, limitation that came from the old
        "KernelTop" codebase, to solve it we would need to do changes
        that would make sym_entry have most of the hist_entry fields.
     2. It was using the number of samples, not the sum of sample->period.

     And brings the --sort code that allows us to have all the views in
     'perf report', for instance:
