From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf parse events: Fix invalid precise_ip handling
Date: Tue, 21 Nov 2017 16:23:57 +0100
Message-ID: <20171121152357.GN20440@krava>
References: <1510302517-33383-1-git-send-email-zhangmengting@huawei.com>
 <20171110103900.GA10233@krava>
 <6dc43edb-0c33-6d82-71a3-3d7cac10a881@huawei.com>
 <20171120073341.GA5497@krava>
 <1a249a21-5e93-7434-8b6f-08241513dceb@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1a249a21-5e93-7434-8b6f-08241513dceb@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: zhangmengting <zhangmengting@huawei.com>
Cc: namhyung@kernel.org, alexander.shishkin@linux.intel.com, acme@kernel.org, Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, huawei.libin@huawei.com, wangnan0@huawei.com
List-Id: linux-perf-users.vger.kernel.org

On Tue, Nov 21, 2017 at 04:30:09PM +0800, zhangmengting wrote:

SNIP

> > > > also I think the precise level is not generic for all the events,
> > > > so you should check it for specific perf_event_attr later, when
> > > > the attr is ready, not in modifier parsing
> > > You are right, and I would check it for specific perf_event_attr.
> > > 
> > > BTW, I have a question. If the user-specified precise_ip is greater than the
> > > max precise_ip, I wonder
> > > whether it is better to adjust the user-specified precise_ip to the maximum
> > > available.
> > no, I think that user defined precise level should stay the
> > way the user wants it.. we don't want more angry users ;-)
> 
> Humm, I am sorry for being unclear.
> If the user defined precise level is greater than the max precise level,
> I think there are two ways to deal with it.
> 1.  return EINVAL to indicate the invalid precise_ip setting;

and warn user about the reason

> 2.  adjust to the max precise level available and give message to indicate
> the adjustment.

we do that (or should) only if the precise_ip is not defined by user
because we want the max precise level by default

> Since we should check user-defined precise level in perf_evsel__config(),
> when the attr is ready, I think there is a problem with method 1, if we keep
> the
> user defined precise level stay the way the user wants it.
> 
> With method 1, we have to let perf_evsel__config() return value and show
> errno.
> And this change will affect many related functions, such as
> perf_evlist__config(), and files.
> 
> With method 2, we don't need to change the return type of
> perf_evsel__config().
> 
> Am I right?

not sure.. let's discuss over the code changes

jirka
