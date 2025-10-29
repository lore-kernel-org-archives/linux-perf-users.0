Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCBC2848A8
	for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 16:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756433; cv=none; b=IwwYiSuwakghi/O6hrJoe7e+pu6iPrNwI4dLmRcSK2bt9cyAtcN2crkNlOF5EAXrY5hfeZbwgxGeIIcQ7D9fgJt8GGWnOAu/Hz9NFZB0HTBuWtSElhf9A5vDk8arX85CMvGbj5fG8QXA+ajG/3sq00AbMdWdYjUs1ix7G9XtKkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756433; c=relaxed/simple;
	bh=XeE2248l8L/72ygAF7Bexy+VhtYVq8rb4yDrxujTcOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PkQcxDWUsJKp4Im57S7AzZYyN2wF+TRk+TlG8DHOZPmKTYtjVDfxvEdN54zJ5JnsZxJ0yEyRg+CQ9mdhzGpYC9aFeobvmOuJDt5m/t48uTC3b3NttEbcJ1pki9eLHJB+nheNYE2FCcjPlGmtygsQH7YDERgLbWLdghmkiFJYo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4aDOFaYu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4aDOFaYu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-290d48e9f1fso1875ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 09:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761756431; x=1762361231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1S+2D3A1zxW1NR0S2yjc3Iwn47ykFEO8hoiIp/5Vd/4=;
        b=4aDOFaYu6IJcCtvEONhG7pJ4HvdDRM2mK7Nr8+NK0UBsMjsyk2pgDI6lXCCanLLOPs
         ohgsosYEW8ljSDV4K4Y53rRu77wXdED1h8zQeDc4FtJ9puABB/aQQ7ZK29dd73RPPCdM
         /be5CdHDNCN4Jvi+YEZS4LM+PiEIDqtq4f1VpDN+4mc++Kh1PqZokSYtvah9q2QGOOF2
         Rpf33epbE6dNjstKsFOaqPwevINtecCGmYhkH81pPsAJXYSXzCa3UWcbw/rggBmwXfwG
         0G/gz17nK4ap7HbTsII6b8w68UQjsSTRcKullct7pKMY/YK7FpjmNA/6+k4h/8Hzy7Fc
         3JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761756431; x=1762361231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1S+2D3A1zxW1NR0S2yjc3Iwn47ykFEO8hoiIp/5Vd/4=;
        b=jmd84krP+YJXnDHL1frby1FRP2UoU2EAJR7D9VQwkUcFoz/FoBPcLSikwMTtdqlds5
         4kRXYb3NUwvkNgwxsIUO3tiHiaw/1hp8S4nmvsmygddmRKajJn+8+RW5ZacYlrsZjn81
         Y0eQHVxXiI0UR/ZcuPeYNevOZwv0YKz43Jg1RYlTfZlvxR5FtUhbqLun2wItP4LndG8x
         6t/ZStw9/uheWHiKmxSzzq80IZm0HkRGpw4olKBLoyNqwmHt6VMlzXhaQ/ygGJYtcf2U
         pm8V1w87pTSKVJttk4pVYWcdXO1C/MDQL+8wYHQTYc2GiZTzBqVbQSX9X3v9gNJYakvf
         TCag==
X-Gm-Message-State: AOJu0YyWeznuq7stZRyEwIiLE+wZMBxRdIrrRPFG/SNQW+RQ7KvRqP5Y
	rtonwDcl0S9wl+IYSA/L+FvtK+9gCv2NMCSydDyl0Sjhu8ZL6XH4g1W74PK7Fw7YkJS23VIFswo
	jZxn54BigFDKFT1cCyxxiutL9Zn+H71DLX3Epg7q+
X-Gm-Gg: ASbGncum7QfjAQNsB7eYejfy0ZmPXx8B6pTKv4lHhjXUYOtwsrpsnk8jcGXN0mckr72
	m14YM4al7eRQByKQDOaQx4NNV514eIMCIb6M22dULp49B45qoV28IDxv4zIZnpIEM16bGiORZpZ
	e1KTY0bA+ZFrRLx6N53Vxuh6qTrCvUW83ybYU0eV4C4xunvHV6MotAm2tmplVJmEfqxMGF+JslY
	1gZiRSQ59ExGc8B9eSaJQuc6pfzCOurEyQih6Cc/14UG+LuacTn6NhgmZbFa7Pe42jvSRLi6LIU
	J7OEWlLW/alpAeaObYqG8QULAAMhY7rH99Uh
