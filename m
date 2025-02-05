Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2481E1DB363
	for <linux-perf-users@vger.kernel.org>; Wed,  5 Feb 2025 16:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738773314; cv=none; b=IS4UTX/G2GFdDhlbKcuuPAgYGiNdlFaSudSfjvEjoqV9mzMaeUnufH9CiVcOTbCGDviFZjHmmb2+2mIDgPkzyWB2ZxMuQK+6ol5TPTJ81kWSmE39opCvnV5ftS+rMKjDeA2nzSfYY34ubY2zxHIUIiwD6oMrINg8NK3BJrmaPTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738773314; c=relaxed/simple;
	bh=dvp1QCVxxQcqxWUgrzP1J6jShJ84IWNo4DvyPXhOUnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qb74475WRKXn1QRiKboieRfq1rbyciP6AEQBhrpJWRRngKZ+A/W0IhB+lrUJuCRQwArjh/fzkt8t1aL85rmuN9iP5OTqBfY50+gU9ra9+8LYPlEqXhky4s6WPD98+60EuruJwWcY9POTq0eZiHoUX9b/gEeWLB4Aq/OQUUg2hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyGzLloF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyGzLloF"
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3d04e5bd797so178835ab.1
        for <linux-perf-users@vger.kernel.org>; Wed, 05 Feb 2025 08:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738773312; x=1739378112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CeDW3SOPT0I7+guyMByE6uP86Z41s6fPZV6qcWyTgnI=;
        b=RyGzLloF9kIVcBWhCsnkVQBGQ41bihbdA8eLhEzHXenjAJAWsxgJhvVUbGMyRpW2ld
         xXo9b8UR9PQ+W/CbAgefTz/n6kRrbOsFN6b+Ln+4L3EUZEzBmfzjwnninQZ+FJ3uIijz
         c3161FMCXB4saBGecUv0gpXIzZSUvB/1uZV4vS+C3CzpqCvKypU0/VaBjhbSTWumwl+R
         avWgq2kcgDASsPg96FLa78tFoL+5Hd0nD73D7/1WGPwkDhiBMilIR3gCSTFIsPn2+CzF
         aBpfe0odas+IM8Iw9mM7VDjFrwru95ReTUJiUirDnTKusTeCIQ6kyCiGGkrBkDcVumDF
         jSPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738773312; x=1739378112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CeDW3SOPT0I7+guyMByE6uP86Z41s6fPZV6qcWyTgnI=;
        b=LxPja/jRFn0NKKELSl6ARqZDMy7KwLyU1+eE3WzmDWP7upirBHiAVDtsFb/KAAscXC
         t2YpmFT+c3fc3x1Scljx7HfczQvQNsTMEH89YbYEIeUj8ZuJUKV0pfdPTVsfhpcYaqw6
         9qrSe915mSNm7AGOrLM+o5UwdH2UpNHBFnO8+pbwDxqkuEoSCnVOsux6oYBnjmzFqkKG
         kp24RE51yM9bo4fScC1g6UyKizButTXrsGgfUWZVO5dum+FR8Y1gZI5uv3fZ1weAI8dO
         YWEdiPu6PqjOJgHOW0vELiR5hvMrt/hjkS0JBrKoA9PdkkG9H9JnZNbtjUTVvrPamPqa
         H4rg==
X-Forwarded-Encrypted: i=1; AJvYcCUaK4cZN87QZqlLY1VPl7cK8ep6gXiJvsizWzMMgeHsVsnwjy562OZ9C5Ie4VMA9RMFRvkjqYoLoie/Uh9IYozF@vger.kernel.org
X-Gm-Message-State: AOJu0YwftoN59hKMKlf1U9/U5FHdmNg2zhM09fJlLrLU/p3qg4KszK77
	FM1lkOzXG/93kLsyrppZTjn66A+J7GXbp73CvdvNxePXPoQp5qY84rIAi8yxeJCmZSEkwDUl6pE
	INjXXOQWn9SoLtroMsusXYog4QEH+LpIS81pi
X-Gm-Gg: ASbGncvEOvEF/7Jde4J4RAe2g4JV0bxMYz9PIsszmiraaxfbG7Ky4KNZECntzC7sihS
	ImgAK9sq48xNpjo9o5tYidSeYc+KcQl5qQPKTTQ7b25OLhl626xq8myUDB/C0L0xeZuDWC87d8D
	C3k5Pb9eFCtIczVKH8HlCkST2X
