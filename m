Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19F72C05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Feb 2023 09:54:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjBAJyA (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjBAJx7 (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 04:53:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635174957D
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 01:53:58 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id o5so4071209ljj.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Feb 2023 01:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXBLBJgX4EaRecabGDlsbhKYn/5vHTxOlvqGwGoHBPg=;
        b=kGuhkOUGRiUBb82xnq/SP0PH18a2BT8S1d4JOz6WZAZJ1pjUkuD2ixPSt46h0gUfdn
         J3o7C+wF049nP5XsvuPSv8RTjjoa+/1JV25eSAFAAv2IOBY89cp3vnPTRwYpWB2pc5H6
         amZqseA7VDjMshiL4mh2kEhmuLUFXriQM27ALI2dFc8fl17ujHHsZznv3QFMa4A7hrgi
         XUJIrFiCgPSrYWwCLPGPLNvO0v5FGURdM1IFSgnm93n1+YkLwpLK3thl+ZyURoKwx/zO
         ocsJuUvX9Dq8NAHuAgOXho0n+QyU73sM+n8n5iF30fuV/k+QzbmwhlTNOMaOXeEE4xlr
         hIgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXBLBJgX4EaRecabGDlsbhKYn/5vHTxOlvqGwGoHBPg=;
        b=E+gRpISbVRuRodxvJ7cuszV1HCeDD+kCC2kK65H8akOdCRyL7jRL9luCPYmUTeijkN
         zXNwAYKoO0bfEzldQwabdBf+wlsRznOnp4mtuzaGBEv1ZbYDqe9MOjI8xoG1L8jV5O4K
         R16AzKaUVRFM+wF6sMs05L10Pn3Xi/n1TzYybotUc7eNiVQy1WfLH5C5YwPWhME4HCjk
         eE/OgW/VrcAcyZfrmzWMbTH2TQb0gGVpoQX9ut/ASn2+mOacBebyz0MzF6We2h32ZEob
         3C8uN1v3Iu5sQZt7PbZXdtvo0SKMXBcj5hx3RwjqJtwZaHdm1mRM9K6KEDhQ+39N9a/q
         eEsA==
X-Gm-Message-State: AO0yUKUV1h3QpFThjop1JEMKlZHiT4668yLjtkJ22iE012/d/ORAYLOx
        i4YuPiAaqGKnM2PQHvW2M5tglO4PkzdaGb8/QjcMkQ==
X-Google-Smtp-Source: AK7set/SnkQ6D+DOsTEIwKu7gH1tVuc4Aop2ZxyXy/5CnDm05inFo7TpmqVd2reBirxiOQVXt78QUDARAskOvz3HHq0=
X-Received: by 2002:a05:651c:231b:b0:290:7402:78a1 with SMTP id
 bi27-20020a05651c231b00b00290740278a1mr233501ljb.183.1675245236576; Wed, 01
 Feb 2023 01:53:56 -0800 (PST)
MIME-Version: 1.0
References: <20230127162409.2505312-1-elver@google.com> <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
 <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N> <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
In-Reply-To: <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 1 Feb 2023 10:53:44 +0100
Message-ID: <CACT4Y+Yriv_JYXm9N1YAMh+YuiT57irnF-vyCqxnTTux-2Ffwg@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user addresses
To:     Marco Elver <elver@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
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

On Wed, 1 Feb 2023 at 10:34, Marco Elver <elver@google.com> wrote:
>
> On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
> [...]
> > > This again feels like a deficiency with access_ok(). Is there a better
> > > primitive than access_ok(), or can we have something that gives us the
> > > guarantee that whatever it says is "ok" is a userspace address?
> >
> > I don't think so, since this is contextual and temporal -- a helper can't give
> > a single correct answert in all cases because it could change.
>
> That's fair, but unfortunate. Just curious: would
> copy_from_user_nofault() reliably fail if it tries to access one of
> those mappings but where access_ok() said "ok"?

I also wonder if these special mappings are ever accessible in a user
task context?
If yes, can a racing process_vm_readv/writev mess with these special mappings?

We could use copy_from_user() to probe that the watchpoint address is
legit. But I think the memory can be potentially PROT_NONE but still
legit, so copy_from_user() won't work for these corner cases.

> Though that would probably restrict us to only creating watchpoints
> for addresses that are actually mapped in the task.
>
> > In the cases we switch to another mapping, we could try to ensure that we
> > enable/disable potentially unsafe watchpoints/breakpoints.
>
> That seems it'd be too hard to reason that it's 100% safe, everywhere,
> on every arch. I'm still convinced we can prohibit creation of such
> watchpoints in the first place, but need something other than
> access_ok().
>
> > Taking a look at arm64, our idmap code might actually be ok, since we usually
> > mask all the DAIF bits (and the 'D' or 'Debug' bit masks HW
> > breakpoints/watchpoints). For EFI we largely switch to another thread (but not
> > always), so that would need some auditing.
> >
> > So if this only needs to work in per-task mode rather than system-wide mode, I
> > reckon we can have some save/restore logic around those special cases where we
> > transiently install a mapping, which would protect us.
>
> It should only work in per-task mode.
>
> > For the threads that run with special mappings in the low half, I'm not sure
> > what to do. If we've ruled out system-wide monitoring I believe those would be
> > protected from unprivileged users.
>
> Can the task actually access those special mappings, or is it only
> accessible by the kernel?
>
> Thanks,
> -- Marco
