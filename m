Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3479FC432BE
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 03:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 115AB610C8
	for <linux-perf-users@archiver.kernel.org>; Thu,  2 Sep 2021 03:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhIBD2F (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Sep 2021 23:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbhIBD2F (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Sep 2021 23:28:05 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C4EC061575
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Sep 2021 20:27:07 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id s3so907305ljp.11
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Sep 2021 20:27:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=sJiS+O5ljlGh/8Y22FmF9bSdbxp+AsyIsADYnFtmh2c=;
        b=olsnLFZYWYXQ00qgBPOGqoCinY9V202B7gA84g83gVtUSgFYnP177fCPPamCWk0Sl7
         s0byL2oC106wx8GhFT5PGXBNYknehQ5XbnXrtDHCX26csA81qa9Vhg2YjsR/9M2FE8Zq
         se1+q68ZAVmHseOZkCYtpNa4Jr1+pt4nSdfFDHdj/Dv7+jx5cd2X02LGJUmQG3XbpRGo
         JLSgWfoMZ5nfhYD6gmrKJEIK14lk6Z8dn1GoixfZA0MxHejR+tJKN7Oq+K9ICSMrQ3qa
         Rrmk+S6mLFLJOD/L/K5B6iruOFNhtrjjJXnxqhAuCdMDg78QCSgkajZ5Tz+zADAGVYOn
         7AuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=sJiS+O5ljlGh/8Y22FmF9bSdbxp+AsyIsADYnFtmh2c=;
        b=ejZUUB3VAH/Y80vL6prSkmfPccLqV/SN8z6EiMpYw+WMNRnXshISDYcJWed9ySUN3d
         kyfUY30NFeNCgCk69o1HOk0MDLw6l2LgR0zpb66sQbPOWfYjmUBh6Jjd2l3r9UuPf0ek
         BOGtcV3uezHxTB7h0IQ/S0duz1VQCRmOMOM0/hYKYSQFrZ6JSUqsxSzAw0vDlMwxfw7p
         NPWo8wovAjx1c1XBPEJ2OcGjfQNf5am4N4IxAyhByI5K2D/23gDmg/8finVKhemHb/2l
         gUNOiy41wS9nyw4qGxqSUDA+Bq7IU3rYAAHkL6SjFpVWQW/KnOKJNireYgN80NQQtbUx
         KHdg==
X-Gm-Message-State: AOAM532C4mbrZ2arDZsYys8yiHuAwActzMFK+Tg5+ak3yTeZ0lFV3paG
        ah0eAKeS7pdQkOMvh0Zx7mKo34lIQYFZcWhOd/1Ief2fyYM=
X-Google-Smtp-Source: ABdhPJxf3glSSbASMhjm+3GhZ6hO1oauo17d8/t7hUPkDVtBMGzf2lHb3H8dbqyW2SYrX9PJgva6lYBshESZYcAKRDg=
X-Received: by 2002:a05:651c:b0b:: with SMTP id b11mr728492ljr.234.1630553225640;
 Wed, 01 Sep 2021 20:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <CAMYFX7n6_ZC6kD_8uCJYjg2iTMhdyOEm=5hSN2U=O95qCtc0hA@mail.gmail.com>
 <CAMYFX7=x8DdTK9s0Ms+LGBLc-6j3p+-=NO03MMJvu06asOaHAw@mail.gmail.com>
In-Reply-To: <CAMYFX7=x8DdTK9s0Ms+LGBLc-6j3p+-=NO03MMJvu06asOaHAw@mail.gmail.com>
From:   Ahmad Nouralizadeh <ahmad.mlists@gmail.com>
Date:   Thu, 2 Sep 2021 07:56:54 +0430
Message-ID: <CAMYFX7mkZrFwGwtJ+OWaZAcfOXXHkDCq1kERcrP4HFk6uJgzvA@mail.gmail.com>
Subject: Re: Performance Counters and IMC Counter Not Matching
To:     linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,
The accesses were caused by the GPU device. The link to the answer (in
case it is helpful for someone else!):
https://stackoverflow.com/a/69006281/6661026
Regards.

On Mon, 24 May 2021 at 13:48, Ahmad Nouralizadeh <ahmad.mlists@gmail.com> wrote:
>
> Hi,
> This is just a gentle reminder. Sorry for the inconvenience!
> Any guesses is welcome!
> Regards.
>
> On Tue, 18 May 2021 at 04:35, Ahmad Nouralizadeh <ahmad.mlists@gmail.com> wrote:
> >
> > Hi,
> > Could you have a look at this question? I don't know how I should
> > start solving the problem. It has made me crazy!
> > https://stackoverflow.com/questions/67513607/performance-counters-and-imc-counter-not-matching
> > Even a simple hint or guess is appreciated!
> > Regards.
