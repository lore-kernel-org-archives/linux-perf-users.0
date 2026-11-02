Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793663601;
	b=bCzqxX1gvFOJ8YfC4rqzlmW/NmdvttVfwbulijxLyGo4g02H8EHZWaCWHHjpbQaaYWnO
	 UgFHT9Yd+6ZCjijXENbciWiLO4g6GD6G/wKCYc69Sktu3JgtDzOW0YWt8C4cNmHGq6e0N
	 yb+Wfbonat6WiVrK1kYdnU12Vl1Bgfr170rU/wPodTTMDf4EaeQzpxEfLLU8jEHO0LxJ7
	 8pAIaQ8akSI1Lko9YSAlmFwH3ZkPr3Z+cpo2B3C94lnmasiC58Wp6TFd4OOgK+yhqe/VV
	 PDuMSeU0fzCzCA1Eqdf5RXM1kYkMeP2iIqdvQJ9Jap7uNUSCbqVtrrGEi9iiiZd/f/A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663601;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y6R/7JiyY+QNpdkHpLxoucL3TEKilfqNsAl22fI4rCc=;
	b=hiP3B57ioHwZ4RxBvJU6qVPYXwb5Zx9Qp+ddbEe4vDxntVAUeoKQrrFVD9lbynn0X86K
	 +4kBgCad3nAxe0VHhJ4QaNr5aXmFbH5HpG16nG3dKy9giSuYTJdrX2NBy/KRDVJJApYcS
	 9CQAEjY/gD6LocrzgFKg6NeoUw9n7ugJLs6lTBmGMDpBKNnE4w513/HcBL3oMZSkTLwrD
	 tWRK4keGE6UXag8LDql4UE94NBEJu4iSHE0AWACWe8Jce9rxfWFUI9/nWID8s8PfDQEn/
	 je/GJ4qfee+TgBBhoSeAcRyNTmEcw6J2DhEZO5zq/ANp8+JNUQDFxVIihFt+TAVQtWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LWInwadQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304FB606A326
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Nov 2026 23:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 304FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=LWInwadQ
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5383c97c8cfso38511cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Nov 2026 15:53:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793663600; cv=none;
        d=google.com; s=arc-20260327;
        b=VOwWK2VfsfaHqN6WhBQrbls6Qu61led96tUu4apO96K7pebxsFssdpYj1RohyFm4Sg
         wjvhstXLJw+Fjh5dUtvsgIjn/PtgOAiUDXFf9Mv3pDU9FekriAJD7JLak4XvRNCu9Kh5
         EOXMiccw/Z4y+cDvFOCrD4c4WsGXgBDYIgSY/QD9KJGuKhTLaSRg+xE56yTwF4CRRxjn
         yQ+GW7b6oU2gKk2IDkVs2I5xcmo4DvJRn/MqALcULG4f1jafCdCqyZUyjUT/A5SgQjeG
         CbfLwp/SuXCPwnDSZeM1Cu0igLWZyqad44Mr9bFztgeWlFPKRB7xvrA4+7xvkRhJz049
         mR0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y6R/7JiyY+QNpdkHpLxoucL3TEKilfqNsAl22fI4rCc=;
        fh=pwl8d2v9SDRBhaSVFxeLqeu9tvrD887P+B+hiyugI3k=;
        b=KeRMGVyqMWtzmPMlmy7U9HIQgquSNmYBrpyeWbKEioJJtBhWQaZrHwOpEsRn0f1u84
         mCM3lONejAou7b+gp6TdW0qemoisJmQSzzsHDYCZ2RVUeKp5hTcXCatRzg8GtyWhCHnH
         xu71UM5BO8XEa6g7CJ3JaZV1jMLA789FsxhrP0+rdmpAGamQoaiYDjfSMfN57WddQJga
         G7D0l1j3uEt1YwXD1IblZtWCsCgnZXUnf8Gvs3pQdYUZU6UUlKQehQGJYR9bl0v7hBTX
         PeRDCR73tkZMNyd0/vabI0Ldk6T+ANLNn9nrP8dAljJ5fEjliQNeK6r6/3iTFfBem9no
         4r3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793663600; x=1794268400; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y6R/7JiyY+QNpdkHpLxoucL3TEKilfqNsAl22fI4rCc=;
        b=LWInwadQSl92S4+jocVul9v4ws1MfhzZfGmblCxS1OopQQQjACkzJA6lAnQJDRwDTy
         nDt7MxK7yKAtE5gjcSoDr/hJ3CPopHj1yV0lgw8XVXJQoeW2pp9UdvvCSLpKiGnZCFk1
         FyHEXbbHMBuPZIkenZryEFDvECc/G5oqKYMvC3nV6qjEenC+80xSQplwvfKbNrL53sdH
         Dcj6txqU6D7uzRClo+/IoADkCX6FiKW/mWXzXACUQuSAMvcP5a0DbhUyHGWFALaa7dCZ
         b8TaIdFkkT3561AgTAIr58r9mJ3j3ULpnmuf035cfn0OEmnP1OoY1Y8XYMEcpWMSrnty
         z8TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793663600; x=1794268400;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y6R/7JiyY+QNpdkHpLxoucL3TEKilfqNsAl22fI4rCc=;
        b=cD8GuOfmf2FHGAf8T1saFzc89ZN8nFV76ln+CN8gFBuGjLY9o9UHhUBT5uQkjEfeYG
         iZvm2AJcVJph02XJMdCFM813F49yjLvpJj8TLGRmDN7orSkwmxTAHqL9Z3xkF1vMoXxB
         efQd8o8GSeyNV8kLC0rN4hTINoKELH67cColBHvBsAbWDLBJH2GwE3tr+6fNMgbqOpNS
         i4r2i8JgbkOERzPvgratX8qcKrGOQlLORyKdK6Xl2AvnrcXGuw8C85/Hx3KN8Aatpil0
         STUc2IBpItdnTpmLTSezVlMTeZisUCVX/OcKTyMnuuQ0scTVg38GhdWdOarAAz8WZnb4
         s0AA==
