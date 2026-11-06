Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793932912;
	b=lUij99v5rc0s4GXSofjkdi0QGVdjzsM4+wCByuhghH2V24T5yWYX4gWlmZsFFqLeXfJa
	 BNQdSFFyLSmhm723WQYK9GEjjpyDapWb5PrB0hTsu8VIuEusg9BTy2ALnhJgl4yT+ZCbd
	 qhNgOCcoev/WpdfXQhx/mFSZKU8ZWVqfY3vFzg7lVwk9ku5zPJXD7su5MqggSy1PjB+nR
	 /4Q3MlO+SeaIE6PokZEAKj/m/lIld5pMQUL9HKdoCnAn/oE99bUUL/EY4XH41Ofl/iosz
	 QVbLyr/+T1oxGc9jNzREkgJz+OJt+HJPRBXN6mVCkkg0qFBas7pUsSXFf52V+q4N57A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rXPT9ftSD1W4Pls/uGVHMwPU27w36zSFUh8Oy468MZ0=;
	b=zTMpLoU15BVx4vh6GK/xRiQb8Cmzf+L81v5LTMs03k6VAuwPSy7LEkcTvYzRT47nO4HB
	 Ap7OHhVmsNmXTCagrnbigUYiR9vw1oZjZhcVf6IBORWzN4NYh6z6GX/zG/WznepId8qBP
	 ChqXJKZUwMLiK8Alml+/SOx0o+HhxD/OY5j6IeRLaRFG+8kksstSJHcIuXZkmJSs60M7u
	 Cy5R4F4e4D1TLNGkTIyMVMHcXh+Vox7tabMMNpGMq5JqPbXtkJdJI4nMG47u2bxnclx24
	 o0Todo7ZwEQQj7bwRd/Iir8SqNLRI2C/+Mt5qsHRCp5DRwGlP+06WuKk4clGCj9Jpyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRSk5lqN;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88556606A31B
	for <linux-perf-users@vger.kernel.org>; Fri,  6 Nov 2026 02:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88556606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NRSk5lqN
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso1624165e9.1
        for <linux-perf-users@vger.kernel.org>; Thu, 05 Nov 2026 18:41:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793932910; cv=none;
        d=google.com; s=arc-20260327;
        b=VItcLd5MQzKkPrfqkUkU/6TcyCz+K2kgWrAVUe2Ry8tQIWMM3HEUU94pqgQu44QXNU
         wlhNix0ykFda49oh7zreJCFJTPkOEZqeWB4foPW0QUl6kutyInynYrID1uHxyIwoi0GP
         aUsBIt4EqSQ7o6FGRMdnfSN4iE/N4E+Kv17aQEbl1RHKQVcdHE30m5Efcv7eWhOlyYtd
         Q2miee53ItVLOLyg8oNADTAt2dnuB1NlB3qu7D5Gn300MjBZAPk2qrNIgZoptjzZ05XZ
         N7hpzDLgITBuCghuUKBaFI/xb943eocbX1/oW6gfYVwViMuEYRn2dtQhgsQii2mcgVvP
         m03A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rXPT9ftSD1W4Pls/uGVHMwPU27w36zSFUh8Oy468MZ0=;
        fh=fgE4yvnqSbf8PSym0k5wXU7fcYzlSfcEoGGi8ZJCM98=;
        b=Ng9Kxe71C2vLkT87MaTGJwMF5aoejPLNWnZqVu/tjYasV3iuHOl5kmX4gZXpXf2j6y
         yta0GZk9Q6HluJbCf1ejhj+7awOfBMqZU99N4APvev3U3nCIU1Q7Q7ehpEAP2BgbTlpn
         VoUXMn0YxpJdZN4ru0PaB3tp7ASpjN8heD7n/x7FmloPpWK1m5nYLJywcYb/HyIyltpz
         YIjSUxOlsEde3IzKql6mFNQdZBgmNW/0bksIgkRDEM7IZCEw8aRCycoBRZpweTS+9qLI
         RCDDWNuHxUUOnfu/UtnV/365eTRmXJE7BKwaepQONfnkaMsa25XWg94srRnMNwTTdvm/
         cDDQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793932910; x=1794537710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rXPT9ftSD1W4Pls/uGVHMwPU27w36zSFUh8Oy468MZ0=;
        b=NRSk5lqNe80aQecN8piJscSed2+4dtCYF9cGKNuDh3/Ps2IsTNKGDK0qxR3Ll2RHQN
         wJSBtjwUVLEnQYuobMm18u8tV1W6vuW7HlIVYLU1QhRckCEwhKSJneuJ15I/923U8H+1
         5zCzKUBMJDwAercoUth0AkAAHtDsSQVIcusHk1QTTZVyHXmlR3/KDCgdjbcIMkPKfBVn
         0vVsedn4fTjRLwtQKkjKzph/kJhi0E+M5N8jRlNrTsYUf/u4mYkOBxz8xg/SIbK9XgXv
         3HzEyd2rUKbDT9HV6yzVwcHhcwlj3kLSDIMfLFb6nBw5ePVFDceVrelnSpGWxmV+zcWq
         fwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793932910; x=1794537710;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rXPT9ftSD1W4Pls/uGVHMwPU27w36zSFUh8Oy468MZ0=;
        b=IET8MCspW+kJzeegv3H8ows1qMl6fNFHbpkBMkwn0voHwJz95gXApQs5o4IM4TgkzR
         QkZ1j7jlQpRIbjxoobuqoc/GNUQk684VjysIitlCpbc7FRgN0+I/35ZHwi55lEkAzFdB
         Uw52XPwHiehXNR0g0grWw417log+Dtt3x8WRTLgi2Optrbpl4Bqo/lyN73rQYfQt7Trz
         e0utgatgjViN9OcmV++tQXi06HbEjnIB7GCxU+xDFMa8fY5sqY/dn4xsaxQBUWra2r6P
         LbxQ2EkMGFkTH6Nbzqs2TcxzatE365vT9rB8mgueF/tpU0DsaYK1o3gBaIEe6E48leCO
         nAaA==
