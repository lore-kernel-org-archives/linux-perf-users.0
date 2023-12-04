Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D0E111;
	Mon,  4 Dec 2023 15:39:20 -0800 (PST)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66b093b86so1605819a12.0;
        Mon, 04 Dec 2023 15:39:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733160; x=1702337960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MiEB5WVQCF9UL/yEGcP5ywJ1Glq90gPG/bPJvMK8tRA=;
        b=ndmAoD0nemrlwqgYlaN7WBuO46ZeZqsinfs5rM4vT+tdv+xIANB4WMsoET6Q8UyJJu
         HPWRnaeMmpZln7KacGTA0/incP7T3gPOYlhLgkz6JtCp5naByh11udXL96cELDfJHzhD
         zY9ey4dFIvgPXExIY5Rifd3z0G9sJP64ZcI/jqC1U1L/rlwclOVQQykgxoYZX8I2YVEB
         ET04epSXl8VBSd1XP+0n9nZ5LQxLO8CFwBbzCVF+D2JKakzoYz74PfkKhwZGmKkCpUj/
         Fo5/er1Wg3DfWsKwRnxbQa9W3/nq/IzDEeUyXATRbe3+Qe2ghLfXuUSL47gJrtDJbVKq
         TRKg==
X-Gm-Message-State: AOJu0YxrvvB9BTgLQeo+sVBdtR5tc9/ol1rfdSphScASOOIZVCppRSsY
	yw2NocfdLRZmm4diXbrv7eElE9vrmtGYzW8cqPQ=
X-Google-Smtp-Source: AGHT+IEE3dQ6SeJfeoYHnnk6ofcJGZYyWWv1VvcvLwagnm513ddlLyTmjavhxGOwwNeOpcqtiypOYaE5417Ok7CDHY8=
X-Received: by 2002:a17:90b:4c12:b0:286:6cd8:ef18 with SMTP id
 na18-20020a17090b4c1200b002866cd8ef18mr323218pjb.48.1701733159820; Mon, 04
 Dec 2023 15:39:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-13-irogers@google.com>
In-Reply-To: <20231127220902.1315692-13-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Dec 2023 15:39:08 -0800
Message-ID: <CAM9d7cgrx7vjLtnSt6Y4q+vtok=kSy6V83xe0c6cT6BVY2m-oA@mail.gmail.com>
Subject: Re: [PATCH v5 12/50] perf map: Simplify map_ip/unmap_ip and make map
 size smaller
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Nick Terrell <terrelln@fb.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Kajol Jain <kjain@linux.ibm.com>, Athira Rajeev <atrajeev@linux.vnet.ibm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Vincent Whitchurch <vincent.whitchurch@axis.com>, "Steinar H. Gunderson" <sesse@google.com>, 
	Liam Howlett <liam.howlett@oracle.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Colin Ian King <colin.i.king@gmail.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Yang Jihong <yangjihong1@huawei.com>, Ming Wang <wangming01@loongson.cn>, 
	James Clark <james.clark@arm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	Sean Christopherson <seanjc@google.com>, Leo Yan <leo.yan@linaro.org>, 
	Ravi Bangoria <ravi.bangoria@amd.com>, German Gomez <german.gomez@arm.com>, 
	Changbin Du <changbin.du@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>, 
	Sandipan Das <sandipan.das@amd.com>, liuwenyu <liuwenyu7@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	Guilherme Amadio <amadio@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ian,

