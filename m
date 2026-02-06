Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AF1F2B8D
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Feb 2026 00:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337573; cv=pass; b=SnSHX88oe2GzuycQTBfPmPCBm2nNlLBL+mOGoD3dd232hlR+N5TvmRVpMWBqnchYG75CnehdQ09owQtrHxOzWj7aqU4GtKNMqsUSx3t3MvEOIBBvj0VSj6jXw3EcHaWLDrR94HM9bqQJ0UQ5obeFP3JRAd6KznUxaJVMSClNRkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337573; c=relaxed/simple;
	bh=DB/tTNiYw/PQy/EDv/YZ/4pnWNvOkCG2uT0Pza6FE4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dz4kUgZyLOj1NDJ0cLIyiBuNEXL1zyXsHwDEp2lJM/o69732G/xCIVvllI71Hq6vPTmVnmepA7VFFqWEqlzj7NKGbPKhJnusUp1kg6bms0k+daBtJtZ8GAIhGHCXiln2WtlanIVq4FFxOuDZn9Uidwav2CucRWyM7n+BXI4eRwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z080XlWW; arc=pass smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z080XlWW"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8887ac841e2so13585876d6.2
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Feb 2026 16:26:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770337572; cv=none;
        d=google.com; s=arc-20240605;
        b=atBgBEkFPVJ+PDyrf3XJWgoHIi4WJ2yig/z3PgWQbSGBSsBt3FPfSucyy4ShpKK81E
         MVusSibBowdbR3BPFmgkDE9QYCltXMT0m9s+2neTWq9FozIanvrMXPsb0QeHCJzR15cz
         T1iFyWsqwvt/EOcvYT18dxfB7oBRx9/L3kcVZ/cnKmukOG0j/d1xcFsL0xxSh9Wkjm3H
         YktCQKYujC2aS3leqWzIAPEeiejAryxcONiNomQP83nE+nWhYNpjQ+N9jtZ2YwKPrkwF
         iluHHAobt0D5WKyEFw99G4qz80L8BZhBqkaZTjK8B8Q50OZIOhR8z9NmNyN+F6h+cfZn
         6MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2OblqpYKjvt5f7zVuxg7jeqmjmC/oQ3f6pybBMg5PE=;
        fh=Z5BIHi0OfeILgIfB+EAmnvLj2HUp7ZHXkXJyTzPIEQ0=;
        b=R80zGo/qFEiIy0aku98KUAGbvuHNy65Lf7KOSWPDf8dhZCqXwwonbb5CLow9CSZr72
         4y0JyktvMEUjnmvv+yM224uXYV/xa7PaUXGTMeTY9sEFnQVAFFp6Ln1z26g0UZJOqYTm
         S0G8ad0mOZMrg7KfhnGTLakPmfWBd6+VvJssVM2YevFXqpj81Sb6TNugu18wxpwWI8pe
         WaqORURFBP118nJFqhYRNnpnY5rybmbk0sSbmtvKKrf3U8h8gYMHf8DMfnAiQ4u2n/Ca
         E8h+3Z4GHu7ByORRhCMisXVKYFwgwjUXhroU/6sctD46TTNXD0GYVpYwm9PpIjMUW2pI
         hXkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770337572; x=1770942372; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2OblqpYKjvt5f7zVuxg7jeqmjmC/oQ3f6pybBMg5PE=;
        b=z080XlWWh50S9p+uq21Q8DkxIYgkJShzZbE64gnaX7JGIqdFKPMI984K+zyFBuyin4
         1b/mU78sVRIs5zvIwMQmurUs52GKsAhdPvJ9PR1B0c6wdR9SkXltPxwqNdxtEd62NSE0
         ZoYMNAmDFY+CU6m813QmCOdRk8iO7ts9rZHDx0o6aabXolINKbaP1UprPGA3onkp438B
         C7hlt9AzEZFewXikT/C3hnhemLCAD3hBBRcBcq/SG6JLnsw/7ysf7KX3m/O8StDuxeOX
         wbaKWbXhbuPWGcz8F8gk69JLb7qCnt8KL0r0SJakBJQkLJKSpxSWUOoqI5ObN3XCv9qK
         XcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770337572; x=1770942372;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W2OblqpYKjvt5f7zVuxg7jeqmjmC/oQ3f6pybBMg5PE=;
        b=j40VGE+ggp02Mmk1wqBRJktpj1JRVovDML4KocXtrDw0C15wR8ttkYcOyNKHVuldPg
         EbOzOBDS27qQOcuFR122Z9Py/Va/Hq+RY4QSz96kyoae6LULLcIspl1LPHN7wcHF1fQN
         JBr87PQqqGvvgX03Gji1+oIlVsdR7efdUhNhmjTQWBJyTey8jb9el+cet+oXbpoa06+6
         WyTQWVU30gQlhaJPAP0i8PyuPa0M6ZbG1DSFQi5klFjHai2dsbyXlIKAdSu+JSaNnTPb
         nmJzGDEHEaSgFOcI8BQ/cx553ErRGlF5MKzRNXyY9NKhUTAzRN95+LmvZYhplw6/lfJU
         lDXQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9smoGAaJOQcPGQRBXpjRIwQYM8vNd9wN3EsJ3NcgcosSnSjHrp8KhHs3w9rZXHeb2dUqRgQJfGEXXs/Ar5Pwz@vger.kernel.org
