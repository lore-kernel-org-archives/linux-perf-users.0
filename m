Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B609BC48BE8
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 09:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929DC61184
	for <linux-perf-users@archiver.kernel.org>; Fri, 18 Jun 2021 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFRJTt (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 18 Jun 2021 05:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbhFRJTs (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 18 Jun 2021 05:19:48 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18E9C061574
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jun 2021 02:17:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id t3so7682891edc.7
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Jun 2021 02:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=qjbuZgVXwT7IkwXCEv44XfBZdQ8COcdDJTzBxor57Uw=;
        b=WdS2+sj1Bk/yFjeXlKT3esLdTeTVJ6Q65R8kjcuWgYpPmxWF7Lyz6KdzCS4bp6W+FB
         A+JHPUDT0hfHR/P4/JXw9zLtgw3+DIMiGdqDvgLdFiQ4e5wwYtrUEicBJRV/tTU/QOT/
         r5f9lrP6k+6FqXbXdAahi4XvQSAmWa0cZgHwZSlOs4dbc5X61m2FjZQJ1Uhz1m1Z7Meu
         JMeq4wlTRv/TAomMQvctHXF8u1odCLrTM+av9xbmNIS3CQeCEMhLKvSthVK9lAnIIM1A
         G478YQuqXBN7QUv8WAGA2T/L2W6GgzyYd6a4Dzbbv4EfKhYN8B4QutwVSSkMmoPwqJrE
         j72Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=qjbuZgVXwT7IkwXCEv44XfBZdQ8COcdDJTzBxor57Uw=;
        b=CtzgVVm9VRDB0icw1Azi37pnmvq7qlReC8jsjMJ9dLs38wI49M6IOh7qSDQ53MeNMg
         LwZGO7jDbEdtiH0vRM1pa4OZymgdMcnH3zqTIkOOtRGYsJUkHvxZ1HiP/wwenQl3BCs4
         7sOClZ7slw6pF+UByTFqYdUiJyHh5DWsckA7s8V9Lzk7Sb5oC+8W7iG+n08JmOSFxfY4
         yBGLCRKrRqM6WNjoM93kSU10de213lPF+gq/HDYyZdCOpMg58uGUsHb5Si17UCZtsvpP
         X1emtOiLX9P8UH3d1aY1XlBBlZlz1SRR7MNc/TYRd/r8PVxQobKBj2XZdJY7j4bLZOGC
         isZA==
X-Gm-Message-State: AOAM533qdt3E5MaOX1oUIksZUQSecZUq1LVZ4LBz9rwKTX5JMLnN14nx
        hbp31Pno3emx1pqY2K3BNPQ=
X-Google-Smtp-Source: ABdhPJyDRbh1lGxjbk9wG5/O+Ba000O+HOYYpam78C6AvCVEZRZ5E7Yo1gHsUBVQnfR5FLlL/VbyDw==
X-Received: by 2002:aa7:c845:: with SMTP id g5mr3677273edt.306.1624007857249;
        Fri, 18 Jun 2021 02:17:37 -0700 (PDT)
Received: from [192.168.1.15] ([151.29.187.239])
        by smtp.gmail.com with ESMTPSA id g15sm774636ejb.103.2021.06.18.02.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 02:17:36 -0700 (PDT)
Message-ID: <e883163b0c0295bfb8a56dcc82f6cae4cbbdc84a.camel@gmail.com>
Subject: perf-top: heap-buffer-overflow in elf_sec__is_text reported from
 ASan
From:   Riccardo Mancini <rickyman7@gmail.com>
To:     jirislaby@kernel.org, namhyung@kernel.org
Cc:     linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>,
        acme@kernel.org
Date:   Fri, 18 Jun 2021 11:17:35 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

Hi,

ASan reports a heap-buffer-overflow in elf_sec__is_text when using perf-top.
The bug is introduced by commit 6833e0b: "perf symbols: Resolve symbols against
debug file first" from Jiri Slaby. 

This is the ASan output (with the source at perf/urgent).

$ make CC=clang CXX=clang++ EXTRA_CFLAGS="-g -O0 -fsanitize=address -fno-omit-frame-pointer" WERROR=0 NO_LIBPYTHON=1 DEBUG=1 NO_LIBPERL=1
[...]
# ASAN_OPTIONS=abort_on_error=1:disable_coredump=0:unmap_shadow_on_exit=1 ./perf top
=================================================================
==363148==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x61300009add6 at pc 0x00000049875c bp 0x7f4f56446440 sp 0x7f4f56445bf0
READ of size 1 at 0x61300009add6 thread T6
    #0 0x49875b in StrstrCheck(void*, char*, char const*, char const*) (/home/user/linux/tools/perf/perf+0x49875b)
    #1 0x4d13a2 in strstr (/home/user/linux/tools/perf/perf+0x4d13a2)
    #2 0xacae36 in elf_sec__is_text /home/user/linux/tools/perf/util/symbol-elf.c:176:9
    #3 0xac3ec9 in elf_sec__filter /home/user/linux/tools/perf/util/symbol-elf.c:187:9
    #4 0xac2c3d in dso__load_sym /home/user/linux/tools/perf/util/symbol-elf.c:1254:20
    #5 0x883981 in dso__load /home/user/linux/tools/perf/util/symbol.c:1897:9
    #6 0x8e6248 in map__load /home/user/linux/tools/perf/util/map.c:332:7
    #7 0x8e66e5 in map__find_symbol /home/user/linux/tools/perf/util/map.c:366:6
    #8 0x7f8278 in machine__resolve /home/user/linux/tools/perf/util/event.c:707:13
    #9 0x5f3d1a in perf_event__process_sample /home/user/linux/tools/perf/builtin-top.c:773:6
    #10 0x5f30e4 in deliver_event /home/user/linux/tools/perf/builtin-top.c:1197:3
    #11 0x908a72 in do_flush /home/user/linux/tools/perf/util/ordered-events.c:244:9
    #12 0x905fae in __ordered_events__flush /home/user/linux/tools/perf/util/ordered-events.c:323:8
    #13 0x9058db in ordered_events__flush /home/user/linux/tools/perf/util/ordered-events.c:341:9
    #14 0x5f19b1 in process_thread /home/user/linux/tools/perf/builtin-top.c:1109:7
    #15 0x7f4f6a21a298 in start_thread /usr/src/debug/glibc-2.33-16.fc34.x86_64/nptl/pthread_create.c:481:8
    #16 0x7f4f697d0352 in clone ../sysdeps/unix/sysv/linux/x86_64/clone.S:95

0x61300009add6 is located 10 bytes to the right of 332-byte region [0x61300009ac80,0x61300009adcc)
allocated by thread T6 here:
    #0 0x4f3f7f in malloc (/home/user/linux/tools/perf/perf+0x4f3f7f)
    #1 0x7f4f6a0a88d9  (/lib64/libelf.so.1+0xa8d9)

Thread T6 created by T0 here:
    #0 0x464856 in pthread_create (/home/user/linux/tools/perf/perf+0x464856)
    #1 0x5f06e0 in __cmd_top /home/user/linux/tools/perf/builtin-top.c:1309:6
    #2 0x5ef19f in cmd_top /home/user/linux/tools/perf/builtin-top.c:1762:11
    #3 0x7b28c0 in run_builtin /home/user/linux/tools/perf/perf.c:313:11
    #4 0x7b119f in handle_internal_command /home/user/linux/tools/perf/perf.c:365:8
    #5 0x7b2423 in run_argv /home/user/linux/tools/perf/perf.c:409:2
    #6 0x7b0c19 in main /home/user/linux/tools/perf/perf.c:539:3
    #7 0x7f4f696f7b74 in __libc_start_main /usr/src/debug/glibc-2.33-16.fc34.x86_64/csu/../csu/libc-start.c:332:16

SUMMARY: AddressSanitizer: heap-buffer-overflow (/home/user/linux/tools/perf/perf+0x49875b) in StrstrCheck(void*, char*, char const*, char const*)
Shadow bytes around the buggy address:
  0x0c268000b560: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c268000b570: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c268000b580: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c268000b590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c268000b5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
=>0x0c268000b5b0: 00 00 00 00 00 00 00 00 00 04[fa]fa fa fa fa fa
  0x0c268000b5c0: fa fa fa fa fa fa fa fa 00 00 00 00 00 00 00 00
  0x0c268000b5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c268000b5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x0c268000b5f0: 07 fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
  0x0c268000b600: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07 
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
  Shadow gap:              cc
==363148==ABORTING


Here is some more information from the coredump:

pwndbg> p *shdr
$1 = {
  sh_name = 342,
  sh_type = 1,
  sh_flags = 0,
  sh_addr = 0,
  sh_offset = 8472,
  sh_size = 1140436,
  sh_link = 0,
  sh_info = 0,
  sh_addralign = 1,
  sh_entsize = 0
}
pwndbg> p *secstrs
$2 = {
  d_buf = 0x6130001836c0,
  d_type = ELF_T_BYTE,
  d_version = 1,
  d_size = 332,
  d_off = 0,
  d_align = 1
}
pwndbg> p syms_ss->name
$4 = 0x607000018f90 "/usr/lib/debug/usr/lib64/libglib-2.0.so.0.6800.2-2.68.2-1.fc34.x86_64.debug"
pwndbg> p runtime_ss->name
$5 = 0x6070000190e0 "/root/.debug/.build-id/37/475e3b392fb3971c8ad0d9ac0a4d7e1b93c521/elf"

Furthermore, the branch in line symbol-elf.c:1241 (the one added in the referred
patch) is not taken.

As you can see, sh_name is out-of-range (342 > 332).
I can also provide a coredump, if it can be useful.

I have no idea of how the ELF stuff works, but I thought this may be caused by
the fact that secstrs is built from runtime_ss, while shdr is built from syms_ss
(since it is the change of the commit). I tried to test this theory with the
following change:

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a73345730ba9..8d2b692f11a2 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1146,7 +1146,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (symstrs == NULL)
 		goto out_elf_end;
 
-	sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
+	sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
 	if (sec_strndx == NULL)
 		goto out_elf_end;
 
@@ -1244,6 +1244,14 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 		 * values for syms (invalid) and runtime (valid).
 		 */
 		if (shdr.sh_type == SHT_NOBITS) {
+			sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
+			if (sec_strndx == NULL)
+				goto out_elf_end;
+
+			secstrs = elf_getdata(sec_strndx, NULL);
+			if (secstrs == NULL)
+				goto out_elf_end;
+
 			sec = elf_getscn(runtime_ss->elf, sym.st_shndx);
 			if (!sec)
 				goto out_elf_end;

However, it still overflows, but oddly the branch is not taken before the
overflow. Is there some kind of state that gets changed in the ELF structs?

I also tried to just change line 1146 as in the diff below:

diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
index a73345730ba9..27c7e1d39323 100644
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1146,7 +1146,7 @@ int dso__load_sym(struct dso *dso, struct map *map, struct symsrc *syms_ss,
 	if (symstrs == NULL)
 		goto out_elf_end;
 
-	sec_strndx = elf_getscn(runtime_ss->elf, runtime_ss->ehdr.e_shstrndx);
+	sec_strndx = elf_getscn(elf, ehdr.e_shstrndx);
 	if (sec_strndx == NULL)
 		goto out_elf_end;

In this case, ASan reports no overflows. So, it looks like it kinda solves the
problem, but I don't know if it's correct. 

What do you think?

Thanks,
Riccardo

