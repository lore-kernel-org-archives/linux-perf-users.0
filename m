Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B0EC64EC4
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Mar 2023 09:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjCIJ41 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 9 Mar 2023 04:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230362AbjCIJ4Y (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 9 Mar 2023 04:56:24 -0500
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93861A54F5
        for <linux-perf-users@vger.kernel.org>; Thu,  9 Mar 2023 01:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
        bh=pjMNkt2tZMtyk4s9pJ2sylWEzRTvvbuAIVPJQDAbMEM=; b=nPiHhphuiF2wbmGdjKDC5Da28k
        UNB23XX4SINhB1bzPfm+/taZezY94q+NAvoKl5EZjOWG/sy6qYfoboe0OYkV0AqYXj505csipN/Kl
        kKRhcM/qbHhDXGyBYlvoEjSm5wecX/sHEknFcLx6NHQPI0HrXW8KLrGQyReLGpBqyhlrY1D1mCCrI
        aWdE/zzBxwJ5P2VrOLlcBc3y1kpjN3VyKMCXLW65rS9tMTHphZBFUr+sa1oSn0Unw8HxyjFExJ+2a
        JyHCPR0cLoFjnTTQP0t5Nr71N0K4hC3S/H5gAl/z4Yofm4ewzGCO6CO6fBB/sZn1mfnwc/800/g3G
        EvaR6aXA==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <daniel@iogearbox.net>)
        id 1paD0P-0007YW-Ab; Thu, 09 Mar 2023 10:56:13 +0100
Received: from [81.6.34.132] (helo=localhost.localdomain)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <daniel@iogearbox.net>)
        id 1paD0P-000WVR-38; Thu, 09 Mar 2023 10:56:13 +0100
Subject: Re: Broken build on 6.3-rc1 with uClibc-ng based toolchains due to
 poisoned strlcpy
To:     Jesus Sanchez-Palencia <jesussanp@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        rongtao@cestc.cn, Stanislav Fomichev <sdf@google.com>
Cc:     linux-perf-users@vger.kernel.org
References: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <533547a7-a9c0-2e6f-7817-43502f3679ba@iogearbox.net>
Date:   Thu, 9 Mar 2023 10:56:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAK4Nh0igK=-wapie340gnoo4xazC8GP7EG7wjy1EEJokCLQanA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/26836/Thu Mar  9 09:23:04 2023)
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On 3/8/23 8:28 PM, Jesus Sanchez-Palencia wrote:
> Hi there,
> 
> So commit 6d0c4b11e743("libbpf: Poison strlcpy()") added the pragma
> poison directive to libbpf_internal.h to protect against accidental
> usage of strlcpy. This has broken the build for some toolchains and
> the problem is that some libcs  (e.g. uClibc-ng) provide the strlcpy()
> declaration from string.h, which leads to a problem with the following
> include order:
> 
>                   string.h,
>                   from Iibbpf_common.h:12,
>                   from libbpf.h:20,
>                   from libbpf_internal.h:26,
>                   from strset.c:9:
> 
> If we patch libbpf_internal.h and move the #pragma GCC poison
> directive to after the include list, we fix the problem but at the
> expense of leaving libbpf.h unprotected (and libbpf_common.h as well,
> of course). We could duplicate the directive on all these other libbpf
> headers after the include list, but that's code duplication so I
> wanted to bring this up here before I send out a patch.
> 
> Let me know what you think or if you have any other suggestions, please.

Looks like you already sent a revert. Imo, that's probably the most pragmatic
way forward, so no objections from my side.

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/commit/?id=3b83591e32dd

Thanks for looking into this,
Daniel
