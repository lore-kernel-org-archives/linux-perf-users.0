Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CD4245005
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 18:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019589; cv=pass; b=u4IhasCWBrJyz1y+7OBhaAh+uavAi5L+3ux8Ps5SqQGc7Azsdqe/yC9IJJKzYPOAMTBhqG95Ky9hTkVaUsW8bo+GEy5+Fq7lsKGmstwsJ+jAMXLRFu2K57DxtwURz9pjb+jU2OjnoLMTWGJcBIhZpYwiIEO0Ojk50AaPHO89I7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019589; c=relaxed/simple;
	bh=6B4J7wL6ufTbOoH8LU2HERRCPptMK2oCbed3mT7BuKk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rCo3Ou+Lp+cSSGD6eMsAWImphAMfIFDQ4ta2Uj1O37kohXaKzVPcuQdofumRmP3z3DAThWB/xWfQRutST9BBJPOy0+9J2Q5MJxaw7FbW35loZKg9scsqHfAotz0gnnl2T/SeTImNm2Ank0z6z2SA2UzDUQ91X9s7dRyRUyUKVoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XAHuX7kj; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XAHuX7kj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a76b39587aso5085ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 10:19:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769019577; cv=none;
        d=google.com; s=arc-20240605;
        b=DOOuXI2pEW4WLBTYtlqw8dzsot8JSvnohWR+Omni00cqT4Folu/HEoJGFOb/hvEFfn
         vWsizvjw5jSj4EGVKTurCNFfd7lDR+VxEgh74AWeUKn92MTk1XB7lQWAmGv1FUI3m+2H
         6Tsu/3O+uLITPv77/b5XlFQaVMY4IWWsDh8Z1ZislRK7QTSDoB26QIoPAw3GhJrQ8pqJ
         ZZGWgvP0QS2h4uq6fqMN4nAV95y9cVettb8ghWWs2twbfdwbQId5Ey5npeM2s2b95s2C
         uabkEuWSKkO6I74MZmWZPykAEjuycVQRFJRi4+2XAF3+uC+ZUMVzpxt9MRgOcImYaFkx
         ycgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Efb51cknvHX9ei2E0sK84VWSn6iufvSF7ahHeBupD7Q=;
        fh=Clqm3twM6mjujinJswQAbEqDN3qcDuMm923c2Auvcvc=;
        b=EAwbzLEQmOBYKrMz6e1uN15AfJHDefSzFsg/G2nthqerzVDk6wAp1/XsTSqVqgkiTb
         RAdHJjx1QAHYww7EyfVLlvKEpdigYMmtPlAYrTaaiF/dD9zLorSdHbClNE2Wo0D2RT/t
         vLrxkvBgwso3QyXu/OIoUIQexzd+VEk5bg6KwhvIFg3E7q5f1w8nj/Xoq92Rgf9Tkv5E
         8Ifph9zyVUB6sDDyPbsiinyypg6oXpIUfsb1AiYp1Ti53pxMQGmVfpnB+cw/K0B02MpB
         AztVPuwTWS5PpzIy1sznOGWYbINltwS4VgU65sKXimhZ05/1+WC+dogF2uKmt1BAM7tD
         IuHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769019577; x=1769624377; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Efb51cknvHX9ei2E0sK84VWSn6iufvSF7ahHeBupD7Q=;
        b=XAHuX7kj1VpBbHoih8wI5jo6CabpIHrt3Zv1NXP3E6J2/q0MQUMDaAiIGVmhojtbvq
         1FfMTzNmLQiK2/7iYwjPwW58ggAa9bvgb5IZrAOBkS4R4xZ93RkRhQMIAXHbJXPIp15J
         sqzVc0riB2GLnvNd6Au6SnrrhYm0DuuwSlQNjfAtM6m2sFjIEOKsQkreokxSR7UfoK9+
         7BdHnHXDyBptiAF8EmWh0PG23u0wORgvkEcfz8hsgbVy2yjU1fbpLy1WNeCUfIrhK+tS
         hON4y+pZ0ZV9w/HEbBBCuloev1sihy8AcEgX8kHuACm+5xWe3TazXTK3r2EfzZxAakZe
         P9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769019577; x=1769624377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Efb51cknvHX9ei2E0sK84VWSn6iufvSF7ahHeBupD7Q=;
        b=u8y9WrEcWUT9sA5F2HS4P/gqRUooSy2SH4MaMAh2CBlAksBzZWTKDvYBozsouVDvGD
         QUXP30WboQJXYwAU/XRrbVmXtngSMUJip+JmPw5X1IuwFVETrDr2EA3iXtz5NivH420K
         ElX9emEQrnDLsVY6+EG6OdDictI0NPyu88ZQHbKGpuJS4GBdTq7Lqk1/6JyDuVccA+RD
         2OhwOinV5se2OajWdcQq7GxAjN1XGy7nAjT+526QF6eSVOfucr/geZBB4uNJMfbbMMsR
         jUSdqExRPZwnf9oBeHySufXcvwXs2q1Zuu7ENSswlrEAw2kTuhAKdy91fa9OzgF2eZaM
         DcQg==
