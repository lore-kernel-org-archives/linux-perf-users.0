Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4A3C433EF
	for <linux-perf-users@archiver.kernel.org>; Fri, 10 Dec 2021 12:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240916AbhLJM1M (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 10 Dec 2021 07:27:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21814 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240915AbhLJM1M (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 10 Dec 2021 07:27:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639139017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KioUMvWRyu6MZM3/L8Y/jHqD4lh7+63A4Z1HNFMR0vs=;
        b=ZyIse436iYxUfu9pcmMFojUfgCR6exzMGUBs81GPP9khsfGQija1gYI6sxxDz2cpQoWnu5
        mz2fqMzHrmX2eQnIrN+d+FSC1/xbl7c3OE2QdB1TNhRaktzgCCW6BjwnBgBeCyL4mgITtH
        QJQQOTWnjs7Ogwxm1bA6+zlIlrsgxQ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-51-IibnnIvdNNCcmJaF9e_KSA-1; Fri, 10 Dec 2021 07:23:36 -0500
X-MC-Unique: IibnnIvdNNCcmJaF9e_KSA-1
Received: by mail-wm1-f72.google.com with SMTP id j71-20020a1c234a000000b00342f418ae7cso6600668wmj.1
        for <linux-perf-users@vger.kernel.org>; Fri, 10 Dec 2021 04:23:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KioUMvWRyu6MZM3/L8Y/jHqD4lh7+63A4Z1HNFMR0vs=;
        b=YYEq8bnL9TizOxFT9bX5l2ELMzHugPI8bzay2BnMJ7mnXlWzF4kuw3bl60NcmGMm74
         7tx8qhDyr3jLKhKoql9K83/KvU4TAKegGq1fJUUPTm22T4CJCCTSO1r1F/ECFCyUd5jJ
         sh+TSyrS2ZE2grDbPcEKGjuK+9lzCtbOJYLIi9GCMrDKqO3LNzf517GV+pobN5fyycS+
         3yqmZA2vlO6PaRjkAk/vsU7JCU/fSmGArR2EKbtpmMYuHGZZ71C1DofGpyMC04eYSUuT
         HUy+7eItVSMCnNn8fuzqznLH4HoZusyAnBhG7yhnnTih9HleN/zFrdtWNgRJz8xnM8dP
         S91g==
X-Gm-Message-State: AOAM533f5IfT7KEd8X5RRJARRbP2F4j2C+L/YVRNQkleupERwbxgYfAh
        d4uHUKq9MVijoKB9ps+esXKGSYbcISE/SJv/BemfazpaEgct7sz31t49k4RmZg3z04UzyG6jvZe
        hjWAtwEMM9oyo47rUZPGpmR9I5Os1RA==
X-Received: by 2002:adf:f352:: with SMTP id e18mr13953158wrp.39.1639139014735;
        Fri, 10 Dec 2021 04:23:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZdAIQO1BeoJ43lLB5AhJ1t+/ESbqQBresHP3hRbQSRzO+zkD1RIkj4eHCsDEjipAo3EGUGA==
X-Received: by 2002:adf:f352:: with SMTP id e18mr13953136wrp.39.1639139014568;
        Fri, 10 Dec 2021 04:23:34 -0800 (PST)
Received: from krava ([83.240.60.218])
        by smtp.gmail.com with ESMTPSA id l5sm3298402wrs.59.2021.12.10.04.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 04:23:34 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:23:32 +0100
From:   Jiri Olsa <jolsa@redhat.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        "Frank Ch. Eigler" <fche@redhat.com>
Subject: Re: [RFC] perf record: Disable debuginfod by default
Message-ID: <YbNGxMAu5LYvqtpq@krava>
References: <20211209200425.303561-1-jolsa@kernel.org>
 <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cjyN_sxMe9yajgnuDRy5234NZQ5sd0e4ynBmCnQSv=WFQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, Dec 09, 2021 at 03:39:20PM -0800, Namhyung Kim wrote:
> Hi Jiri,
> 
> On Thu, Dec 9, 2021 at 12:04 PM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > hi,
> > after migrating to fedora 35 I found perf record hanging on exit
> > and it's because fedora 35 sets DEBUGINFOD_URLS that triggers
> > debuginfod query which might take long time to process.
> >
> > I discussed this briefly with Frank and I'm sending the change
> > to disable debuginfod by default in perf record.
> >
> > Frank had other idea we could discuss here to fork or just spawn
> > "/usr/bin/debuginfod-find ...." into background after perf record.
> >
> > Perhaps there are other ways as well, hence this is RFC ;-)
> 
> I thought the debuginfod was for perf report, not record.
> Maybe I'm missing something but how about moving it to
> report?  We can talk to debuginfod after checking the local
> build-id cache and binary on the system.

at the end of the perf record we populate buildid cache
with profiled binaries for the current perf.data

**IF** there's DEBUGINFOD_URLS defined, that code will
also ask debuginfod for binaries it could not find on
the system

> 
> Still, we can have perf buildid-cache to move it from the
> debuginfod to local cache.

yep, we have that already

jirka

