Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121E434E51
	for <linux-perf-users@vger.kernel.org>; Tue,  7 Jul 2026 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783447142; cv=pass; b=Sc5GDpLZ9gdio+je723TVbrSOW5bKlmQx8ztV3SYB8DieXGlYhUdN+4JBjNpfdGkFMViJ5C00pQ5CX73od1Dt2MV1HjrbobHIIa4ZscrkPKsufW2vwI2uiBnRuRwempuvclEj70/zdv9ASVfByTh0kslTyO/SA+mrD4TMinsuVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783447142; c=relaxed/simple;
	bh=gWTeSD9poTg46O4+IeCw/XsrxHlO/aMfCHPgEBmo+wQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yk11htwwA/JTSznFoIQmNSgfTVbKvmJF/tqbmd1pgk0sN6vGRP2byzlmNAN2rfK7qCLFxPM39LNkrFdbMiyxy+PeZBX3aUcHZ2/bKkrh8zHV4IqOolWxQCFuJs2EMLyBVPvK6TbCqDZIX07Xcw3y08vi1OdhqvuDMyR8pUBodfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gPsOhiyr; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gPsOhiyr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ccdf36f63dso9335ad.0
        for <linux-perf-users@vger.kernel.org>; Tue, 07 Jul 2026 10:59:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783447140; cv=none;
        d=google.com; s=arc-20260327;
        b=hGbUs7pWZaix7Mk70Kk9OxZhsCO+HFgQJ7SEK97MFIbnuWJKtqOw9EX29KjLtSmPoo
         fJ5DDB1XEirOVJAotfkg3ATKCapZYZfiuLRJ8ae9GJOgjMgiknBKPO38ZWhgh7nJbIg1
         u//3E26IcRE6SbKJRl+dm1JCPKOj4JI5AGdPqIuY2LArjBrhBey6vlh1E8FqwyeCYbCz
         wH24pWNikymSaUp2yVsW/Kz854RVYdo5IQNrd9xU4/ppUUo1t9OKestN2hRUtayTRVr6
         8Tc+i5fjAPhuqWzZ4SoXyW+nU7WOYW5q2zp2HgkJ88ak5Hi5rhcbb2BSfrr0lYF/zACh
         7G7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lJpmSCQb7JPh8DN3AUk0v9N/JxhqbqclIPM8uoArkRs=;
        fh=c3LNkZH3giN8H0LzNrGmXtk1Iqtmdw+mEVYGjPp7yqU=;
        b=scc9uRRNphAeennk4a/PfBhDzXuAVEw8Fl06rXkHaHiimOEucYoasju3rB9SwmjIOF
         grQSm4zqVDJmmwC5DQ+f9xMgKZhfmB/RgfD8ojbGIokjmS6Qqd1OAqTLxxN146fQYMkr
         kUpf8y/VF85AfPEdlkpeLd6eKwvqNa4ui/lvOopnCwKAGuwPUkQvChGQnwhEUtSDFx9r
         J3MO8ocjP43ftKTrosrtgSy6Ld5uNbAl2XfcL+nZBgh68TiKiNG9EhSWtlKU56HdLl4r
         zFQ9VtJBPHrJs3XF1FJqLqvAmZPbnTych+JI2P6FnCRGqWQB+VZVRq71giLleWxM5cjX
         7/3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783447140; x=1784051940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lJpmSCQb7JPh8DN3AUk0v9N/JxhqbqclIPM8uoArkRs=;
        b=gPsOhiyrP5jKXX1I29sOcaJVAfxW8BE8VHTFmRQqiCNUmS5gSIp85LX/mYaZ4QOeKf
         4khxdhqBuejKWD307uKInHHm+xCWhtIti3yRY+hqaCFERkC0ZbfBM7lad9p6tihp38b8
         IJgBNPTyBnS2aqTk4r87jmr384csakswq79HezVQB8ukMDm0ntQ5DGsGHvwNB+bnTgW0
         HRcbyFytdZxuo5WFOX9iAEYaJzPki+NkOX8r8l4lx4jrEDKLqdTbsv3QLwxO4klkT3yi
         abF6wRGFbLfHp++40Mmil/Xwfjgc6AmpZUjhVtxYG4U9+ZtxODLysnVJpQu7koOhj6TK
         vbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783447140; x=1784051940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJpmSCQb7JPh8DN3AUk0v9N/JxhqbqclIPM8uoArkRs=;
        b=qpyNbFrAd7BkDazQIoLfRSFoK1gEC5WxlcqBw7a8bn7Qxnd5VJJ8udu27y3em1fW5/
         VRQngG756OM2FRfc2jvS/TPRt2BV4fSUAol8b5NPBGLnuxU8aCLFU9QACSaY9fK9ZKOx
         +tAshs/fQIIFsh20D9R/AyE0L3nBhsrqKtecmtuOPGhS9WtolquYpVkBRkoCwVOIy6Ir
         tMUjgcJubx6XPqDES6iiZjeZc6MGvv7tW8Q/IJobs58JAmKapvuukjeu64FKoj4z1iYj
         rkiNQI6OWXMzfi8OYB6syHehVxgwDSl7gHJmZ2Resl0FLTbisS8FtftAxyxaD4LWz6MA
         F1hw==
