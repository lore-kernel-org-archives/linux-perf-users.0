Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795122985;
	b=PjZXV0N27bYElqNR5zVtWEes3WpCHu9hWBDhusrw+2OqiQnLezq9ylXfqLJtW6sV1a2J
	 O0+8oYAP8RGmrdHXPaSMMPOGzvFG8qjkyn5njBhOst7RIf6RGTvN5tAY7ETUOJO6z/4zd
	 aRtS/3kKzw9mL1vKzJ2jHtrUw7TS1rMUwVHqElfmTP0MzjbCncEN2zQ/9qFhyyFcnzzY0
	 DonAXxiIExaDXqwz25Xiqaioe+LKoTTWxJIaRYuOc9c9CwHFMGdM3dGsIsoA7TVl2VuOX
	 5FlIhQYSzL5atq0wOiGvXGAAXYPJG5uHMp5w/I/xbUnY1s/u8TeY7W/6zQcbhMfKBxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795122985;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=WDRlDxJjQHkVu2PHgk64ZWW2ZSAZW86T1/O0yHx0njc=;
	b=KOTl7luR+3dj0CWverNhBA0MXzBFAMDw8q3v3nQhwgj4B9u7nPphjvBse8lJWAxelBfJ
	 sy0vJB5BCWXcmt2mDQBXGOztan2pyxgwxSicg5iw7u1A/dV5bUVs/Iw/lKBeQGpj6tjUJ
	 d/c5MapURhy45PTnHDMErg4aF5kLGDIzkFf08r97r+HEUCOM3suprXRkkdaVuBgwqNNn1
	 xCUnIgusoi6AmITJIMjJ+43zq3/oYCVXeyIeG5w8Qa2Z981mJehwnVKiA+/0Hc6SXJK/J
	 l1f308HFioDDM+l9/GyKtcFkMtnOudIzg1xXExu7qOCRWlXWs3vgyt/V2GG0yFAWvUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fu8tyQHg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B7B60A2619
	for <linux-perf-users@vger.kernel.org>; Thu, 19 Nov 2026 21:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fu8tyQHg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A0D21F000EC;
	Thu, 19 Nov 2026 21:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795122984;
	bh=WDRlDxJjQHkVu2PHgk64ZWW2ZSAZW86T1/O0yHx0njc=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Fu8tyQHgblINjhiA/lMtV3iKqLdat1BR2Xy+mLZihdd2x7yZe/LWcKSKvqgtOKll/
	 EDvz0wpwhRVRlY8XJJ/7f48ruZKqFQTKQqttVxoCC7dBMI7IcmQrEZdZn4RnsSASf9
	 4kli9Qzo4c7JDnY3uPqjyNBC48uxwoyolXDJqRqZV9yZxM4fBDzps/sluEN1Cd5HUJ
	 rhz6pf5tkEQNYCyQEwAiFd3k7ylfsgVzpq/jVbUOwmIeyAxmE49Qz8F9eDW6/Q+ac8
	 kav8teQMJBN1aJ0nvURVEdROE5Q+fgGQYDCsGAk4TW3XpKaBgq+wJPoygA6q7SxvgM
	 inLW8bfeyEhLQ==
Message-ID: <sashiko-outbox-224086@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] perf/core: Fix perf_sample_data reuse across
 software events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Usama Arif" <usama.arif@linux.dev>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261119211235.99805-2-usama.arif@linux.dev>
References: <20261119211235.99805-1-usama.arif@linux.dev>
 <20261119211235.99805-2-usama.arif@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 21:16:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> do_perf_sw_event() passes one on-stack struct perf_sample_data to every
> matching event. perf_prepare_sample() fills in the fields an event
> samples, marks them in data->sample_flags and skips fields that are
> already marked, and those marks survive from one event to the next.
>=20
> So a sampling event later in the list emits the sample ID, timestamp,
> pid/tid and callchain prepared for an earlier one. Its record size is
> computed from the earlier event's dynamic fields as well and can come
> out smaller than what is written, in which case the kernel writes past
> its ring-buffer reservation over the records that follow.
>=20
> Two "perf record -e page-faults,context-switches -c 1 -a" sessions
> running at the same time hit this: the one started first gets the
> other's sample IDs and fails with "Bad address".
>=20
> Commit 1d1bfe30dad5 ("perf/core: Fix perf_sample_data not properly
> initialized for different swevents in perf_tp_event()") fixed the same
> problem for tracepoints. Do the same here: initialize the struct for
> each matching event. While at it, drop the unused data argument of
> perf_swevent_match().
>=20
> Fixes: bb447c27a467 ("perf/core: Set data->sample_flags in perf_prepare_s=
ample()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119211235.9980=
5-1-usama.arif@linux.dev?part=3D1

