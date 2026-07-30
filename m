Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ECF45C710;
	Thu, 30 Jul 2026 18:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785437602; cv=none; b=fCVqK6WvLGTHFrjXbHzwoLNRS+Z0l5TFMCVZ0uVQedaTW6YfggBieu8eOVmL6ugRr9GmjPQY/S7hbUaZ5LDkMaUND9/47MWx+QsN6aGPcppLEyX4KZWG04m0JGCb1kJaZN4QrlvuSaFjlyGQO+Ye7BjK9ePK+u/hdgESg1fxNKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785437602; c=relaxed/simple;
	bh=kYZRCIV953NDcqkNwXAy6ARunyYoZelm9iB2MeqKvDg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NSZEn/o/N/dKOieqjglPaJ3MumcCIHG2lzqlWSzUj16nYkPJgX82PAuk32NZWij0gy//TRYCP7YlqkpCCTYG55LD6Zbn9FshxIjxexzBVaUeXRdduiwhi+Rzd89TVNVv9P87KnB+w4igvWIyCX51R/EXlwJbucwDnepmO9vHZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZfvcP5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZfvcP5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5300E1F000E9;
	Thu, 30 Jul 2026 18:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785437599;
	bh=xYIMU6IJKgEgBnB9Sw4bSHlQMhtRlASNzquQ/9m0UP4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DZfvcP5Iy83u08qnrtWGZEt+czTAhzvWL3OhxN994VBrRCV161d7DYO4GEd5xFWyc
	 hwqoZDTjLytpmXftccgyAOYs28uZ+j1xozZZEtnZgdIuEB7Hhj0Xlpn7PyYzKPY30+
	 3tHDfA2EZcUbQFf0sL6D4q5533SzewP429ncLVuA5eKKfs6lncTAJT6cwHZB3jCbgE
	 HZN1Gglsht9L2l0hQBMSlYxdVLLeJKEQGjnb6O5bpMQ6RdFA3BuJ7/ARfNLAMIU3ca
	 2JphssMjkGKVPZe6N5l9go5CfwTFX1oncVeB12n3wZ+E9jb6giA65RcLwA/aMeMkoK
	 wbFh5n2bgJq3Q==
Date: Thu, 30 Jul 2026 19:53:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
 linux-perf-users@vger.kernel.org, will@kernel.org, mark.rutland@arm.com,
 dave@stgolabs.net, sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] perf/cxl: Unfreeze counters after handling an
 overflow interrupt
Message-ID: <20260730195313.3e2c0b8e@jic23-huawei>
In-Reply-To: <3dc5c366-652f-4977-84a1-6e5a921a74cc@arm.com>
References: <20260729145555.3919550-1-dave.jiang@intel.com>
	<20260729145555.3919550-7-dave.jiang@intel.com>
	<3dc5c366-652f-4977-84a1-6e5a921a74cc@arm.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2026 13:04:17 +0100
Robin Murphy <robin.murphy@arm.com> wrote:

> On 29/07/2026 3:55 pm, Dave Jiang wrote:
> > The counters are configured with Freeze on Overflow, so when any counter
> > overflows the CPMU freezes every counter in the block (CXL r4.0
> > =C2=A78.2.7.2.1). cxl_pmu_irq() reads the overflowed counters and clear=
s the
> > overflow status, but never writes the CPMU Freeze register to unfreeze,
> > so all counters stay frozen until the next pmu_enable() and events in
> > that window are silently lost.
> >=20
> > Unfreeze after clearing the overflow status so counting resumes.
> >=20
> > Fixes: 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> > Reported-by: sashiko-bot@kernel.org
> > Closes: https://sashiko.dev/#/patchset/20260715191454.459673-1-dave@stg=
olabs.net?part=3D1
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> >   drivers/perf/cxl_pmu.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> > index 8b89db8f4d68..52e78a6e0960 100644
> > --- a/drivers/perf/cxl_pmu.c
> > +++ b/drivers/perf/cxl_pmu.c
> > @@ -804,6 +804,15 @@ static irqreturn_t cxl_pmu_irq(int irq, void *data)
> >  =20
> >   	writeq(overflowed, base + CXL_PMU_OVERFLOW_REG);
> >  =20
> > +	/*
> > +	 * Counters are configured to freeze on overflow (Freeze on Overflow),
> > +	 * which freezes every counter in the CPMU. Once the overflowed count=
ers
> > +	 * have been read and their status cleared, unfreeze so counting resu=
mes;
> > +	 * otherwise all counters stay frozen until the next pmu_enable() and
> > +	 * events are silently lost.
> > +	 */
> > +	writeq(0, base + CXL_PMU_FREEZE_REG); =20
>=20
> Does this unconditionally unfreeze _all_ counters, including any which=20
> might have have overflowed since the read of CXL_PMU_OVERFLOW_REG and=20
> thus have not been handled yet? Or are we hoping that the "global=20
> freeze" behaviour prevents that from being able to happen?
>=20

Yes global freeze should stop world on first one overflowing - if two go to=
gether
we should see them both in the handler.

> Furthermore, what if an overflow happens to occur just as=20
> cxl_pmu_disable() is intentionally freezing all the counters, such that=20
> by the time we get here, unfreezing them would be the wrong thing to do?

Hmm. That may indeed be bad.

>=20
> Thanks,
> Robin.
>=20
> > +
> >   	return IRQ_HANDLED;
> >   }
> >    =20
>=20

