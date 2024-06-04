Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71116FC3
	for <linux-perf-users@vger.kernel.org>; Tue,  4 Jun 2024 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717475190; cv=none; b=Lzg+hgueU4T98xwDCckPfDpqLuqvl+4Y+457hU6T9qOfQJMDlHEbNCtENc/5IVpLMh3eSMw9vAsp3qpEgcNapuvSYkS4d+Y6PdlzOac3QX1dynhy9IcFQVR+Ai6edqGlGZwhlsr0KiWmXLSNexXEgOFA12L1Q0eegrnOlTSYt5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717475190; c=relaxed/simple;
	bh=UBe4dT8Kt0rKzCNy+zhjBUAtBzsGcLdYgDGWmuY7aKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PO8pmNObOac8qiiUe6yTHFzaFc/F7yg/wVKzo8izbFsgNXywVrw+gWQS0gHv5BHgAYVpWO/mzTsvDmaOaefQ8s4uVbdqXorRyQh/Kf0Bqln/8fcyqVf98dm6nuO0NAyH1H7R4j0Bs+VkJKLfn3jbupqV4wANqNkqK59QRuYu8aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SfSZl8ju; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SfSZl8ju"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-60585faa69fso3413382a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 03 Jun 2024 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717475188; x=1718079988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2c0tU+/5SpZwwGdGwRUW1gzmMAZlOWxua95Jqvg17AQ=;
        b=SfSZl8ju91EEe0LqECHniOflItCvzSsxfBUdew+5H3yWb+pMb9lFvcFOH2Vcxh9c00
         VpoeC8zZUV9WOkpVb1D8jqHfan/zZrRWsDTRhclzxrqrntoMEhVF/xwRhu/l0+KWTpa/
         f+MlrFMrAUYzwW5Mknt2LCFZhXvyQYqrqia6waqlxVyOSlDed04bE+kpllCZzWOk+yoq
         wspbFchX5l5r3L7Wk4Xt2QSG7NdjyleJPAv5YJ7QtJTlO1YmT2kQE4BvDwTtfjAWr57Y
         PyU/A0VfqpOFc7PQtLOZN+1ovZ86EYs1pNu6+7ibXz3v5yK6UzjoPL4C8UaDriuKLp2e
         icTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717475188; x=1718079988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2c0tU+/5SpZwwGdGwRUW1gzmMAZlOWxua95Jqvg17AQ=;
        b=ZQ3tJHf9eBLBPRbKjxqSQpzJqIKFYKZf3obCCS/c7q8MDMUNHwSmkqmaTPcSRo3L/B
         Npw27nKtZpohPNmmV6qXt5Wel0KzAaGIooxXNUU12D+1YNiZ8UoQiR9Ke6IMbwdgeeYn
         i2HyrdfaNgCOLSvc1w+lp4dONajUsvK1pzM34iHE+YY4E2dg6/wVOx3+aYWxAMU4qpmj
         Fzpuo0UysDmLPlA26/Fx+Nbh+C5JhTparmK5pTk/lYDxn4+jvzKRPc9iE5gXQ1isskIL
         fUz62yCIZBgpJIrmQHZ/BD/pNmty5X0MhEmtQuGGhoRTNcld7mTpsLNR1SVKPsHfoPF4
         UAlw==
X-Forwarded-Encrypted: i=1; AJvYcCUnYV09GvP7kRmPp7wYV6GGUtReLLqkG9Eg93NebvmqGZJJxvNNtXC+LO3HT4n6px7YweFpwktJObFebXemaKk2PW3sbeN1YSZ9yWTIOjetDQ==
X-Gm-Message-State: AOJu0YzSvQC5/30ItEopRpXaJ/dreBC+u9NlFeR9iWmpMDTaTTdh2p+c
	YRm9D9U42BX5/4MVOzr07SVXP4x97qmF18XeV+RAYPxHy4B1ZuG7APBOgw==
X-Google-Smtp-Source: AGHT+IE8QxCN+1JbAkDjJlkWneYIDnNf52vAKGNDHWVqWtCQmjNtsyhZPgRSrfa4aRmjpiuv4g5xQg==
X-Received: by 2002:a05:6a20:dd88:b0:1a7:a644:4485 with SMTP id adf61e73a8af0-1b2a2c1d4bfmr1723891637.18.1717475187836;
        Mon, 03 Jun 2024 21:26:27 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:4401:24f0:463a:dd07:ae32:b61c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7025ee4fa8esm3704062b3a.149.2024.06.03.21.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 21:26:27 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
