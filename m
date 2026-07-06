Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9207F3C9ED9
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 18:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783363743; cv=pass; b=ArAHm0NLtd8un4xU34sq7hwVueC6FofcChw8uO0dku2ZzdhKD+Ixe5KOZ0uYW9xptiNkDoA5GWbOxa8PbP7YjE8T7pguceYEnEAd5iU+d/bNb3QKr9ZmmW4gHrZAReS72xbh0ggc1ed3muBlFAkJlLNUjCa+HAfqGQIYP3GT63I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783363743; c=relaxed/simple;
	bh=fSXLC+29Q6hMGPnVE0AS7x78VauG4a2lkxYGy+Qz7cA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qeT1nL11DOwvW1MLqPPMTaT3ccRfeeTISrRdjSjU1cvsW9qpcD29yF9lMYi6ULT1QIdfQLxX+ULAtBo4I4C6455XWnUPCV86T+SL/ALjJLF6Y0kNyTDnz8q4Znj8x9tdXpWj4XU6+vqazwY3yXsYXMt09pEzPuAWQvatw+YNjb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ufOFCgob; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufOFCgob"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cacef7d299so4185ad.1
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 11:48:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783363736; cv=none;
        d=google.com; s=arc-20260327;
        b=ocSvCGNvUDU+vqzEgVcHM39JaukQXU82Kcm7qv791rdTux7LShB3aXBlxzAMvgYmsH
         u6rxS93zWiCUUIByzTeuPAxHTgXPvw1g1EQID+9TDS/H3BEiNP5HFptAdmcm3DW45Ltj
         fS8Ni7YSbT6YQ3gDju8HzHCzoCAZNJO/tPsQuJ2tAabtv+Cvbwm3r6XdicDq+kLOMYko
         7RUJAZexGWKbFyBEDHaolpc9JAPTwmCyViiJM8H/inRhkN9Wk2SwxuWVd0PBntdBrQil
         NNX114cRolAqt2FwToe3X4pBoxnq7XM7288be+FpGtyRRtJHzg1EKo+gKm/JZ3VX4iT/
         D3eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K8F/Nl0r+WpOsDVesi8wVf/lFeR1D4uTWm+X/O0FskQ=;
        fh=6Hwjx1E4FLdNT/MCq/lw8Uhi6Y9FuqWrInGimY/yVXY=;
        b=Jc+SbY5Qu/uU4WF9O9S0nkHRJeqgo6n2nkrprS6A2ceS6clhlTTMWgodc+eIPVsL4x
         lZtIDlZvecTFKsQZ0FpaB1YJW3fmNbo96BQE6JscBUAv0GB9384OFlOeJgJHwPQokoOt
         YMZn0kK2fy61WyPimpPwra5Q6wCuX0QU3wQKZ1Y/CwAtuKTtfTXdOWfai0BID7wUepVB
         4K/mRarSqm6PCnMWtBuVHBZXAIJKYJOVaCaR1C8Xl86KzQ0j6iGJnhTHi8IuqKqMKTZI
         yXMoHTIJwgOQrKihx72IbdjHW4ne7qN938GfOaQ2HooOXmcnNV7d5DDY4Bc232J7IvGc
         ZBKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783363736; x=1783968536; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K8F/Nl0r+WpOsDVesi8wVf/lFeR1D4uTWm+X/O0FskQ=;
        b=ufOFCgobT+RbUeKHePrkfE4FHRJai74JlmI4P7hHu/5i4/RGKYCYGa+ghvBxptd2In
         3hjnKi53LyDqODgZLRCTvAXx22wEDZbSrIBtYrn6k7SNC1em2fZjJpfinx1M6CZVbu/W
         BUQXwm6ocWeZ2lnjj2KnCerT5zAt7I0fI+dp1SRW0cojaNjSWf06lAbWYABxoBvpEaWs
         a+j//l+beraB1qP7GZH39HfkldYh+XQ27WXZ58H/gx2QsFzmPDbtvebnCqPozmGA8Rt9
         k+w1FSFkZkRy+EMzgt8PduPanOwC2yDE9bRdXd8ChyauK/QX2jG31IbuwirihJmPaoHp
         zJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783363736; x=1783968536;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K8F/Nl0r+WpOsDVesi8wVf/lFeR1D4uTWm+X/O0FskQ=;
        b=V4dQai8KSsyF6ykfUWwf5nduLNrvnF9QCqVH+OpFGeuANushvFeIfkrtkrjH7MaYnu
         Novv7+ktWG4lR2+uiMhbbctlHWobzO6xvFfsD6IuBNm/7tIFhVBXFGy6eLlG73C6tD0+
         iGkQEYB9QwcxNK22FbUG3jk8TmXp+ALuqevDW1cY5n3gjQyv0DKjuga+srx0DdOSyNQ8
         fnHpFJcTghXK5loGBqWv5zzEnwbyTxit3XQ8iGer5C946ZreEmWt/XVNJOymbUhGXuIZ
         plE+CrMrirE2IP56hG3h946Uh5EibhAHyYRFFG/Q/YZ2MItgjTLY6GMGKA/B6QD0rlcF
         mmMQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro10VVLJK5FH3qSP/5yMQqkm2D/7uLEnoKfX4YzQ5MLKBitjBVdD3URkT85TqwoGbrxBRdLf238XCggeyLpnq5s@vger.kernel.org
