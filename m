Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B39710E7;
	Mon,  4 Dec 2023 15:49:57 -0800 (PST)
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6ce5a0c384fso1068730b3a.1;
        Mon, 04 Dec 2023 15:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701733796; x=1702338596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRrhfsrD/bMKdqj5ETo8Mo1h2Igm/9o0AxAk0uXBBOw=;
        b=GiGriiPSW0/GA6JpJa/Fl/NDAw7y9mru03e3XBqGjBrr4sj0jsmQYSwl4ghfsz2U/+
         osXuTB6z5NWReOcexEIBi0Gz8MnWrS09P9Dw4YMEOJg1EhCWR7AORkyFW/XBm5AYIo5C
         zyFa4gdVYvrJnHSEzGcFnuyuwFHGsHG8O7JCVedx+ZJ5CzvXl8mgNyhhF/476eY8MW39
         z4Kiop4sQ5aIVrMMbdZYnw9quSCVrhglCL0hVahXPeSVAupztLjpjrizNa67LO1+qxSc
         6Rnoykr8HnwbEu2SKUa5Le7KQGaLAXmcYE2RireYmmnBqVTxc9Sr4hOGtImq5Ox7kloO
         j4Gw==
X-Gm-Message-State: AOJu0Ywx6Mhow/uy3srg74PSDAMEdAdaHmt33aXNPkC4fkgPDWvPRm71
	+wcoai9IuaMXetnya+fuiZRdnw7v2Duh5qzYgCc=
X-Google-Smtp-Source: AGHT+IEn+dfabIrnbTnJQVVa1L8bpZTxTRbjx3WnEZV/Fy81qMQfbYPEQZtuojPuqD7kr0pSbFISByzI8zgsDKkhptg=
X-Received: by 2002:a05:6a20:9f96:b0:18f:97c:ba1a with SMTP id
 mm22-20020a056a209f9600b0018f097cba1amr4697963pzb.116.1701733796435; Mon, 04
 Dec 2023 15:49:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231127220902.1315692-1-irogers@google.com> <20231127220902.1315692-17-irogers@google.com>
In-Reply-To: <20231127220902.1315692-17-irogers@google.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 4 Dec 2023 15:49:45 -0800
Message-ID: <CAM9d7cgj4Wj+0ZFQ3XfG12kkp4ThE4RT1+g=A1aSOinCXM9w+Q@mail.gmail.com>
Subject: Re: [PATCH v5 16/50] perf maps: Add remove maps function to remove a
 map based on callback
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

On Mon, Nov 27, 2023 at 2:10=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Removing maps wasn't being done under the write lock. Similar to
> maps__for_each_map, iterate the entries but in this case remove the
> entry based on the result of the callback. If an entry was removed
> then maps_by_name also needs updating, so add missed flush.
>
> In dso__load_kcore, the test of map to save would always be false with
> REFCNT_CHECKING because of a missing RC_CHK_ACCESS.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

A nitpick below,

> ---
[SNIP]
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index 72f03b875478..30da8a405d11 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -1239,13 +1239,23 @@ static int kcore_mapfn(u64 start, u64 len, u64 pg=
off, void *data)
>         return 0;
>  }
>
> +static bool remove_old_maps(struct map *map, void *data)
> +{
> +       const struct map *map_to_save =3D data;
> +
> +       /*
> +        * We need to preserve eBPF maps even if they are covered by kcor=
e,
> +        * because we need to access eBPF dso for source data.
> +        */
> +       return RC_CHK_ACCESS(map) !=3D RC_CHK_ACCESS(map_to_save) && !__m=
ap__is_bpf_prog(map);

RC_CHK_EQUAL(map, map_to_save) ?

Thanks,
Namhyung


> +}
> +
>  static int dso__load_kcore(struct dso *dso, struct map *map,
>                            const char *kallsyms_filename)
>  {
>         struct maps *kmaps =3D map__kmaps(map);
>         struct kcore_mapfn_data md;
>         struct map *replacement_map =3D NULL;
> -       struct map_rb_node *old_node, *next;
>         struct machine *machine;
>         bool is_64_bit;
>         int err, fd;
> @@ -1292,17 +1302,7 @@ static int dso__load_kcore(struct dso *dso, struct=
 map *map,
>         }
>
>         /* Remove old maps */
> -       maps__for_each_entry_safe(kmaps, old_node, next) {
> -               struct map *old_map =3D old_node->map;
> -
> -               /*
> -                * We need to preserve eBPF maps even if they are
> -                * covered by kcore, because we need to access
> -                * eBPF dso for source data.
> -                */
> -               if (old_map !=3D map && !__map__is_bpf_prog(old_map))
> -                       maps__remove(kmaps, old_map);
> -       }
> +       maps__remove_maps(kmaps, remove_old_maps, map);
>         machine->trampolines_mapped =3D false;
>
>         /* Find the kernel map using the '_stext' symbol */
> --
> 2.43.0.rc1.413.gea7ed67945-goog
>