X-Gm-Message-State: AOJu0Yz0aJuPC8MUrSs9wXLLVZxb/bqTRO2p/k/wz9MCWDftlVYT8HkV
	17Izg0DHm+5IWDX4HWD7EIj0smuM6SLtoTc0IVDDl2cJqiwUTPinbOFFHKt9RxgRxh89cuN4SQ7
	knXn7EsHnEqGktUaoNCsTT41YxuG5KR9QMWZcFY6n
X-Gm-Gg: AfdE7clBvU01rEuENzBwQNmw6Hb3jZJKXvmjGoEoBp1wcVfmenWgZdtnOpnXVXvPyZ+
	U2wySVCE/Po5lVU9DXsPbDrlwc/bCXJcLhW5rTmDCQgZyCRuHjCrKC1JdM4uipmnb2Y51zn8tVc
	WKSOmpAagsCH8GUKHeZ/N/wjgvYdtYdb4fw6QHtl7egaORdrtYNNXaSLHKlVR6+8oebZ+DLBVPR
	xRFkCxkeefFNNjhkToZuiPlJdfd4pMqDvgsxs/ePqnN3kEwzwgi5rugdoM5yTQfc5ug3BO0zWdm
	+pX6tlotprHKAHR3Yvq62+M1nD0=
X-Received: by 2002:a17:902:d4c1:b0:2ca:d9ec:322c with SMTP id
 d9443c01a7336-2ccc9cdcd8fmr3998845ad.24.1783447139875; Tue, 07 Jul 2026
 10:58:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260707153801.315352-1-abyssmystery@gmail.com>
In-Reply-To: <20260707153801.315352-1-abyssmystery@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 7 Jul 2026 10:58:48 -0700
X-Gm-Features: AVVi8CctjJRtHvex5DkZjTA7u_bIxjQULf4vC8epBj2Tqpex7qm6NtK2C8a6-mI
Message-ID: <CAP-5=fXPD84ni_Db=P=18t88wmXAM7iwBXkXJYU7kgQFYO4VtA@mail.gmail.com>
Subject: Re: [PATCH] perf record: fix poll storm when monitored threads exit
To: Jiawei Sun <abyssmystery@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, acme@kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, james.clark@linaro.org, 
	alexey.budankov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 7, 2026 at 8:37=E2=80=AFAM Jiawei Sun <abyssmystery@gmail.com> =
