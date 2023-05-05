Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AD1C77B7C
	for <linux-perf-users@archiver.kernel.org>; Fri,  5 May 2023 14:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjEEOH3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 5 May 2023 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjEEOH2 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 5 May 2023 10:07:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D23411DA0
        for <linux-perf-users@vger.kernel.org>; Fri,  5 May 2023 07:07:27 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-3ef36d814a5so1075261cf.0
        for <linux-perf-users@vger.kernel.org>; Fri, 05 May 2023 07:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683295646; x=1685887646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s6mZ98r1CEkcuTf/+z3h4Qdss1a806smK+XLwNs5T/w=;
        b=ZNGUVgnYGNJBMh+SBcFd5W+Ld8RBMwH52mwDUGCoy80M6C/5rDoKUsW6qJvvQ3t4iS
         14Hd6xPA+nFCXFpiqkm/acSfmO0rvIoaELEgmub0Fy8TJboK69T3GiIvo0vZ/UIsnwoT
         kF8xPOh+YM2yqBiQQLePtk0RRMXbfeXt3pMtzr/4C85P2Bw/PHjNk1EPE7iapu+pHYjV
         T6g22zEdX95Co4sPV/AWprGp2RbAGOV37M/SAZnrRFhaaF+uNcamsifYGzmxMXPtlcgM
         gBmBjmdnttdJZiS09G/ppCT6fnz3IB1No7wySLcStl550C0sdgS8V4+KV5cWEu1/PUNS
         bQ0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683295646; x=1685887646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s6mZ98r1CEkcuTf/+z3h4Qdss1a806smK+XLwNs5T/w=;
        b=Q33s/DHjtcIpqD3DgE+KIVqL+S4T1FqUU2ND3B025BO6n3tbiWXqeaUCBaqDGKdclQ
         1JMhwYQqY39oqTFtmHN+7G7hfNY3AigSNoo8YwwjYPy0V6yHTyy9BTjyu5uN+Zq28ZFN
         6ceTYQgX5fXbq2zFo7VeECUL+91+dzPs9+qqJTzyEXGkQCjpqjv7/wkUCR/Bfj8e066S
         Sby6ehwiqehbOtmOqYRoXHKyEWlCRLH+CeN+R41tvYiWhRA2FJYQKBd//71rTIR2Ufiz
         dmo6I9cKvdFTxYdtfykiYtGLq3jg9SshIOhHYa9sjE2JvcqC/XXTSdenm/IZsqZYbdFw
         gU1A==
X-Gm-Message-State: AC+VfDxQ7eLPBzfhq1z5QPc1uG+KRKa7ZTn1SkPBNo8oB3Nx81OWD5/y
        /SWCTVVdOf4eoVzG1tZKOdeHiBeuMLIyfKQrWwdTRg==
X-Google-Smtp-Source: ACHHUZ6UE8hE3R3mPQfMESrltuJvBJrn35gH8EFvsaFdr7K/TBHEZuqIODBZ2GVe5nhvC61LMwVfUxTaDWfKeB+L5xY=
X-Received: by 2002:ac8:5712:0:b0:3ef:302c:319e with SMTP id
 18-20020ac85712000000b003ef302c319emr216449qtw.8.1683295646301; Fri, 05 May
 2023 07:07:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAP-5=fXKi+VAr-_n5tAaJ7Z2fvU7jc5N-CKCjkCAh_01_pzMfA@mail.gmail.com>
 <20230505082832.GA1770668@hirez.programming.kicks-ass.net>
In-Reply-To: <20230505082832.GA1770668@hirez.programming.kicks-ass.net>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 5 May 2023 07:07:15 -0700
Message-ID: <CAP-5=fV0_d8JmPXx8AgFRcO21H43bJHDojxVT4NJoepVnkTW8Q@mail.gmail.com>
Subject: Re: uapi vs kernel headers
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-perf-users <linux-perf-users@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

On Fri, May 5, 2023 at 1:28=E2=80=AFAM Peter Zijlstra <peterz@infradead.org=
> wrote:
>
> On Thu, May 04, 2023 at 03:36:48PM -0700, Ian Rogers wrote:
> > Hi,
> >
> > when the C compiler builds perf the priority of the "-I" flags is left
> > to right. This means that in the perf build:
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/tree/too=
ls/perf/Makefile.config?h=3Dperf-tools-next#n355
> > if the build is looking for <linux/types.h> then whereas most projects
> > would expect that to come from /usr/include/linux/types.h (which
> > matches the uapi version) perf actually builds with the kernel version
> > (tools/include/linux/types.h). The kernel version will declare types
> > like u64 that are __u64 in the uapi code, so reversing the include
> > order massively breaks the build as u64 and many associated types are
> > missing.
> >
> > It almost feels accidental that perf does things this way, and it
> > feels more obvious if perf were to reverse the include order and deal
> > with the fall-out in the code (ie perf's linux/types.h would agree
> > more with what normal projects have). Perhaps perf needs its own
> > types.h to minimize the fallout. I wondered what more general opinions
> > on this were? Is this something that should be fixed?
>
> Doesn't perf have to prioritize the kernel headers because it needs the
> latest version of the perf uapi -- and not some random old version the
> system headers might have?

Yep. I have no problem with using the tools/kernel headers, the issue
is that we prefer the non-uapi headers, like linux/types.h over the
uapi headers, which feels odd.

Thanks,
Ian
