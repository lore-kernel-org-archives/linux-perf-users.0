Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF691B87F3
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496992; cv=none; b=gUUPc1q/UA0zRwYYDUp6W2uq6vRUv8o8pXVp3y9FrE2xTL8NcrBGCKfsQLdBbpFRXh7OGynBUV8HUMBgjLPr8VTXl97hJ0Zp3yoYgyxl7Id8EPfDsFr4l1EUU7NaarKCAnTNV46iZuMDlLui5skOIc8bAqEwxIA+69OfLXHBrPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496992; c=relaxed/simple;
	bh=mFkvari2z1fWmLsvq6Omj2Wn6kRaHkVGQj4jhZc19bQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=thDG0KELEM+LUrz1byFnour4QCzdhBjWlZaZQYg7NfDbdFIi2NnP7CWmi+5TlUaV6gg8l9gSDhG90SUzO1I9IrbA1CKg0bimu9KiTVlCTYrRa7INnSYKDIbpjy9szf1B4SgMkBlM4aqr/5uvtIb1wPKkSv+lQMYnp5F+XgvsedI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NwOA65IL; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NwOA65IL"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aa69107179cso1173886566b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 14:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737496989; x=1738101789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Pf5ReTbt0QrHvKNrJy0BbTY66yNBal6L8d/3IlahQ8=;
        b=NwOA65ILeg9bI3QRmKEX6kg5ytTy7rcThgaZciEp03/LH28ojzKkKA3y30Q2DOPqfe
         HxtnxQb/+5PguwMwrlOlQKMmIaSCwMNgJQNyoeXwGHmb7/UTuFbeH+ge+RozOjI5zhLl
         L99OErWr1dpnRmTVWc6VOgdhLBVmBcFx3GktFdM4r9ReJuk4pC96wr7p2yNGmYUQ1AoG
         HNNWiblodb7Nc+JdrIN+sa0SrSOdD+yFgw4aANBpVtNnNRpdMRb10h/3EwN5kR5QCiCX
         BeL/yH1I2VzVE+5VvSgXXUNf+9m37LHrarh34KdtGwc202x02FOy9iqKGhQYbUNjSM+m
         SSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737496989; x=1738101789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Pf5ReTbt0QrHvKNrJy0BbTY66yNBal6L8d/3IlahQ8=;
        b=bVm/4wlSifr9ABt5ZYRni68K1Zwvc5dC6C6TRPyIswflb5tahemgUeXZwye0voGr4s
         IS+YCxth5sdo9yRuim8KqWtykfzPjKDuaPUch6JQZdr0eVvrFIdfneDAYPlcXCqShSRQ
         QGUWSZ0+/Al6QR7bqifZjRHcDu2cCh+jYTMv/yisziuOSrReGkQ2ZjkK0tBQ09I61yhW
         8a72YqbTX+XO12m3Bk+ZHwS56Tp3D52+Y7DahGkhkEDAnjCnrQTsuytQV4Et0w3iniib
         1e6dS7S5qSa3t8aEktZYOKVSjR98EfN14Shu9tHdUgUodaD9CkzKRo8G8W+oLr06JK1d
         vT2w==
X-Forwarded-Encrypted: i=1; AJvYcCXJL8hEhUPb82fVBvlhN9jrEWvvIDp9vATJpJi7hvNibmMLmVGPgq7cd4FWSTbr3la2Rzblb73qiR+hIdlQOnMD@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn1pyyx2OKvS6yAgzKmK2jBy9myn/tqK6jHe6tjbZVujiKI11c
	YOy3qAKALh+AOgEi4TV1Jr0KeNW+4UEYf4LsejR98LC2qSaxvlBLNZeMRQTU4bfM/2EJ/YlYDMe
	npqwHWTOEc2zFPXThezgqIHgmGQDz+bkifh4W
X-Gm-Gg: ASbGncsayDn231x+KcNvEOJez5NwiYHVdTpHB9w89iGwj9P0GRrKoFHXnD8S1/+MlCW
	d8eOKfiIPLf/AewGQZCNWNVMHEJ6hmTrO+JbArWTbejrh5uZh/G5B+vlBGi8CMZ1MOk5NS9OEY6
	WOMSGR3Q==
