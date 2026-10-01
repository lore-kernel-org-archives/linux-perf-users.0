Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9235C448D03
	for <linux-perf-users@vger.kernel.org>; Thu,  1 Oct 2026 06:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790834480; cv=pass; b=N4Auu6qgtMnu4aPyFpO837uT1q7mjYYdpJKWuma05Iu+6q00TrFWHUHBDtuEraeODcnEQgdes6qnrbUYa2mrhVo2lwuiHFxrVw9bX6XX1hBViKc8laSYrQGG0pkjK1rfOCxiLKW8ioeUFo1SsdPfdrGbcAAk4rm5Mq64qhMe7No=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790834480; c=relaxed/simple;
	bh=orNJIYCPExrhwIMf8GZooIvqSki4abZ9scUo3yGD+8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=REBT4wG25aSDWX4iGUK3VTR2DMjLf6BprX7lwdPLhYiOEyID4AJOixkV7EN8OTBTeGrIP6PvW2tJeyKrwqRa1uimgYKB6SYt+3e1Cvv77D/ljk6RmRE+rDO+Qr+JBG2OReG5JrlaK9UwKy5MLa8BpJNuGv40TkCcAobSOfFolHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LgE+0ZZD; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LgE+0ZZD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53113d72966so123481cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 30 Sep 2026 23:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790834475; cv=none;
        d=google.com; s=arc-20260327;
        b=SQzFhBPkvgAR3SuKGH3wEm6TFUsxAY5n/lkjYQE/JaBg9kCwop9FKaD0UutIC4QxsY
         MRONmVTL8pg3u5BX4Vg2fErF6EZPM/JIM63xqkGuJ2PWeasrGX1wdEltt5fQktx8JWHX
         DrXz+uH1tsdKu4JrTZd2OWxLg3klrZhZY5MTsR2VQ6YB+PICzuLD/lftVjIhMe8f9Mba
         wp0R/PqoIdaSUqENXP5TLeQf15/9kIeaagow7OQj0Ev3rCfs6WM66+KV4FTBH97SlnPg
         tzozV2Dkm3cjpKSEpbV9IUVURH0lzC2hkQ2/dDiCEZ+uJyqpjEdJeE+2FxUAJgXH2fEx
         QdxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OyPwq39iE32SaL8RXGnmByH8Kd2xuM6EtYTUcKeGtco=;
        fh=Ydep5KMWVI6liChbwz4YA5YKOi9aSxxePNNTuX2PQxs=;
        b=dJk/ZmAXkoEnmUJpY9UhV2Ml7phiCXu3yuusf/1iL25Cw0Konrc+nA0ZGknB00D2cI
         WO90vqTx+CbK5Krg6mnJxjwqAVhKJfePPsQTorxGyCqIeIVKvdYXhaB+eCSJxfwwpIPE
         g5iJ8gzdbsJTvzAD15jWfN7cPFsywQ0OJEyEleCsrbaKyie7Jz1jvSmsa2I8OVgw4t9T
         pUJ5FVEtZohb2IjNaSh9zpJwsFp7acMjhQUfLU+/Bu59m/AMYkpDLSHmuEupOrYvA5+f
         tL58mxnELJy+Qdw/b0eRTwQ9puE/Hzjl9yGCBlxR5AIwAdUz0j53Vetop+coypW+/gDW
         bZnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790834475; x=1791439275; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OyPwq39iE32SaL8RXGnmByH8Kd2xuM6EtYTUcKeGtco=;
        b=LgE+0ZZDVlZChphrTtpq1NQLf9s80p6SdFx4oTRubPKmx/d6Tf4ZjX2j97y/Sxic7s
         rlVJZQXshq1FyLiTxd9CJYDE/bvl+oO1sAWxe4HZDwIuHm0B41MVDUsnhYba+TYKefcZ
         cYKil500gG8eaph83++tn8dJqNaUrJg6PemdqEKbnv2zTc7RJQgXxGAr4fa1hW3VsnvT
         wGjTZfR7wjVOqWjPw+fffvykTCALj6ctTlggpB+f+8mwRXUoR8Gth7HGuxwHZCSB6vQ+
         oyGfg2rqKAwbxM/dqGC7sbIcoJMg0sPfclbNNmoDpPwEp/ICkYUvSSBrDJrhZJmQjieS
         1rWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790834475; x=1791439275;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OyPwq39iE32SaL8RXGnmByH8Kd2xuM6EtYTUcKeGtco=;
        b=swZKFuSVZraY+CkYy904q8L9IHC5ybG/dM+nTfgPkTcLxp3Fhox2Yy9uDBRs2jWCh+
         mPSVIBOdgQfDKH2eIlOh2JLj5I/aSx+lw+2/BirI6lUDZxmko4kvAh9CoR001Nig6paU
         trsjAoIW84GhI9KPPeEuhPvvv0EQi+eIsOsKofYQwzwv0w9HYdjiPWMIePWedSh6ubFV
         6RhdoNsXI78qXjzE8b7ye8VIZKWsjNpZImQ9mN/YIJ/BDkCQQnGw0nHvnkv/k+7+VEsw
         T4TcxJlqo47avCTGDEKlX4/YLqIgfXf13y6VtQx7Pf0ZXXDGbZMyxIqxtsvSaftleQm4
         E4vg==