wrote:
>
> When `perf record` samples a multi-threaded process and one of the
> target threads exits during the session, perf itself may start burning
> 100% CPU (up to 200% across two cores) until the session ends.  A
> single dead fd is sufficient to trigger this; it can be reproduced with
> 15 pthreads in a compute loop where one thread exits halfway through.
>
> The root cause is two independent instances of the same defect: dead
> perf_event ring-buffer fds are left in a pollfd array.  When a monitored
> thread exits, the kernel closes its ring-buffer fd, which then returns
> POLLHUP.  POSIX specifies that poll() always reports POLLHUP and POLLERR
> regardless of the events mask, so any dead fd left in the array makes
> poll() return immediately every time, spinning in a tight loop:
>
>   3 seconds: 256,600 poll() calls, 0 context switches, only 21 write()
>   Woken up count goes from ~0 to 1,300,000+
>
> There are two affected poll paths, fixed together here:
>
> 1. Record main loop, via fdarray__filter() (tools/lib/api/fd/array.c).
>    Since commit 59b4412f27f1 ("libperf: Avoid internal moving of
>    fdarray fds") it only zeroes events/revents without setting fd to
>    -1, so poll() keeps reporting POLLHUP for the entry.  Setting
>    fd =3D -1 makes poll() skip it, matching the pattern already used in
>    the control-fd path at tools/perf/builtin-record.c:1673.
>
> 2. BPF sideband thread, perf_evlist__poll_thread()
>    (tools/perf/util/sideband_evlist.c).  This thread polls for
>    PERF_RECORD_BPF_EVENT but, unlike the main record loop, never calls
>    fdarray__filter() at all, so dead fds accumulate forever and it
>    spins at 100% CPU:
>
>      Before fix: dJiffies=3D101, wchan=3D0 (running)
>      After fix:  dJiffies=3D0,   wchan=3Ddo_sys_poll (blocking)
>
>    Fixed by calling the existing evlist__filter_pollfd() helper after
>    evlist__poll(), mirroring the main record loop.  <poll.h> is
>    included for the POLLERR/POLLHUP macros (previously unused there).
>
> The two fixes compose: fix 1 makes poll() ignore dead fds (fd=3D-1); fix
> 2 ensures the sideband thread actually performs the filtering.  Both
> paths are affected in all kernels from v5.1/v5.9 to the current master
> (7.2-rc1); the source of both functions is byte-identical across them.
>
> BPF event recording is preserved: after the fix, perf.data still
> contains PERF_RECORD_BPF_EVENT records and bpf_prog_info entries.
>
> Verified on perf 6.1.76, 6.6.143 and 7.2-rc1 with a minimal reproducer
> (Woken up 1,300,000 -> 3, CPU 100% -> 0%) and an A/B orthogonal test:
> keeping the unpatched binary but preventing the target thread from
> exiting also makes the storm disappear, confirming the trigger.
>
> Fixes: 59b4412f27f1 ("libperf: Avoid internal moving of fdarray fds")
> Fixes: 657ee5531903 ("perf evlist: Introduce side band thread")
> Signed-off-by: Jiawei Sun <abyssmystery@gmail.com>

This all makes sense and reviewing the surrounding code I don't see
issues. Sashiko is also happy:
https://sashiko.dev/#/patchset/20260707153801.315352-1-abyssmystery%40gmail=
.com

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/lib/api/fd/array.c          |  6 ++++++
>  tools/perf/util/sideband_evlist.c | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/tools/lib/api/fd/array.c b/tools/lib/api/fd/array.c
> index f0f195207..ffe8272af 100644
> --- a/tools/lib/api/fd/array.c
> +++ b/tools/lib/api/fd/array.c
> @@ -122,6 +122,12 @@ int fdarray__filter(struct fdarray *fda, short reven=
ts,
>                         if (entry_destructor)
>                                 entry_destructor(fda, fd, arg);
>
> +                       /*
> +                        * Set fd to -1 so poll() ignores this entry; oth=
erwise
> +                        * POLLHUP/POLLERR are still reported for events=
=3D0 fds
> +                        * (POSIX: always checked), causing a poll storm.
> +                        */
> +                       fda->entries[fd].fd =3D -1;
>                         fda->entries[fd].revents =3D fda->entries[fd].eve=
nts =3D 0;
>                         continue;
>                 }
> diff --git a/tools/perf/util/sideband_evlist.c b/tools/perf/util/sideband=
_evlist.c
> index c07dacf3c..ba043db6c 100644
> --- a/tools/perf/util/sideband_evlist.c
> +++ b/tools/perf/util/sideband_evlist.c
> @@ -8,6 +8,7 @@
>  #include <perf/mmap.h>
>  #include <linux/perf_event.h>
>  #include <limits.h>
> +#include <poll.h>
>  #include <pthread.h>
>  #include <sched.h>
>  #include <stdbool.h>
> @@ -55,6 +56,19 @@ static void *perf_evlist__poll_thread(void *arg)
>                 if (!draining)
>                         evlist__poll(evlist, 1000);
>
> +               /*
> +                * When a thread of the monitored target exits, its per-c=
pu
> +                * ring-buffer fd is closed and starts returning POLLHUP.=
 Such
> +                * dead fds are never requested for POLLIN, but poll() re=
ports
> +                * POLLHUP/POLLERR unconditionally, so leaving them in th=
e
> +                * pollfd array makes the following evlist__poll() return
> +                * immediately forever, spinning this thread at 100% CPU.
> +                *
> +                * Filter them out here, mirroring what the 'perf record'=
 main
> +                * loop does after fdarray__poll().
> +                */
> +               evlist__filter_pollfd(evlist, POLLERR | POLLHUP);
> +
>                 for (i =3D 0; i < evlist__core(evlist)->nr_mmaps; i++) {
>                         struct mmap *map =3D &evlist__mmap(evlist)[i];
>                         union perf_event *event;
> --
> 2.39.5
>
