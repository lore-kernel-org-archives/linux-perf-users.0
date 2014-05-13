From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: Does perf support different length of user-space hw_breakpoint?
Date: Tue, 13 May 2014 14:00:46 +0200
Message-ID: <20140513120046.GB1138@krava.brq.redhat.com>
References: <53707DD6.2000108@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19566 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759892AbaEMOnz (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Tue, 13 May 2014 10:43:55 -0400
Content-Disposition: inline
In-Reply-To: <53707DD6.2000108@huawei.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: xiakaixu <xiakaixu@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, paulus@samba.org, Ingo Molnar <mingo@kernel.org>, a.p.zijlstra@chello.nl, Arnaldo Carvalho de Melo <acme@kernel.org>, Borislav Petkov <bp@alien8.de>, Namhyung Kim <namhyung@kernel.org>, Huxinwei <huxinwei@huawei.com>, peifeiyue@huawei.com, fweisbec@gmail.com

On Mon, May 12, 2014 at 03:52:54PM +0800, xiakaixu wrote:
> Hi guys,
> 
> Does perf support different length of user-space hw_breakpoint,
> such as  HW_BREAKPOINT_LEN_1/HW_BREAKPOINT_LEN_2/HW_BREAKPOINT_LEN_4/
> HW_BREAKPOINT_LEN_8?
> 
> Seems perf only support HW_BREAKPOINT_LEN_4/sizeof(long)
> by default from the source code and simple test.

right..

        /*
         * We should find a nice way to override the access length
         * Provide some defaults for now
         */
        if (attr.bp_type == HW_BREAKPOINT_X)
                attr.bp_len = sizeof(long);
        else
                attr.bp_len = HW_BREAKPOINT_LEN_4;

> 
> May I have your opinions if I want to trace different bytes of
> hw_breakpoint addr?

I guess that depends on what you want to do ;-)

jirka
