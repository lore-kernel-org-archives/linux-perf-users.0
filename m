Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793058730;
	b=WCK6KsLqmvj2OBTjJ3UFj1j+SYJLhI64KmugC5qx1YJmTrVpitxB8ETTe9Tc1miwMTmq
	 aIS1gYXPtGnqATkptB9DbtLDdc3yLcncQMYIAE/zly7SrtcHNspLcVzEV8wdyzYbBq76g
	 DxFk9CkpSoIuoTS1g5sYtcSVHo039PPsL4nbqRHpjz4MnLuSBeECc39JY+Vtf1Ngxr1K1
	 MbNRD8LU7lx/FVUq8qFPCD4kej3ldaqko/8h9l7vwiLX3gfvqoBZXYsMrTMyO/N7r4uaW
	 Bk7GGIxaVGD+LwtzXJrEoLsle94rX/XBu1/NXPhgOv9Yft12fpykU3v/LwZSM4qOh/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
	b=RcjMiHAMuaVBGMjEP31opwRemU+YHOYsLzDAiLGxUk+ky3YYL68Top5mdUG4ZqBX/aO0
	 8/BCdEyum9wF45phP+CEcgvzJS68vdQt/jzxK0+JyvaaPFBQg7rNKBN5USCxtvbxA0PHs
	 dGhD0N2k9qH6iApQFrBBm79fnHUSGbA1xUXJ8uCrAVejDprTwZlV+gamZf0nPOe31SWqm
	 rW2Slo5dTal8ZmFOPp02wm3rz8C1JMm59OxxrFlhXsgXGmYm5HQJirAu3or3O+/GIRFXG
	 WVVYWfPPviRamlaXc3HKPrEhUzFa+Knc7m2KXM3SFWhDvRESISIL/tFBe3xFmeoQrKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77B606A31B
	for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 23:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB77B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=IrwijN25
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c34bff61551so525173366b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 26 Oct 2026 16:52:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793058728; cv=none;
        d=google.com; s=arc-20260327;
        b=LnAsWmlkBR3AHIohhhs1Et8G/7ict9F4lPbXmPCWT6TMqFvOYu/DogY+v2419ha1o4
         JKkwA/0d/7A7ObsrzIOaPnVkeIc+Cau/dh1jvwCkWJDiLqGKohELaTLK+VLfDJL7Nigl
         s2YTkpNEQSUTqK9ls6mmTPoaqelTlkItoTA0XUVT5sJINf8MW4i/BQxghXRuwt1LQL54
         evf/wMO3NHANUnVUODLgxhAoN7XTu4Gj2gPXbiMGVV8TK5lvQ9kpek2f5D/MwVxN/nNA
         mAwhyww4x3oEZOaCLSAoGoHc9Xklmtj7ygT0oEUPZ8W8XHE3NhNJw9fFxRt14zIqS64B
         av5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        fh=QLro3EF6K4S+oCkoFCGfNpJx4DslvrFsYeGqrS8rTVM=;
        b=KXcXcGo6UWZwaS7hVxMYpSepBMIIZMg1bcuXl4IUyoIL0W+a6qDBAGjCitY56hqyR5
         BkF09TtCQ0I4YtZtV47/oIiyg92WOJ/wzy6oqzEnimlAVwfPeB/O7sNNsYiV4Yed2UZu
         sBy0Fqym4juiW6sk6GQk8+RWtmhXyBqxQahDkH4X0Rs86vaQ1bdi5x+4utonU/SNeJLe
         c8Hhsky/LodMJBHGU3cSfeP0CaBk5vtPpzrZn3UOHGb4J+JeMoPCshxhU1E7wXLRPvq1
         0+IFnthCag+Ii3NSzRC+zl8QNEBAN4PxcNfYdJ+G6pJyfRKitBYBe8U1gPW8gR2IxL+H
         15BQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793058728; x=1793663528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=IrwijN25Y5XuhkNoEvpxTGUzu2F8Fw7yumOC6bQX+sv9sI5cIkUQ+8qDyW8Rn0leIE
         KD/M3UgHYaJH9qxw5QEzap4cvaO8QRp4WvUy/b8d8qlbP4zjT/NLwA46mVK4rk5TE67Z
         hbcIs7JRXy3S3BU1Zp46QexhDFTfTqhgb9F5yDiJoNepIvxVOAnGlUkvuMj53pVOulEq
         nY7AospiQUxyoh3b4b1zlSlhp0Xm7S9U0DWHUHqyywQpS6V9BxBGr6qPvm7+SL/x95K4
         vKS38fvl7h/D+VqUiNNcMPjyNlpB+LfGZlaoNjHo8oTsgp0eeolgiheQhrTjRg97kEV2
         ylBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793058728; x=1793663528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wkDgiw/AqsIfVPHoMoSGYbq8gYoliaNoZ6zCaoCS6us=;
        b=tZ6HxOUmZbyynETr3JyYXSSG7+w51k/tPZYIr2YzuRiTNmPp/c/QRs6s1cUuJDpGGr
         3E7867CGbmGGl6lXTKiO9SMyfgbgrbOpptawuDdm2ghj0wK1lOzU+j1aVx6J5wBKuIyK
         fkzVb96HIg5JJDbG/CtXLhZmQ/xGpRF185XYBQQSyh+bAWJX/2f8TQqFHtFihKOeW20d
         vDG0L+NdWJ7Bxu7C1KiFunQG1I6kGoD4mCzIByE6GmHjq0suqyruCwQOaZ8ZGLxwuDj8
         Hq5HXEehkV+g45Wucwd0XLITNIe9mXqLoldFFs+H3NyC+ZlARxE6IsQnU7CQ0YD4B5hH
         PHpQ==
