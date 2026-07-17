Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8081937A4B8
	for <linux-perf-users@vger.kernel.org>; Fri, 17 Jul 2026 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784284694; cv=none; b=lVvUMv1vTBt7gQ7yL2zE+StiQXqHQakLuzq4PW4rXaphleYHxBPRIU0dVbyCWjlFjRQczPbWyMf3DOfeAyZsbSRHx2iGwg5lGsYAuoYpaIcWQqvapyA03RXE19i8+deehdQ29rpFmlVypBxrJPdSyREBRFEYO3YmoeCXcUkZr3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784284694; c=relaxed/simple;
	bh=7M8b6H4/Suea7A1U3B9aTdSILJWPe9/EnH5isXKtTBE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rxFFT6A0WQFez99A1sVjKzsY4te+2Fy0p4H7JC0DbSamDtiGaPiua0G9Vq6Prll1c55gmSxzckZNlThzBkH9r6IQkR1OPiMtteJg8FzOM8Pp96atobIMmrifQiONCqng+BN1OKUjVdA2mX2JFpW55Xq1rA6ihND8r57vueg7i6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgUqWv2p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgUqWv2p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 075C11F000E9;
	Fri, 17 Jul 2026 10:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784284693;
	bh=GQbasscoe2V6UXYHSsgodfB527guSwU3X0f9MHopVzk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hgUqWv2pK9Wv9TNzGpvvnw0I2wbYjm1Q1sdejpzFvSfW9rbrwZxorjKqgmAhrhqvP
	 HwJDOWNd3/F8UKmUooHp6l58uLDM4c9qRb4ubDSM2jUhE6RMAezOWuf2Dln06RxM60
	 qXSA+fNfZA6R8uPhFVX+gT79XUjLft4eavMOHvVRZtuUlmT5mtS+K10WwgiWJjSodj
	 mFzncWht3draBh/qv62fJnj+WCYL6y7U5lM9Yz5eMBNO5swnf5yVQBT866ChGFUZnr
	 lwP5DPK77trm8gta0QPwjCikIU34cF11/EoAxAxYzsDQBTNc9lcrq3YXCWm0yA+Zca
	 fmEZEzuR581Ag==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
References: <20260717080342.1879573-1-dapeng1.mi@linux.intel.com>
 <20260717080342.1879573-9-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 10:38:12 +0000
Message-Id: <20260717103813.075C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race in intel_pmu_drain_bts_buffer leading to duplicate BTS=
 records.
--

--- Patch [8]: [Patch v3 8/8] perf/x86/intel: Prevent drain_pebs() reentry =
---
commit 77ebceadaa828dfb1bed75e560551cf29b1ae9f5
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Prevent drain_pebs() reentry

The PEBS buffer is shared by all events on a CPU, so drain_pebs() must
not run concurrently. This commit introduces __intel_pmu_quiesce() and
__intel_pmu_resume() helpers to disable the full PMU around the
drain_pebs() call, preventing reentry.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index e86e4ba91e1b3..7f8b98d1837dc 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -1240,13 +1240,6 @@ int intel_pmu_drain_bts_buffer(void)
>  	return 1;
>  }

[Severity: High]
This is a pre-existing issue, but since you are fixing the drain reentry=20
race for PEBS, does intel_pmu_drain_bts_buffer() need similar protection?

If a user configures a BTS event alongside another active counter and=20
disables the BTS event, the stop IPI can call this sequence without=20
globally disabling the PMU:

__perf_event_stop()
  x86_pmu_stop()
    intel_pmu_disable_event()
      intel_pmu_drain_bts_buffer()

If a PMI interrupts execution precisely between reading the top pointer and=
=20
resetting the index:

arch/x86/events/intel/ds.c:intel_pmu_drain_bts_buffer() {
    ...
    base =3D (struct bts_record *)(unsigned long)ds->bts_buffer_base;
    top  =3D (struct bts_record *)(unsigned long)ds->bts_index;

    if (top <=3D base)
        return 0;

    memset(&regs, 0, sizeof(regs));

    <-- PMI FIRES HERE -->

    ds->bts_index =3D ds->bts_buffer_base;
    ...
}

Could the NMI handler unconditionally call intel_pmu_drain_bts_buffer(),=20
draining the records and resetting the index, only for the interrupted=20
context to resume and push the exact same records again using its stale=20
top pointer?

Would it make sense to wrap the BTS draining logic with the newly=20
introduced __intel_pmu_quiesce() and __intel_pmu_resume() helpers as well?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717080342.1879=
573-1-dapeng1.mi@linux.intel.com?part=3D8
