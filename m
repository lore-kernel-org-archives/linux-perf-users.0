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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3002CC07E94
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 15:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145DC61402
	for <linux-perf-users@archiver.kernel.org>; Fri,  4 Jun 2021 15:24:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhFDP0W (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 4 Jun 2021 11:26:22 -0400
Received: from mail-ed1-f48.google.com ([209.85.208.48]:46637 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhFDP0W (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 4 Jun 2021 11:26:22 -0400
Received: by mail-ed1-f48.google.com with SMTP id r11so11562248edt.13;
        Fri, 04 Jun 2021 08:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wGPasXoYywrXGg/ef9droojodHfnwVODBHNGyzr6cPQ=;
        b=lCxg46amv/7bUXOXqNXkN0JNoN3MlGdXw9kOK8N3ciKtK1i+webFZfGVCYH03zRi+K
         tRkxETxQjtKlwbrxpx/tNaxdqN+nsPJPiuxJWlOg+6qhrzJqZii69/3s3GcDg0iN3APO
         q4OPk1G28/AWwBzlvhRMp+wlUe/bJB2fKKkCnqraEvbYeMwAM10Lr5tJwlKoHWTKMx82
         9WHbSTlrN1nrSq+G5o8suW29A7cr2YDokNBGshZewVqBfqYkBNH/Ga3+UR3t7aybS58w
         ns+Ul1q/2oP1j76sCupx9XUPfGAQtRJEJ+IBuQJarNNzEywLs/k1U0YEwfbhyB6ts9xr
         2hcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=wGPasXoYywrXGg/ef9droojodHfnwVODBHNGyzr6cPQ=;
        b=faD5ugX//gRXTQWqQwOuxEnc4u5ks9+xbv5eFGhuqps34WREnc2ZPLWQoqYsRZnysQ
         pHqPKcjPk8xZGrMr6FezZbHBWloZsDvSVvfTUC07cihAM+WWLvf99Gd/Xr9aAx4tit/l
         HQkqHM/N/tSUMZWuIEym/cT61VHrTIwAvWmUPJxYrayVVitLEAvjAL8hGTXLGqyOWZOg
         DUqjJg4owq8zTxksJQFoMMDOgUVBF9xe3KJH6QV8y9seDWZ+qbc2ZwUm8ycNzhJfM1SA
         lNqvYsJ/pgRBlZ2a01mo/8RYShvhCUfgf2yPuFSawgl9SaYUBICTIC+7gtFiiFxjYwRu
         SgXQ==
X-Gm-Message-State: AOAM531VTID2/uaABtSV1WWSLmpwFAqy7yPZJ5ueA8ZkANrwRMjihlnZ
        75GnMUeoWouQ9nKABDifBBo=
X-Google-Smtp-Source: ABdhPJzLQFbMoaD99xPELT1NpZp87JjnFZU5iz+fpVDfsQTf0L+qcrUY7HlgqQyS18TkeG91n/oXCg==
X-Received: by 2002:a05:6402:51ce:: with SMTP id r14mr5461482edd.138.1622820201630;
        Fri, 04 Jun 2021 08:23:21 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.179.73])
        by smtp.gmail.com with ESMTPSA id g22sm1456986edv.74.2021.06.04.08.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 08:23:21 -0700 (PDT)
Message-ID: <3e31a3f86487b31cd5161f57648798a129f13b0a.camel@gmail.com>
Subject: Re: [PATCH] perf symbol-elf: fix memory leak: free sdt_note.args
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Fabian Hemmer <copy@copy.sh>,
        Remi Bernon <rbernon@codeweavers.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 04 Jun 2021 17:23:19 +0200
In-Reply-To: <YLokBBmh2+vd9E9d@kernel.org>
References: <20210602220833.285226-1-rickyman7@gmail.com>
         <CAP-5=fVp4xGd8wxLc1eFfTUPn3Urp23RmHBha2kgiJGvfysgZg@mail.gmail.com>
         <YLokBBmh2+vd9E9d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.1 (3.40.1-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

On Fri, 2021-06-04 at 10:00 -0300, Arnaldo Carvalho de Melo wrote:
> Em Thu, Jun 03, 2021 at 09:08:46PM -0700, Ian Rogers escreveu:
> > On Wed, Jun 2, 2021 at 3:12 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
> > > 
> > > Reported by ASan.
> > 
> > Did you have a reproducer for getting this to fail?

In case you'd like to add it to the commit message.

$ sudo ./perf record -- sleep 5
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.025 MB perf.data (15 samples) ]

=================================================================
==79402==ERROR: LeakSanitizer: detected memory leaks

[...]

Direct leak of 999 byte(s) in 47 object(s) allocated from:
    #0 0x4b7cc7 in strdup (/home/user/linux/source/tools/perf/perf+0x4b7cc7)
    #1 0xac69db in populate_sdt_note /home/user/linux/source/tools/perf/util/symbol-elf.c:2256:15
    #2 0xac2b57 in construct_sdt_notes_list /home/user/linux/source/tools/perf/util/symbol-elf.c:2359:10
    #3 0xac2502 in get_sdt_note_list /home/user/linux/source/tools/perf/util/symbol-elf.c:2394:8
    #4 0xacc6ac in probe_cache__scan_sdt /home/user/linux/source/tools/perf/util/probe-file.c:882:8
    #5 0x7e2949 in build_id_cache__add_sdt_cache /home/user/linux/source/tools/perf/util/build-id.c:619:8
    #6 0x7e233c in build_id_cache__add /home/user/linux/source/tools/perf/util/build-id.c:779:6
    #7 0x7e2b37 in build_id_cache__add_s /home/user/linux/source/tools/perf/util/build-id.c:805:8
    #8 0x7e3e99 in build_id_cache__add_b /home/user/linux/source/tools/perf/util/build-id.c:821:9
    #9 0x7e3166 in dso__cache_build_id /home/user/linux/source/tools/perf/util/build-id.c:889:9
    #10 0x8da7bc in machine__for_each_dso /home/user/linux/source/tools/perf/util/machine.c:3167:7
    #11 0x7e2ec1 in machines__for_each_dso /home/user/linux/source/tools/perf/util/build-id.c:896:12
    #12 0x7e2e46 in __perf_session__cache_build_ids /home/user/linux/source/tools/perf/util/build-id.c:917:9
    #13 0x7e2faa in perf_session__cache_build_ids /home/user/linux/source/tools/perf/util/build-id.c:922:9
    #14 0x8996c8 in write_build_id /home/user/linux/source/tools/perf/util/header.c:327:2
    #15 0x8b76e9 in do_write_feat /home/user/linux/source/tools/perf/util/header.c:3216:9
    #16 0x8ac70d in perf_header__adds_write /home/user/linux/source/tools/perf/util/header.c:3261:7
    #17 0x8abe52 in perf_session__write_header /home/user/linux/source/tools/perf/util/header.c:3353:9
    #18 0x5961ed in record__finish_output /home/user/linux/source/tools/perf/builtin-record.c:1241:2
    #19 0x58e6ca in __cmd_record /home/user/linux/source/tools/perf/builtin-record.c:2060:4
    #20 0x58990b in cmd_record /home/user/linux/source/tools/perf/builtin-record.c:2901:8
    #21 0x7b2a20 in run_builtin /home/user/linux/source/tools/perf/perf.c:313:11
    #22 0x7b12ff in handle_internal_command /home/user/linux/source/tools/perf/perf.c:365:8
    #23 0x7b2583 in run_argv /home/user/linux/source/tools/perf/perf.c:409:2
    #24 0x7b0d79 in main /home/user/linux/source/tools/perf/perf.c:539:3
    #25 0x7effc1a65b74 in __libc_start_main /usr/src/debug/glibc-2.33-8.fc34.x86_64/csu/../csu/libc-start.c:332:16

Thanks,
Riccardo

> > 
> > > Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> > 
> > Acked-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied.
> 
> - Arnaldo
> 
>  
> > Thanks,
> > Ian
> > 
> > > ---
> > >  tools/perf/util/symbol-elf.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> > > index 4c56aa8374344..a73345730ba90 100644
> > > --- a/tools/perf/util/symbol-elf.c
> > > +++ b/tools/perf/util/symbol-elf.c
> > > @@ -2412,6 +2412,7 @@ int cleanup_sdt_note_list(struct list_head *sdt_notes)
> > > 
> > >         list_for_each_entry_safe(pos, tmp, sdt_notes, note_list) {
> > >                 list_del_init(&pos->note_list);
> > > +               zfree(&pos->args);
> > >                 zfree(&pos->name);
> > >                 zfree(&pos->provider);
> > >                 free(pos);
> > > --
> > > 2.31.1
> > > 
> 


