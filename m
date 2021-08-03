Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7AAC4338F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 13:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A257160F0F
	for <linux-perf-users@archiver.kernel.org>; Tue,  3 Aug 2021 13:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbhHCNYX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 3 Aug 2021 09:24:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236228AbhHCNYX (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 3 Aug 2021 09:24:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A4BC60EB9;
        Tue,  3 Aug 2021 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627997052;
        bh=o3dWD+NtSdOsjF8zTizWlT8Zz2qjfP7d2UK7eV2zcx4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oJoyztAawT1ekxaSi4QoOSf8H2WrU+IKOIlgDS8KtFz3nQ4oUmlWnfqwAcGPOIgRm
         ixCJbu5S8Xqhh4OAXzLmtnVDiWessoBrsi/L5dQVGv6ki9aYpoPOXy4zSuJA8snbk5
         1lLsiIhsj4Ew57bxMAqaPeM+AyyFVYMFZVC3X+9Ajk+W5GErX4ZQhm2Bim2mWdWZdM
         nhIIz68trv6MAYiVrzQ29JYwY+7/YqP5rQF8L14L3Gd1ITp/PQnA2nN9yuCFvCJX7u
         0zC5DlaLeW8MvuXieoV82mrA7aAhyYQx3G1t8tWe8C9UQ8Q3qL0rA5WZYzaHdFYYsC
         9dEX8IN7OVnOg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2F5E9403F2; Tue,  3 Aug 2021 10:24:09 -0300 (-03)
Date:   Tue, 3 Aug 2021 10:24:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     James Clark <james.clark@arm.com>, mathieu.poirier@linaro.org,
        coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
        suzuki.poulose@arm.com, mike.leach@linaro.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 6/6] perf cs-etm: Add warnings for missing DSOs
Message-ID: <YQlDefz+g45dqFsP@kernel.org>
References: <20210729155805.2830-1-james.clark@arm.com>
 <20210729155805.2830-7-james.clark@arm.com>
 <20210802154145.GC148327@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802154145.GC148327@leoy-ThinkPad-X240s>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Mon, Aug 02, 2021 at 11:41:45PM +0800, Leo Yan escreveu:
> On Thu, Jul 29, 2021 at 04:58:05PM +0100, James Clark wrote:
> > Currently decode will silently fail if no binary data is available for
> > the decode. This is made worse if only partial data is available because
> > the decode will appear to work, but any trace from that missing DSO will
> > silently not be generated.
> > 
> > Add a UI popup once if there is any data missing, and then warn in the
> > bottom left for each individual DSO that's missing.
> > 
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/util/cs-etm.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 32ad92d3e454..e6851260d059 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -746,8 +746,16 @@ static u32 cs_etm__mem_access(struct cs_etm_queue *etmq, u8 trace_chan_id,
> >  
> >  	len = dso__data_read_offset(al.map->dso, machine, offset, buffer, size);
> >  
> > -	if (len <= 0)
> > +	if (len <= 0) {
> > +		ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n");
> > +		if (!al.map->dso->auxtrace_warned) {
> > +			pr_err("CS ETM Trace: Debug data not found for address %#"PRIx64" in %s\n",
> > +				    address,
> > +				    al.map->dso->long_name ? al.map->dso->long_name : "Unknown");
> > +			al.map->dso->auxtrace_warned = true;
> > +		}
> 
> This is very useful.
> 
> Just one comment: in particularly if the perf fails to find the kernel
> symbols, the user needs to enable config "CONFIG_PROC_KCORE=y" or
> specify option "-k /path/to/vmlinux".  In this case, using 'perf
> archive' is not helpful.  So I think the UI warning can be imporved
> like:
> 
>         ui__warning_once("CS ETM Trace: Missing DSO. Use 'perf archive' to export data from the traced system.\n"
>                          " Enable CONFIG_PROC_KCORE or use option '-k /path/to/vmlinux' for kernel symbols\n");

one can also use debuginfod-client, which, as time passes, probably will
be the main way of finding DSOs now that we have build-ids in
PERF_RECORD_MMAP2 and debuginfod servers such as:

export DEBUGINFOD_URLS=https://debuginfod.fedoraproject.org/

https://fedoraproject.org/wiki/Debuginfod
 
> With this improvement, the patch looks good to me:
> 
> Reviewed-by: Leo Yan <leo.yan@linaro.org>

Does this apply to the other 5 patches in this series?

- Arnaldo
 
> >  		return 0;
> > +	}
> >  
> >  	return len;
> >  }
> > -- 
> > 2.28.0
> > 

-- 

- Arnaldo
