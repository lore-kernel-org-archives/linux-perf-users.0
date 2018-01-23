From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH 1/1] perf stat: Add support to print counts for fixed
 times
Date: Tue, 23 Jan 2018 15:24:50 +0100
Message-ID: <20180123142449.GA21721@krava>
References: <1516192645-27187-1-git-send-email-ufo19890607@gmail.com>
 <1516192645-27187-2-git-send-email-ufo19890607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeAWOYy (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 23 Jan 2018 09:24:54 -0500
Content-Disposition: inline
In-Reply-To: <1516192645-27187-2-git-send-email-ufo19890607@gmail.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: ufo19890607 <ufo19890607@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, dsahern@gmail.com, namhyung@kernel.org, milian.wolff@kdab.com, arnaldo.melo@gmail.com, yuzhoujian@didichuxing.com, adrian.hunter@intel.com, wangnan0@huawei.com, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, acme@redhat.com

On Wed, Jan 17, 2018 at 01:37:25PM +0100, ufo19890607 wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> Introduce a new option to print counts for fixed number of times
> and update perf-stat documentation accordingly.
> 
> Show below is the output of the new option for perf stat.
> 
> 	$perf stat -I 1000 --times-print 2 -e cycles -a
>         #           time             counts unit events
>              1.002827089         93,884,870      cycles
>              2.004231506         56,573,446      cycles

you can do that with following command:

[jolsa@krava perf]$ sudo ./perf stat -I 1000 -e cycles -a sleep 2
#           time             counts unit events
     1.000160132        437,471,026      cycles                                                      
     2.000367121        729,415,520      cycles                                                      
     2.000857390          1,407,820      cycles                                                      


jirka
