From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf parse events: Fix invalid precise_ip handling
Date: Mon, 20 Nov 2017 08:33:41 +0100
Message-ID: <20171120073341.GA5497@krava>
References: <1510302517-33383-1-git-send-email-zhangmengting@huawei.com>
 <20171110103900.GA10233@krava>
 <6dc43edb-0c33-6d82-71a3-3d7cac10a881@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32834 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751061AbdKTHdo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 20 Nov 2017 02:33:44 -0500
Content-Disposition: inline
In-Reply-To: <6dc43edb-0c33-6d82-71a3-3d7cac10a881@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: zhangmengting <zhangmengting@huawei.com>
Cc: namhyung@kernel.org, alexander.shishkin@linux.intel.com, acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, huawei.libin@huawei.com, wangnan0@huawei.com

On Wed, Nov 15, 2017 at 09:00:03AM +0800, zhangmengting wrote:
> Hi Jiri, thanks for your detailed review, please see my comments inline.
> 
> 
> On 2017/11/10 18:39, Jiri Olsa wrote:
> > On Fri, Nov 10, 2017 at 04:28:37PM +0800, Mengting Zhang wrote:
> > 
> > SNIP
> > 
> > > diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> > > index 39b1596..25225f4 100644
> > > --- a/tools/perf/util/parse-events.c
> > > +++ b/tools/perf/util/parse-events.c
> > > @@ -1369,6 +1369,32 @@ struct event_modifier {
> > >   	int pinned;
> > >   };
> > > +static int perf_get_max_precise_ip(void)
> > > +{
> > > +       int max_precise_ip = 0;
> > > +       struct perf_event_attr attr = {
> > > +               .type   = PERF_TYPE_HARDWARE,
> > > +               .config = PERF_COUNT_HW_CPU_CYCLES,
> > > +       };
> > > +
> > > +       event_attr_init(&attr);
> > > +
> > > +       attr.precise_ip = 3;
> > > +       attr.sample_period = 1;
> > > +
> > > +       while (attr.precise_ip != 0) {
> > > +               int fd = sys_perf_event_open(&attr, 0, -1, -1, 0);
> > > +               if (fd != -1){
> > > +                       close(fd);
> > > +                       break;
> > > +               }
> > > +               --attr.precise_ip;
> > > +       }
> > > +       max_precise_ip = attr.precise_ip;
> > > +
> > > +       return max_precise_ip;
> > > +}
> > we already have a function for that, please check perf_event_attr__set_max_precise_ip
> Yeah, I've checked that function. But perf_event_attr__set_max_precise_ip()
> will change attr.precise_ip
> into the max precise ip available.
> 
> In this case, perf should only check whether the user-specified precise_ip
> is greater than the max
> precise_ip without changing it into maximum.  Here, introduce
> perf_get_max_precise_ip() to return
> the max precise ip and do not change attr.precise_ip.
> 
> But you reminds me that perf_get_max_precise_ip() can be simplied.

well both do the same.. probe kernel for max precise level,
so we can keep just one function for that

> > also I think the precise level is not generic for all the events,
> > so you should check it for specific perf_event_attr later, when
> > the attr is ready, not in modifier parsing
> You are right, and I would check it for specific perf_event_attr.
> 
> BTW, I have a question. If the user-specified precise_ip is greater than the
> max precise_ip, I wonder
> whether it is better to adjust the user-specified precise_ip to the maximum
> available.

no, I think that user defined precise level should stay the
way the user wants it.. we don't want more angry users ;-)

jirka
