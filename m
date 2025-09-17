Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BF302CB9
	for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 21:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758143582; cv=none; b=Nw7x9LYeIBaZjkhtMDCsp2pZgIKrybhSi/iVdGoRPdfPdpbdvkB+laiKzCZXa55n582qlC5pUyryXiMYZQCJmnZwaNfgIluwfm1mkgI2a0cqhrxlF1sbXkymrzyqfRdSpZsq5tDZiyDSkhyxBurLcIuS/1iHdtSFYl7N6uyrog4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758143582; c=relaxed/simple;
	bh=0NV118m/ucNL4hGNaRGYd0PW446G/5kdWpVvTpty/8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBdmzvm1hrWjsph2g1NDembA4Bedw41pJzSv2Kbj+v4fkgDB5rB+VDzOqGPiGLj5SajFRiWEBJc/uzGDJzOk91+Z3ITGGZWoM1HuJVyNM17HOO3hPoLFZL4JlOMI9PAGqVqaQ536SEgfQP3GgiU8cLn+t+WeBJOVEAlECZvYU7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SHyNOYHM; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHyNOYHM"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-265abad93bfso54355ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 17 Sep 2025 14:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758143580; x=1758748380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mfu99aaPsl7lO5kkVqQHKSVhMr/04dLqdSGEmEMpZPY=;
        b=SHyNOYHMHz2VNQt2xYBqBSWdZDqJVJ4apMi/ElR1tZtCab+9nPnsUrD2IKJ/6SE5QS
         1PTG3bW803vhg/nhNUI/9dc2quWVTuZKAVveBxchMS2YIK/FHs5o5BK9OwWeqnpxLoaM
         xORiAdPlkJRCvbJ9TPjy4MyUaIECh0jj66ZzA8OzWNF7t6PI9rY95rY2fuSut7YShVVC
         H3BDW7CdGZkbWaPJxyAbYLAT9z22+kA7sekcZC9sSWe07Y3LcYrqLWZYUcJzAYt4lsrd
         pVg2RfBNCqmz8xWl4lb39GUfcA+vZS9E0GMxvH1FbMPA5xcry2iB37Nt/v9sVVNiloXk
         sxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758143580; x=1758748380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mfu99aaPsl7lO5kkVqQHKSVhMr/04dLqdSGEmEMpZPY=;
        b=SFEZ9VTyU20yQoxK+fk9J5YGlsgRJBjVIF858s17P0SPkcFBLwsqC5hd2lM1YMbfx5
         0SWyjaHnIncBLZDZLi09rlx012XYYQeytKiv9Ibo4t9uJIXxZSq5XZ5S/nqCKDdTshFn
         HS0Dw0vEe13+5GwPS+cJQ+70jJNhGOf0oTWw1wIOf6Q6PidGO2q70Uf4e2kTsCaHojtq
         32mZuvPaSMXDA/Jj/3XpEVgsHcs5NkAtGOptX/xRe01Ptuy1bkMvYqOfZThLHFCggYD/
         DI2OAFFl7Zxn2zYOYroxrwclXMpph1DT1MeneVPHqMAB/ozXkwqLBu/oI2giWkuriOfk
         6cqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ0ZpwP41LbCQTC0hc39TN5emWu+mKU5E6RA7GlI8okRUUrlUVb/B/P8zlyF1wLakkp/DR2aWTB+SaEg34hcOt@vger.kernel.org
X-Gm-Message-State: AOJu0YzQTSJi58jpSnsNxWjjr/hQIOAdwro4R4lzDVrkgVI3adtvG8dB
	5RbLImQFsvfwAm98Sfu7o5tDxJyk8Ndl03nTvj1AJW9EA/L+bF+f+dU24o3WjktnHdGfvsEzAIm
	xHsxX769eYqha0Ur+E+YIccS3R/nzhZZL8LFgbNWu
X-Gm-Gg: ASbGncv6b9dI0IQqtfo/nDKimzjeD13H7bLbgxUdXGUb9jYoWCbwiVzY6/e4ybQwJKN
	xTtJaUSEkwofJwoTltHjud/oUALtPXlWULiaOs9bdJPicVPZkre1pq31XAzA6kCXZxSrb9REBql
	gWQx6TxSdveShNvjOgWnkIv0f0Ng5N6nzNLkkOv2sNfXmEejOA0jsjhF29XLnwMIoDTpixikxlY
	snqqzrhSJCOY0kBoKvM0FM6+LPliOnfZ9wLsFrBCLy3w9jnIi+kgv8r/Edzlg==
X-Google-Smtp-Source: AGHT+IGq0upiJh6JIgG1mEsxqUx8fQkSIiit6VnVAuHy0r/3lp3ren6BfVxVF/psZ+KwlIgBfaGdVXzFKRWJd3gGiLw=
X-Received: by 2002:a17:902:ea06:b0:265:cb5f:3a66 with SMTP id
 d9443c01a7336-26808aeb835mr6924825ad.13.1758143579562; Wed, 17 Sep 2025
 14:12:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
