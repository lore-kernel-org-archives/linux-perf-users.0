From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] perf report: Fix debug messages with --call-graph
 option
Date: Mon, 25 Sep 2017 10:47:51 -0300
Message-ID: <20170925134751.GO29668@kernel.org>
References: <1506154694-39691-1-git-send-email-zhangmengting@huawei.com>
 <20170925130251.GA20935@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934381AbdIYNrx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Sep 2017 09:47:53 -0400
Content-Disposition: inline
In-Reply-To: <20170925130251.GA20935@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Mengting Zhang <zhangmengting@huawei.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, alexander.shishkin@linux.intel.com, yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org, namhyung@kernel.org, kjlx@templeofstupid.com, milian.wolff@kdab.com, wangnan0@huawei.com, huawei.libin@huawei.com

Em Mon, Sep 25, 2017 at 03:02:51PM +0200, Jiri Olsa escreveu:
> On Sat, Sep 23, 2017 at 04:18:14PM +0800, Mengting Zhang wrote:
> > The patch fixes this issue by moving the warning out of the function
> > parse_callchain_{mode,order,sort_key,value}.
> > 
> > Signed-off-by: Mengting Zhang <zhangmengting@huawei.com>
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, tested and queued for perf/urgent.

- Arnaldo
