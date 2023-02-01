Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9C4C05027
	for <linux-perf-users@archiver.kernel.org>; Wed,  1 Feb 2023 09:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjBAJeT (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Wed, 1 Feb 2023 04:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbjBAJeS (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Wed, 1 Feb 2023 04:34:18 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E8D28D13
        for <linux-perf-users@vger.kernel.org>; Wed,  1 Feb 2023 01:34:17 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-501c3a414acso238066807b3.7
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Feb 2023 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWSgBLB/d7CBkiS7vUeRrl+u5WlVlYA2/RDeWKtD4s=;
        b=bVa6yGtrbg7X54zNXj3nrQQADqcWyif95t7Tpgktx+hZ+nQxcoC8M2mGx+4jdvE+p1
         cjVHphe0Kn8DXQryEt/Hp/bjA5K1wHoMwGl0dz9LfD6eUDlZWL+mKYIk0SXI6gEqWvfA
         g5opR0g/nF8uRKATRfp91PHqQYHEX/eUWpHAhK8LFt2ZY7Dfi7WfcJneOMHsRqVT+xtz
         sq9qCoYkZJN3Z9I6wG1qKahOuOvt9f8gkdQB9qNZkAGen8epRUTEEJtTc575m4Q+C1B1
         hMCi4cBpMEm88PNR8VZLGCQY3BCX/0dds6L8a7XWQgQGvmL52HudtxZD0Jslcje1dhZ/
         BYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhWSgBLB/d7CBkiS7vUeRrl+u5WlVlYA2/RDeWKtD4s=;
        b=Ls4JwVaqih+pqU5QvVfTH6i1Q0Kw/DmM8CKKGRsQqQ+d3DvLKfbt/yu7p9MyvqKlee
         dRih8oZMS3TaEPMcmquqVQzaHp7wryF16nB+e/NSWItxlbNR8ten49SJrcDv4r+3wPsg
         wBpi/W46tbJA+PZ3fM7MuzlgCw+MSTr4cWuSKdZPKAli+y67STHEMfVzY5RubyQiBiyo
         W5PVUZv7HTNbT4aLC+NJJ71jCzPdLKAsh+j5KaM6+QdJIrFSrpwELntXJcUmDhUquLuN
         rXA6xoJwTDqsZChPevswwkfrVvt8TzELfxMH8DLtwFqTJHC4RKOdh+feuqYwXtqCK7ic
         Pk+Q==
X-Gm-Message-State: AO0yUKXMuITnqst6Df0ZMpc5Dg6Dlv6oTw+sOcYnnSvuuhhZIo6vYQX0
        MSAPlk2E3p5KK2umYllkO6CBVtGyNmDdhp7iZROMIg==
X-Google-Smtp-Source: AK7set85DUWKc2v6zBheFw+i+qRyYX8wNKafC0i6wlEmLLx9nxLNChCq4IX/VQmJmD1rBU/5J52AObA7BfAxiJlPCF4=
X-Received: by 2002:a81:fe02:0:b0:506:369c:69c1 with SMTP id
 j2-20020a81fe02000000b00506369c69c1mr221926ywn.192.1675244056986; Wed, 01 Feb
 2023 01:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20230127162409.2505312-1-elver@google.com> <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com> <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
In-Reply-To: <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Feb 2023 10:33:40 +0100
Message-ID: <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user addresses
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
[...]
> > This again feels like a deficiency with access_ok(). Is there a better
> > primitive than access_ok(), or can we have something that gives us the
> > guarantee that whatever it says is "ok" is a userspace address?
>
> I don't think so, since this is contextual and temporal -- a helper can't give
> a single correct answert in all cases because it could change.

That's fair, but unfortunate. Just curious: would
copy_from_user_nofault() reliably fail if it tries to access one of
those mappings but where access_ok() said "ok"?

Though that would probably restrict us to only creating watchpoints
for addresses that are actually mapped in the task.

> In the cases we switch to another mapping, we could try to ensure that we
> enable/disable potentially unsafe watchpoints/breakpoints.

That seems it'd be too hard to reason that it's 100% safe, everywhere,
on every arch. I'm still convinced we can prohibit creation of such
watchpoints in the first place, but need something other than
access_ok().

> Taking a look at arm64, our idmap code might actually be ok, since we usually
> mask all the DAIF bits (and the 'D' or 'Debug' bit masks HW
> breakpoints/watchpoints). For EFI we largely switch to another thread (but not
> always), so that would need some auditing.
>
> So if this only needs to work in per-task mode rather than system-wide mode, I
> reckon we can have some save/restore logic around those special cases where we
> transiently install a mapping, which would protect us.

It should only work in per-task mode.

> For the threads that run with special mappings in the low half, I'm not sure
> what to do. If we've ruled out system-wide monitoring I believe those would be
> protected from unprivileged users.

Can the task actually access those special mappings, or is it only
accessible by the kernel?

Thanks,
-- Marco
