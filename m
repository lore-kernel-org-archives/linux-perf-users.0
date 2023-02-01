Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68304C05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Feb 2023 12:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjBAMB3 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:01:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBAMBN (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 07:01:13 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E32BF23
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 04:01:05 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id t12so19104413lji.13
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Feb 2023 04:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XkDaAs7NEt8L2ex9bykzKZqXj4em5dtmEAnn6lTD46I=;
        b=fYBQpmj9+BCFujF4ggobCLF8XcT7axTJSwBqGi4rHoqTmgZG3IV/eTiVL8hjJBWqxB
         cCItiSoVjZfEwznFZWj914HVyfoIwkePYVADQsQpNd7zQjY2m39QG4VL8t5PtpjGQ6Uj
         4fFqQ3ZKZUFm9//ZLWqnF8CN+KC+vnv9uv2Zwv9PiTcAM/mHP3dw9DeHjsPDel8ioSbk
         2Uxa1Irw1zYCEW17iQkT6X8OzIsQyeNiruRCkJya8biexSSyFupnHPGdoM//rC/KNWN2
         2wN7p2lN6oSIsg3ZnTV51I8FUU3ctF8Mu4k+FOQ5tnhOcinfq7J5uqKAQ6eLfBt8Z0P9
         j4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XkDaAs7NEt8L2ex9bykzKZqXj4em5dtmEAnn6lTD46I=;
        b=H1XPqs8Cg//rR0VsxrjUU9CheyZc91HS7QFd5r5H3JLRheYEUkJzD6leCiJ/sAiFpu
         CAUDWR9GIuxV/S8bYbefhjltzTd5Yw82hMNJa/Ryt48rYJU5+aCVLlWoEphFNyXDJQLy
         JmZk7aGF0R3gboDMc02AAAopJ27Hub5Of4Vd38bAvVe5tbGL/NyAuki1p51TpMtiadil
         qGiBjEoedfvU1mqeFLVjgVNj14QwkR90Kf/tfvQ9SGWbd47NiFIPIpM3xtHpBsQgbbDN
         Ol6vmga18mpPl1FhHa3qYRSz2nzVEKFqLCNtGyE6sd6e+rF2q9X9C2V7x414W72NuARJ
         OW8Q==
X-Gm-Message-State: AO0yUKXTMtsMOjF/94iG0vXgJRmMUmBn8tRC4WsdvoZE1WAQrPJ1T2J9
        zB1ABhSChk8B+xXzirTGQEFUFXGfPdbLPstJcsFlSg==
X-Google-Smtp-Source: AK7set+zVln3WH05zdXmKTDplM012eLlf6r2VhDXYbH6vrJMeKcnnpLEzXKgjxgvPsUsRQCoWkdKb7pqe3DO1S9pXCQ=
X-Received: by 2002:a05:651c:200a:b0:290:7c00:8cee with SMTP id
 s10-20020a05651c200a00b002907c008ceemr241094ljo.144.1675252864135; Wed, 01
 Feb 2023 04:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20230127162409.2505312-1-elver@google.com> <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
 <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N> <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
 <CACT4Y+Yriv_JYXm9N1YAMh+YuiT57irnF-vyCqxnTTux-2Ffwg@mail.gmail.com> <Y9pS4MNnFWOEO2Fr@FVFF77S0Q05N>
In-Reply-To: <Y9pS4MNnFWOEO2Fr@FVFF77S0Q05N>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 13:00:51 +0100
Message-ID: <CACT4Y+Y3E7nu7PGj3m6+83Hs_D=3dVZe4rBh5-Pn=Gsm07r-=g@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user addresses
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Wed, 1 Feb 2023 at 12:54, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Dmitry,
>
> We raced to reply here, so there's more detail in my reply to Marco. I'm
> providing minimal detail here, sorry for being terse! :)
>
> On Wed, Feb 01, 2023 at 10:53:44AM +0100, Dmitry Vyukov wrote:
> > On Wed, 1 Feb 2023 at 10:34, Marco Elver <elver@google.com> wrote:
> > >
> > > On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
> > > [...]
> > > > > This again feels like a deficiency with access_ok(). Is there a better
> > > > > primitive than access_ok(), or can we have something that gives us the
> > > > > guarantee that whatever it says is "ok" is a userspace address?
> > > >
> > > > I don't think so, since this is contextual and temporal -- a helper can't give
> > > > a single correct answert in all cases because it could change.
> > >
> > > That's fair, but unfortunate. Just curious: would
> > > copy_from_user_nofault() reliably fail if it tries to access one of
> > > those mappings but where access_ok() said "ok"?
> >
> > I also wonder if these special mappings are ever accessible in a user
> > task context?
>
> No. The special mappings are actually distinct page tables from the user page
> tables, so whenever userspace is executing and can issue a syscall, the user
> page tables are installed.
>
> The special mappings are only installed for transient periods within the
> context of a user task. There *might* be some latent issues with work happening
> in IPI context (e.g. perf user backtrace) on some architectures.
>
> > If yes, can a racing process_vm_readv/writev mess with these special mappings?
>
> No; those happen in task context, and cannot be invoked within the critical
> section where the page tables with the special mappings are installed.
>
> > We could use copy_from_user() to probe that the watchpoint address is
> > legit. But I think the memory can be potentially PROT_NONE but still
> > legit, so copy_from_user() won't work for these corner cases.
>
> Please see my other reply; ahead-of-time checks cannot help here. An address
> might be a legitimate user address and *also* transiently be a special mapping
> (since the two aare in entirely separate page tables).

This brings more clarity. Thanks for the explanations.

If addresses overlap, then it seems that the kernel must disable all
watchpoints while the mapping is installed. This patch tries to relax
checks, but CAP_ADMIN can install such watchpoints today. And they can
unintentionally break kernel, or produce false watchpoint triggers.
And if all watchpoints are disabled while the mapping is installed,
then this patch should be OK, right?