X-Gm-Message-State: AOJu0YwXSORaenIilewLUO7Dt+u+VOwobBLVELkYdKtLvK+j2XQcybO8
	/Wh87uKbDCGSJquhWkMPtOHDoz645yfGKzmNYFKQf+TbVfMhyHqsxI54jX1TLs7NDKVqXjFB3hl
	xkaUISmQPkxnnlwi1NiHYgtspkZeTZRpOLEruDpRC
X-Gm-Gg: AZuq6aLpewUsYOqtE5QTo6jOcx0j5d0IWXLUjq5Sz7HicthM5ex2P/6GvJx3v5XlvNQ
	3q12K1obELD/f2dHuY7LeiHoarfw1wzPdx1w1KJcVdeSvKLo40jpPjKTs9MuZ8bnNDTh9RMCRVS
	kpIZGbVN4twsW98Y88QBuGNq6nNR8qA4XcVYI9QPohTMsJ57nzq+CNUgcBTrp+K3cuQDyqOM+4E
	XSar+AJKDcfhlMWRoBd6qmZ3XCnj+hquPFkIBV6BEHkyvuPmoUV84QznZT5EZxT3TN2QVDAJoaD
	MSgL1Rqk1zGntZX4nbj4bdmC5g==
X-Received: by 2002:a05:6214:e66:b0:895:3a2c:5298 with SMTP id
 6a1803df08f44-8953cd9a351mr14874686d6.45.1770337571756; Thu, 05 Feb 2026
 16:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231224233.113839-1-zide.chen@intel.com> <20251231224233.113839-9-zide.chen@intel.com>
 <4f62ecc3-b47c-4c9f-9189-1159e8e9be8a@linux.intel.com>
