Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795625055;
	b=Ap/MSgoQ60SHzMqOufOBqx1mJZP5wfq4LBjxB6CLs02Me01rbefx1647INFdqm0AROSS
	 B7EDFq57OcP5oDwArabxD8HCUEx0rcsjX2E1ltWlGma92vDwrooqaQAYsq3kLyCVOwNMK
	 58PfTLNp00J9Ol5Xf1Qxb9fuj5QuNCuoehHMwoILSVkZpgr3yKk5i10vkF55Y0/arvhIR
	 /93Tnj/sINim6q6uV5VZOb4WnEbbwCtOWjQRqPhn3dDm7Js2Bo+DioYTKkSTbucICnrrh
	 u0Cnhp+NKFlKCJERtxDemzIIP2ZLt4+YJtLYL4ckVyfuT6NiU9jKLeWcUCGRoL7ljsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625055;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
	b=VHl1fPhVXOiKS/vvyDHDBCdBX9XCvRownV4blM66DThXMI7nOPL4+t++K+UadpXTCD+y
	 ntcWTkbzujbTLBthj5O3P1ydp7mFwJVSsVdQ2+yVK4MVMvnG+6haqQnyo1CnMbLRszLDQ
	 nHyWMU+kkko/pZpxYz9K4aZvq+/rSFeKY/Rtdr6XmNTzbOOcha3SPX7k5rOeeeK1itIfT
	 d5GWvrC2tkE420tjHnGYWK+V8VNHEWj59qsF61C6GLeiE/0HQP35ojDxZGChI/+XDyIiZ
	 p+LEcFflC/4DdzNIVRMo7vyfGu7PTZysgT+YN6lBNYl2P89AZjm0Df7rFNTMzbcjVbw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8068E606A32E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 16:44:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8068E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PKZ23RQe
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d21051042so113066566b.0
        for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 08:44:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795625054; cv=none;
        d=google.com; s=arc-20260327;
        b=hR8JqPMucD7vsKaJuyXLkOU3r/9ZVIvFQo8WNmiE9ViL/aWjz5yzzSNULwSZY9BObf
         7EaikiD6XvUF183Mthxqbx5q8FhSWRccR7L3EqGm008B4iOfPE4bJ4+95NtJV8qMdTQJ
         8DUcR3raBJU6AqiXsFQbonVtMOjvqXQ+i6XCNaSW6gN2hsZutC+5avzwKQFOYemQaui7
         fX+Vt+SKlpxJOIpcADwhl29vmynKyimCCC22aKh2nvu+awHjKVDIDbaf88nxVehWaV7V
         aAdqECTBbHLYDS/F0RRTNpAcZwf0RvIMw3G0CoE59GwUZxhSVAm5A8varhYxqRY8vXY7
         VJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        fh=ThPJs6xdHe75YBqfPQ7gotrXXybUbTT1REOuR7QrL/4=;
        b=hJyZ1jxH0vX0nrLSEnUi7/6HuZ7cQVA2bY/GR1Hi2+ouObNsVNj+Kf08TTeEXkeCpE
         vydCelNPTh8ZxEEu1x4gM6nTCqkrdvPscVjjP3EJ68kQY7P1ERPi0OPh14gvAzkE5vdZ
         NOtKBUg8O7LowWLR79NTmnPZf7Ok8lIMnnVUPeanibymfIixGR9ZPE9nytKSsPc3B648
         E78ArLoznVSACfcLibyq4OdVrv82IwdVfYf4U4GWHEefVxu1qwCByrdTMU3eeSu4WjKa
         CNMczFiwtPT+R8L8tNbqXC0a0ri/S4w7pCjf5VVeCzhch+Bi7kt16UoqD5ow/aacmr3F
         VdOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795625054; x=1796229854; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=PKZ23RQeMEttotX4OBPRP2DbbrMEB51nwAQlsHi3Clsl60+KLwydytyVzIwS3CPrsp
         gMCa0qLojqUmZPTj1WgDWb2vfDDzy8I3ouZC6AtzVQzGhYkAtsdS7I194LfKbKzPHVBH
         9FjnQKv/TdlaTy27yqxtS+FRu+TCtlSdjsR4QOyB9tkMnDrs00BEwfTTEGdJNrrE0d1S
         i0G3BgU+8ocwt4ScMKi+JN47+02WlDqK9aHu8g0fQCVcWCnmaTG9N306L0mPKog4H/f4
         BgsXgGhnHP8RFqRdmh8kRVgxVbHO2JS8qa43xqFnpf9P4Z4Esbd1QfxvoHuOMiibIYtV
         4BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625054; x=1796229854;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II/aro/lwWCAag041h9klo86GZWrpoxtriGNBQNlDMw=;
        b=ht5+eSuWAtNaYUwm4LdgBUlC0b0cHnZ5iWcrQT+rAQ44PTlzgtqFOq3tkbn2j5xxw5
         RSO/KrydGyTHMr1gshikPZ78Tbdc14gmQT97V1MyGdVGyx7IiIIxTWZibKIqXsgWoK+W
         zLt8QD86dYKUaLVDTC3ZZtQt0qumKMaw5DXy7ME29BM4oUdtMtpFAutF/rXzrsYJw/6o
         q/CcFjFCHC7+oG5XnuW3gvzo+1bUe10u+bte1++xCXcaltCzg13K/brXc2hLsu0AZJeQ
         4uijQZWfG7RMY8UZSu3XvNB7XvjN2Usm5FdtKcxft9DMCKDmPW7Kav8cbKO6E22+EG2G
         CkQA==
