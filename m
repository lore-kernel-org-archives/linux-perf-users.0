Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3B2C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 11 Mar 2022 19:44:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351166AbiCKTpp (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 11 Mar 2022 14:45:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347127AbiCKTpo (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 11 Mar 2022 14:45:44 -0500
X-Greylist: delayed 897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 11 Mar 2022 11:44:40 PST
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCDDA76E3;
        Fri, 11 Mar 2022 11:44:40 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EB5F428204D;
        Fri, 11 Mar 2022 19:19:21 +0000 (UTC)
Received: from pdx1-sub0-mail-a285.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 83F55281FDF;
        Fri, 11 Mar 2022 19:18:16 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a285.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.119.141.198 (trex/6.5.3);
        Fri, 11 Mar 2022 19:19:21 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Chemical: 7467b47a74256cd0_1647026361804_258408801
X-MC-Loop-Signature: 1647026361804:3893042779
X-MC-Ingress-Time: 1647026361804
Received: from offworld (unknown [104.36.25.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a285.dreamhost.com (Postfix) with ESMTPSA id 4KFbL42vc1z1fy;
        Fri, 11 Mar 2022 11:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1647026269;
        bh=EGDhfn3s0aOiXPdBM24HRsLgqadRYpC/nAsYtUjp4Fg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=b3cAoMZJNESp8vPSigV7mlH8uXfQjNUPtoGwsH/v30BTaDJtkOVSE2VxP0NS4LAIo
         zODPozWpjMkTXiFnoS4o1ekmVr9KakGavts/tCs+Ns0flSxev6EQbMhjHcuEDZkT6Z
         yrrLIKqQKEIrLjdPIa2ct5WR4wj6RoavTtS5ESJ6aX3TLAOoxHb4JcxkEa7W3WKIZ0
         QLTNljdaGyvATdKHTpSzmJAIe2/2Bl36OaNsM42nTfJ/FDLHDJ+KUmINhsuiHAsUNj
         w8UMz6BO/jRLzVUg94LHKAVlcppiuTGcpzVGk5xf4G/OzkSTtII1jqO6sD5Qck+Dmt
         +CJxmfbfLMcSw==
Date:   Fri, 11 Mar 2022 11:08:56 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Weiguo Li <liwg06@foxmail.com>
Cc:     dbueso@suse.de, peterz@infradead.org, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf bench: Fix null check
Message-ID: <20220311190856.iv6tz3e3do2cc7tl@offworld>
References: <tencent_B5D64530EB9C7DBB8D2C88A0C790F1489D0A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <tencent_B5D64530EB9C7DBB8D2C88A0C790F1489D0A@qq.com>
User-Agent: NeoMutt/20211029
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, 11 Mar 2022, Weiguo Li wrote:

>We did a null check after "epollfdp = calloc(...)", but we checked
>"epollfd" instead of "epollfdp".
>
>Signed-off-by: Weiguo Li <liwg06@foxmail.com>

Acked-by: Davidlohr Bueso <dave@stgolabs.net>
