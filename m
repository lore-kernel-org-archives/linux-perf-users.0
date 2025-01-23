Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4891B4150
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737671488; cv=none; b=ByAVharjmjBZwWNyF/K3v/mcOmgUxJAmPzUIGjChuWTNWyuLHYRhqYuuSuyb8qGMVowwAnNPQG5lpuW1i72/HyJr8ZQzmA4t6QkGtxKaGaR1zq66a7ESsW7JYH4rSgeqOVjVosjYJw8FedU6WPBYzwOgNbz7O+V3qnPhb18bN+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737671488; c=relaxed/simple;
	bh=xqR83RCHpEzd0cRixkitnU7bDWOP6qfrz7MXU1ccb7Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o4sFcqjHv7VHjf6p42+PjD8lW6f+dDYsDMR2IhpVRFjy3LYiAnHU1KjER7rhtWize8dqVUn3jOUrrTaxOpLTHsZjsBXAm7b2poLNcj72wm0cRpEa9/CVUr6PYjArie6qefyuOm/Y3oJhlfH+YRkTh3l2jMNAKUg9bwk1Q9uAMIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2euT+nro; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2euT+nro"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3a7dfcd40fcso10645ab.1
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 14:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737671486; x=1738276286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShIZYmiz5rEdJRdcejQKKDjBHYyqPeQRUwD3bDwuMzc=;
        b=2euT+nrobgSMX9qmeIShdqmTrXJgzCwk1a5TpLoBwzVNg2Z2r0Ng4iYT1+BWZTXZCt
         d+ICEBxOov2AlBb0wTsr/BBNozB426CZqMaDku6enkwBH3mUwpP5+ymjbgRwv5o42H1p
         5SK7A5To06OHE2u19BvC6C7szAS3IatXkSJuT/Al02it3lAZTmgOfR8Hb+k6gONj5es0
         Nh6cb+vO87e0IQHoPxAZqI3vSBQUCxi3Q4UpxWo8oYnBgCPFx4ev9IbDQEy4X4QUMRiF
         TLbqGp0I7mgwY6k+f8fgcDOOF4XWPbEoLp2hxSKcWwgezwyI6/jVhyDidp8YtpQ2tkTY
         iKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737671486; x=1738276286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShIZYmiz5rEdJRdcejQKKDjBHYyqPeQRUwD3bDwuMzc=;
        b=wgYT5uA14FNGMn60CWKN1O3d5cbkWmsBkHGnfdFDT2C8ejKpm0xPi2W4u1czogtbBT
         qAUS1DviNFZTYcIbA/qW5PGgSrDhJAJuoxwubLKFsWV/5+uhB89PS4b0KMK+Aw1g6pB9
         OmOgeRCcSDVmjGYuGdUvpoSD8NLydx1FX9EkPsALCSK99tlhsyipR5K4wW2w9tbRhlOK
         kDoPqt7HoSf/tzCUKlApCa1ZAxGVCgZS8Hui00Otx0M1Keu3ctWiiy2lLVE/JOthmby0
         jdow5mm9c7JyVtTj5HwVBmyDehaWiz/pN27XpQ2zwxP7y+VM6wXpYz0k0cPf6LChzt8t
         QgkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa5Eu8baIyvK/eCHrHba5iCxIKLUjK+eRmxrp1sXVOouVrDAn2Uluv8+fTOXiT9MvFXTh/R9bzdjPRMmO9E/AX@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRcIn2v7i1yIh+RA328GX9EP+a8vXgfuiDXKUBB4IpFJV9eJh
	QvVaaVGbnqMtqWH025U5OGgE/PB/tHX77Hq1WADM5g64xlxvaEOISqxq0fkgiCMHwSt8lpYZ2F4
	zmrNFWlliTd/cU0qxXXy1gBS5ZXNIWzIYwq5c
X-Gm-Gg: ASbGncuh1TDftdYq+DE+zqYzSojDgTJT9USFJw2ykexxspryEOPzgFq1AkMYNF/jXWL
	GqZ21VeeuhAwW51LomygdbWvoWPd5+yObr/0VCKglhj9ZyMhlvrePzh6FmKiWCQFLL7KR+kjlw+
	wwtPyF8ggwEI1W9w==
X-Google-Smtp-Source: AGHT+IH3ZqSReuJbZWIKzWK99ERSZRALerf83DfB8RMs7JhV1U/wbd/m8iDVKSsMRGUsVLtbXVlZHzQpZkLU+RM8akk=
X-Received: by 2002:a05:6e02:4d2:b0:3cf:c75d:150f with SMTP id
 e9e14a558f8ab-3cfc75d1a59mr1242165ab.12.1737671485842; Thu, 23 Jan 2025
 14:31:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241111151734.1018476-1-acme@kernel.org> <20241111151734.1018476-4-acme@kernel.org>
