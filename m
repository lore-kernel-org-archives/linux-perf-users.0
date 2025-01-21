Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222231F8923
	for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737498962; cv=none; b=Rmwj1RTBqZo6O/U0iCfgK/B9CjeaSK/fvSyAFDNDWQITEz9nFnFL+qR4hqoZbznJ6U+SzHXWo4KyFsVEGXwT5IliODZ/2ko8EFSaqx0Rg1NmxbPHwmvbIwNZUcTb3Osj802bSBYkuqjmZyXQ64xvooM8skyHvceB/YYCVw3Bnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737498962; c=relaxed/simple;
	bh=06Hh2+UAEpneh6HfJH3Ll28Wf+x1/JghZ6f5pl9BOek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SpHD/kXuSpmZXyYGRjbdIHexWpXIMoKjOz/hpCrhSnME2sL9dPN5qP7eDa6YkGg5xH+Ajx/4BHUd5gQI5nNchgBgdRl8R9HGFh6q0h1UnkshU7NB2nWy0/uZBbDqxZA7u0qthzylV6YX5NB/sE+chqTtyvpM9+93dLpdmjGue7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M+B5Pyii; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M+B5Pyii"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so9904009a12.3
        for <linux-perf-users@vger.kernel.org>; Tue, 21 Jan 2025 14:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737498958; x=1738103758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWvQ57s5WLieNo1sliCfgXAQCkGzy3GzVR5mbefurH0=;
        b=M+B5Pyiilwayg0tUh/v4jkOfWP3OMZKU8emv+ETIXNI4mXaaXtnbdZkjxvHyA0EbXC
         pLHyhw9esBn2vt1GfWAuqwd1u4+3HI1WlM6q4Y/cSFPsGVvvkC06STsP6BCOxeJqrJPY
         p+lU44j+30ZSM4bKzgubseEbi5/hrUqMYf09yPmSEs+s1KprNTDDH+XZaVYNOeWJDpfW
         AuYpWMSLNbwfy42/Pm87pJW1jCNiUaeHJ9fr7vy6zq6BbxeoOq8hK02Q0wNglKEhPXvO
         4JZyu4hlX/KfJKgY7eZt7BvncOhb5PSxQsj4qWvfaZmW9shmKyahAkTODoladSkTn07v
         vLAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737498958; x=1738103758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWvQ57s5WLieNo1sliCfgXAQCkGzy3GzVR5mbefurH0=;
        b=czLDNS2e4OgvBmoYz2nhaMr660QAtT+BTUoAmDvITqLfU/EYVgRFxvy6Xs/3UWF9uQ
         84wyPV+QDIEhy8XPLSpXHwGHqPjx1ymzHw3WQU839XACVi5VVu+PrK33LCVYqkqyoL3G
         c73euHIHzWf9f6mJpAkFjPPyq2gwoInPZ8bRz4C+rCrlS+OK1ZV+hw3GmHJmgP9UkXBw
         UG72Yl3S1EhKQoUHadCzDzXdVR4qt/drbth0JQPN1+lGsMtZnjxPoSMOBpCyIwsYP7b7
         R7lYuAnFhfZFO03w+YHary023HsSxSSMtDmBTY4P/6qtQe8631hIrHammdU+KlUYQGZF
         H8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCUuCwBjmZlnoTtavKRN766tutFfjJz5AYdoFmTTIIjY/gBkA8roa2zwfgFKanuCo6hQm635wGssDZoAT5knhmgp@vger.kernel.org
X-Gm-Message-State: AOJu0YziO2ZugQ/Ik7i7cMjfCRXZtgDTo4w5Pz8t+obb8WQJ+yKhQRN1
	kq1Xn8x8Hxz2g4lfgNBe0jmY1e+YOc1rcy/8z2gR7tVJS/ZsOtmMBN1BsTZ9mgBNcVYltTeIULO
	YY+HW5LlbRceFThhsB0t1VJMndYwheNmuLRXB
