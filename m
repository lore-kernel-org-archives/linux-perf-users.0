Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E8BC433F5
	for <linux-perf-users@archiver.kernel.org>; Mon, 10 Oct 2022 14:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJJOy0 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 10 Oct 2022 10:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiJJOyZ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 10 Oct 2022 10:54:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAF5440E3D
        for <linux-perf-users@vger.kernel.org>; Mon, 10 Oct 2022 07:54:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC25CD6E;
        Mon, 10 Oct 2022 07:54:30 -0700 (PDT)
Received: from [10.57.3.59] (unknown [10.57.3.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34EB53F766;
        Mon, 10 Oct 2022 07:54:24 -0700 (PDT)
Message-ID: <96a77e3e-7a9a-a519-0646-eb1f424e4ec1@arm.com>
Date:   Mon, 10 Oct 2022 15:54:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Recent perf-tools does not compile on alpha
Content-Language: en-US
To:     matoro <matoro_mailinglist_kernel@matoro.tk>,
        linux-perf-users@vger.kernel.org
References: <43a0c856c61f0bee69290b82c7bd8e7a@matoro.tk>
From:   James Clark <james.clark@arm.com>
In-Reply-To: <43a0c856c61f0bee69290b82c7bd8e7a@matoro.tk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org



On 08/10/2022 04:53, matoro wrote:
> Hi!  Recent versions of the perf tools (5.19) do not compile on alpha
> with the following errors:
> 
> util/unwind-libdw.c: In function ‘memory_read’:
> util/unwind-libdw.c:161:62: error: ‘PERF_REG_SP’ undeclared (first use
> in this function); did you mean ‘PERF_MEM_S’?
>   161 |         ret = perf_reg_value(&start, &ui->sample->user_regs,
> PERF_REG_SP);
>       |                                                             
> ^~~~~~~~~~~
>       |                                                             
> PERF_MEM_S
> util/unwind-libdw.c:161:62: note: each undeclared identifier is reported
> only once for each function it appears in
> util/unwind-libdw.c: In function ‘unwind__get_entries’:
> util/unwind-libdw.c:255:53: error: ‘PERF_REG_IP’ undeclared (first use
> in this function); did you mean ‘PERF_REGS_MAX’?
>   255 |         err = perf_reg_value(&ip, &data->user_regs, PERF_REG_IP);
>       |                                                     ^~~~~~~~~~~
>       |                                                     PERF_REGS_MAX
> 
> Wondering if anybody has some pointers about where these definitions
> should be coming from on alpha?

Is CONFIG_LIBDW_DWARF_UNWIND being set in the autodetection when it
wasn't before? You can override it with NO_LIBDW_DWARF_UNWIND=1

Other than that, you'd have to add
linux/tools/perf/arch/alpha/include/perf_regs.h