X-Google-Smtp-Source: AGHT+IF/1cvo8Gb+iy3C21tsS3O07s4tko4EtPhMOkFSCFs9t9K/CXygGAtFKu1l5fy6ofdFJnQ7W/55GFIwVZIjuhw=
X-Received: by 2002:a05:6e02:3c06:b0:3d0:507f:38dd with SMTP id
 e9e14a558f8ab-3d0507f3b50mr3538025ab.5.1738773311918; Wed, 05 Feb 2025
 08:35:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250204213259.127939-1-irogers@google.com> <CAP-5=fXpuND+kNe16CJMETkMOW+__eQpB8No0ra5gyEcfqCCKQ@mail.gmail.com>
 <d44036481022c27d83ce0faf8c7f77042baedb34.camel@intel.com>
 <CAP-5=fV8EcxVZR0Be6wb57_VvssE9FYFBTmbd415CqmidGWT7g@mail.gmail.com> <ca45ff5e-3d1a-4149-8efe-7615dd3581ff@linux.intel.com>
In-Reply-To: <ca45ff5e-3d1a-4149-8efe-7615dd3581ff@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 5 Feb 2025 08:35:00 -0800
X-Gm-Features: AWEUYZmYPCX1ExEW0FD8i7hkzrOSM3YXwFUPDROL1WGpdGtGQFKZ-hVUs5o_THc
Message-ID: <CAP-5=fW7gaskkJKnJcsfe0UO0V0wDsQaa-2NSNr3ho9urUeKBw@mail.gmail.com>
Subject: Re: [PATCH v4 00/23] Intel vendor events and TMA 5.01 metrics
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: "Falcon, Thomas" <thomas.falcon@intel.com>, "Baker, Edward" <edward.baker@intel.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, 
	"Biggers, Caleb" <caleb.biggers@intel.com>, "mpetlan@redhat.com" <mpetlan@redhat.com>, 
	"Taylor, Perry" <perry.taylor@intel.com>, "Hunter, Adrian" <adrian.hunter@intel.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "mingo@redhat.com" <mingo@redhat.com>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>, 
	"peterz@infradead.org" <peterz@infradead.org>, "Alt, Samantha" <samantha.alt@intel.com>, 
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "Wang, Weilin" <weilin.wang@intel.com>, 
	"acme@kernel.org" <acme@kernel.org>, "afaerber@suse.de" <afaerber@suse.de>, 
	"jolsa@kernel.org" <jolsa@kernel.org>, "namhyung@kernel.org" <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 7:47=E2=80=AFAM Liang, Kan <kan.liang@linux.intel.co=
