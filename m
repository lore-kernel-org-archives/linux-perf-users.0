Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558FE345CB0
	for <linux-perf-users@vger.kernel.org>; Thu, 22 Jan 2026 07:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769065868; cv=pass; b=ahJIRH6QssUw9qbPK9ZOj0e7jaflXI57dXh6YK+XXBzlBiRwOPkU4pTvHiYv2OmkoR7nR4MMeQU8Jl9RJG15JNUvgPh+uoLjhxJE2E1pViM3j9vzU/jXbb2EQ8lJUIKqUxabX+n8zrY93guM/olf7+lylOpWMjSomEkoWfP293A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769065868; c=relaxed/simple;
	bh=q5+MA4WaOLu4f98BZQEVfeL8VylCLV6ZxpdHDz/bQmI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dUe1qs9nhIgKZcgtehn/phREZ6JZ5BA7hO6v+At9eQMpBPzpuEFXrpJWRBZiybi/Ajz5EotgCey/DFL9mKb/qpobHstBvT9wpN1rv8R4wSBYgnmqDJT4cO6qh8v6RkYUBCuzvRJNVhndJXRGPuyPMiPMmt5TK2cA3FWYYvekEZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bYdMhhVh; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bYdMhhVh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a1462573caso33585ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 23:10:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769065853; cv=none;
        d=google.com; s=arc-20240605;
        b=AobNGcdOw6d4vunjEHuzCNhjR0BRBNQ1O161BsK4diRfiFm/wx8PJ2LTtGVa+mWQRM
         Ci+0WLTaVinVBwfjZwooF51XPz14F3wfhX/vmEA2XvLsoCeO+O1nz+t13awnURbIK6xK
         AibpjrPTK3q1wzPAF2fWIf0CGbNgpizdW7CqKOzHkA6Q/swVfSmVBtuG/hMMBjCrLYTL
         aeVclgMJGH66bSUX2t5gCNQNORYvsbxEFIw9MBqUPzbihpoVRuI+yNt64IsbCnG7zwMT
         5yYunsZEjXubSeQLN1AKDr3V3H/DHRyKYYoCHaNs6X6jMGl7vnDAx/hCNrQOHQeDb0Ca
         Dhlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F0BaD+v81dlVaebU+BVETwfyNe3GQUhPn6UPHVOWiGo=;
        fh=EM5laG7jwUosybGASR3k1bx9IHkor8lhUCbGhKEZcNI=;
        b=a+UYbMhebCIlU3Gad51eqMeOcaUmFrkgRYgUBUIMyuIoh38nQkR4uqBkaqZLdJ2oXW
         kreJ+zYd9M0tt1uSw7ljNwSRnp9BLZof9jDNhyanyGZy4aw4kyekcUU/5tr5bACOPrV8
         erwK45ZDsGpBOKp3Eb+Ui/en48EjaT2mIV2JyJ7DwGkmGdR0kSOeUsfLch2BwOhk/j+L
         li4AG6Tl+d0f8MouZP7jxzBbJC5VoffKd+NMvKrqUVUqTRXYptaomv2x/NJY6kdqcGL5
         hC3raxC9ZDRfR+USTpSYG/55JzUHiYKqnjygN8j30whRpEF376CYUcRcxMqqm4HeoWH0
         7FnA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769065853; x=1769670653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0BaD+v81dlVaebU+BVETwfyNe3GQUhPn6UPHVOWiGo=;
        b=bYdMhhVhfv1j3k3ei+vAD53qBwxpNmzbdYFoZrCBXaGk0QpaTkKrCPuAaTQ9XohqB7
         P4A0pWg7R/5uExl9xHWl1ErDRWgM1BW0N9DInDZpwSAypqXWo3rv6nVbNC7QDdgR/zkI
         jB/40VQkGyRpGsSP6UuVuCeCG+WjVjZ5ILdsGZbtTyU3uF2dZBI4qXv45ynFF8hotwfS
         ihN+Y5guW+dsAnhkmnJsXYIZg8qLpTdo2pqQ6nbACeaK1MTtEyZdCqCqjyoq8l2d3NCe
         008OG5dqhqa6A2DKEXpSTlPWjnr8ilUtMYtL6UHLnS7RxQx3HhzNArYe3CaK2SOR1d2L
         xXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769065853; x=1769670653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0BaD+v81dlVaebU+BVETwfyNe3GQUhPn6UPHVOWiGo=;
        b=izz6WHtTBIA6sHba3StP/AD5fc/St9SR02SMxYSTEqFOShe48Ke8RfcE9kWugutZN0
         PCYsMeT/MVBjsPNh5DWCD1Ea+prGDOpOp0+qhMYgtn4D0GGq6TgdDi1PzoIL6r4p/MlL
         7dPTElzc+sw3lWiIggSlcErUbRr6M+SxAaC4+Pqft8PgnOYKdmkRmPOXhl6fX41J1T2Q
         TeTuKheToQnz/cUJNRu3EsL8gXWAcE8D/1edllDCrII8JefOQFpphUfyaFa6ODw6jCzX
         e6o/c/NS6oItsQ1HmWW4hKmgtSOhOprdUgLPnRtO4UiEzujHZV+EYp6esd0sjxPTLCWF
         2ZlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0xqLMha5QByCGd+FsJK6pFp2pO/06pxOFCwTrWx8CbuK6LwiXn8LlS7G3hB97OiS8+LV2Vc5l5GZ37nOqcBam@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6rLz6KeuvFaQJxpo4pAXQJ3NGD94k/WoEgG9qzxjErdBxQxC/
	HsQQz96fpMvRRDIhTDFvMbU0sV8QzlBBk4XI1cRlQWW2eAsoCO26rcH3e2uZsYjGQYYJ4A60kAD
	2jGglWeHg4ddhDpHWmXerIWWSmCd7OVkNBo0koj3z
