Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A439209F52
	for <linux-perf-users@vger.kernel.org>; Thu, 13 Feb 2025 07:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431673; cv=none; b=tRBAXV4JVWOKMWYwAfhJx4sjtZCzqwxmEIvCmS3xjRDImCsV6ZeeEh0l4uHzE+yYZ9sa69dq6Es9tvO2PwdlOJWz+wxriz7Uog6Qi8d2E3KXmSjh6ImmFoNXB+wqg1uTG8dgr/TrFV29vdEbRxKhucgl9JLB3iMRymfKm4b3Ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431673; c=relaxed/simple;
	bh=plxTwgeTq7F6yUyHdWE5jJ10XrQNBo2r7azFr7961V8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NnFOrugyRcFd7w0ZqH62EL6wW6WY3rbxyvh8i1glkECQoZr05xz9MfaHVPTgx3EBaE+hvk8YUBzeZJAmTiwwLozTgqWucWZo7uZM3tvm4MWuByMnXzFTRlt+Vc7SQsfkdU+0j94gb4RM5D1UBATiTDg9GxA+k1d2+XXpBZmUZkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S9TcdN5l; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S9TcdN5l"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3d147331fb5so69605ab.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Feb 2025 23:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739431670; x=1740036470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5FejQoCZenuFrsg8Vi9rlyqVpbgfi4ZA4sjxV11J6CY=;
        b=S9TcdN5l0rSEc6OuTgEhKE3PgeAMCwlaqW1Te38q/XjLp5qBcBmYVNGXDYxcWHFgW+
         xl9rbNk7SGg5EUj+U0GL2pYAyE1k7H7rLM3Cb3Xvgb2E2P3pEYxWHw/q7bqn7OxkFGnD
         j8OlEFd+n9/qLI3vHhnd2+cPAMbd2aDAt5gjjPaaDuh1WEIEhKRrzxs/GWHwmUAxT5UK
         gP/K1nbk/rzqwGHxDnmudCMXgFzTxiNgTedYIruhEMWBXOMvjN6zUCJR3+jW0akvIy0u
         /+5+ikdzq7VlGyuh9Xpx/V+nNjtMIIfuFEEUAMH4KL8+KvtD6v5UjJjToTaePoM7yx7a
         vCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739431670; x=1740036470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5FejQoCZenuFrsg8Vi9rlyqVpbgfi4ZA4sjxV11J6CY=;
        b=bFeqj6PBRgzvVv53HJYj1AU6s4ltS821fusmPC3p+FdPU4dC0lENtf2RqwYQRgyRNN
         3wyh1mWoUVCqj5w70g02B4syeHZr3iSmbeY3/gKu6ZunU6/lHgdgcALfaqVrzqTSUeAp
         X1YSuSwFgDjV0HeglOwdOCZHGqZg4z6BNTfxKJK7C1vxItByslqyaVQDsrqHwQVVPj04
         JM8x0CCTTBGNBqUATXPmhlg/CNLfldct6S3uEhTt/AWy3jz7LJq6LFyArGxB4qW53yqQ
         y1hmURdlU9X67r9Oi4RrSJdgU0j+6Nge6iZPP8JdfTGyfVEZsVQTa5uDKZmmjRXgPIHM
         ix1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV4PDfBkiQO37BrsFvDvHQwlt9AreT5/R9O6dIjUK4W5GsXSOeXfL7OyJCQUJxAUGpR6vclewSjMOgy3nX6bK8g@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3bkAuNRwwo6ImhozWEk8gnT+TBrM0h4KBeA21XvGCTVKJ+n2i
	uBGAvmvEhjsFuvQR0Dzbiyf3rwseQyLrDOrycM7tvTX1iuxXuJGJVpxJJXgNLxpmOUQSukcV+2M
	6nlS408B6shk1GD1F50WeNKYABZgzyBxLRqNg
X-Gm-Gg: ASbGnct+Atq3ZLVb6n1yshPsOj76+xYMAOkOaoJVztwHi2U9JbGC49IyTCqsqhnh8pB
	0s97Ld5vLCMW9/iYA4Eq/RYdo9B75Ql+FWCiFuQ3L8mLdR+CZ19Tqb3EHFN3ZkW/xEbOKg2JVCA
	==
X-Google-Smtp-Source: AGHT+IGTlzfWGThHpMP8V7PEgexl4+UpAdBXGKqVTuU4gjUHt87FerVNVR3Cng+HnAP7JgQJ0VZ+gjZnJrljAcjp1FM=
X-Received: by 2002:a05:6e02:1c89:b0:3cf:aeb5:c5cb with SMTP id
 e9e14a558f8ab-3d18cc8fc1cmr2822955ab.8.1739431670250; Wed, 12 Feb 2025
 23:27:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z6rAHhAIdlkAryGJ@google.com> <CAP-5=fXjmJ+Rr7ejL6fCMeu6PZSit7n84hQkjh=0jQhkr1on3Q@mail.gmail.com>
 <Z6uOGNO6p7i9Fese@google.com> <CAP-5=fVxFe4nMS_dHmO=6-ddA40XbVdvouPLuOxj5cenjUr8ng@mail.gmail.com>
 <Z6v-mPJq6m61pFA4@google.com> <CAP-5=fU+-4igQomO4Q41=7xo6YWyDdVqJdZd34dcMUS-Ua=N1Q@mail.gmail.com>
 <Z6zslLa8XM1ubwXj@google.com> <CAP-5=fUrzPvV3sD1_wMzQ7dF8xk3hL9_nkdS6toFjt7L+SRsgg@mail.gmail.com>
 <Z60nBQCetMzhRg5b@google.com> <CAP-5=fWG7JOmQhTa+OccOxSLhik6Du-qy9d90q-zhDTu0P=q3A@mail.gmail.com>
 <Z61OeArP-P-I5NjU@google.com>
