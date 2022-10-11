Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4E5C433FE
	for <linux-perf-users@archiver.kernel.org>; Tue, 11 Oct 2022 05:24:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiJKFY2 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 11 Oct 2022 01:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJKFY1 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 11 Oct 2022 01:24:27 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97A17E82F;
        Mon, 10 Oct 2022 22:24:26 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id s1-20020a4a81c1000000b0047d5e28cdc0so9321931oog.12;
        Mon, 10 Oct 2022 22:24:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7Pyh/nHa6VqZh92DYyRutJXMCD1rt9GXfh4Mq4x8o8=;
        b=iVVFGNVInoubSTQv9YYMLZtEtJmL+Gj+yTZqBA8X19dr1B35a4tCFCRssmGqJMeQww
         IJKAlivCKXKuocHB2tXqXI/feyweM7tpEQyr+xiMz4yw2gcmYd2HKXDg0z5U/+prOzV/
         GbJJO5MEtNkL7+VXdH1wWnAwm/TaqVhrqohIt4kgaXhAZqd6wMm/Bwqn7uJTFlAyPVSt
         uSm1D4hSBUH3Ro/MuaFHK906J+0/EH7iUoe7JO2vckYtHzZa1GQMrGcC32iA+mgYcaFU
         lWlgurqBtZ6qwVYwwI4ZdoJVkqkuc+Zzp/ljPG4iDScYqTgHINqGKequJniRzOZPO49U
         0sNg==
X-Gm-Message-State: ACrzQf0OJKVaN2T1KYd3UvVXktFJ/t6oNWx1qLoz4dffMApk9rVqHpDM
        m67mHMNhjx7RyMupQ7Su8lboIvDvfNXvJ2BapsI=
X-Google-Smtp-Source: AMsMyM7mdl1XFCUSlpZs3cuLcb0xxxbSawHPHx4TGJ8I9Uloe9oBoRmc3IYU9ne0Xj84MonLr+pe/flYRtdMiTsZAJw=
X-Received: by 2002:a9d:6848:0:b0:661:a608:cbc3 with SMTP id
 c8-20020a9d6848000000b00661a608cbc3mr2213875oto.206.1665465866064; Mon, 10
 Oct 2022 22:24:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAM9d7cjQ20a01YoZi=o-_7HT6TzR0TZgtpscKNvRrMq2yqV1Og@mail.gmail.com>
 <20220922041435.709119-1-namhyung@kernel.org> <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
In-Reply-To: <Y0Sx2KWX4gPlLytq@slm.duckdns.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Oct 2022 22:24:17 -0700
Message-ID: <CAM9d7cjNed7+v7WwfPshJuJzhvXFc_8zsHsociLfVnaFU8_0cg@mail.gmail.com>
Subject: Re: [PATCH] perf stat: Support old kernels for bperf cgroup counting
To:     Tejun Heo <tj@kernel.org>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org, Song Liu <songliubraving@fb.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Tejun,

On Mon, Oct 10, 2022 at 4:59 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Wed, Sep 21, 2022 at 09:14:35PM -0700, Namhyung Kim wrote:
> > The recent change in the cgroup will break the backward compatiblity in
> > the BPF program.  It should support both old and new kernels using BPF
> > CO-RE technique.
> >
> > Like the task_struct->__state handling in the offcpu analysis, we can
> > check the field name in the cgroup struct.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Looks like it's acked enough but the patch doesn't apply anymore. Namhyung,
> can you please refresh the patch? I'll route this through
> cgroup/for-6.1-fixes unless somebody objects.

Sorry about the conflict.  There was another change to get the perf
cgroup subsys id properly.  Will send v2 soon.

Thanks,
Namhyung
