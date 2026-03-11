Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BF175A71
	for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 16:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773245715; cv=pass; b=eD/w3BTdWBw1KaPvwWZNtKJSvU91d5Ou+oWykUjMmvcNlcK+ZgNzLqGNJDUZ6//mANHIMaXBecfPfE+W0TBL9x0irz/tt1auzTxnRJuLcZgaRgxY1XrUmqvs6YwbtGsTQ8pzAR6wACRY59yfXRNMup9XNdxwhCed3FyamjpQAxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773245715; c=relaxed/simple;
	bh=PGbOdEkJmTSIpivIi2ogP78UdPIV1Tgc0HQlXe/htJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9YkSleVsySk2s4rXzqKBD/fSEztv3hhmLtf5Sz1vE4DKfHtKoKVqrkGaRDdNSZkrfLz2zxHFu6L2VSc+/K+C1QiM3JH5QrUF6G/EyKc1ln+A2cdeiIAzG61ZjhYrqsgXFya2WUYagqIUTcVp6frZ2wEfQU2s5qohbSJyK57Kvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G+FGAar4; arc=pass smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G+FGAar4"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-126ea4e9697so9938c88.1
        for <linux-perf-users@vger.kernel.org>; Wed, 11 Mar 2026 09:15:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773245713; cv=none;
        d=google.com; s=arc-20240605;
        b=Slc6oHJbtSAYtgExaQphDXMUcBehCy2DRzDYX0vQJ6mS0+kio5H2blBFJ6T6z03cbt
         PwgYoO1jy+aNmLm8vGc153KeRUtxN4GZWBH1YImc/T6SF+HKCkKYXKdCNUzn0A8kgcHh
         azfI+c+er44eu5AyHYPo5aJ32df3sGUE/+vKJ7owlv4bpGK2esJZA3d43lJA848rJyEN
         iScjwMfFzdN1JGm5aU+mZjO7MnO3cJ2lxlduehhJdZkNMtGZQOk5Nh2sLGy6yo0DngUd
         jSj7jeoevn4IwGxvauifHt3bmFZ9Ag8hO9qEtlvPcKMs1md1OguiBV7bSd77m+EqKKyr
         ql/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Di+3Sg/nw0YF0/bD6j0bdCtq2OotXhyEyl4oQ2IgsIE=;
        fh=vceR4/0z+AV4I+aFkY+FFZ+FJdGR9zO64ENTn81WUrg=;
        b=jrIYmay96tbYw70wJ+3yu71jVTwyZteYmzL1d2h5oYcbzSRw2BBrJ4x4eyOxtPYnb7
         llbTkGQ/GO486tLnypwL89mYmcFaoMY/EOSgkbvViKXJGDz0rvI2eSdh+OFQYD8i3pS4
         Vt2YPOHEnt3GZsUNAZ3s2sa29B0+1p4nIWSsD51MpO5g9hcd3VROYEVeK1RFr9pQO4jZ
         zVHZ7HMdT2pnH7MaKsWey1ik5/6gXu4HIY6oNLbHICJfRwXgN256xZsLh67Ctu6UjdDX
         uZppv4X9HCv19vxf/BD2Yl3GLdpCNwBjtRKEu0JluW3AXYBt2UFzKmwvCxTrp/TruvNl
         Xklg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773245713; x=1773850513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Di+3Sg/nw0YF0/bD6j0bdCtq2OotXhyEyl4oQ2IgsIE=;
        b=G+FGAar4SIMYBO9h1r7xAS0EKSOVvw5o8FuxPpNU929hZqwcaO4O/Nmwkr2PgiB79z
         47RoOI4CMZqOSQOK8DRBjrHig3TZnwfussLLj+2T8P7rI/aTweb5yZFAxzJczwkPLMVI
         oqjkkwcQAsel1Vf4eHYx7ROeiG+XeNWGQJcgC3eUyf7LwuZO48AJTLXG/f1/bVYls1F0
         vNTUxycr3a0LOAuJjB0cNOrkEKUtTkjAb97GwP+hhec2dqulp0P9A5mIAohHcfpNd/2e
         zxI7TYyjqM+jybWlpZjEnE5paNVcrvQHe3blTSieGOUcwMtciMz7QCuM36KkBmxi/4no
         Q22A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773245713; x=1773850513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Di+3Sg/nw0YF0/bD6j0bdCtq2OotXhyEyl4oQ2IgsIE=;
        b=MKzTJT0L1L2AHzCSHzwZ5ua3HvDLSQd7wbZRIMBnfJAfHPOOWhZY8GkG6I6LcjRgpR
         ehlz2lctyv5/dfxI0pTitMP2eN3iz5q5d9t/KKIuE/M7DXEEKNIStP0F+f0xliosf3+S
         hHmUcTQf3goXqXG+dpLWGzmy+sSW8WKb4mPv66adR/0EJJEqNjDdgGM/0OaF5miqSU3m
         rEcIOU3LHQXJ/v5nekXE3WI6RH988vKNWXFNIjoPrT7jXdOmtFenJ5OSygHTeQP7o4Cr
         /x9Csy1gPNCq69ULdl9NfTn7aqA+j2rdG8LR8zswj79lSXpgLqKJYpe/eapXKhPj4eSS
         G7+w==
