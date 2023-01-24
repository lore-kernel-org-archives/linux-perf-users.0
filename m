Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C1BDC25B4E
	for <linux-perf-users@archiver.kernel.org>; Tue, 24 Jan 2023 17:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjAXR02 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjAXR01 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 24 Jan 2023 12:26:27 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D292E4AA74
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 09:26:24 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-506609635cbso13922007b3.4
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Jan 2023 09:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjCq/s/qxZjogYR5ngUzY/NZUDkH1TtJ8+qNI3/W6+I=;
        b=mIA6qhmPfHGd99lkE+IwzQCZzdM9X13+COMMujo6Ur5QioVNCBbM+892KpiJpptStM
         IO4oYfMH+tsU0G2cB2zH9iAcYBaC+iEoKVwYzWIQwHg5t+zlCzuiMJVe6kbxJfoNWgTe
         l425GHM+CryY46Q+XteCB/PcZ5Ll+2uB1tuFSuHeY4Pu1hgkSVCFkZhNz9JKQX6Eovw+
         yVrdNP9u7kqN6hw1sDzXhArVxAwolFrzhUMMKX+ZeWBU/0M0sxHDQzaGPQHMjibG+tuQ
         Z2uqEBm4uY2QrxNI2mES8MZztMIrlXGtiGx7h0m1sKBEc8xqnf3A2l/A+eEIfB7C+AH/
         eviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjCq/s/qxZjogYR5ngUzY/NZUDkH1TtJ8+qNI3/W6+I=;
        b=mNyx4+c1Bord1RbZcyUyCFQZx7haEuNim4Nc0Vx2+bGVJ8ji08Gg6HMhLai1eyhG11
         SecGoZDmXTENMox+SuTcHoFedf7F+HLnxRHj03ShbP0KNU7wKKbf1xC36aDO1x4jzTPK
         tPdn5V+VFgXTcl3bmJ9VWHO5oZqYFE67Tof/E2Ul1roY9NmDaqBdkZJw4ItuwLPe5Em3
         w0fdcOjj+Ed3OzbRemibxeJTgrpKrsdRlWxoOO0WvfFIH7YnfuQ2jRpGYW+CULQ6fqBv
         JmHoOZmo60BKDkT4VDO8aXP5aIIvcQu2V1vDMhcMMvZdGF/kryUy9CulLD7pSU4vrgSc
         ApqQ==
X-Gm-Message-State: AFqh2kqWx42fTdfPajDcWSlXmZCCppTTRO55WqlKvvGgL4/kFYFdBIL/
        R1mLJmujKEltGJsZ1lCkWt2AQuDMecDnncZVwAs=
X-Google-Smtp-Source: AMrXdXt/c3Gs2bf1Co0vyq0XJBDESMTrOCf7vwv/qYF5meM1ulIsqzPOL5ucIVeZOSVyvyP2LC4NOL7v6Ea/epKhCcg=
X-Received: by 2002:a0d:db07:0:b0:500:8d0d:7feb with SMTP id
 d7-20020a0ddb07000000b005008d0d7febmr2296449ywe.358.1674581184026; Tue, 24
 Jan 2023 09:26:24 -0800 (PST)
MIME-Version: 1.0
References: <20230120134039.17788-1-mpetlan@redhat.com> <20230120134039.17788-3-mpetlan@redhat.com>
 <CAM9d7ch-if6Ov9dT+zHtYzVOdOjGOe=YsQvmb_5AOdbK9NDmZQ@mail.gmail.com> <alpine.LRH.2.20.2301241747420.5281@Diego>
In-Reply-To: <alpine.LRH.2.20.2301241747420.5281@Diego>
From:   Namhyung Kim <namhyung@gmail.com>
Date:   Tue, 24 Jan 2023 09:26:12 -0800
Message-ID: <CAM9d7cip0KM-LJ_xdxvcL71E9BU31=PLZaJM-q7LawLQAScOqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf test: Fix JSON format linter test checks
To:     Michael Petlan <mpetlan@redhat.com>
Cc:     linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com,
        qzhao@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Jan 24, 2023 at 8:49 AM Michael Petlan <mpetlan@redhat.com> wrote:
>
> On Sun, 22 Jan 2023, Namhyung Kim wrote:
> > On Fri, Jan 20, 2023 at 6:00 AM Michael Petlan <mpetlan@redhat.com> wrote:
> > >
> > > The test fails on CPUs with topdown metrics, where it is common to print
> > > two metrics per line. Since these are included in default event set for
> > > `perf stat -- something`, it causes the "no args" subtest to fail due to
> > > unexpected member count. We need to accept 7 or 9 members in that case.
> > >
> > > Coming to that, counting commas in the JSON line and consider it a number
> > > of elements is incorrect and misleading. There should be +1 element than
> > > the count of commas, while also, commas can potentially appear in the
> > > event names. Count " : " substrings rather, since these better fit to
> > > what should be actually counted.
> >
> > I'm also curious if ":" could appear in the event/metric names.
> > Probably more chances to have ":" than "," in the name, no?
>
> Yes, ':' can appear in the event names, but not " : " (with the spaces
> around).

Ah, ok.  Missed the whitespaces. :)

Thanks,
Namhyung