In-Reply-To: <Z61OeArP-P-I5NjU@google.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Feb 2025 23:27:38 -0800
X-Gm-Features: AWEUYZnMmcb06RsPzW1yAcBRDWFHnL-gV43xQhFBafDLiEBaXsxELUGSHeBzwlg
Message-ID: <CAP-5=fXTLBb1+PghPCraJQcXY518Jtt3AwPLpoXvjXErW79U5w@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] Move uid filtering to BPF filters
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	Hao Ge <gehao@kylinos.cn>, James Clark <james.clark@linaro.org>, 
	Howard Chu <howardchu95@gmail.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	Levi Yun <yeoreum.yun@arm.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Tengda Wu <wutengda@huaweicloud.com>, Yang Jihong <yangjihong1@huawei.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2025 at 5:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Wed, Feb 12, 2025 at 03:17:35PM -0800, Ian Rogers wrote:
> > On Wed, Feb 12, 2025 at 2:56=E2=80=AFPM Namhyung Kim <namhyung@kernel.o=
rg> wrote:
> > >
> > > On Wed, Feb 12, 2025 at 12:00:42PM -0800, Ian Rogers wrote:
> > > > On Wed, Feb 12, 2025 at 10:46=E2=80=AFAM Namhyung Kim <namhyung@ker=
nel.org> wrote:
> > > > > It's not completely broken and works sometimes.
> > > >
> > > > No this is the definition of completely broken. If it only works
> > > > sometimes then you can't use it, we can't put a test on it, there i=
s
> > > > no point in it. Even when it doesn't fail on perf_event_open, does =
it
> > > > work for processes that start after /proc is scanned? No, it is
> > > > completely broken.
> > >
> > > Ok, we have a different definition for it.  Let's ignore the imaginar=
y
> > > users of the broken features.  Have you added a test for this change?
> > >
> > > Anyway I've tested your change and found some issues:
> > >
> > > 1. It silently exited when BPF-skel is not built.  Better to put some
> > >    messages at least.
> > >
> > >   $ sudo ./perf record -u $(id -u) -- sleep 1
> > >
> > > 2. Even with BPF-skel, perf record doesn't work well.  It did somethi=
ng
> > >    but failed to get sample data for some reason.
> > >
> > >   $ sudo ./perf record -u $(id -u) -- sleep 1
> > >   [ perf record: Woken up 1 times to write data ]
> > >   [ perf record: Captured and wrote 0.045 MB perf.data ]
> > >
> > >    Oh, I think you now need to pass -a because it now works in
> > >    system-wide mode and drops samples for other users.
> >
> > This is a pre-existing problem, no?
>
> No, it worked without -a in the past.  Please see my previous reply.
> I think -u/--uid is one of the supported target in the perf tool (not
> for the system call) and it used to disable system-wide mode if -u is
> used at the same time.

As I keep repeating the '-u' option has never worked in the past, it
either early exited or missed recording new processes.

The documentation for `perf record` is:
```
...
       -a, --all-cpus
          System-wide collection from all CPUs (default if no target
is specified).
...
       -u, --uid=3D
          Record events in threads owned by uid. Name or number.
...
```
So `-a` is implied without a target/workload but you are specifying a
workload and `-u`. So do you want samples from the workload or from
the user's processes? I can tell from your command line being sleep
that you want it to imply `-a` but would that be true if it were a
benchmark? For the benchmark case you probably don't want `-a`
implied. If you specify `-p` and `-u` should the processes that don't
match -u be sampled or are you expecting implicit system wide
profiling now?

I agree the behavior in the patch series doesn't match the existing
behavior, but I'm not sure the existing behavior agrees with the
documentation nor working as expected. Having the `-u` not select
system wide, as in the patch, seems to agree with the documentation
better. You have specified a target workload/process/eventual pid and
you want samples owned by the uid, why should you now start getting
samples from other processes? With `-p` you wouldn't expect `-a` to
suddenly get implied, I'm not sure it makes any more sense with any
target/workload.

> > > 3. With BPF-skel, non-root users will see this.
> > >
> > >   $ ./perf record -u $(id -u) -- sleep 1
> > >   cannot get fd for 'filters' map
> > >   failed to set filter "BPF" on event cycles:P with 13 (Permission de=
nied)
> > >
> > >    I think it's confusing and better to tell user that you need to ru=
n
> > >    'perf record --setup-filter pin' as root first.  But maybe due to =
the
> > >    issue #2, you still need to run it as root.

I think that is an okay addition to BPF filters in general. I'm wary
of having patch series feature crept into requiring the entire tool
being reimplemented.

Thanks,
Ian