X-Forwarded-Encrypted: i=1; AJvYcCX5HOvZKd1dv3NkZfPQjZG2BFTwIqnZIX3cFS94GyeCw36BJhpiUSao/DuBnPyZl/lKtKCOEp7hAaRqJ2oW8XwI@vger.kernel.org
X-Gm-Message-State: AOJu0YyKfH5PvDC+e5I4GJ7HJalxkZcMGvtQKJ6cYTdqbe34eNtwqcDJ
	18uCqkgqjeEdgBXAcuelML5azZq+1ywHJaH7kgFDiTlLa1NpcoIx/qtJjuxzvHVXDgi7ieIVdhu
	8c0u4N/N+opjXM+O/2kY4LM3VQRdgLOM6GZ0k3+CU1GKKfpPtaXz8aksmztI=
X-Gm-Gg: ATEYQzwCfw/L7sSQAorSIykK1fJ5mYfV/Yk0OmkMflZyCJW2EIej/Ac6AzELRNmXt0x
	1vWCAI5PN5rBbsgKPG3rvwPQHdiejL7UFh/tpcjeWnrgYH6XoBKKs6H+fQSyQOzgfrkQZKSAHve
	vUG/TSBnc7kLLmJuIe5OmPx/JGnxBW0E8hqz1FaXCyLJ1oGgDnlsBurL5ibHsf9roi2EgBLfUwL
	FmO5OHDNOuRwUkIgiU67t168a1AodsRbXsNtOhRoxgUYXHS1nYdvBE+1A9m/cVAELtT7oujYTMt
	I92QHmYFNCmBy3sQPyrxrRsswknoEZMasCeS
X-Received: by 2002:a05:701b:420f:20b0:11a:b4dc:7773 with SMTP id
 a92af1059eb24-128e6dc4a7cmr127393c88.12.1773245712352; Wed, 11 Mar 2026
 09:15:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310175951.29500-1-cel@kernel.org> <CAP-5=fUA0BiCfgqgy_ik8iAhABQxYtFhKiUiEGrOCcF2jAqhfQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUA0BiCfgqgy_ik8iAhABQxYtFhKiUiEGrOCcF2jAqhfQ@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 11 Mar 2026 09:14:58 -0700
X-Gm-Features: AaiRm53vJsX03SY9ESYFMbt8bTkkpG8SalYg12e7OUisqrOEacpe50IVq4VxpjM
Message-ID: <CAP-5=fVVxqt9Po-dokuP8dOJ+VN1Zrzgx6hVJ=cXgkW8f8dhvA@mail.gmail.com>
Subject: Re: [PATCH v1] perf synthetic-events: Fix stale build ID in module
 MMAP2 records
