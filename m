Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142C526AEC
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 18:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330394; cv=none; b=oLLQ0lRt6wlznGuY+KifNBiBecmRgOOIMpMtmSkBsBTM23xUK45GZKp3pQF0X+Bv0We3XRG2h0WqAcOshVw03JZTIcipTKjGravUyk4UlFujY4aM7oXBZH3OnAjcgyzVVPwdafyz2ACV/EbUI5TGUve121q2rHUnN1T2ca5JdqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330394; c=relaxed/simple;
	bh=/xXYT/dLZvs79m30ucc/SA6mjHSB6UGSKFkcpqjvd78=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/uNlSwE9e/xNnT9tBktOsMb/2gM9nBeaj2MrUcbBpn5HUfCNf+issNFsucEX5TP0KlsHIVE7lW9s0roaoK3xynryqH2mxVKiHkuelxGNQi4LQvtIWPg+SPPxpm+n2qz0GsEXzp3AVxpMM3HSQ7mYpEDrTn1Y6OhUCono2VOlM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dRMtWeTm; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dRMtWeTm"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27eeafd4882so27545ad.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Oct 2025 11:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761330392; x=1761935192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6URo0RHCzgXmccx7rlNSvSKMolAOCwrmZ6PQotsL+68=;
        b=dRMtWeTmLea/xzT1JlBg9Oy6uMQf8onbFF0V4XYRy36iXggpnDse/XjfH9Csx0fnLd
         SmpsJF4wFp2NqCu5yJNvIkELvptDDFytA+6vt9dn5tilB2Xn+JE2WkJAHOJTuFv4T0L7
         F7yG7/O+bvdQcjRlEhF3mdWl4M92zeWb0ssxdYWmwSa6NO9ri2XDKLKHIiJBPs5k47Zl
         R/GWP52b6J46ki6/OM5MAPffiQ5CyhldVvVRPeg0Rws6jKUZSloQDunkeBehDYhmGkTu
         0uBTO4rRwSVmVNvP7F6UuP0O7gHtsqXk7aHW+hm9JUu3ZopYfj+aEHezzefhtQ6VcDNR
         EJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330392; x=1761935192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6URo0RHCzgXmccx7rlNSvSKMolAOCwrmZ6PQotsL+68=;
        b=GlnA8KbZ40OLaZbVoJvdz+la63te+ZqiPPhihSrr0DW0AIh21+bGsWW83n0Yl0Gkrc
         nhExEPAtQg3/48xWhTsjq243W16lYURVjo4EEyz/7Z7e5NS5GpK7fF8/Y9QWkOW2u8DI
         zlqvvQAiysK1CbzVTSD3sNOdSkjyYacuOjf/er9cNdYc064arfDWyJjisp8jfgj7fr5T
         kdt7XCcTIKlvDpBIJWErgYWbVcQdKFcjXmIZ3ajkwzLlMboQjRWN1oSQfYm4RGaQY5W+
         S1nXpHCOnKsos6mEioC7TPB/PRS8qa0vFfuES7gLUGF7k/pKHb0yfcd521aroA53zZeJ
         k+kg==
X-Forwarded-Encrypted: i=1; AJvYcCV+0PZ5eH8dW2yzkEYLlyb5NwhHouFi08K26HAZHUUtOMZoTJ4iG/rmfS8DEseKwymflURD2cPasdycUZKQEXCn@vger.kernel.org
X-Gm-Message-State: AOJu0YzAqZ0aDnW0rDuLvKctSYGj5v1Xzh+d8s4Y1D45l6hsLYV6DLwN
	xfSnZdtwTgZn+km0VVaf4SShT4RVHDzNFrE6sxlpSITbct7V7IXG9cO24arNAqog0KOoYSu4M2M
	CrmPodXF2nBiJVnM43JcQu1uHBkkI3S0ke9BrxZM8
X-Gm-Gg: ASbGnctKa2GUDxvgPESNHSjheAwirqYMg7E3eDo21XID4Y7D5Rmei3RjO7s5GDnUp53
	RsFj7p6hmg0EiDraE9PD129hzrnHaoWB0UaK5cqe/7Uwo+iGBJulQlTjUpRd84WL9WRqBbn+0jl
	qtiyNXqwiTDDHZeKk92uKB0O9Y4Ec1K7JswC4K0jXmR3dmC4Ko20Cql4OMWulWZkLqaTHVqT6Ui
	vkSru9ulylS/RzK2tADyySAfSYReqOhMX+o8OFLbSVtlMgTFcVxKgm9eKM1lrHppXTBJq6ijm1p
	zbUPPx5uxVv6s7EgIFK7wsKl
