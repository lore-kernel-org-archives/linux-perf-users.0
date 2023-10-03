Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5C710FE
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Oct 2023 04:28:44 +0000 (UTC)
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929AA4
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Oct 2023 21:28:43 -0700 (PDT)
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-565e54cb93aso237160a12.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Oct 2023 21:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696307322; x=1696912122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ui5vQUghw0mUmrDD+JeX4I/UKJ+qz0BegH6zc5Qe3i4=;
        b=fbP2JA5MzKFsqBvuzGpqFPfy26/KScwOeHltLCqLw8uitwrkvw51bmMase4TCX31fA
         bfSkjCas53StxsDBtRYHSFeyBVLCdkjbI6IfxQOaOmTWQNDiYF5tJg97RVuPY9FpFKd7
         ++fzovHnhg6s9EHr0i0icOTtq2sLsmYOVpUXZWHaJBGm6jrh0zn1BXnU/MrXRbaz4gZD
         IQMrvgQTGx9SzaEElv9M4hPbzkrKGlBzbOKNHFdSzfPY145oF1xopxCpZuJtKWjVJ+xZ
         EKJRzciujeRWxQY8Ki6fvkkKR7x3gA6E3jVf5FZKkeK68lg6/YH+tKkAl56UHW8Q2iLg
         Sflw==
X-Gm-Message-State: AOJu0YzIEMA2xnumwHWZw3Ofku2aTxgNvoZHiId8APsqSGCpdj6ssiug
	iz53kjeeVq8rswhxzBXYoQs2lAF/oDdFuZgh3oE=
X-Google-Smtp-Source: AGHT+IGAYn6urh4QQpEb1WP35HB4W0615OWmzQRgcXzZodqLzIRl8jDxQ089v8BXwy2w3l14Af6R0W0fKNMmKkKUGXQ=
X-Received: by 2002:a17:90a:e503:b0:26b:56fa:87d3 with SMTP id
 t3-20020a17090ae50300b0026b56fa87d3mr11514638pjy.31.1696307322223; Mon, 02
 Oct 2023 21:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230928075213.84392-1-atrajeev@linux.vnet.ibm.com>
In-Reply-To: <20230928075213.84392-1-atrajeev@linux.vnet.ibm.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 2 Oct 2023 21:28:30 -0700
Message-ID: <CAM9d7cj0iLdrV6EYmo_oC9M_32fuRVv_geBPz4GJv41jZR5WNQ@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] tools/perf: Add text_end to "struct dso" to save
 .text section size
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
	irogers@google.com, linux-perf-users@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, kjain@linux.ibm.com, 
	disgoel@linux.vnet.ibm.com, Disha Goel <disgoel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

On Thu, Sep 28, 2023 at 12:52=E2=80=AFAM Athira Rajeev
<atrajeev@linux.vnet.ibm.com> wrote:
>
> Update "struct dso" to include new member "text_end".
> This new field will represent the offset for end of text
> section for a dso. For elf, this value is derived as:
> sh_size (Size of section in byes) + sh_offset (Section file
> offst) of the elf header for text.
>
> For bfd, this value is derived as:
> 1. For PE file,
> section->size + ( section->vma - dso->text_offset)
> 2. Other cases:
> section->filepos (file position) + section->size (size of
> section)
>
> To resolve the address from a sample, perf looks at the
> DSO maps. In case of address from a kernel module, there
> were some address found to be not resolved. This was
> observed while running perf test for "Object code reading".
> Though the ip falls beteen the start address of the loaded
> module (perf map->start ) and end address ( perf map->end),
> it was unresolved.
>
> Example:
>
>     Reading object code for memory address: 0xc008000007f0142c
>     File is: /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     On file address is: 0x1114cc
>     Objdump command is: objdump -z -d --start-address=3D0x11142c --stop-a=
ddress=3D0x1114ac /lib/modules/6.5.0-rc3+/kernel/fs/xfs/xfs.ko
>     objdump read too few bytes: 128
>     test child finished with -1
>
> Here, module is loaded at:
>     # cat /proc/modules | grep xfs
>     xfs 2228224 3 - Live 0xc008000007d00000
>
> From objdump for xfs module, text section is:
>     text 0010f7bc  0000000000000000 0000000000000000 000000a0 2**4
>
> Here the offset for 0xc008000007f0142c ie  0x112074 falls out
> .text section which is up to 0x10f7bc.
>
> In this case for module, the address 0xc008000007e11fd4 is pointing
> to stub instructions. This address range represents the module stubs
> which is allocated on module load and hence is not part of DSO offset.
>
> To identify such  address, which falls out of text
> section and within module end, added the new field "text_end" to
> "struct dso".
>
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> Reviewed-by: Kajol Jain <kjain@linux.ibm.com>

For the series,
Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
> Changelog:
> v2 -> v3:
>  Added Reviewed-by from Adrian
>
>  v1 -> v2:
>  Added text_end for bfd also by updating dso__load_bfd_symbols
>  as suggested by Adrian.
>
>  tools/perf/util/dso.h        | 1 +
>  tools/perf/util/symbol-elf.c | 4 +++-
>  tools/perf/util/symbol.c     | 2 ++
>  3 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/dso.h b/tools/perf/util/dso.h
> index b41c9782c754..70fe0fe69bef 100644
> --- a/tools/perf/util/dso.h
> +++ b/tools/perf/util/dso.h
> @@ -181,6 +181,7 @@ struct dso {
>         u8               rel;
>         struct build_id  bid;
>         u64              text_offset;
> +       u64              text_end;
>         const char       *short_name;
>         const char       *long_name;
>         u16              long_name_len;
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 95e99c332d7e..9e7eeaf616b8 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1514,8 +1514,10 @@ dso__load_sym_internal(struct dso *dso, struct map=
 *map, struct symsrc *syms_ss,
>         }
>
>         if (elf_section_by_name(runtime_ss->elf, &runtime_ss->ehdr, &tshd=
r,
> -                               ".text", NULL))
> +                               ".text", NULL)) {
>                 dso->text_offset =3D tshdr.sh_addr - tshdr.sh_offset;
> +               dso->text_end =3D tshdr.sh_offset + tshdr.sh_size;
> +       }
>
>         if (runtime_ss->opdsec)
>                 opddata =3D elf_rawdata(runtime_ss->opdsec, NULL);
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 3f36675b7c8f..f25e4e62cf25 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1733,8 +1733,10 @@ int dso__load_bfd_symbols(struct dso *dso, const c=
har *debugfile)
>                         /* PE symbols can only have 4 bytes, so use .text=
 high bits */
>                         dso->text_offset =3D section->vma - (u32)section-=
>vma;
>                         dso->text_offset +=3D (u32)bfd_asymbol_value(symb=
ols[i]);
> +                       dso->text_end =3D (section->vma - dso->text_offse=
t) + section->size;
>                 } else {
>                         dso->text_offset =3D section->vma - section->file=
pos;
> +                       dso->text_end =3D section->filepos + section->siz=
e;
>                 }
>         }
>
> --
> 2.31.1
>
