Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544A7EB64DD
	for <linux-perf-users@archiver.kernel.org>; Sun,  9 Jul 2023 01:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjGIBkX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 8 Jul 2023 21:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjGIBkW (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 8 Jul 2023 21:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0FE45
        for <linux-perf-users@vger.kernel.org>; Sat,  8 Jul 2023 18:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614D460B73
        for <linux-perf-users@vger.kernel.org>; Sun,  9 Jul 2023 01:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B37BEC433C7;
        Sun,  9 Jul 2023 01:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688866820;
        bh=cCSoNdGhByAcijFIGmpoKqHnbwrgQX07PWN6H3JHoxI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=gdmRzLTAlL8lwG//5JfNGpXD0g6NltnVSqqJ0B5n38Boz335q8wAJ46gnh2DSiuDY
         iHNqR/qnIhxENOmdQ+tnetp+ZjDIvFzxWZtrSocS6S4YWmRodZUbQ+eTGYyP1jcVz1
         TtNsH/fRF35hLQqukPUtBZSHEL9UV0pHTi0gBiEqp7cFDbDc5zSYm/gDwPwh6NB/mq
         M3YqvmOEgMT/40TGx2pUqCWz0t9LtoD2vTpPT5Ov40y7+d+qNvo1GUZR0MRpnL7mWX
         klTC3UNKlnCrW3Ht6rNRdwqnhvU4nFC/ILWTb7iHQmVhCw0NJJY7sQkCQkcdKYqZx/
         6N3nxe22+x2zg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E2BFC0C40E;
        Sun,  9 Jul 2023 01:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] libbpf: only reset sec_def handler when necessary
From:   patchwork-bot+netdevbpf@kernel.org
Message-Id: <168886682064.2231.10209973851568634649.git-patchwork-notify@kernel.org>
Date:   Sun, 09 Jul 2023 01:40:20 +0000
References: <20230707231156.1711948-1-andrii@kernel.org>
In-Reply-To: <20230707231156.1711948-1-andrii@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, ravi.bangoria@amd.com,
        linux-perf-users@vger.kernel.org, acme@kernel.org
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 7 Jul 2023 16:11:56 -0700 you wrote:
> Don't reset recorded sec_def handler unconditionally on
> bpf_program__set_type(). There are two situations where this is wrong.
> 
> First, if the program type didn't actually change. In that case original
> SEC handler should work just fine.
> 
> Second, catch-all custom SEC handler is supposed to work with any BPF
> program type and SEC() annotation, so it also doesn't make sense to
> reset that.
> 
> [...]

Here is the summary with links:
  - [bpf-next] libbpf: only reset sec_def handler when necessary
    https://git.kernel.org/bpf/bpf-next/c/c628747cc880

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


