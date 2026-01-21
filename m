Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE61D314B7C
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769006018; cv=pass; b=tamTw+bTK+bXvAdde9QBIwyxFHyRZk/pGaHz+wygb2JbTFWTMeOKd8YF02qVO7iKtX3qdDWfESgb7Qnl9LZES32QZIQGMiBkw0Q0H5LTfbao6iE+P5vRfdAGg4U9iWYTseMO5bsJLBC4pVR7tf+kC0fyfKaeltRLaVSBlNan1Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769006018; c=relaxed/simple;
	bh=uGGspcjrb7XbbCwLPvSTRo13YwY+eRnoPea8t9tIBC4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YfvJRkU7swzsmC5nLsqwEUnVgjx9q72U6xPFcrn81eZQpzceHTVcuAjicjZszdc49sKEI/PRg2mnDVWHmRMlGdeFInIFsKf0noKL2SBfY7YKM2FzOgX/xW7rtSPUlVnXJ5YP/0WEe6sWAiH2EUixDHruPwUwRn4W6KdOPEcX+FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCtwccw8; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCtwccw8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a0d06cfa93so76605ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 06:33:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769006016; cv=none;
        d=google.com; s=arc-20240605;
        b=XE7W22EY7mXE0Z+VTdQgrDda1CEooc5sfOXrtMs43bUDHnlEI5lPHltjisEq3guvx7
         q5OFblu1Qje6Qozs3w8WoV9fM3AgJD/zNOr9hiyYcvAGCWmNxKANweH2vrrG08eILeZH
         7iCoKABqEp1B726AZWUiJI3clBVDCqIPd/l46069lgDn3wpKhrP3e5Bj/8mMGYMDVjRi
         +P6P16DwX1JozUqRBpfcSZSyPUB9M0oSeIs6hgrZcIKFGkHjpCTrwbKAeNMbp3pqQuhl
         l79ZISNKcgZIvnvZHL6Qh0nAR/5mPxE8v5JcTzQMshYnuYy6iW/NqZeg3MiWsQbH7G+f
         rbAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KaGz+J679+mbK9SlRqosKys0qvTEgLpPl68CBIgPizs=;
        fh=7IR5ONcFKqVbA5D9VCKKhFYzEyO+cuT1+MVtCpEUzQ4=;
        b=LoV6POfroGUN33rUSnap1Q2GxuAsazmpE6tQTVBaAH9xdObMf1GwAtK7G8nfD6hW8V
         Axw9Rt4BPUvwvcmDxRS2nTZLZlann6fkaaGcp0OwZexZE5WPiigncMmKnYpqKAM5DHd4
         HiVMJT4HszjVK4XgXVG0MulvkdHeIyZr39U3OSV0onFoJvDob2bejAVnjUnFTh9JR58a
         5KvZ/VdzzTN3NJ+h2e8okzYF7ed9hFI2ZHqndnw7abD+nnBHCySUoWU9FAf6Te3430j2
         Yg+W2iZ3PBXmK8MO6mp+tBkgRPJEAxUlw2dS464coFdG4O3aMbdnutmE9KATaqVTJ8oW
         goqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769006016; x=1769610816; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaGz+J679+mbK9SlRqosKys0qvTEgLpPl68CBIgPizs=;
        b=wCtwccw8mn99h9nHuIu/6hxjHaynYH9Y605Z44Yq0HdbniPhd59iYAZPap/d8vwL+8
         iDD3qE+/QhWo8o0afPBLG5cBMblNNHFRR8qQDm3HxFRBAB56Wv1j4XCa4ChPE0b4aJcl
         mYTN+OS6onALG40c82b1XbuQb1jibRvaFd69QBjHoFhuZhmRgldfVsGdUfS/iJP9ZKRS
         NDZ5PJ9GdhE/c1crgDbus9lGedPeV2o4DudBN9fPx6ouJxlB2bfjuOr+gzYEIanZhaJj
         fK4kTjy7weEnYyME8GKzotlogXtVqUIHc7Mj9YlWKt9Mj7ucryOe7cVkgVx23P26Wkep
         Rx7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769006016; x=1769610816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaGz+J679+mbK9SlRqosKys0qvTEgLpPl68CBIgPizs=;
        b=TcUYJhsBe4DA9GfvW/oH1nKZBg+E0r/XQZLgSdEFfdnDzIODyRUsbkqaUGVyq6w1lx
         rvUuXu2391KClp0Arcr73Tyn9KLX8DvwUfELB8MDxRB97/b86/IEqyRTjq4VRgkw8rNl
         m4R4gY3BqirQo006fsO6hd42NOzgqPgOv9FcvK1hWRs0TVGjoO6Af1K608LOxBi8YQ2O
         NdF4tRaFZw22ySryiuLCuL66CgQUuqejMaBcl+NO/JDwdjhjzq5lA7EKwl0726i0LM/l
         Jo5Ih77/dJgFIAqz5bg1YT5Xq6+35rUhPpiw88uMhWumojROI4m3LaKCpT5P2npr30Kg
         pPeg==
X-Forwarded-Encrypted: i=1; AJvYcCWZZHZ/3BUUVYrvqlq/LAzYTuNt5hyZ34amsxFEUdlpp/SJYt8lPBJH7wKIicmqr6Dab9UEyz6n5MyfbQbJLTDv@vger.kernel.org
X-Gm-Message-State: AOJu0YwGUaai2KhH+JO2iorvBiErV0R4jjzLB84aksnE741IUYDCEEGE
	2xb662BvKI0vfLRNg2cRnV4o6FpsemPyJyUgyvHdnqrAAJGh4oVqnkIdz/OzYW0gv4bmIF2XduN
	iKowcmi+ZWW8yMkYrSwWG4fH1VihIADdFrrHs8FNv