X-Gm-Gg: ASbGncupAdachEZ2w3bkyoAEMyCw+cpJhe5Kp7zScCPg1H97hTaGMHFNipZDKvTUuVG
	PFmh3cKRkNcdQVM6w7tBfORwk24EMhRSKEVs11XcLg4mjheuhaFxRKMM75c5Aj9XnUUVwrAzgkb
	5ZjALuAg==
X-Google-Smtp-Source: AGHT+IGt0OMy7B4oot6v84WB08lfnc/QRZCDU+KLiGjyKu7W62PqcoeuptE013G66TBd117SgsxqzMkgh51s4sdqzTU=
X-Received: by 2002:a05:6402:4406:b0:5d9:84ee:ff31 with SMTP id
 4fb4d7f45d1cf-5db7d2dc6d2mr41461629a12.3.1737498958162; Tue, 21 Jan 2025
 14:35:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113052220.2105645-1-ctshao@google.com> <20250113052220.2105645-3-ctshao@google.com>
 <Z4XbdVKyXgjUqZcP@google.com>
In-Reply-To: <Z4XbdVKyXgjUqZcP@google.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 21 Jan 2025 14:35:46 -0800
X-Gm-Features: AbW1kvZ6SGeDznqhE4nXMvbzFFvd_WAlQ0gHHFXPNtYPjNsTqI5NxSw61i6S2z4
Message-ID: <CAJpZYjWvuzrwViWqi3Oet2agXkJP6T=82HZ_YeKNYV2KKioWdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] perf lock: Retrieve owner callstack in bpf program
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 13, 2025 at 7:35=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Sun, Jan 12, 2025 at 09:20:15PM -0800, Chun-Tse Shao wrote:
> > Tracing owner callstack in `contention_begin()` and `contention_end()`,
> > and storing in `owner_lock_stat` bpf map.
> >
> > Signed-off-by: Chun-Tse Shao <ctshao@google.com>
> > ---
> >  .../perf/util/bpf_skel/lock_contention.bpf.c  | 152 +++++++++++++++++-
> >  1 file changed, 151 insertions(+), 1 deletion(-)
> >
> > diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/per=
f/util/bpf_skel/lock_contention.bpf.c
> > index 05da19fdab23..3f47fbfa237c 100644
> > --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> > @@ -7,6 +7,7 @@
> >  #include <asm-generic/errno-base.h>
> >
> >  #include "lock_data.h"
> > +#include <time.h>
> >
> >  /* for collect_lock_syms().  4096 was rejected by the verifier */
> >  #define MAX_CPUS  1024
> > @@ -178,6 +179,9 @@ int data_fail;
> >  int task_map_full;
> >  int data_map_full;
> >
> > +struct task_struct *bpf_task_from_pid(s32 pid) __ksym;
> > +void bpf_task_release(struct task_struct *p) __ksym;
>
> To support old (ancient?) kernels, you can declare them as __weak and
> check if one of them is defined and ignore owner stacks on them.  Also
> you can check them in user space and turn off the option before loading.
>
> > +
> >  static inline __u64 get_current_cgroup_id(void)
> >  {
> >       struct task_struct *task;
> > @@ -407,6 +411,60 @@ int contention_begin(u64 *ctx)
> >       pelem->flags =3D (__u32)ctx[1];
> >
> >       if (needs_callstack) {
> > +             u32 i =3D 0;
> > +             int owner_pid;
> > +             unsigned long *entries;
> > +             struct task_struct *task;
> > +             cotd *data;
> > +
> > +             if (!lock_owner)
> > +                     goto contention_begin_skip_owner_callstack;
>
> Can be it 'skip_owner'?
>
> > +
> > +             task =3D get_lock_owner(pelem->lock, pelem->flags);
> > +             if (!task)
> > +                     goto contention_begin_skip_owner_callstack;
> > +
> > +             owner_pid =3D BPF_CORE_READ(task, pid);
> > +
> > +             entries =3D bpf_map_lookup_elem(&owner_stacks_entries, &i=
);
> > +             if (!entries)
> > +                     goto contention_begin_skip_owner_callstack;
> > +             for (i =3D 0; i < max_stack; i++)
> > +                     entries[i] =3D 0x0;
> > +
> > +             task =3D bpf_task_from_pid(owner_pid);
> > +             if (task) {
> > +                     bpf_get_task_stack(task, entries,
> > +                                        max_stack * sizeof(unsigned lo=
ng),
> > +                                        0);
> > +                     bpf_task_release(task);
> > +             }
> > +
> > +             data =3D bpf_map_lookup_elem(&contention_owner_tracing,
> > +                                        &(pelem->lock));
>
> No need for parenthesis.
>
> > +
> > +             // Contention just happens, or corner case `lock` is owne=
d by
> > +             // process not `owner_pid`.
> > +             if (!data || data->pid !=3D owner_pid) {
> > +                     cotd first =3D {
> > +                             .pid =3D owner_pid,
> > +                             .timestamp =3D pelem->timestamp,
> > +                             .count =3D 1,
> > +                     };
> > +                     bpf_map_update_elem(&contention_owner_tracing,
> > +                                         &(pelem->lock), &first, BPF_A=
NY);
> > +                     bpf_map_update_elem(&contention_owner_stacks,
> > +                                         &(pelem->lock), entries, BPF_=
ANY);
>
> Hmm.. it just discard the old owner data if it comes from a new owner?
> Why not save the data into the result for the old lock/callstack?

There are two conditions which enter this if statement:
1. (!data) contention just started, `&pelem->lock` entry in
`contetion_owner_tracing` is empty.
2. (data->pid !=3D owner_pid) Some internal errors so `data->pid` is
misaligned with `owner_pid`. In this case the timestamp would be
incorrect so I prefer to drop it.
WDYT?

>
>
> > +             }
> > +             // Contention is going on and new waiter joins.
> > +             else {
> > +                     __sync_fetch_and_add(&data->count, 1);
> > +                     // TODO: Since for owner the callstack would chan=
ge at
> > +                     // different time, We should check and report if =
the
> > +                     // callstack is different with the recorded one i=
n
> > +                     // `contention_owner_stacks`.
> > +             }
> > +contention_begin_skip_owner_callstack:
> >               pelem->stack_id =3D bpf_get_stackid(ctx, &stacks,
> >                                                 BPF_F_FAST_STACK_CMP | =
stack_skip);
> >               if (pelem->stack_id < 0)
> > @@ -443,6 +501,7 @@ int contention_end(u64 *ctx)
> >       struct tstamp_data *pelem;
> >       struct contention_key key =3D {};
> >       struct contention_data *data;
> > +     __u64 timestamp;
> >       __u64 duration;
> >       bool need_delete =3D false;
> >
> > @@ -469,12 +528,103 @@ int contention_end(u64 *ctx)
> >                       return 0;
> >               need_delete =3D true;
> >       }
> > -     duration =3D bpf_ktime_get_ns() - pelem->timestamp;
> > +     timestamp =3D bpf_ktime_get_ns();
> > +     duration =3D timestamp - pelem->timestamp;
> >       if ((__s64)duration < 0) {
> >               __sync_fetch_and_add(&time_fail, 1);
> >               goto out;
> >       }
> >
> > +     if (needs_callstack && lock_owner) {
> > +             u64 owner_contention_time;
> > +             unsigned long *owner_stack;
> > +             struct contention_data *cdata;
> > +             cotd *otdata;
> > +
> > +             otdata =3D bpf_map_lookup_elem(&contention_owner_tracing,
> > +                                          &(pelem->lock));
> > +             owner_stack =3D bpf_map_lookup_elem(&contention_owner_sta=
cks,
> > +                                               &(pelem->lock));
> > +             if (!otdata || !owner_stack)
> > +                     goto contention_end_skip_owner_callstack;
> > +
> > +             owner_contention_time =3D timestamp - otdata->timestamp;
> > +
> > +             // Update `owner_lock_stat` if `owner_stack` is
> > +             // available.
> > +             if (owner_stack[0] !=3D 0x0) {
> > +                     cdata =3D bpf_map_lookup_elem(&owner_lock_stat,
> > +                                                 owner_stack);
> > +                     if (!cdata) {
> > +                             struct contention_data first =3D {
> > +                                     .total_time =3D owner_contention_=
time,
> > +                                     .max_time =3D owner_contention_ti=
me,
> > +                                     .min_time =3D owner_contention_ti=
me,
> > +                                     .count =3D 1,
> > +                                     .flags =3D pelem->flags,
> > +                             };
> > +                             bpf_map_update_elem(&owner_lock_stat,
> > +                                                 owner_stack, &first,
> > +                                                 BPF_ANY);
> > +                     } else {
> > +                             __sync_fetch_and_add(&cdata->total_time,
> > +                                                  owner_contention_tim=
e);
> > +                             __sync_fetch_and_add(&cdata->count, 1);
> > +
> > +                             /* FIXME: need atomic operations */
> > +                             if (cdata->max_time < owner_contention_ti=
me)
> > +                                     cdata->max_time =3D owner_content=
ion_time;
> > +                             if (cdata->min_time > owner_contention_ti=
me)
> > +                                     cdata->min_time =3D owner_content=
ion_time;
> > +                     }
> > +             }
> > +
> > +             //  No contention is going on, delete `lock` in
> > +             //  `contention_owner_tracing` and
> > +             //  `contention_owner_stacks`
> > +             if (otdata->count <=3D 1) {
> > +                     bpf_map_delete_elem(&contention_owner_tracing,
> > +                                         &(pelem->lock));
> > +                     bpf_map_delete_elem(&contention_owner_stacks,
> > +                                         &(pelem->lock));
> > +             }
> > +             // Contention is still going on, with a new owner
> > +             // (current task). `otdata` should be updated accordingly=
.
> > +             else {
> > +                     (otdata->count)--;
>
> No need for parenthesis, and it needs to be atomic dec.
>
> > +
> > +                     // If ctx[1] is not 0, the current task terminate=
s lock
> > +                     // waiting without acquiring it. Owner is not cha=
nged.
>
> Please add a comment that ctx[1] has the return code of the lock
> function.  Maybe it's better to use a local variable.
>
> Also I think you need to say about the normal case too.  Returing 0
> means the waiter now gets the lock and becomes a new owner.  So it needs
> to update the owner information.
>
>
> > +                     if (ctx[1] =3D=3D 0) {
> > +                             u32 i =3D 0;
> > +                             unsigned long *entries =3D bpf_map_lookup=
_elem(
> > +                                     &owner_stacks_entries, &i);
> > +                             if (entries) {
> > +                                     for (i =3D 0; i < (u32)max_stack;=
 i++)
> > +                                             entries[i] =3D 0x0;
> > +
> > +                                     bpf_get_task_stack(
> > +                                             bpf_get_current_task_btf(=
),
>
> Same as bpf_get_stack(), right?
>
> > +                                             entries,
> > +                                             max_stack *
> > +                                                     sizeof(unsigned l=
ong),
> > +                                             0);
> > +                                     bpf_map_update_elem(
> > +                                             &contention_owner_stacks,
> > +                                             &(pelem->lock), entries,
> > +                                             BPF_ANY);
>
> Please factor out the code if it indents too much.  Or you can use goto
> or something to reduce the indentation level.

I will reindent it with `ColumnLimit=3D100`. I was using 80 since it was
predefined in `.clang-format`, looks outdated but no one updated it..

>
>   if (ret !=3D 0)
>         goto skip_update;
>
>   ...
>
>   if (entries =3D=3D NULL)
>         goto skip_stack;
>
>   ...
>
> Thanks,
> Namhyung
>
> > +                             }
> > +
> > +                             otdata->pid =3D pid;
> > +                             otdata->timestamp =3D timestamp;
> > +                     }
> > +
> > +                     bpf_map_update_elem(&contention_owner_tracing,
> > +                                         &(pelem->lock), otdata, BPF_A=
NY);
> > +             }
> > +     }
> > +contention_end_skip_owner_callstack:
> > +
> >       switch (aggr_mode) {
> >       case LOCK_AGGR_CALLER:
> >               key.stack_id =3D pelem->stack_id;
> > --
> > 2.47.1.688.g23fc6f90ad-goog
> >
