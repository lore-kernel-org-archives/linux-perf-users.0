From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 16/18] tools include uapi: Grab a copy of linux/vhost.h
Date: Wed, 2 Aug 2017 18:44:14 +0300
Message-ID: <20170802184245-mutt-send-email-mst@kernel.org>
References: <20170801195645.16986-1-acme@kernel.org>
 <20170801195645.16986-17-acme@kernel.org>
 <20170802001802-mutt-send-email-mst@kernel.org>
 <20170802141837.GG12201@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51665 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751930AbdHBPoR (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 2 Aug 2017 11:44:17 -0400
Content-Disposition: inline
In-Reply-To: <20170802141837.GG12201@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, David Ahern <dsahern@gmail.com>, Jason Wang <jasowang@redhat.com>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Wang Nan <wangnan0@huawei.com>

On Wed, Aug 02, 2017 at 11:18:37AM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Aug 02, 2017 at 12:19:18AM +0300, Michael S. Tsirkin escreveu:
> > On Tue, Aug 01, 2017 at 04:56:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > From: Arnaldo Carvalho de Melo <acme@redhat.com>
> > > 
> > > We will use it to generate tables for beautifying ioctl's 'cmd' arg.
> > > 
> > > Cc: Adrian Hunter <adrian.hunter@intel.com>
> > > Cc: David Ahern <dsahern@gmail.com>
> > > Cc: Jason Wang <jasowang@redhat.com>
> > > Cc: Jiri Olsa <jolsa@kernel.org>
> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>
> > > Cc: Wang Nan <wangnan0@huawei.com>
> > > Link: http://lkml.kernel.org/n/tip-nxwpq34hu6te1m2ra5m7o8n9@git.kernel.org
> > > Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> > 
> > Is this what tools/perf always does? Isn't there a way
> > to reuse the single header?
> 
> So, that is how we did it at first, we tried to use files from the
> kernel from tools/ directly, and it worked most of the time.
> 
> Shortest summary: We don't want to add to the workload of kernel
> developers, they don't have to care about tools/, if they don't want to.

OK then, thanks for the explanation.

-- 
MST