X-Gm-Gg: AZuq6aKxk8spo/617QU/5XGnlx+ysnrjh6/eWMOe7bo26sjXv2oITNe9qOEBBpV9fJV
	JXglTkdbB+crRBD1w8BLrkDw0vVf2FXamU6VDKgFMYPQ0SNztHrYW9aqLYm69dq6Dx2BcpD+qoG
	OZ6B7vJnfEnZruCcvHcbMF4BXCKnNDm3MIQEcFypegglTqLdY3UMaQXiLNb8R7rYOOuL76hi7ex
	ymfmjd8zQbq0SnqV6bC99YNG/72xWMZaYMq0ctePS2AMu4DkVYgyngeb5Ku5d2EUIm6DlFcWINF
	kwDMWFvq+6+lj3BzdaxSIoOlyQ==
X-Received: by 2002:a17:903:2310:b0:2a7:6ce1:17d8 with SMTP id
 d9443c01a7336-2a7d3ee0699mr2149545ad.0.1769065853105; Wed, 21 Jan 2026
 23:10:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231224233.113839-1-zide.chen@intel.com> <20251231224233.113839-12-zide.chen@intel.com>
 <CAP-5=fVO+dSstWmYiTvu7o66hahiUKig4r=FEfu+FvUN8+nvcg@mail.gmail.com>
 <12dbc1f5-022d-4653-8ac7-01c503a860dd@linux.intel.com> <CAP-5=fXnMgwoa=VF2oK6D_rXvEOLCyq2PHkXoyN42KOgaWBTgQ@mail.gmail.com>
 <CAP-5=fVVZbb0qSDw+geqbb2m0rtb4gS3xSgO-iK6hJp-R2MWLQ@mail.gmail.com>
 <d8b6e506-a235-4d50-b223-bf979247c4ca@intel.com> <f39e1250-228b-406e-95c2-1a30897dbd0d@linux.intel.com>
