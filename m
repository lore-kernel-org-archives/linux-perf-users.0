Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBEB3E51C7
	for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 17:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776273226; cv=pass; b=mtLZLmWNz2fY07mCCNxtqXmC6qsti1HWNTDItG6/LQs5VDmBUuYPkmGM+WRrzGWxJnkm/aTZ+AQp0MR0iDNTaAoDo+wnXkDFvIt3EsVOxpt10yPZt+NE31OTBClwPBwHMYUPc65KOlKidrg917ufl6viO36y/XdaWcmkDFJmkSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776273226; c=relaxed/simple;
	bh=s3TlneGTtgZkhf2a6cRw8SxgcpnVtRXJ0p5SucE/8Dc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JG/9eNMFtdQWaoXabhKY7OGnpn8b8lnagJBAJI5zXRLbaFXmugTULWKYndRIYKtQgWTDge6YQ/rTUP/dIrCUGKYh8cdK8GghSua6lh0Wh//L/sDC4ZpG+z2Yzkm7F/mS4ZGHHK7E7RaygBRtNS/rnog4B6MjoUrYdO9C6F0zLaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EBngt3Aq; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EBngt3Aq"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b2e8b95bdbso25885ad.0
        for <linux-perf-users@vger.kernel.org>; Wed, 15 Apr 2026 10:13:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776273224; cv=none;
        d=google.com; s=arc-20240605;
        b=BJuyZcAj6o+gSUxdYH1yLzfcj0Hmd6R9AfBdoRZccFVfhWIfPlcff/QeLzQP0Leuuw
         Tqh8NNY2kFoyldoKdygV5Ye8+Rzo85mDJ+Kz9pRjrUhS5CP7IBai0XTOVcmQcOAzJARI
         3ejICoyXrktGKWpv1AQnRagLMbTldVZlY42Q1K4RIbxPaE+Hfif5+9E3jRNFpnTptJPR
         6E8fAjLF8Tq061kcHH9g1D46FDvZm8K1rinuKqmldPgad4w62ysEVTVIKtbNkIzSYzcr
         U4+w8MFHAlrmbM6JlbLw1mTEkezf/SJlYL+/ujGs9tfu0kldqiWD6amh44m+L/I97kXy
         M7vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FYcWcz5aJypLjGST25Dvn/EADFHU0gHzqJMvhyb9K8o=;
        fh=8k1JbqdnfM6Aq2diHhWkRcG9GmnPfyLe6G4r3vvmQTw=;
        b=N64Y6jQURlABf011XnrJY90rxV9gQn1H2EjSLqj5tHCahTTrC3HCYru+WmhEkYsO4+
         KoXBM0pzROp1n81WEoYyS4RNPlZpTUKNkmZUj+Xu+VWtQQ4n9frJ2p/JdfAYhjDP04Wq
         f+UF2iNKSKWbGPwMwwsDDpl+QkXNYwSOJr4IWkNQbsIbTjC3li0be093iYOkbkeN0zht
         HbxzxC2gdVqywrFH8npBcWX6QXzO/Jq0fTReIrMqGch7gsibDJEOyf+FfnF89kZWkyxr
         Ipequ2EOWFOiEkN6Iuy5dj5NTdi4SlmOW9iaFoXCBYn4g//So5kk9mCkzi1FNpVX8//T
         wDIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776273224; x=1776878024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYcWcz5aJypLjGST25Dvn/EADFHU0gHzqJMvhyb9K8o=;
        b=EBngt3AqL1FXfZovC9035UT3ywR7LMeLulqQV++HemIu3UgH/WlezVFhZ8xNKu0AVr
         lg0cGcd1Vxwlh0kpAMFYmEh4ALWWdlaHiPIapvjxeHz/H2MA0Hej6d+2+lx++4Lv91Ro
         3KNbRjlIt+saB0XIy8L0LzAgfmKIqcZnbljBb7qjG7tqV7VESwM76taR22FgxIouOfsN
         P57SwhRGV1PoeeNHtUErP4RsA658mqyMoKQtgMptBozKCSTshzGOIF2M53gtSSLtCKax
         PGcaM3gjpZwC+Pltb1Uea7IOW2uOyQ46y1tEi5g2EgIfB7ZJP6iChF06mUmqyIidxvee
         hSMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776273224; x=1776878024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FYcWcz5aJypLjGST25Dvn/EADFHU0gHzqJMvhyb9K8o=;
        b=M4esyExLdqRIhBJ9j37ysmOMZjeQaLhUQj1F8ZXkEyINP3dqK08kxbikgNmIZHKveS
         z3f2Rg4+8BBtgEGussO9Kl46j1KXXpKWmanSm2qkdE+0MBFgm7+lYJ132bT3C4mSK6Xe
         /YVB8wmnUljd5Oxkt9Q+guxzXMzz+y1IQQUU+0EsPOKNg28giPhTOGE7+jjIuUolz478
         xBQ6JZmBZxzi4NYhxFf8vi8/oMEX2qMRzJ0saHPdq1SI19rPWWDdk9LmeQUAVg65OTrP
         2M8mCTQ1ASQLsPVs1jM8Ucn3U7/c9MBtaKxTpD0t6XPmm1cGO+uatPpphu6RXxrL4L4F
         yFRg==