To: Chuck Lever <cel@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 12:32=E2=80=AFPM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Tue, Mar 10, 2026 at 10:59=E2=80=AFAM Chuck Lever <cel@kernel.org> wro=
te:
> >
> > From: Chuck Lever <chuck.lever@oracle.com>
> >
> > perf_event__synthesize_modules() allocates a single union
> > perf_event and reuses it across every kernel module callback.
> > After the first module is processed,
> > perf_record_mmap2__read_build_id() sets
> > PERF_RECORD_MISC_MMAP_BUILD_ID in header.misc and writes that
> > module's build ID into the event. On subsequent iterations the
> > callback overwrites start, len, pid, and filename for the next
> > module but never clears the stale build ID fields or the
> > MMAP_BUILD_ID flag. When perf_record_mmap2__read_build_id()
> > runs for the second module it sees the flag, reads the stale
> > build ID into a dso_id, and __dso__improve_id() permanently
> > poisons the DSO with the wrong build ID. Every module after
> > the first therefore receives the first module's build ID in
> > its MMAP2 record. On a system with the sunrpc and nfsd modules
> > loaded, this causes perf script and perf report to show
> > [unknown] for all module symbols.
> >
> > The latent bug has existed since commit d9f2ecbc5e47 ("perf
> > dso: Move build_id to dso_id") introduced the
> > PERF_RECORD_MISC_MMAP_BUILD_ID check in
> > perf_record_mmap2__read_build_id(). Commit 53b00ff358dc ("perf
> > record: Make --buildid-mmap the default") then exposed it to
> > all users by making the MMAP2-with-build-ID path the default.
> > Both commits were merged in the same series.
> >
> > Clear the MMAP_BUILD_ID flag and zero the build_id union
> > before each call to perf_record_mmap2__read_build_id() so
> > that every module starts with a clean slate.
> >
> > Fixes: d9f2ecbc5e47 ("perf dso: Move build_id to dso_id")
> > Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> > ---
> >  tools/perf/util/synthetic-events.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/tools/perf/util/synthetic-events.c b/tools/perf/util/synth=
etic-events.c
> > index ef79433ebc3a..ddf1cbda1902 100644
> > --- a/tools/perf/util/synthetic-events.c
> > +++ b/tools/perf/util/synthetic-events.c
> > @@ -703,6 +703,11 @@ static int perf_event__synthesize_modules_maps_cb(=
struct map *map, void *data)
> >
> >                 memcpy(event->mmap2.filename, dso__long_name(dso), dso_=
_long_name_len(dso) + 1);

AI points out that leaving stale data isn't just a problem for misc
bits but also after the filename, due to the event's alignment to 8
bytes. I think this is benign, you're only leaking bits of the
filename from the last event, not uninitialized data from the perf
execution. The AI made me think about it so I thought I'd  repeat it.
We could add a memset here to clear the filename up to the alignment,
as is done here:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/synthetic-events.c?h=3Dperf-tools-next#n529
```
memset(event->mmap2.filename + size, 0, machine->id_hdr_size +
        (aligned_size - size));
```

Thanks,
Ian

> >
> > +               /* Clear stale build ID from previous module iteration =
*/
> > +               event->mmap2.header.misc &=3D ~PERF_RECORD_MISC_MMAP_BU=
ILD_ID;
> > +               memset(event->mmap2.build_id, 0, sizeof(event->mmap2.bu=
ild_id));
> > +               event->mmap2.build_id_size =3D 0;
> > +
> >                 perf_record_mmap2__read_build_id(&event->mmap2, args->m=
achine, false);
>
> Thanks for the report and fix. One thing this change will fix is the
> dso lookup, as the previous mmap2 event's build id would be read by
> perf_record_mmap2__read_build_id for the dso_id. The other fix
> addresses the written out mmap2 event, which now won't contain data
> from the last event when reading a module's build ID fails. If reading
> the build ID fails, since the build id misc bit is clear we should
> probably write the maj, min, ino and ino_generation fields. In
> perf_event__synthesize_mmap_events these are populated by the reading
> of the /proc/pid/maps file but in
> perf_event__synthesize_modules_maps_cb and
> __perf_event__synthesize_kernel_mmap we probably need to stat the file
> if possible - mind you the non-build ID code there uses an mmap event
> rather than an mmap2 event, where these fields aren't present.
>
> So:
> Reviewed-by: Ian Rogers <irogers@google.com>
> But I think we can improve the perf_record_mmap2__read_build_id when
> filename__read_build_id fails.
>
> Thanks,
> Ian
>
> >         } else {
> >                 size =3D PERF_ALIGN(dso__long_name_len(dso) + 1, sizeof=
(u64));
> > --
> > 2.53.0
> >
