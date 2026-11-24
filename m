Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795554687;
	b=qYAxmZ36D7cBA1Y/kyqZXH51F0VQvwvDeXmNxM8A0ziZN0g+fUFZVh4z7+/rtupKQ6b/
	 MoSLA2B2xnUzy3oetEPddPdQzux1ZMnWAlzcX/ehc3rMRFRJKh5Kj3lO6Wf2LEHz7eXTd
	 Aclr7tTIKafImVlGz5RtJ3pwagptXjOizSj3Y6olkBRAbwtYk3Iskws9Rn26ZgmnJAJAK
	 n7rUzHFzMbMvhrc6qMKMT9R1rRUrzdLWZkIRhMddl1dFvBth4lRnAtKXiznE5jjjTc8jC
	 MLKsbRXy3/fMWxPAUFsaNAGStbslUSCVo6IW33KQ8QXsb2R6oHzQVvYy2wU9CK0Rgqw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554687;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R4pw9DcpdnMYeIxEUYnbnv91ThzTvTrm2VVYBrvrMnw=;
	b=SDgXk3ha5o4WOuZ2bqhfcwLSMR/8V3Yspi6u30x9bDU1OBJyh3Urm5cye7cx3bU4vVjb
	 jjgGSiEsQpv7RpOus06e7MoxzdXVz2RP+IMSRHijIOP1AMv9OlF6ZiUx9s2wd0iC00izo
	 pXvisanaCiD5d1f1YFfmA9JjfSCOznoY0lieNQGftS5RmxqV61xfu3j28iik7MDdt0rcL
	 mW3o1FgDQTPd3TZJfza/yZX+zM0D3jePjNh0o7A14ClhdsIjzXODiP8vvNKtkh09tmvdJ
	 ujzEuiPNnzalzK40MJ1acNClmE2P8Yej1uN27aUPYqgVsx8dw9pmK5XckCRd+qN7QAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HKOoVTgW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6D0606A332
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 21:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E6D0606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=HKOoVTgW
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so820852666b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Nov 2026 13:11:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795554685; cv=none;
        d=google.com; s=arc-20260327;
        b=sBI++el8jZK6X8XtEnNq0YttUs2xQMCxTPI6yoNlSAt+tTBhQ1m67GyqwUBCz1TCr8
         yQG+efoO8b2TOKgObjys8UiiuV81JFUETrhPiIH7FxPhgeIsKHjYtC19ZC+5y1VcC0XI
         qWAZDE1gc3+yXANcLt2oUJhrULctmnNm9279oD3g+bVdITGMWJbm7JbIfd0rlP68/VzR
         K9Hg4Gu8sOAnf17JBVUL46wqpCSaqUS74WjH2NjpUVm5e+DKdgpAhfzn9XRj8mUTRKFv
         rjp29/f2f9AgvNl/AoZPvGCX85nBfOZ8Y4bZuWnYhJwTlNmJ4zFUURaFjURjlncUN0Ox
         oRaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=R4pw9DcpdnMYeIxEUYnbnv91ThzTvTrm2VVYBrvrMnw=;
        fh=V0Q14IVNRLxvnS/rMa9JBLw4EJ7JTEitoZZ8dawzAUY=;
        b=U1RR6X22y+pZFTCj6OJKlbd2dkTJKX7RmdCv/2QessV1MaLUvWtLabWPilbUhREzIH
         JGnXDa7BI+a0H3L2RQMJYdZ+wHJZNgwtW9oDYM/rT/L3jpPlzMf1PNHBoD0we3rZkTWg
         z9l0Q+FzGel1amUgbI5bg6HnJoBibb2IUa6xJx+QTSmCVchMMc3HeNtcv9Vru2se3qor
         ZEkDNzZgQA3oNYBr704zAtwjT0bwTPSVlLTeM4TDIQcsNvTwrvPlV1j11igU4ibCeKz/
         YrtUMFXyao/0yV2ED7V70VMsogthl4A/ez/Bee66+KSONqkJGun743ADrpMkSGRsoYkj
         qnAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795554685; x=1796159485; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=R4pw9DcpdnMYeIxEUYnbnv91ThzTvTrm2VVYBrvrMnw=;
        b=HKOoVTgWD/jri2ICKWYuabv2C9ujuA+HmAdR17PYnmvFnkT100ju59IEN9nDAg7lhQ
         3izGbBqkf1fX3HoYq56E8uvZBM8ZfAXmNAMUUomMtkB8DHkorVYcnwfKwOZBzRAsgJO2
         wbssVX4FXCgljByNAMwJEcMSidhJrLwVFKJ1EfKU+8JqRAFj8NpfeL3/N4xH71b2T0ZD
         PXQrVq2c0wZQYeDZp0n+YHWMjfbJA3/aBiAASKWtScWWXk2KhE5bNgUwG12UKI/EVE3c
         WsQsHA0ImsWl4+O15635i2+p+jMvtEzWWzvoBA93u4Nd2V3dnI4ABVn9slfjzPalO5cK
         HwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795554685; x=1796159485;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4pw9DcpdnMYeIxEUYnbnv91ThzTvTrm2VVYBrvrMnw=;
        b=bCFO9dyJt0nmBAIy2RJEFZl106g35S9Nn+FH5Xp0/HJQSJpeVsVSLJ+HssA5463rd1
         fQllG+NTJLH900J+ZZJy9iYprLNfVMqrNlB1KX3J/oMwu0O9MgT6jMiVrZxaUaHztsmj
         /0Ur5TvV2q8nPZb01JL5Fil7ANmOXLm8U+qU6UKXsftqfRKw3cMj+iSVCa40n6+ygcEh
         zmpmAlI3gpRSy+FO8x+z/Zj98eH61V+JNrmDyUOcXfEc//TvrHJYK6oflNE1ATXPNxi+
         /2xz8THkKoImiSJb0xHMlJ21csIuUdo5hJYZP9L7P5/PrPZI+D7sLDS/UDmOjfkaJ7Iv
         kbhQ==
