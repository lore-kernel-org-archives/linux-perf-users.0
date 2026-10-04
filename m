Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748253CB56B
	for <linux-perf-users@vger.kernel.org>; Sun,  4 Oct 2026 17:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791135923; cv=none; b=K2Cc4lhNxHE/jV1tIeL7swVnDdrlMxZ8+ACuxFQPbzjMGb88M2xSRUOzw3ZuL5dQJIN9bgH9WClZ7GJdiR5jLPMVU4PKMObcmaumY2W47Xitc2vHPPyVZCLYmean7UqM5gDPq0B6ftbPcy3J5ngaVVfTOOV/9S6gxUcUFfhWAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791135923; c=relaxed/simple;
	bh=x6oauCeYX/Y9NjxF8a9gcqDBmLUbw2copXhRJpG2jrA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tchJCwsssloinLR60/99EagA8NDcx4NXpsYCCDWi4/wgNI1tumXc8nylPRyo2PRMhwpqOec45IHIQ0OMYisLPtHNVOOy6zEm5sOJaFRLD+3SeeYdmLv1FMPtjPuATr/zq7XC8S+dopxX3BuAW9RzDptaogZzXKf97HY2+WaA7Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRdPvOn7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRdPvOn7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE771F000FF;
	Sun,  4 Oct 2026 17:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791135920;
	bh=lWHHWSLAuo/kgoD43F+JHEixbaSCqiYlHgFAG7CMSs0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kRdPvOn7Lxm5aOaGb6gmWMKbP2I5XPjV2fjLjCYcyAi8DtrLn3Mhp+RTF/8uRL3VC
	 W7anp17KOTwtz+QfHFxX3/2zn0e7oz4Sbx3ypDVUoXbAHXLKoKbGNdDWnDS3t/2Vfd
	 GFIE7jpZRawFIE6TpiPaobvOoz/iOurOIMHa8IoIDAXB5qX6cKvGBMkh72HYX/g7sX
	 T678UtYz5Pp9eIzlakGTVcZWFAR4EECOm4EhxS8u79KHWnfIVmqa0jVubMfYk1jwUM
	 xuI4gwS4NVsIXzFbHbjXNSh3t8l6HdmmumOHdJRsfNvEMaNUE+n2V3U618zilWmOyQ
	 /hdNNbaMa9MzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] perf/core: add KUnit tests for AUX kernel-consumer
 API
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261004173458.837842-4-kunwu.chan@gmail.com>
References: <20261004173458.837842-1-kunwu.chan@gmail.com>
 <20261004173458.837842-4-kunwu.chan@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 04 Oct 2026 17:45:20 +0000
Message-Id: <20261004174520.8BE771F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: double free of perf_event in aux_test_create_event()
- [Medium] perf: memory leak of AUX pages on KUnit assertion failure
--

commit 5c8a187a6ddc0c41bba18676f8fced4749f18392
Author: Lian Wang <lianux.mm@gmail.com>

perf/core: add KUnit tests for AUX kernel-consumer API

This commit adds a KUnit test suite for the perf AUX kernel-consumer API.
It registers a self-contained dummy AUX PMU and includes 39 test cases to=20
cover the setup, release, and data copying lifecycle.

> diff --git a/kernel/events/aux_kernel_test.c b/kernel/events/aux_kernel_t=
est.c
> new file mode 100644
> --- /dev/null
> +++ b/kernel/events/aux_kernel_test.c

[ ... ]

> +static struct perf_event *aux_test_create_event(struct kunit *test)
> +{
> +	struct perf_event_attr attr =3D {};
> +	struct perf_event *event;
> +
> +	attr.type =3D dummy_aux_pmu_type;
> +	attr.size =3D sizeof(attr);
> +	attr.disabled =3D 1;
> +
> +	event =3D perf_event_create_kernel_counter(&attr, raw_smp_processor_id(=
),
> +						 NULL, NULL, NULL);
> +	if (IS_ERR(event))
> +		return event;
> +
> +	if (kunit_add_action_or_reset(test, aux_test_event_release, event)) {
> +		perf_event_release_kernel(event);

[Severity: Medium]
Will this cause a double free of the event object?

If kunit_add_action_or_reset() fails, it automatically executes the cleanup=
=20
action, which in this case is aux_test_event_release(). That callback=20
already invokes perf_event_release_kernel() on the event. Calling it a=20
second time explicitly in this error path appears to trigger a double free.

> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return event;
> +}

[ ... ]

> +static void test_user_kernel_coexistence(struct kunit *test)
> +{
> +	struct perf_event *ev_a =3D aux_test_create_event(test);
> +	struct perf_event *ev_b =3D aux_test_create_event(test);
> +	struct perf_output_handle handle_a, handle_b;
> +	unsigned long a_head_before, b_head_before;
> +	void *addr;
> +	int ret;

[ ... ]

> +	/* Simulate userspace ownership: swap refcounts on B's rb.
> +	 * perf_mmap() would set aux_mmap_count=3D1 for a userspace event.
> +	 */
> +	refcount_set(&ev_b->rb->aux_mmap_count, 1);
> +	refcount_set(&ev_b->rb->aux_kernel_count, 0);
> +
> +	/* Produce on A =E2=80=94 B's head stays 0 */
> +	addr =3D perf_aux_output_begin(&handle_a, ev_a);
> +	KUNIT_ASSERT_NOT_NULL(test, addr);

[Severity: Medium]
Does this leak the AUX pages if the assertion fails?

If this assertion or subsequent assertions fail while aux_kernel_count is
set to 0, the test will immediately abort and skip the manual refcount
restoration at the end of the function.

When KUnit runs the deferred cleanup action aux_test_event_release() on=20
abort, perf_event_release_aux() observes that aux_kernel_count is 0 and=20
returns early without tearing down the buffer, leaving the memory=20
permanently leaked.

> +	perf_aux_output_end(&handle_a, 512);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261004173458.8378=
42-1-kunwu.chan@gmail.com?part=3D3
