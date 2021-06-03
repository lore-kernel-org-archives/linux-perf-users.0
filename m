Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83887C47082
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D7EE61402
	for <linux-perf-users@archiver.kernel.org>; Thu,  3 Jun 2021 23:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbhFCXEX (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Thu, 3 Jun 2021 19:04:23 -0400
Received: from mail-ej1-f54.google.com ([209.85.218.54]:38521 "EHLO
        mail-ej1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhFCXEX (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 3 Jun 2021 19:04:23 -0400
Received: by mail-ej1-f54.google.com with SMTP id og14so6314991ejc.5;
        Thu, 03 Jun 2021 16:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=NYpcrUNiLcsOZAXAtknUpjfz3k6LyTw1gP/lM5pt/8Y=;
        b=NnzxAdM5hXb/P1M6I2y/Ha3S32u9L6sCl4gYrU41dmMmiCvAWmBTxtYDh5bI85sDsi
         X7Zbxh+C6yZYn4lUA/GGaXIfJ7ehhyq0h3hu9PFD52+9eTzVATtVNcwdWPXhnTb4wRfU
         ln35a60owcjq0U9izacZBJTFDyATvr8t/ZvneNLQIMmtN6zfPJ7n7DApsxC94SyhfMRU
         yJ0ywYj5VN3Z5k7p6uS4SjnGO5lEVOpiT+aIpqovdSMfCzReMkdtDOyGW/NDkros459T
         zVZntf9Vs0oL5b4dakT24uiVnIGC6SIERTyTf5BY7eY0rfN+L7uO1LAX9TeMARnhWhEn
         bdtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NYpcrUNiLcsOZAXAtknUpjfz3k6LyTw1gP/lM5pt/8Y=;
        b=szETCIomvV4Ik/sDW5WrKPRRQTljlrgfhxY+mv0aSFlLX2T7Jr4jNw/X6La4AEOHhT
         czcDnvp0GrdtCGvPQHYRx9UiMM9SGQwYYtfouT0VtcZV9iBmtZiF6u2+J2yfcUFiezD8
         FPQCEmhekJaBqeueqberUtpZQft+GU1plvPHUcVMeMzL++gU7dgut8AEdB48AnZygoH8
         RGAVeFFivA68WF67n1KoeurZe9JZiOeTKyXUziLDN9s43iWa3lEhyx5+j6IhmqyW7MrU
         z27YUoJVG12w/y94GdfPbShvPqBoDw3SXZre0i8bpNN8Aj4/MZ8x0TE22qYpypOSV2c7
         wk0Q==
X-Gm-Message-State: AOAM531rvd8m9ebj5t+2K5/7i28+G1hDNbwgX+3ponwzdqNwVd+br9MK
        oJtQ0WpWoqdvg2bhRBrqyns=
X-Google-Smtp-Source: ABdhPJzNrGH0cc7RhLhy/s/9Q5VOycD27D6j7NEPA0KKDEFNQooVX59uD4WGC0e0ypFVvWJL7r3HPg==
X-Received: by 2002:a17:906:7d0:: with SMTP id m16mr1411579ejc.319.1622761283387;
        Thu, 03 Jun 2021 16:01:23 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id r19sm2393816eds.75.2021.06.03.16.01.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 16:01:19 -0700 (PDT)
Message-ID: <9df174c09795b1f8e42f1ac31877a6ea9d3ecae3.camel@gmail.com>
Subject: Re: [PATCH v6 05/20] perf record: Start threads in the beginning of
 trace streaming
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Date:   Fri, 04 Jun 2021 01:01:17 +0200
In-Reply-To: <bdbb55a052ced7adf7f2d16cbc4c7c5507b7c0e3.1622025774.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1622025774.git.alexey.v.bayduraev@linux.intel.com>
         <bdbb55a052ced7adf7f2d16cbc4c7c5507b7c0e3.1622025774.git.alexey.v.bayduraev@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Wed, 2021-05-26 at 13:52 +0300, Alexey Bayduraev wrote:
> Start thread in detached state because its management is implemented
> via messaging to avoid any scaling issues. Block signals prior thread
> start so only main tool thread would be notified on external async
> signals during data collection. Thread affinity mask is used to assign
> eligible cpus for the thread to run. Wait and sync on thread start using
> thread ack pipe.
> 
> Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
> ---
>  tools/perf/builtin-record.c | 106 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 105 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> index 838c1f779849..88fad12cbe5b 100644
> --- a/tools/perf/builtin-record.c
> +++ b/tools/perf/builtin-record.c
> @@ -1423,6 +1423,66 @@ static void record__thread_munmap_filtered(struct
> fdarray *fda, int fd,
>                 perf_mmap__put(map);
>  }
>  
> +static void *record__thread(void *arg)
> +{
> +       enum thread_msg msg = THREAD_MSG__READY;
> +       bool terminate = false;
> +       struct fdarray *pollfd;
> +       int err, ctlfd_pos;
> +
> +       thread = arg;
> +       thread->tid = syscall(SYS_gettid);
> +
> +       err = write(thread->pipes.ack[1], &msg, sizeof(msg));
> +       if (err == -1)
> +               pr_err("threads[%d]: failed to notify on start: %s", thread-
> >tid, strerror(errno));
> +
> +       pr_debug("threads[%d]: started on cpu=%d\n", thread->tid,
> sched_getcpu());
> +
> +       pollfd = &thread->pollfd;
> +       ctlfd_pos = thread->ctlfd_pos;
> +
> +       for (;;) {
> +               unsigned long long hits = thread->samples;
> +
> +               if (record__mmap_read_all(thread->rec, false) < 0 ||
> terminate)
> +                       break;
> +
> +               if (hits == thread->samples) {
> +
> +                       err = fdarray__poll(pollfd, -1);
> +                       /*
> +                        * Propagate error, only if there's any. Ignore
> positive
> +                        * number of returned events and interrupt error.
> +                        */
> +                       if (err > 0 || (err < 0 && errno == EINTR))
> +                               err = 0;
> +                       thread->waking++;
> +
> +                       if (fdarray__filter(pollfd, POLLERR | POLLHUP,
> +                                           record__thread_munmap_filtered,
> NULL) == 0)
> +                               break;
> +               }
> +
> +               if (pollfd->entries[ctlfd_pos].revents & POLLHUP) {
> +                       terminate = true;
> +                       close(thread->pipes.msg[0]);
> +                       pollfd->entries[ctlfd_pos].fd = -1;
> +                       pollfd->entries[ctlfd_pos].events = 0;
> +               }
> +
> +               pollfd->entries[ctlfd_pos].revents = 0;
> +       }
> +       record__mmap_read_all(thread->rec, true);
> +
> +       err = write(thread->pipes.ack[1], &msg, sizeof(msg));
> +       if (err == -1)
> +               pr_err("threads[%d]: failed to notify on termination: %s",
> +                      thread->tid, strerror(errno));
> +
> +       return NULL;
> +}
> +
>  static void record__init_features(struct record *rec)
>  {
>         struct perf_session *session = rec->session;
> @@ -1886,13 +1946,57 @@ static int record__terminate_thread(struct thread_data
> *thread_data)
>  
>  static int record__start_threads(struct record *rec)
>  {
> +       int t, tt, ret = 0, nr_threads = rec->nr_threads;
>         struct thread_data *thread_data = rec->thread_data;
> +       sigset_t full, mask;
> +       pthread_t handle;
> +       pthread_attr_t attrs;
> +
> +       sigfillset(&full);
> +       if (sigprocmask(SIG_SETMASK, &full, &mask)) {
> +               pr_err("Failed to block signals on threads start: %s\n",
> strerror(errno));
> +               return -1;
> +       }
> +
> +       pthread_attr_init(&attrs);
> +       pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
> +
> +       for (t = 1; t < nr_threads; t++) {
> +               enum thread_msg msg = THREAD_MSG__UNDEFINED;
> +
> +               pthread_attr_setaffinity_np(&attrs,
> +                                          
> MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
> +                                           (cpu_set_t *)(thread_data[t].mask-
> >affinity.bits));
> +
> +               if (pthread_create(&handle, &attrs, record__thread,
> &thread_data[t])) {
> +                       for (tt = 1; tt < t; tt++)
> +                               record__terminate_thread(&thread_data[t]);
> +                       pr_err("Failed to start threads: %s\n",
> strerror(errno));
> +                       ret = -1;
> +                       goto out_err;
> +               }
> +
> +               if (read(thread_data[t].pipes.ack[0], &msg, sizeof(msg)) > 0)
> +                       pr_debug2("threads[%d]: sent %s\n", rec-
> >thread_data[t].tid,
> +                                thread_msg_tags[msg]);
> +       }
> +
> +       if (nr_threads > 1) {
> +               sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread_data[0].mask-
> >affinity),
> +                                 (cpu_set_t *)thread_data[0].mask-
> >affinity.bits);
> +       }
>  
>         thread = &thread_data[0];
>  
>         pr_debug("threads[%d]: started on cpu=%d\n", thread->tid,
> sched_getcpu());
>  
> -       return 0;
> +out_err:
> +       if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
> +               pr_err("Failed to unblock signals on threads start: %s\n",
> strerror(errno));
> +               ret = -1;
> +       }
> +
> +       return ret;
>  }

ASan complains of a memory leak of the attrs, since pthread_attr_destroy is
missing. It could be added just after out_err label.

Thanks,
Riccardo

>  
>  static int record__stop_threads(struct record *rec, unsigned long *waking)