X-Google-Smtp-Source: AGHT+IE/R1MWUMoRED9m8KDFeIvwsQdy8ET29v31C+Q9bortUC4rMaEW0+tjaZB8YlaiwfwGZSQhF9utyG5KG6THwWQ=
X-Received: by 2002:a17:902:f605:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-29497c0c9d2mr351855ad.7.1761330391641; Fri, 24 Oct 2025
 11:26:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
In-Reply-To: <20251022-james-perf-fix-dso-block-v1-1-c4faab150546@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 24 Oct 2025 11:26:18 -0700
X-Gm-Features: AS18NWDqeMJm0qdg4y_7XXPpGJ0ljpcenxt2e3n92QfttyvGjhVX5ObkesE21ZY
Message-ID: <CAP-5=fUF8C=yFkPb_ohJVzX01PvS5n++yZZifWSV-4sMNKZAZA@mail.gmail.com>
Subject: Re: [PATCH] perf dsos: Don't block when reading build IDs
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 8:46=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> The following command will hang consistently when the GPU is being used
> due to non regular files (e.g. /dev/dri/renderD129, /dev/dri/card2)
> being opened to read build IDs:
>
>  $ perf record -asdg -e cpu-clock -- true
>
> Change to non blocking reads to avoid the hang here:
>
>   #0  __libc_pread64 (offset=3D<optimised out>, count=3D0, buf=3D0x7fffff=
ffa4a0, fd=3D237) at ../sysdeps/unix/sysv/linux/pread64.c:25
>   #1  __libc_pread64 (fd=3D237, buf=3D0x7fffffffa4a0, count=3D0, offset=
=3D0) at ../sysdeps/unix/sysv/linux/pread64.c:23
>   #2  ?? () from /lib/x86_64-linux-gnu/libelf.so.1
>   #3  read_build_id (filename=3D0x5555562df333 "/dev/dri/card2", bid=3D0x=
7fffffffb680, block=3Dtrue) at util/symbol-elf.c:880
>   #4  filename__read_build_id (filename=3D0x5555562df333 "/dev/dri/card2"=
, bid=3D0x7fffffffb680, block=3Dtrue) at util/symbol-elf.c:924
>   #5  dsos__read_build_ids_cb (dso=3D0x5555562df1d0, data=3D0x7fffffffb75=
0) at util/dsos.c:84
>   #6  __dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e7030 <d=
sos__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:59
>   #7  dsos__for_each_dso (dsos=3D0x55555623de68, cb=3D0x5555557e7030 <dso=
s__read_build_ids_cb>, data=3D0x7fffffffb750) at util/dsos.c:503
>   #8  dsos__read_build_ids (dsos=3D0x55555623de68, with_hits=3Dtrue) at u=
til/dsos.c:107
>   #9  machine__read_build_ids (machine=3D0x55555623da58, with_hits=3Dtrue=
) at util/build-id.c:950
>   #10 perf_session__read_build_ids (session=3D0x55555623d840, with_hits=
=3Dtrue) at util/build-id.c:956
>   #11 write_build_id (ff=3D0x7fffffffb958, evlist=3D0x5555562323d0) at ut=
il/header.c:327
>   #12 do_write_feat (ff=3D0x7fffffffb958, type=3D2, p=3D0x7fffffffb950, e=
vlist=3D0x5555562323d0, fc=3D0x0) at util/header.c:3588
>   #13 perf_header__adds_write (header=3D0x55555623d840, evlist=3D0x555556=
2323d0, fd=3D3, fc=3D0x0) at util/header.c:3632
>   #14 perf_session__do_write_header (session=3D0x55555623d840, evlist=3D0=
x5555562323d0, fd=3D3, at_exit=3Dtrue, fc=3D0x0, write_attrs_after_data=3Df=
alse) at util/header.c:3756
>   #15 perf_session__write_header (session=3D0x55555623d840, evlist=3D0x55=
55562323d0, fd=3D3, at_exit=3Dtrue) at util/header.c:3796
>   #16 record__finish_output (rec=3D0x5555561838d8 <record>) at builtin-re=
cord.c:1899
>   #17 __cmd_record (rec=3D0x5555561838d8 <record>, argc=3D2, argv=3D0x7ff=
fffffe320) at builtin-record.c:2967
>   #18 cmd_record (argc=3D2, argv=3D0x7fffffffe320) at builtin-record.c:44=
53
>   #19 run_builtin (p=3D0x55555618cbb0 <commands+288>, argc=3D9, argv=3D0x=
7fffffffe320) at perf.c:349
>   #20 handle_internal_command (argc=3D9, argv=3D0x7fffffffe320) at perf.c=
:401
>   #21 run_argv (argcp=3D0x7fffffffe16c, argv=3D0x7fffffffe160) at perf.c:=
445
>   #22 main (argc=3D9, argv=3D0x7fffffffe320) at perf.c:553
>
> Fixes: 53b00ff358dc ("perf record: Make --buildid-mmap the default")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> I'm not actually sure if this is the right fix for this. Commit
> 2c369d91d093 ("perf symbol: Add blocking argument to
> filename__read_build_id") which added the blocking argument says that it
> should be non-blocking reads for event synthesis, but the callstack here
> is when writing the header out.
>
> There was also an is_regular_file() check added in commit c21986d33d6b
> ("perf unwind-libdw: skip non-regular files"), which presumably falls
> afoul of the "which unfortunately fails for symlinks" part of the other
> linked commit message?
>
> So I can't tell if we should add the is_regular_file() check here too,
> or just set it to non-blocking, or it needs some extra state to be
> passed all the way down to dsos__read_build_ids_cb() to do different
> things.

The fix lgtm but I worry about making all the build ID reading
non-blocking meaning build IDs getting lost. It seems that generating
the build ID feature table is unnecessary if we have build ID mmap
events, including synthesized ones that will have read the build IDs.
I wonder if a better "fix" is:
```
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cb52aea9607d..15f75c70eb76 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -1842,7 +1842,7 @@ static void record__init_features(struct record *rec)
       for (feat =3D HEADER_FIRST_FEATURE; feat < HEADER_LAST_FEATURE; feat=
++)
               perf_header__set_feat(&session->header, feat);

-       if (rec->no_buildid)
+       if (rec->no_buildid || rec->buildid_mmap)
               perf_header__clear_feat(&session->header, HEADER_BUILD_ID);

       if (!have_tracepoints(&rec->evlist->core.entries))
```
that should disable the build ID feature table generation when build
ID mmaps are in use (the default). Having the build IDs twice in the
data file feels redundant. Or we could do your fix or both, wdyt?

Thanks,
Ian

> ---
>  tools/perf/util/dsos.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 64c1d65b0149..5e1c815d7cb0 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -81,13 +81,14 @@ static int dsos__read_build_ids_cb(struct dso *dso, v=
oid *data)
>                 return 0;
>         }
>         nsinfo__mountns_enter(dso__nsinfo(dso), &nsc);
> -       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=3D=
*/true) > 0) {
> +       /* Don't block in case path isn't for a regular file. */
> +       if (filename__read_build_id(dso__long_name(dso), &bid, /*block=3D=
*/false) > 0) {
>                 dso__set_build_id(dso, &bid);
>                 args->have_build_id =3D true;
>         } else if (errno =3D=3D ENOENT && dso__nsinfo(dso)) {
>                 char *new_name =3D dso__filename_with_chroot(dso, dso__lo=
ng_name(dso));
>
> -               if (new_name && filename__read_build_id(new_name, &bid, /=
*block=3D*/true) > 0) {
> +               if (new_name && filename__read_build_id(new_name, &bid, /=
*block=3D*/false) > 0) {
>                         dso__set_build_id(dso, &bid);
>                         args->have_build_id =3D true;
>                 }
>
> ---
> base-commit: a1d8548c23076c66d96647f5f6f25aa43567f247
> change-id: 20251022-james-perf-fix-dso-block-ca1d8437bbc0
>
> Best regards,
> --
> James Clark <james.clark@linaro.org>
>
