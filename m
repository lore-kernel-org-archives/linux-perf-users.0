Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC47C4708E
	for <linux-perf-users@archiver.kernel.org>; Mon,  2 Jan 2023 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbjABOqe (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 2 Jan 2023 09:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbjABOqb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 2 Jan 2023 09:46:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EAF910DD;
        Mon,  2 Jan 2023 06:46:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BFC9F60FD9;
        Mon,  2 Jan 2023 14:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1476C433D2;
        Mon,  2 Jan 2023 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672670790;
        bh=ib99j/Xg8KnJRGQY44zZ0IToYbBshf5eDR9ggpXoZDM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1qURN7gOSYA5/0zAam7wEX+Sz9Xh2sdVTIJI5359YPR3xJjJAx6NUFySFl6FMeir
         WIOaA9595wr9WlwptcJv2ZVPKnIJkyy2hfSUzGqfaxkfXpPIxc6eBn+EqUdbM6MyLz
         seku88jAtPupGF82Ob/F13MNKJjw+qLuUwLoZNmCQ5CijtaqJ0t62rgf0x6h+xvarv
         jTO2xxIUuDiyrVVek/WxLxEVRrQpSlnJi2jN8J/V3H+2gzS2XAascPX4qtctz2FYFM
         5fOsGY/t4mCkckoaYYiJj8Zv8jLy2Laj2LJAMuL3hUs5hS/C9gXei9Wi846luqwpbm
         GVnqX0Z1a10YQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D13CF40468; Mon,  2 Jan 2023 11:46:27 -0300 (-03)
Date:   Mon, 2 Jan 2023 11:46:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Miaoqian Lin <linmq006@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: Fix resources leak in perf_data__open_dir
Message-ID: <Y7LuQ/gM9O/EFtvD@kernel.org>
References: <20221229090903.1402395-1-linmq006@gmail.com>
 <d0cf59ae-87c3-3aab-34fa-aa88ea467423@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0cf59ae-87c3-3aab-34fa-aa88ea467423@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Dec 29, 2022 at 01:27:39PM +0200, Adrian Hunter escreveu:
> On 29/12/22 11:09, Miaoqian Lin wrote:
> > In perf_data__open_dir(), opendir() opens the directory stream.
> > Add missing closedir() to release it after use.
> > 
> > Fixes: eb6176709b23 ("perf data: Add perf_data__open_dir_data function")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied.

- Arnaldo

 
> > ---
> >  tools/perf/util/data.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/tools/perf/util/data.c b/tools/perf/util/data.c
> > index a7f68c309545..fc16299c915f 100644
> > --- a/tools/perf/util/data.c
> > +++ b/tools/perf/util/data.c
> > @@ -132,6 +132,7 @@ int perf_data__open_dir(struct perf_data *data)
> >  		file->size = st.st_size;
> >  	}
> >  
> > +	closedir(dir);
> >  	if (!files)
> >  		return -EINVAL;
> >  
> > @@ -140,6 +141,7 @@ int perf_data__open_dir(struct perf_data *data)
> >  	return 0;
> >  
> >  out_err:
> > +	closedir(dir);
> >  	close_dir(files, nr);
> >  	return ret;
> >  }

-- 

- Arnaldo