X-Google-Smtp-Source: AGHT+IHzCxhoMf6ohoA+266CSdltTcSDXJIxs8ks0UJy0hc1h+PYNIXZcA3hHH+ewCO4/aJ7hE9IYR/DGeZr5HeYugc=
X-Received: by 2002:a17:903:191:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-294de454d78mr6329145ad.6.1761756431154; Wed, 29 Oct 2025
 09:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <09943f4f-516c-4b93-877c-e4a64ed61d38@linux.ibm.com> <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
In-Reply-To: <79195870-7223-4aeb-beb4-a7d8f1895caa@linux.ibm.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 29 Oct 2025 09:47:00 -0700
X-Gm-Features: AWmQ_bnN8vW48kP-OiuRijfYMeimHwgzwVuOHpPkjR6Nx_WJuu5h2BPnHyjPnKU
Message-ID: <CAP-5=fXi=EDU7-tdNLwTKbCHR80_p3=TAe0qF0oE-tXbx35znw@mail.gmail.com>
Subject: Re: [linux-next] perf report runtime extremely long
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>, Jan Polensky <japo@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 9:12=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> On 10/29/25 09:03, Thomas Richter wrote:
> > Hi all,
> >
> > has something changed recently in perf report in linux-next repo?
> >
> > I run perf report -i <file> -D | grep something
> > on s390 with 2 different kernels:
> >
> > master 6.18.0rc3:
> > # uname -a
> > Linux a35lp67.lnxne.boe 6.18.0-rc3m-perf+ #23 SMP Tue Oct 28 15:53:44 C=
ET 2025 s390x GNU/Linux
> > # ll /tmp/perf2-eSso2q-2
> > -rw------- 1 root root 8538184 Oct 29 08:44 /tmp/perf2-eSso2q-2
> > # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/n=
ull
> >
> > real  0m22.262s
> > user  0m22.068s
> > sys   0m0.200s
> > #
> >
> > This runtime is ok for the perf.data file size.
> >
> > linux-next:
> > # uname -a
> > Linux s83lp47.lnxne.boe 6.18.0-20251028.rc3.git141.f7d2388eeec2.63.fc42=
.s390x+next #1 SMP Tue Oct 28 20:06:13 CET 2025 s390x GNU/Linux
> > #ll /tmp/perf2-eSso2q-2
> > -rw-------. 1 root root 8538184 Oct 29 08:47 /tmp/perf2-eSso2q-2
> > # time perf report -i/tmp/perf2-eSso2q-2 -D | grep Counter:000 > /dev/n=
ull
> >
> > real  2m53.601s
> > user  2m52.938s
> > sys   0m0.575s
> > #
> >
> > Same perf.data file and run time increased from 22 seconds to nearly 30=
0 seconds, roughly 14 times longer
> > for the same input!
> >
> > Has anybody similar observations?
> >
> > Thanks a lot
> >
>
> Ian,
>
> sorry sent button pushed too early...
>
> here is a second try without option -D.
>
> This is much better:
>
> root in =F0=9F=8C=90 s83lp47 in ~
> =E2=9D=AF ll perf1.data
> -rw-------. 1 root root 99692290 Oct 29 16:17 perf1.data
>
> root in =F0=9F=8C=90 s83lp47 in ~
> =E2=9D=AF time perf record -- perf report -i perf1.data  > /dev/null
> [ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 0.027 MB perf.data (246 samples) ]
>
> real    0m1.097s
> user    0m0.082s
> sys     0m0.167s
>
> root in =F0=9F=8C=90 s83lp47 in ~
> =E2=9D=AF perf report --stdio
> # To display the perf.data header info, please use --header/--header-only=
 options.
