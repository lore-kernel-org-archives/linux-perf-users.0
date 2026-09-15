Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849583E5A29
	for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 22:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512259; cv=pass; b=rL6R9o/KNqMW7dolF0Q7Vv6QE/DwlnVpuAJF4kzSMUsZqHsMn4Fnm46pN2ia0SJzVYgKWnZNS/TaYx0N2xzaR9iLTmLZfnERFGo/KC4yvCssbI/Aa7wCpT6+PxyWZJcCqesBzhjv/Gcrebw/a2tTibWgeVJyLhGV9h8G4NeDigk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512259; c=relaxed/simple;
	bh=hiN8gmMir/W9bNffZY+EIZwn0mCZcrb0qGVAzbZqNQk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrHHP8LVlMz042COYjIHRevEQ6L7eNCJfvo3dl1plesGZGDnpT6HkI4M6KeZzpNDZfT25ewrcVqayO75iv/PjepdwX/mNj+vAOfM9MmTP7MVMMtZ0as3oZRq00/K9vMJfsQQNNmJMNAF4BUwEMOKno/ZqtaX3yGlX8rrYxmYk6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bLOfJnkN; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bLOfJnkN"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530411c7ee1so50981cf.0
        for <linux-perf-users@vger.kernel.org>; Tue, 15 Sep 2026 15:44:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789512256; cv=none;
        d=google.com; s=arc-20260327;
        b=MNOKx96GSETs0qFv5Y2LoHSezomDDVzCldW/Ls9ylSytYT6jfc/lNAbSBO7fYcRaZV
         /5ZfnHdT110Iq1YyMIWPAfd31GmaLcw+zKBT6TxkLWKBJ/5fIvymBgFC84HRDnGuGuBq
         0tiG6/8JJh9lPugz6Mrq38tpeClHYaYxfA+LFaZDPXRLETTFKLfQClPAqhEsyktxUZrz
         ORePtv+bcjGYewF1goZ/78JHXwrIDICad73cH/bAgdo/klmENWS3CDeCpuUYQfS98Hz7
         WN+FqVcqPkXAAd43DnyZT+KUPcXAO2wikPrSZ0rgAaFCsGdvuJci2f2dvtClaN5armbQ
         3gcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EaIQehfbhcZxllYG58s/kgtKRpkkLc8kmZQmGY/AurE=;
        fh=XLinBlypsS7RSfExIi1tmRwsJFZR9pdus6MQWpUZ6J8=;
        b=r1KQt7J06fy4/Co9X/He5F91pSvxgu+ejVJcdalbRLK7FnvvyKbaiOw3l6YrMVijvt
         W9Zs0oSWX2rqp6DOnQ5eJ17lG+GbwEdzRMGKDcr09pLS0x3uHM7LMmrwYAVGEaD/k4IC
         Hgm06/m4+qiqz3eb06kz39KVamvf8PRCJbFccXBTwI+78QPhTB/VcDxrCJX+uCn1ainE
         /YXebLlneLqMWHgODcitukGO+WHc6aVr0OYVrJthL32xLxXiObBlUXH7xEWxidfuctIf
         tqM5fYumrXu40+jVbOZMIDCSfhDI9JMe0Y8M7QxK4n+IgIKmxM2MZrlcNj4/dKRHK/eU
         5+qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789512256; x=1790117056; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EaIQehfbhcZxllYG58s/kgtKRpkkLc8kmZQmGY/AurE=;
        b=bLOfJnkNLSiKb/hBphoeOXi+A/0YaomF9rjPXFAO3IKOOhmG3BM1QR+IeZs7YkjNO5
         45sf3hjh9neVRwT5nbNQ+i2jBBLODhPEhSY7CuO+UD47WflhCasBD/INolQcvhFefU73
         7HlhZPLLI3e3grQnFlmNveEf68htuZnSAR6ao6km8DqOqQFzI0jJayAmGKLEzXf5CcN2
         yKYvkOiYhueP9+PW2qLj2rLwUU84lU/4myrMlG+xTII/Z/epDNVZogDg0wgNkYJiiZqG
         QZN6XLJ/SdTQRWHCh5EhQh9/S2M/LiqpM94dZQrFBnoJYOSkamgJ5QmqRatXLy7j1YB1
         Clkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789512256; x=1790117056;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EaIQehfbhcZxllYG58s/kgtKRpkkLc8kmZQmGY/AurE=;
        b=K4vq1nX6dTBt3wUQcnwT4kki62bcsrVyzNYQtY/ooqfG2VWV0JN4oEYGynlwwjfdCP
         fWFRSczimZrgStbLTVsQfd7NSRcep4P/8cOMTbj9r8DmlB0lr+oaf3HspnuRjoqjdu1D
         JR8a9tOUu+9b/J0RxdDXDG0XxgzzUxhOayob9KI8oPFPieUpfxNNrroB0NjyJ1zhYdez
         x4z6hWJoKdSPpj8TKoD3zSx4TISK7B8Ihv3ti1IfvpGEEOnB6UByPw0IaSf6l3wo4J2X
         MB668ONOAvaq7yE5R40FWdgwD1HWREZPU5ZKQyhSRiWeL8rAk8i4HIOhLUtO5xSgmmQZ
         LX0g==
