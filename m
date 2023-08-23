Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D5CAEE49A0
	for <linux-perf-users@archiver.kernel.org>; Wed, 23 Aug 2023 11:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233622AbjHWLg6 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 23 Aug 2023 07:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233297AbjHWLg5 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 23 Aug 2023 07:36:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84998E5D
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 04:36:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122B565F4E
        for <linux-perf-users@vger.kernel.org>; Wed, 23 Aug 2023 11:36:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D3AC433C7;
        Wed, 23 Aug 2023 11:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692790611;
        bh=o8vy5BJWPXwe5Sc85tpSC7movFesjnPX1nkI7u08f4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRMYYoyjlauIdmlFOtqgAgHEYpVyKhSaIG0wbfmOoEesPPa0Iqlksw5ktSZIoUiql
         tT+JQu6IIiG+2KF9x031McSW+wOXRbXMC6oKT9z95Nl19dp1tZbF+38+IWXOKgtCXl
         OWc25vNL2gLATzr5V8B6L5zsEDx56CgzfvImp4Zo/9Qx1cpnbGBcsdJgaGN2oUt7LZ
         fX4Geo7smizUI10ROOOdmgYLjSjDnMTaVEOjjLrxQ3BEyv8zBbnKIOxsnawNVz8oUF
         IB+2MjqP1/j3KawHmKRiwYdsng2Z666p0gd6usdBlKxYL/S/DpcwOtELkGamnCAce3
         6RX0Z0bQIeNbA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1191040722; Wed, 23 Aug 2023 08:36:49 -0300 (-03)
Date:   Wed, 23 Aug 2023 08:36:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yanteng Si <siyanteng@loongson.cn>
Cc:     mingo@redhat.com, peterz@infradead.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, irogers@google.com, adrian.hunter@intel.com,
        chenhuacai@kernel.org, linux-perf-users@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn, loongarch@lists.linux.dev
Subject: Re: [PATCH v1 1/2] perf/trace: Fix mmap_flags for archs use generic
 mman.h
Message-ID: <ZOXvUbQL67bdWfNz@kernel.org>
References: <cover.1692694595.git.siyanteng@loongson.cn>
 <03ddc1c0e01518df63aac88e561cd0ec3c1e0028.1692694595.git.siyanteng@loongson.cn>
 <ZOT4Tuc6JGrbDqFW@kernel.org>
 <8ead439a-63aa-434e-9d1e-3b1b05b6347b@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ead439a-63aa-434e-9d1e-3b1b05b6347b@loongson.cn>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Wed, Aug 23, 2023 at 03:11:01PM +0800, Yanteng Si escreveu:
> 
> 在 2023/8/23 02:02, Arnaldo Carvalho de Melo 写道:
> > Em Tue, Aug 22, 2023 at 05:32:06PM +0800, Yanteng Si escreveu:
> > > Silence this warning:
> > > 
> > > grep: /root/linux-next/tools/arch/xxxxx/include/uapi/asm//mman.h:
> > > No such file or directory
> > > Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> > > ---
> > >   tools/perf/trace/beauty/mmap_flags.sh | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
> > > index 3022597c8c17..d035b29fc5ec 100755
> > > --- a/tools/perf/trace/beauty/mmap_flags.sh
> > > +++ b/tools/perf/trace/beauty/mmap_flags.sh
> > > @@ -19,7 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
> > >   printf "static const char *mmap_flags[] = {\n"
> > >   regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> > > -grep -E -q $regex ${arch_mman} && \
> > > +([ -f ${arch_mman} ] && grep -E -q $regex ${arch_mman}) && \
> > >   (grep -E $regex ${arch_mman} | \
> > >   	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
> > >   	xargs printf "\t[ilog2(%s) + 1] = \"%s\",\n#ifndef MAP_%s\n#define MAP_%s %s\n#endif\n")
> > Humm, wouldn't this be simpler without that extra subshell? Like this:
> > 
> > diff --git a/tools/perf/trace/beauty/mmap_flags.sh b/tools/perf/trace/beauty/mmap_flags.sh
> > index 3022597c8c178f21..0ac1886a83b5aceb 100755
> > --- a/tools/perf/trace/beauty/mmap_flags.sh
> > +++ b/tools/perf/trace/beauty/mmap_flags.sh
> > @@ -19,6 +19,7 @@ arch_mman=${arch_header_dir}/mman.h
> >   printf "static const char *mmap_flags[] = {\n"
> >   regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+MAP_([[:alnum:]_]+)[[:space:]]+(0x[[:xdigit:]]+)[[:space:]]*.*'
> > +test -f ${arch_mman} && \
> 
> The following lines have already used the [ ! -f ${arch_mman}, so let's stay
> consistent？

Well, we can make it consistent by simplifying the other places where
the long, equivalent test is being done, which I think is the way to go,
agreed?

- Arnaldo
 
> 
> Thanks,
> 
> Yanteng
> 
> >   grep -E -q $regex ${arch_mman} && \
> >   (grep -E $regex ${arch_mman} | \
> >   	sed -r "s/$regex/\2 \1 \1 \1 \2/g"	| \
> 

-- 

- Arnaldo
