Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77401C04A68
	for <linux-perf-users@archiver.kernel.org>; Sat, 30 Jul 2022 05:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbiG3FNV (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Sat, 30 Jul 2022 01:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiG3FNU (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Sat, 30 Jul 2022 01:13:20 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3576EBF
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 22:13:18 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id p10so3858777wru.8
        for <linux-perf-users@vger.kernel.org>; Fri, 29 Jul 2022 22:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtteVBgS71Lb/JC0BpG4/xW6LftD/Fk6tCYTvc5gfGo=;
        b=ZkWJlPy9/j+8ucQs4aao4njIAn6w9Nppt+1clKTBWJseKyjDQ6CqCFfFDmBlYXTzNp
         +MmrSbuIjSkC7Zw+Gi1SqziLRVs3hX8wy3iZu3rmgdMTm8sZWPxHsS6XmC6dzBP8COxc
         LBcKoUYu3j3sme4GrypwHMuGWwvUcswSqrKh+VDyN2ikfFg1j9+dljQ9+6QEVxQBgInu
         30yk8NhvwLS1UvKsfbwBdUGdYWaFo88TQ1UjzI//Iia+NCN+NO4z1lR49F2ECAzU8MhV
         XRCZbudaYxcaslIIG95TxEb4uRnwViGSzkaL+bLfa/YBzQ8pn3SPUiYkbBmTGPxqJ+Li
         KL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtteVBgS71Lb/JC0BpG4/xW6LftD/Fk6tCYTvc5gfGo=;
        b=MuH23fPh63QBlligomPoAFlCERb1vVn9EXge+cd8s5+JVzK8tj0hUuI5zSdjjWfc/n
         K9+hCc4cwkrPYZHUDNIsoUEffy1mvmU/S8oZfnLffEoMoqB8wnKFuemEubaJ8IliznHh
         7YdftlhsABmGE/zvRqTCV1MlqUSnDVZBuH2rl7uRVdg8Fw7YGhMn6Eaqn9sbgzZ/zJ9V
         /LNtTfbpIEVPa29DAGT4nXFTsmBetWxAcx1R2n4a8M7toCkD5ZKtOBcoHDSsqq+UYdwY
         rDsWaLlBjEl9zLQsjEf1yCfLsY1bN8W6cVq5u9T1LLOkHT2WRwRJQUnr4ll5Qp3jTDtG
         8PhA==
X-Gm-Message-State: ACgBeo0SYpQPDJ32dJGIQRv1YJaLymOiJ78Szhs0W61SGWxaB2RN5O0s
        4JYJRuwJAzr4zj+yU2pSBTwWI8x5N3O4DpQ/jjDH/Q==
X-Google-Smtp-Source: AA6agR7TqvLwTbBs6GsXk9Z+S16HTlKccQxHC18N2V18QiyTAC8qpJce59RMmfuL0E+NYFGvKjDyaP21krsMSDusqts=
X-Received: by 2002:a5d:6d4e:0:b0:21e:660e:55bf with SMTP id
 k14-20020a5d6d4e000000b0021e660e55bfmr3971363wri.343.1659157996688; Fri, 29
 Jul 2022 22:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220724060013.171050-1-leo.yan@linaro.org> <20220724060013.171050-2-leo.yan@linaro.org>
In-Reply-To: <20220724060013.171050-2-leo.yan@linaro.org>
From:   Ian Rogers <irogers@google.com>
Date:   Fri, 29 Jul 2022 22:13:04 -0700
Message-ID: <CAP-5=fVY=_WUpke0sRMpvbJFu9JuYwqiwAmKdCS+=u7vEG-2uA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] perf symbol: Correct address for bss symbols
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Fangrui Song <maskray@google.com>,
        Chang Rui <changruinj@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Sat, Jul 23, 2022 at 11:00 PM Leo Yan <leo.yan@linaro.org> wrote:
>
> When using 'perf mem' and 'perf c2c', an issue is observed that tool
> reports the wrong offset for global data symbols.  This is a common
> issue on both x86 and Arm64 platforms.
>
> Let's see an example, for a test program, below is the disassembly for
> its .bss section which is dumped with objdump:
>
>   ...
>
>   Disassembly of section .bss:
>
>   0000000000004040 <completed.0>:
>         ...
>
>   0000000000004080 <buf1>:
>         ...
>
>   00000000000040c0 <buf2>:
>         ...
>
>   0000000000004100 <thread>:
>         ...
>
> First we used 'perf mem record' to run the test program and then used
> 'perf --debug verbose=4 mem report' to observe what's the symbol info
> for 'buf1' and 'buf2' structures.
>
>   # ./perf mem record -e ldlat-loads,ldlat-stores -- false_sharing.exe 8
>   # ./perf --debug verbose=4 mem report
>     ...
>     dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 sh_addr: 0x4040 sh_offset: 0x3028
>     symbol__new: buf2 0x30a8-0x30e8
>     ...
>     dso__load_sym_internal: adjusting symbol: st_value: 0x4080 sh_addr: 0x4040 sh_offset: 0x3028
>     symbol__new: buf1 0x3068-0x30a8
>     ...
>
> Perf tool relies on libelf to parse symbols, in executable and shared
> object files, 'st_value' holds a virtual address; 'sh_addr' is the
> address at which section's first byte should reside in memory, and
> 'sh_offset' is the byte offset from the beginning of the file to the
> first byte in the section.  Perf tool uses below formula to convert
> symbol's memory address to file address:
>
>   file_address = st_value - sh_addr + sh_offset
>                     ^
>                     ` Memory address
>
> We can see the final adjusted address ranges for buf1 and buf2 are
> [0x30a8-0x30e8) and [0x3068-0x30a8) respectively, apparently this is
> incorrect, in the code, the structure for 'buf1' and 'buf2' specifies
> compiler attribute with 64-byte alignment.
>
> The problem happens for 'sh_offset', libelf returns it as 0x3028 which
> is not 64-byte aligned, combining with disassembly, it's likely libelf
> doesn't respect the alignment for .bss section, therefore, it doesn't
> return the aligned value for 'sh_offset'.
>
> Suggested by Fangrui Song, elf file contains program header which
> contains PT_LOAD segments, the fields p_vaddr and p_offset in PT_LOAD
> segments contain the execution info.  A better choice for converting
> memory address to file address is using the formula:
>
>   file_address = st_value - p_vaddr + p_offset
>
> This patch introduces function elf_read_program_header() which returns
> out the program header based on the passed 'st_value', then it uses
> above formula to calculate the symbol file address; and the debugging
> log is updated respectively.
>
> After applying the change:
>
>   # ./perf --debug verbose=4 mem report
>     ...
>     dso__load_sym_internal: adjusting symbol: st_value: 0x40c0 p_vaddr: 0x3d28 p_offset: 0x2d28
>     symbol__new: buf2 0x30c0-0x3100
>     ...
>     dso__load_sym_internal: adjusting symbol: st_value: 0x4080 p_vaddr: 0x3d28 p_offset: 0x2d28
>     symbol__new: buf1 0x3080-0x30c0
>     ...
>
> Fixes: f17e04afaff8 ("perf report: Fix ELF symbol parsing")
> Reported-by: Chang Rui <changruinj@gmail.com>
> Suggested-by: Fangrui Song <maskray@google.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>

I am seeing a problem with this patch with jvmti. To repro:

1) download a Java workload dacapo-9.12-MR1-bach.jar from
https://sourceforge.net/projects/dacapobench/
2) build perf such as "make -C tools/perf O=/tmp/perf NO_LIBBFD=1" it
should detect Java and create /tmp/perf/libperf-jvmti.so
3) run perf with the jvmti agent:
/tmp/perf/perf record -k 1 java -agentpath:/tmp/perf/libperf-jvmti.so
-jar dacapo-9.12-MR1-bach.jar -n 10 fop
4) run perf inject:
/tmp/perf/perf inject -i perf.data -o perf-injected.data -j
5) run perf report
/tmp/perf/perf report -i  perf-injected.data | grep org.apache.fop

With this patch reverted I see lots of symbols like:
     0.00%  java             jitted-388040-4656.so  [.]
org.apache.fop.fo.FObj.bind(org.apache.fop.fo.PropertyList)

With the patch I see lots of:
dso__load_sym_internal: failed to find program header for symbol:
Lorg/apache/fop/fo/FObj;bind(Lorg/apache/fop/fo/PropertyList;)V
st_value: 0x40

> ---
>  tools/perf/util/symbol-elf.c | 45 ++++++++++++++++++++++++++++++++----
>  1 file changed, 41 insertions(+), 4 deletions(-)
>
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index ecd377938eea..ef6ced5c5746 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -233,6 +233,33 @@ Elf_Scn *elf_section_by_name(Elf *elf, GElf_Ehdr *ep,
>         return NULL;
>  }
>
> +static int elf_read_program_header(Elf *elf, u64 vaddr, GElf_Phdr *phdr)
> +{
> +       size_t i, phdrnum;
> +       u64 sz;
> +
> +       if (elf_getphdrnum(elf, &phdrnum))
> +               return -1;
> +
> +       for (i = 0; i < phdrnum; i++) {
> +               if (gelf_getphdr(elf, i, phdr) == NULL)
> +                       return -1;
> +
> +               if (phdr->p_type != PT_LOAD)
> +                       continue;
> +
> +               sz = max(phdr->p_memsz, phdr->p_filesz);
> +               if (!sz)
> +                       continue;
> +
> +               if (vaddr >= phdr->p_vaddr && (vaddr < phdr->p_vaddr + sz))
> +                       return 0;
> +       }
> +
> +       /* Not found any valid program header */
> +       return -1;
> +}
> +
>  static bool want_demangle(bool is_kernel_sym)
>  {
>         return is_kernel_sym ? symbol_conf.demangle_kernel : symbol_conf.demangle;
> @@ -1209,6 +1236,7 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>                                         sym.st_value);
>                         used_opd = true;
>                 }
> +
>                 /*
>                  * When loading symbols in a data mapping, ABS symbols (which
>                  * has a value of SHN_ABS in its st_shndx) failed at
> @@ -1262,11 +1290,20 @@ dso__load_sym_internal(struct dso *dso, struct map *map, struct symsrc *syms_ss,
>                                 goto out_elf_end;
>                 } else if ((used_opd && runtime_ss->adjust_symbols) ||
>                            (!used_opd && syms_ss->adjust_symbols)) {
> +                       GElf_Phdr phdr;
> +
> +                       if (elf_read_program_header(syms_ss->elf,
> +                                                   (u64)sym.st_value, &phdr)) {
> +                               pr_warning("%s: failed to find program header for "
> +                                          "symbol: %s st_value: %#" PRIx64 "\n",
> +                                          __func__, elf_name, (u64)sym.st_value);
> +                               continue;
> +                       }
>                         pr_debug4("%s: adjusting symbol: st_value: %#" PRIx64 " "
> -                                 "sh_addr: %#" PRIx64 " sh_offset: %#" PRIx64 "\n", __func__,
> -                                 (u64)sym.st_value, (u64)shdr.sh_addr,
> -                                 (u64)shdr.sh_offset);
> -                       sym.st_value -= shdr.sh_addr - shdr.sh_offset;
> +                                 "p_vaddr: %#" PRIx64 " p_offset: %#" PRIx64 "\n",
> +                                 __func__, (u64)sym.st_value, (u64)phdr.p_vaddr,
> +                                 (u64)phdr.p_offset);
> +                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
>                 }

Combining the old and new behaviors fixes the issue for me, wdyt?

```
--- a/tools/perf/util/symbol-elf.c
+++ b/tools/perf/util/symbol-elf.c
@@ -1305,16 +1305,21 @@ dso__load_sym_internal(struct dso *dso, struct
map *map, struct symsrc *syms
_ss,

                       if (elf_read_program_header(syms_ss->elf,
                                                   (u64)sym.st_value, &phdr)) {
-                               pr_warning("%s: failed to find program
header for "
+                               pr_debug4("%s: failed to find program
header for "
                                          "symbol: %s st_value: %#" PRIx64 "\n",
                                          __func__, elf_name,
(u64)sym.st_value);
-                               continue;
+                               pr_debug4("%s: adjusting symbol:
st_value: %#" PRIx64 " "
+                                       "sh_addr: %#" PRIx64 "
sh_offset: %#" PRIx64 "\n",
+                                       __func__, (u64)sym.st_value,
(u64)shdr.sh_addr,
+                                       (u64)shdr.sh_offset);
+                               sym.st_value -= shdr.sh_addr - shdr.sh_offset;
+                       } else {
+                               pr_debug4("%s: adjusting symbol:
st_value: %#" PRIx64 " "
+                                       "p_vaddr: %#" PRIx64 "
p_offset: %#" PRIx64 "\n",
+                                       __func__, (u64)sym.st_value,
(u64)phdr.p_vaddr,
+                                       (u64)phdr.p_offset);
+                               sym.st_value -= phdr.p_vaddr - phdr.p_offset;
                       }
-                       pr_debug4("%s: adjusting symbol: st_value: %#"
PRIx64 " "
-                                 "p_vaddr: %#" PRIx64 " p_offset: %#"
PRIx64 "\n",
-                                 __func__, (u64)sym.st_value,
(u64)phdr.p_vaddr,
-                                 (u64)phdr.p_offset);
-                       sym.st_value -= phdr.p_vaddr - phdr.p_offset;
               }

               demangled = demangle_sym(dso, kmodule, elf_name);
```

Thanks,
Ian

>
>                 demangled = demangle_sym(dso, kmodule, elf_name);
> --
> 2.25.1
>