X-Forwarded-Encrypted: i=1; AKwUvBz0qu09EZ9JeK9QTZVFySrp/KYFC/C3w3a3tsFkKmyjvO9k77xZgiwa1chxdo5xwhfN13T9VxHTZz1ZuDqeP4Uo@vger.kernel.org
X-Gm-Message-State: AFuF++mbn9qdZpLyW7tSbZGtsg/W6OBS5QEWREyvO+1sNL8YdOQk7wNj
	1G67PrSCbWuz3xqccZfH7BPsPLzSxDvfHiOaLSmECg9+5/Q8AkudhAqNTguvizdjs+BdG52a4OR
	20FLhaeNvHb8c3AyeQm5VL6Crc/4fKO1230frZoMQ
X-Gm-Gg: AYBFou2m9xoFBEXko2/A/eVF1stYsv+wI7c3EIFavr3Mq5IXlGNRJeCcuqU1L/Algh8
	3EtiZDBG2U4n/VCVTJjzSjuYrFIxz/vzpPX1auQP/mjUlDxVk47+oCtNdj6Kb/piA1MlKkwHx7a
	DqbB3DxMzkKchCDYeKysBGNSca/GbjW8GbOQIFYVynOwHS7d1UcCfUWldy8FdP/7Ev7XztMynGq
	9gVwzNvvt3h6OSofLzxbjPK0gL4RdToHfVn/CWPVLI4B5grmtj9yvZtZuH7APNji8dV/E+rmLs6
	akCs8NdCX5yXtsbXOz9JY3+taIZgdJbysNQFwFQEcjvvEA5YrDHitVE1urs2EfOJHClUVdq1qSr
	KiWvuhdtg611dhyPH8HUN
X-Received: by 2002:ac8:610c:0:b0:531:129b:2dba with SMTP id
 d75a77b69052e-5327e5ee122mr3172021cf.3.1789512250983; Tue, 15 Sep 2026
 15:44:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805155911.1304807-1-dave.jiang@intel.com>
In-Reply-To: <20260805155911.1304807-1-dave.jiang@intel.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 15 Sep 2026 15:43:59 -0700
X-Gm-Features: AcwNN1WGAjRzYjZLg6n5XYokgIbJhj5NtoS_8u9irGMa66FsXE2_a3JLfQkEHLY
Message-ID: <CAP-5=fXoVf5dGua_TJ5CMWFMRwtegiO3v2S96X28vRCfqO+N8Q@mail.gmail.com>
Subject: Re: [RESEND PATCH v4 00/11] perf/cxlpmu: Misc sashiko raised issues fixes
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	jic23@kernel.org, will@kernel.org, mark.rutland@arm.com, dave@stgolabs.net, 
	robin.murphy@arm.com, icheng@nvidia.com, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 9:02=E2=80=AFAM Dave Jiang <dave.jiang@intel.com> wr=
