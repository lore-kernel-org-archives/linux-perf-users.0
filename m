Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF352E06D2
	for <linux-perf-users@vger.kernel.org>; Tue,  3 Feb 2026 23:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770161600; cv=pass; b=TKZ+syXEIwpcbRG/k8zvSRdxYFj365nlgJ/DZ3Cl7sPOemSEzLPz0GxjtQ5stigkXwscKmPNqGfIQZwFpuvnkI2dmlgFrjaQ8n3J1OjnyJANrOnSDQVOMpwsNBPEBMRA9XD0vjdF6HabCJxiETFShCLskqjcwSWTqtEJoEuhJ60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770161600; c=relaxed/simple;
	bh=lVuShqiwLXoZ5u0coXVogjj//cxTh16o2S4il116s14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i8ETU2odm/rZUJB4f7oL2kokFlEO2jDRot8t1GREbxyrAlutODX8OnNLhwExuqC2wxazZWvPQyQvKaLN05ahxG5ygGpe05GmtB4yN2ls0Cglp7A0I2PbqKvp/9zoc57nzfZrrPyMABD45mK+VEA9BlZH4LolLIlm6yqLw5Z+70M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IqT5Dw3W; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IqT5Dw3W"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a1462573caso16125ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 03 Feb 2026 15:33:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770161598; cv=none;
        d=google.com; s=arc-20240605;
        b=S7HOxZwVecNoSmy6OzoeIxEanucQIQy7XPydol62AGYSd4WDnJAoZlLqplD7RHJU/g
         4zH7nUkU2u8vwo4EgN3cq07T36LLHECo80Hq2aROQ8m5zC7t1TnY+P2d6qlH6/NT49lH
         fpLjI4KpxT/kgd3m+KHkRZM5ouLJ0RibFvxpZTCtoc7UmZq2X+Gjbs1nU+FE7On/+7Vy
         TLKw7ISpPfmmutyHpprpz5OOJeeK1Pg/IBSEMMVHFJft6/W/Wea8TmK4xHCq4RzEZ3s9
         aG/7UIwN4lVixn8fo33Nh8bojsLAB63meNlh2rA47rfvBwJR4BdeVNAWhjYXCoG/d+1O
         VfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MGEnDS7qmQL0+Q50zye12E/b1wz2/diWcYDc1E5SFEU=;
        fh=DcuVBOGdMvtUY2STOq+Zw6+w9yinfxvKLzX5bx/AF/U=;
        b=WZWe1e2b5tk4KVyuj5l4zGwkOD59E57YKfiG0vr7swiAJOxDIMstwEFgTdsu5jrofr
         ZGAnuwZviFmjHBfm8FOO6hIvUrvIniZvAVj0MOY7YPHLNdZsf5u00TJET2y061Y0v8p8
         I3Y/e/9A6nHzmabu7PJi32e8X5PAxU0utETTZzyzm2qEPGXzZ028kffUpKiBTLw8n6CP
         ZNifLRI2wzQZWfX0rw5UEwN+A4h3ECQmOwaC7rvrkQBbUPtXb5Z9whuUFOIOgZOugOcf
         Wqvleh1aqBkUaMCUWxlJmUGcAsyfGb1phLYCrf66rZUdHfbpQ/TtCnNEo6BEP6HYd5jR
         fcBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770161598; x=1770766398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MGEnDS7qmQL0+Q50zye12E/b1wz2/diWcYDc1E5SFEU=;
        b=IqT5Dw3WQwfzjzP9oAYFAxkptWc8drZIIddWIraNgq7/plUWYkAEWmXpjxbY9RKJQK
         0VIzikq0ooInhDNE0/dvu8HoGK2L0LLt3Q7Py8h9PbSnZ6imKReKJD3OBAKmIQ+8IiQJ
         A8WbYWyp7fqETs4/Ejrg1j0uJmLKF3RkKie+LTmSUMOrv6aglFh+NeD4SvMZXf0X/6D/
         F0dh307pjxlZZ265+Guet3D1KM5NWPPntPyG7hQcNoJW9OTyK6wIBUGdUI3OHqQyvbmx
         AtoFA6+oMh/t0QD87lWDzcpghconb+G7fUaTKOAcGOHjdNqhmuXZ4M3tdbVwnPlKYx4M
         itVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770161598; x=1770766398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MGEnDS7qmQL0+Q50zye12E/b1wz2/diWcYDc1E5SFEU=;
        b=lBA7JwcmOEgSFgOtWF4SMY4kbAJB3IqvCi7737gOsR9/wxUNXWRJ6lG+P9HbnBTDQk
         63oDl1FDJtBLkt9Ax/d8gUiiVYNQUHTiJc7kNY6gTkUA6brhmo+/FIwLK+s7vO+WLmFb
         kap7nwQeCfyaZKjKg2L5uLuZO8ybhUBK5JKyUxNd0pZp6BQjm+rvEA1xWM9yJ26zznjM
         igzW3M8JJXOA3bMq1C6GCZvUn5rqqNeqNEC1kpNderkz1YHfwQ5ZlkUjlNQN6XrRzz7u
         vadDRInYM4lpv3uozvef7Pkkrcy8YASnotYnIoS205B7GVYgP8cO3b965ElZmMruCkKo
         fsvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlFkdGhpG4N7xhCayJ6XhrWzRTsNIV1kToiqfAGqZoJ2qHbUfFyajf45BiiLnkuMMm5YU7E8bjoSPnaTDbfTAP@vger.kernel.org
