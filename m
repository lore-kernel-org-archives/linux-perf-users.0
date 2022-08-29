Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12981ECAAD2
	for <linux-perf-users@archiver.kernel.org>; Mon, 29 Aug 2022 22:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbiH2WjF (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 29 Aug 2022 18:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiH2WjE (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 29 Aug 2022 18:39:04 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D819DF99
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 15:39:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 92-20020a9d0be5000000b0063946111607so6901717oth.10
        for <linux-perf-users@vger.kernel.org>; Mon, 29 Aug 2022 15:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aYEw9phYIh6NdtB1WNMHpZ3C2dTWIH1UNUXVcYo+veg=;
        b=Z11L16MyzjSCjbgizK7EG1DQa/UlWs8dZ3Pppm9/A4Ol0j5Fw43+OcoD9k3HRNg+M6
         pznSL4enFD9kRCFv5xGe981qOr/jhEmlKOhuT9Z+N0GyHp/Pyx4u/9RUdvAWY6Y9LQpe
         vApfblyerZ5PhC+4mSN31QpfrdRxJ+fllRCIn1EeU+nGar9vLRz0gn3t5jkg5rKZW2hs
         PxoTxCR+LhsMsbJ/NngHHTKK8pfaoqxqAprqejJrL1IQ0Xioy3yrqe4kIBAUWf8oUSn5
         lwt8eopHRdSEU+4kmEERnLEzMas92uRy9DKttaWNt/e7DFcekz2AzkcB/JUzLh6QJLax
         bQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aYEw9phYIh6NdtB1WNMHpZ3C2dTWIH1UNUXVcYo+veg=;
        b=M+ozv+N1AN/ffk+rVoUBq31M/7Vv5lSQ7w5CngRgWgZa2ITqg/tjhWXCtevrT5hHXa
         WNkWKkV/Yp5B3NW1V7Shc7b95A4jBFZQUXi7YXZPgLYh8XgwS6bjiew9zNxFK6Nu+243
         26JViM0PHYXRHhtq1/D0DBqyYxx6pdENdS/RJNwQe0nNjehymzWLqygMCy3S64G6Snys
         e0ROw7Qc+p7td362PB80Y92mmxCIXLQniMVHx56b9BCC23SSGL0adSuRLM9iFH+MwYVK
         Gkn7ODxvadOx2jXe09/v4AZyKyC2miug0kbDx13hl68uTJYivz9VstIBua5nHVEtND/C
         YDTQ==
X-Gm-Message-State: ACgBeo0mOc6oxVOdnzAvQlXaEfT6J43q0esTLTtFWsznqPWQnfngjO88
        3z9D6oOxepPfMqPJQ7mxyN9pyAthGwO0AtpPJGI=
X-Google-Smtp-Source: AA6agR7rQ267wdWZKDEvFssoFvG9NwKepyPMlKSJuGhjY/oDqysjvf0tBYGAcXL+L9VOtALK1XbVSiMThmbNlalZu1I=
X-Received: by 2002:a9d:6a59:0:b0:638:92fd:d5b4 with SMTP id
 h25-20020a9d6a59000000b0063892fdd5b4mr7739837otn.247.1661812742448; Mon, 29
 Aug 2022 15:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <DM4PR18MB5026C7008C77EF24557409138A6B9@DM4PR18MB5026.namprd18.prod.outlook.com>
 <YwyxOVALB0mUf/t9@krava> <DM4PR18MB50267E1E2D1A247C5E10F8098A769@DM4PR18MB5026.namprd18.prod.outlook.com>
In-Reply-To: <DM4PR18MB50267E1E2D1A247C5E10F8098A769@DM4PR18MB5026.namprd18.prod.outlook.com>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Mon, 29 Aug 2022 15:38:51 -0700
Message-ID: <CAM9d7cg4dC03So8kXMk2tEh5-C88br52qK=EdyL_1XofiHHhDQ@mail.gmail.com>
Subject: Re: Cannot print 'uregs' field with perf script -F uregs
To:     Hongtao Yu <Hongtao.Yu@outlook.com>
Cc:     Jiri Olsa <olsajiri@gmail.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hello,

On Mon, Aug 29, 2022 at 10:28 AM Hongtao Yu <Hongtao.Yu@outlook.com> wrote:
>
> Thanks for the response. I tried with hw:uregs but it didn't seem to work expectedly. Instead of giving uregs samples, it gives something like
>
>       hhvmworker 10485 [003] 2812596.974788:      16009 br_inst_retired.near_call:uppp:          10349698 [unknown] ([unknown])
>       hhvmworker  4412 [006] 2812596.975085:      16009 br_inst_retired.near_call:uppp:          1339b05e [unknown] (/tmp/perf-1530.map)
>

Please reply under the original messages.

>
>
> From: Jiri Olsa <olsajiri@gmail.com>
> Sent: Monday, August 29, 2022 5:29 AM
> To: Hongtao Yu <Hongtao.Yu@outlook.com>
> Cc: olsajiri@gmail.com <olsajiri@gmail.com>; linux-perf-users@vger.kernel.org <linux-perf-users@vger.kernel.org>
> Subject: Re: Cannot print 'uregs' field with perf script -F uregs
>
> On Mon, Aug 15, 2022 at 10:34:44PM -0700, Hongtao Yu wrote:
> > You fix works, thanks! Are you going to commit it?
>
> sorry for delay.. I was checking in more detail and we actually
> can do it even without the fix with 'hw:' prefix like:
>
>   # perf script -F hw:uregs
>
> dummy event is special, but I'll need to check if we want
> to hardcode that first

Maybe we can just skip the dummy event as it won't have samples.

Thanks,
Namhyung
