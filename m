Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846CEC433F5
	for <linux-perf-users@archiver.kernel.org>; Tue, 17 May 2022 03:13:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiEQDN1 (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Mon, 16 May 2022 23:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239648AbiEQDNV (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Mon, 16 May 2022 23:13:21 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B5E440A13;
        Mon, 16 May 2022 20:13:20 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id e189so20910737oia.8;
        Mon, 16 May 2022 20:13:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PWhv8SUJ7Zi/KQsr7OOR1d8BfvT5pK75grSbAtZ3mLs=;
        b=l0nfXAAVQbga+lEfnM7gmAl2xbS58DEieZl9riWRs02jOjfjdZ9/o3t+JCx//KnStW
         DmG73SRzvvxnmvh4oBZ48nxHeCHQEFUUVsU7mqWQgial8ELwN+41LsqbXQxLl8o5ekyt
         jI9yF4999oThvsWikeEEY+3H3C81hMDtXjOSbsTnR3h7feSB11ERI6pKS7P2UmnbdBcn
         VgqBxoLPcgRW15cFtDnvY9Yt3j8MwPdxdwi2Bqw9ynyNBLqyTDCMLwtMunZ5SxhilMsu
         ziThsoytp7G7LQdaLKtIfXxrrgVPcFKDQ5ljFi8cnj2dyPNVwTaIEya+sDJUgsyCXV7u
         sSPQ==
X-Gm-Message-State: AOAM5304WRnHaz+yLl/CTaGMarLq/LTWwx18S1BvIs/D22dTgEK56fEC
        hkvxPA9lcFjZ2FDwYYxuCviQJQW9ACERv83Pt8U=
X-Google-Smtp-Source: ABdhPJw/s9VGkv+VwVcVjajwVKXNJB//UKWE7QSo6EgoadpgYV01Q+mpv6cZ6Ihl1BzegtnGy0ujzQO2o8Qcz0bYTjc=
X-Received: by 2002:a05:6808:2218:b0:326:bd8c:d044 with SMTP id
 bd24-20020a056808221800b00326bd8cd044mr9426742oib.92.1652757199897; Mon, 16
 May 2022 20:13:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220513090237.10444-1-adrian.hunter@intel.com> <20220513090237.10444-4-adrian.hunter@intel.com>
In-Reply-To: <20220513090237.10444-4-adrian.hunter@intel.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 16 May 2022 20:13:08 -0700
Message-ID: <CAM9d7chFeVZNm_WTqrLzv74U13RPQtTvezxbP41GLte+ir6P_A@mail.gmail.com>
Subject: Re: [PATCH 3/6] perf tools: Add guest_code support
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        KVM <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Adrian,

On Fri, May 13, 2022 at 2:03 AM Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> A common case for KVM test programs is that the guest object code can be
> found in the hypervisor process (i.e. the test program running on the
> host). To support that, copy the host thread's maps to the guest thread's
> maps. Note, we do not discover the guest until we encounter a guest event,
> which works well because it is not until then that we know that the host
> thread's maps have been set up.
>
> Typically the main function for the guest object code is called
> "guest_code", hence the name chosen for this feature.

Ok, so that's just a convention and there's no hard-coded
support for the "guest_code" function in this code, right?

>
> This is primarily aimed at supporting Intel PT, or similar, where trace
> data can be recorded for a guest. Refer to the final patch in this series
> "perf intel-pt: Add guest_code support" for an example.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/event.c       |  7 +++-
>  tools/perf/util/machine.c     | 70 +++++++++++++++++++++++++++++++++++
>  tools/perf/util/machine.h     |  2 +
>  tools/perf/util/session.c     |  7 ++++
>  tools/perf/util/symbol_conf.h |  3 +-
>  5 files changed, 86 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/event.c b/tools/perf/util/event.c
> index 6439c888ae38..0476bb3a4188 100644
> --- a/tools/perf/util/event.c
> +++ b/tools/perf/util/event.c
> @@ -683,9 +683,12 @@ static bool check_address_range(struct intlist *addr_list, int addr_range,
>  int machine__resolve(struct machine *machine, struct addr_location *al,
>                      struct perf_sample *sample)
>  {
> -       struct thread *thread = machine__findnew_thread(machine, sample->pid,
> -                                                       sample->tid);
> +       struct thread *thread;
>
> +       if (symbol_conf.guest_code && !machine__is_host(machine))
> +               thread = machine__findnew_guest_code(machine, sample->pid);
> +       else
> +               thread = machine__findnew_thread(machine, sample->pid, sample->tid);
>         if (thread == NULL)
>                 return -1;
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index e67b5a7670f3..ae2e1fb422e2 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -392,6 +392,76 @@ struct machine *machines__find_guest(struct machines *machines, pid_t pid)
>         return machine;
>  }
>
> +/*
> + * A common case for KVM test programs is that the guest object code can be
> + * found in the hypervisor process (i.e. the test program running on the host).
> + * To support that, copy the host thread's maps to the guest thread's maps.
> + * Note, we do not discover the guest until we encounter a guest event,
> + * which works well because it is not until then that we know that the host
> + * thread's maps have been set up.
> + */
> +static struct thread *findnew_guest_code(struct machine *machine,

But this function returns a thread and IIUC that's the task which
does the host to guest transition.  Then why not calling it just
findnew__hypervisor() ?

Thanks,
Namhyung


> +                                        struct machine *host_machine,
> +                                        pid_t pid)
> +{
> +       struct thread *host_thread;
> +       struct thread *thread;
> +       int err;
> +
> +       if (!machine)
> +               return NULL;
> +
> +       thread = machine__findnew_thread(machine, -1, pid);
> +       if (!thread)
> +               return NULL;
> +
> +       /* Assume maps are set up if there are any */
> +       if (thread->maps->nr_maps)
> +               return thread;
> +
> +       host_thread = machine__find_thread(host_machine, -1, pid);
> +       if (!host_thread)
> +               goto out_err;
> +
> +       thread__set_guest_comm(thread, pid);
> +
> +       /*
> +        * Guest code can be found in hypervisor process at the same address
> +        * so copy host maps.
> +        */
> +       err = maps__clone(thread, host_thread->maps);
> +       thread__put(host_thread);
> +       if (err)
> +               goto out_err;
> +
> +       return thread;
> +
> +out_err:
> +       thread__zput(thread);
> +       return NULL;
> +}
> +
