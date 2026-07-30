Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F983806C8
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 19:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785441394; cv=pass; b=sXSJILaVpa2itaRntz3cys8Shn3M41aaT4T+wX5xN3JKXKDckZbyNwcQz3eooU2wdRyx6DjsgK5Teaqq89CDG76b1enQqzxEK6qGlbYzW7ccPOBXzpZbUvZOkPZX2+dRC+m8HYfujPH70RCTxFAX04CR00tHbTF+OJQO+oteQKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785441394; c=relaxed/simple;
	bh=Fd1f99vygy+qd1Txs8X/LRlu3cQ5f0p0/unNHTb7UvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G4efPFYCZJ/yqJaHplu5KHxTH/3BbhqVpC08OBvp6f4Q0cz4cMcU7mfPR2SjaOSFUEgK7YTCUgJqFrZ9u54+rayWaa1gUGDSpgFN4ASa5jqaeIkzC1HyacWx1/8vmr23f3BOGf30eRbpJIcqrVnQ3bMI4xFdiIQ/M0jV7rxeuUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+zpmeNw; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+zpmeNw"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e27035206so349293b3a.3
        for <linux-perf-users@vger.kernel.org>; Thu, 30 Jul 2026 12:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785441392; cv=none;
        d=google.com; s=arc-20260327;
        b=Dn+PNgfMU4hP7pQTEmtCUbMWBvrkwfs7fp6D6T7kbyh5e6pWN/2eLfuutNYohHHoh4
         xvU0hAGe8zH3F2AW2RaBCzbMrTzqGD/v9TFNl6hGodK59WpRVtCsuE1FsCrZKbBh6wQ1
         TvZt6fCWwPL53x40vCbWAzu4P6+GjMYSWapUYeZn/EA6UupEcDtZRy0gEGNILX0oE8ln
         /ttdyYSjpIFAefl4BpM6E6dqWfWSjCpI3bkzZr6DJ7beiXHz+KGrPOP3EiBAnsz6pyBw
         hB3w6DpMbiefYLMMZrz58/oPI2mFFafrc+bzNqHTVqZ2wX6KyGgckLcCrsnBbbZrQeEz
         /Cpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qLJjqOKfhyu7g7JHPGSZLeYWicOZ0Mup3q40HiWWSR0=;
        fh=FiCn155hbwfGT6UzP09kdCUVNRxkXhZIRmG0IY21yQU=;
        b=qgmA9TrfI52Gf5nrCaWzNcgRI1eCVFwdtTRON2lW9oaKhsB04t/KKFUhdJJTIsu1V6
         afB0fPAP32xFU11PKRUn0S7aj7mBE1RL2GbAeylTKufFHaonBVn+JTclTgMzPU/3kmHM
         XuJRL4MQ1hkVhwoz6DPZDhmkqmPks0UtKtyaPT/u7hJPJgN0NoaFoSEWz2veTvA7lZca
         TzvLnkK9iAywlPBETrC5Kc4wrlp/La58NPPO29adjx9W2FN3Ib0IgnFIFHn9k+GyAHE8
         m3yL7LerTGR6xQnsdFoPTNOZlixRFgE7LF5fXIK2op2xkgJ06yKuHIZzWhVJTCLGPUoF
         4F8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785441392; x=1786046192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qLJjqOKfhyu7g7JHPGSZLeYWicOZ0Mup3q40HiWWSR0=;
        b=R+zpmeNwpb0tTZhPzKBk1xNQvVtRfZ7O4Hqk1zmHS6n1as4eig2rQQvlmIcKyMRXAo
         kXNGG/gvyVCavWDL72/E3cxXmdc9pBhAacrBHKCkiVDhvjFSsP3pk8OsZLrmh97Ltw8/
         iqGs1SO7W06O07AnWfV0lbEPD5YXeWRSQi0euaT8wh/19VIRigWN4EqQzu4KBcg70J1v
         GH5nMmqZj4WvjRqWkca649m4c5pkbdK/jnsCXvfALJ/CWt2hQrPU7yFE9BaWjSorhlJT
         dPJ0mMjsm4rzgpN3jooOTHGIf7DsCzNw/DrlYdnuO1On5g9cIQ79Uf3+HzObtqlf3Jyk
         VLQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785441392; x=1786046192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qLJjqOKfhyu7g7JHPGSZLeYWicOZ0Mup3q40HiWWSR0=;
        b=QD0KmUJG2zF2FoBh5BSqeoBmj3vR2F71byPtlJXJ9MBI/+7J1cRurlhl2yWplqoFWg
         cPvAdlXwMs3aa0UNogCTF0jtWIgbbE0hDVJTlsKHw6Nq4Jb4d2cRIYsfGlCFy6kOGjmH
         gWcmn+eMD+hOLBY5IV2x8sg8jhog15EKSsGQyFcaKE4x01G26BA+OeN7+vjGev5epEdg
         GQFvGlY3axilcJh/r6Jq+Zv77OinPnhldOo3RAdGez2yb/lblAVXQGKteBlrZufWQYMi
         M09tLmsphNSren4eK44PTpdVeW29nxcpZCPDRPDmsosPUzAmz8S4vZYnJQGmeOsp3qSk
         0l7w==