X-Forwarded-Encrypted: i=1; AKwUvBwuAcqzKJ6phDDA8HC65o5E8aQ0wx4/FC1FF6kC+TlDteUUSCrxXRiJ5vHJh5U5yy9DkY4bACI8Bf2pQwpWDSMQ@vger.kernel.org
X-Gm-Message-State: AFq9FYJyIecAcW4UYBUASWZU5MHlaOw/01LU2XVU+iTw33oNxopORown
	Gmpnp3O/dAJ1erFUAiErXyiBLNsfncyKlStDt7HYOzLe4tcwcmedDADK1A+rsi7fbrnVpxCrqWp
	MCW4Zc7ppVRfkI2IKB8BBQcUZYlWqW6jtdW5RXe7c
X-Gm-Gg: AYBFou2N7kBQjt299+ecphyteOfVDyAQXMSt7DJMXRLLPGZ7JKhdtNaS2WcyVA+E475
	aiRkRc9RlbCz6pqg3ir2ojShcfLaJeThM03SKTExeDWeJqKL1P5XBXyvpyGUgbSnsNB57G042mU
	dNweVCQ9aGSmFXLI+/A3c02YrM2iCmHjbWHo4S0e/nVUEXBUnme2D65eAV01KJM7/f/dKBEAwpM
	c/D+IJ+bfT+4CtZurLjdPn2cCcyXaNdhh0A0ElNkWRQbyBIkemPhMd5t1acVEtfIdCrLxLbabGM
	yHJ6K1PMKtCDiomlz/zf7zalP1QvUyihd4U09ZL9pbRXMsArZjSJs/lw9yagqMyEluyPjEWCIK6
	q9AxagZId1/uXFCanOqUhBS7swaeIie64fTocFw==
X-Received: by 2002:a05:622a:1c11:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-549b675d2f3mr2787571cf.0.1793663599242; Mon, 02 Nov 2026
 15:53:19 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030174816.1544471-1-bwicaksono@nvidia.com>
 <CAP-5=fUEmNrREh-ipxYMiStr5xCakGDBZW8OmAj1rhACs8qaZw@mail.gmail.com>
 <SA1PR12MB6773B13BD3EB2B60FBED6013A06D2@SA1PR12MB6773.namprd12.prod.outlook.com>
 <CAP-5=fWJn=Fws6ew_HCsxVo6Bcqvvgn-8g=21+nvoEHA5GhLKA@mail.gmail.com> <SA1PR12MB6773A9E13CCFD7322501EE0BA06A2@SA1PR12MB6773.namprd12.prod.outlook.com>
