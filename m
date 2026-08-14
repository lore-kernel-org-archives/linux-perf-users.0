Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9AF349CDD
	for <linux-perf-users@vger.kernel.org>; Fri, 14 Aug 2026 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786719859; cv=none; b=D+qrZNdj5I0JevgNBX3dWbnEzL6TqJfWdxFoN+8XRw9BJX98BF65R4y6d/ZPJeST1F6x1x2FhufhcYhPtQyTuRdEUCqtuOrfeYo0DSpIuc2BHR7N6PmgGhtIU3twvCZ+Z8hTE6AZa1sJaS8so2eSG9Teeg6SwNUs29fN3AOyDEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786719859; c=relaxed/simple;
	bh=JOW9odBs21uPtEhJJ89YchffQQmHlxTGjaEiNkXZDDA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BET4V8g6msVql0ZU7Tc7o4mBYxceEDnWBuYcRlsXprOoz06uI2MiKergxG5+Mo0R/CNv0g88R/qfrl9Eb6OTaufSvRUvDyAXTFzqvjDO3xlPyDOyz8S35sdp9OS0++BwoLxF4GcYs1R1kd16QC/RNahZn59Zd+xlVSkrWPryLAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fczokZBm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fczokZBm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D14E1F000E9;
	Fri, 14 Aug 2026 15:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786719858;
	bh=RGGZ81d/d4rv/OcoQtGTnVJGRgXfRSHaXiwIE3ohccE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fczokZBmjcl4Iai6Z9zCfmP+18Sf9ZZ2e3cWsQZeedEWAZlSZlv5j39E3Lu5PYDxf
	 IOBi6qd0vlmNdVi5GCCaHejUm7kuReOA6cuzhtgwTRH8clxbOiAHGrs4ObiweXUBhU
	 0lNNZ6xzsbgp3ahQB93YVq928YxbEMZymGf2npttwbcYWqqMgwUJiEtR3iKQpC3bmn
	 hwOj7Og8cWgVxSpyAIfSIqwRZ+/+3axbFHDpI7YYv1YQvOVn40TzXgdgotFDsY2XUg
	 D0SlJ/EpM2ybaSlByaWfTaXJlAFe89e6peCfpMtTVFaLH2A6fWpddyZMp9LqGko+iO
	 IOb8FbTB4uP6Q==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] perf/core: add AUX buffer ownership for kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kunwu Chan" <kunwu.chan@gmail.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260814144927.489172-2-kunwu.chan@linux.dev>
References: <20260814144927.489172-1-kunwu.chan@linux.dev>
 <20260814144927.489172-2-kunwu.chan@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 15:04:17 +0000
Message-Id: <20260814150418.4D14E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Double `ring_buffer_put()` in `perf_event_release_aux()` leads to =
refcount underflow and use-after-free of the ring buffer.
- [High] Concurrent detach of `event->rb` causes a NULL pointer dereference=
 inside `perf_pmu_output_stop()`.
--

--- Patch [1]: [RFC PATCH 1/5] perf/core: add AUX buffer ownership for kern=
el events ---
commit 34b60be57b99a06be2e537e647853e4c5c20c8c2
Author: Kunwu Chan <kunwu.chan@gmail.com>

perf/core: add AUX buffer ownership for kernel events

This commit adds an in-kernel AUX owner reference and setup/release helpers
for kernel-created perf events. It introduces perf_event_setup_aux() and
perf_event_release_aux() to handle AUX buffer lifecycle without requiring a
userspace mmap.

> diff --git a/kernel/events/core.c b/kernel/events/core.c
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c

[ ... ]

> +void perf_event_release_aux(struct perf_event *event)
> +{
> +	struct perf_buffer *rb;
> +
> +	if (!is_kernel_event(event) || event->parent)
> +		return;
> +
> +	rb =3D ring_buffer_get(event);
> +	if (!rb)
> +		return;
> +
> +	/* Do not detach a ring buffer that this API does not own. */
> +	if (!rb_has_aux(rb) || !refcount_read(&rb->aux_kernel_count))
> +		goto out_put;
> +
> +	if (refcount_dec_and_mutex_lock(&rb->aux_kernel_count, &rb->aux_mutex))=
 {
> +		/*
> +		 * Stop all AUX events writing to this buffer so the pages
> +		 * can be freed; after aux_kernel_count drops to zero they
> +		 * won't start any more (see perf_aux_output_begin()).
> +		 */
> +		perf_pmu_output_stop(event);

[Severity: High]
Is there a race condition here if multiple threads call this concurrently?

If Thread 1 enters this block and calls perf_pmu_output_stop(), it accesses
event->rb directly:

static void perf_pmu_output_stop(struct perf_event *event)
{
        ...
        list_for_each_entry_rcu(iter, &event->rb->event_list, rb_entry) {

Meanwhile, Thread 2 could fail the aux_kernel_count decrement, skip the
block, and immediately detach the buffer:

        if (event->rb =3D=3D rb) {
                ring_buffer_attach(event, NULL);

Since ring_buffer_attach(event, NULL) sets event->rb to NULL, could Thread 1
dereference a NULL pointer inside perf_pmu_output_stop()?

> +
> +		rb_free_aux(rb);
> +		WARN_ON_ONCE(refcount_read(&rb->aux_refcount));
> +		mutex_unlock(&rb->aux_mutex);
> +	}
> +
> +	/*
> +	 * Detach the ring buffer from the event.  This runs even if the
> +	 * refcount_dec_and_mutex_lock above lost the race to another
> +	 * concurrent release caller; the mmap_mutex serialisation and the
> +	 * event->rb =3D=3D rb check ensure only one caller performs the detach.
> +	 */
> +	mutex_lock(&event->mmap_mutex);
> +	if (event->rb =3D=3D rb) {
> +		ring_buffer_attach(event, NULL);
> +		ring_buffer_put(rb); /* drop the event->rb reference */

[Severity: High]
Does this result in a double-free?

Looking at ring_buffer_attach(), it already drops the reference to the old
buffer when it is replaced:

static void ring_buffer_attach(struct perf_event *event,
                               struct perf_buffer *rb)
{
        ...
        rcu_assign_pointer(event->rb, rb);

        if (old_rb) {
                ring_buffer_put(old_rb);
        ...
}

If ring_buffer_attach(event, NULL) already calls ring_buffer_put() on the
detached buffer, will calling ring_buffer_put(rb) again immediately after
cause the refcount to underflow and prematurely free the ring buffer?

> +	}
> +	mutex_unlock(&event->mmap_mutex);
> +
> +out_put:
> +	ring_buffer_put(rb); /* the temporary reference from ring_buffer_get() =
*/
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814144927.4891=
72-1-kunwu.chan@linux.dev?part=3D1