In-Reply-To: <4f62ecc3-b47c-4c9f-9189-1159e8e9be8a@linux.intel.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Thu, 5 Feb 2026 16:26:01 -0800
X-Gm-Features: AZwV_QguCrIcaec_nWyGm16HbLI-rAROSIZz_xRROzJhN_8FcsBTMW1aE2fr2B0
Message-ID: <CAJpZYjWBWFx2ac=jYRJf-GEpenBZ14a6JpAhY6CE1kUXyVUVJw@mail.gmail.com>
Subject: Re: [PATCH V2 08/13] perf/x86/intel/uncore: Support IIO free-running
 counters on DMR
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Zide Chen <zide.chen@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Xudong Hao <xudong.hao@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 3, 2026 at 6:31=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel.c=
om> wrote:
>
>
> On 1/1/2026 6:42 AM, Zide Chen wrote:
> > The free-running counters for IIO uncore blocks on Diamond Rapids are
> > similar to Sapphire Rapids IMC freecounters, with the following
> > differences:
> >
> > - The counters are MMIO based.
> > - Only a subset of IP blocks implement free-running counters:
> >   HIOP0 (IP Base Addr: 2E7000h)
> >   HIOP1 (IP Base Addr: 2EF000h)
> >   HIOP3 (IP Base Addr: 2FF000h)
> >   HIOP4 (IP Base Addr: 307000h)
> > - IMH2 (Secondary IMH) does not provide free-running counters.
> >
> > Signed-off-by: Zide Chen <zide.chen@intel.com>
> > ---
> > V2:
> > - Remove pr_warn() from dmr_uncore_freerunning_init_box().
> >
> >  arch/x86/events/intel/uncore_snbep.c | 118 +++++++++++++++++++++++++--
> >  1 file changed, 113 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/int=
el/uncore_snbep.c
> > index 09a3bdbd188a..28bcccf5cdfe 100644
> > --- a/arch/x86/events/intel/uncore_snbep.c
> > +++ b/arch/x86/events/intel/uncore_snbep.c
> > @@ -472,10 +472,14 @@
> >  #define SPR_C0_MSR_PMON_BOX_FILTER0          0x200e
> >
> >  /* DMR */
> > +#define DMR_IMH1_HIOP_MMIO_BASE                      0x1ffff6ae7000
> > +#define DMR_HIOP_MMIO_SIZE                   0x8000
> >  #define DMR_CXLCM_EVENT_MASK_EXT             0xf
> >  #define DMR_HAMVF_EVENT_MASK_EXT             0xffffffff
> >  #define DMR_PCIE4_EVENT_MASK_EXT             0xffffff
> >
> > +#define UNCORE_DMR_ITC                               0x30
> > +
> >  #define DMR_IMC_PMON_FIXED_CTR                       0x18
> >  #define DMR_IMC_PMON_FIXED_CTL                       0x10
> >
> > @@ -6442,7 +6446,11 @@ static int uncore_type_max_boxes(struct intel_un=
core_type **types,
> >       for (node =3D rb_first(type->boxes); node; node =3D rb_next(node)=
) {
> >               unit =3D rb_entry(node, struct intel_uncore_discovery_uni=
t, node);
> >
> > -             if (unit->id > max)
> > +             /*
> > +              * on DMR IMH2, the unit id starts from 0x8000,
> > +              * and we don't need to count it.
> > +              */
> > +             if ((unit->id > max) && (unit->id < 0x8000))
> >                       max =3D unit->id;
> >       }
> >       return max + 1;
> > @@ -6930,6 +6938,101 @@ int dmr_uncore_cbb_units_ignore[] =3D {
> >       UNCORE_IGNORE_END
> >  };
> >
> > +static unsigned int dmr_iio_freerunning_box_offsets[] =3D {
> > +     0x0, 0x8000, 0x18000, 0x20000
> > +};
> > +
> > +static void dmr_uncore_freerunning_init_box(struct intel_uncore_box *b=
ox)
> > +{
> > +     struct intel_uncore_type *type =3D box->pmu->type;
> > +     u64 mmio_base;
> > +
> > +     if (box->pmu->pmu_idx >=3D type->num_boxes)
> > +             return;
> > +
> > +     mmio_base =3D DMR_IMH1_HIOP_MMIO_BASE;
> > +     mmio_base +=3D dmr_iio_freerunning_box_offsets[box->pmu->pmu_idx]=
;
> > +
> > +     box->io_addr =3D ioremap(mmio_base, type->mmio_map_size);
> > +     if (!box->io_addr)
> > +             pr_warn("perf uncore: Failed to ioremap for %s.\n", type-=
>name);
> > +}
> > +
> > +static struct intel_uncore_ops dmr_uncore_freerunning_ops =3D {
> > +     .init_box       =3D dmr_uncore_freerunning_init_box,
> > +     .exit_box       =3D uncore_mmio_exit_box,
> > +     .read_counter   =3D uncore_mmio_read_counter,
> > +     .hw_config      =3D uncore_freerunning_hw_config,
> > +};
> > +
> > +enum perf_uncore_dmr_iio_freerunning_type_id {
> > +     DMR_ITC_INB_DATA_BW,
> > +     DMR_ITC_BW_IN,
> > +     DMR_OTC_BW_OUT,
> > +     DMR_OTC_CLOCK_TICKS,
> > +
> > +     DMR_IIO_FREERUNNING_TYPE_MAX,
> > +};
> > +
> > +static struct freerunning_counters dmr_iio_freerunning[] =3D {
> > +     [DMR_ITC_INB_DATA_BW]   =3D { 0x4d40, 0x8, 0, 8, 48},
> > +     [DMR_ITC_BW_IN]         =3D { 0x6b00, 0x8, 0, 8, 48},
> > +     [DMR_OTC_BW_OUT]        =3D { 0x6b60, 0x8, 0, 8, 48},
> > +     [DMR_OTC_CLOCK_TICKS]   =3D { 0x6bb0, 0x8, 0, 1, 48},
> > +};
> > +
> > +static struct uncore_event_desc dmr_uncore_iio_freerunning_events[] =
=3D {
> > +     /*  ITC Free Running Data BW counter for inbound traffic */
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port0, 0x10, "3.814697266e-6"=
),
Hi, it is probably a bit late but I think the third argument should be
a string. Because the macro already applies __stringify, the resulting
expansion is ""3.814697266e-6"", which eventually shows in sysfs
knobs. It would cause problems while Perf tries to parse the file.

Thanks,
CT
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port1, 0x11, "3.814697266e-6"=
),
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port2, 0x12, "3.814697266e-6"=
),
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port3, 0x13, "3.814697266e-6"=
),
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port4, 0x14, "3.814697266e-6"=
),
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port5, 0x15, "3.814697266e-6"=
),
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port6, 0x16, "3.814697266e-6"=
),
> > +     INTEL_UNCORE_FR_EVENT_DESC(inb_data_port7, 0x17, "3.814697266e-6"=
),
> > +
> > +     /*  ITC Free Running BW IN counters */
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port0, 0x20, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port1, 0x21, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port2, 0x22, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port3, 0x23, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port4, 0x24, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port5, 0x25, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port6, 0x26, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_in_port7, 0x27, "3.814697266e-6"),
> > +
> > +     /*  ITC Free Running BW OUT counters */
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port0, 0x30, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port1, 0x31, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port2, 0x32, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port3, 0x33, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port4, 0x34, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port5, 0x35, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port6, 0x36, "3.814697266e-6"),
> > +     INTEL_UNCORE_FR_EVENT_DESC(bw_out_port7, 0x37, "3.814697266e-6"),
> > +
> > +     /* Free Running Clock Counter */
> > +     INTEL_UNCORE_EVENT_DESC(clockticks, "event=3D0xff,umask=3D0x40"),
> > +     { /* end: all zeroes */ },
> > +};
> > +
> > +static struct intel_uncore_type dmr_uncore_iio_free_running =3D {
> > +     .name                   =3D "iio_free_running",
> > +     .num_counters           =3D 25,
> > +     .mmio_map_size          =3D DMR_HIOP_MMIO_SIZE,
> > +     .num_freerunning_types  =3D DMR_IIO_FREERUNNING_TYPE_MAX,
> > +     .freerunning            =3D dmr_iio_freerunning,
> > +     .ops                    =3D &dmr_uncore_freerunning_ops,
> > +     .event_descs            =3D dmr_uncore_iio_freerunning_events,
> > +     .format_group           =3D &skx_uncore_iio_freerunning_format_gr=
oup,
> > +};
> > +
> > +#define UNCORE_DMR_MMIO_EXTRA_UNCORES                1
> > +static struct intel_uncore_type *dmr_mmio_uncores[UNCORE_DMR_MMIO_EXTR=
A_UNCORES] =3D {
> > +     &dmr_uncore_iio_free_running,
> > +};
> > +
> >  int dmr_uncore_pci_init(void)
> >  {
> >       uncore_pci_uncores =3D uncore_get_uncores(UNCORE_ACCESS_PCI, 0, N=
ULL,
> > @@ -6937,11 +7040,16 @@ int dmr_uncore_pci_init(void)
> >                                               dmr_uncores);
> >       return 0;
> >  }
> > +
> >  void dmr_uncore_mmio_init(void)
> >  {
> > -     uncore_mmio_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MMIO, 0,=
 NULL,
> > -                                              UNCORE_DMR_NUM_UNCORE_TY=
PES,
> > -                                              dmr_uncores);
> > -}
> > +     uncore_mmio_uncores =3D uncore_get_uncores(UNCORE_ACCESS_MMIO,
> > +                                             UNCORE_DMR_MMIO_EXTRA_UNC=
ORES,
> > +                                             dmr_mmio_uncores,
> > +                                             UNCORE_DMR_NUM_UNCORE_TYP=
ES,
> > +                                             dmr_uncores);
> >
> > +     dmr_uncore_iio_free_running.num_boxes =3D
> > +             uncore_type_max_boxes(uncore_mmio_uncores, UNCORE_DMR_ITC=
);
> > +}
> >  /* end of DMR uncore support */
>
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
>
>
>
