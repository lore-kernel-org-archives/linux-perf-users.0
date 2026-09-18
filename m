Received: from mail-ed2-f16.google.com (mail-ed2-f16.google.com [74.125.228.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5303A7F4B
	for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789722192; cv=pass; b=gOeDkZlYqOVQrEuAaiTKCvu/5BwURzHw71m6z1TDrYyZ6GV/fN72oilln5LJ9tPOTYhwofRrl+OO0WnkU6riTL03RnOLs8rTcqfszO/goOsbiVA79FXALTArRKnqVhiiFW0Dk69yaYZSSAZItm46eDzmDqhkQvVKe0fEy8Ku1MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789722192; c=relaxed/simple;
	bh=6TlD8wuSjPaN9GyN5XboLKvnCQX2Mh3eITva9cDh0w4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mArdgXUYQSRfcb03G0xzJi4prVSXcbc+u8zKpsILp5dhlp0ozHqXA3g6RpTb9/zlL4mmwTGhOXDsKBucC8mpM3qkvJIH1YCV+Xl3RXpbmIjVBSmCWJw9IHbmDxWIxeRipsGCqfbKSkbz10e/2YUlI2hdhbvne3bDTmpijrja9Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ackwVSn4; arc=pass smtp.client-ip=74.125.228.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ackwVSn4"
Received: by mail-ed2-f16.google.com with SMTP id 4fb4d7f45d1cf-6a9984f9adcso799850a12.0
        for <linux-perf-users@vger.kernel.org>; Fri, 18 Sep 2026 02:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789722189; cv=none;
        d=google.com; s=arc-20260327;
        b=b1z+KBUhS/3yUCJ7SNG7XljCyZM74mXclhoLSz1aZLrdAP+5xtEyzAH4zgZWN1JdQ/
         5e+OrwZSHvcG5UlUUTjzWwe0Y6REFj1POhNpSN3IafLAlhUuvQGzdhfuo0xCaLMAJgRZ
         KIWNB8Bi+qlFWUwYxP7zOfcrjO0Z7OpcCu0hm5ql50WN8b/Oy6Sw4PtCiderOaoSe0H9
         HrG4aSAKPuwf9iBLvKFIpGZq9HqYwCQqO2AwE7F7ZAb0No8p/D59h8XtZDV/wcdNUKnU
         VXjn85KqymcrSKPqttYgDufF4T5TXzcraGsQDQFNV+SBUpqif5Jdo2m4PGLHN5d9kDwv
         Y8WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZjnOddhe/+6nZrX2o26xcB2cmch/7OUqQ9vJUDa25zA=;
        fh=S86ddDpyNVItBIRnyXg6OqSz0rVeJ10ANhF9mUR+Bt0=;
        b=UZn2kI4ATdvJ/rHyHm6/7GFcENz6YR/+BFZWPIdJ90n6DI2Tp01n6nDV8kh/GT1qiG
         1s3xWc/ECoh4z2NSYCWO/9fApxEi+3VG+0lOP3xbFZBpI5/mvEwhZ5kuswE3MSzVSwsC
         6Y56MYcL5DWrg32p2FVMf0EFB/1m0A/luMMiI4UJDXkfvm63kdpiP0xuqYjLVEkuOvoe
         rdcQ1gq94CqtgW8e1mbq8X8Llo718RGde+FjD8Pi+uEFyFGUyT7jjoc60MlRtJwPebH/
         KBRNRUsT4ImOEwZUK8rNmGs85pPw/T641kQG2R36RGU268Zlvmbn8OeZMflDFaFmjirW
         XfoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789722189; x=1790326989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZjnOddhe/+6nZrX2o26xcB2cmch/7OUqQ9vJUDa25zA=;
        b=ackwVSn4WI8VtLcF8lb6kw/3eknAzvMlsGX8QlMCkh5ItgPC433rOEkyPO/tQmB2Gs
         30PaneC2jERsDSLcheLSKZ1z/bg/5OgFTiJF85byv/UA9h4i2IOHcmO+KCQO5sEoNH39
         5WdlsIsJBgxYJmDUHE6oKbRYWxI9RoKXJaVI0CuYJ4OgYdJhZuD2izy8QVvYy69yBcAj
         r2K/O28kNQi9G9Ynrv3LIhRHefXhUL7mf/XhfruFxgd2MpqMG0UUfPVxg6RCI/Mo4wki
         TuNothWQYZKYjA2l7vap2cXx7lyQQQiNbtqCztu4P9MbZkduKYa11C6jUhctNmBAuqXq
         u1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789722189; x=1790326989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjnOddhe/+6nZrX2o26xcB2cmch/7OUqQ9vJUDa25zA=;
        b=bFd6XWoS2MTYMg5MUnfqb5xMG2fGf/8aJJ4637C8w72KbRRt82HvK4FBynF6HU8ezl
         jYnGkT6sJqocFi6nrwQtL9GHpcw2Bz3DR46j/gIengmpLIK58SFBKDE/h1Jr3VTsqET1
         jHEsY7k3XvMhEg2hsu3pCBRbnQwq2M16VHW0AdbRpQytO7WCmykLTT2s43TPIzuIqOkA
         NbONWwoG++Dw9g5vHYUrJUdUDlsZ6fCLXrpk2JwdtBjQejuInL/hRZYKGqNU6oa13bRG
         qkZs/zu9mj3RIISz7d0CgJ0EKgx9Yq+bmDroK9j+/l4RPSUTt1ojY21mna4ar9znd+ST
         0vFg==
X-Forwarded-Encrypted: i=1; AKwUvBzznJZzJxcxxybTGyRaXg/RRe6mQo24A77GN47EBpSWIMPSMwIem9kxzw3TQIkuTySYrGDcRx82EcWeSaduyDg2@vger.kernel.org
X-Gm-Message-State: AFuF++ktaKUFZslBM/xfK93DAlPXDwvX0bw8UZFGbsYW3SRpLm3nAp3O
	64oPDivwHeOLoOVDawJ9NBPysiC70xa0edGQxg9AHPDStqqgyE5qsowFo5dugAeD4HChL0wVPFV
	emdzidZnyeEeyTDrSiUcwVf7jlxb2XPkEDHYY8PTX
X-Gm-Gg: AYBFou3A6J2lo+LhuzlRb8jPSkIxIkcqgp0UJCUKl+myvO+80FtD+KuFDq/v1zlE/KI
	N63HqKwSQ61786A0tAVSt/zj78v/zlxq6yYYrvyJB0kZV/N8YKyQ4D8+o1rjH5CMi2MFMm7h4zn
	E9uTOSSusigi0vQoCG2EJuLvZQbp1K/1JULjWOxtM2Yr+ESfW0sScakHQRXrMTmcH5drYIFPj+X
	YsiV9L4EqnLQqezkmiGhf5cDmTI5rCPp+FKemVz+OV3xH+V3JqlwHlQz5eXTyPSqopLvqI0h2Nc
	Wtrg1bgkGOOTZMIdciTGac5hRkcYZmJ+BWhI/dNEhLq9SjAlmkBFWuqA8cLg3uiff5PkIBDq9bZ
	R3lIB+0GcvBuABgOLxUscsbC5WS0Q+I95tTlldjaR+mFF+hKMFbu/XiE=
X-Received: by 2002:a17:907:9345:b0:c25:5a7:87f with SMTP id
 a640c23a62f3a-c2a1547f75cmr189032966b.0.1789722187933; Fri, 18 Sep 2026
 02:03:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416033443.1492483-1-luogengkun2@huawei.com> <CAP-5=fW3yFPj2HuSZHntUNgze3UdY3eSsMditKMw4yWRCfg_CA@mail.gmail.com>
In-Reply-To: <CAP-5=fW3yFPj2HuSZHntUNgze3UdY3eSsMditKMw4yWRCfg_CA@mail.gmail.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Fri, 18 Sep 2026 11:02:56 +0200
X-Gm-Features: AcwNN1Vl1kt_vkzCVFaTRtgcR8ATogeMjqtrHtAJDnxMsot94AuLZrOqOXFlq0M
Message-ID: <CACT4Y+YXrH3_7Je2+8r9-VV-4Dc4WekRrz-9_Pe-Qj1tfFDtDg@mail.gmail.com>
Subject: Re: [PATCH] perf/core: Fix race between perf_event_exit_task and perf_pending_task
To: Ian Rogers <irogers@google.com>, elver@google.com
Cc: Luo Gengkun <luogengkun2@huawei.com>, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, james.clark@linaro.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	peterz@infradead.org, mingo@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 15 Sept 2026 at 23:35, Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Apr 15, 2026 at 8:08=E2=80=AFPM Luo Gengkun <luogengkun2@huawei.c=
om> wrote:
> >
> > A race condition exists between perf_event_exit_task() and perf_pending=
_task().
> >
> > During begin_new_exec(), perf_event_exit_task() may be called, and the
> > PF_EXITING flag is not set on task. so perf_sigtrap() continues to exec=
ute
> > and triggers WARN_ON_ONCE(event->ctx->task !=3D current).
> >
> > To fix this problem, also check if the event->ctx->task is TASK_TOMBSTO=
NE.
> >
> > Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> > Signed-off-by: Luo Gengkun <luogengkun2@huawei.com>
>
> Dmitry, the description and patch look sensible. Could you take a look?

Marco, please take a look.

I paged out all context long time ago... The code is too tricky to say
if it's possible/not possible/fixed by the patch/not fixed by the
patch looking at the diff.
A test would be helpful. Will also prevent regression in the next release.



> Thanks,
> Ian
>
> > ---
> >  kernel/events/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 1f5699b339ec..3422900263fa 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -7543,7 +7543,7 @@ static void perf_sigtrap(struct perf_event *event=
)
> >          * Both perf_pending_task() and perf_pending_irq() can race wit=
h the
> >          * task exiting.
> >          */
> > -       if (current->flags & PF_EXITING)
> > +       if (current->flags & PF_EXITING || event->ctx->task =3D=3D TASK=
_TOMBSTONE)
> >                 return;
> >
> >         /*
> > --
> > 2.34.1
> >