X-Forwarded-Encrypted: i=1; AFNElJ90tNYVAO9vtEpQN2c/VPb/GWxoJ8vhi99kPb9doxHvptWpKGwDcG/eIwLLfMuIoRdxAVlkco3V2fw2gFcT+hRy@vger.kernel.org
X-Gm-Message-State: AOJu0YySgQlziMOqYGiUCPln+KYHM/3aLNCe8wnK1aktTV08YArjgYia
	hfWeER8SbWfIznVqNcUhFmrNhjrPv8AEl1YOPvjpCwXuj5unCJ4YhDzxwteWWp5EYGGne7T0Rlm
	O6qy6JcAQu0wnYqwPfoCcGGFUVzea7qhUKCEGAh3k
X-Gm-Gg: AeBDiesZ76UakMh7+fFcdgFs9XugMAF/aI7u2mPVmayIQLfR+WhMHzG3yh1PnGdwOHJ
	YoPIErk32ny1Vi7x2BCSA+Sm1cHDhBJXv2lKwJj6u5tPgwA9yDikPE9MENiriqpSmVROorjo4iw
	FwYH1E19r2445v3IqQpLqPNI1hJJil4sVczh1khoPNwmvsKnQuv0Avnm3pNgH5KHig2l9rR2oiN
	6AnhGDzQTc4yJA42vxgyIlxb6oONr4jfIc7ZVqP+pTRs7eEilu5Nt8Vy7wCS7rcpdhGoGD3AJ7U
	xdOb0H0OM0OAbnUr6EiqW/D2OBGl+3a6eX4JdU9wO+WzUOgEpr+MHnC9J+4=
X-Received: by 2002:a17:903:37d0:b0:2b0:5c88:51e1 with SMTP id
 d9443c01a7336-2b5eb1e1dc5mr69755ad.14.1776273223556; Wed, 15 Apr 2026
 10:13:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413010920.546501-1-dapeng1.mi@linux.intel.com>
 <CAP-5=fW0Z0zXDjqR_tpJbT-0nbyXQO-Zcc+4Fpk=XejYX8uF4g@mail.gmail.com> <0ce093d8-3647-4879-9d65-acd52d4c0ab0@linux.intel.com>
In-Reply-To: <0ce093d8-3647-4879-9d65-acd52d4c0ab0@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 15 Apr 2026 10:13:30 -0700
X-Gm-Features: AQROBzBLlxn_CLuDJq8Ee0GFbBIzQ5Gr21sA0tYXXyRcxkgluYHfBfXbVnFkFqU
Message-ID: <CAP-5=fWj4PaadfdmkoNyOVnbNb9aAdhgxOr-CG+R8OLx2jFRCg@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Add auto counter reload (ACR) sampling test
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Falcon Thomas <thomas.falcon@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>, Xudong Hao <xudong.hao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 2:19=E2=80=AFAM Mi, Dapeng <dapeng1.mi@linux.intel.=
com> wrote:
>
>
> On 4/13/2026 9:30 AM, Ian Rogers wrote:
> > On Sun, Apr 12, 2026 at 6:14=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.int=
el.com> wrote:
> >> Add auto counter reload sampling test to verify that the intended even=
t
> >> records can be captured and the self-reloaded events won't generate an=
y
> >> records.
> >>
> >> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> >> ---
> >>  tools/perf/tests/shell/record.sh | 42 +++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 42 insertions(+)
> >>
> >> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell=
/record.sh
> >> index 7cb81cf3444a..1068843282f5 100755
> >> --- a/tools/perf/tests/shell/record.sh
> >> +++ b/tools/perf/tests/shell/record.sh
> >> @@ -402,6 +402,47 @@ test_callgraph() {
> >>    echo "Callgraph test [Success]"
> >>  }
> >>
> >> +test_acr_sampling() {
> >> +  events=3D"{instructions/period=3D20000,acr_mask=3D0x2/u,cycles/peri=
od=3D40000,acr_mask=3D0x3/u}"
> >> +  pebs_events=3D"{instructions/period=3D20000,acr_mask=3D0x2/pu,cycle=
s/period=3D40000,acr_mask=3D0x3/u}"
> >> +  echo "Auto counter reload sampling test"
> >> +  if ! perf record -o "${perfdata}" -e "${events}" ${testprog} 2> /de=
v/null
> >> +  then
> >> +    echo "Auto counter reload sampling [Skipped not supported]"
> >> +    return
> >> +  fi
> >> +  if ! perf script -i "${perfdata}" | grep -q "period=3D20000,acr_mas=
k=3D0x2"
> >> +  then
> >> +    echo "Auto counter reload sampling [Failed missing instructions e=
vent]"
> >> +    err=3D1
> >> +    return
> >> +  fi
> >> +  if perf script -i "${perfdata}" | grep -q "period=3D40000,acr_mask=
=3D0x3"
> >> +  then
> >> +    echo "Auto counter reload sampling [Failed cycles event shouldn't=
 be sampled]"