X-Forwarded-Encrypted: i=1; AL+hErEXhr5zmj1gdmQsO8YWdW28tCTpM5HwlyIMDcFxuoymVwc+bUfgEuJfkGwsnw6C/pbjKVMkmF7PYUyy8EtUqzZD@vger.kernel.org
X-Gm-Message-State: APuU4Z/OTc32vSmeG0iCvxUk2JZHENBXzk9GLQEeBQVIpR/r5Zsg7UqR
	Jn/smv+FK6d3YcAj0VL6RlPTYf8Bs20cwM8fiFbk6Ez9aN+jnoA0DxogqcLPc3U2E5mx/hBR2Y6
	bOgbWPpRoVPODA/ca9mxeRJzaCYhZyDRNoCBiSn3p
X-Gm-Gg: AZFdTZdvttQ6GYsj2Yplzj4GeTrfgLCvG9Ewzm8yRaxhcNM1wXvf8pPdUqCF6T56X2g
	pQC7+UpqRijI9HUW8AGnDPy1yOP5ErMq46gGgv6612HIsQOMS7TsuR22NCmCYh2BceZQTKZRELw
	qnt39LK8KcnF7IH/cmJ7CSMyb65gGZi45MfR2+JFKwRvXa9TPqLTojy7zOK4p9R/860t9dWuHe0
	F+V0gR8uX+ybY4i91SaNL4YT7V13dzBhMqrHvVbMgj8OGrgAkBcL+bRcnoLpNlPzb9YtPWHiya9
	CgOeNpuLkItYJhYo00Yr7/6unDkGf3eo1xZnRKy3B3M9VkR5MVp2u5sZFcxcHd/Hk61gZp/kb81
	Iu/IUo7oMreZ7OvfUDpxWCBY8zrjLxbtbQgrZ4FpyILLhvBl0JSYYl4XrINdpS1eaCAEuCM30do
	ZK0PqiK8vucinXbQ6aND2v4GC2ryhcTfzoGeO3g4ssM/0ZG/x/Cjc=
X-Received: by 2002:a17:907:8e90:b0:c50:5186:a428 with SMTP id
 a640c23a62f3a-c513a87d9edmr1227142466b.27.1795554684471; Tue, 24 Nov 2026
 13:11:24 -0800 (PST)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ac22215d-3e58-4aab-851e-47c30836e058@app.fastmail.com>
 <20261027231728.1466446-1-jthoughton@google.com> <32fad21b-5bad-4640-97df-ef0f638cd9e9@app.fastmail.com>
In-Reply-To: <32fad21b-5bad-4640-97df-ef0f638cd9e9@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 24 Nov 2026 16:10:47 -0500
X-Gm-Features: Aa3M54qLiZYW-OI4p5Ie96tNauNpwSe6qBub2eVFZl5dz1FgCFOseL6mdcwJEy8
Message-ID: <CADrL8HX5vb1PGDpWzp-eR0rNfsMCVUhFa9vp_WZZx2eJZ+dfXQ@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, David Sterba <dsterba@suse.com>, io-uring@vger.kernel.org, 
	Jim Mattson <jmattson@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Kees Cook <kees@kernel.org>, kvm@vger.kernel.org, 
	"Liam R. Howlett" <liam@infradead.org>, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-perf-users@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, Chris Mason <mason@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Ingo Molnar <mingo@redhat.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Paolo Bonzini <pbonzini@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@kernel.org>, 
	Sean Christopherson <seanjc@google.com>, Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arnd,