X-Gm-Message-State: AOJu0YyrG0+tBFIlg4JM8DUEBt+oJpJDWX1QptnwTcr6ZHEEtJgomH+M
	1YytHtFnqcP61M+9dPVYvTYFdqIPENVC6r3pSYIgz4b9hCSAALQ291pcwPB5Knf32FrbNMz9aHv
	Y0hy15jeJnas1+lL59yNQtNqi2YzUEdwwqOpdOJP/
X-Gm-Gg: AZuq6aI+WVg8q5AjhGPl3N565ODssnx+xiBoSQq5RmtZ03ZnofE3agne1sQIdmXznK/
	0rJToXiDHFFhGLxLepT75xAmjaYl9meag5GdX/lcw7I6IPrv+DbFz9e4MscPy+S7/Ay2wr8EiuQ
	7oHAJSh5TxISVAzasNTLsewZAayrA/0HAmw5Rf4fTYZfU6Z+v2MDuEPAqCA+ejNhP4hflISRnQc
	KwwZ/V5RNsxn6OdUrwFaqwRoBN1qr3ZAHaIrIwqRCXDYy2w4EjDVftWh/uvYxCLcdJuRirylzTS
	tjN6Pdvd9uZ+Vce/r2vDBM6tUw==
X-Received: by 2002:a17:902:cf41:b0:291:6858:ee60 with SMTP id
 d9443c01a7336-2a9344dc8c8mr1309325ad.4.1770161598135; Tue, 03 Feb 2026
 15:33:18 -0800 (PST)
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
 <CAP-5=fW5PHB-5DmY-rh+BbP2JEH+0Z+=tdoe_iZW_TVNQnUbwg@mail.gmail.com>
In-Reply-To: <CAP-5=fW5PHB-5DmY-rh+BbP2JEH+0Z+=tdoe_iZW_TVNQnUbwg@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 3 Feb 2026 15:33:07 -0800
X-Gm-Features: AZwV_QivUMHZ_T7PsAgtSU4uiDeL4mRYnjrx1bh9nfDZuBzJjlkHrVnkZBRDMVs
Message-ID: <CAP-5=fWofHz9fq=RLo90G_FQ2sjn4RyBp10d=wTOvJhxdvc_wQ@mail.gmail.com>
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