In-Reply-To: <SA1PR12MB6773A9E13CCFD7322501EE0BA06A2@SA1PR12MB6773.namprd12.prod.outlook.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 2 Nov 2026 15:53:07 -0800
X-Gm-Features: AclHuK9AmugvMqLXDCOPc8pKZIzILBtJSEV_O6t_Xr6tdxsqP1qTjRrJzqawtBs
Message-ID: <CAP-5=fWKC7GD43BebLd_nP+TM87aS0fBKg2o=q-C156tAgCLGQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] perf: Add NVIDIA Tegra410 uncore PMU events and metrics
To: Besar Wicaksono <bwicaksono@nvidia.com>
Cc: Will Deacon <will@kernel.org>, "acme@kernel.org" <acme@kernel.org>, 
	"namhyung@kernel.org" <namhyung@kernel.org>, "ctshao@google.com" <ctshao@google.com>, 
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vikram Sethi <vsethi@nvidia.com>, 
	Rich Wiley <rwiley@nvidia.com>, Sean Kelley <skelley@nvidia.com>, Matt Ochs <mochs@nvidia.com>, 
	Raj Joshi <rajjoshi@nvidia.com>, Thierry Reding <treding@nvidia.com>, 
	Jon Hunter <jonathanh@nvidia.com>, "john.garry@linux.dev" <john.garry@linux.dev>, 
	"james.clark@linaro.org" <james.clark@linaro.org>, "mike.leach@arm.com" <mike.leach@arm.com>, 
	"leo.yan@linux.dev" <leo.yan@linux.dev>, "mark.rutland@arm.com" <mark.rutland@arm.com>, 
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>, "jolsa@kernel.org" <jolsa@kernel.org>, 
	"adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 3:08=E2=80=AFPM Besar Wicaksono <bwicaksono@nvidia.c=
om> wrote:
>
> > -----Original Message-----
> > From: Ian Rogers <irogers@google.com>
> > Sent: Saturday, October 31, 2026 4:18 AM
> > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > Cc: Will Deacon <will@kernel.org>; acme@kernel.org;
> > namhyung@kernel.org; ctshao@google.com; linux-tegra@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-perf-users@vger.kernel.org;
> > linux-kernel@vger.kernel.org; Vikram Sethi <vsethi@nvidia.com>; Rich Wi=
ley
> > <rwiley@nvidia.com>; Sean Kelley <skelley@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Raj Joshi <rajjoshi@nvidia.com>; Thierry Reding
> > <treding@nvidia.com>; Jon Hunter <jonathanh@nvidia.com>;
> > john.garry@linux.dev; james.clark@linaro.org; mike.leach@arm.com;
> > leo.yan@linux.dev; mark.rutland@arm.com;
> > alexander.shishkin@linux.intel.com; jolsa@kernel.org;
> > adrian.hunter@intel.com
> > Subject: Re: [PATCH v2 0/9] perf: Add NVIDIA Tegra410 uncore PMU events
> > and metrics
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Fri, Oct 30, 2026 at 3:19=E2=80=AFPM Besar Wicaksono
> > <bwicaksono@nvidia.com> wrote:
> > >
> > > > -----Original Message-----
> > > > From: Ian Rogers <irogers@google.com>
> > > > Sent: Friday, October 30, 2026 6:07 PM
> > > > To: Besar Wicaksono <bwicaksono@nvidia.com>
> > > > Cc: acme@kernel.org; namhyung@kernel.org; ctshao@google.com;
> > linux-
> > > > tegra@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-=
perf-
> > > > users@vger.kernel.org; linux-kernel@vger.kernel.org; Vikram Sethi
> > > > <vsethi@nvidia.com>; Rich Wiley <rwiley@nvidia.com>; Sean Kelley
> > > > <skelley@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Raj Joshi
> > > > <rajjoshi@nvidia.com>; Thierry Reding <treding@nvidia.com>; Jon
> > Hunter
> > > > <jonathanh@nvidia.com>; john.garry@linux.dev; will@kernel.org;
> > > > james.clark@linaro.org; mike.leach@arm.com; leo.yan@linux.dev;
> > > > mark.rutland@arm.com; alexander.shishkin@linux.intel.com;
> > > > jolsa@kernel.org; adrian.hunter@intel.com
> > > > Subject: Re: [PATCH v2 0/9] perf: Add NVIDIA Tegra410 uncore PMU
> > events
> > > > and metrics
> > > >
> > > > External email: Use caution opening links or attachments
> > > >
> > > >
> > > > On Fri, Oct 30, 2026 at 10:49=E2=80=AFAM Besar Wicaksono
> > > > <bwicaksono@nvidia.com> wrote:
> > > > >
> > > > > Add event aliases and derived metrics for the NVIDIA Tegra410 unc=
ore
> > > > > PMUs, and fix perf's aggregation of PMU instances that are number=
ed
> > in
> > > > > more than one parts in their name.
> > > > >
> > > > > The series covers the UCF, PCIe, PCIe target, CPU memory latency,=
 and
