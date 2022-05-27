Return-Path: <linux-perf-users-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04157C433F5
	for <linux-perf-users@archiver.kernel.org>; Fri, 27 May 2022 06:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344253AbiE0Gtk (ORCPT
        <rfc822;linux-perf-users@archiver.kernel.org>);
        Fri, 27 May 2022 02:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241644AbiE0Gtj (ORCPT
        <rfc822;linux-perf-users@vger.kernel.org>);
        Fri, 27 May 2022 02:49:39 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1A6ED8DA
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 23:49:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t6so4645031wra.4
        for <linux-perf-users@vger.kernel.org>; Thu, 26 May 2022 23:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CMMQj1E+W+OKtPtGL0+A/7QGQfBcptKEcxi00C6OVyM=;
        b=M+W4UyLSGvo0t58rgTg4oMEAWDxdBHxc3YEhKYQxoZNueNXltcxeVmDHroiqRe6mCX
         vAPk2+YrS+knE8xUGykw4IHLHi6wFoap27Y8N/5rNtE5jFRh0EYFWSRmFfx9Qc0YLoGS
         rXOmCwyd7s2uOUsFCmyUv7T9U0lY9edRCjawosA6j+NiJVZ9fWZKhouBLD6VSl6r9a+o
         1v/lbqLzRB/IX3YAcn6xSc5C0ZXSSlm4CMO6EH6Je4/gRh/z0e4muMhOLv3AZ9SRM+0w
         adK4gF9rNOJgkzGePyi4l5B87reRTAXFMRRIqgN6EU+Ck87oGSubyrT63AasLcWb5OfF
         vTnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CMMQj1E+W+OKtPtGL0+A/7QGQfBcptKEcxi00C6OVyM=;
        b=jolU7hIVHDXiY7jtrasDrwrU1JJINqgAfnc8uRI923DYw7axLNlsruYrJv6v5m0bcF
         F2Bk/ExKSnWxuxoFBHJ/WDFp23wjdJ2fdVtr0kcOfV8o+dnQFKQL64qKO/jv6pDY8mka
         dZBAzcS1q+e+M+vTfbUXXKD4UhumyJOK2DeD85j4b8IUW8j+KTEz1OVPd+JExiGK1pNK
         5IlgkIS+Z/3v+TEmRU/+oI4j78ShdWSwhK9IpGQG3cViw9P7z/XJuYFyggToGOtwVl4d
         gvTtHOWAPMbvjWr0PXylaT8VI+wQsU6UpjhEPwqboRGWXflQzJ7fYjcOKe7/Ay2JvyEf
         A+Aw==
X-Gm-Message-State: AOAM531EU480OpnMNid9rwbKDRLzGjkEAeWTxo9yCKCVBU/QTPHbonbq
        Gb5wL2/sJVULjdgmcMmtVsu6ghdaiKMh1nLgvreigDqM7pU=
X-Google-Smtp-Source: ABdhPJxKT3L7Rvc+COcl+bNxYDz44rwdvHah0+D7Gyl3cdeFfOZ0CpoL0BGklY6WxeTCFe0e7yh51ljYsQ22wNZz/Ww=
X-Received: by 2002:adf:eb91:0:b0:20f:fcc2:475c with SMTP id
 t17-20020adfeb91000000b0020ffcc2475cmr9968168wrn.40.1653634175621; Thu, 26
 May 2022 23:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220527055217.452307-1-maskray@google.com>
In-Reply-To: <20220527055217.452307-1-maskray@google.com>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 26 May 2022 23:49:22 -0700
Message-ID: <CAP-5=fVk9BmzcinBnjjFKBbNA+ojOo+qjS2m2ZAs7t9c2EkLxw@mail.gmail.com>
Subject: Re: [PATCH] perf: Fix segbase for ld.lld linked objects
To:     Fangrui Song <maskray@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Sebastian Ullrich <sebasti@nullri.ch>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-perf-users.vger.kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org

