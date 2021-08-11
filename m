Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51390C4338F
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:09:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300C560EB9
	for <linux-perf-users@archiver.kernel.org>; Wed, 11 Aug 2021 19:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhHKTJy (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbhHKTJx (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 11 Aug 2021 15:09:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0D4C60F21;
        Wed, 11 Aug 2021 19:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628708969;
        bh=vUEiqMDOgegvrF85jfSJPR40TzW+3TCm5rt5o8ByeHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ux7G78V8M1YuE8+Eg1zPvYws2EAKmPeiSULwqbN0tkAPJihNdk9ME4tJLkxFVfcUi
         oCXLSiR6h+pg/MxoKc9kcxHJVdsLqUZNIJwb8PsyZF65O1TW3Vj5TtOIlAiDHR94aI
         htcw8PK2/2HWUDbPWe6PXS8tK8652u8+OQ5rJlqrIQIqUPoEqQoL9wxj+5o4pa529D
         nrznQfNeu/2oHkJhdClkc5CJBUCvqbDoLmM504Tsz/70m7Oim+mAEU2fkuUu07Fdpc
         yVix4qqP95n8shPOxIOmz+mcNMzQG8FuDbQJNy5qQnr8xRJspGNLAdydl66HcaPtvd
         j1cN+DOymrbKg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1F8F4403F2; Wed, 11 Aug 2021 16:09:26 -0300 (-03)
Date:   Wed, 11 Aug 2021 16:09:26 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v4 0/3] perf tool: Enable cpu list for hybrid
Message-ID: <YRQgZsFtMiuw9HIo@kernel.org>
References: <20210723063433.7318-1-yao.jin@linux.intel.com>
 <YRQebER3uDUkJogC@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRQebER3uDUkJogC@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 11, 2021 at 09:01:00PM +0200, Jiri Olsa escreveu:
> On Fri, Jul 23, 2021 at 02:34:30PM +0800, Jin Yao wrote:
> > The perf-record and perf-stat have supported the option '-C/--cpus'
> > to count or collect only on the list of CPUs provided. This option
> > needs to be supported for hybrid as well.
> > 
> > v4:
> > ---
> > Rename evlist__use_cpu_list to evlist__fix_hybrid_cpus
> > Add comments to evlist__fix_hybrid_cpus.
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Thanks, applied.

- Arnaldo

