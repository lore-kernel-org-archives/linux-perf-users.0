Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3448C48BE8
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Jun 2021 18:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6E0C613DA
	for <linux-perf-users@archiver.kernel.org>; Wed, 16 Jun 2021 18:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhFPSOv (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 16 Jun 2021 14:14:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231648AbhFPSOv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 16 Jun 2021 14:14:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95A07613B9;
        Wed, 16 Jun 2021 18:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623867164;
        bh=FVS8dvAqTX3/2tuOG6nrPzs64bbf6xagc9ZoBuR7k3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tmVFNsJnRGywkjX1WEvwb9a5mDlyUXc1LJr6WzVn3GZSKh+Dhp3QcvszqfIktM5lc
         aUjQirir0bRB5qprx30jE5Qr0Snp9GyBz6sJ6mpOWi+mZUSUnpITbZgiC+s02the4M
         WhwUnhdbd4+7rZZQlc8RcDtXbfy9LxDvn/cAGi4lF2GugY/AtikFhqEtSLh6eaFcQV
         pU5TvQVmP3N4kaMVshWorptFFX7M5gjvgZgEseZy4tBH66LESpkx7BgAOhCauoQBd7
         RVu1HilViuiATmoPWWa4bswrQjqe4E693npltfef50SC3bhlmpGYK1nKLDstWmT3lK
         2GV/kVwM1sVhg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 281C940B1A; Wed, 16 Jun 2021 15:12:42 -0300 (-03)
Date:   Wed, 16 Jun 2021 15:12:42 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf ksymbol: fix memory leak: decrease refcount of
 map and dso
Message-ID: <YMo/GgO78R8YL5WE@kernel.org>
References: <YLpxDf6+YOxYI5z3@kernel.org>
 <20210612173751.188582-1-rickyman7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210612173751.188582-1-rickyman7@gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Sat, Jun 12, 2021 at 07:37:48PM +0200, Riccardo Mancini escreveu:
> ASan reported a memory leak of BPF-related ksymbols
> map and dso. The leak is caused by refount never
> reaching 0, due to missing __put calls in the function
> machine__process_ksymbol_register.
> Once the dso is inserted in the map, dso__put should be
> called (map__new2 increases the refcount to 2).
> The same thing applies for the map when it's inserted
> into maps (maps__insert increases the refcount to 2).

Thanks, applied.

- Arnaldo

 
> $ sudo ./perf record -- sleep 5
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.025 MB perf.data (8 samples) ]
> 
> =================================================================
> ==297735==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 6992 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x8e4e53 in map__new2 /home/user/linux/tools/perf/util/map.c:216:20
>     #2 0x8cf68c in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:778:10
>     [...]
> 
> Indirect leak of 8702 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x8728d7 in dso__new_id /home/user/linux/tools/perf/util/dso.c:1256:20
>     #2 0x872015 in dso__new /home/user/linux/tools/perf/util/dso.c:1295:9
>     #3 0x8cf623 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:774:21
>     [...]
> 
> Indirect leak of 1520 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
>     #2 0x888954 in map__process_kallsym_symbol /home/user/linux/tools/perf/util/symbol.c:710:8
>     [...]
> 
> Indirect leak of 1406 byte(s) in 19 object(s) allocated from:
>     #0 0x4f43c7 in calloc (/home/user/linux/tools/perf/perf+0x4f43c7)
>     #1 0x87b3da in symbol__new /home/user/linux/tools/perf/util/symbol.c:269:23
>     #2 0x8cfbd8 in machine__process_ksymbol_register /home/user/linux/tools/perf/util/machine.c:803:8
>     [...]
> 
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> ---
>  tools/perf/util/machine.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 3ff4936a15a4..da19be7da284 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -776,10 +776,10 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		if (dso) {
>  			dso->kernel = DSO_SPACE__KERNEL;
>  			map = map__new2(0, dso);
> +			dso__put(dso);
>  		}
>  
>  		if (!dso || !map) {
> -			dso__put(dso);
>  			return -ENOMEM;
>  		}
>  
> @@ -792,6 +792,7 @@ static int machine__process_ksymbol_register(struct machine *machine,
>  		map->start = event->ksymbol.addr;
>  		map->end = map->start + event->ksymbol.len;
>  		maps__insert(&machine->kmaps, map);
> +		map__put(map);
>  		dso__set_loaded(dso);
>  
>  		if (is_bpf_image(event->ksymbol.name)) {
> -- 
> 2.23.0
> 

-- 

- Arnaldo
