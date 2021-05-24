Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8829C04FF3
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 May 2021 09:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACC35610C7
	for <linux-perf-users@archiver.kernel.org>; Mon, 24 May 2021 09:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhEXJU3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 24 May 2021 05:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbhEXJU2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 24 May 2021 05:20:28 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6BBC061574
        for <linux-perf-users@vger.kernel.org>; Mon, 24 May 2021 02:19:00 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id w7so19289500lji.6
        for <linux-perf-users@vger.kernel.org>; Mon, 24 May 2021 02:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=26p2Cx/YKghWAmWFrWsyTQT41qSxbIYkWClRt3rZCj8=;
        b=sRLOnRRnYdsKTM3w5bI3De9i6vm9iDT/ZEg7ZpfPnfIvtY5glk9KJQuy90xE9g62u/
         gb4i5i+LAylDj57a5hf26bEsnQxmPuavZFWFCC+R+oTGhNz8+I726aIW9emCkgY0UMQP
         +fGzIbjQK+JZp+s8OuCdv+QUOdCU2RtjxUi2bZi6Zre0mU7h9CWaU4qQ/p6CMb7kMOv0
         /qVrkYC1FqP529Y5luOzBQ+vMUPyR4Ae0G6+nObt5HSoGnST0xBQZOrycytx6jCjPuin
         9B4lKWetiquyGEljDDTbRzQQjS0yqPjIflvipRtor3ZIFcwe/v+hjSbyHF+JDZiBUZ/A
         GkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=26p2Cx/YKghWAmWFrWsyTQT41qSxbIYkWClRt3rZCj8=;
        b=cf21hTaZwJYlv0misU4TW0E52D6AbPF1Di55I1DaG8sGiNRRfkBb5RLhRg4YNRBTqM
         HkenD82FLEgm5JmzPnVyBX/ivKKyKSJT1VXwpTCaWwNG+gqA/1rPz4g8hb2GiCPzXGxg
         wlL71s/kbAwIvcoB50PmVI1LVNEFtLOSACyg3mjSx5/uO7amVeJa5jgRY6CChqCky1S1
         H0t4yKTj6r8I0s32RdCUvP1l5su+p959yuWjc7S27xm+4us4Ou/RJA1biJ7oxp1HxVsX
         xZTj2brDNC4bM7s3/fIoy6pcfsDEaqnQOUkOTAYp4V6DfAwtVYuoAhsWMfFx4CdSTU1U
         1wqg==
X-Gm-Message-State: AOAM5312l2Dd2UDQWbCOLA1jEc1sWosnjYwi1v1Nj+ES7OwcLeLCw5vO
        htkUwXZ3HxElLexwmlxHLn5dyCQY0kMzbh8Lota4CP55Clf9b2eE
X-Google-Smtp-Source: ABdhPJz+HPTEZa8LyeFHm2v6535md+92lBeoapLoKfH0oAmm5ZNoknlXLIIS6vZy1ovTq2DGy2NcXnpYIKPSoV4vL1k=
X-Received: by 2002:a2e:a585:: with SMTP id m5mr16617418ljp.51.1621847938333;
 Mon, 24 May 2021 02:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAMYFX7n6_ZC6kD_8uCJYjg2iTMhdyOEm=5hSN2U=O95qCtc0hA@mail.gmail.com>
In-Reply-To: <CAMYFX7n6_ZC6kD_8uCJYjg2iTMhdyOEm=5hSN2U=O95qCtc0hA@mail.gmail.com>
From:   Ahmad Nouralizadeh <ahmad.mlists@gmail.com>
Date:   Mon, 24 May 2021 13:48:46 +0430
Message-ID: <CAMYFX7=x8DdTK9s0Ms+LGBLc-6j3p+-=NO03MMJvu06asOaHAw@mail.gmail.com>
Subject: Re: Performance Counters and IMC Counter Not Matching
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
This is just a gentle reminder. Sorry for the inconvenience!
Any guesses is welcome!
Regards.

On Tue, 18 May 2021 at 04:35, Ahmad Nouralizadeh <ahmad.mlists@gmail.com> wrote:
>
> Hi,
> Could you have a look at this question? I don't know how I should
> start solving the problem. It has made me crazy!
> https://stackoverflow.com/questions/67513607/performance-counters-and-imc-counter-not-matching
> Even a simple hint or guess is appreciated!
> Regards.