X-Gm-Gg: AZuq6aJUih+IJe2wUFeW/0N8aaX8Lh4t3DWCWEAiG18i+J6oZcW7EGlP2aQnUux1rx0
	Eq1uruR0U4pBd2zOJal3j7UXRzxlkoM+nfGDEH0mP7KVnTO5BrmP3VZmZmlv9Q3I05QmTYwy1r+
	C9g0Z0+RGgd1jxJixwvQ46yGY3UKO5QnVGgMdQnmCXtMrptzTgBptUpxGPwoizes6uYDnCScSmo
	BvNAnf0GZx8D4aYU2x7vt9ZvU0exyuCUrVMer6fR6DXaIuS4+VNm0SGU/qU4FKl9WZM8s6T/SdI
	/z8dcqk=
X-Received: by 2002:a17:902:ccca:b0:2a0:7fac:c031 with SMTP id
 d9443c01a7336-2a79a616ae8mr3451965ad.14.1769006015612; Wed, 21 Jan 2026
 06:33:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231224233.113839-1-zide.chen@intel.com> <20251231224233.113839-12-zide.chen@intel.com>
 <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com> <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com>
In-Reply-To: <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 06:33:22 -0800
X-Gm-Features: AZwV_QhIdrFtwUb-NvpLgYWuhWB3KK_I6D8AS62nn5cHXQTqw5nKmPn-SaQylro
Message-ID: <CAP-5=fXnMgwoa=VF2oK6D_rXvEOLCyq2PHkXoyN42KOgaWBTgQ@mail.gmail.com>
Subject: Re: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to
 allow numeric suffix
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Xudong Hao <xudong.hao@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 12:02=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 1/21/2026 3:18 PM, Ian Rogers wrote:
> > On Wed, Dec 31, 2025 at 2:49=E2=80=AFPM Zide Chen <zide.chen@intel.com>=
 wrote:
> >> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> >> "uncore_pcie4_*" and "uncore_pcie6_*".
> >>
> >> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can mat=
ch
> >> and collect events from both PMU types, slightly relax the wildcard
> >> matching logic in perf_pmu__match_wildcard().
> >>
> >> This change allows a wildcard such as "pcie" to match PMU names that
> >> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
> >>
> >> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> > Can we not merge this. I'd missed a perf tool patch as it was hiding
> > in a bunch of kernel uncore updates. At the very least if wildcard
> > conventions are updated then the corresponding documentation needs
> > updating:
> > Documentation/ABI/testing/sysfs-bus-event_source-devices
>
> Ian, thanks for the information. We didn't notice there is such
> documentation to describe the name. :(
>
> Besides the documentation, are there other comments? We can update it
> together. Thanks.

The suffix handling is notoriously brittle. For example, ARM added hex
suffixes which are generally 12 characters of physical address rather
than the typical _0, _1, etc. What could go wrong? Well in some
situations ARM make their core PMU's follow the model name, so rather
than armv8_pmuv3_0 the core pmu is a name that ends with a model
number something like _a76, however, that is also a valid hex suffix.
So we have bumped the hex suffix to be at least 2 characters:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmus.c?h=3Dtmp.perf-tools-next#n81
This also works around the naming of s390 PMUs (comments in the code).
ARM now have models like a720ae which would appear as a 5 character
hex suffix, and so this whole hex suffix thing is hanging together for
some part because we treat core and uncore PMUs differently. From my
pov, ideally the ARM uncore PMUs would have just used the _0, _1, etc.
naming convention and placed the physical address information into a
caps file, rather than trying to shoehorn it into the PMU name.
s390 pmu names have discrepancies that mean lots of their core PMUs
can match suffixes and Intel's i915 PMU name ("i915") will happily
match as just "i" as the underscore before the number is optional. A
change like this needs a range of testing on a variety of
architectures because the code has broken things in a lot of different
architecture types.

Besides a lack of testing, going in through the wrong tree, the change
is changing suffix handling in one place but not all - at least
pmu_name_len_no_suffix wasn't updated. Let's get this out of the tree
and start again.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >> ---
> >>  tools/perf/util/pmu.c | 14 ++++++++------
> >>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >> index 956ea273c2c7..01a21b6aa031 100644
> >> --- a/tools/perf/util/pmu.c
> >> +++ b/tools/perf/util/pmu.c
> >> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char *p=
mu_name, const char *tok)
> >>  {
> >>         const char *p, *suffix;
> >>         bool has_hex =3D false;
> >> +       bool has_underscore =3D false;
> >>         size_t tok_len =3D strlen(tok);
> >>
> >>         /* Check start of pmu_name for equality. */
> >> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const char =
*pmu_name, const char *tok)
> >>         if (*p =3D=3D 0)
> >>                 return true;
> >>
> >> -       if (*p =3D=3D '_') {
> >> -               ++p;
> >> -               ++suffix;
> >> -       }
> >> -
> >> -       /* Ensure we end in a number */
> >> +       /* Ensure we end in a number or a mix of number and "_". */
> >>         while (1) {
> >> +               if (!has_underscore && (*p =3D=3D '_')) {
> >> +                       has_underscore =3D true;
> >> +                       ++p;
> >> +                       ++suffix;
> >> +               }
> >> +
> >>                 if (!isxdigit(*p))
> >>                         return false;
> >>                 if (!has_hex)
> >> --
> >> 2.52.0
> >>