In-Reply-To: <f39e1250-228b-406e-95c2-1a30897dbd0d@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 21 Jan 2026 23:10:41 -0800
X-Gm-Features: AZwV_QjweXqEl9cQ6lnlipYqz7M3bxSfeC6VwkG1sdEowg7_2jwR9fX2ULe0wSQ
Message-ID: <CAP-5=fW5PHB-5DmY-rh+BbP2JEH+0Z+=tdoe_iZW_TVNQnUbwg@mail.gmail.com>
Subject: Re: [PATCH V2 11/13] perf pmu: Relax uncore wildcard matching to
 allow numeric suffix
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: "Chen, Zide" <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Xudong Hao <xudong.hao@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 6:10=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 1/22/2026 3:03 AM, Chen, Zide wrote:
> >
> > On 1/21/2026 10:19 AM, Ian Rogers wrote:
> >> On Wed, Jan 21, 2026 at 6:33=E2=80=AFAM Ian Rogers <irogers@google.com=
> wrote:
> >>> On Wed, Jan 21, 2026 at 12:02=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux=
.intel.com> wrote:
> >>>>
> >>>> On 1/21/2026 3:18 PM, Ian Rogers wrote:
> >>>>> On Wed, Dec 31, 2025 at 2:49=E2=80=AFPM Zide Chen <zide.chen@intel.=
com> wrote:
> >>>>>> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> >>>>>> "uncore_pcie4_*" and "uncore_pcie6_*".
> >>>>>>
> >>>>>> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) can=
 match
> >>>>>> and collect events from both PMU types, slightly relax the wildcar=
d
> >>>>>> matching logic in perf_pmu__match_wildcard().
> >>>>>>
> >>>>>> This change allows a wildcard such as "pcie" to match PMU names th=
at
> >>>>>> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
> >>>>>>
> >>>>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> >>>>> Can we not merge this. I'd missed a perf tool patch as it was hidin=
g
> >>>>> in a bunch of kernel uncore updates. At the very least if wildcard
> >>>>> conventions are updated then the corresponding documentation needs
> >>>>> updating:
> >>>>> Documentation/ABI/testing/sysfs-bus-event_source-devices
> >>>> Ian, thanks for the information. We didn't notice there is such
> >>>> documentation to describe the name. :(
> >>>>
> >>>> Besides the documentation, are there other comments? We can update i=
t
> >>>> together. Thanks.
> >>> The suffix handling is notoriously brittle. For example, ARM added he=
x
> >>> suffixes which are generally 12 characters of physical address rather
> >>> than the typical _0, _1, etc. What could go wrong? Well in some
> >>> situations ARM make their core PMU's follow the model name, so rather
> >>> than armv8_pmuv3_0 the core pmu is a name that ends with a model
> >>> number something like _a76, however, that is also a valid hex suffix.
> >>> So we have bumped the hex suffix to be at least 2 characters:
> >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-n=
ext.git/tree/tools/perf/util/pmus.c?h=3Dtmp.perf-tools-next#n81
> >>> This also works around the naming of s390 PMUs (comments in the code)=
.
> >>> ARM now have models like a720ae which would appear as a 5 character
> >>> hex suffix, and so this whole hex suffix thing is hanging together fo=
r
> >>> some part because we treat core and uncore PMUs differently. From my
> >>> pov, ideally the ARM uncore PMUs would have just used the _0, _1, etc=
.
> >>> naming convention and placed the physical address information into a
> >>> caps file, rather than trying to shoehorn it into the PMU name.
> >>> s390 pmu names have discrepancies that mean lots of their core PMUs
> >>> can match suffixes and Intel's i915 PMU name ("i915") will happily
> >>> match as just "i" as the underscore before the number is optional. A
> >>> change like this needs a range of testing on a variety of
> >>> architectures because the code has broken things in a lot of differen=
t
> >>> architecture types.
> >>>
> >>> Besides a lack of testing, going in through the wrong tree, the chang=
e
> >>> is changing suffix handling in one place but not all - at least
> >>> pmu_name_len_no_suffix wasn't updated. Let's get this out of the tree
> >>> and start again.
> >> To be explicit, things that I think are broken by this change:
> >>
> >> 1) ARM has PMUs called armv8_pmuv3_0, previously _0 would be the
> >> suffix and now 3_0 becomes the suffix. There may be other existing
> >> PMUs where this unintended behavioral change has happened. This may
> >> break output formatting but I think as the patch is incomplete that
> >> hasn't happened here.
> >>
> >> 2) as pmu_name_len_no_suffix wasn't updated it and assuming a machine
> >> with uncore_pcie4_0, uncore_pcie4_1, uncore_pcie6_0, uncore_pcie6_1
> >> and a common data_read event, the wildcarding for "pcie/data_read/"
> >> should match the event on the 4 PMUs, however, rather than the PMU
> >> name with no suffix (what pmu_name_len_no_suffix gives) being
> >> uncore_pcie it will be either uncore_pcie4 or uncore_pcie6 depending
> >> on which event/evsel we get the PMU name for. As the output will show
> >> an aggregated amount the output for "perf stat -e pcie/data_read/ .."
> >> the output may show just 1 event "pcie4/data_read/" rather than
> >> "pcie/data_read/" as the suffix length calculation is off and the
> >> number before the underscore not removed. In this example, it makes it
> >> look like just 2 events on 2 PMUs were read rather than the full 4
> >> events.
> >>
> >> So my point is, resolving this is complex and needs buy-in and testing
> >> from at least s390 and ARM. The easiest thing to do for now is to
> >> drop/revert the change.
>
> Sigh, the PMU name wildcard comparison is over complicated than I imagine=
...