ote:
>
> [resend, mangled linux-cxl mailing addr]
>
> Teed off of Davidlohr's misc cxlpmu series [1]. I had Claude pick up all
> the sashiko raised issues and then continued multiple internal review
> iterations to pick up a number of fixes. I'm no CXL PMU or perf expert,
> but the fixes look reasonable to me AFAICT.
>
> Since v3:
> - 4/11 and 5/11 swapped, so the one-line MSI vector 0 fix comes before th=
e
>   info->msi_vec rename and backports on its own (Robin).
> - 6/11: new patch, add the PMUs after configuring events.
> - 7/11: no code change; the commit message no longer overstates what
>   dropping IRQF_SHARED costs a device that shares a vector.
> - 8/11: quote the spec sentence that makes the freeze sticky, and correct
>   the claim about what the migration window leaves enabled (Richard,
>   sashiko-bot).
> - 10/11: split the probe-time overflow clear out, so this is back to the
>   single hunk Jonathan acked.
> - 11/11: new patch. Clear a counter's stale overflow status when starting
>   an event, which is where the reuse case bites; the probe clear moved
>   here from 10/11 (Richard).
>
> Since v2:
> - 1/11: check event_idx alongside counter_idx (Jonathan).
> - 2/11: use FIELD_MODIFY() rather than mask-then-OR (Jonathan).
> - 3/11: rewrite the rationale, no code change (Jonathan).
> - 5/11: new patch, split the MSI vector out of info->irq (Robin, Jonathan=
).
> - 7/11: drop IRQF_SHARED as well as adding IRQF_NOBALANCING, and retitle
>   (Jonathan, Robin).
> - 8/11: don't unfreeze if the PMU has been disabled meanwhile (Robin,
>   Jonathan).
> - 10/11: retitle, and drop the cxl_pmu_offline_cpu() hunk since that
>   dev_err() cannot be reached (Robin).
> - Dropped the old 9/9 that guarded cpumask_show() against cpumask_of(-1).
>   The init case was a false positive and neither reviewer liked the shape
>   of it (Jonathan, Robin).
>
> Since v1:
> - Updated 3/9 to address sashiko issue.
> - No other changes as sashiko only raised issue with pre-existing.
>
> Three follow-ups this series does not attempt:
>
> cxl_pmu_read() relies on local64_t being same-CPU, which is the only reas=
on
> the interrupt has to be pinned at all. Moving prev_count and event->count
> off local64_t would make the affinity question moot, and Robin may have a
> view on whether that is worth doing.
>
> cxl_pmu_offline_cpu() still leaves on_cpu at -1 across a sleeping
> perf_pmu_migrate_context(), and still has an unreachable no-target branch=
.
> Both want removing, possibly on top of the generic PMU hotplug rework
> Jonathan pointed at [2].
>
> Firmware can leave a counter enabled with Global Freeze on Overflow but n=
ot
> Interrupt on Overflow, which stalls the whole CPMU with no interrupt to s=
ay
> so. Quiescing the block at probe needs two writes per counter to stay
> within the spec's rule about changing an enabled counter, so it belongs i=
n
> its own patch.
>
> [1]: https://lore.kernel.org/linux-cxl/20260715191454.459673-1-dave@stgol=
abs.net/
> [2]: https://lore.kernel.org/linux-arm-kernel/cover.1784911757.git.robin.=
murphy@arm.com/


Thanks Dave, I notice that everything seems ready to land for this
series. Is there anything pending? Sashiko mentioned pre-existing
issues.

Thanks,
Ian

> Dave Jiang (11):
>   perf/cxl: Program the requested event group on configurable counters
>   perf/cxl: Clear stale event fields before reprogramming a counter
>   perf/cxl: Fix the counter overflow delta fixup
>   perf/cxl: Accept an overflow interrupt on MSI message number 0
>   perf/cxl: Split the MSI vector out of info->irq
>   cxl/pci: Add the PMUs after configuring events
>   perf/cxl: Don't share the overflow interrupt, and keep it pinned
>   perf/cxl: Unfreeze counters after handling an overflow interrupt
>   perf/cxl: Validate the hardware-reported counter width
>   perf/cxl: Don't log through pmu.dev in the overflow interrupt handler
>   perf/cxl: Clear stale overflow status before using a counter
>
>  drivers/cxl/pci.c      |  11 +++--
>  drivers/perf/cxl_pmu.c | 107 ++++++++++++++++++++++++++++++++---------
>  2 files changed, 90 insertions(+), 28 deletions(-)
>
>
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> --
> 2.54.0
>
>