X-Forwarded-Encrypted: i=1; AJvYcCUnvnGHxYX3dPAes6QiPCzffW38sb4K+xInWAuUN8CJOXQOPx2A2nUiNiSKmn0ZL4G6d8aIlXjyaavL7YtHkOT8@vger.kernel.org
X-Gm-Message-State: AOJu0YygdohRkrlNR+uotUK3HOhR4mgKsETIG7vuBUCJ1UjOoLiKLZ1G
	jRNGH3BU4SIKo46NhIFZjAjoQlZvck+EaZVfvOGGTLpjrJWKL1U3PHmCRz1wXjTY/rmHTt98oZQ
	ZWMv9sVdV112w9cCRo0MrcBpi7KLPP7V379vCaKOe
X-Gm-Gg: AZuq6aI9trPJIE76vjbFw2X09FQWBQyY1RS0PWWaYf9H91iJp3DoSZQcgTwzXD+Uajs
	Fy7rbFfjxp5xukCb1jVsOHeyUM64Lb+1qNyzneRPD6oHVPmrqzYVcII8jLnZ1JaE1/ScoIuE0cJ
	SaC7QVCuV6LTuT72DQXf+Asw9bAERsuQ9nQwxu2BsoWHuLfs3XQ5ETRdSi2AWlzsbQHHq3NERNm
	0Sr8P+lF9qacKX/Hr2ZDIT9pPaEzbaHKHx546qGL9T1juzZ+Eef8LR2YrhPLh5l1fQvtJMkVuxO
	eU6rSjj4dmFiHnZHAqpold2+iLh/KMldRErE
X-Received: by 2002:a17:903:907:b0:2a7:516d:18e2 with SMTP id
 d9443c01a7336-2a7d4290618mr36515ad.9.1769019577156; Wed, 21 Jan 2026 10:19:37
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231224233.113839-1-zide.chen@intel.com> <20251231224233.113839-12-zide.chen@intel.com>
 <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
 <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com> <CAP-5=fXnMgwoa=VF2oK6D_rXvEOLCyq2PHkXoyN42KOgaWBTgQ@mail.gmail.com>
In-Reply-To: <CAP-5=fXnMgwoa=VF2oK6D_rXvEOLCyq2PHkXoyN42KOgaWBTgQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 10:19:26 -0800
X-Gm-Features: AZwV_QjURA5R9qArwSIE51WjzJCksh58z91mr7o0-btZPTYCEl_sfIW-WmyEtd0
Message-ID: <CAP-5=fVVZbb0qSDw+geqbb2m0rtb4gS3xSgO-iK6hJp-R2MWLQ@mail.gmail.com>
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

