Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F3DC32771
	for <linux-perf-users@archiver.kernel.org>; Mon, 26 Sep 2022 20:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbiIZUdH (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiIZUdH (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 26 Sep 2022 16:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F28A4B81
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 13:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A6A361323
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Sep 2022 20:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA92BC433D6;
        Mon, 26 Sep 2022 20:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664224379;
        bh=8UAIStDNONzpPjqOgzzt8D+DVeeNKYymebJCDJEd9gQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ueIdLpp+LGmO31WvmtBhvdq7IL1dn/9N8gctBIi/8YQeqhFIGdxDRc3EXMBKj4Fqt
         23HmUdXNeHQ6TVSSU2Pa2sNNcZRmGVvYY2i3ocZEgycPYAqTuxbLV18NbdSNKCMyc+
         jixIxzqRP0xOPksIZDaVzeDN2aASCGLuPVE4Fd6pbmqgQM5nIlTCn6pocZktR45ahY
         n4FFAk4Zq7Pea3DkgrJBIkX+Sa2Tp35XQZUVhoEMEo1K8z9I2/zkvyubjdDMdSeaSK
         9CdlzkI389qEfFXiMSnqxVkT2NViHpG415nfog4CQvEYkmIWgvkGa7moIqs5hLt2W7
         up+vkFZJNmb7w==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BFCE9403B0; Mon, 26 Sep 2022 21:32:55 +0100 (IST)
Date:   Mon, 26 Sep 2022 21:32:55 +0100
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Shang XiaoJing <shangxiaojing@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 4/4] perf stat: Clean redundant if in process_evlist
Message-ID: <YzIMd85lShkA9e1s@kernel.org>
References: <20220922141438.22487-1-shangxiaojing@huawei.com>
 <20220922141438.22487-5-shangxiaojing@huawei.com>
 <Yyy9jX5vlnUaDa/G@kernel.org>
 <CAP-5=fXPnXVgw_XvqnPpnV4kq_HntQOSdbBVmy7ajjZhJeRi2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXPnXVgw_XvqnPpnV4kq_HntQOSdbBVmy7ajjZhJeRi2g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Sep 22, 2022 at 03:50:40PM -0700, Ian Rogers escreveu:
> On Thu, Sep 22, 2022 at 12:55 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Sep 22, 2022 at 10:14:38PM +0800, Shang XiaoJing escreveu:
> > > Since the first if statment is covered by the following one, clean up
> > > the first if statment.
> > >
> > > Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Thanks,
> Ian
> 
> > > ---
> > >  tools/perf/builtin-stat.c | 2 --
> > >  1 file changed, 2 deletions(-)
> > >
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index e10595f649bc..ccea5d1e053a 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -899,8 +899,6 @@ static int __run_perf_stat(int argc, const char **argv, int run_idx)
> > >               evlist__for_each_cpu(evlist_cpu_itr, evsel_list, affinity) {
> > >                       counter = evlist_cpu_itr.evsel;
> > >
> > > -                     if (!counter->reset_group && !counter->errored)
> > > -                             continue;
> > >                       if (!counter->reset_group)
> > >                               continue;
> >
> > Ian, can you please take a look at this one? You added this in:
> >
> > commit 472832d2c000b9611feaea66fe521055c3dbf17a
> > Author: Ian Rogers <irogers@google.com>
> > Date:   Tue Jan 4 22:13:37 2022 -0800
> >
> >     perf evlist: Refactor evlist__for_each_cpu()
> >
> > >  try_again_reset:
> > > --
> > > 2.17.1
> >
> >
> > - Arnaldo

-- 

- Arnaldo