On Mon, Nov 27, 2023 at 2:09=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> When mapping an IP it is either an identity mapping or a DSO relative
> mapping, so a single bit is required in the struct to identify
> this. The current code uses function pointers, adding 2 pointers per
> map and also pushing the size of a map beyond 1 cache line. Switch to
> using a byte to identify the mapping type (as well as priv and
> erange_warned), to avoid any masking. Change struct maps's layout to
> avoid holes.
>
> Before:
> ```
> struct map {
>         u64                        start;                /*     0     8 *=
/
>         u64                        end;                  /*     8     8 *=
/
>         _Bool                      erange_warned:1;      /*    16: 0  1 *=
/
>         _Bool                      priv:1;               /*    16: 1  1 *=
/
>
>         /* XXX 6 bits hole, try to pack */
>         /* XXX 3 bytes hole, try to pack */
>
>         u32                        prot;                 /*    20     4 *=
/
>         u64                        pgoff;                /*    24     8 *=
/
>         u64                        reloc;                /*    32     8 *=
/
>         u64                        (*map_ip)(const struct map  *, u64); /=
*    40     8 */
>         u64                        (*unmap_ip)(const struct map  *, u64);=
 /*    48     8 */
>         struct dso *               dso;                  /*    56     8 *=
/
>         /* --- cacheline 1 boundary (64 bytes) --- */
>         refcount_t                 refcnt;               /*    64     4 *=
/
>         u32                        flags;                /*    68     4 *=
/
>
>         /* size: 72, cachelines: 2, members: 12 */
>         /* sum members: 68, holes: 1, sum holes: 3 */
>         /* sum bitfield members: 2 bits, bit holes: 1, sum bit holes: 6 b=
its */
>         /* last cacheline: 8 bytes */
> };
> ```
>
> After:
> ```
> struct map {
>         u64                        start;                /*     0     8 *=
/
>         u64                        end;                  /*     8     8 *=
/
>         u64                        pgoff;                /*    16     8 *=
/
>         u64                        reloc;                /*    24     8 *=
/
>         struct dso *               dso;                  /*    32     8 *=
/
>         refcount_t                 refcnt;               /*    40     4 *=
/
>         u32                        prot;                 /*    44     4 *=
/
>         u32                        flags;                /*    48     4 *=
/
>         enum mapping_type          mapping_type:8;       /*    52: 0  4 *=
/
>
>         /* Bitfield combined with next fields */
>
>         _Bool                      erange_warned;        /*    53     1 *=
/
>         _Bool                      priv;                 /*    54     1 *=
/
>
>         /* size: 56, cachelines: 1, members: 11 */
>         /* padding: 1 */
>         /* last cacheline: 56 bytes */
> };
> ```

Thanks for doing this!  I really wanted to clean up the map
code and to make it more intuitive.

>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

A few nitpicks below.