X-Forwarded-Encrypted: i=1; AKwUvBycUYFOI1kte76JPJ+zZMBqZDxWAgV5gfChmTj37AF/XK28SIEQVPsSF3SUc8K1sFP23SFlWEJdV1FzSj8gwzl3@vger.kernel.org
X-Gm-Message-State: AFq9FYJ96lK1v/l5rmbbEBlwu7iQDf4UeqgMTVkH4LGKwfx1qPmLqNkb
	Pzt9pACkAhwWbAssy/kqZQkhC1C6Jg36+waryCq1+lD2gKsXJbzXJGqGfC/DHEeFXI6USWupXib
	Y9Pm8j9kDILrHXkKf3+erjJfCll39SS4YKrnQ8g9g
X-Gm-Gg: AYBFou0+ywOq5XUMTKV8jw40+RCa7hq4+TQ4+w+pS3+HHIi3hS9Spu+iBi1k297GNr+
	AG9b1Vw4IsaFsyYTxmX476Ejkbt14PuX+wmiIyrQMQPZdwAFRIHn4a/2aHrT0FW+WiHureG3z/T
	wMv9x76ng5T0AI9RFztgl1QsFSAe2ulclMSYdC+w10H/Y0DW+k9a0IR14xijA4gEHPiKW6PhSIw
	c/BPBLau6RA2rCRP6hvZ+u4sqnQPDcFaCLhSdYUQYsngHszbaBLYmyBxw/4Z3f6vBVxGGe2QM3I
	Se1xbbfr6c15X83eoW0mDDcFGbVCSLoaMG/wnok2jPNBKBGVcKXkb+mnTWO6DuC3YYO0PxUDkXk
	ynHV1D+5Lm+Pn3bDGmZQi1Ry1NS3chX8K1E9TK8/8MjKcvH+t2URQ6K4NESUKmVgenkeXcV/+7b
	qcOyOH87t+cCX6sgo39x69CqSZYbToq+l80R7uW7J5HmBTWoptqc4prC0O8N6IOm9ZH5btWkC0f
	KmqtRsxwA==
X-Received: by 2002:a17:907:80c:b0:c46:6a50:40c2 with SMTP id
 a640c23a62f3a-c46bdee2675mr943075666b.39.1793058727681; Mon, 26 Oct 2026
 16:52:07 -0700 (PDT)
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-1-jthoughton@google.com>
 <20261026215226.3713941-11-jthoughton@google.com> <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
In-Reply-To: <3b0a8fc4-d140-4a90-b810-cbc1283fc083@app.fastmail.com>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 16:51:31 -0700
X-Gm-Features: AclHuK-Nhf6TYTDNWSq0v6hReecRKBdo5ExoV8oZWGVCIO9BK-126Jv082Kq0QQ
Message-ID: <CADrL8HUZ3t8RdMEeBPfqsy1_1rN0Ty9B2c4iP6OzNS12te6vOg@mail.gmail.com>
Subject: Re: [RFC PATCH 10/10] uaccess: Move the NULL mm warning out of line
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

On Mon, Oct 26, 2026 at 4:03=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> wrote=
:
>
> On Mon, Oct 26, 2026, at 22:52, James Houghton wrote:
> > uaccess_without_mm() is inlined into every user copy, including every
> > copy_{to,from}_user() call site on architectures that define
> > INLINE_COPY_USER, such as arm64. Each inlined WARN_ON_ONCE() adds its
> > own __bug_table entry.
> >
> > Keep the NULL current->mm check inline, but move the warning into a
> > single out-of-line, __cold function, uaccess_warn_without_mm().
> >
> > The trade-off is that only the first offending access in the system
> > warns, rather than the first one from each call site. The stack trace
> > still identifies the caller, and the access is refused either way.
> >
> > Compared to the base of this series, with defconfig + KVM:
> >
> >                      inline WARN_ON_ONCE()    out-of-line warning
> >   x86_64 total       +5,884 B (+0.014%)       +9,714 B (+0.023%)
> >   arm64  total      +40,948 B (+0.10%)       +24,609 B (+0.06%)
> >
> > On arm64, this removes the ~16 KB of __bug_table growth, while text
> > size is unchanged, as a call is the same size as the inline brk. On
> > x86_64, the call is larger than the inline ud2 and causes more .cold
> > splitting, so this is a slight regression.
> >
> > Signed-off-by: James Houghton <jthoughton@google.com>
> > ---
> > NOTE: This patch is included for reference only, to show the cost of th=
e
> >       inline warning.
>
> I would suspect that the growth is larger on architectures that
> don't implement __WARN_FLAGS() but rely on the generic WARN_ON().
>
> This would mainly affect 32-bit arm and mips machines, some of which
> are very memory limited, most of the 64-bit architectures have it.

Thanks, Arnd! I ran some build tests on 32-bit arm and mips:

arm (multi_v7_defconfig):
 - base: 31,913,726 B
 - patches 1-9: +64,816 B (+0.20%)
 - patches 1-10: +23,193 B (+0.07%)

mips (malta_defconfig):
 - base: 11,830,177 B
 - patches 1-9: +61,168 B (+0.52%)
 - patches 1-10: +25,881 B (+0.22%)

I think it makes sense to include patch 10 with these results; cutting
>50% of the size increase for arm and mips seems worth the trade-off
of only WARNing on the violating callstack. Let me know what you
think.

Is the increase even with patch 10 too much for mips or arm? I can add
a Kconfig in that case.
