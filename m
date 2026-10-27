Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793122223;
	b=xGjI2aq6uuol/g/UiBQoM2wkTe6XR8cNhmCcNuKdWxz2QyzwU1Rt1sYTjJ6/OgM7uDoH
	 NhUMk1Gpf4tPMof7YuDCKO2lOftdC4LVRuJeGaCIAs2a8OewGPSeocrBZGu8eMag78var
	 +bibQUi3jbUcm/IEQLx6TzzEnBTKExkZ/35sCLOc2VdrMzsG/misvB0sPEsoQr/fWbDXA
	 zvC+lVvYUVE0y57Z0AR0e7i6fIKylgHt9/GZHLLojuyFGcVVZaUYX5O4bb9uBXI+MnvQE
	 lKE5BRthI6m80Sk0L8ZLYuDx3GQB0JkdS+fTzM+BkRUyLLrGzWleZ6EcLXbD+bQkfFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793122223;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
	b=r/9MXgzBIeYrkwUTUAI/UaxhABphARlLyt7CnrauSgeLBaD3Day6qe6vPIYJy7T+65fT
	 T69rtrsqoRihFlSgYqa0w6iK1z8kG/FTYE3wsDOTMx39lyx7ZaTXL9zcRWidz6MEQhWCb
	 SgG47/4lB8Ps2BB/e6RLnj1kjwP86deSTxGWeKgegkmgIH18XD71lULNcM4JEPc9Gdzfb
	 HEnwqCtTxp8mUEfNPIi3xstI9/jvnuJkoNaG/U26ADRst8os7J3e2N4iJTTRXdLR7T38n
	 AzkL/Fo+S06uP1f/j9vXkn4FtAoDEFutcvOB02KRoR5hN/qcSVoy8VvFSPN+XfCnJCg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH5XVSYu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84949606A320
	for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 17:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84949606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=AH5XVSYu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c34bff61551so8949066b.2
        for <linux-perf-users@vger.kernel.org>; Tue, 27 Oct 2026 10:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793122222; cv=none;
        d=google.com; s=arc-20260327;
        b=NkmhanWfSq0vpmA8NZc93YkwfSyhC2Uzy8E3bQhy1qwfUDQxcvRKEAbhipQ4FZzxJ6
         PPZeOJISs3K3lQxyCpOj5i1zrPgeFzeW8SXlofo3CsHbERCwavgzwvuYZocSkPQnhmIh
         Wt7ZUgs2f3HojhGCzw4DoloaHQS8arLPNmW9R2s8rCeFilSpmzOrVEQIAyvQr7vTebR3
         FzNkPeZHmR34L6pJ7YKGPvarv9PXymdU/DQQpbsEg6Rr60S17XBeHIzFmsJCajooFLFY
         6mZx7b7n75p2MrJbdufVZ7e3YhTH8uXPkWnvJRG/OGMfVyLjf+krkTsgjUynTYZH6O4f
         Ci9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        fh=ShdUGc/Gm6G5myk60+9l7joBjedU/HRSIi6kUJLRL3s=;
        b=d6LePHAzigVgan4bFDN9YgqOsDR08Zm4ka2IwJfeJCk7ZQCCp+L/WwVJj+tfZerdCr
         PIKNlHD9lB7kWmItnX7og56HObk/yWmkOqrXQjVN2+ynHJ55bXpviWppHO/AjFYsRfWd
         IsO0WsWyNNm+RamaLzLACLkejM8YnMYOsQD/1lBzHmNVs1DHXHcXxpoE6QNQ73Ajgt3g
         EyPYBn5jijPh5MNXNhd/14aArU0rvpGhxdZu/1iGyzSEeUxwGI9+bG8rFwYKcVSIKBMD
         TSTI36sAEL2RkKSIYp1Ak4nnifcbzMpqMf09u9S+rSa9g3QUC/GP+yhYwD+q8bt99Sw3
         6AIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793122222; x=1793727022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        b=AH5XVSYuq6HUx6QejcrLzJHXiZbWI9DboIxOz+yByNgh84gxZAIKBuzZHV99EG6rqB
         sL71z4Wm6MSPA3Nnza0i731ilrImuFj3jUTow6hkS/0r7bYzxQobbOzdeIyt6ASGeEbF
         yTa0PHt944q+HSgG6NrCVe3wZJYFAVwhpzaLqX011nHEVLqO4I7UJy1zd5cfMTXQHdaA
         BSUKBBxl7R08MamwKyO7Ss8mI2wGFLi7Y2RxS2XZ75lMQCOMaDZ6YNjy/Um35SI/BQEx
         H9A/IMXo16KCWMivgQdBOKUL0g+UWglSQzebhEs3U4Ckl7bH2Y72gGHNDHSXACje/sxH
         22yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793122222; x=1793727022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7gQ+97vReKa4toS9130cb0MEUCUe5fofr2ehSKz/dNw=;
        b=xQL2TNBXrFFg98XZ9jV8DRArxl3RGCrGwGlW9rCQZJS2DfV3iYHv9BztLGlQbA+nxv
         s0GVqBidlDAm597M1XoryXjJi0Sn+UiAreOdQezLL3xXJtTjCQBy1gfP0U9pLaLOA2E0
         cI9RU55FIMv4yq3zBQCjnhqGJARUARW+Qvf0RV50OrFDDlF1WJ4uypkOGBEcNyC3NtAf
         PemFQRLwNXrGef9gBAh0/xhLOf7C2y9MZZ9Z+Cr39AjWfkxcSKz7fA4PyZH0UXpoOeUn
         HKwMXCATSMB8VbvhhNTzJVtVgFD6ENNiqjwcD04AiDU1psT75n7SnCm337Rpv6ZPqaI4
         ULFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxSKsPOQlFAkZm7Yry1VjoWB5VRJ5enrPB8FObA50nPUb7we7mHMHM+QwsGxde2xywvQ1q5jvAckcwBkLRbEucG@vger.kernel.org