On Wed, Jan 21, 2026 at 6:33=E2=80=AFAM Ian Rogers <irogers@google.com> wro=
te:
>
> On Wed, Jan 21, 2026 at 12:02=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.int=
el.com> wrote:
> >
> >
> > On 1/21/2026 3:18 PM, Ian Rogers wrote:
> > > On Wed, Dec 31, 2025 at 2:49=E2=80=AFPM Zide Chen <zide.chen@intel.co=
m> wrote:
> > >> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> > >> "uncore_pcie4_*" and "uncore_pcie6_*".
> > >>
> > >> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can m=
atch
> > >> and collect events from both PMU types, slightly relax the wildcard
> > >> matching logic in perf_pmu__match_wildcard().
> > >>
> > >> This change allows a wildcard such as "pcie" to match PMU names that
> > >> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
> > >>
> > >> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >> Signed-off-by: Zide Chen <zide.chen@intel.com>
> > > Can we not merge this. I'd missed a perf tool patch as it was hiding
> > > in a bunch of kernel uncore updates. At the very least if wildcard
> > > conventions are updated then the corresponding documentation needs
> > > updating:
> > > Documentation/ABI/testing/sysfs-bus-event_source-devices
> >
> > Ian, thanks for the information. We didn't notice there is such
> > documentation to describe the name. :(
> >
> > Besides the documentation, are there other comments? We can update it
> > together. Thanks.
>
> The suffix handling is notoriously brittle. For example, ARM added hex
> suffixes which are generally 12 characters of physical address rather
> than the typical _0, _1, etc. What could go wrong? Well in some
> situations ARM make their core PMU's follow the model name, so rather
> than armv8_pmuv3_0 the core pmu is a name that ends with a model
> number something like _a76, however, that is also a valid hex suffix.
> So we have bumped the hex suffix to be at least 2 characters:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/pmus.c?h=3Dtmp.perf-tools-next#n81
> This also works around the naming of s390 PMUs (comments in the code).
> ARM now have models like a720ae which would appear as a 5 character
> hex suffix, and so this whole hex suffix thing is hanging together for
> some part because we treat core and uncore PMUs differently. From my
> pov, ideally the ARM uncore PMUs would have just used the _0, _1, etc.
> naming convention and placed the physical address information into a
> caps file, rather than trying to shoehorn it into the PMU name.
> s390 pmu names have discrepancies that mean lots of their core PMUs
> can match suffixes and Intel's i915 PMU name ("i915") will happily
> match as just "i" as the underscore before the number is optional. A
> change like this needs a range of testing on a variety of
> architectures because the code has broken things in a lot of different
> architecture types.
>
> Besides a lack of testing, going in through the wrong tree, the change
> is changing suffix handling in one place but not all - at least
> pmu_name_len_no_suffix wasn't updated. Let's get this out of the tree
> and start again.

To be explicit, things that I think are broken by this change:

1) ARM has PMUs called armv8_pmuv3_0, previously _0 would be the
suffix and now 3_0 becomes the suffix. There may be other existing
PMUs where this unintended behavioral change has happened. This may
break output formatting but I think as the patch is incomplete that
hasn't happened here.

2) as pmu_name_len_no_suffix wasn't updated it and assuming a machine
with uncore_pcie4_0, uncore_pcie4_1, uncore_pcie6_0, uncore_pcie6_1
and a common data_read event, the wildcarding for "pcie/data_read/"
should match the event on the 4 PMUs, however, rather than the PMU
name with no suffix (what pmu_name_len_no_suffix gives) being
uncore_pcie it will be either uncore_pcie4 or uncore_pcie6 depending
on which event/evsel we get the PMU name for. As the output will show
an aggregated amount the output for "perf stat -e pcie/data_read/ .."
the output may show just 1 event "pcie4/data_read/" rather than
"pcie/data_read/" as the suffix length calculation is off and the
number before the underscore not removed. In this example, it makes it
look like just 2 events on 2 PMUs were read rather than the full 4
events.

So my point is, resolving this is complex and needs buy-in and testing
from at least s390 and ARM. The easiest thing to do for now is to
drop/revert the change.

Thanks,
Ian

> Thanks,
> Ian
>
> > >
> > > Thanks,
> > > Ian
> > >
> > >> ---
> > >>  tools/perf/util/pmu.c | 14 ++++++++------
> > >>  1 file changed, 8 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > >> index 956ea273c2c7..01a21b6aa031 100644
> > >> --- a/tools/perf/util/pmu.c
> > >> +++ b/tools/perf/util/pmu.c
> > >> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const char =
*pmu_name, const char *tok)
> > >>  {
> > >>         const char *p, *suffix;
> > >>         bool has_hex =3D false;
> > >> +       bool has_underscore =3D false;
> > >>         size_t tok_len =3D strlen(tok);
> > >>
> > >>         /* Check start of pmu_name for equality. */
> > >> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const cha=
r *pmu_name, const char *tok)
> > >>         if (*p =3D=3D 0)
> > >>                 return true;
> > >>
> > >> -       if (*p =3D=3D '_') {
> > >> -               ++p;
> > >> -               ++suffix;
> > >> -       }
> > >> -
> > >> -       /* Ensure we end in a number */
> > >> +       /* Ensure we end in a number or a mix of number and "_". */
> > >>         while (1) {
> > >> +               if (!has_underscore && (*p =3D=3D '_')) {
> > >> +                       has_underscore =3D true;
> > >> +                       ++p;
> > >> +                       ++suffix;
> > >> +               }
> > >> +
> > >>                 if (!isxdigit(*p))
> > >>                         return false;
> > >>                 if (!has_hex)
> > >> --
> > >> 2.52.0
> > >>
