Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEC7C77B7D
	for <linux-perf-users@archiver.kernel.org>; Mon, 15 May 2023 16:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242440AbjEOQWO (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 15 May 2023 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242192AbjEOQWN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 15 May 2023 12:22:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1663A30F0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 09:21:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3f38824a025so1506811cf.0
        for <linux-perf-users@vger.kernel.org>; Mon, 15 May 2023 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684167711; x=1686759711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jvq2CNWQkZWNW3MsZokYYrlPwDDtt8hmc7eDmpJCQ6I=;
        b=WEKFeghZHl1B4CtqbHqD3XOCFfybPeKo7uv5koeXZIR6qOEQYgkSXKm6Q3HzQd0zXw
         ESpmeBR/URegZW4U0M8D+m1TIxAQXD5p7n3juIo4IbeRsl2UdR/sm4mQsUMzRJ/8rjWQ
         B72edvl8LgZ9BS9K3nLVby1RjS1L5Q88I90nY2g65OntfsBQeAwSmrh8waMpbKGrOvr6
         xzliwJScAYb8p5vMkNz3jTWLheMaFHASW53yj4XFdfq3AxUjwxSwgusntSmbUUWAoSGD
         ZNdzMTl2A9KCEH9DRWWaNgGMuJfJWIL8oh3rKRoeC44qFCjV05c/5g0cKPcGDhs/1+rC
         hVbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684167711; x=1686759711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jvq2CNWQkZWNW3MsZokYYrlPwDDtt8hmc7eDmpJCQ6I=;
        b=jRrIVsDPRsWWN2vHUBJILxxIyt1VO7pysPezBJ+ZFxA+a103H8JL75/vsf74QGTi54
         ukYxPcUq9nDWG4p8Ki5ay/gChYZ/szJRoUtJe3rYCAIjCdMy7Sm+cXQghiAd4iPW/ZYk
         O/i+4Wkab0oLUdlTUfZe+Bcl9dVL6t74v/ru/0pxcrtoiz0jOm4bds4/f4QScRbcApgJ
         qaOXaTC6aOy6OS58oAERLHM+0Sv+G/O8xawZqvB+mgdxoCxtnD55NQ32i1E8WlSwMr4e
         LwJDPRlUWNkVS4agnEZBTfxE8YjZxBhkxW4NHqO65DvID4kg8AmbY8JNykmtCUWXvNSK
         AteQ==
X-Gm-Message-State: AC+VfDzbKLJlfNX9X2qmW4d1oFV76GOVNxCSs10LUe23lYN37xvpZJOw
        sgcFDKKR+KI+9+9JS0TzJPGWG8Qz4xfTZ0DorPl2B/uQ0mfpm8FXf53PqA==
X-Google-Smtp-Source: ACHHUZ7Z4n8LyjNAXoexOTxTeUyTa4UKcxiUv4eqlCG5dbbv+KGC4+RG665GhsfyVs4j7HT9FvuZtn5nYILvNoWQcNs=
X-Received: by 2002:a05:622a:c3:b0:3db:1c01:9d95 with SMTP id
 p3-20020a05622a00c300b003db1c019d95mr1221385qtw.4.1684167710615; Mon, 15 May
 2023 09:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fXKi+VAr-_n5tAaJ7Z2fvU7jc5N-CKCjkCAh_01_pzMfA@mail.gmail.com>
 <20230505082832.GA1770668@hirez.programming.kicks-ass.net> <CAP-5=fV0_d8JmPXx8AgFRcO21H43bJHDojxVT4NJoepVnkTW8Q@mail.gmail.com>
In-Reply-To: <CAP-5=fV0_d8JmPXx8AgFRcO21H43bJHDojxVT4NJoepVnkTW8Q@mail.gmail.com>
From:   Ian Rogers <irogers@google.com>
Date:   Mon, 15 May 2023 09:21:39 -0700
Message-ID: <CAP-5=fX_tfGZP8r6Dvmt6C+Jw2A9ZGZ2u3YtUPyYcKjvJTN6oQ@mail.gmail.com>
Subject: Re: uapi vs kernel headers
To:     linux-perf-users <linux-perf-users@vger.kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Fri, May 5, 2023 at 7:07=E2=80=AFAM Ian Rogers <irogers@google.com> wrot=
e:
>
> On Fri, May 5, 2023 at 1:28=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
> >
> > On Thu, May 04, 2023 at 03:36:48PM -0700, Ian Rogers wrote:
> > > Hi,
> > >
> > > when the C compiler builds perf the priority of the "-I" flags is lef=
t
> > > to right. This means that in the perf build:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/t=
ools/perf/Makefile.config?h=3Dperf-tools-next#n355
> > > if the build is looking for <linux/types.h> then whereas most project=
s
> > > would expect that to come from /usr/include/linux/types.h (which
> > > matches the uapi version) perf actually builds with the kernel versio=
n
> > > (tools/include/linux/types.h). The kernel version will declare types
> > > like u64 that are __u64 in the uapi code, so reversing the include
> > > order massively breaks the build as u64 and many associated types are
> > > missing.
> > >
> > > It almost feels accidental that perf does things this way, and it
> > > feels more obvious if perf were to reverse the include order and deal
> > > with the fall-out in the code (ie perf's linux/types.h would agree
> > > more with what normal projects have). Perhaps perf needs its own
> > > types.h to minimize the fallout. I wondered what more general opinion=
s
> > > on this were? Is this something that should be fixed?
> >
> > Doesn't perf have to prioritize the kernel headers because it needs the
> > latest version of the perf uapi -- and not some random old version the
> > system headers might have?
>
> Yep. I have no problem with using the tools/kernel headers, the issue
> is that we prefer the non-uapi headers, like linux/types.h over the
> uapi headers, which feels odd.

Hi,

So I remain curious to see if we should reorder the include order to
prefer uapi over kernel headers - both being the latest. There was
some related order issues in BPF compilation for perf that came up
recently:
https://lore.kernel.org/linux-perf-users/CAP-5=3DfXvxpOJoKF_YsB=3DdY=3D+pyF=
nGSaOgUrEFa4mYA0uzDLxhQ@mail.gmail.com/

Thanks,
Ian


> Thanks,
> Ian