X-Gm-Message-State: AFq9FYLthuqw37o02DW889fEpCiLW1BqKaVcpcPZYo9XW/tSlLVSmwHT
	Xhy5zlKbt2+W606trRwxwJBOq8beLI25qCos6zVAYI5+rAUd5w0PAXsGIcEkushv7l8t78OE4Ur
	BZg7rvWJ8IRXgUTIxcl1pv85WzqMYXk+VDRVoeo+b
X-Gm-Gg: AYBFou3ADDWuYqdJuaNf9o9KiCnwlM/4aKgCWE+yhFyoXaRDauWRV2RYX9YQxe/JZ7C
	ZeoEfZ6abpeVj2YMc2ynkmKsAuwLm/4g6uKE54qBgyJJJkpZX+drPWPCK1H+Dz8zmC+21wR0d2k
	15wmzZDFWt0SKdfnBpllLFD8HCtgyTfiNWy3Ykf+lhXqDBmTz5WebY8aa4CB9ByOUPp5325j4Mq
	93U99NodopN2HBFiLmlAEQrr0vMcsN9rLyZZmQ01raAMxseL/wKtXy6U+v800JSirU/JZWRWKnX
	ZLvUvNzr6QZMDQhXuoZfRKdIMtEiUUx/wOKT0ypd5QJcBA+MftnV/D0kI1SIpNe6fj+zw0t4Sv9
	qbitUzxmRwGsJREW/btbZ+bhwDGnb8g2zq4CTBhpXIv9I+wgTdcZm/U6NIj1Z8OWwVwnrFafrf8
	pklLweTlUQBHlRo/GvDywnwtzf8gXGt1TpgxeoFbaUsft5mTO2yj/HYm+u3gI+0iwUjD5joCnfa
	3X5KYqmsMqopVtIIO1FJNNFXAtheHNAbg==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr1178260566b.39.1793122221137; Tue, 27 Oct 2026
 10:30:21 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com> <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