> > > > > chip-to-chip interconnect PMUs. It provides symbolic names for th=
e
> > raw
> > > > > event encodings and metrics for bandwidth, frequency, and average
> > read
> > > > > latency.
> > > > >
> > > > > The PCIe and PCIe target PMUs are named
> > > > nvidia_pcie_pmu_<socket>_rc_<rc>
> > > > > and nvidia_pcie_tgt_pmu_<socket>_rc_<rc>. Their json Unit uses th=
e
> > > > > existing comma-separated form ("nvidia_pcie_pmu_,rc_"), but perf
> > only
> > > > > merged instances that differ in the trailing number, so these eve=
nts and
> > > > > metrics gave one result per socket and were reported incorrectly =
(e.g.
> > > > > with --metric-only), as discussed in v1. Patches 6-9 fix this:
> > > > >
> > > > > - Patch 6 adds a check of the cpumasks of all merged PMU instance=
s to
> > the
> > > > >   zero-count skip in perf stat, so a socket that counts nothing s=
hows 0
> > > > >   instead of having its row hidden.
> > > > > - Patch 7 merges PMU instances that match the same comma-
> > separated
> > > > json
> > > > >   Unit. This also applies to the HiSilicon hisi_sccl PMUs, which =
use the
> > > > >   same json form; not tested on HiSilicon hardware.
> > > > > - Patch 8 labels a merged uncore counter after all of its PMUs, e=
.g.
> > > > >   nvidia_pcie_pmu_*_rc_*/cycles/ or nvidia_ucf_pmu/cycles/, inste=
ad
> > of
> > > > >   after the first instance, such as nvidia_pcie_pmu_0_rc_0/cycles=
/.
> > > > >   Output with --no-aggr is unchanged.
> > > > > - Patch 9 describes these PMU names in the ABI document.
> > > > >
> > > > > Changes in v2:
> > > > > - Move the uncore JSON out of the sys directory and remove the
> > > > >   "Compat" fields. Thanks to Ian Rogers for the feedback.
> > > > > - Drop "perf jevents: Process model files before sys subdirectori=
es",
> > > > >   which this series no longer needs.
> > > > > - Add UCF SLC and memory bandwidth metrics from all sources to lo=
cal
> > > > >   CMEM (read, write and read+write) and from local sources to loc=
al
> > > > >   CMEM and to remote memory, PCIe bandwidth metrics to local
> > > > >   destinations, and read+write bandwidth metrics for UCF SLC, UCF
> > > > >   memory and PCIe. Thanks to Chun-Tse Shao for the suggestion.
> > > > > - Add patches 6-9 to fix the PCIe instance aggregation. Thanks to=
 Ian
> > > > >   Rogers and Chun-Tse Shao for the pointers.
> > > > >
> > > > > v1: https://lore.kernel.org/all/20261019164241.403644-1-
> > > > bwicaksono@nvidia.com/
> > > >
> > > > Why don't we look to fix code in drivers/perf? This series introduc=
es
> > > > PMU instances, overloads the meaning of aliases, and a bunch of oth=
er
> > > > silly complexity due to poor reviews and maintenance of drivers/per=
f -
> > > > specifically by not pointing out the ABI issues. Isn't this a
> > > > straightforward, whoops we did a bad suffix and here's the patch to
> > > > rename our PMU in the driver? Throwing more complexity at the
> > problem
> > > > doesn't feel like the right fix.
> > >
> > > Hi Ian,
> > >
> > > My apologies for the names not following perf's PMU naming convention=
.
> > > I will be more careful about this in future.
> > >
> > > These names (nvidia_pcie_pmu_<socket>_rc_<root complex> and
> > > nvidia_pcie_tgt_pmu_<socket>_rc_<root complex>) have been upstream
> > > since v7.1, and several customers already rely on them. Renaming them=
 in