m> wrote:
>
> On 2025-02-04 11:58 p.m., Ian Rogers wrote:
> > On Tue, Feb 4, 2025 at 8:28=E2=80=AFPM Falcon, Thomas <thomas.falcon@in=
tel.com> wrote:
> >>
> >> On Tue, 2025-02-04 at 13:35 -0800, Ian Rogers wrote:
> >>> On Tue, Feb 4, 2025 at 1:33=E2=80=AFPM Ian Rogers <irogers@google.com=
> wrote:
> >>>>
> >>>> Update the Intel vendor events to the latest.
> >>>> Update the metrics to TMA 5.01.
> >>>> Add Arrowlake and Clearwaterforest support.
> >>>> Add metrics for LNL and GNR.
> >>>> Address IIO uncore issue spotted on EMR, GRR, GNR, SPR and SRF.
> >>>>
> >>>> The perf json was generated using the script:
> >>>> https://github.com/intel/perfmon/blob/main/scripts/create_perf_json.=
py
> >>>> with the generated json being in:
> >>>> https://github.com/intel/perfmon/tree/main/scripts/perf
> >>>>
> >>>> Thanks to Perry Taylor <perry.taylor@intel.com>, Caleb Biggers
> >>>> <caleb.biggers@intel.com>, Edward Baker <edward.baker@intel.com>
> >>>> and
> >>>> Weilin Wang <weilin.wang@intel.com> for helping get this patch
> >>>> series
> >>>> together.
> >>>>
> >>>> v4: Fix TSC events on hybrid mistakenly specifying the core PMU
> >>>>     inhibiting the use of the msr PMU.
> >>>> v3: Fixes for hybrid metrics that were missing PMU. Update to the
> >>>>     latest events.
> >>>> v2: Fix hybrid and Co-authored-by tag issues reported by
> >>>>     Arnaldo. Updates to Lunarlake and Meteorlake events. Addition
> >>>> of
> >>>>     Clearwaterforest.
> >>>
> >>> Sorry, forgot to add Thomas again.
> >>> https://lore.kernel.org/lkml/20250204213259.127939-1-irogers@google.c=
om/
> >>
> >> Hi, I'm seeing some warnings like this and the all metrics test is
> >> skipped:
> >>
> >> Testing tma_info_inst_mix_iparith
> >> FP issues
> >> Cannot resolve IDs for tma_info_inst_mix_iparith:
> >> cpu_core@INST_RETIRED.ANY@ / (cpu_core@FP_ARITH_INST_RETIRED.SCALAR@ +
> >> cpu_core@FP_ARITH_INST_RETIRED.VECTOR@)
> >> Testing tma_info_inst_mix_iparith_avx128
> >> FP issues
> >> Cannot resolve IDs for tma_info_inst_mix_iparith_avx128:
> >> cpu_core@INST_RETIRED.ANY@ /
> >> (cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_DOUBLE@ +
> >> cpu_core@FP_ARITH_INST_RETIRED.128B_PACKED_SINGLE@)
> >> Testing tma_info_inst_mix_iparith_avx256
> >> FP issues
> >> Cannot resolve IDs for tma_info_inst_mix_iparith_avx256:
> >> cpu_core@INST_RETIRED.ANY@ /
> >> (cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_DOUBLE@ +
> >> cpu_core@FP_ARITH_INST_RETIRED.256B_PACKED_SINGLE@)
> >> Testing tma_info_inst_mix_iparith_scalar_dp
> >> FP issues
> >> Cannot resolve IDs for tma_info_inst_mix_iparith_scalar_dp:
> >> cpu_core@INST_RETIRED.ANY@ /
> >> cpu_core@FP_ARITH_INST_RETIRED.SCALAR_DOUBLE@
> >> Testing tma_info_inst_mix_iparith_scalar_sp
> >> FP issues
> >> Cannot resolve IDs for tma_info_inst_mix_iparith_scalar_sp:
> >> cpu_core@INST_RETIRED.ANY@ /
> >> cpu_core@FP_ARITH_INST_RETIRED.SCALAR_SINGLE@
> >
> > Thanks Tom, we've gone from a fail to skip - so progress! I think it
> > actually isn't something to worry about. These metrics are measuring
> > vector and floating point things. We run a workload, when testing the
> > metrics, that doesn't have floating point and vector operations. This
> > causes issues with metrics for these instructions as the counters
> > don't count anything. Because of this I added some logic to just skip
> > when we see these failures:
> > https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/tests/shell/stat_all_metrics.sh?h=3Dperf-tools-next#n51
> > but a better fix would be to have a workload with FP and AMX operations=
.
> >
> > You could test these metrics work manually, by running something like:
> > $ perf stat -M tma_info_inst_mix_iparith <benchmark>
> > where <benchmark> would need to contain FP or AMX instructions.
> >
>
> It should be OK to skip the "FP issues", but the "Cannot resolve IDs"
> seems a different issue.
>
> I found the similar error when I run perf stat on my Arrow Lake machine.
>
> $ sudo ./perf stat
> Cannot resolve IDs for tma_memory_bound: topdown\-mem\-bound /
> (topdown\-fe\-bound + topdown\-bad\-spec + topdown\-retiring +
> topdown\-be\-bound) + 0 * slots
>
> I think the warning is because perf doesn't find all the matched events.
> https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git/=
tree/tools/perf/util/metricgroup.c?h=3Dtmp.perf-tools-next#n326
>
>
> Then I go to check the event list of tma_memory_bound.
> For cpu_atom, it requires slots and topdown-mem-bound, which should be
> only available on p-core.
>
> +    {
> +        "BriefDescription": "This metric represents fraction of slots
> the Memory subsystem within the Backend was a bottleneck",
> +        "DefaultMetricgroupName": "TopdownL2",
> +        "MetricExpr": "topdown\\-mem\\-bound / (topdown\\-fe\\-bound +
> topdown\\-bad\\-spec + topdown\\-retiring + topdown\\-be\\-bound) + 0 *
> slots",
> +        "MetricGroup":
> "Backend;Default;Slots;TmaL2;TopdownL2;tma_L2_group;tma_backend_bound_gro=
up",
> +        "MetricName": "tma_memory_bound",
> +        "MetricThreshold": "tma_memory_bound > 0.2 & tma_backend_bound
> > 0.2",
> +        "MetricgroupNoGroup": "TopdownL2;Default",
> +        "PublicDescription": "This metric represents fraction of slots
> the Memory subsystem within the Backend was a bottleneck.  Memory Bound
> estimates fraction of slots where pipeline is likely stalled due to
> demand load or store instructions. This accounts mainly for (1)
> non-completed in-flight memory demand loads which coincides with
> execution units starvation; in addition to (2) cases where stores could
> impose backpressure on the pipeline when many of them get buffered at
> the same time (less common out of the two)",
> +        "ScaleUnit": "100%",
> +        "Unit": "cpu_atom"
> +    },
>
> I didn't check the tma_info_inst_mix_iparith which Thomas mentioned
> above yet. But I suspect it should be the same issue.
>
> The perf test may have to error out when the "Cannot resolve IDs"
> message is detected.

Agreed. I think I see the issue. We're adding the extra/Valkyrie
metrics to both core types during conversion, a quick fix is to just
skip doing this for atom. I'll cut a v4 with this.

Thanks,
Ian