> >> +    err=3D1
> >> +    return
> >> +  fi
> >> +  if ! perf record -o "${perfdata}" -e "${pebs_events}" ${testprog} 2=
> /dev/null
> >> +  then
> >> +    echo "Auto counter reload PEBS sampling [Skipped not supported]"
> >> +    return
> >> +  fi
> >> +  if ! perf script -i "${perfdata}" | grep -q "period=3D20000,acr_mas=
k=3D0x2"
> >> +  then
> >> +    echo "Auto counter reload PEBS sampling [Failed missing instructi=
ons event]"
> >> +    err=3D1
> >> +    return
> >> +  fi
> >> +  if perf script -i "${perfdata}" | grep -q "period=3D40000,acr_mask=
=3D0x3"
> >> +  then
> >> +    echo "Auto counter reload PEBS sampling [Failed cycles event shou=
ldn't be sampled]"
> >> +    err=3D1
> >> +    return
> >> +  fi
> >> +  echo "Auto counter reload sampling [Success]"
> > Thanks Dapeng! Could we also test ratio-to-prev as well as just the
> > plain acr_mask?
>
> Ian, it could be hard to validate ratio-to-prev option in this test. On
> platforms which don't support ACR, perf would automatically fallback the
> ACR sampling to normal sampling, this would lead to false positives on
> checking the existence of records from cycles event. I didn't find a good
> way to figure out this fallback.
>
> Since we already have independent test case to validate the ratio_to_prev
> parsing. It may be unnecessary to add ratio-to-prev validation in this AC=
R
> test.

So the ratio_to_prev test covers parsing the ratio-to-prev option (it
only has `perf record` commands) and ensures it is acted upon, but it
doesn't check the option's functional behavior - what the output is.
This test makes sure the acr_mask option is functional and so would be
complemented by ratio-to-prev testing somethig like:
```
  rtp_events=3D"{instructions,cycles/period=3D40000,ratio-to-prev=3D0.5/u}"

  # Test ratio-to-prev
  if ! perf record -o "${perfdata}" -e "${rtp_events}" ${testprog} 2> /dev/=
null
  then
    echo "Auto counter reload ratio-to-prev sampling [Failed record
ratio-to-prev]"
    err=3D1
    return
  fi
  if ! perf script -i "${perfdata}" | grep -q "instructions"
  then
    echo "Auto counter reload ratio-to-prev sampling [Failed missing
instructions event]"
    err=3D1
    return
  fi
  if perf script -i "${perfdata}" | grep -q "cycles"
  then
    echo "Auto counter reload ratio-to-prev sampling [Failed cycles
event shouldn't be sampled]"
    err=3D1
    return
  fi
```
The first thing your test does is to make sure the acr_mask is
supported, so I'm not sure how the fall back can happen?
We could additionally check for
`/sys/bus/event_source/devices/cpu*/format/acr_mask`.

Thanks,
Ian

> >
> > Thanks,
> > Ian
> >
> >> +}
> >> +
> >>  test_ratio_to_prev() {
> >>    echo "ratio-to-prev test"
> >>    if ! perf record -o /dev/null -e "{instructions, cycles/period=3D10=
0000,ratio-to-prev=3D0.5/}" \
> >> @@ -457,6 +498,7 @@ test_leader_sampling
> >>  test_topdown_leader_sampling
> >>  test_precise_max
> >>  test_callgraph
> >> +test_acr_sampling
> >>  test_ratio_to_prev
> >>
> >>  # restore the default value
> >>
> >> base-commit: 4e03d6494f9504f8af46ba68a2a8b6877c196789
> >> --
> >> 2.34.1
> >>