> > > the driver would break their use case.
> >
> > It only breaks their use case if they name the PMU with an event. You
> > have multiple naming conventions for the PMU and only those involving
> > multiple sockets have a broken suffix.
> >
>
> Naming the PMU in the event is currently the main way to use the PCIE PMU=
s,
> which we can't break.
>
> > > Given that, what would you suggest as the next step? Would handling
> > these
> > > names in perf, as in patch 7 and 8, be reasonable, or do you have ano=
ther
> > > approach in mind?
> >
> > So we don't need a new abstraction, I've been reducing aggregation
> > abstractions in the perf tool. As I pointed to previously, the suffix
> > is computed with pmu_name_len_no_suffix:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> > next.git/tree/tools/perf/util/pmus.c?h=3Dperf-tools-next#n66
> > So you can do something like (untested):
> > ```
> > size_t pmu_name_len_no_suffix(const char *str)
> > {
> >   if (strstarts(str, "nvidia_") && strstr(str, "_rc_")) {
> >     // nvidia PMU with a non-ABI suffix of nvidia_..._[0-9]+_rc_[0-9]+
> >     const char *p =3D str + strlen(str);
> >     int n =3D 3;
> >     while(p > str && n > 0) {
> >        if (*p-- =3D=3D '_')
> >           n--
> >      }
> >      return p - str;
> >   }
> >   // The rest of the existing pmu_name_len_no_suffix code.
> >   ...
> > }
> > ```
>
> Thanks for the suggestion. I can replace the changes in patch 7 and 8
> with NVIDIA PCIE RC specific check in pmu_name_len_no_suffix().
>
> While trying it, I noticed two side effects:
> 1. perf list now combines the nvidia_pcie_pmu_<socket>_rc_<rc> PMUs and
>    shows their events as nvidia_pcie_pmu/<event>/, but "perf stat" doesn'=
t
>    accept just "nvidia_pcie_pmu" on the command line, e.g.
>    "perf stat -e nvidia_pcie_pmu/rd_req/" can't find the PMU.
> 2. After fixing no.1, "perf stat -A -a  -e nvidia_pcie_pmu/rd_req/"
>    lists the result in sysfs directory order. On my system, it gives the
>    result for RC 0, 5, 3, 1, 4, 2.
>
> Both look like they can be handled with a similar NVIDIA specific check
> in perf_pmu__match_wildcard() and pmu_name_cmp():
>
> /* perf_pmu__match_wildcard() */
> if (strstarts(pmu_name, "nvidia") && strstr(pmu_name, "_rc_")) {
>         /* NVIDIA PMU with a non-ABI suffix of nvidia_..._[0-9]+_rc_[0-9]=
+. */
>         if (tok_len =3D=3D pmu_name_len_no_suffix(pmu_name) && !strncmp(p=
mu_name, tok, tok_len))
>                 return true;
> }
>
> /* pmu_name_cmp()*/
> if (lhs_num =3D=3D rhs_num && strstarts(lhs_pmu_name, "nvidia")) {
>         /*
>          * NVIDIA PMU with a non-ABI suffix of nvidia_..._[0-9]+_rc_[0-9]=
+:
>          * compare the RC too.
>          */
>         const char *lhs_rc =3D strstr(lhs_pmu_name, "_rc_");
>         const char *rhs_rc =3D strstr(rhs_pmu_name, "_rc_");
>         if (lhs_rc && rhs_rc) {
>                 lhs_num =3D strtoull(lhs_rc + 4, NULL, 10);
>                 rhs_num =3D strtoull(rhs_rc + 4, NULL, 10);
>         }
> }
>
> What do you think about these additional changes?

Sounds good to me. I really hate we didn't fix cycles -> cpu_cycles
and instead have to carry:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/builtin-record.c?id=3Dc5a244bf17caf2de22f9e100832b75f72b3=
1d3e6#n1389
given the other event is called bus_cycles and the documentation
literally calls the event CPU cycles (and Linus wants `perf record -e
cycles` not to complain).

