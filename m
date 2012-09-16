From: Yuanfang Chen <tabloid.adroit@gmail.com>
Subject: Re: measuring offcore events on snb
Date: Sun, 16 Sep 2012 01:40:18 -0400
Message-ID: <CAN1HeCdqaequeyWcDqETfbkj=jMTwq-eCuiCNK14uAU+EhpqUw@mail.gmail.com>
References: <loom.20120915T194641-95@post.gmane.org>
	<m2txuyyk50.fsf@firstfloor.org>
	<alpine.DEB.2.02.1209152103400.576@pianoman.cluster.toy>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:59717 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab2IPFkT (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Sun, 16 Sep 2012 01:40:19 -0400
Received: by obbuo13 with SMTP id uo13so7883780obb.19
        for <linux-perf-users@vger.kernel.org>; Sat, 15 Sep 2012 22:40:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1209152103400.576@pianoman.cluster.toy>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Vince Weaver <vince@deater.net>
Cc: Andi Kleen <andi@firstfloor.org>, linux-perf-users@vger.kernel.org

On Sat, Sep 15, 2012 at 9:06 PM, Vince Weaver <vince@deater.net> wrote:
> On Sat, 15 Sep 2012, Andi Kleen wrote:
>
>> OFFCORE requires setting an external MSR. perf currently supports this
>> for its integrated events, as the support for setting the MSR directly
>> was not accepted. It works though to write the MSR manually through
>> /dev/cpu/*/msr, as long as you exclude conflicts manually.
>> For details see the Intel SDM.
>
> no, the kernel has had raw offcore response support since 3.3.  It works
> fine.  It's just not easy to get if you use the "perf" tool.  (PAPI and
> libpfm4 support it fine).
>
> as far as I know the only way to do it is to use the rediculous
>    -e cpu/cmask=1,event=2,umask=3,config1=3f80408fff
> format.

just found that commit in git log also. however, even just with perf version of
that commit, I still get 'invalid or unsupported event' error. Have you been
successful using this option?

thanks,
yuanfang

>
> Vince
