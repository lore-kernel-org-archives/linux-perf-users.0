Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964DFC433C1
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69CF4619D1
	for <linux-perf-users@archiver.kernel.org>; Tue, 30 Mar 2021 18:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbhC3SYA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:43816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232793AbhC3SXv (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 30 Mar 2021 14:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 49A8C60241;
        Tue, 30 Mar 2021 18:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617128631;
        bh=Yiw4tRxmxPRSB/D+IKwL8DgVjXMbmmaBGHZStoIUVHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVydiRaruAEdhngBvYhuW61k70bNTXVUPMawDCo1FqqIBh5ZZojnjweATSgeUkQwy
         YhvkN48MbLZyks9ZRuhP7hVCsHDK5l8flZjEMyAX7whwgXcsnUvethjjrZfZ32eP89
         KqiqCDb+mxLMzUcS5E87+f18FEiwmwt+iNoafKoQfUmXQomsq5dG7JJRde1JNaMFE/
         vPzjO1NxAsCv52hvqL+ld5SzHklGaPba4+5HuaRzuzGAMdipnDHYxTdLOS8XNVp5Iz
         DzFwjXtEVkCP0okOoBSfApv4gLMeUHjcvn4YmTvA81jZ7Vq485UJsctOVOMI2PHr9z
         JUBPtiCt3CajA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0D58140647; Tue, 30 Mar 2021 15:23:48 -0300 (-03)
Date:   Tue, 30 Mar 2021 15:23:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Martin =?utf-8?B?TGnFoWth?= <mliska@suse.cz>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf annotate: add --demangle and --demangle-kernel
Message-ID: <YGNstDqBbh2/alvf@kernel.org>
References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
 <YDVcZJscuKIgShsm@kernel.org>
 <a2349b3e-b3e2-f979-6bc5-a2cffbdd2d6a@suse.cz>
 <cad07055-620e-f0ce-9af2-a8a794bc47aa@suse.cz>
 <71d26f15-f0e8-adca-1e7c-46effcba913a@suse.cz>
 <YGNG9PLKEniErXwy@kernel.org>
 <2327ca98-f2ee-3a9a-0e24-d52fc90bcf9b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2327ca98-f2ee-3a9a-0e24-d52fc90bcf9b@suse.cz>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Em Tue, Mar 30, 2021 at 08:19:10PM +0200, Martin Liška escreveu:
> On 3/30/21 5:42 PM, Arnaldo Carvalho de Melo wrote:
> > Trying to find V2

You said you would resend fixing up this:

+	OPT_BOOLEAN(0, "demangle", &symbol_conf.demangle,
+		    "Disable symbol demangling"),
                     ^^^^^^^



+	OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
+		    "Enable kernel symbol demangling"),
 
> It's this email:
> https://lore.kernel.org/lkml/deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz/
> 
> Subject: Re: [PATCH] perf config: add annotate.demangle{,_kernel}
> From:   =?UTF-8?Q?Martin_Li=c5=a1ka?= <mliska@suse.cz>
> To:     Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
> References: <deb2af9e-25dd-ac72-29f4-ab90c2b24237@suse.cz>
>  <YDVcZJscuKIgShsm@kernel.org> <a4e687b9-f611-1b24-ae7c-2ecd93c42ea8@suse.cz>
> Message-ID: <c96aabe7-791f-9503-295f-3147a9d19b60@suse.cz>
> Date:   Fri, 26 Feb 2021 11:08:12 +0100
> 
> 
> Cheers,
> Martin

-- 

- Arnaldo