Things in Linux do get fixed over time. For example, PMU devices in
/sys/devices/ will one day disappear and only be accessible under
/sys/bus/event_source/devices . Given the PMU name only appeared in
January IIRC, it hasn't appeared in an LTS Linux release yet. So, yes,
someone running a non-LTS kernel on a dual socket machine and using
the PMU name in the event name would be impacted by renaming the PMU.
The pain I feel about that will be momentary, while carrying around
NVIDIA non-ABI specific PMU suffix code will be long lasting.

Thanks,
Ian

> Regards,
> Besar
>
> > I'd much rather we didn't add bespoke behavior to the tool for every
> > new PMU. This happened previously when PMUs were merged in
> > drivers/perf with hex instead of numeric suffixes. We already handle
> > certain PMUs specially due to their lack of hotplug support:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> > next.git/tree/tools/perf/arch/arm/util/pmu.c?h=3Dperf-tools-next#n41
> > And due to event name fiascos:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-
> > next.git/tree/tools/perf/builtin-record.c?h=3Dperf-tools-next#n1395
> > At some point, perf's internals become so forked due to mismatched
> > conventions that every code path will have a variant. This saddens me
> > as something that we've much improved this year is being able to say
> > `perf stat record` on one machine type and then `perf stat report` on
> > another.
> >
> > Thanks,
> > Ian
> >
> > > Will, do you have any comment on this?
> > >
> > > Thanks,
> > > Besar
> > >
> > > >
> > > > Thanks,
> > > > Ian
> > > >
> > > > > Besar Wicaksono (9):
> > > > >   perf jevents: Add support for NVIDIA Tegra410 UCF PMU aliasing
> > > > >   perf jevents: Add support for NVIDIA Tegra410 PCIE PMU aliasing
> > > > >   perf jevents: Add support for NVIDIA Tegra410 PCIE-TGT PMU alia=
sing
> > > > >   perf jevents: Add support for NVIDIA Tegra410 CPU Memory Latenc=
y
> > > > PMU
> > > > >     aliasing
> > > > >   perf jevents: Add support for NVIDIA Tegra410 C2C PMU aliasing
> > > > >   perf stat: Check merged PMU instance's cpumasks when skipping z=
ero
> > > > >     counts
> > > > >   perf pmu: Merge PMU instances that match the same comma-
> > separated
> > > > json
> > > > >     Unit
> > > > >   perf evsel: Name a merged uncore counter after all of its PMUs
> > > > >   perf Documentation: Describe PMU names numbered in more than
> > one
> > > > place
> > > > >
> > > > >  .../testing/sysfs-bus-event_source-devices    |  14 +
> > > > >  .../arm64/nvidia/t410/uncore-cpu_mem.json     |  43 +
> > > > >  .../arm64/nvidia/t410/uncore-nvclink.json     |  67 ++
> > > > >  .../arm64/nvidia/t410/uncore-nvdlink.json     |  43 +
> > > > >  .../arm64/nvidia/t410/uncore-nvlink_c2c.json  | 115 +++
> > > > >  .../arch/arm64/nvidia/t410/uncore-pcie.json   | 249 ++++++
> > > > >  .../arm64/nvidia/t410/uncore-pcie_tgt.json    |  83 ++
> > > > >  .../arch/arm64/nvidia/t410/uncore-ucf.json    | 764
> > > > ++++++++++++++++++
> > > > >  tools/perf/tests/pmu.c                        | 134 +++
> > > > >  tools/perf/util/evlist.c                      |   2 +-
> > > > >  tools/perf/util/evsel.c                       |  83 +-
> > > > >  tools/perf/util/evsel.h                       |   2 +-
> > > > >  tools/perf/util/parse-events.c                |   2 +-
> > > > >  tools/perf/util/pmu.c                         |  65 ++
> > > > >  tools/perf/util/pmu.h                         |   9 +
> > > > >  tools/perf/util/pmus.c                        |  47 ++
> > > > >  tools/perf/util/pmus.h                        |   1 +
> > > > >  tools/perf/util/stat-display.c                |  20 +
> > > > >  18 files changed, 1737 insertions(+), 6 deletions(-)
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-cpu_mem.json
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-nvclink.json
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-nvdlink.json
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-nvlink_c2c.json
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-pcie.json
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-pcie_tgt.json
> > > > >  create mode 100644 tools/perf/pmu-
> > > > events/arch/arm64/nvidia/t410/uncore-ucf.json
> > > > >
> > > > > --
> > > > > 2.43.0
> > > > >