Agreed. One proposal from chatting with Namhyung is that in the future
we have some PMU base name file in sysfs, this will be used for
wildcard matching, giving the name with no suffix, etc. At some future
point that may allow us to not care about all of these overloaded uses
for the PMU name.

Thanks,
Ian

> I have no objection to drop this specific perf tools patch. Thanks.
>
>
> > Agreed. Thank you very much for pointing this out!
> >
> >
> >> Thanks,
> >> Ian
> >>
> >>> Thanks,
> >>> Ian
> >>>
> >>>>> Thanks,
> >>>>> Ian
> >>>>>
> >>>>>> ---
> >>>>>>  tools/perf/util/pmu.c | 14 ++++++++------
> >>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
> >>>>>>
> >>>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> >>>>>> index 956ea273c2c7..01a21b6aa031 100644
> >>>>>> --- a/tools/perf/util/pmu.c
> >>>>>> +++ b/tools/perf/util/pmu.c
> >>>>>> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const cha=
r *pmu_name, const char *tok)
> >>>>>>  {
> >>>>>>         const char *p, *suffix;
> >>>>>>         bool has_hex =3D false;
> >>>>>> +       bool has_underscore =3D false;
> >>>>>>         size_t tok_len =3D strlen(tok);
> >>>>>>
> >>>>>>         /* Check start of pmu_name for equality. */
> >>>>>> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const c=
har *pmu_name, const char *tok)
> >>>>>>         if (*p =3D=3D 0)
> >>>>>>                 return true;
> >>>>>>
> >>>>>> -       if (*p =3D=3D '_') {
> >>>>>> -               ++p;
> >>>>>> -               ++suffix;
> >>>>>> -       }
> >>>>>> -
> >>>>>> -       /* Ensure we end in a number */
> >>>>>> +       /* Ensure we end in a number or a mix of number and "_". *=
/
> >>>>>>         while (1) {
> >>>>>> +               if (!has_underscore && (*p =3D=3D '_')) {
> >>>>>> +                       has_underscore =3D true;
> >>>>>> +                       ++p;
> >>>>>> +                       ++suffix;
> >>>>>> +               }
> >>>>>> +
> >>>>>>                 if (!isxdigit(*p))
> >>>>>>                         return false;
> >>>>>>                 if (!has_hex)
> >>>>>> --
> >>>>>> 2.52.0
> >>>>>>
> >