On Wed, Jan 21, 2026 at 11:10=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Wed, Jan 21, 2026 at 6:10=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.inte=
l.com> wrote:
> >
> >
> > On 1/22/2026 3:03 AM, Chen, Zide wrote:
> > >
> > > On 1/21/2026 10:19 AM, Ian Rogers wrote:
> > >> On Wed, Jan 21, 2026 at 6:33=E2=80=AFAM Ian Rogers <irogers@google.c=
om> wrote:
> > >>> On Wed, Jan 21, 2026 at 12:02=E2=80=AFAM Mi, Dapeng <dapeng1.mi@lin=
ux.intel.com> wrote:
> > >>>>
> > >>>> On 1/21/2026 3:18 PM, Ian Rogers wrote:
> > >>>>> On Wed, Dec 31, 2025 at 2:49=E2=80=AFPM Zide Chen <zide.chen@inte=
l.com> wrote:
> > >>>>>> Diamond Rapids introduces two types of PCIe related uncore PMUs:
> > >>>>>> "uncore_pcie4_*" and "uncore_pcie6_*".
> > >>>>>>
> > >>>>>> To ensure that generic PCIe events (e.g., UNC_PCIE_CLOCKTICKS) c=
an match
> > >>>>>> and collect events from both PMU types, slightly relax the wildc=
ard
> > >>>>>> matching logic in perf_pmu__match_wildcard().
> > >>>>>>
> > >>>>>> This change allows a wildcard such as "pcie" to match PMU names =
that
> > >>>>>> include a numeric suffix, such as "pcie4_*" and "pcie6_*".
> > >>>>>>
> > >>>>>> Co-developed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >>>>>> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >>>>>> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> > >>>>>> Signed-off-by: Zide Chen <zide.chen@intel.com>
> > >>>>> Can we not merge this. I'd missed a perf tool patch as it was hid=
ing
> > >>>>> in a bunch of kernel uncore updates. At the very least if wildcar=
d
> > >>>>> conventions are updated then the corresponding documentation need=
s
> > >>>>> updating:
> > >>>>> Documentation/ABI/testing/sysfs-bus-event_source-devices
> > >>>> Ian, thanks for the information. We didn't notice there is such
> > >>>> documentation to describe the name. :(
> > >>>>
> > >>>> Besides the documentation, are there other comments? We can update=
 it
> > >>>> together. Thanks.
> > >>> The suffix handling is notoriously brittle. For example, ARM added =
hex
> > >>> suffixes which are generally 12 characters of physical address rath=
er
> > >>> than the typical _0, _1, etc. What could go wrong? Well in some
> > >>> situations ARM make their core PMU's follow the model name, so rath=
er
> > >>> than armv8_pmuv3_0 the core pmu is a name that ends with a model
> > >>> number something like _a76, however, that is also a valid hex suffi=
x.
> > >>> So we have bumped the hex suffix to be at least 2 characters:
> > >>> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools=
-next.git/tree/tools/perf/util/pmus.c?h=3Dtmp.perf-tools-next#n81
> > >>> This also works around the naming of s390 PMUs (comments in the cod=
e).
> > >>> ARM now have models like a720ae which would appear as a 5 character
> > >>> hex suffix, and so this whole hex suffix thing is hanging together =
for
> > >>> some part because we treat core and uncore PMUs differently. From m=
y
> > >>> pov, ideally the ARM uncore PMUs would have just used the _0, _1, e=
tc.
> > >>> naming convention and placed the physical address information into =
a
> > >>> caps file, rather than trying to shoehorn it into the PMU name.
> > >>> s390 pmu names have discrepancies that mean lots of their core PMUs
> > >>> can match suffixes and Intel's i915 PMU name ("i915") will happily
> > >>> match as just "i" as the underscore before the number is optional. =
A
> > >>> change like this needs a range of testing on a variety of
> > >>> architectures because the code has broken things in a lot of differ=
ent
> > >>> architecture types.
> > >>>
> > >>> Besides a lack of testing, going in through the wrong tree, the cha=
nge
> > >>> is changing suffix handling in one place but not all - at least
> > >>> pmu_name_len_no_suffix wasn't updated. Let's get this out of the tr=
ee
> > >>> and start again.
> > >> To be explicit, things that I think are broken by this change:
> > >>
> > >> 1) ARM has PMUs called armv8_pmuv3_0, previously _0 would be the
> > >> suffix and now 3_0 becomes the suffix. There may be other existing
> > >> PMUs where this unintended behavioral change has happened. This may
> > >> break output formatting but I think as the patch is incomplete that
> > >> hasn't happened here.
> > >>
> > >> 2) as pmu_name_len_no_suffix wasn't updated it and assuming a machin=
e
> > >> with uncore_pcie4_0, uncore_pcie4_1, uncore_pcie6_0, uncore_pcie6_1
> > >> and a common data_read event, the wildcarding for "pcie/data_read/"
> > >> should match the event on the 4 PMUs, however, rather than the PMU
> > >> name with no suffix (what pmu_name_len_no_suffix gives) being
> > >> uncore_pcie it will be either uncore_pcie4 or uncore_pcie6 depending
> > >> on which event/evsel we get the PMU name for. As the output will sho=
w
> > >> an aggregated amount the output for "perf stat -e pcie/data_read/ ..=
"
> > >> the output may show just 1 event "pcie4/data_read/" rather than
> > >> "pcie/data_read/" as the suffix length calculation is off and the
> > >> number before the underscore not removed. In this example, it makes =
it
> > >> look like just 2 events on 2 PMUs were read rather than the full 4
> > >> events.
> > >>
> > >> So my point is, resolving this is complex and needs buy-in and testi=
ng
> > >> from at least s390 and ARM. The easiest thing to do for now is to
> > >> drop/revert the change.
> >
> > Sigh, the PMU name wildcard comparison is over complicated than I imagi=
ne...
>
> Agreed. One proposal from chatting with Namhyung is that in the future
> we have some PMU base name file in sysfs, this will be used for
> wildcard matching, giving the name with no suffix, etc. At some future
> point that may allow us to not care about all of these overloaded uses
> for the PMU name.
>
> Thanks,
> Ian
>
> > I have no objection to drop this specific perf tools patch. Thanks.

