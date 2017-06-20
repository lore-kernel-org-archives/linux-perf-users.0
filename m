From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2] RFC perf test 14 add platform dependency
Date: Mon, 19 Jun 2017 22:40:36 -0300
Message-ID: <20170620014036.GF13640@kernel.org>
References: <20170613090937.72899-1-tmricht@linux.vnet.ibm.com>
 <20170619205944.GA19183@krava>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbdFTBks (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 19 Jun 2017 21:40:48 -0400
Content-Disposition: inline
In-Reply-To: <20170619205944.GA19183@krava>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Thomas Richter <tmricht@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org

Em Mon, Jun 19, 2017 at 10:59:44PM +0200, Jiri Olsa escreveu:
> On Tue, Jun 13, 2017 at 11:09:37AM +0200, Thomas Richter wrote:
> > This is a proposal to add platform dependency into the
> > test case 14 (perf_event_attr). It is based on a suggestion from
> > Jiri Olsa.
> > Add a new optional attribute named 'machine' in the [config] section
> > of the test case file. It is a comma separated list of architecture
> > names this test can be executed on. For example:
> > 
> > machine = x86_64,alpha,ppc
> 
> 'arch' sounds better to me, but machine is ok I guess

Agreed, for consistency with other places, like in struct machine, that
represents virtual and host 'machines' that have an 'arch', etc.

So better to rename "machine" above to "arch".
 
> > If this attribute is missing the test is executed on any platform.
> > This does not break the current setup.
> > The values listed for this attribute should be identical to
> > uname -m output.
> > If the list starts with an exclamation mark (!) the comparison is
> > inverted, for example for
> > 
> > machine = !s390x,ppc
> > 
> > the test is not executed on s390x or ppc platforms.
> > The exclamation mark must be at the beginnning of the list.
> 
> could that be per arch? this made me think that it's not s390 and it IS for ppc

yeah, having the ! affect just the arch right after it looks more
flexible and clear.
 
> > Here is an example debug output:
> > [root@s35lp76]# fgrep machine tests/attr/test-stat-C2
> > machine = x86_64,alpha,ppc
> > [root@s35lp76]# PERF_TEST_ATTR=/tmp /usr/bin/python2 ./tests/attr.py \
> >   -d ./tests/attr/ -p ./perf -vvvvv -t test-stat-C1
> > 
> > provides the following output:
> > 
> > running './tests/attr//test-stat-C1'
> > test executed only on 'x86_64,alpha,ppc' <--- new
> >   loading expected events
> >     Event event:base-stat
> >       fd = 1
> >       group_fd = -1
> >       .....
> > skipped [s390x] './tests/attr//test-stat-C1' <--- new
> 
> is this mixed output from supported and non supported archs?
> if the arch is skip there's no output other than the skip line right?
> 
> 
> ther than above nits it looks ok to me
> 
> thanks,
> jirka
> --
> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
