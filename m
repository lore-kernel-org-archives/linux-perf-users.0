Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D0A1EF39F
	for <linux-perf-users@vger.kernel.org>; Tue, 17 Jun 2025 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750134989; cv=none; b=I4Kti0lMS+SkuFiCPT+AVFS0FYN76ILf5w1nPpaC/4lRpqj65oISyjD3MSK+UJ8BU5oNv/4IHimflneBkSkd0MwwAA8MvI6j8Br3fd/TFrQlKJtcnfxB3S0araY6P+4tksy+Yz7P7ZIoRcBoP3ZqdBYcsL4Eb5SmtHh5eOwH63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750134989; c=relaxed/simple;
	bh=peJGVOouWDDOE4go7WfuBFhVBMsA8bJZwHHfnK8sPrU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qWL2AYYq93rMLB8bykuKfaJXEcqtJeXO5NhUA9TUTOpBgvQNu3UK3OF3U6Uhch2wxlYxjGw7o5cy6CadvnKt9+sq4IamqCxDDZi9Q0BtmGPhQ/AG4trYHrj19yfzTRDFOqmJIKevKVaGYZH4a/qXlNMC21qZ3MdHi14mYIV+5p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f/0yirsk; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f/0yirsk"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3ddd1a3e659so63095ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 16 Jun 2025 21:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750134987; x=1750739787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXqEuGWyhC1IDbKEyxK+WsF40e66qLVAXVMUF9UX+Pw=;
        b=f/0yirskxiH+ScOs61Do35t6vVGrRMSw/2jKeRoGuqmIguER+qYKni7cmbW6m3L+k6
         mqYYZy3aGOh8917BaOLn9QIMQ0BP8GKG8qRq0FU3bM/6atJUc6BvY51DE2KpWtqyRgmh
         L0Snb7F+zedY8dkEjvfrQ7O74OZfiGsRUMIvtj4kbkKmw+1u6qjSLDBLzACS6DaZDU2H
         aNngbPVFrGpz8ATYS3YNCfuI7lKLAnxG4bR17edEcyG0vC3xeo5SyPlE5YSoHx5n50gh
         tRbMARinzUFVf4tysn/hC4w38tXnf42JFT42bJHe+as1uyP8Q2Hd/QwjFBEc+He0zI2Z
         XRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750134987; x=1750739787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FXqEuGWyhC1IDbKEyxK+WsF40e66qLVAXVMUF9UX+Pw=;
        b=aPYIcbxbOGnWU6pQJbEDs5hCIlVQPM4fjCkUHS8txbU1JM9y4Re9qyy9u+QlQZsO59
         mI3O7IwL3vR1nknwnf/QQAa6EzdKH4+lTJvczhuo9iT/YVSepi0Rj5O2/rGTABPKdRMa
         RpZ0XA5KjOxyvAkjQrZu8T2GjQCTVNCPlGpsaSj0VBcTDciGcciQ9dMh/KI/HDa2szJb
         Hg5Er6CLvxWZhS3LSr3L4LKsXhtZv0hSEIFOWPBI1owdP+ESgVYf9Hdxdrt4vJDcq9kj
         +dwhuDtzzSOTcybyYj4CHwF11VuPyjxLb4j2XyzIUXfkVp9hrOsfvRGxENhu+5WZJKjz
         c7bA==
X-Forwarded-Encrypted: i=1; AJvYcCXTGbc/DXXSDsra34QgiVEyvW3l42mCAoAVpBXiOUlgR0pxN8D1BGlZvUPVNfeKin/699xBzMrZRHxGIdZ8cxBZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzUL1yTJ2BGEo0oDmBYrssuhT++NyVUXwkX8Z791XPtoMlG+ZAh
	bRYqoMApFM6uXSjz66Oc+pedmNA6o2zAErH2dMB7ruF8XR6F4BvmRiCsT/poQ26bJ6yh3qFu4j+
	YGEdl9WoLNNaF2ueqgDTjyWj8dKUp4fNSPsgMrdjWvi/wQiO2mMtJkTWVuVc=
