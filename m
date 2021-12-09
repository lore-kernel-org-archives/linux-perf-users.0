Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0094C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Dec 2021 10:47:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232745AbhLIKv2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Dec 2021 05:51:28 -0500
Received: from foss.arm.com ([217.140.110.172]:53964 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231618AbhLIKv2 (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Dec 2021 05:51:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B506411FB;
        Thu,  9 Dec 2021 02:47:54 -0800 (PST)
Received: from [10.57.33.188] (unknown [10.57.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 364113F73B;
        Thu,  9 Dec 2021 02:47:54 -0800 (PST)
Subject: Re: perf probe: adding probe on C++ member/namespace function or
 versioned symbols
To:     Milian Wolff <milian.wolff@kdab.com>,
        linux-perf-users@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kenel.org>
References: <2119579.vFYbnVOWES@milian-workstation>
From:   James Clark <james.clark@arm.com>
Message-ID: <d2ddc34f-3825-4b95-e6d3-fd25604b6867@arm.com>
Date:   Thu, 9 Dec 2021 10:47:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2119579.vFYbnVOWES@milian-workstation>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 08/12/2021 20:08, Milian Wolff wrote:
> Hey there,
> 
> how can one escape function names for `perf probe`? It seems like the current 
> parser is confused by the `:` which is common in C++ symbol names.
> 
> ```
> $ perf probe -F --exec /usr/lib/libQt5Widgets.so | grep syncBacking
> QWidgetPrivate::syncBackingStore
> QWidgetPrivate::syncBackingStore

It might not be obvious, but you have to get the mangled name with 'nm -D',
and then pass the mangled name with --no-demangle to perf and then it works:

  sudo ./perf probe --no-demangle --exec libQt5Widgets.so.5 --add '_ZN14QWidgetPrivate16syncBackingStoreEv'

Maybe the docs could be updated to make it clearer, or print a warning message, or
get perf to output mangled symbols in addition to demangled with -F.


> 
> $ perf probe --exec /usr/lib/libQt5Widgets.so --add 
> QWidgetPrivate::syncBackingStore
> Semantic error :There is non-digit char in line number.
> ...
> ```
> 
> Additionally, it is also not possible to pass a versioned symbol either:
> ```
> $ nm -aD /usr/lib/libQt5Widgets.so | grep syncBacking
> 0000000000197480 T 
> _ZN14QWidgetPrivate16syncBackingStoreERK7QRegion@@Qt_5_PRIVATE_API
> 00000000001973b0 T _ZN14QWidgetPrivate16syncBackingStoreEv@@Qt_5_PRIVATE_API
> Semantic error :SRC@SRC is not allowed.

If adding mangling fix doesn't work for this one, you could try removing some of
the name processing in probe-event.c like:

	/* Cut off the dot suffixes (e.g. .const, .isra) and version suffixes */
	p = strpbrk(nbase, ".@");
	if (p && p != nbase)
		*p = '\0';

> ...
> ```
> 
> Is there a workaround available for this?
> 
> Thanks
> 
