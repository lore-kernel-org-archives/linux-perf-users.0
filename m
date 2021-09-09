Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C80C433F5
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 02:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5609A6101A
	for <linux-perf-users@archiver.kernel.org>; Thu,  9 Sep 2021 02:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbhIICRh (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 8 Sep 2021 22:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231660AbhIICRh (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 8 Sep 2021 22:17:37 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB76C061575
        for <linux-perf-users@vger.kernel.org>; Wed,  8 Sep 2021 19:16:28 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id m4so461044ljq.8
        for <linux-perf-users@vger.kernel.org>; Wed, 08 Sep 2021 19:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irW/yy93SBuAkK/7TOzcQ8NgXINc0jGttDWunT9fvoc=;
        b=mjloalnHpQL3GD3SVMdlUDr97Vk1U4nHyM68TEiyj0YitS1zZ3W3ErdvUgDPFByhWs
         rMWDVteSvldFMohBW4cl+7oS1mg99nLxD6sk8nrRge4JkwD83kFddqu4j6XBc7sUWv60
         hTSl8X+RaNUd0PemHCry2Xd1vsvQEU+MHZtwyH3wNNXDuswyRbvSfMqMSIglHE8kp9vZ
         o4D7/M2qpaF1X2t9DYx39ONpgmFew7DfJcosnhTYQndyv0zgg6DDE6RfZmjqTNo19lsF
         klYAkKxMiVaFugQiyXHZTJ+Mqk5APYoFbhklaeI+UJkuyetGvYVLopWiDAPPfYCOoA2Y
         84dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irW/yy93SBuAkK/7TOzcQ8NgXINc0jGttDWunT9fvoc=;
        b=rgahHbYy/4YMm5/pErP8YbOm6oh53pnnnf8J+rpLDL1HsgTT4cOZWjVFjC65diFk9x
         KbzWRhrbDgiMvs5b5FZLYBIk6OSAEp7doqFb52tvU67lYpkHr6hJZTfwoXNy7EdnmBTW
         yck7Xog2MyutKS5M0VoJGGhrSkP4MpncRnSHtzOSpGzksEClWIdXT8eqSJ14oOaGN1iU
         2tJZRFQGLCSKf2pGDWRsA90czNjjbvcQJsF6j1zxvWaTmA52ENcDtdBXnhyfJb/8GVE8
         w6AmFqbCs5TXn/k7Z9bMZkoj/u5pXwkQ/AWX8bZU2nZp7zbjRZfHrXSb9C2keyWbWOgc
         cCyg==
X-Gm-Message-State: AOAM530hC4YMZ9O7ssggQXUIWY8AvSc7pmI6WwhOpvwZHEbYH9O2N0z7
        E7D6gTFCpB3w/rz+e4E9rBnZRzqtBVv4EONtm6pYRjLX5cM=
X-Google-Smtp-Source: ABdhPJyQJxGPqafBfEc2iNzc1ioQN4zKVc7dd8OUOl0AQm7wd9Sf0eNsWOri3619IVyifxOfx3ua+O6iQvXWLoWq9uY=
X-Received: by 2002:a2e:86d1:: with SMTP id n17mr353594ljj.237.1631153786505;
 Wed, 08 Sep 2021 19:16:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAM07o6QB9rUgzxHxR=sdwTddn+2GxeK5Uwj9QeCVMyEiD5SRdA@mail.gmail.com>
 <CAE40pdf7n-YzZb71CvFmNFtCh3eTiBfAtiWxdJQLQRxs-hVUmA@mail.gmail.com> <9e717abe-d923-d88c-90b6-ca589831d157@oracle.com>
In-Reply-To: <9e717abe-d923-d88c-90b6-ca589831d157@oracle.com>
From:   Brendan Gregg <brendan.d.gregg@gmail.com>
Date:   Thu, 9 Sep 2021 12:15:59 +1000
Message-ID: <CAE40pdewTBdv5eUXks4ZTf5K6UjrVjYVv62kyqN7dZydnYjX9g@mail.gmail.com>
Subject: Re: A list of visual Profiler UIs for linux perf
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Mark Hansen <mark@markhansen.co.nz>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

G'Day Stephen,

On Thu, Sep 9, 2021 at 5:13 AM Stephen Brennan
<stephen.s.brennan@oracle.com> wrote:
>
> Hi Mark & Brendan,
>
> Thanks for this thread - it's very useful.
>
> Firefox Profiler is news to me and looks exciting. However, I can't see
> any clear documentation on their part that the tool is client-side only.
> I can't always put internal flamegraphs into a web form on the
> assumption that they won't be uploaded somewhere. Do you know if there's
> anything explicit that says data won't be shared? (unless I explicitly
> upload it to create a link)
>
> Flamescope is quite exciting as well! I can see how the time dimension
> can be incredibly useful. Brendan, I had a couple questions regarding it:
> 1) Is the box color scale in terms of "number of samples in that time
> interval"? If so, it would only really be useful for cpu-cycles or
> instructions, correct? Something like the cpu-clock which tries to
> regularly sample at a set frequency would just look monochrome?

Exclude idle stacks then cpu-cycles works. Most of our samples are
cpu-cycles based (only thing available in most of EC2). FlameScope
should already filter it:

app/perf/regexp.py:idle_stack =
re.compile("(cpuidle|cpu_idle|cpu_bringup_and_idle|native_safe_halt|xen_hypercall_sched_op|xen_hypercall_vcpu_op)")

I've also used it for other non-CPU events including off-CPU spans by
adapting it to sample equivalents.

>
> 2) I'm curious if you've considered directly using perf.data in
> Flamescope, rather than perf.script? I've recently discovered the
> "--symfs" and "--kallsyms" options for perf. By using perf buildid-list,
> you can identify all DSOs, capture their symbol tables, and create a
> minimal bundle of files to allow the perf.data to be read with useful
> symbols on any system. Since perf.data contains more information,
> usually with less disk space, I've started taking this approach to make
> capturing, transferring, and analyzing larger recordings (especially
> from customers) easier as well as more flexible and efficient. All the
> same analysis can be done via the Python engine in perf-script, without
> need to worry about text parsing.

We do gzip the perf script outputs. Just checking the README, I should
probably change 'perf script --header' to use -F to specify the
fields, to make it more future proof.

I haven't explored the buildid-list path since we have Java apps with
massive symbol tables that can be 100s of Mbytes of text, and other
binaries that use a mix of ELF symbol tables and DWARF debuginfo. I've
assumed this will be too big to include, but haven't tried yet. Maybe
it's better suited for some apps with smaller symbol tables?

Brendan