X-Google-Original-From: Namhyung Kim <namhyung@google.com>
To: Ian Rogers <irogers@google.com>
Cc: namhyung@kernel.org,
	Guilherme Amadio <amadio@cern.ch>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf mem segfaults
Date: Mon,  3 Jun 2024 21:26:14 -0700
Message-ID: <20240604042622.1930703-1-namhyung@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <CAP-5=fWyOhZDVQh+dpxQYRfSST6+v1wUTrm7gPwe5LTL_ir52w@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: namhyung@kernel.org

On Fri, 31 May 2024 10:02:18 -0700 Ian Rogers <irogers@google.com> wrote:

> On Fri, May 31, 2024 at 8:30 AM Guilherme Amadio <amadio@cern.ch> wrote:
> >
> > Hi Arnaldo,
> >
> > I reached some segfaults with perf mem, so I recompiled with DEBUG=1
> > and am sending below some stack traces. This is all with perf 6.9 for
> > now. The first one seems to pass a null pointer as format in frame #5,
> > along with a blank mem_loads_name:
> >
> > gentoo ~ $ gdb --args perf mem record -t load -- root.exe -l -q
> > GNU gdb (Gentoo 14.2 vanilla) 14.2
> > Reading symbols from perf...
> > (gdb) run
> > Starting program: /usr/bin/perf mem record -t load -- root.exe -l -q
> > [Thread debugging using libthread_db enabled]
> > Using host libthread_db library "/usr/lib64/libthread_db.so.1".
> >
> > Program received signal SIGSEGV, Segmentation fault.
> > __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
> > 67              vmovdqu (%rdi), %ymm2
> > (gdb) bt
> > #0  __strchrnul_avx2 () at ../sysdeps/x86_64/multiarch/strchr-avx2.S:67
> > #1  0x00007ffff6c982de in __find_specmb (format=0x0) at printf-parse.h:82
> > #2  __printf_buffer (buf=buf@entry=0x7fffffffc760, format=format@entry=0x0, ap=ap@entry=0x7fffffffc880,
> >     mode_flags=mode_flags@entry=0) at vfprintf-internal.c:649
> > #3  0x00007ffff6cb7840 in __vsnprintf_internal (string=<optimized out>, maxlen=<optimized out>, format=0x0,
> >     args=0x7fffffffc880, mode_flags=mode_flags@entry=0) at vsnprintf.c:96
> > #4  0x00007ffff6cb787f in ___vsnprintf (string=<optimized out>, maxlen=<optimized out>, format=<optimized out>,
> >     args=<optimized out>) at vsnprintf.c:103
> > #5  0x00005555557b9391 in scnprintf (buf=0x555555fe9320 <mem_loads_name> "", size=100, fmt=0x0)
> >     at ../lib/vsprintf.c:21
> > #6  0x00005555557b74c3 in perf_pmu__mem_events_name (i=0, pmu=0x555556832180) at util/mem-events.c:106
> > #7  0x00005555557b7ab9 in perf_mem_events__record_args (rec_argv=0x55555684c000, argv_nr=0x7fffffffca20)
> >     at util/mem-events.c:252
> > #8  0x00005555555e370d in __cmd_record (argc=3, argv=0x7fffffffd760, mem=0x7fffffffcd80) at builtin-mem.c:156
> > #9  0x00005555555e49c4 in cmd_mem (argc=4, argv=0x7fffffffd760) at builtin-mem.c:514
> > #10 0x000055555569716c in run_builtin (p=0x555555fcde80 <commands+672>, argc=8, argv=0x7fffffffd760) at perf.c:349
> > #11 0x0000555555697402 in handle_internal_command (argc=8, argv=0x7fffffffd760) at perf.c:402
> > #12 0x0000555555697560 in run_argv (argcp=0x7fffffffd59c, argv=0x7fffffffd590) at perf.c:446
> > #13 0x00005555556978a6 in main (argc=8, argv=0x7fffffffd760) at perf.c:562
> > (gdb)
> >
> > when I record without -t load, then it works. However, when I report
> > with --hierarchy, I get a crash as well:
> >
> > gentoo ~ $ gdb --args perf mem report --stdio --hierarchy
> > ...
> > Program received signal SIGSEGV, Segmentation fault.
> > 0x000055555574b228 in _hist_entry__sym_snprintf (ms=0x555558256940, ip=7237970023832232038, level=46 '.',
> >     bf=0x555558261200 "[.] ", size=525, width=42) at util/sort.c:376
> > 376                     if (sym->type == STT_OBJECT) {
> > (gdb) bt
> > #0  0x000055555574b228 in _hist_entry__sym_snprintf (ms=0x555558256940, ip=7237970023832232038, level=46 '.',
> >     bf=0x555558261200 "[.] ", size=525, width=42) at util/sort.c:376
> > #1  0x000055555574e148 in hist_entry__daddr_snprintf (he=0x5555568d66c0, bf=0x555558261200 "[.] ", size=525, width=42)
> >     at util/sort.c:1384
> > #2  0x0000555555750acb in __sort__hpp_entry (fmt=0x555556844a00, hpp=0x7fffffffa550, he=0x5555568d66c0)
> >     at util/sort.c:2505
> > #3  0x0000555555829cce in hist_entry__hierarchy_fprintf (he=0x5555568d66c0, hpp=0x7fffffffa550, hists=0x555556818270,
> >     fp=0x7ffff6df25c0 <_IO_2_1_stdout_>) at ui/stdio/hist.c:517
> > #4  0x000055555582a039 in hist_entry__fprintf (he=0x5555568d66c0, size=525, bf=0x555558261200 "[.] ", bfsz=525,
> >     fp=0x7ffff6df25c0 <_IO_2_1_stdout_>, ignore_callchains=true) at ui/stdio/hist.c:598
> > #5  0x000055555582adf5 in hists__fprintf (hists=0x555556818270, show_header=true, max_rows=0, max_cols=0, min_pcnt=0,
> >     fp=0x7ffff6df25c0 <_IO_2_1_stdout_>, ignore_callchains=true) at ui/stdio/hist.c:868
> > #6  0x00005555555b2442 in evlist__tty_browse_hists (evlist=0x55555682e000, rep=0x7fffffffa930,
> >     help=0x555556924240 "Tip: System-wide collection from all CPUs: perf record -a") at builtin-report.c:581
> > #7  0x00005555555b28c0 in report__browse_hists (rep=0x7fffffffa930) at builtin-report.c:684
> > #8  0x00005555555b3e7f in __cmd_report (rep=0x7fffffffa930) at builtin-report.c:1141
> > #9  0x00005555555b668a in cmd_report (argc=0, argv=0x555556806100) at builtin-report.c:1800
> > #10 0x00005555555e42d2 in report_events (argc=3, argv=0x7fffffffd790, mem=0x7fffffffcdb0) at builtin-mem.c:374
> > #11 0x00005555555e4a1c in cmd_mem (argc=3, argv=0x7fffffffd790) at builtin-mem.c:516
> > #12 0x000055555569716c in run_builtin (p=0x555555fcde80 <commands+672>, argc=4, argv=0x7fffffffd790) at perf.c:349
> > #13 0x0000555555697402 in handle_internal_command (argc=4, argv=0x7fffffffd790) at perf.c:402
> > #14 0x0000555555697560 in run_argv (argcp=0x7fffffffd5cc, argv=0x7fffffffd5c0) at perf.c:446
> > #15 0x00005555556978a6 in main (argc=4, argv=0x7fffffffd790) at perf.c:562
> > (gdb)
> 
> Maybe this relates to the cleanup in:
> https://lore.kernel.org/all/20240123185036.3461837-1-kan.liang@linux.intel.com/
> I also did some smaller cleanup trying to make sanitizers happy:
> https://lore.kernel.org/all/20240507183545.1236093-1-irogers@google.com/

How about this?  I'm not sure why we think it's supported if it has no
event name.

Thanks,
Namhyung

---8<---

diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 6dda47bb774f..e6051f0cf4db 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -86,7 +86,7 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
                return NULL;
 
        e = &pmu->mem_events[i];
-       if (!e)
+       if (!e || e->name)
                return NULL;
 
        if (i == PERF_MEM_EVENTS__LOAD || i == PERF_MEM_EVENTS__LOAD_STORE) {
@@ -184,7 +184,7 @@ static bool perf_pmu__mem_events_supported(const char *mnt, struct perf_pmu *pmu
        struct stat st;
 
        if (!e->event_name)
-               return true;
+               return false;
 
        scnprintf(path, PATH_MAX, "%s/devices/%s/events/%s", mnt, pmu->name, e->event_name);
 