> ---
>  tools/perf/util/machine.c    |  3 +-
>  tools/perf/util/map.c        | 20 +--------
>  tools/perf/util/map.h        | 83 +++++++++++++++++++-----------------
>  tools/perf/util/symbol-elf.c |  6 +--
>  tools/perf/util/symbol.c     |  6 +--
>  5 files changed, 50 insertions(+), 68 deletions(-)
>
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index be3dab9d5253..b6831a1f909d 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -1360,8 +1360,7 @@ __machine__create_kernel_maps(struct machine *machi=
ne, struct dso *kernel)
>         if (machine->vmlinux_map =3D=3D NULL)
>                 return -ENOMEM;
>
> -       map__set_map_ip(machine->vmlinux_map, identity__map_ip);
> -       map__set_unmap_ip(machine->vmlinux_map, identity__map_ip);
> +       map__set_mapping_type(machine->vmlinux_map, MAPPING_TYPE__IDENTIT=
Y);
>         return maps__insert(machine__kernel_maps(machine), machine->vmlin=
ux_map);
>  }
>
> diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
> index f64b83004421..54c67cb7ecef 100644
> --- a/tools/perf/util/map.c
> +++ b/tools/perf/util/map.c
> @@ -109,8 +109,7 @@ void map__init(struct map *map, u64 start, u64 end, u=
64 pgoff, struct dso *dso)
>         map__set_pgoff(map, pgoff);
>         map__set_reloc(map, 0);
>         map__set_dso(map, dso__get(dso));
> -       map__set_map_ip(map, map__dso_map_ip);
> -       map__set_unmap_ip(map, map__dso_unmap_ip);
> +       map__set_mapping_type(map, MAPPING_TYPE__DSO);
>         map__set_erange_warned(map, false);
>         refcount_set(map__refcnt(map), 1);
>  }
> @@ -172,7 +171,7 @@ struct map *map__new(struct machine *machine, u64 sta=
rt, u64 len,
>                 map__init(result, start, start + len, pgoff, dso);
>
>                 if (anon || no_dso) {
> -                       map->map_ip =3D map->unmap_ip =3D identity__map_i=
p;
> +                       map->mapping_type =3D MAPPING_TYPE__IDENTITY;
>
>                         /*
>                          * Set memory without DSO as loaded. All map__fin=
d_*
> @@ -630,18 +629,3 @@ struct maps *map__kmaps(struct map *map)
>         }
>         return kmap->kmaps;
>  }
> -
> -u64 map__dso_map_ip(const struct map *map, u64 ip)
> -{
> -       return ip - map__start(map) + map__pgoff(map);
> -}
> -
> -u64 map__dso_unmap_ip(const struct map *map, u64 ip)
> -{
> -       return ip + map__start(map) - map__pgoff(map);
> -}
> -
> -u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip)
> -{
> -       return ip;
> -}
> diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
> index 1b53d53adc86..3a3b7757da5f 100644
> --- a/tools/perf/util/map.h
> +++ b/tools/perf/util/map.h
> @@ -16,23 +16,25 @@ struct dso;
>  struct maps;
>  struct machine;
>
> +enum mapping_type {
> +       /* map__map_ip/map__unmap_ip are given as offsets in the DSO. */
> +       MAPPING_TYPE__DSO,

I slightly prefer __PIC than __DSO, but won't argue. :)

> +       /* map__map_ip/map__unmap_ip are just the given ip value. */
> +       MAPPING_TYPE__IDENTITY,
> +};
> +
>  DECLARE_RC_STRUCT(map) {
>         u64                     start;
>         u64                     end;
> -       bool                    erange_warned:1;
> -       bool                    priv:1;
> -       u32                     prot;
>         u64                     pgoff;
>         u64                     reloc;
> -
> -       /* ip -> dso rip */
> -       u64                     (*map_ip)(const struct map *, u64);
> -       /* dso rip -> ip */
> -       u64                     (*unmap_ip)(const struct map *, u64);
> -
>         struct dso              *dso;
>         refcount_t              refcnt;
> +       u32                     prot;
>         u32                     flags;
> +       enum mapping_type       mapping_type:8;
> +       bool                    erange_warned;
> +       bool                    priv;
>  };
>
>  struct kmap;
> @@ -41,38 +43,11 @@ struct kmap *__map__kmap(struct map *map);
>  struct kmap *map__kmap(struct map *map);
>  struct maps *map__kmaps(struct map *map);
>
> -/* ip -> dso rip */
> -u64 map__dso_map_ip(const struct map *map, u64 ip);
> -/* dso rip -> ip */
> -u64 map__dso_unmap_ip(const struct map *map, u64 ip);
> -/* Returns ip */
> -u64 identity__map_ip(const struct map *map __maybe_unused, u64 ip);
> -
>  static inline struct dso *map__dso(const struct map *map)
>  {
>         return RC_CHK_ACCESS(map)->dso;
>  }
>
> -static inline u64 map__map_ip(const struct map *map, u64 ip)
> -{
> -       return RC_CHK_ACCESS(map)->map_ip(map, ip);
> -}
> -
> -static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> -{
> -       return RC_CHK_ACCESS(map)->unmap_ip(map, ip);
> -}
> -
> -static inline void *map__map_ip_ptr(struct map *map)
> -{
> -       return RC_CHK_ACCESS(map)->map_ip;
> -}
> -
> -static inline void* map__unmap_ip_ptr(struct map *map)
> -{
> -       return RC_CHK_ACCESS(map)->unmap_ip;
> -}
> -
>  static inline u64 map__start(const struct map *map)
>  {
>         return RC_CHK_ACCESS(map)->start;
> @@ -123,6 +98,34 @@ static inline size_t map__size(const struct map *map)
>         return map__end(map) - map__start(map);
>  }
>
> +/* ip -> dso rip */
> +static inline u64 map__dso_map_ip(const struct map *map, u64 ip)
> +{
> +       return ip - map__start(map) + map__pgoff(map);
> +}
> +
> +/* dso rip -> ip */
> +static inline u64 map__dso_unmap_ip(const struct map *map, u64 ip)

I think it's better to use 'rip' consistently in the variable name
if possible.

Thanks,
Namhyung


> +{
> +       return ip + map__start(map) - map__pgoff(map);
> +}
> +
> +static inline u64 map__map_ip(const struct map *map, u64 ip)
> +{
> +       if ((RC_CHK_ACCESS(map)->mapping_type) =3D=3D MAPPING_TYPE__DSO)
> +               return map__dso_map_ip(map, ip);
> +       else
> +               return ip;
> +}
> +
> +static inline u64 map__unmap_ip(const struct map *map, u64 ip)
> +{
> +       if ((RC_CHK_ACCESS(map)->mapping_type) =3D=3D MAPPING_TYPE__DSO)
> +               return map__dso_unmap_ip(map, ip);
> +       else
> +               return ip;
> +}
> +
>  /* rip/ip <-> addr suitable for passing to `objdump --start-address=3D` =
*/
>  u64 map__rip_2objdump(struct map *map, u64 rip);
>
> @@ -294,13 +297,13 @@ static inline void map__set_dso(struct map *map, st=
ruct dso *dso)
>         RC_CHK_ACCESS(map)->dso =3D dso;
>  }
>
> -static inline void map__set_map_ip(struct map *map, u64 (*map_ip)(const =
struct map *map, u64 ip))
> +static inline void map__set_mapping_type(struct map *map, enum mapping_t=
ype type)
>  {
> -       RC_CHK_ACCESS(map)->map_ip =3D map_ip;
> +       RC_CHK_ACCESS(map)->mapping_type =3D type;
>  }
>
> -static inline void map__set_unmap_ip(struct map *map, u64 (*unmap_ip)(co=
nst struct map *map, u64 rip))
> +static inline enum mapping_type map__mapping_type(struct map *map)
>  {
> -       RC_CHK_ACCESS(map)->unmap_ip =3D unmap_ip;
> +       return RC_CHK_ACCESS(map)->mapping_type;
>  }
>  #endif /* __PERF_MAP_H */
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index 9e7eeaf616b8..4b934ed3bfd1 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1392,8 +1392,7 @@ static int dso__process_kernel_symbol(struct dso *d=
so, struct map *map,
>                         map__set_start(map, shdr->sh_addr + ref_reloc(kma=
p));
>                         map__set_end(map, map__start(map) + shdr->sh_size=
);
>                         map__set_pgoff(map, shdr->sh_offset);
> -                       map__set_map_ip(map, map__dso_map_ip);
> -                       map__set_unmap_ip(map, map__dso_unmap_ip);
> +                       map__set_mapping_type(map, MAPPING_TYPE__DSO);
>                         /* Ensure maps are correctly ordered */
>                         if (kmaps) {
>                                 int err;
> @@ -1455,8 +1454,7 @@ static int dso__process_kernel_symbol(struct dso *d=
so, struct map *map,
>                         map__set_end(curr_map, map__start(curr_map) + shd=
r->sh_size);
>                         map__set_pgoff(curr_map, shdr->sh_offset);
>                 } else {
> -                       map__set_map_ip(curr_map, identity__map_ip);
> -                       map__set_unmap_ip(curr_map, identity__map_ip);
> +                       map__set_mapping_type(curr_map, MAPPING_TYPE__IDE=
NTITY);
>                 }
>                 curr_dso->symtab_type =3D dso->symtab_type;
>                 if (maps__insert(kmaps, curr_map))
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 82cc74b9358e..314c0263bf3c 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -956,8 +956,7 @@ static int maps__split_kallsyms(struct maps *kmaps, s=
truct dso *dso, u64 delta,
>                                 return -1;
>                         }
>
> -                       map__set_map_ip(curr_map, identity__map_ip);
> -                       map__set_unmap_ip(curr_map, identity__map_ip);
> +                       map__set_mapping_type(curr_map, MAPPING_TYPE__IDE=
NTITY);
>                         if (maps__insert(kmaps, curr_map)) {
>                                 dso__put(ndso);
>                                 return -1;
> @@ -1475,8 +1474,7 @@ static int dso__load_kcore(struct dso *dso, struct =
map *map,
>                         map__set_start(map, map__start(new_map));
>                         map__set_end(map, map__end(new_map));
>                         map__set_pgoff(map, map__pgoff(new_map));
> -                       map__set_map_ip(map, map__map_ip_ptr(new_map));
> -                       map__set_unmap_ip(map, map__unmap_ip_ptr(new_map)=
);
> +                       map__set_mapping_type(map, map__mapping_type(new_=
map));
>                         /* Ensure maps are correctly ordered */
>                         map_ref =3D map__get(map);
>                         maps__remove(kmaps, map_ref);
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