In-Reply-To: <20241111151734.1018476-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 23 Jan 2025 14:31:14 -0800
X-Gm-Features: AWEUYZk7bKB4gw79k6x73ejQp4VlbKC9jnY7e9GfwWyxbcYSPlcJ9cGASkLFqdw
Message-ID: <CAP-5=fUdfCyxmEiTpzS2uumUp3-SyQOseX2xZo81-dQtWXj6vA@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf disasm: Allow configuring what disassemblers to use
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>, "Steinar H. Gunderson" <sesse@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 11, 2024 at 7:18=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> The perf tools annotation code used for a long time parsing the output
> of binutils's objdump (or its reimplementations, like llvm's) to then
> parse and augment it with samples, allow navigation, etc.
>
> More recently disassemblers from the capstone and llvm (libraries, not
> parsing the output of tools using those libraries to mimic binutils's
> objdump output) were introduced.
>
> So when all those methods are available, there is a static preference
> for a series of attempts of disassembling a binary, with the 'llvm,
> capstone, objdump' sequence being hard coded.
>
> This patch allows users to change that sequence, specifying via a 'perf
> config' 'annotate.disassemblers' entry which and in what order
> disassemblers should be attempted.
>
> As alluded to in the comments in the source code of this series, this
> flexibility is useful for users and developers alike, elliminating the
> requirement to rebuild the tool with some specific set of libraries to
> see how the output of disassembling would be for one of these methods.
>
>   root@x1:~# rm -f ~/.perfconfig
>   root@x1:~# perf annotate -v --stdio2 update_load_avg
>   <SNIP>
>   symbol__disassemble:
>     filename=3D/usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux,
>     sym=3Dupdate_load_avg, start=3D0xffffffffb6148fe0, en>
>   annotating [0x6ff7170]
>     /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux :
>     [0x7407ca0] update_load_avg
>   Disassembled with llvm
>   annotate.disassemblers=3Dllvm,capstone,objdump
>   Samples: 66  of event 'cpu_atom/cycles/P', 10000 Hz,
>         Event count (approx.): 5185444, [percent: local period]
>   update_load_avg()
>     /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux
>   Percent       0xffffffff81148fe0 <update_load_avg>:
>      1.61         pushq   %r15
>                   pushq   %r14
>      1.00         pushq   %r13
>                   movl    %edx,%r13d
>      1.90         pushq   %r12
>                   pushq   %rbp
>                   movq    %rsi,%rbp
>                   pushq   %rbx
>                   movq    %rdi,%rbx
>                   subq    $0x18,%rsp
>     15.14         movl    0x1a4(%rdi),%eax
>
>   root@x1:~# perf config annotate.disassemblers=3Dcapstone
>   root@x1:~# cat ~/.perfconfig
>   # this file is auto-generated.
>   [annotate]
>           disassemblers =3D capstone
>   root@x1:~#
>   root@x1:~# perf annotate -v --stdio2 update_load_avg
>   <SNIP>
>   Disassembled with capstone
>   annotate.disassemblers=3Dcapstone
>   Samples: 66  of event 'cpu_atom/cycles/P', 10000 Hz,
>   Event count (approx.): 5185444, [percent: local period]
>   update_load_avg()
>   /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux
>   Percent       0xffffffff81148fe0 <update_load_avg>:
>      1.61         pushq   %r15
>                   pushq   %r14
>      1.00         pushq   %r13
>                   movl    %edx,%r13d
>      1.90         pushq   %r12
>                   pushq   %rbp
>                   movq    %rsi,%rbp
>                   pushq   %rbx
>                   movq    %rdi,%rbx
>                   subq    $0x18,%rsp
>     15.14         movl    0x1a4(%rdi),%eax
>   root@x1:~# perf config annotate.disassemblers=3Dobjdump,capstone
>   root@x1:~# perf config annotate.disassemblers
>   annotate.disassemblers=3Dobjdump,capstone
>   root@x1:~# cat ~/.perfconfig
>   # this file is auto-generated.
>   [annotate]
>           disassemblers =3D objdump,capstone
>   root@x1:~# perf annotate -v --stdio2 update_load_avg
>   Executing: objdump  --start-address=3D0xffffffff81148fe0 \
>                       --stop-address=3D0xffffffff811497aa  \
>                       -d --no-show-raw-insn -S -C "$1"
>   Disassembled with objdump
>   annotate.disassemblers=3Dobjdump,capstone
>   Samples: 66  of event 'cpu_atom/cycles/P', 10000 Hz,
>   Event count (approx.): 5185444, [percent: local period]
>   update_load_avg()
>   /usr/lib/debug/lib/modules/6.11.4-201.fc40.x86_64/vmlinux
>   Percent
>
>                 Disassembly of section .text:
>
>                 ffffffff81148fe0 <update_load_avg>:
>                 #define DO_ATTACH       0x4
>
>                 ffffffff81148fe0 <update_load_avg>:
>                 #define DO_ATTACH       0x4
>                 #define DO_DETACH       0x8
>
>                 /* Update task and its cfs_rq load average */
>                 static inline void update_load_avg(struct cfs_rq *cfs_rq,
>                                                    struct sched_entity *s=
e,
>                                                    int flags)
>                 {
>      1.61         push   %r15
>                   push   %r14
>      1.00         push   %r13
>                   mov    %edx,%r13d
>      1.90         push   %r12
>                   push   %rbp
>                   mov    %rsi,%rbp
>                   push   %rbx
>                   mov    %rdi,%rbx
>                   sub    $0x18,%rsp
>                 }
>
>                 /* rq->task_clock normalized against any time
>                    this cfs_rq has spent throttled */
>                 static inline u64 cfs_rq_clock_pelt(struct cfs_rq *cfs_rq=
)
>                 {
>                 if (unlikely(cfs_rq->throttle_count))
>     15.14         mov    0x1a4(%rdi),%eax
>   root@x1:~#
>
> After adding a way to select the disassembler from the command line a
> 'perf test' comparing the output of the various diassemblers should be
> introduced, to test these codebases.
>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Steinar H. Gunderson <sesse@google.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/Documentation/perf-config.txt | 13 ++++
>  tools/perf/util/annotate.c               |  6 ++
>  tools/perf/util/annotate.h               |  6 ++
>  tools/perf/util/disasm.c                 | 77 ++++++++++++++++++++++--
>  4 files changed, 96 insertions(+), 6 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-config.txt b/tools/perf/Docume=
ntation/perf-config.txt
> index 379f9d7a8ab11a02..1f668d4724e3749a 100644
> --- a/tools/perf/Documentation/perf-config.txt
> +++ b/tools/perf/Documentation/perf-config.txt
> @@ -247,6 +247,19 @@ annotate.*::
>         These are in control of addresses, jump function, source code
>         in lines of assembly code from a specific program.
>
> +       annotate.disassemblers::
> +               Choose the disassembler to use: "objdump", "llvm",  "caps=
tone",
> +               if not specified it will first try, if available, the "ll=
vm" one,
> +               then, if it fails, "capstone", and finally the original "=
objdump"
> +               based one.
> +
> +               Choosing a different one is useful when handling some fea=
ture that
> +               is known to be best support at some point by one of the o=
ptions,
> +               to compare the output when in doubt about some bug, etc.
> +
> +               This can be a list, in order of preference, the first one=
 that works
> +               finishes the process.
> +
>         annotate.addr2line::
>                 addr2line binary to use for file names and line numbers.
>
> diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
> index b1d98da79be8b2b0..32e15c9f53f3c0a3 100644
> --- a/tools/perf/util/annotate.c
> +++ b/tools/perf/util/annotate.c
> @@ -2116,6 +2116,12 @@ static int annotation__config(const char *var, con=
st char *value, void *data)
>                         opt->offset_level =3D ANNOTATION__MAX_OFFSET_LEVE=
L;
>                 else if (opt->offset_level < ANNOTATION__MIN_OFFSET_LEVEL=
)
>                         opt->offset_level =3D ANNOTATION__MIN_OFFSET_LEVE=
L;
> +       } else if (!strcmp(var, "annotate.disassemblers")) {
> +               opt->disassemblers_str =3D strdup(value);
> +               if (!opt->disassemblers_str) {
> +                       pr_err("Not enough memory for annotate.disassembl=
ers\n");
> +                       return -1;
> +               }
>         } else if (!strcmp(var, "annotate.hide_src_code")) {
>                 opt->hide_src_code =3D perf_config_bool("hide_src_code", =
value);
>         } else if (!strcmp(var, "annotate.jump_arrows")) {
> diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
> index 8b9e05a1932f2f9e..194a05cbc506e4da 100644
> --- a/tools/perf/util/annotate.h
> +++ b/tools/perf/util/annotate.h
> @@ -34,6 +34,9 @@ struct annotated_data_type;
>  #define ANNOTATION__BR_CNTR_WIDTH 30
>  #define ANNOTATION_DUMMY_LEN   256
>
> +// llvm, capstone, objdump
> +#define MAX_DISASSEMBLERS 3
> +
>  struct annotation_options {
>         bool hide_src_code,
>              use_offset,
> @@ -49,11 +52,14 @@ struct annotation_options {
>              annotate_src,
>              full_addr;
>         u8   offset_level;
> +       u8   nr_disassemblers;
>         int  min_pcnt;
>         int  max_lines;
>         int  context;
>         char *objdump_path;
>         char *disassembler_style;
> +       const char *disassemblers_str;
> +       const char *disassemblers[MAX_DISASSEMBLERS];
>         const char *prefix;
>         const char *prefix_strip;
>         unsigned int percent_type;
> diff --git a/tools/perf/util/disasm.c b/tools/perf/util/disasm.c
> index 83df1da20a7b16cd..df6c172c9c7f86d9 100644
> --- a/tools/perf/util/disasm.c
> +++ b/tools/perf/util/disasm.c
> @@ -2210,13 +2210,65 @@ static int symbol__disassemble_objdump(const char=
 *filename, struct symbol *sym,
>         return err;
>  }
>
> +static int annotation_options__init_disassemblers(struct annotation_opti=
ons *options)
> +{
> +       char *disassembler;
> +
> +       if (options->disassemblers_str =3D=3D NULL) {
> +               const char *default_disassemblers_str =3D
> +#ifdef HAVE_LIBLLVM_SUPPORT
> +                               "llvm,"
> +#endif
> +#ifdef HAVE_LIBCAPSTONE_SUPPORT
> +                               "capstone,"
> +#endif
> +                               "objdump";
> +
> +               options->disassemblers_str =3D strdup(default_disassemble=
rs_str);
> +               if (!options->disassemblers_str)
> +                       goto out_enomem;
> +       }
> +
> +       disassembler =3D strdup(options->disassemblers_str);
> +       if (disassembler =3D=3D NULL)
> +               goto out_enomem;
> +
> +       while (1) {
> +               char *comma =3D strchr(disassembler, ',');
> +
> +               if (comma !=3D NULL)
> +                       *comma =3D '\0';
> +
> +               options->disassemblers[options->nr_disassemblers++] =3D s=
trim(disassembler);

Here is an array assignment.

> +
> +               if (comma =3D=3D NULL)
> +                       break;
> +
> +               disassembler =3D comma + 1;
> +
> +               if (options->nr_disassemblers >=3D MAX_DISASSEMBLERS) {
> +                       pr_debug("annotate.disassemblers can have at most=
 %d entries, ignoring \"%s\"\n",
> +                                MAX_DISASSEMBLERS, disassembler);
> +                       break;
> +               }

The bound check is after the assignment.

> +       }
> +
> +       return 0;
> +
> +out_enomem:
> +       pr_err("Not enough memory for annotate.disassemblers\n");
> +       return -1;
> +}
> +
>  int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
>  {
> +       struct annotation_options *options =3D args->options;
>         struct map *map =3D args->ms.map;
>         struct dso *dso =3D map__dso(map);
>         char symfs_filename[PATH_MAX];
>         bool delete_extract =3D false;
>         struct kcore_extract kce;
> +       const char *disassembler;
>         bool decomp =3D false;
>         int err =3D dso__disassemble_filename(dso, symfs_filename, sizeof=
(symfs_filename));
>
> @@ -2276,16 +2328,29 @@ int symbol__disassemble(struct symbol *sym, struc=
t annotate_args *args)
>                 }
>         }
>
> -       err =3D symbol__disassemble_llvm(symfs_filename, sym, args);
> -       if (err =3D=3D 0)
> +       err =3D annotation_options__init_disassemblers(options);

symbol__disassemble may be called more than once so
annotation_options__init_disassemblers can be called more than once
yielding a buffer overflow above. I'm working on a fix which removes
some of the fiddliness of using strings.

Thanks,
Ian

> +       if (err)
>                 goto out_remove_tmp;
>
> -       err =3D symbol__disassemble_capstone(symfs_filename, sym, args);
> -       if (err =3D=3D 0)
> -               goto out_remove_tmp;
> +       err =3D -1;
>
> -       err =3D symbol__disassemble_objdump(symfs_filename, sym, args);
> +       for (int i =3D 0; i < options->nr_disassemblers && err !=3D 0; ++=
i) {
> +               disassembler =3D options->disassemblers[i];
>
> +               if (!strcmp(disassembler, "llvm"))
> +                       err =3D symbol__disassemble_llvm(symfs_filename, =
sym, args);
> +               else if (!strcmp(disassembler, "capstone"))
> +                       err =3D symbol__disassemble_capstone(symfs_filena=
me, sym, args);
> +               else if (!strcmp(disassembler, "objdump"))
> +                       err =3D symbol__disassemble_objdump(symfs_filenam=
e, sym, args);
> +               else
> +                       pr_debug("Unknown disassembler %s, skipping...\n"=
, disassembler);
> +       }
> +
> +       if (err =3D=3D 0) {
> +               pr_debug("Disassembled with %s\nannotate.disassemblers=3D=
%s\n",
> +                        disassembler, options->disassemblers_str);
> +       }
>  out_remove_tmp:
>         if (decomp)
>                 unlink(symfs_filename);
> --
> 2.47.0
>
