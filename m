Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3ADC433DB
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jan 2021 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B1A0225AB
	for <linux-perf-users@archiver.kernel.org>; Mon, 25 Jan 2021 16:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730806AbhAYQj5 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 25 Jan 2021 11:39:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730600AbhAYQjw (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 25 Jan 2021 11:39:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F82D225AB;
        Mon, 25 Jan 2021 16:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611592751;
        bh=vMUD38Yg0SsfRc0DMiTzjJn/7LThB+u3+w33+LXOenM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g8xxrArqOOO5WZwKKulg5CcIUMZh7KX0zIQF+0YZNPqHZzJs3tbdXhaIXGtOaL5lp
         pK1oRvPQxqyHRRfCSc2+f2fAOMERTII9bGic5pdU1UjcKIFPdtq8XF9E6YvEc3ymxQ
         arQ2z9XacZ8IGxw9oy+mAdQvMGlEZkKQXY2CUL7GcmHhWFtqbJB6vU9DViVQSoyM/V
         b9yj8WzoE+Mmm9MxELAkLvMO7+9/j4cdx2vDgYnuRYiHtgAowwpkYT6ingD1q0FbaE
         K+tZNcPCoLGi4RQz86mm8oHTwWu+mCr+JLbxS3LjnrUln74g+tgTd16RbXhr2cF0dK
         3gxYiEJJstz/Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B57CC40513; Mon, 25 Jan 2021 13:39:06 -0300 (-03)
Date:   Mon, 25 Jan 2021 13:39:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf tools fixes for v5.11, 2nd batch
Message-ID: <20210125163906.GD617095@kernel.org>
References: <20210122135156.608434-1-acme@kernel.org>
 <CAHk-=wjXjWWwOtGv22Edx+hv1od3g_eR+68J+bS93GiKqok15w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXjWWwOtGv22Edx+hv1od3g_eR+68J+bS93GiKqok15w@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Fri, Jan 22, 2021 at 01:59:02PM -0800, Linus Torvalds escreveu:
> On Fri, Jan 22, 2021 at 5:52 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> > Test results in the signed tag at:
 
> Side note: I'd actually prefer if you didn't do this. These big things
> end up being (a hidden) part of the merge commit (and that's how the
> tag verification works after-the-fact: ie I don't just verify the tag
> when I pull, you can also do the verification later), and it really
> makes zero sense to add 28kB of data to each merge just because you
> hid them in the signed tag.
 
> It would actually be better to have it just in the email at the end,
> not in the tag.
 
> Please?

Sure, intention was to record that tests were done and where it was
done, and at the same time not to bother you with test results in the
pull request.

But as you point out and was discussed somewhere else, it doesn't ends
up accessible upstream, so I'll do as you suggest and just leave it in
the cover letter, as I did in the past when submitting to Ingo.

Thanks,

- Arnaldo