X-Forwarded-Encrypted: i=1; AKwUvBx+f9wi0NV+zMOpUANQ9oo0F+euPcAJQKzqgVqL2juFIJq8hBPvgt4Gdj8s2nIAUYWLLG4jzL3WtXsfCf2lvliF@vger.kernel.org
X-Gm-Message-State: APuU4Z/Rezow6Bdpzegpr5ZLOtocz7AFWQK0HlvXWvuu0p6SGh2gYeEW
	5dKKMxBUd7DKldc9yi82pH/AOFRZSBv5I1fUEY1ecb9SiYJ/S0BQGJWHgYpOn7zuqmStf1QSjfC
	Ec2bcAk9eMPeLP/FgvaA5vGd3Spnsy1Y=
X-Gm-Gg: AYBFou0ePbVz71/eUiCcvyeURmWsXz4fSTvlo7EWDc/0sRXGCiO1ph0eDhFDHVOiYsf
	7R0qK1O9x4tsxlMKi6n14WlzSGQA6q0Us7v2VbuUtcymVBhrC5di9QIfA/VZmQWhtRflmURuKrh
	KY9LFEYLL9rgGmFt6cqPrCfygDldjPiS2zKqkt74MrtrABoAln7lIzaI1yT3PsBVZCvOx+ZTeiw
	Mk5I+9S/3D5vGdsO/G9scdKb4Nqqn/PlDBNyFlp53HXzLHLerxb2qiZvmjAOD0VgqU1mpLtiYHi
	p+fLj8k3tQ0SWIbiO0biMpS5TGtdDQZbyO2051L7wmwqQ8+nOJVnCH3cWd9C/O4rhsFYCwqWFki
	02SOnNDf5U/iRAHgfM/tRXp1s+qo76CYlU1Sv2MOPizJBBBJxjfDp2a0/Uks=
X-Received: by 2002:a05:600c:4f13:b0:4a1:d8fc:8165 with SMTP id
 5b1f17b1804b1-4b6de1c645dmr14873335e9.20.1793932909304; Thu, 05 Nov 2026
 18:41:49 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261009160010.1829642-1-kunwu.chan@gmail.com>
 <20261009160010.1829642-2-kunwu.chan@gmail.com> <20261012104208.GQ4121339@noisy.programming.kicks-ass.net>
 <CAN_Opa9S2ObHYqa+w5Tqh8PFPRijo=iUZDk97aCYmNZT_75yVQ@mail.gmail.com>
