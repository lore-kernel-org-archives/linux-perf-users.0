Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FEC00523
	for <linux-perf-users@archiver.kernel.org>; Wed, 20 Sep 2023 15:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbjITPTO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 20 Sep 2023 11:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbjITPTN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 20 Sep 2023 11:19:13 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5149CF
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 08:19:06 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41513d2cca7so436831cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 20 Sep 2023 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695223146; x=1695827946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZVktfiYPXa2c9fV5ZGf4F81MgVZBSMRNlZQj4QQxBg=;
        b=byb/tWhx0qYSI8+s4vKgAO47H16iCAosTSK4a8qdOmJFR+aLC6D7M/rZH585K/mNMe
         LLmTlMSIQ0RhbN3u4LnnTJdg6ke3YnUU6VxG4FhidO9gx/UHdXDbpxTXsjbHd9OrHK8M
         0GGmnkArNofcGWnTB4XGDUFn9pJYTq1AmjE9j+ewYdetyrSeyZzwQ9KjBIIcoYHDgUA7
         EwlXbtAi5PgyrpJXslF+vPvhXOIfr2lcfkfGj/Cz+bNecpjv8kMk70E212I74j4uZBf1
         6M2Fbw+uB+PRJF53L/7c27EAcGT2AUf5qCequneHjEtCL/OmxRtL2GaBoC25YO/EmDor
         8GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695223146; x=1695827946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cZVktfiYPXa2c9fV5ZGf4F81MgVZBSMRNlZQj4QQxBg=;
        b=hrPoE2nKaAWZqpNpLo1BRlFz9k51pgDFFx7R7uWevA/YMyPTv5ztmKyBRdElkQSj2T
         nahRaRfvAjrG9D7720QxyVuOlQun6EnpwOIICQM+jODsUvGKjrkJxlC2mLwfl+wvqCal
         ln+QGlbFTTX4ZvExGncbdirs7gK71xXN+SKkkrB1OUmO/wE0WlCcOoALLfc5d0qAasEw
         Bb2JaB0zXn+2mdebXw/ftEIj4Lq3VQ5PNxGm1iRwzGx8tOxBnqXQntoMff05cNXGtcju
         HHeybjTUUirnRm3NJpESKWauNSGNLz136+WEuT4lKTLRF/JCBcFouCsqahC/hnY+ObEQ
         85MA==
X-Gm-Message-State: AOJu0YxwySZ8T1sAZ2NKct4Kdi/zBeb0tFw5nYVOr3ztn0lvMJ4zJ6cZ
        tgKdgVyZqJshex2InIPrZ9uj9mKx/X4VN43N4k9MGd99ZH6P6hjNrr8QkadW
X-Google-Smtp-Source: AGHT+IGg9OX2knxrt8TGCHR7RIaSr8kvvgesGEHfGfTDWXkYHR7WctD5uq5qzG3lPxg2TleN5maxjHe2qc/QFVAFGis=
X-Received: by 2002:a05:622a:506:b0:410:916b:eb3f with SMTP id
 l6-20020a05622a050600b00410916beb3fmr335729qtx.16.1695223145740; Wed, 20 Sep
 2023 08:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <2fb5c263fce545b0a5b745e6122fa88e@akamai.com> <CAP-5=fX-wPy11iVZyc7HRXr_rK3GVwU_7gRtLKFsZH5=i=jWTA@mail.gmail.com>
 <e4473389303b43f1aa063d3dcf72ad57@akamai.com> <0915ceb147174fc4a09a2a0b774c01bb@akamai.com>
In-Reply-To: <0915ceb147174fc4a09a2a0b774c01bb@akamai.com>
From:   Ian Rogers <irogers@google.com>
Date:   Wed, 20 Sep 2023 08:18:54 -0700
Message-ID: <CAP-5=fUmtqqh9XCFaFbNRfijJr_orSz5xe5yT-fT3NubQ_n=Wg@mail.gmail.com>
Subject: Re: Symbol resolution when text in hugepages
To:     "Jayaramappa, Srilakshmi" <sjayaram@akamai.com>
Cc:     "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Tue, Sep 19, 2023 at 1:51=E2=80=AFPM Jayaramappa, Srilakshmi
<sjayaram@akamai.com> wrote:
>
> From: Ian Rogers <irogers@google.com>
> Sent: Thursday, September 14, 2023 4:26 PM
> To: Jayaramappa, Srilakshmi
> Cc: linux-perf-users@vger.kernel.org
> Subject: Re: Symbol resolution when text in hugepages
>
> On Wed, Sep 13, 2023 at 5:21=E2=80=AFPM Jayaramappa, Srilakshmi
> <sjayaram@akamai.com> wrote:
> >
> > Hi all,
> >
> > We have an application that has its text section backed by hugepages. I=
n our new build environment the text section of the binary is split up into=
 read and read/execute sections with offsets into the segment. This is brea=
king the perf symbol resolution. Previously,  everything was in one segment=
 and there was no offset, so perf functioned fine. I know we can dump the s=
ymbols from readelf into /tmp/perf-PID.map file. I was wondering if anyone =
has a cleaner solution? I'd appreciate any pointers you have.
>
> Hi Sri,
>
> Since Linux 5.4 you can use MADV_HUGEPAGE with madvise for file backed
> pages. It can still be profitable to use other sources of huge pages
> so that you don't wait for the hugepage to be formed, in that case if
> there is a file/memfd_create you can embed the information in the
> filename. For anonymous pages you can merge them when scanning the
> executable in perf_event__synthesize_mmap_events, but it can be
> problematic if the program header is on an anonymous page.
>
> Thanks,
> Ian
>
> > Thanks
> > Sri
>
>
>
> [resending since my message bounced from the mailing list. Apologies for =
the spam, Ian]
>
> Thank you for the response, Ian, appreciate it. The pointer to perf_event=
__synthesize_mmap_events  is super useful, we will need to do something lik=
e that to find if the address range is backed by hugepages and if so grab t=
he offset from the executable.
>
>
> For more context - our application first loads and then we remap its text=
 segment to hugepages via the libhugetlbfs. When that happens the memory ma=
p doesn't need any offset. But perf is grabbing the maps from the /proc/pid=
/maps and trying  to lookup the address in the binary, so it looks at the w=
rong place without the offset into the file.

Hi Sri,

I think you'd be much better served using MADV_COLLAPSE or
MADV_HUGEPAGE, not least because hugetlbfs requires preallocation of
huge pages. Using these shouldn't alter perf's symbolization.

Thanks,
Ian

> Thanks!
> Sri
