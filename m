Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FD3C2B9F4
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 19:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E3961360
	for <linux-perf-users@archiver.kernel.org>; Tue, 22 Jun 2021 19:46:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhFVTtJ (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Tue, 22 Jun 2021 15:49:09 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40690 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhFVTtI (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Tue, 22 Jun 2021 15:49:08 -0400
Received: by mail-lf1-f41.google.com with SMTP id i13so37776845lfc.7;
        Tue, 22 Jun 2021 12:46:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K1sjZRxUxf8LdFz/zxGfgHzUrlWEJZzkhMnFGqLjBJA=;
        b=nugVLZ6MigagDKAJCL/iKYblCDspOFhDw7lEbJLHunKMQF5T67aWpCCk8wRgTHLvPX
         P0U08EYdvLQCstIBIzYx/Uc8T73tuN45jSORZbQC/lkOt498SHVzQOLD/4HyUlUecPCJ
         g5uNGXeRDunJJGyR1y4ASRwh6qs0gNi/95iRZ3t5Xa7qAFOvhytQWyg0PifX1JL5mV6Z
         zeKxpQvzj+TF9hy7RdTx0sRSSrRAbEW8rmyuZ1cupjip4mXUcBO+GXU9LrUnjB1NTeUf
         3zhmLPa2YtpNQB4Hi2hKnCXYIiHpSTDUSlbaCx+DPakNspDvFFqSQ5pbGfnIQ/7basOL
         7JNw==
X-Gm-Message-State: AOAM530JE4qoQq+IL6iwLzYMj+dON31lt8P65lJxJvFYz16xRGy89wDF
        8nlqyxu0LHI3vG3P0TlUVCapwDdYrzz7xz6WIuY=
X-Google-Smtp-Source: ABdhPJwZp6hfUVrqki2SWHNk0X4mAwypD93vv4PkCPVlx+Q8lZKpIIVAZ3O2gIs7AH4YES2sKaceH1Wn6R7OZXDZGU8=
X-Received: by 2002:a05:6512:20ce:: with SMTP id u14mr4046378lfr.300.1624391209484;
 Tue, 22 Jun 2021 12:46:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210621222108.196219-1-rickyman7@gmail.com>
In-Reply-To: <20210621222108.196219-1-rickyman7@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 22 Jun 2021 12:46:38 -0700
Message-ID: <CAM9d7ch7eg6_tX76FeXz3zPJdUGnHRPKkkBF6ZwjAGcJz7wQCg@mail.gmail.com>
Subject: Re: [PATCH] perf top: fix overflow in elf_sec__is_text
To:     Riccardo Mancini <rickyman7@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        Fabian Hemmer <copy@copy.sh>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi Riccardo,

On Mon, Jun 21, 2021 at 3:22 PM Riccardo Mancini <rickyman7@gmail.com> wrote:
>
> ASan reports a heap-buffer-overflow in elf_sec__is_text when using perf-top.
> The bug is caused by the fact that secstrs is built from runtime_ss, while
> shdr is built from syms_ss if shdr.sh_type != SHT_NOBITS. Therefore, they
> point to two different ELF files.
>
> This patch renames secstrs to secstrs_run and adds secstrs_sym, so that
> the correct secstrs is chosen depending on shdr.sh_type.
>
> $ ASAN_OPTIONS=abort_on_error=1:disable_coredump=0:unmap_shadow_on_exit=1 ./perf top
> =================================================================
> ==363148==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61300009add6 at pc 0x00000049875c bp 0x7f4f56446440 sp 0x7f4f56445bf0
> READ of size 1 at 0x61300009add6 thread T6
>     #0 0x49875b in StrstrCheck(void*, char*, char const*, char const*) (/home/user/linux/tools/perf/perf+0x49875b)
>     #1 0x4d13a2 in strstr (/home/user/linux/tools/perf/perf+0x4d13a2)
>     #2 0xacae36 in elf_sec__is_text /home/user/linux/tools/perf/util/symbol-elf.c:176:9
>     #3 0xac3ec9 in elf_sec__filter /home/user/linux/tools/perf/util/symbol-elf.c:187:9
>     #4 0xac2c3d in dso__load_sym /home/user/linux/tools/perf/util/symbol-elf.c:1254:20
>     #5 0x883981 in dso__load /home/user/linux/tools/perf/util/symbol.c:1897:9
>     #6 0x8e6248 in map__load /home/user/linux/tools/perf/util/map.c:332:7
>     #7 0x8e66e5 in map__find_symbol /home/user/linux/tools/perf/util/map.c:366:6
>     #8 0x7f8278 in machine__resolve /home/user/linux/tools/perf/util/event.c:707:13
>     #9 0x5f3d1a in perf_event__process_sample /home/user/linux/tools/perf/builtin-top.c:773:6
>     #10 0x5f30e4 in deliver_event /home/user/linux/tools/perf/builtin-top.c:1197:3
>     #11 0x908a72 in do_flush /home/user/linux/tools/perf/util/ordered-events.c:244:9
>     #12 0x905fae in __ordered_events__flush /home/user/linux/tools/perf/util/ordered-events.c:323:8
>     #13 0x9058db in ordered_events__flush /home/user/linux/tools/perf/util/ordered-events.c:341:9
>     #14 0x5f19b1 in process_thread /home/user/linux/tools/perf/builtin-top.c:1109:7
>     #15 0x7f4f6a21a298 in start_thread /usr/src/debug/glibc-2.33-16.fc34.x86_64/nptl/pthread_create.c:481:8
>     #16 0x7f4f697d0352 in clone ../sysdeps/unix/sysv/linux/x86_64/clone.S:95
>
> 0x61300009add6 is located 10 bytes to the right of 332-byte region [0x61300009ac80,0x61300009adcc)
> allocated by thread T6 here:
>     #0 0x4f3f7f in malloc (/home/user/linux/tools/perf/perf+0x4f3f7f)
>     #1 0x7f4f6a0a88d9  (/lib64/libelf.so.1+0xa8d9)
>
> Thread T6 created by T0 here:
>     #0 0x464856 in pthread_create (/home/user/linux/tools/perf/perf+0x464856)
>     #1 0x5f06e0 in __cmd_top /home/user/linux/tools/perf/builtin-top.c:1309:6
>     #2 0x5ef19f in cmd_top /home/user/linux/tools/perf/builtin-top.c:1762:11
>     #3 0x7b28c0 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
>     #4 0x7b119f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
>     #5 0x7b2423 in run_argv /home/user/linux/tools/perf/perf.c:409:2
>     #6 0x7b0c19 in main /home/user/linux/tools/perf/perf.c:539:3
>     #7 0x7f4f696f7b74 in __libc_start_main /usr/src/debug/glibc-2.33-16.fc34.x86_64/csu/../csu/libc-start.c:332:16
>
> SUMMARY: AddressSanitizer: heap-buffer-overflow (/home/user/linux/tools/perf/perf+0x49875b) in StrstrCheck(void*, char*, char const*, char const*)
> Shadow bytes around the buggy address:
>   0x0c268000b560: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c268000b570: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c268000b580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c268000b590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c268000b5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =>0x0c268000b5b0: 00 00 00 00 00 00 00 00 00 04[fa]fa fa fa fa fa
>   0x0c268000b5c0: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
>   0x0c268000b5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c268000b5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>   0x0c268000b5f0: 07 fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
>   0x0c268000b600: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
> Shadow byte legend (one shadow byte represents 8 application bytes):
>   Addressable:           00
>   Partially addressable: 01 02 03 04 05 06 07
>   Heap left redzone:       fa
>   Freed heap region:       fd
>   Stack left redzone:      f1
>   Stack mid redzone:       f2
>   Stack right redzone:     f3
>   Stack after return:      f5
>   Stack use after scope:   f8
>   Global redzone:          f9
>   Global init order:       f6
>   Poisoned by user:        f7
>   Container overflow:      fc
>   Array cookie:            ac
>   Intra object redzone:    bb
>   ASan internal:           fe
>   Left alloca redzone:     ca
>   Right alloca redzone:    cb
>   Shadow gap:              cc
> ==363148==ABORTING
>
> Signed-off-by: Riccardo Mancini <rickyman7@gmail.com>
> Suggested-by: Jiri Slaby <jirislaby@kernel.org>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/symbol-elf.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 4c56aa837434..7a6e38bf87b0 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1081,7 +1081,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>         struct maps *kmaps = kmap ? map__kmaps(map) : NULL;
>         struct map *curr_map = map;
>         struct dso *curr_dso = dso;
> -       Elf_Data *symstrs, *secstrs;
> +       Elf_Data *symstrs, *secstrs, *secstrs_run, *secstrs_sym;
>         uint32_t nr_syms;
>         int err = -1;
>         uint32_t idx;
> @@ -1150,8 +1150,16 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>         if (sec_strndx == NULL)
>                 goto out_elf_end;
>
> -       secstrs = elf_getdata(sec_strndx, NULL);
> -       if (secstrs == NULL)
> +       secstrs_run = elf_getdata(sec_strndx, NULL);
> +       if (secstrs_run == NULL)
> +               goto out_elf_end;
> +
> +       sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
> +       if (sec_strndx == NULL)
> +               goto out_elf_end;
> +
> +       secstrs_sym = elf_getdata(sec_strndx, NULL);
> +       if (secstrs_sym == NULL)
>                 goto out_elf_end;
>
>         nr_syms = shdr.sh_size / shdr.sh_entsize;
> @@ -1237,6 +1245,8 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>
>                 gelf_getshdr(sec, &shdr);
>
> +               secstrs = secstrs_sym;
> +
>                 /*
>                  * We have to fallback to runtime when syms' section header has
>                  * NOBITS set. NOBITS results in file offset (sh_offset) not
> @@ -1249,6 +1259,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>                                 goto out_elf_end;
>
>                         gelf_getshdr(sec, &shdr);
> +                       secstrs = secstrs_run;
>                 }
>
>                 if (is_label && !elf_sec__filter(&shdr, secstrs))
> --
> 2.23.0
>