On Thu, May 26, 2022 at 10:52 PM Fangrui Song <maskray@google.com> wrote:
>
> segbase is the address of .eh_frame_hdr and table_data is segbase plus
> the header size. find_proc_info computes segbase as `map->start +
> segbase - map->pgoff` which is wrong when
>
> * .eh_frame_hdr and .text are in different PT_LOAD program headers
> * and their p_vaddr difference does not equal their p_offset difference
>
> Since 10.0, ld.lld's default --rosegment -z noseparate-code layout has
> such R and RX PT_LOAD program headers.
>
>     ld.lld => fail
>     ld.lld --no-rosegment => ok
>     ld.lld -z separate-code => ok
>
>     ld.bfd -z separate-code (default for Linux/x86) => ok
>     ld.bfd -z noseparate-code => ok
>
> To fix the issue, compute segbase as dso's base address plus
> PT_GNU_EH_FRAME's p_vaddr.
>
> Reported-by: Sebastian Ullrich <sebasti@nullri.ch>
> Link: https://github.com/ClangBuiltLinux/linux/issues/1646
> Signed-off-by: Fangrui Song <maskray@google.com>
> Cc: Ian Rogers <irogers@google.com>

Thanks Fangrui! I tested static vs not, bfd and lld, perf test and
some hand tests. I couldn't see anything out of order. The code looks
good although there could be some ambiguity over the variables ending
_addr as these are the ELF given addresses rather than the thread's
virtual memory addresses. I'm also trying to get more comments
especially on major data structures like dso, but that can be fixed as
a follow-on.

Tested-by: Ian Rogers <irogers@google.com>