X-Forwarded-Encrypted: i=1; AL+hErEaMQJ7c4ifom2vBvcnOH/1tiRK9VT8i+llqILfXBAPCampjfAaQmAFlK8zdKSoD+e20hNLCDFwBGlNJkShdXh9@vger.kernel.org
X-Gm-Message-State: APuU4Z9OXfWyR8PAFra0PFbALCv29c0GVBg30NK76pTq+bcUVCgvALWT
	CQMLK1QBP2s0vj9xP+xRCSZgUzaCxbx8hiYIgrf5Ti42V8MMcRHKxxLRuNSVFGRLzMAqeNEYjE4
	CBgzvj4qyOIbtn3U7Qm/+KNVbRektjqiH2+VdvzLy
X-Gm-Gg: AZFdTZe8ZAuvDXmHAq/SIjkW1w1WYfnERIPbzcnPaoIGYUQVfpBinH0+/SgoFxURHko
	Mexc5Kub6BMKtzVENuyShRzWZxto35Ngh2qpULY3o7ZUwbWtSVSlUlIn8Y7Acg0NnnYWLquQ5h8
	Mj7b9NppkTxMDsQR1CZCxXdp17XgFXfrZAGIPepyTV+hXAsQuuLompjuXkaJ7o1bIimBD4ibWOE
	zLe3ZjUOKTlpO1LVoxgmXtmbXSrah497sUxmYZf4/fFjbQXVNEiYthH8vt7br7tpNXkcjG4O6l/
	eW2lVvgmVGhQkha4Fb5l8DuhU8vtFDsrl4q9jm7/iylYkvlXMAzGEdt6fJEnDIsB9d+PZjvd/XO
	VxqtYzpRvbfTpeby32DCvKmk4zhghIdYbbOFJ104d1GVJNpgEfWL1oaQ9spdst3DDn0aj0WMpQP
	0Yrz9cQo8LPInvgT/DXUnnDR5F5/hp0pOW4jDEI+HvYeNjNY7wHOY=
X-Received: by 2002:a17:907:6d22:b0:c51:40e:847a with SMTP id
 a640c23a62f3a-c513a1e6fdfmr1639688066b.0.1795625053094; Wed, 25 Nov 2026
 08:44:13 -0800 (PST)
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
 <CADrL8HX5vb1PGDpWzp-eR0rNfsMCVUhFa9vp_WZZx2eJZ+dfXQ@mail.gmail.com> <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
In-Reply-To: <1a99e5fc-129e-41e3-8420-101bcf04b366@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Wed, 25 Nov 2026 11:43:36 -0500
X-Gm-Features: Aa3M54qTCDON0Zo2YJDXp5pBtwrXjTcYjv8NoqDjQS_XV_tl8JrBb-LQVlKEL3Q
Message-ID: <CADrL8HUOZs-vWRyM9p+Na-=arRU+Gx_cWMLbxHmUYnho4fAUXg@mail.gmail.com>
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

On Tue, Nov 24, 2026 at 5:02=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Tue, Nov 24, 2026, at 22:10, James Houghton wrote:
> > On Wed, Oct 28, 2026 at 7:14=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> w=
rote:
> >> On Wed, Oct 28, 2026, at 00:17, James Houghton wrote:
>
> > So now in v2, the _nofault() helpers themselves do not check current->m=
m.
> >
> > I've uploaded a draft version of v2 here, in case you want to take a lo=
ok:
> >   https://github.com/48ca/linux uaccess-v2-wip
>
> I read through this now and it all looks good to me so far.

Wow you looked at that really quickly, thank you so much!

> >> Since in principle every user access should go through both
> >> access_ok/mask_user_address and current->mm check at some point,
> >> so combining the two as much as possible should help long-term
> >> maintainability.
> >
> > You're right, and v2 has been restructured like this.
> >
> > - The check is in access_ok() itself: the generic version, plus the
> > arm64 and riscv versions. __access_ok() remains a plain range check.
> > - The callers of mask_user_address()/masked_user_*_access_begin()
> > check current->mm explicitly. There are about a dozen such callers.
> > - The unchecked accessors, __copy_{from,to}_user()
> > and__copy_{from,to}_user_inatomic() (and arm64's
> > copy_from_user_flushcache(), which also relies on an earlier
> > access_ok()), keep an explicit check for now. Once their users are
> > converted to the checked versions, those checks can be dropped.
>
> Ok, sounds all good. If we get more than handful of mask_user_address()
> and masked_user_*_access_begin(), we can always revisit that interface
> to make sure the check can't be skipped, but for now this seems
> like a good tradeoff.

Great!

> > Compared to v1, this also covers get_user()/put_user()/clear_user() on
> > arm64, powerpc, riscv and the asm-generic architectures, and arch code
> > like signal frame setup that uses access_ok() followed by __put_user()
> > or unsafe_*(). user_access_begin() no longer needs its own check.
> >
> > What's still not covered: x86's get_user()/put_user(), which do their
> > own range check in asm, a few architecture-specific paths that call
> > __access_ok() directly (e.g. on alpha and sparc32), and arch code that
> > calls __get_user()/__put_user() without access_ok(), mostly trap
> > handlers for user-mode faults. Probably best tackled later.
>
> ok
>
> >> There are probably few enough of these that we could address them
> >> by either adding current->mm checks or converting them to use
> >> the full versions instead where that is an obvious change like
> >> that usb gadget driver.
> >
> > Sounds good. I'll send a separate series converting the obvious ones,
> > starting with the usb gadget driver. I think that will be useful.
> > Let's see how far I can get; hopefully I can drop
> > __copy_{from,to}_user() completely.
>
> Ok, perfect!

Thanks, Arnd! FWIW, there have been no syzkaller issues so far with
this WIP v2. :)
