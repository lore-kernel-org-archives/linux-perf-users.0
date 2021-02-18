Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCD9C4332B
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77FB64EB9
	for <linux-perf-users@archiver.kernel.org>; Thu, 18 Feb 2021 19:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhBRTAn (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 18 Feb 2021 14:00:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:39946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233750AbhBRROc (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 18 Feb 2021 12:14:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 439A664E2E;
        Thu, 18 Feb 2021 17:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613668430;
        bh=fuU0xjKZ2fUMkh79septR1upqifwvtb9+Q0YZQEUFV0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FkXxs1v65py/QtZ3r8kTrlOLHWcOgiZL0tv+jRDdmKejI/eosX5vkvmwnwgq1gjbk
         yhwK/vfH8HOAhWs9hw3T+ZkNq28fCPw+OxhQa25raudgLf+9xFgodLe0IvRt5RSLgB
         rT97vaab5qQhwX6L6B3neA9TlotS9slrUybSXcs7kAoNOCRMnCXglLlExWkEOrU6ta
         kA83KChDQBrg7KTZRAirOUY022eR5ZaP52eu3ef1XS0ECHGYqFWi9xIkt4rjaNloQv
         kC0JQY0qjbb+vhNMhCVumzyOiYvnv46OMo7pKkJWfDrOubkyyjoc7z7mBYfhSe694v
         YRO+4P+xiBeEg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 112F040CD9; Thu, 18 Feb 2021 14:13:48 -0300 (-03)
Date:   Thu, 18 Feb 2021 14:13:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Dave Rigby <d.rigby@me.com>
Cc:     linux-perf-users@vger.kernel.org,
        Jan Kratochvil <jan.kratochvil@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] perf unwind: Set userdata for all __report_module paths
Message-ID: <YC6gTCIV+EHNaerJ@kernel.org>
References: <20210218165654.36604-1-d.rigby@me.com>
 <D53872E9-71B0-4F1F-8640-672CE1ABE344@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D53872E9-71B0-4F1F-8640-672CE1ABE344@me.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Thu, Feb 18, 2021 at 04:58:44PM +0000, Dave Rigby escreveu:
> I missed adding a link to the bugzilla issue: https://bugzilla.kernel.org/show_bug.cgi?id=211801
> 
> Note sure what the recommended way of tagging that in the patch is…

I'll add a:

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211801

tag,

Thanks,

- Arnaldo
 
> 
> DaveR
> 
> > On 18 Feb 2021, at 16:56, d.rigby@me.com wrote:
> > 
> > From: Dave Rigby <d.rigby@me.com>
> > 
> > When locating the dwarf module for a given address, __find_debuginfo()
> > requires a 'struct dso' passed via the userdata argument.
> > 
> > However, this field is only set in __report_module() if the module is
> > found in via dwfl_addrmodule(), not if it is found later via dwfl_report_elf().
> > 
> > Set userdata irrespective of how the dwarf module was found, as long
> > as we found a module.
> > 
> > Fixes: bf53fc6b5f41 ("perf unwind: Fix separate debug info files when using elfutils' libdw's unwinder")
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Jan Kratochvil <jan.kratochvil@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > ---
> > tools/perf/util/unwind-libdw.c | 11 ++++++++---
> > 1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
> > index 0ada907..a74b517 100644
> > --- a/tools/perf/util/unwind-libdw.c
> > +++ b/tools/perf/util/unwind-libdw.c
> > @@ -60,10 +60,8 @@ static int __report_module(struct addr_location *al, u64 ip,
> > 	mod = dwfl_addrmodule(ui->dwfl, ip);
> > 	if (mod) {
> > 		Dwarf_Addr s;
> > -		void **userdatap;
> > 
> > -		dwfl_module_info(mod, &userdatap, &s, NULL, NULL, NULL, NULL, NULL);
> > -		*userdatap = dso;
> > +		dwfl_module_info(mod, NULL, &s, NULL, NULL, NULL, NULL, NULL);
> > 		if (s != al->map->start - al->map->pgoff)
> > 			mod = 0;
> > 	}
> > @@ -79,6 +77,13 @@ static int __report_module(struct addr_location *al, u64 ip,
> > 					      al->map->start - al->map->pgoff, false);
> > 	}
> > 
> > +	if (mod) {
> > +		void **userdatap;
> > +
> > +		dwfl_module_info(mod, &userdatap, NULL, NULL, NULL, NULL, NULL, NULL);
> > +		*userdatap = dso;
> > +	}
> > +
> > 	return mod && dwfl_addrmodule(ui->dwfl, ip) == mod ? 0 : -1;
> > }
> > 
> > -- 
> > 1.8.3.1
> 

-- 

- Arnaldo