> ---
>  tools/perf/util/dso.h                    |  2 +
>  tools/perf/util/unwind-libunwind-local.c | 96 ++++++++++++++++--------
>  2 files changed, 67 insertions(+), 31 deletions(-)
>
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index 3a9fd4d389b5..ec4fc1a9454b 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -179,6 +179,7 @@ struct dso {
>         bool             loaded;
>         u8               rel;
>         struct build_id  bid;
> +       u64              base_addr;
>         u64              text_offset;
>         const char       *short_name;
>         const char       *long_name;
> @@ -197,6 +198,7 @@ struct dso {
>                 u64              file_size;
>                 struct list_head open_entry;
>                 u64              debug_frame_offset;
> +               u64              eh_frame_hdr_addr;
>                 u64              eh_frame_hdr_offset;
>         } data;
>         /* bpf prog information */
> diff --git a/tools/perf/util/unwind-libunwind-local.c b/tools/perf/util/unwind-libunwind-local.c
> index 41e29fc7648a..7a0053954e49 100644
> --- a/tools/perf/util/unwind-libunwind-local.c
> +++ b/tools/perf/util/unwind-libunwind-local.c
> @@ -169,30 +169,55 @@ static int __dw_read_encoded_value(u8 **p, u8 *end, u64 *val,
>         __v;                                                    \
>         })
>
> -static u64 elf_section_offset(int fd, const char *name)
> +static int elf_section_address_and_offset(int fd, const char *name, u64 *address, u64 *offset)
>  {
>         Elf *elf;
>         GElf_Ehdr ehdr;
>         GElf_Shdr shdr;
> -       u64 offset = 0;
> +       int ret;
>
>         elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
>         if (elf == NULL)
> -               return 0;
> +               return -1;
>
> -       do {
> -               if (gelf_getehdr(elf, &ehdr) == NULL)
> -                       break;
> +       if (gelf_getehdr(elf, &ehdr) == NULL)
> +               goto out_err;
>
> -               if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
> -                       break;
> -
> -               offset = shdr.sh_offset;
> -       } while (0);
> +       if (!elf_section_by_name(elf, &ehdr, &shdr, name, NULL))
> +               goto out_err;
>
> +       *address = shdr.sh_addr;
> +       *offset = shdr.sh_offset;
> +       ret = 0;
> +out_err:
>         elf_end(elf);
> +       return ret;
> +}
> +
> +#ifndef NO_LIBUNWIND_DEBUG_FRAME
> +static u64 elf_section_offset(int fd, const char *name)
> +{
> +       u64 address, offset;
> +
> +       if (elf_section_address_and_offset(fd, name, &address, &offset))
> +               return 0;
> +
>         return offset;
>  }
> +#endif
> +
> +static int elf_base_address(int fd)
> +{
> +       Elf *elf = elf_begin(fd, PERF_ELF_C_READ_MMAP, NULL);
> +       GElf_Phdr phdr;
> +       int retval = 0;
> +
> +       if (gelf_getphdr(elf, 0, &phdr) != NULL)
> +               retval = phdr.p_vaddr & -getpagesize();
> +
> +       elf_end(elf);
> +       return retval;
> +}
>
>  #ifndef NO_LIBUNWIND_DEBUG_FRAME
>  static int elf_is_exec(int fd, const char *name)
> @@ -248,8 +273,7 @@ struct eh_frame_hdr {
>  } __packed;
>
>  static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
> -                              u64 offset, u64 *table_data, u64 *segbase,
> -                              u64 *fde_count)
> +                              u64 offset, u64 *table_data_offset, u64 *fde_count)
>  {
>         struct eh_frame_hdr hdr;
>         u8 *enc = (u8 *) &hdr.enc;
> @@ -265,35 +289,45 @@ static int unwind_spec_ehframe(struct dso *dso, struct machine *machine,
>         dw_read_encoded_value(enc, end, hdr.eh_frame_ptr_enc);
>
>         *fde_count  = dw_read_encoded_value(enc, end, hdr.fde_count_enc);
> -       *segbase    = offset;
> -       *table_data = (enc - (u8 *) &hdr) + offset;
> +       *table_data_offset = enc - (u8 *) &hdr;
>         return 0;
>  }
>
> -static int read_unwind_spec_eh_frame(struct dso *dso, struct machine *machine,
> +static int read_unwind_spec_eh_frame(struct dso *dso, struct unwind_info *ui,
>                                      u64 *table_data, u64 *segbase,
>                                      u64 *fde_count)
>  {
> -       int ret = -EINVAL, fd;
> -       u64 offset = dso->data.eh_frame_hdr_offset;
> +       struct map *map;
> +       int ret, fd;
>
> -       if (offset == 0) {
> -               fd = dso__data_get_fd(dso, machine);
> +       if (dso->data.eh_frame_hdr_offset == 0) {
> +               u64 addr_min = UINT64_MAX;
> +
> +               fd = dso__data_get_fd(dso, ui->machine);
>                 if (fd < 0)
>                         return -EINVAL;
>
>                 /* Check the .eh_frame section for unwinding info */
> -               offset = elf_section_offset(fd, ".eh_frame_hdr");
> -               dso->data.eh_frame_hdr_offset = offset;
> +               ret = elf_section_address_and_offset(fd, ".eh_frame_hdr",
> +                                                    &dso->data.eh_frame_hdr_addr,
> +                                                    &dso->data.eh_frame_hdr_offset);
> +               maps__for_each_entry(ui->thread->maps, map) {
> +                       if (map->dso == dso && map->start < addr_min)
> +                               addr_min = map->start;
> +               }
> +               dso->base_addr = addr_min - elf_base_address(fd);
>                 dso__data_put_fd(dso);
> +               if (ret || dso->data.eh_frame_hdr_offset == 0)
> +                   return -EINVAL;
>         }
>
> -       if (offset)
> -               ret = unwind_spec_ehframe(dso, machine, offset,
> -                                         table_data, segbase,
> -                                         fde_count);
> -
> -       return ret;
> +       *segbase = dso->base_addr + dso->data.eh_frame_hdr_addr;
> +       ret = unwind_spec_ehframe(dso, ui->machine, dso->data.eh_frame_hdr_offset,
> +                                  table_data, fde_count);
> +       if (ret)
> +           return ret;
> +       *table_data += *segbase;
> +       return 0;
>  }
>
>  #ifndef NO_LIBUNWIND_DEBUG_FRAME
> @@ -388,14 +422,14 @@ find_proc_info(unw_addr_space_t as, unw_word_t ip, unw_proc_info_t *pi,
>         pr_debug("unwind: find_proc_info dso %s\n", map->dso->name);
>
>         /* Check the .eh_frame section for unwinding info */
> -       if (!read_unwind_spec_eh_frame(map->dso, ui->machine,
> +       if (!read_unwind_spec_eh_frame(map->dso, ui,
>                                        &table_data, &segbase, &fde_count)) {
>                 memset(&di, 0, sizeof(di));
>                 di.format   = UNW_INFO_FORMAT_REMOTE_TABLE;
>                 di.start_ip = map->start;
>                 di.end_ip   = map->end;
> -               di.u.rti.segbase    = map->start + segbase - map->pgoff;
> -               di.u.rti.table_data = map->start + table_data - map->pgoff;
> +               di.u.rti.segbase    = segbase;
> +               di.u.rti.table_data = table_data;
>                 di.u.rti.table_len  = fde_count * sizeof(struct table_entry)
>                                       / sizeof(unw_word_t);
>                 ret = dwarf_search_unwind_table(as, ip, &di, pi,
> --
> 2.36.1.124.g0e6072fb45-goog
>
