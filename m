Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3E2EEC0
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777089220; cv=none; b=kRa1gFmVbptEb/i2CM+WUek05cQ3K9w2YoaMsH0lUQV2KIIANTX7Hv6vuOpbgkyo+Hf9Gx7SXZfcC+9pAnZ5Q3lP/OHR0BmAummFwcTftDAf5WYfdJjGIVe+hhO4mPu5GHjLQMtVDtro8ySfUfGNl7jaZTzHfsJwCakJk2X+D1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777089220; c=relaxed/simple;
	bh=LkV82wJoV9JWY1EzJmlhyrRuK6LTQcxLIVpubsHNevw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=c7LLTk7xcK0L3m4FXyjj/bEEwGdjTPbYKV9WDFKPCqTBh2HD4s/ZiyCk04YCVvxJLjZ11Zo0csSzdTdcaXuK7QY9YB5HUK3WwfHYXjnPG/LbrfWIu5nyLfhIlX+/QCvxXh0vCtXveTI5N+5oovjuQiG+DxQ0EY2lw/Zi9LTAhZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WcAUL9Uc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WcAUL9Uc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8032DC2BCB2;
	Sat, 25 Apr 2026 03:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777089219;
	bh=LkV82wJoV9JWY1EzJmlhyrRuK6LTQcxLIVpubsHNevw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=WcAUL9UcLDKgR08vY0SlvqFZXsccutBXoYYKmAEVzoK5lBiqzCHRqUnFOEZK0qhAJ
	 dIXW6NEioCOKM4PqQswY8ulXGy+s6oRkeqa96fnqqs/u0xCu62odrThbn3W85Hno9Z
	 La1nCEvMX1gX7HRL2LsUMaY3xP4gz/NgNd4e2ugjyaa769qh64FiXjsB6BkZyiIZ6k
	 QGjlIb1rol63/RPK1GCrDSLP5VdJn73xd1c7ltmlzroA5LQjCHyhBW3jimZh2pps+1
	 DNwpvQABh4uzuyRfSlgEWrzWJbwMQTr4b0E2kHXzESCYM0NqbLLz1LZHNMqpfpqo7b
	 I2jeL2WIWQ1LQ==
From: sashiko-bot@kernel.org
Subject: Re: [Patch v7 24/24] perf/x86/intel: Add sanity check for PEBS
 fragment size
Reply-To: sashiko@lists.linux.dev
To: "Dapeng Mi" <dapeng1.mi@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260324004118.3772171-25-dapeng1.mi@linux.intel.com>
References: <20260324004118.3772171-25-dapeng1.mi@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 03:53:38 +0000
Message-Id: <20260425035339.8032DC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 3 potential issue(s):
- [Critical] Skipping setup_sample() for corrupted records does not discard=
 the record, but instead leaks stale register states to userspace.
- [High] The global `corrupted` flag falsely invalidates valid pending samp=
les for unrelated PMU counters.
- [Medium] The corruption checks fail to flag records with out-of-bounds fi=
nal fragments or zero-sized fragments as corrupted.
--

commit ed1fa3eb36814252a303cf5b2e6f3f4bfd3ed81e
Author: Dapeng Mi <dapeng1.mi@linux.intel.com>

perf/x86/intel: Add sanity check for PEBS fragment size

This commit adds a sanity check to prevent potential infinite loops
caused by corrupted PEBS fragment sizes. It intends to discard
corrupted PEBS records and all subsequent records.

> diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
> index 19f96d9ae04b5..e7bc6a37a3575 100644
> --- a/arch/x86/events/intel/ds.c
> +++ b/arch/x86/events/intel/ds.c
> @@ -2951,13 +2951,17 @@ __intel_pmu_pebs_last_event(struct perf_event *ev=
ent,
>  			    struct pt_regs *iregs,
>  			    struct pt_regs *regs,
>  			    struct perf_sample_data *data,
> -			    void *at,
> -			    int count,
> +			    void *at, int count, bool corrupted,
>  			    setup_fn setup_sample)
>  {
>  	struct hw_perf_event *hwc =3D &event->hw;
> =20
> -	setup_sample(event, iregs, at, data, regs);
> +	/* Skip parsing corrupted PEBS record. */
> +	if (corrupted)
> +		perf_sample_data_init(data, 0, event->hw.last_period);
> +	else
> +		setup_sample(event, iregs, at, data, regs);
> +

The commit message states that corrupted PEBS records will be discarded, but
skipping setup_sample() still allows the execution to continue to
perf_event_output() or perf_event_overflow() located further down in this
function.

Since regs points to a per-CPU x86_pebs_regs, and it is not updated with
the current hardware context when setup_sample() is skipped, does this emit
stale register states from previously processed PEBS records into the
userspace ring buffer?

[ ... ]

> @@ -3391,6 +3399,10 @@ static int intel_pmu_drain_arch_pebs(struct pt_reg=
s *iregs,
>  			if (!header->size)
>  				break;

If a fragment has header->size =3D=3D 0, the loop breaks and reaches done: =
with
corrupted =3D=3D false.

Does this miss flagging malformed zero-sized fragments as corrupted, allowi=
ng
them to be parsed and potentially causing out-of-bounds reads?

>  			at +=3D header->size;
> +			if (WARN_ON_ONCE(at >=3D top)) {
> +				corrupted =3D true;
> +				goto done;
> +			}
>  			header =3D at;
>  		}
> =20
>  		/* Skip last fragment or the single record */
>  		at +=3D header->size;
>  	}

If the final fragment of a record (where arch_pebs_record_continued()
is false) has an out-of-bounds size, at +=3D header->size; is executed
and the loop terminates naturally with corrupted =3D=3D false.

Could this allow out-of-bounds reads past ds->pebs_index when the unflagged
malformed record is parsed by setup_arch_pebs_sample_data()?

> +done:
>  	__intel_pmu_handle_last_pebs_record(iregs, regs, data, mask,
> -					    counts, last,
> +					    counts, last, corrupted,
>  					    setup_arch_pebs_sample_data);

Here a single corrupted flag is passed for the entire PEBS buffer drain
operation.

If one PMU counter encounters a corrupted record and jumps to done:, this
global flag is applied to the last events of all active counters.

Does this falsely invalidate perfectly valid pending samples for unrelated
PMU counters, and subject them to the stale register leak described above?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260324004118.3772=
171-1-dapeng1.mi@linux.intel.com?part=3D24