In-Reply-To: <20250811055546.296678-1-dapeng1.mi@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 17 Sep 2025 14:12:48 -0700
X-Gm-Features: AS18NWByQXui-cbq7Hni-JA9LsBVy0lAL2uPym6h4MIqguq_9wEQJ0SNhl04WP8
Message-ID: <CAP-5=fWcf7F1QvWXzAD_KMpOnnKGw9PFM7mNtgzp_jh4Vi6V-w@mail.gmail.com>
Subject: Re: [Patch v2 0/6] Perf kvm commands bug fix
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Kevin Tian <kevin.tian@intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 10:56=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.=
com> wrote:
>
> his patch-set fixes perf kvm commands issues, like missed memory
> allocation check/free, out of range memory access and especially the
> issue that fails to sample guest with "perf kvm record/top" commands on
> Intel platforms.
>
> The commit 634d36f82517 ("perf record: Just use "cycles:P" as the
>  default event") changes to use PEBS event to do sampling by default
> including guest sampling. This breaks host to sample guest with commands
> "perf kvm record/top" on Intel platforms.

Huh? That change is:
```
$ git show 634d36f82517
commit 634d36f82517eb5c6a9b9ec7fe3ba19dbbcb7809
Author: Namhyung Kim <namhyung@kernel.org>
Date:   Tue Oct 15 23:23:58 2024 -0700

    perf record: Just use "cycles:P" as the default event

    The fallback logic can add ":u" modifier if needed.
...
-               bool can_profile_kernel =3D perf_event_paranoid_check(1);
-
-               err =3D parse_event(rec->evlist, can_profile_kernel ?
"cycles:P" : "cycles:Pu");
+               err =3D parse_event(rec->evlist, "cycles:P");
...
```
isn't the precision the same before and after? I think you've blamed
the wrong patch.

The change to use cycles:P looks to come from commit 7b100989b4f6
("perf evlist: Remove __evlist__add_default") but the old code was
doing things like "evsel->precise_max =3D true;" so I think I was just
carrying forward behavior. The use of precise_max comes from commit
4e8a5c155137 ("perf evsel: Fix max perf_event_attr.precise_ip
detection") from over 6 years ago, and the behavior before that also
appears to have been to use the maximum supported precision.

Apart from the blame and commit message being off I think the change
is okay, delta my usual complaint that weak symbols are the devil's
work.

Thanks,
Ian

> Since the change "KVM: x86/pmu: Add basic support to enable guest PEBS
>  via DS"[1] starts, host loses the capability to sample guest with PEBS
> since all PEBS related MSRs are switched to guest value after vm-entry,
> like IA32_DS_AREA MSR is switched to guest GVA at vm-entry. This leads
> to PEBS events can't be used to sample guest by host, otherwise no guest
> PEBS records can be really sampled. The patches 5-6/6 fix this issue by
> using "cycles" event instead of PEBS event "cycles:P" to sample guest on
> Intel platforms.
>
> Changes:
>   v1 -> v2:
>   * Free memory allocated by strdup().
>   * Check "--pfm-events" in kvm_add_default_arch_event() as well.
>   * Opportunistically fix the missed memory allocation and free issue in
>     builtin-kwork.
>   * Comments refine.
>
>
> Tests:
>   * Run command "perf kvm record -a && perf kvm report" and "perf kvm
>     top" on Intel Sapphire Rapids platform, guest records can be
>     captured successfully.
>   * Since no powerpc platforms on hand, doesn't check the patches on
>     powerpc. Any test on powerpc is appreciated.
>
> Ref:
>   [1] https://lore.kernel.org/all/20220411101946.20262-1-likexu@tencent.c=
om/
>
>
> Dapeng Mi (6):
>   perf tools kvm: Add missed memory allocation check and free
>   perf tools kwork: Add missed memory allocation check and free
>   perf tools kvm: Fix the potential out of range memory access issue
>   perf tools: Add helper x86__is_intel_cpu()
>   perf tools kvm: Use "cycles" to sample guest for "kvm record" on Intel
>   perf tools kvm: Use "cycles" to sample guest for "kvm top" on Intel
>
>  tools/perf/arch/x86/util/kvm-stat.c |  51 +++++++++++
>  tools/perf/builtin-kvm.c            | 130 ++++++++++++++++++++--------
>  tools/perf/builtin-kwork.c          |  27 ++++--
>  tools/perf/util/env.c               |  22 +++++
>  tools/perf/util/env.h               |   2 +
>  tools/perf/util/kvm-stat.h          |  10 +++
>  6 files changed, 203 insertions(+), 39 deletions(-)
>
>
> base-commit: 6235ce77749f45cac27f630337e2fdf04e8a6c73
> --
> 2.34.1
>