In-Reply-To: <14f5f919-55bd-47c6-a1c8-6f1445cce733@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 27 Oct 2026 10:29:43 -0700
X-Gm-Features: AclHuK_V7ZmMdE83iy-wOvaliSqHMUcbKVcnfqQwnRgRgjPYRFDHKTZOMwXOk5E
Message-ID: <CADrL8HXQdzcroeGN-ACjyy-jSAdBNHiT1_BCVVe0P+Y8ZueiyA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/10] uaccess: Refuse and warn on user accesses when
 current->mm is NULL
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Thomas Gleixner <tglx@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Jim Mattson <jmattson@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <mkp@kernel.org>, David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 5:13=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> >
> > This series comes out of a set of bugs that were found in KVM where the
> > kernel can sometimes write to a random process's user memory[1]. The KV=
M
> > fixes at [1] are still required, even with this uaccess series, as note=
d
> > by Sean here[2] and below in this cover letter. The beginning of this
> > series includes fixes for similar bugs found through static analysis
> > with Claude Opus 5.5. I don't think any of these bugs are more severe
> > than the KVM bugs[1].
> >
> > We hit one of the KVM bugs in production, and it was challenging to
> > debug. This series makes such bugs, where the kernel is doing uaccess
> > without an mm, much more obvious.
>
> Nice work!

Thanks!

> > Such an access does not reliably fail. The user portion of the address
> > space belongs to whatever mm happens to be lazily loaded, if any. If
> > the access faults, the fault handler refuses to handle it and the copy
> > fails, but if the page is already mapped, the access silently reads or
> > writes another task's memory.
>
> This sounds like the problem depends a lot on the architecture,
> and to what degree they implement lazy mm switching. If an architecture
> makes all user pointers invalid for a kernel thread, this does not
> actually happen, right?
>
> E.g. on arm64 with CONFIG_ARM64_SW_TTBR0_PAN, the page table base for
> the current process is only set in user_access_begin() and would
> not point to any task here. Without ttbr0_pan, it should be
> covered by cpu_set_reserved_ttbr0() turning off all user space access
> for kernel threads.
>
> Should this perhaps be addressed in architecture specific code
> instead of in a common place?

You're right that whether corruption can actually occur depends on the
architecture and config. I'll write a note about this in the v2 cover
letter.

That being said, I still think the right thing to do is to have the
new check(s) in common code. Instances of improper uaccesses are still
bugs, even if no corruption occurs.

> > =3D=3D The New WARN =3D=3D
> >
> > The rest of the series makes the generic uaccess helpers WARN_ON_ONCE()
> > and refuse the access when current->mm is NULL:
> >
> >  - Patch 6 adds uaccess_should_fail(), which combines the existing
> >    should_fail_usercopy() fault injection check with the NULL mm check,
> >    and uses it in place of should_fail_usercopy(). This covers
> >    copy_{to,from}_user() on all architectures (including the masked
> >    user access paths, which never call access_ok()), the
> >    __copy_{to,from}_user() variants used by KVM's guest memory
> >    accessors, the user-backed iov_iter copy routines and
> >    strncpy_from_user().
> ...
> > The checks are deliberately limited to generic code. Accesses
> > implemented entirely by architectures (get_user(), put_user(),
> > clear_user(), and direct users of user_access_begin() or
> > masked_user_access_begin()) are not covered. Please let me know if the
> > new check should be placed elsewhere.
>
> I would think that user_access_begin() is a more natural place
> for the added checks, as this should be called exactly once for
> any function that accesses user space and also stays out of the
> way of the copy_from_kernel_nofault() etc.

user_access_begin() isn't used in a lot of places that I want to
catch, including the KVM case. Roughly:

  kvm_write_guest_cached() --> __copy_to_user() --> raw_copy_to_user()

There's no user_access_begin() in there. :/

I do think user_access_begin() should have the new check though, so
I've added it in the v2.

Thanks for the feedback, Arnd. :)
