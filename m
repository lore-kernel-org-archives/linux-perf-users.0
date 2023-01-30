Return-Path: <linux-perf-users-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DB8C54EAA
	for <linux-perf-users@archiver.kernel.org>; Mon, 30 Jan 2023 07:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231477AbjA3HAK (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 30 Jan 2023 02:00:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjA3HAJ (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 30 Jan 2023 02:00:09 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9ED6181
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Jan 2023 23:00:07 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id m199so12841446ybm.4
        for <linux-perf-users@vger.kernel.org>; Sun, 29 Jan 2023 23:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YevmuFxSkxWTJZuYLK3auP/ln6gsEkZmPuZuK5JXHz4=;
        b=HL6O2If/EMA+SEG6je5PgALJBHlr/+R+3PY2wdrQCU3wvO9mnmNvsh9aaO61I3fyRc
         3ARc+UhmJQykTUsq3E314Br0WN3CblaHfMif44cYVUTS+SeHQMrM9XVnK8DE0ZU4tt+c
         xxyxHwQ/LuwXZ12Fd5RGe53VTMYoc582L0SYAWF1qL1mqMeyWwiMTeQ7jRKgBB7/MM6r
         mTEyRdG5YraqNhOi8rU1PoD2EKphgFISOD+8sAlVbWuME75/xSKv2YwfFINjanPqjbjs
         1O9IfN0C9E8ZEQ7ZGjuazrp69RKxYInh728ZYOt3cbbL1sm+BZjy3Mic68SyTtVzrAtG
         9jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YevmuFxSkxWTJZuYLK3auP/ln6gsEkZmPuZuK5JXHz4=;
        b=fmxK9laFH3c5kYjl+N5XcwkpdjBk8Gvu16Q+oa0YfkX3husb9/b27a3hurR/+/TyJk
         hjABlN0cHiNdDd6WroOG0ozC4CeCbcZaBBebtgHAwYquiJTtaf7GA4tpN3yxZwhZ3m6l
         lYTOTcaOAMytE4ST7cnxwuDqZngviDk3qZKEnoBS+LysPPabjDCm89X7VDasbjDcsC3x
         4QCFewvISVB3Er91PBryWb68+W7/m9pj9VT1f8Jqk3Up7z5ncVswA7OYVsL+T6UtUl9M
         fCIvelGl77buKqIGBhbIQUWKiPkntYHm5JQfwqWhcaTCTqvFcCc3ddfRRhB17uGn3+HV
         3ivg==
X-Gm-Message-State: AO0yUKVlzGe85CT+z4VpqDCDFI80+4DHxzztJSBx3QZOUoFW7/kcrOP4
        EZnJJCLUKezLK823p6a3JfSPh1Y7hS7QJtrGwe4Psw==
X-Google-Smtp-Source: AK7set/6nLkKwtzlCdEbCgY14b7QoEWPAMsdcvj1ZwHpsPZB0mZjRgHUb2s7USI9RwXd/4jaqZH9cAJsNT+VZ7eeSbQ=
X-Received: by 2002:a5b:92:0:b0:80b:d161:ace9 with SMTP id b18-20020a5b0092000000b0080bd161ace9mr1690523ybp.143.1675062005661;
 Sun, 29 Jan 2023 23:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20230127162409.2505312-1-elver@google.com> <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
In-Reply-To: <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Mon, 30 Jan 2023 08:00:00 +0100
Message-ID: <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com>
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

On Fri, 27 Jan 2023 at 19:14, Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Marco,
>
> Apologies for having not replies on v1...
>
> On Fri, Jan 27, 2023 at 05:24:09PM +0100, Marco Elver wrote:
> > Allow the creation of restricted breakpoint perf events that also fire
> > in the kernel (perf_event_attr::exclude_kernel=0), if:
> >
> >   1. No sample information is requested; samples may contain IPs,
> >      registers, or other information that may disclose kernel addresses.
> >
> >   2. The breakpoint (viz. data watchpoint) is on a user address.
>
> I think there's a potential problem here w.r.t. what constitutes a "user
> address". Below, the patch assumes that any address which access_ok() is happy
> with is a user address, but that's not always the case, and it's not
> necessarily always safe to allow watchpoints on such addresses.

Isn't that a deficiency with access_ok()?

https://www.kernel.org/doc/html/latest/core-api/mm-api.html#c.access_ok
"Checks if a pointer to a block of memory in user space is valid. [...]"

> For example, UEFI runtime services may live in low adddresses below
> TASK_SIZE_MAX, and there are times when we run code in an idmap (or other
> low-half mapping) when we cannot safely take an exception for things like idle,
> suspend, kexec, pagetable rewriting on arm64, etc.
>
> So I think this may introduce functional issues (e.g. a mechanism to crash the
> kernel) in addition to any potential information disclosure, and I would not
> want this to be generally available to unprivileged users.
>
> Most of those happen in kernel threads, but they can also happen in the context
> of user threads (e.g. if triggering suspend/idle via sysfs), so special care
> will be needed, as above.

These are good points.

> > The rules constrain the allowable perf events such that no sensitive
> > kernel information can be disclosed.
> >
> > Despite no explicit kernel information disclosure, the following
> > questions may need answers:
> >
> >  1. Q: Is obtaining information that the kernel accessed a particular
> >     user's known memory location revealing new information?
> >
> >     A: Given the kernel's user space ABI, there should be no "surprise
> >     accesses" to user space memory in the first place.
>
> I think that may be true for userspace, but not true for other transient
> mappings in the low half of the address space. Ignoring the functional concern
> above, for idmap'd code this would at least provide a mechanism to probe for
> the phyiscal address of that code (and by extension, reveal the phyiscal
> location of the entire kernel).

This again feels like a deficiency with access_ok(). Is there a better
primitive than access_ok(), or can we have something that gives us the
guarantee that whatever it says is "ok" is a userspace address?

> >  2. Q: Does causing breakpoints on user memory accesses by the kernel
> >     potentially impact timing in a sensitive way?
> >
> >     A: Since hardware breakpoints trigger regardless of the state of
> >     perf_event_attr::exclude_kernel, but are filtered in the perf
> >     subsystem, this possibility already exists independent of the
> >     proposed change.
>
> Hmm... arm64's HW breakpoints and watchpoints have HW privilege filters, so I'm
> not sure the above statement is generally/necessarily true.

Right, I can see this being a valid concern on those architectures
that do support HW privilege filters.

> > Motivation:  Data breakpoints on user addresses that also fire in the
> > kernel provide complete coverage to track and debug accesses, not just
> > in user space but also through the kernel. For example, tracking where
> > user space invokes syscalls with pointers to specific memory.
> >
> > Breakpoints can be used for more complex dynamic analysis, such as race
> > detection, memory-safety error detection, or data-flow analysis. Larger
> > deployment by linking such dynamic analysis into binaries in production
> > only becomes possible when no additional capabilities are required by
> > unprivileged users. To improve coverage, it should then also be possible
> > to enable breakpoints on user addresses that fire in the kernel with no
> > additional capabilities.
>
> I can understand the argument for watchpoints (modulo my concerns above), but
> there's no need to support instruction breakpoints, right? i.e. there's no
> legitimate reason for a user to want to monitor a given user address
> system-wide, regardless of what's running?
>
> IIUC this only makes sense for watchpoints, and only in the context of a given
> task.

Right, there shouldn't be a need for instruction breakpoints, the
kernel shouldn't be executing user code.

Thanks,
-- Marco