X-Forwarded-Encrypted: i=1; AHgh+RohF0mQ8vo5HP6DXaV6+yrUYvlZeF2YQA2EEvtIUEy8hkOpwLRsvZXzpFpIY4Ol2LaslJ65sk38qyT+wUwvK/DW@vger.kernel.org
X-Gm-Message-State: AOJu0Yze4bZ61xROVRNDZE1rsn1fUR57tzAJh3yU1Fsmn9DTnuRtWNci
	FzWg6muKmAVd3f9huNz8NEfQOQ6sp0bWsSPvHFki4F5UMhbZLNOj64fm0WMfEPAleVP07T+48vw
	59svKteH67BxzL9DUR1KfKvE2gJNDJQk=
X-Gm-Gg: AR+sD11NZB+2w4DYiPEYcloSY+W5TxFyLxVyal9u+C0piwIsDf2PoGbQ0xE6BOBuel6
	yHs7lL77U9L93ifa/2mK6VdWN5O6MZN/27ZU3/9lUXpHJuBQzc6jsX2YdEkaiy1RLTmqJDXAUtV
	nC2m41j6vpqGDzZbbeAnSsIMS7MAA2Yw7xG3PUxkVpFLaQz4kUo/DU1sXKWYPCMtlRclhBN/VJy
	zp4SOQ4diCxk/iB8EgcG3rgHqh6+07f03J8sA8ckO994KVpGzHrYXuG0P6LFgsTq48ZZgSe6axG
	ZI6jFOwBT7vDk3PNhpVaYULISir09a2/j/m63kQUpLEyEnFqF31Rbe1pNkBz3lM7yPu2mOAvnnk
	1ZRQWmZMgUyXFZPkzMVBP1F0dBE0VTuqNK+0Y0ActRw==
X-Received: by 2002:a05:6a00:928f:b0:847:904c:8452 with SMTP id
 d2e1a72fcca58-84ebc3cfb0cmr3687688b3a.38.1785441391979; Thu, 30 Jul 2026
 12:56:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616155716.2631508-1-puranjay@kernel.org> <20260616155716.2631508-3-puranjay@kernel.org>
In-Reply-To: <20260616155716.2631508-3-puranjay@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 30 Jul 2026 12:56:14 -0700
X-Gm-Features: AUfX_mypllbuQtwnAyQGtjj8wrW31i_okmt7jn4Zb1OXf9HqTBm6BS29OcrxDXw
Message-ID: <CAEf4BzYrwthXzMP-oyxfnFyFm+N0ZD_cEB8Sz7pYn97RMPgb7w@mail.gmail.com>
Subject: Re: [PATCH v5 2/4] perf/core: Clear the whole branch entry in perf_clear_branch_entry()
To: Puranjay Mohan <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, Puranjay Mohan <puranjay12@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Leo Yan <leo.yan@arm.com>, Rob Herring <robh@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	James Clark <james.clark@linaro.org>, Ian Rogers <irogers@google.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Shuah Khan <shuah@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Ravi Bangoria <ravi.bangoria@amd.com>, 
	Stephane Eranian <eranian@google.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Usama Arif <usama.arif@linux.dev>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 8:57=E2=80=AFAM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> perf_clear_branch_entry_bitfields() resets the bitfields of struct
> perf_branch_entry one at a time and deliberately leaves from/to alone,
> since callers overwrite those immediately. The list of assignments has to
> be kept in sync with the struct by hand, and it has already drifted:
> new_type and priv were added to perf_branch_entry but never cleared here,
> so stale values can leak into the records handed to userspace.
>
> Clear the entry with a single struct assignment instead:
>
>         *br =3D (struct perf_branch_entry){ };
>
> Every caller writes from/to right after the clear, so zeroing them as wel=
l
> is harmless and the dead stores are elided on the x86 LBR read paths.
> There is no longer anything to keep in sync when a field is added.
>
> The helper no longer touches only the bitfields, so rename it to
> perf_clear_branch_entry() and update the callers, fixing up the
> br+nr/br+out spacing on the touched lines while at it.
>
> Fixes: b190bc4ac9e6 ("perf: Extend branch type classification")
> Fixes: 5402d25aa571 ("perf: Capture branch privilege information")
> Suggested-by: James Clark <james.clark@linaro.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/x86/events/amd/brs.c   |  2 +-
>  arch/x86/events/amd/lbr.c   |  2 +-
>  arch/x86/events/intel/lbr.c |  6 +++---
>  drivers/perf/arm_brbe.c     |  2 +-
>  include/linux/perf_event.h  | 16 ++--------------
>  5 files changed, 8 insertions(+), 20 deletions(-)
>

