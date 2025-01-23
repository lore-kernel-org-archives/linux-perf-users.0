Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531041CAA82
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 21:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669187; cv=none; b=WnzknW1R9sCt3xKF1QjiQS0+gWesCPRJQ6N+ab5qIwS6E/P22BSbeEaGr1voT5yQBlxDGQBvle79F3FCnvDpJs6VGo3EFc+tlaXPXbEtJQcTeBZR8uUA5b1EG91EEtX0PjzcXsr972oSIHpHOgk7xlxdatm0zSHQzGCGlXPuCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669187; c=relaxed/simple;
	bh=zKuaqHe3ECZ+QZJ2plP1NWcmvneXigvDjbh4dDIey84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqPcdXSaJjoomwzAWpqfBA8wzitD/pg/FNp+2heZazZiS69MlPc1McvU5/aa1Xg2U26jDRtlJErSS6N77R3/hCtco2vcsTxZkTQ9JY/fsZtRAxK62vInMbLsE8QfEeAewiDrU4ONIUMbeT9PynbYC2+8naZLjklJ1zVHLZ27mYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mZrSJIX3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mZrSJIX3"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-467896541e1so70021cf.0
        for <linux-perf-users@vger.kernel.org>; Thu, 23 Jan 2025 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737669184; x=1738273984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHGt0WbleYB5l+m2dLlfWbtdjxWYo81KWqBel+Isirk=;
        b=mZrSJIX3jKSn/SHtCgZOyvB0W2eF33yPdj6WsAfx1FQOv9U+JNX8wzB/XIBa73PAr0
         ReJgkrba1SMbpMf+YPbj085qMjHuiDNW1Fps8sfnRKe782rU73DM+PnAeJad7QC4tNEV
         qve0/jSI7suadkwhuSBsRYK38xm+LzgjVMKY8IxEtlr0XypAofSFgk85e3SSgZGdlUMK
         3xUz1xtKofOHLeQmx+wWESdkisDS3fsmzRYg1/f71zUFMQioT5x+bo6vJd1OiKhARcdG
         aJoFd/+t88ir3ai/DG+OVXhw4ZpUGfKxqxb9oXi+fTpN1BMAH9kEZ6JzLUJSoRHakI8z
         YIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669184; x=1738273984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHGt0WbleYB5l+m2dLlfWbtdjxWYo81KWqBel+Isirk=;
        b=weOdZKYvERCcYACNi2RxZVR1VgsqYu79ZB72stjv6mfXh1lQHq+K8a15yH4nL91LLm
         zT65xhBnASeZ13XL0XNF2+/QhAR2Th/FXGqQmf9/4MhMltmAa7wkNN3fFQCQk6hqItsZ
         W1eUf8UFfjan4AGSGaSXEZRjluqQEIzbuK0bsfMaqxmWieFa8A/zKujHctbmC0dD0brj
         zUhJqYPkaqijqo0k5KOVNnujUrSxK9kCJqOxupS6ZO2e/HDKv10Xga9WSxSFDNWKalxH
         JrdHQrW4dPMOlNIlLZGC4jq5WIaktaN+yWFGAMKxwWcUXKldvqQeM0/OqI6ON0tsoN6A
         eQlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbVnW0svSh2MKYYMfFycfOw3jm0JQRs2YTxmRxNpWqRGEUuq2g8FFsg5dOIa/qbOZvL55N+4YcN5ZsbjjxuS+t@vger.kernel.org
X-Gm-Message-State: AOJu0YxhVTX2krLdFTEjW28tUEOP4fnwegewGdTOrC3nN4U94Dh5rLXK
	MIuVbI55wV2Kg6d8SWAuxZZtD2doe32nqMiEirhq8jrpoc9nYdwMWOD2nxk0MhGakpbCpM1D3iq
	KKsLxBwPWMp7hH+kGxEETnBVguiDPKsOACfv9
X-Gm-Gg: ASbGnctzjTExY1vS/LDAxCTP0+O0T2Zt0PkM+Yz0wIomROJ0fdWdWWY1JiqcKPTfPGW
	FVXXAk1aBiaICuvXHzKsFXCs0aMLSmG/LRM95/nIaqKGyOXp3lbYD70AWEwMLO1JgAm5N9b8ifn
	jE3bbeuGLYeSyoRuPyD58v95WOorw=