X-Forwarded-Encrypted: i=1; AKwUvByrQDbBmc9r68WMBSL68WIAYp/ze9ijWpznTxkJjz53Q55N6E1fiNmw1yw0fxnKE7DvsaXoQ4eF/H0CDaQEKh53@vger.kernel.org
X-Gm-Message-State: AFuF++npTZ3lNEOPXjfHUE1yJamW7tOMOHqNJtVPlcqxz6ay7mv7Sx/k
	Y2Q7pd0f/Ku1xJaykS9u2wjVRjjwwA65FHLVy6FERgIGMed7KHo5Poq3LzuCVJCH/IQxhhQmWLf
	L5azvKaflqBaoYpfMiyM7FoegEzlOe1RFqswgZ1yq
X-Gm-Gg: AYBFou2TQ3UDnt0amlSF/v/db/IWrfK00evYpNFxdI9mLY0DDh+UcJZlmDt1O0Mcibo
	7D3nC7Bhte6QVV/h0SUofRZNR2ySZ64I+vPsJIxzvQg6vEx2pw77aTMwss69cbxqb8K9JzSv78L
	AMDaaIB95u8+qRplws0a6B2UuIsEBvpbUDQiU3XUDr8OtL7O8jX3sMkGJ55nhLqQdJUJCD1Lsdk
	QqwvL95DvtS0uau4TMKd1b457hxWOlu006aELRdewg3O9erNjCbe1aOpxJRfmaKzOcDrK2m9JM+
	2or7rApLU7h0JjvA0XAlUYHu8CoJd2VYueL8u2x3+OZdzCcforltHA==
X-Received: by 2002:ac8:570d:0:b0:532:c99e:b16b with SMTP id
 d75a77b69052e-5338456868amr11151001cf.3.1790834473785; Wed, 30 Sep 2026
 23:01:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1790145937.git.irogers@google.com> <20260928182605.3649015-1-irogers@google.com>
 <20260928182605.3649015-7-irogers@google.com> <ar1fon_Z4uT3Cd22@x2> <ar2WYemXnrbDx-Il@google.com>
In-Reply-To: <ar2WYemXnrbDx-Il@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 30 Sep 2026 23:01:01 -0700
X-Gm-Features: AclHuK_MV7id34lX8cEpkQdw3irzLIYujhfHvytA6kxE1fL6j6ztkyS-gf3QnZY
Message-ID: <CAP-5=fVPANOdM5vFY93SCm=mN5Z1U+jMqa7s6piqgtAbUrCBbg@mail.gmail.com>
Subject: Re: [PATCH v6 06/26] perf trace: Copy sockaddr arguments by their length
To: Namhyung Kim <namhyung@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Aaron Tomlin <atomlin@atomlin.com>, Howard Chu <howardchu95@gmail.com>, 
	Jakub Brnak <jbrnak@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2026 at 4:08=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Sep 30, 2026 at 09:14:42PM +0200, Arnaldo Carvalho de Melo wrote:
> > On Mon, Sep 28, 2026 at 11:25:45AM -0700, Ian Rogers wrote:
> > > The BTF augmenter copies sizeof(struct sockaddr), 16 bytes, for the
> > > sockaddr arguments of connect, bind and sendto, and runs before the
> > > sys_enter_connect and sys_enter_sendto programs that copy their lengt=
h.
> > > An IPv6 address needs 24 or 28 bytes, so the rest was read from past =
the
> > > payload, and now that the printers are bounded only its family is sho=
wn.
> > >
> > > Copy them as buffers sized by the length argument after them, up to t=
he
> > > 32 bytes augmented buffers are limited to. That holds an IPv6 address
> > > and doubles the AF_LOCAL path shown.
> > >
> > > Fixes: a68fd6a6cdd3 ("perf trace: Collect augmented data using BPF")
> > > Assisted-by: Antigravity:gemini-3.1-pro
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> > > ---
> > >  tools/perf/builtin-trace.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > index 85db74965280..f94745a60f4a 100644
> > > --- a/tools/perf/builtin-trace.c
> > > +++ b/tools/perf/builtin-trace.c
> > > @@ -4159,7 +4159,12 @@ static int trace__bpf_sys_enter_beauty_map(str=
uct trace *trace, int e_machine, i
> > >                             continue;
> > >
> > >                     bt =3D sc->arg_fmt[i].type;
> > > -                   beauty_array[i] =3D bt->size;
> > > +                   /* Copy a sockaddr as a buffer sized by the next =
argument, e.g. addrlen. */
> > > +                   if (strcmp(name, "sockaddr") =3D=3D 0 && field->n=
ext &&
> > > +                       strstr(field->next->name, "len"))
> > > +                           beauty_array[i] =3D -((i + 1) + 1);
> > > +                   else
> > > +                           beauty_array[i] =3D bt->size;
> >
> >
> > Humm, I thought that this would be called in BPF handlers like:
> >
> > SEC("tp/syscalls/sys_enter_connect")
> > int sys_enter_connect(struct syscall_enter_args *args)
> > {
> >         struct augmented_args_payload *augmented_args =3D augmented_arg=
s_payload();
> >         const void *sockaddr_arg =3D (const void *)args->args[1];
> >         unsigned int socklen =3D args->args[2];
> >         unsigned int len =3D sizeof(u64) + sizeof(augmented_args->args)=
; // the size + err in all 'augmented_arg' structs
> >
> >         if (augmented_args =3D=3D NULL)
> >                 return 1; /* Failure: don't filter */
> >
> >         _Static_assert(is_power_of_2(sizeof(augmented_args->arg.saddr))=
, "sizeof(augmented_args->arg.saddr) needs to be a power of two");
> >         socklen &=3D sizeof(augmented_args->arg.saddr) - 1;
> >
> >         bpf_probe_read_user(&augmented_args->arg.saddr, socklen, sockad=
dr_arg);
> >         augmented_args->arg.size =3D socklen;
> >         augmented_args->arg.err =3D 0;
> >
> >         return augmented__output(args, augmented_args, len + socklen);
> > }
> >
> > And it knows how many bytes to read by looking at socklen
> > (args->args[2]), i.e. not use the generic BPF handler that uses this
> > beauty_array, because knowing how many bytes to read in this case is
> > dynamic, varies with each syscall, according to one of its arguments :-=
\
> >
> > What am I missing?
>
> I think Ian's patch update the beauty map which is used by
> augment_sys_enter() before tail-calling syscall-specific functions.
>
> It'd be great if we cover all syscalls in the BPF skeleton and switch
> to the beauty-map and discard the functions.

Right, as Namhyung says, sys_enter() runs augment_sys_enter() before
tail-calling syscalls_sys_enter, and only falls back to the tail call
if augment_sys_enter() returns non-zero:

  if (augment_sys_enter(args, &augmented_args->args))
    bpf_tail_call(args, &syscalls_sys_enter, augmented_args->args.syscall_n=
r);

trace__init_syscalls_bpf_prog_array_maps() populates beauty_map_enter
for every enabled syscall, even ones with a dedicated sys_enter_*
program. In trace__bpf_sys_enter_beauty_map(), connect, bind and
sendto's "struct sockaddr *" argument matched the struct branch, which
looked up "struct sockaddr" in BTF and put bt->size (16 bytes) in
beauty_array. So whenever BTF was available, augment_sys_enter()
handled connect, bind and sendto by copying 16 bytes and returned 0,
and sys_enter_connect / sys_enter_sendto were never tail-called.

beauty_array already supports dynamic lengths from another syscall
argument: a negative entry -(j + 1) tells augment_arg() to read
args->args[j] bytes (clamped to TRACE_AUG_MAX_BUF =3D 32), which was
added for buffer arguments like write's buf/count. This patch uses
that encoding for struct sockaddr * when the next argument is its
length.

If you'd rather have connect, bind and sendto fall back to
sys_enter_connect and sys_enter_sendto (which copies up to
sizeof(struct sockaddr_storage) =3D 128 bytes, so AF_LOCAL paths over 30
bytes aren't truncated), we could instead skip "struct sockaddr" in
trace__bpf_sys_enter_beauty_map().

On Namhyung's point: all 9 syscalls with dedicated sys_enter_*
programs (connect, sendto, open, openat, rename, renameat2,
clock_nanosleep, nanosleep, perf_event_open) already get
beauty_map_enter entries when BTF is loaded, so the tail-call programs
and trace__find_usable_bpf_prog_entry() are mostly shadowed today. The
main gaps before removing them are:

1. trace__bpf_sys_enter_beauty_map() bails out early if trace->btf is
NULL, even for strings/buffers that don't need BTF.
2. TRACE_AUG_MAX_BUF is 32 bytes vs sizeof(struct sockaddr_storage)
(128 bytes) for AF_LOCAL sockaddrs.
3. perf_event_open reads attr->size from userspace in
sys_enter_perf_event_open if the BTF-sized read of perf_event_attr
faults on an older, smaller struct.

That seems like a good follow-up cleanup.

Thanks,
Ian