I'm still seeing this patch in tip.git:
https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/tool=
s/perf/util/pmu.c?h=3Dperf/core&id=3D2246c24426fbc1069cb2a47e0624ccffe5f262=
7b
with no revert:
https://web.git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/tools/p=
erf/util/pmu.c?h=3Dperf/core

Thanks,
Ian

> >
> >
> > > Agreed. Thank you very much for pointing this out!
> > >
> > >
> > >> Thanks,
> > >> Ian
> > >>
> > >>> Thanks,
> > >>> Ian
> > >>>
> > >>>>> Thanks,
> > >>>>> Ian
> > >>>>>
> > >>>>>> ---
> > >>>>>>  tools/perf/util/pmu.c | 14 ++++++++------
> > >>>>>>  1 file changed, 8 insertions(+), 6 deletions(-)
> > >>>>>>
> > >>>>>> diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > >>>>>> index 956ea273c2c7..01a21b6aa031 100644
> > >>>>>> --- a/tools/perf/util/pmu.c
> > >>>>>> +++ b/tools/perf/util/pmu.c
> > >>>>>> @@ -939,6 +939,7 @@ static bool perf_pmu__match_wildcard(const c=
har *pmu_name, const char *tok)
> > >>>>>>  {
> > >>>>>>         const char *p, *suffix;
> > >>>>>>         bool has_hex =3D false;
> > >>>>>> +       bool has_underscore =3D false;
> > >>>>>>         size_t tok_len =3D strlen(tok);
> > >>>>>>
> > >>>>>>         /* Check start of pmu_name for equality. */
> > >>>>>> @@ -949,13 +950,14 @@ static bool perf_pmu__match_wildcard(const=
 char *pmu_name, const char *tok)
> > >>>>>>         if (*p =3D=3D 0)
> > >>>>>>                 return true;
> > >>>>>>
> > >>>>>> -       if (*p =3D=3D '_') {
> > >>>>>> -               ++p;
> > >>>>>> -               ++suffix;
> > >>>>>> -       }
> > >>>>>> -
> > >>>>>> -       /* Ensure we end in a number */
> > >>>>>> +       /* Ensure we end in a number or a mix of number and "_".=
 */
> > >>>>>>         while (1) {
> > >>>>>> +               if (!has_underscore && (*p =3D=3D '_')) {
> > >>>>>> +                       has_underscore =3D true;
> > >>>>>> +                       ++p;
> > >>>>>> +                       ++suffix;
> > >>>>>> +               }
> > >>>>>> +
> > >>>>>>                 if (!isxdigit(*p))
> > >>>>>>                         return false;
> > >>>>>>                 if (!has_hex)
> > >>>>>> --
> > >>>>>> 2.52.0
> > >>>>>>
> > >