X-Gm-Gg: ASbGncszl8fLWzH/6ksi5Uw/rgG9IrY5jApTsfNdN0Ji0BWMKm1OdDBMRGtuuzJFPyt
	pf4m6gX7jtqHz0YuMzv8z+s8s7VhRVIPUAQx4t6TAILaY3jM4hZ6DWUHKZaJ9ebXkXMKPhESnwb
	ocHHCdYrvK4hlWhOy4WwbNcmqW5AJ/KPOzHZXaFFKa1m5B1IHh+iT56p0=
X-Google-Smtp-Source: AGHT+IEnZ8imIW9ADcA+qizsXQQoSv/oB/fkmol7lE7kCqeFiMI3tg/eYqcCBTWzUietI1f8YfK/UM+rn525PVoGRIA=
X-Received: by 2002:a05:6e02:1aa5:b0:3dd:a7a1:9f14 with SMTP id
 e9e14a558f8ab-3de08d982b8mr9375795ab.4.1750134986695; Mon, 16 Jun 2025
 21:36:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b0b0ae91-785e-64f6-348a-ca6edd448b74@maine.edu>
 <CAP-5=fVivxz-TPVap6-+6U=ueU9W9fdZSH3w5F7e-h=uN--8kA@mail.gmail.com>
 <CAP-5=fVa14Y+0a=nrxo85uEOHfiEJRbQXt6fOV7E3dQJDf4fdQ@mail.gmail.com> <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
In-Reply-To: <2c759cfb-41b2-6f50-e893-1545a965d106@maine.edu>
From: Ian Rogers <irogers@google.com>
Date: Mon, 16 Jun 2025 21:36:15 -0700
X-Gm-Features: AX0GCFtcHc6tsVg38oq18iBbH2UQp04rpc-tc3PgxL4lz7W_gUDosOE7QbvVTiM
Message-ID: <CAP-5=fXHgzhp6=xrVi1GK6gO_dtVAAStK__eKKoaAvvge4oNow@mail.gmail.com>
Subject: Re: perf_event: avoiding gpf on rdpmc for top-down-events on hybrid
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: "Liang, Kan" <kan.liang@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 16, 2025 at 12:34=E2=80=AFPM Vince Weaver <vincent.weaver@maine=
.edu> wrote:
>
> On Sun, 15 Jun 2025, Ian Rogers wrote:
>
> > So I spoke to Kan and posted a revised perf test that works on hybrid:
> > https://lore.kernel.org/lkml/20250614004528.1652860-1-irogers@google.co=
m/
> > Basically on hybrid before doing the rdpmc instruction the test now
> > ensures the affinity matches that of the CPUs the perf event can be
> > scheduled upon.
>
> for PAPI we ended up using restartable sequences which more or less work
> for our case (though we had to get some fixes merged with the upstream
> rseq developers)
>
> I don't always track the libperf code as its license makes it
> incompatible with PAPI (which is BSD licensed).  Does it handle the
> rdpmc case where by default on x86 you're supposed to sign-extend from 48
> bits (or whatever is in the mmap page) but some of the top-down event
> rdpmc registers use all 64-bits so the sign-extension corrupts the value?

Yep:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/lib/perf/mmap.c?h=3Dperf-tools-next#n514
The same code is in UAPI perf_event.h which has the Linux-syscall-note:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/include/uapi/linux/perf_event.h?h=3Dperf-tools-next#n651

Fwiw, I don't think restartable sequences would solve the problem of:
 - 2 events programmed 1 gets the fixed counter and 1 on a generic,
 - the thread gets ready to do rdpmc for the generic counter,
 - another CPU/thread requests deleting the fixed counter event,
 - the event is deleted and the generic event is now scheduled onto
the fixed counter,
 - the rdpmc executes but the "index" is still set for the generic
counter but the kernel scheduled the counter onto the fixed counter
which I believe would have a different index.

but to be honest I don't understand how the mmap page works for say
only opening the event on a subset of the PMU's CPUs. Or if the
"index" is loaded and then thread preempted onto a different CPU with
events scheduled differently (as with the delete case above).

Thanks,
Ian

> Vince Weaver
> vincent.weaver@maine.edu