Sorry for the long delay; I am finally able to get back to this
series. Thanks for all your feedback so far!

On Wed, Oct 28, 2026 at 7:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Wed, Oct 28, 2026, at 00:17, James Houghton wrote:
> >>
> >>  - does there need to be any compile-time configuration to skip
> >>    the extra checks and/or the warnings?
> >
> > Since patch 10 moves the warning out of line, it costs nothing on the
> > fast path, so making the WARN configurable wouldn't save anything. The
> > question is really whether the mm check itself should be configurable,
> > and that check is also what makes the access safe.
>
> Right, makes sense.
>
> > The text size increase seems manageable[1], but it would be great to
> > hear other people's thoughts. For the runtime cost, I'll do some
> > performance testing. My guess is that a load of current->mm and a
> > well-predicted branch per user access will be negligible, but I'll get
> > numbers.
>
> Sounds good. I agree this should not have much of a performance
> impact, and for the size it is probably as good as it gets without
> a major rework of the lazy mm switch.
>
> >>  - are there any cheaper ways to make it safe than to add a
> >>    condition on each user access?
> >>    E.g. the original lazy mm switch was intended to avoid
> >>    expensive TLB flushes when switching to a kernel thread and
> >>    back to the original task on 32-bit x86. On modern CPUs,
> >>    the MMU can deal with multiple ASIDs cheaply, so turning
> >>    off user access in a kernel thread may be cheaper than
> >>    adding code to uaccess depending on the architecture.
> >
> > That's a fair point. If user memory were inaccessible in kernel threads
> > and after exit_mm(), every such access would fault, and the fault
> > handler could WARN about it (x86's do_user_addr_fault() already has a
> > !mm branch), so it could still be loud without a check on every access.
> >
> > I'll look into disabling lazy mm switching on x86 and doing some
> > performance testing with that (like comparing the per-uaccess check
> > with the added cost of non-lazy mm switching).
> >
> > Other than the performance difference, I see these issues with making
> > uaccess safe entirely with the mm switch mechanics:
> >
> >  - It only helps on architectures (and configs) that implement it,
> >    while the common check works everywhere today.
>
> Yes, this would probably be opt-in by architecture, unless we decide
> to give up on lazy mm switch altogether and pay the performance
> penalty for that on CPUs without ASID support. Either way it is not
> be something we can do right away but that we can still consider
> in the future.

Agreed. I haven't collected performance numbers yet; I'll try to do
that before sending v2.

> >  - The fault handler would need to tell legitimate faults apart from
> >    bugs, e.g. copy_from_user_nofault() from BPF or perf in a kernel
> >    thread is fine and must stay quiet.
>
> Would it be possible to move those checks into the individual
> callers that want to avoid the WARN_ON(), with a comment on
> each one explaining why they do that? It feels more consistent
> to always warn here, and I would expect that for most of the
> _nofault() users we do want the warning, and I'm still unsure
> what is special about these.

Yes, I think that is better, and I've done this for v2.

The _nofault() users really did need more scrutiny, thanks Arnd. They
are special for different reasons, and they differ in how we should
handle them.

1. They can run in any context. Many of the BPF functions like
probe_read_user*, probe_write_user, user dynptr and bprintf helpers,
etc. are like this; a user can just attach a BPF program to places
where there is no mm. So we should fail the uaccess but not WARN on
it.

2. They run in process context, but use nofault because they can't
take page faults. btrfs's tree search ioctl is an example. In these
cases, a missing mm is a bug, so we should WARN. So v2 will fix these.

3. There are three cases where it tries to read the PC while handling
an exception that was taken from user mode. In these cases, it should
always be the case that `current->mm` is non-NULL, because we just
came from user mode (i.e., when user_mode(regs) returns true,
`current->mm` should always be non-NULL and pointing to the correct
mm). So we should WARN if current->mm is NULL, which v2 will do.

4. powerpc's BHRB decoding is a special case; I'll just put this in v2
and we can discuss it there.

So now in v2, the _nofault() helpers themselves do not check current->mm.

I've uploaded a draft version of v2 here, in case you want to take a look:
  https://github.com/48ca/linux uaccess-v2-wip

