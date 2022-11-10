Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CACA2C433FE
	for <linux-perf-users@archiver.kernel.org>; Thu, 10 Nov 2022 18:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKJShd (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:37:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiKJShb (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 10 Nov 2022 13:37:31 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C1F15FEF
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Nov 2022 10:37:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 60A5CCE2487
        for <linux-perf-users@vger.kernel.org>; Thu, 10 Nov 2022 18:37:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 701B0C433D7;
        Thu, 10 Nov 2022 18:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668105447;
        bh=S6sYlGLdlLsx5U6PB6C1tBSkf5UuJ9wMVebxh8yNMl8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LyPXrNcCWZkapzx/NdnglGruUTLJifd1AL6uu1l4EMCpxU0pDPq9cGvpbeRsAYR+0
         o/OAUqAT7zoT/sPp5qUfXy7El1k8QsEpdkfS1RsT1U6NQjwTbxqYJ5OrKtakzEUE2s
         4QNc8LoGkn5657rPIFbjHcDo7FSdIxdHqX13IDgyAcQoNMK1tbqyvQCp1h8UwWeAsZ
         oHIaxUboMzPofd/vdHbqa9FtyTbLL+xh4Of0x1Zad3nxV0TjUF4Fvo1s/c/M7aTP0a
         JF+k2/cjzEEtQui/Se2Qc400m3l+P+JAvPzXURA8st5riVkpJnIz22XlE2XdJ44mLQ
         LA/DTf35o4z+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 367974034E; Thu, 10 Nov 2022 15:37:25 -0300 (-03)
Date:   Thu, 10 Nov 2022 15:37:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Dmitrii Dolgov <9erthalion6@gmail.com>,
        linux-perf-users@vger.kernel.org, mingo@redhat.com,
        jolsa@kernel.org
Subject: Re: [RFC PATCH v1] perf data: Add fields when converting to json
Message-ID: <Y21E5RpLbBchuOdC@kernel.org>
References: <20221108190019.19265-1-9erthalion6@gmail.com>
 <CAP-5=fXgO4ai5EvsYHw+_F2FUYqBRkBzXuBOZg_wHK0=_ymgFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fXgO4ai5EvsYHw+_F2FUYqBRkBzXuBOZg_wHK0=_ymgFg@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Nov 08, 2022 at 05:35:28PM -0800, Ian Rogers escreveu:
> On Tue, Nov 8, 2022 at 11:00 AM Dmitrii Dolgov <9erthalion6@gmail.com> wrote:
> >
> > When converting recorded data into json format, perf data omits probe
> > variables. Add them to the output in the format "field name": "field value"
> > using tep_print_field:
> >
> >     $ perf data convert --to-json output.json
> >
> >     // output.json
> >     {
> >         "linux-perf-json-version": 1,
> >         "headers": { ... },
> >         "samples": [
> >             {
> >             "timestamp": 29182079082999,
> >             "pid": 309194,
> >                     [...]
> >             "__probe_ip": "0x93ee35",
> >             "query_string_string": "select 2;",
> >             "nxids": "0"
> >             }
> >         ]
> >     }
> >
> > Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
> 
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