X-Gm-Message-State: AOJu0YyETP3X/3e0h2iiNWCroGxqLMm+HD+i0eIu1byC1TbNaT9im7u1
	VtEkzNNe1nPDJr4SfwczuGVpKUX4qxt1PRR5d7jiDgsVHekyIllhR0/M+bcevU2cDrw5lpU+FWW
	d52Lq9bq2MjpoIeNk3gnJ51yB2/tBtgTR5Qj04bWg
X-Gm-Gg: AfdE7clFXocDgklXH7kTjXsPFUZTwcV2m42RIGYDV7yknpdGfD8/VmTDP4IwOm18lVI
	wdoXGU9FqONC4HqWuYOIkFB83xqF7o3ujpkUK6nM2RslGv64ldoeHbP8JQtzxUTTo8qMf/A6Q4z
	OkgGLnOkR6p9weWG86Xxlu+DQyFTtBGgS/6+JEfhGur/oFk/Mg4bjxecHBMluIzY8rSbrBNxoTL
	uPbtY67Pi2tHdJtzu/JMN+lKWwbmbsYBMd6bO26lrjoBPsb+s6HXBge8uo8/W177F0FgknueZ79
	UyFb05Uc+TJ6vRBcXe054dUW0Z4=
X-Received: by 2002:a17:902:d58f:b0:2c9:b404:b55 with SMTP id
 d9443c01a7336-2ccc3ac5329mr881935ad.6.1783363735170; Mon, 06 Jul 2026
 11:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706175624.692736-1-nazar.kazakov@codethink.co.uk>
 <CAP-5=fWXhESb=4TMyt2X9oM64h5xwpNf7VGqXCs+NbPr8zeuGA@mail.gmail.com> <9871da36895a05e0ca5646ba6edf4a52@codethink.co.uk>
In-Reply-To: <9871da36895a05e0ca5646ba6edf4a52@codethink.co.uk>
From: Ian Rogers <irogers@google.com>
Date: Mon, 6 Jul 2026 11:48:43 -0700
X-Gm-Features: AVVi8CfXJG8-485J721Yern5FnRmTFu7weQlUvg3jALVaQeNZx6RtexCoINEyqQ
Message-ID: <CAP-5=fWm8q6EX29hY33xoDNFJYoGOB4GnsLkXarUFzsoUZVEqg@mail.gmail.com>
Subject: Re: [PATCH] perf jevents: make events order more deterministic
To: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ben Dooks <ben.dooks@codethink.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 11:22=E2=80=AFAM Nazar Kazakov
<nazar.kazakov@codethink.co.uk> wrote:
>
> On 2026-07-06 19:04, Ian Rogers wrote:
> > On Mon, Jul 6, 2026 at 10:57=E2=80=AFAM Nazar Kazakov
> > <nazar.kazakov@codethink.co.uk> wrote:
> >>
> >> Some of the events have the same name, but differing descriptions.
> >> This
> >> leads to a non-deterministic sorting order, so fix by adding the
> >> description field to the order.
> >>
> >> Signed-off-by: Nazar Kazakov <nazar.kazakov@codethink.co.uk>
> >
> > This shouldn't be an issue; can you give an example? I mean, with:
> > $ perf stat -e event1,event1 true
> > There's only one meaning for what event1 is. There is wildcard
> > support, but that's not the same as having the same event more than
> > once, differing only by description. Note, I deliberately use events
> > with perf stat in the example because the metrics build on the regular
> > event parsing code.
>
> I meant sorting order during build time:
> tools/perf/pmu-events/pmu-events.c
> changes between different builds, you can see an example of diffoscope
> output here
> https://freedesktop-sdk.gitlab.io/-/freedesktop-sdk/-/jobs/15174060131/ar=
tifacts/result_folder/components/perf.bst/index.html
>
> /* offset=3D5995059 */
> "lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS,
> duration_time)\000\000L2 cache request for ownership (RFO) misses per
> second\000\0001misses/s\000\000\000\000000"
> /* offset=3D5995210 */
> "lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS,
> L2_RQSTS.RFO_HIT + L2_RQSTS.RFO_MISS)\000\000L2 cache request for
> ownership (RFO) misses\000\000100%\000\000\000\000000"
>
> vs
>
> /* offset=3D5995059 */
> "lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS,
> L2_RQSTS.RFO_HIT + L2_RQSTS.RFO_MISS)\000\000L2 cache request for
> ownership (RFO) misses\000\000100%\000\000\000\000000"
> /* offset=3D5995217 */
> "lpm_l2_rfo_misses\000lpm_l2;lpm_l2_rfo\000d_ratio(L2_RQSTS.RFO_MISS,
> duration_time)\000\000L2 cache request for ownership (RFO) misses per
> second\000\0001misses/s\000\000\000\000000"
>
> That leads to non-reproducible binaries, even though the functionality
> is probably the same.

I agree non-reproducible builds are bad. The functionality should be
the same, the offsets exist only to avoid a gazillion C-string
constants that massively inflate the perf binary size which is about
75% string constants on x86. We don't want to relocate all those
strings when the perf binary loads.

I see the problem from your example. I wonder a more complete fix
would be something like:
```
   def __lt__(self, other):
     """Sort order."""
    if self.name !=3D other.name:
        return self.name < other.name
    if not self.expr.Equals(other.expr):
        return self.expr.ToPerfJson() < other.expr.ToPerfJson()
    return self.description < other.description
```
wdyt?

Thanks,
Ian

> Thanks,
> Nazar Kazakov