X-Google-Smtp-Source: AGHT+IH9C1DgWkCx/IF4GEs7d9XZatTYKETnSowzdKonvoodh953CDLims5pFZm6C/i2cli3mzBo9Aq8dlLsp6D4WLY=
X-Received: by 2002:a17:907:940d:b0:aa6:a05c:b068 with SMTP id
 a640c23a62f3a-ab38b3d6ec1mr1466946166b.56.1737496988737; Tue, 21 Jan 2025
 14:03:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com> <20250113052220.2105645-2-ctshao@google.com>
 <Z4XUfjdaooYNpkFt@google.com>
In-Reply-To: <Z4XUfjdaooYNpkFt@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 21 Jan 2025 14:02:57 -0800
X-Gm-Features: AbW1kvaa11xh-6ChK4SsaO-FFoq4twz-OU0zgXLvRtPsaq-J9zamERG4ixA9i8o
Message-ID: <CAJpZYjXMd4+UbaO8y-HGkPor4M1L7W1iMWYe+ak1EYSOxwqXiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] perf lock: Add bpf maps for owner stack tracing
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Namhyung, thanks for your reply!

On Mon, Jan 13, 2025 at 7:05=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Sun, Jan 12, 2025 at 09:20:14PM -0800, Chun-Tse Shao wrote:
> > Add few bpf maps in order to tracing owner stack.
>
> If you want to split this code as a separate commit, I think you'd
> better explain what these maps do and why you need them.
>
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  tools/perf/util/bpf_lock_contention.c         | 17 ++++++--
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 40 +++++++++++++++++--
> >  tools/perf/util/bpf_skel/lock_data.h          |  6 +++
> >  3 files changed, 56 insertions(+), 7 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_lock_contention.c b/tools/perf/util/bp=
f_lock_contention.c
> > index 41a1ad087895..c9c58f243ceb 100644
> > --- a/tools/perf/util/bpf_lock_contention.c
> > +++ b/tools/perf/util/bpf_lock_contention.c
> > @@ -41,9 +41,20 @@ int lock_contention_prepare(struct lock_contention *=
con)
> >       else
> >               bpf_map__set_max_entries(skel->maps.task_data, 1);
> >
> > -     if (con->save_callstack)
> > -             bpf_map__set_max_entries(skel->maps.stacks, con->map_nr_e=
ntries);
> > -     else
> > +     if (con->save_callstack) {
> > +             bpf_map__set_max_entries(skel->maps.stacks,
> > +                                      con->map_nr_entries);
> > +             if (con->owner) {
> > +                     bpf_map__set_value_size(skel->maps.owner_stacks_e=
ntries,
> > +                                             con->max_stack * sizeof(u=
64));
> > +                     bpf_map__set_value_size(
> > +                             skel->maps.contention_owner_stacks,
> > +                             con->max_stack * sizeof(u64));
> > +                     bpf_map__set_key_size(skel->maps.owner_lock_stat,
> > +                                             con->max_stack * sizeof(u=
64));
> > +                     skel->rodata->max_stack =3D con->max_stack;
> > +             }
> > +     } else
> >               bpf_map__set_max_entries(skel->maps.stacks, 1);
> >
> >       if (target__has_cpu(target)) {
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 1069bda5d733..05da19fdab23 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -19,13 +19,37 @@
> >  #define LCB_F_PERCPU (1U << 4)
> >  #define LCB_F_MUTEX  (1U << 5)
> >
>
> Can we rename these shorter and save some typings?

I tend to use longer variable names with full descriptions with some
easy to understand abbreviations. Would a shorter name be preferable
in Linux kernel?

>
> > -/* callstack storage  */
> > + /* tmp buffer for owner callstack */
> >  struct {
> > -     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +     __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> >       __uint(key_size, sizeof(__u32));
> >       __uint(value_size, sizeof(__u64));
> > +     __uint(max_entries, 1);
> > +} owner_stacks_entries SEC(".maps");
>
> I think this can be 'stack_buf'.
>
> > +
> > +/* a map for tracing lock address to owner data */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64)); // lock address
> > +     __uint(value_size, sizeof(cotd));
> >       __uint(max_entries, MAX_ENTRIES);
> > -} stacks SEC(".maps");
> > +} contention_owner_tracing SEC(".maps");
>
> owner_data.
>
> > +
> > +/* a map for tracing lock address to owner stacktrace */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64)); // lock address
> > +     __uint(value_size, sizeof(__u64)); // straktrace
>
> Typo.
>
> > +     __uint(max_entries, MAX_ENTRIES);
> > +} contention_owner_stacks SEC(".maps");
>
> owner_stack.
>
> > +
> > +/* owner callstack to contention data storage */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_HASH);
> > +     __uint(key_size, sizeof(__u64));
> > +     __uint(value_size, sizeof(struct contention_data));
> > +     __uint(max_entries, MAX_ENTRIES);
> > +} owner_lock_stat SEC(".maps");
>
> owner_stat.  What do you think?
>
> By the way, I got an idea to implement stackid map in BPF using hash
> map.  For owner stack, you can use the stacktrace as a key and make a
> value an unique integer.  Then the return value can be used as a stack
> id (like from bpf_get_stackid) for the owner_data and owner_stat.
>
> Something like:
>
>   s32 get_stack_id(struct owner_stack *owner_stack, u64 stacktrace[])
>   {
>         s32 *id, new_id;
>         static s32 id_gen =3D 1;
>
>         id =3D bpf_map_lookup_elem(owner_stack, stacktrace);
>         if (id)
>                 return *id;
>
>         new_id =3D __sync_fetch_and_add(&id_gen, 1);
>         bpf_map_update_elem(owner_stack, stacktrace, &new_id, BPF_NOEXIST=
);
>
>         id =3D bpf_map_lookup_elem(owner_stack, stacktrace);
>         if (id)
>                 return *id;
>
>         return -1;
>   }
>
> Later, in user space, you can traverse the owner_stack map to build
> reverse mapping from id to stacktrace.