> #
> #
> # Total Lost Samples: 0
> #
> # Samples: 246  of event 'cpum_cf/cycles/P'
> # Event count (approx.): 307500000
> #
> # Overhead  Command  Shared Object        Symbol
> # ........  .......  ...................  ...............................=
...................
> #
>      9.35%  perf     perf                 [.] reader__read_event
>      4.47%  perf     perf                 [.] perf_env__arch
>      2.85%  perf     ld64.so.1            [.] _dl_relocate_object_no_relr=
o
>      2.44%  perf     ld64.so.1            [.] _dl_lookup_symbol_x
>      2.44%  perf     ld64.so.1            [.] do_lookup_x
>      2.44%  perf     perf                 [.] down_read
>      2.03%  perf     perf                 [.] hists__findnew_entry
>      2.03%  perf     perf                 [.] perf_hpp__is_dynamic_entry
>      1.63%  perf     [kernel.kallsyms]    [k] __s390_indirect_jump_r14
>      1.63%  perf     [kernel.kallsyms]    [k] format_decode
>      1.63%  perf     libc.so.6            [.] cfree@GLIBC_2.2
>      1.63%  perf     perf                 [.] evsel__parse_sample
>      1.63%  perf     perf                 [.] map__put
>      1.63%  perf     perf                 [.] sort__comm_cmp
>      1.63%  perf     perf                 [.] thread__put
>      1.22%  perf     [kernel.kallsyms]    [k] folio_add_file_rmap_ptes
>      1.22%  perf     [kernel.kallsyms]    [k] get_page_from_freelist
>      1.22%  perf     ld64.so.1            [.] _dl_name_match_p
>      1.22%  perf     perf                 [.] dump_printf
>      1.22%  perf     perf                 [.] evlist__event2evsel
>      1.22%  perf     perf                 [.] hashmap_find
>      1.22%  perf     perf                 [.] perf_session__deliver_event

Hmm.. for perf_env__arch we could probably cache better:
```
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index f1626d2032cd..2591f71c7c42 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -593,17 +593,27 @@ static const char *normalize_arch(char *arch)

const char *perf_env__arch(struct perf_env *env)
{
-       char *arch_name;
+       if (env && env->arch && env->arch_name_normalized)
+               return env->arch;

       if (!env || !env->arch) { /* Assume local operation */
               static struct utsname uts =3D { .machine[0] =3D '\0', };
               if (uts.machine[0] =3D=3D '\0' && uname(&uts) < 0)
                       return NULL;
-               arch_name =3D uts.machine;
-       } else
-               arch_name =3D env->arch;

-       return normalize_arch(arch_name);
+               if (!env)
+                       return normalize_arch(uts.machine);
+
+               env->arch =3D strdup(normalize_arch(uts.machine));
+               env->arch_name_normalized =3D true;
+       } else {
+               char *normalized =3D strdup(normalize_arch(env->arch));
+
+               free(env->arch);
+               env->arch =3D normalized;
+               env->arch_name_normalized =3D true;
+       }
+       return env->arch;
}

#if defined(HAVE_LIBTRACEEVENT)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 9977b85523a8..da20bc3810bd 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -61,6 +61,7 @@ struct perf_env {
       char                    *os_release;
       char                    *version;
       char                    *arch;
+       bool                    arch_name_normalized;
       int                     nr_cpus_online;
       int                     nr_cpus_avail;
       char                    *cpu_desc;
```
or just force the normalize before assignment.

For reader__read_event and the perf_env these changes may be relevant:
"perf sample: Remove arch notion of sample parsing"
https://lore.kernel.org/r/20250724163302.596743-21-irogers@google.com
"perf env: Remove global perf_env"
https://lore.kernel.org/r/20250724163302.596743-20-irogers@google.com

I wonder if for some reason the env is NULL in your cases, so we go
slow path a lot.

The histogram stuff, Namhyung may know more.

Thanks!
Ian

> --
> Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, German=
y
> --
> IBM Deutschland Research & Development GmbH
>
> Vorsitzender des Aufsichtsrats: Wolfgang Wendt
>
> Gesch=C3=A4ftsf=C3=BChrung: David Faller
>
> Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stut=
tgart, HRB 243294
>