X-Google-Smtp-Source: AGHT+IFrvyD1YIeawr10Rqwn0aqWOnQMagnJHkBqii3YUgDR1PE9AGJ2YTglhmvCvF2LAkLUTFvBu1sN/7u/Lgk0CGI=
X-Received: by 2002:a05:622a:1aa6:b0:46c:77a0:7714 with SMTP id
 d75a77b69052e-46e5dadbf65mr4804111cf.21.1737669183862; Thu, 23 Jan 2025
 13:53:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123214342.4145818-1-andrii@kernel.org>
In-Reply-To: <20250123214342.4145818-1-andrii@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 23 Jan 2025 13:52:52 -0800
X-Gm-Features: AbW1kvYitEyfLCjZHD7-lTTvjs22unJX8NoVKvDf4fLvx82SDzv6eFu65vu0VC4
Message-ID: <CAJuCfpE9QOo-xmDpk_FF=gs3p=9Zzb-Q5yDaKAEChBCnpogmQg@mail.gmail.com>
Subject: Re: [PATCH] mm,procfs: allow read-only remote mm access under CAP_PERFMON
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
	rostedt@goodmis.org, peterz@infradead.org, mingo@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	shakeel.butt@linux.dev, rppt@kernel.org, liam.howlett@oracle.com, 
	Jann Horn <jannh@google.com>, Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 1:44=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> It's very common for various tracing and profiling toolis to need to
> access /proc/PID/maps contents for stack symbolization needs to learn
> which shared libraries are mapped in memory, at which file offset, etc.
> Currently, access to /proc/PID/maps requires CAP_SYS_PTRACE (unless we
> are looking at data for our own process, which is a trivial case not too
> relevant for profilers use cases).
>
> Unfortunately, CAP_SYS_PTRACE implies way more than just ability to
> discover memory layout of another process: it allows to fully control
> arbitrary other processes. This is problematic from security POV for
> applications that only need read-only /proc/PID/maps (and other similar
> read-only data) access, and in large production settings CAP_SYS_PTRACE
> is frowned upon even for the system-wide profilers.
>
> On the other hand, it's already possible to access similar kind of
> information (and more) with just CAP_PERFMON capability. E.g., setting
> up PERF_RECORD_MMAP collection through perf_event_open() would give one
> similar information to what /proc/PID/maps provides.
>
> CAP_PERFMON, together with CAP_BPF, is already a very common combination
> for system-wide profiling and observability application. As such, it's
> reasonable and convenient to be able to access /proc/PID/maps with
> CAP_PERFMON capabilities instead of CAP_SYS_PTRACE.
>
> For procfs, these permissions are checked through common mm_access()
> helper, and so we augment that with cap_perfmon() check *only* if
> requested mode is PTRACE_MODE_READ. I.e., PTRACE_MODE_ATTACH wouldn't be
> permitted by CAP_PERFMON.
>
> Besides procfs itself, mm_access() is used by process_madvise() and
> process_vm_{readv,writev}() syscalls. The former one uses
> PTRACE_MODE_READ to avoid leaking ASLR metadata, and as such CAP_PERFMON
> seems like a meaningful allowable capability as well.
>
> process_vm_{readv,writev} currently assume PTRACE_MODE_ATTACH level of
> permissions (though for readv PTRACE_MODE_READ seems more reasonable,
> but that's outside the scope of this change), and as such won't be
> affected by this patch.

CC'ing Jann and Kees.

>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/fork.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index ded49f18cd95..c57cb3ad9931 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1547,6 +1547,15 @@ struct mm_struct *get_task_mm(struct task_struct *=
task)
>  }
>  EXPORT_SYMBOL_GPL(get_task_mm);
>
> +static bool can_access_mm(struct mm_struct *mm, struct task_struct *task=
, unsigned int mode)
> +{
> +       if (mm =3D=3D current->mm)
> +               return true;
> +       if ((mode & PTRACE_MODE_READ) && perfmon_capable())
> +               return true;
> +       return ptrace_may_access(task, mode);
> +}
> +
>  struct mm_struct *mm_access(struct task_struct *task, unsigned int mode)
>  {
>         struct mm_struct *mm;
> @@ -1559,7 +1568,7 @@ struct mm_struct *mm_access(struct task_struct *tas=
k, unsigned int mode)
>         mm =3D get_task_mm(task);
>         if (!mm) {
>                 mm =3D ERR_PTR(-ESRCH);
> -       } else if (mm !=3D current->mm && !ptrace_may_access(task, mode))=
 {
> +       } else if (!can_access_mm(mm, task, mode)) {
>                 mmput(mm);
>                 mm =3D ERR_PTR(-EACCES);
>         }
> --
> 2.43.5
>