I wonder if stack_id is necessary here. So far I have three bpf maps.
2 bpf maps for tracing owner stack on given lock address in bpf program:
  key: lock_address, value: a struct for tracing owner pid, count of
waiters and contention begin timestamp.
  key: lock_address, value: owner stack, which is variable length so I
have to put it in a separate bpf map.

1 bpf map for reporting owner stack in user mode:
  key: owner stack, value: struct lock_stat.

With stackid I think there will still be 3 bpf maps, one for
lock_address to owner's info with stackid, one for stackid to stack,
and one for contention_key (has stackid inside) to lock_stat. I think
it is just another way to implement and does not simplify the
implementation. WDYT?

>
> >
> >  /* maintain timestamp at the beginning of contention */
> >  struct {
> > @@ -43,6 +67,14 @@ struct {
> >       __uint(max_entries, 1);
> >  } tstamp_cpu SEC(".maps");
> >
> > +/* callstack storage  */
> > +struct {
> > +     __uint(type, BPF_MAP_TYPE_STACK_TRACE);
> > +     __uint(key_size, sizeof(__u32));
> > +     __uint(value_size, sizeof(__u64));
> > +     __uint(max_entries, MAX_ENTRIES);
> > +} stacks SEC(".maps");
> > +
> >  /* actual lock contention statistics */
> >  struct {
> >       __uint(type, BPF_MAP_TYPE_HASH);
> > @@ -126,6 +158,7 @@ const volatile int needs_callstack;
> >  const volatile int stack_skip;
> >  const volatile int lock_owner;
> >  const volatile int use_cgroup_v2;
> > +const volatile int max_stack;
> >
> >  /* determine the key of lock stat */
> >  const volatile int aggr_mode;
> > @@ -436,7 +469,6 @@ int contention_end(u64 *ctx)
> >                       return 0;
> >               need_delete =3D true;
> >       }
> > -
> >       duration =3D bpf_ktime_get_ns() - pelem->timestamp;
> >       if ((__s64)duration < 0) {
> >               __sync_fetch_and_add(&time_fail, 1);
> > diff --git a/tools/perf/util/bpf_skel/lock_data.h b/tools/perf/util/bpf=
_skel/lock_data.h
> > index de12892f992f..1ef0bca9860e 100644
> > --- a/tools/perf/util/bpf_skel/lock_data.h
> > +++ b/tools/perf/util/bpf_skel/lock_data.h
> > @@ -3,6 +3,12 @@
> >  #ifndef UTIL_BPF_SKEL_LOCK_DATA_H
> >  #define UTIL_BPF_SKEL_LOCK_DATA_H
> >
> > +typedef struct contention_owner_tracing_data {
> > +     u32 pid; // Who has the lock.
> > +     u64 timestamp; // The time while the owner acquires lock and cont=
ention is going on.
> > +     u32 count; // How many waiters for this lock.
>
> Switching the order of timestamp and count would remove padding.

Thanks for the nit!

>
> > +} cotd;
>
> Usually we don't use typedef to remove the struct tag.
>
> Thanks,
> Namhyung
>
> > +
> >  struct tstamp_data {
> >       u64 timestamp;
> >       u64 lock;
> > --
> > 2.47.1.688.g23fc6f90ad-goog
> >
