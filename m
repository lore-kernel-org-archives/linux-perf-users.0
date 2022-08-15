Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5913DC00140
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 Aug 2022 13:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiHON22 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 Aug 2022 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbiHON2E (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 Aug 2022 09:28:04 -0400
X-Greylist: delayed 239 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 06:28:03 PDT
Received: from forward501j.mail.yandex.net (forward501j.mail.yandex.net [IPv6:2a02:6b8:0:801:2::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93591FCE7;
        Mon, 15 Aug 2022 06:28:02 -0700 (PDT)
Received: from myt5-aad1beefab42.qloud-c.yandex.net (myt5-aad1beefab42.qloud-c.yandex.net [IPv6:2a02:6b8:c12:128:0:640:aad1:beef])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 006D362346E;
        Mon, 15 Aug 2022 16:28:01 +0300 (MSK)
Received: by myt5-aad1beefab42.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 9t3MXX2NvM-Rvh0ex7m;
        Mon, 15 Aug 2022 16:27:59 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1660570079;
        bh=fFBDJAUv3+NYO8fK5MxMGSwQlgTg0VDUZqjNCrIr6ys=;
        h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
        b=IN6CJREbPLjNBkjiFwjZoXSjd4UP14C+tOE/8YsUQCk3zhIaURa3TA9NYrdTBpEOg
         gZdwGexiNBR7dfM+7SBwOfo1odTTSmKJmdNzD7mdZrwwFGJuDmfHOHv87lXbo1m5Yq
         Ur5TVsYHrOSpb+sEVwP+brF/X4TXku2JNknIAyH4=
Authentication-Results: myt5-aad1beefab42.qloud-c.yandex.net; dkim=pass header.i=@maquefel.me
Date:   Mon, 15 Aug 2022 16:27:55 +0300
From:   Nikita Shubin <nikita.shubin@maquefel.me>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Mayuresh Chitale <mchitale@ventanamicro.com>, linux@yadro.com,
        Genevieve Chan <genevieve.chan@starfivetech.com>,
        =?UTF-8?B?Sm/Do28gTcOhcmlv?= Domingos 
        <joao.mario@tecnico.ulisboa.pt>,
        Nikita Shubin <n.shubin@yadro.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Kautuk Consul <kconsul@ventanamicro.com>
Subject: Re: [PATCH v5] perf arch events: riscv sbi firmware std event files
Message-ID: <20220815162755.7ed970c6@redslave.neermore.group>
In-Reply-To: <Yvas60duFUkSzuz+@kernel.org>
References: <20220628114625.166665-1-nikita.shubin@maquefel.me>
        <20220628114625.166665-4-nikita.shubin@maquefel.me>
        <18c8e9c74955c08fdbd631a35c51b30f3cff3cd3.camel@ventanamicro.com>
        <20220811112303.4e5f0566@redslave.neermore.group>
        <Yvas60duFUkSzuz+@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello Arnaldo!

> If I get this today it may even get into v6.0. :-)
> 
> Thanks,
> 
> - Arnaldo

Well... i missed it :), on the other hand this series depends on 
https://lkml.org/lkml/2022/7/27/23 
which hasn't been merged yet.

Just have sent a v6 series.

Thank you for review!

Yours, 
Nikita Shubin