> > The series handles that today by
> >    checking current->mm in the nofault helpers (patch 6).
> >
> > The two approaches are mostly complementary: if non-lazy switching
> > turns out to be cheap enough, an architecture that does this will have
> > better defense against uaccess bugs. But I'd still like the common
> > check so that these bugs are reported on every architecture.
>
> Agreed. My main remaining concern is about the number of functions
> that need the additional check, if we want to avoid missing
> any of them. If we can have the check in access_ok(), that would
> cover the majority of the functions you are changing right now,
> and it looks like we can deal with the corner cases individually.
>
> Since in principle every user access should go through both
> access_ok/mask_user_address and current->mm check at some point,
> so combining the two as much as possible should help long-term
> maintainability.

You're right, and v2 has been restructured like this.

- The check is in access_ok() itself: the generic version, plus the
arm64 and riscv versions. __access_ok() remains a plain range check.
- The callers of mask_user_address()/masked_user_*_access_begin()
check current->mm explicitly. There are about a dozen such callers.
- The unchecked accessors, __copy_{from,to}_user()
and__copy_{from,to}_user_inatomic() (and arm64's
copy_from_user_flushcache(), which also relies on an earlier
access_ok()), keep an explicit check for now. Once their users are
converted to the checked versions, those checks can be dropped.

Compared to v1, this also covers get_user()/put_user()/clear_user() on
arm64, powerpc, riscv and the asm-generic architectures, and arch code
like signal frame setup that uses access_ok() followed by __put_user()
or unsafe_*(). user_access_begin() no longer needs its own check.

What's still not covered: x86's get_user()/put_user(), which do their
own range check in asm, a few architecture-specific paths that call
__access_ok() directly (e.g. on alpha and sparc32), and arch code that
calls __get_user()/__put_user() without access_ok(), mostly trap
handlers for user-mode faults. Probably best tackled later.

>
> >> There are of course few enough of these left that I think
> >> we can consider doing the same thing here and turn them all
> >> into the checking version:
> >>
> >> $ git grep -wl __copy_'\(from\|to\)'_user  drivers mm virt
> >> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
> >> drivers/gpu/drm/i915/i915_gem.c
> >> drivers/gpu/drm/i915/i915_query.c
> >> drivers/usb/gadget/udc/atmel_usba_udc.c
> >> drivers/vhost/scsi.c
> >> drivers/vhost/vhost.c
> >> mm/kasan/kasan_test_c.c
> >> virt/kvm/kvm_main.c
> >
> > Agreed, I think we should clean those up, but that can be done
> > separately. This series already adds the check to the common
> > __copy_{from,to}_user() and __copy_{from,to}_user_inatomic() wrappers
> > in include/linux/uaccess.h (patches 7 and 8), so the KVM path is
> > covered without converting the callers first.
>
> Right, if dropping __copy_{from,to}_user() as global interfaces does
> not help add the check in a consistent way, that can wait as well.
> It looks like we are very slowly converting away from them already,
> as we have about half the call sites left compared to v5.0.
>
> There are probably few enough of these that we could address them
> by either adding current->mm checks or converting them to use
> the full versions instead where that is an obvious change like
> that usb gadget driver.

Sounds good. I'll send a separate series converting the obvious ones,
starting with the usb gadget driver. I think that will be useful.
Let's see how far I can get; hopefully I can drop
__copy_{from,to}_user() completely.

> >> As a quick fix I would probably start with just the 'if (!mm) return f=
alse'
> >> bit here to get something merged while we still discuss the other
> >> details.
> >
> > Making the same point as Sean[2] but with a little more detail, I had
> > thought about making the change in access_ok(), but:
> >
> >  - On x86-64 and powerpc, the masked user access paths don't call
> >    access_ok() at all. That includes copy_from_user(),
> >    strncpy_from_user(), strnlen_user() and every scoped_user_*_access()
> >    block, which is where many of the converted __get_user() users ended
> >    up.
>
> Ok. Apparently there is some of this on arm64 as well, using
> __uaccess_mask_ptr() instead of mask_user_address().
>
> >  - __copy_{from,to}_user() and __copy_from_user_inatomic() skip it too,
> >    and the KVM bug followed exactly that pattern: the range was checked
> >    once up front, and the access came much later from a different
> >    context.
>
> Arguably this is itself a TOCTOU issue and replacing
> all __copy_{from,to}_user() with copy_{from,to}_user() would be a better
> solution long-term, if we can do that.

Yeah, I agree, that's another reason to get rid of them.

> >  - access_ok() is also used as a plain range check where having no mm
> >    is fine. For example, copy_{from,to}_user_nofault() call
> >    __access_ok()/access_ok(), and BPF and perf legitimately call those
> >    from kernel threads, so a WARN there would fire on valid tracing.
>
> These at least could be easily worked around by just skipping the
> calls to copy_{from,to}_user_nofault() as mentioned above.

Yep, and v2 now does this.

Thanks, Arnd! I'll send a v2 early next week. I've kicked off
syzkaller against the new version too.