Another one for tip/perf probably?... Puranjay, maybe send the first
two patches separately?


> diff --git a/arch/x86/events/amd/brs.c b/arch/x86/events/amd/brs.c
> index 06f35a6b58a5..68c5f42965e9 100644
> --- a/arch/x86/events/amd/brs.c
> +++ b/arch/x86/events/amd/brs.c
> @@ -343,7 +343,7 @@ void amd_brs_drain(void)
>
>                 rdmsrq(brs_from(brs_idx), from);
>
> -               perf_clear_branch_entry_bitfields(br+nr);
> +               perf_clear_branch_entry(br + nr);
>
>                 br[nr].from =3D from;
>                 br[nr].to   =3D to;
> diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
> index d24da377df77..08401fd60585 100644
> --- a/arch/x86/events/amd/lbr.c
> +++ b/arch/x86/events/amd/lbr.c
> @@ -181,7 +181,7 @@ void amd_pmu_lbr_read(void)
>                     entry.to.split.reserved)
>                         continue;
>
> -               perf_clear_branch_entry_bitfields(br + out);
> +               perf_clear_branch_entry(br + out);
>
>                 br[out].from    =3D sign_ext_branch_ip(entry.from.split.i=
p);
>                 br[out].to      =3D sign_ext_branch_ip(entry.to.split.ip)=
;
> diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> index 72f2adcda7c6..295da179fa74 100644
> --- a/arch/x86/events/intel/lbr.c
> +++ b/arch/x86/events/intel/lbr.c
> @@ -755,7 +755,7 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc=
)
>
>                 rdmsrq(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
>
> -               perf_clear_branch_entry_bitfields(br);
> +               perf_clear_branch_entry(br);
>
>                 br->from        =3D msr_lastbranch.from;
>                 br->to          =3D msr_lastbranch.to;
> @@ -846,7 +846,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc=
)
>                 if (abort && x86_pmu.lbr_double_abort && out > 0)
>                         out--;
>
> -               perf_clear_branch_entry_bitfields(br+out);
> +               perf_clear_branch_entry(br + out);
>                 br[out].from     =3D from;
>                 br[out].to       =3D to;
>                 br[out].mispred  =3D mis;
> @@ -920,7 +920,7 @@ static void intel_pmu_store_lbr(struct cpu_hw_events =
*cpuc,
>                 to =3D rdlbr_to(i, lbr);
>                 info =3D rdlbr_info(i, lbr);
>
> -               perf_clear_branch_entry_bitfields(e);
> +               perf_clear_branch_entry(e);
>
>                 e->from         =3D from;
>                 e->to           =3D to;
> diff --git a/drivers/perf/arm_brbe.c b/drivers/perf/arm_brbe.c
> index ba554e0c846c..effbdeacfcbb 100644
> --- a/drivers/perf/arm_brbe.c
> +++ b/drivers/perf/arm_brbe.c
> @@ -604,7 +604,7 @@ static bool perf_entry_from_brbe_regset(int index, st=
ruct perf_branch_entry *ent
>                 return false;
>
>         brbinf =3D bregs.brbinf;
> -       perf_clear_branch_entry_bitfields(entry);
> +       perf_clear_branch_entry(entry);
>         if (brbe_record_is_complete(brbinf)) {
>                 entry->from =3D bregs.brbsrc;
>                 entry->to =3D bregs.brbtgt;
> diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
> index 48d851fbd8ea..e034be4a473a 100644
> --- a/include/linux/perf_event.h
> +++ b/include/linux/perf_event.h
> @@ -1467,21 +1467,9 @@ static inline u32 perf_sample_data_size(struct per=
f_sample_data *data,
>         return size;
>  }
>
> -/*
> - * Clear all bitfields in the perf_branch_entry.
> - * The to and from fields are not cleared because they are
> - * systematically modified by caller.
> - */
> -static inline void perf_clear_branch_entry_bitfields(struct perf_branch_=
entry *br)
> +static inline void perf_clear_branch_entry(struct perf_branch_entry *br)
>  {
> -       br->mispred     =3D 0;
> -       br->predicted   =3D 0;
> -       br->in_tx       =3D 0;
> -       br->abort       =3D 0;
> -       br->cycles      =3D 0;
> -       br->type        =3D 0;
> -       br->spec        =3D PERF_BR_SPEC_NA;
> -       br->reserved    =3D 0;
> +       *br =3D (struct perf_branch_entry){ };
>  }
>
>  extern void perf_output_sample(struct perf_output_handle *handle,
> --
> 2.53.0-Meta
>