In-Reply-To: <CAN_Opa9S2ObHYqa+w5Tqh8PFPRijo=iUZDk97aCYmNZT_75yVQ@mail.gmail.com>
From: KunWu Chan <kunwu.chan@gmail.com>
Date: Fri, 6 Nov 2026 10:41:37 +0800
X-Gm-Features: AclHuK8qaZa9j-EaRF6SECEA-dJP4xeAumfQIepVXAc0Je3LqIVzsucrbjhA_sM
Message-ID: <CAN_Opa96ww9yOwDVOERLkrByxMU6Dha9f5=i2vFjAWSr4hvUYg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] perf/core: add AUX buffer ownership for kernel events
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, sj@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, james.clark@linaro.org, 
	akpm@linux-foundation.org, lianux.mm@gmail.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:41=E2=80=AFPM KunWu Chan <kunwu.chan@gmail.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 6:42=E2=80=AFPM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Fri, Oct 09, 2026 at 11:59:48PM +0800, Kunwu Chan wrote:
> > > Add an in-kernel AUX owner reference and setup/release helpers for
> > > kernel-created perf events that need an AUX buffer without a userspac=
e
> > > mmap.  The setup path validates that the event is a kernel event with
> > > no parent, rejects non-power-of-two page counts and negative watermar=
k
> > > values, allocates the perf buffer and AUX pages, records the kernel
> > > owner, and attaches the buffer under the same lock.
> > >
> > > perf_event_release_aux() stops AUX writers, frees AUX storage, and
> > > detaches the buffer, in that order, matching the AUX teardown orderin=
g
> > > of perf_mmap_close(): perf_pmu_output_stop() walks event->rb->event_l=
ist
> > > and rb_free_aux() must run while the buffer is still referenced by th=
e
> > > event.  The single event->rb reference is dropped by
> > > ring_buffer_attach(event, NULL) itself, so the release path does not
> > > put it again.
> > >
> > > Both functions run under event->mmap_mutex, the lock that already
> > > serialises ring-buffer attach/detach transitions for an event:
> > > perf_mmap(), perf_mmap_close(), _perf_event_set_output() and
> > > _free_event() all hold it around ring_buffer_attach().  Concurrent
> > > perf_event_release_aux() callers therefore go through the same
> > > serialisation point, and a second release call, or a release of a
> > > buffer this API does not own, is a no-op.
> > >
> > > Keep aux_mmap_count dedicated to userspace mappings.
> > > perf_aux_output_begin() accepts a writer while either a userspace or =
kernel
> > > owner remains, preserving the existing teardown ordering.
> > >
> >
> > > diff --git a/kernel/events/internal.h b/kernel/events/internal.h
> > > index c03c4f2eea57..760b7659ad87 100644
> > > --- a/kernel/events/internal.h
> > > +++ b/kernel/events/internal.h
> > > @@ -48,6 +48,12 @@ struct perf_buffer {
> > >       int                             aux_nr_pages;
> > >       int                             aux_overwrite;
> > >       refcount_t                      aux_mmap_count;
> > > +     /*
> > > +      * In-kernel AUX owner reference, set by perf_event_setup_aux()=
:
> > > +      * admits writers and ties the AUX teardown to
> > > +      * perf_event_release_aux() when no userspace mmap holds the bu=
ffer.
> > > +      */
> > > +     refcount_t                      aux_kernel_count;
> > >       unsigned long                   aux_mmap_locked;
> > >       void                            (*free_aux)(void *);
> > >       refcount_t                      aux_refcount;
> >
> > This doesn't make sense to me. If the even is a kernel event, then ther=
e
> > cannot be mmap users, so adding another refcount is just for giggles?
>
> Hi Peter,
>
> I added `aux_kernel_count` to keep `aux_mmap_count`
> specific to userspace mappings. The two paths have different
> teardown responsibilities: `perf_mmap_close()` handles mmap
> cleanup, while `perf_event_release_aux()` stops AUX output,
> frees the AUX pages and detaches the buffer for a kernel
> consumer.
>
> `perf_aux_output_begin()` checks both counts so writers are
> admitted while either owner remains.
>
> Would you suggest a simpler approach here?
>
> Thanks,
> Kunwu

Gentle ping.

On your aux_kernel_count question: the separate count
is for teardown, not admission control.

When aux_mmap_count reaches zero, perf_mmap_close() subtracts from
mmap_user->locked_vm and vma->vm_mm->pinned_vm before calling
rb_free_aux().
A kernel owner has neither of these accounting requirements.

Reusing the count would therefore require either branching in
perf_mmap_close() on owner type, or duplicating the teardown in
release_aux().
Keeping separate counts lets each side handle its
own teardown without needing to know about the other.

If you'd prefer a single count with teardown selected by owner type,
I'm happy to rework it.

Thanks,
Kunwu
