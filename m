Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719401F4CB3
	for <linux-perf-users@vger.kernel.org>; Wed, 26 Nov 2025 01:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764121424; cv=none; b=odPyPy1CG8YA/6wHs3BcH8aZk+XDm6kb6z4c2zD5yEZHX+okrXzS7OQr7cKWSvgfE9Agc2JmUZX7B9i7zik/7xBYXxLBvnKxVF0VwBX0hwiQZib/ovoBBEMJK4zoLZS/AhdWFXI6pa/fLVA5TpG556RYvt//V1vA2cIF87TtybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764121424; c=relaxed/simple;
	bh=RgoG2QjVtV/MBQQ6BuPKbeOOJv8TrZoYsrOBz12BCRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRDtV+lVzQZ9JIoH1CKcxnRJUtnpQ8ZOZZBeLxZuzi3+z2PjPLPn0AqAFQWFLQEofa+iJAzfhpY54DCx7r6sNoIcNog7ipDwqqg/klsOTrqkDzzANweNnqVuif3WK9DJjoVAxhlPjp6MNuZsY3RS0pj0IkGa7CzaxhrXOex0MWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7DfA8yg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7DfA8yg"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2980343d9d1so61065ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Nov 2025 17:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764121423; x=1764726223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nh1d/9yMuCiM8Nz6j/NlZlDry+0zo07qKygWs7xAcxk=;
        b=q7DfA8ygRBcbT/561xL7H/wRcKGgnJljSd54jY9JZ0YEumQqcjla2MyJqqkG0MdsZp
         hdKCyyzdXJjE02uX14hGAdq72YucrFLYhOcSnIb/bCYMqYdO6XdwZ0QPMZ+ovKilakgw
         OAv0H9cV6F+GWkTdN9t1gFExp+cEzK3NJbUBL2Ts4i6DJaELjwxmF+zbTvsZEzTnX4OC
         XJI/N3tPmt2MGLXjC+aSAOctpNeEhzO/fwnJhLqJpGgwb0m51j6gXTGGkfvITAMhVKNe
         tK+4pISR10ixU6rY8jH5aNSCpTkVFLxBgI+NUcRmvL2ywdjGzY2WTHE8lAbs6Dm58my4
         YfZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764121423; x=1764726223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nh1d/9yMuCiM8Nz6j/NlZlDry+0zo07qKygWs7xAcxk=;
        b=qD0Zez4Iius6sFHjc2PjmNLC13M8dtbeSmFE0vRaWD0BLrCSwQcwT/1mJUmuyZtYjz
         20M14W6wF8gYv10oorx2cXmr6i0OwqjBTgw26SKS5TTEV/ZpE6QhRfZoZx36imSMGKk/
         y6G5Bw7aIz0NdYot5+zzZCW3TtBH1VWzM3Fr+iGQTg0g2YT/IfUUgXvxNduHYkNqLPFE
         3ecN+GK0/YM3yDbQWm35h/P09H//PdHHlaUDGnkhNwZci7wl1iwGEoKhthuhRaVg/Mhx
         hRKm7BeH3+P1jHXXmqRZDh/eHqzLKmblUAIDwgs0MlmBD1p0TpAiWbODpxplu1oRk2LZ
         BSRg==
X-Gm-Message-State: AOJu0YxqlnBemsrfGbbcqDhG7PyMQuoKScDCMV7u1Ggv6D3zqXoePRr2
	CgArPekiEU4Qgz/BP2MdgdUnunMWVg58sIqOJ4gk08PembLSKJ9kkgi2BwJLGk562/ZHFUmh7rm
	4cPBsrzedb+R9YW11s4XOHofXZXyJENVUXMlxuO1CjTDsacUICmb5Jvsbvk4=
X-Gm-Gg: ASbGnct2O8zA/uu6wEGaCfaiZC79WsCicmstZ5J46B/eKCDeLZi/T6HJSTEe/NjMdDV
	Aj/GWYscxiwi7UQKTGTNsR0sT8P1hyql2qTXQJxIsdlO6O3kL9htWvuycnO8NvxEGhbitcgtgCE
	JvG5fnC63hA9SS9miFryy6Vtu5McJpCyAAFAIh4nS/8RQ5xYtPzSMabWYZnYm7EO9PGlH9Mi+T2
	OVl4r8RLWVu2eiWTtk+X+/t7gDOQCdmC5FNQS/1TadGOVVtMqu6Pt7qVLFa3Fx7cjfLJ6CD
X-Google-Smtp-Source: AGHT+IHjM1sfiGyOKJI+rj2txN2NAlKd/8vohnzlW0/f3geWKBHE0pTJCGMStBuFrlD686EYRlvyw6rz2KFpxoK7tyE=
X-Received: by 2002:a17:902:d4c6:b0:297:f0aa:d466 with SMTP id
 d9443c01a7336-29bb8f3ad92mr1168775ad.8.1764121422413; Tue, 25 Nov 2025
 17:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3u-5gjxsFbnimP0mMFM6GRki7TAfNe6YmY6KtJhApV45nSNw@mail.gmail.com>
In-Reply-To: <CAK3u-5gjxsFbnimP0mMFM6GRki7TAfNe6YmY6KtJhApV45nSNw@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Nov 2025 17:43:29 -0800
X-Gm-Features: AWmQ_bkH-se5F4FQgDGnKrqrYioI6WEFN7aZ6ZOqjquSKZYDvLlLlJ7vou9Ni4w
Message-ID: <CAP-5=fVndu7gOVSzH=jKtsNLQk=Asv_OZNaEQ8nPXoUKWE8izg@mail.gmail.com>
Subject: Re: [BUG] perf: libdw not working for data collected on a different
 arch than host
To: Shimin Guo <shimin.guo@skydio.com>
Cc: linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 10:39=E2=80=AFAM Shimin Guo <shimin.guo@skydio.com>=
 wrote:
>
> Hi,
>
> I see there have been patches aimed at enabling perf to unwind stacks
> collected on a different arch than the host perf itself is running on,
> for example, https://lore.kernel.org/all/20230606014559.21783-4-leo.yan@l=
inaro.org/.
>
> I believe there is still one issue that prevents me from doing
> unwinding on arm64 stacks on a x86 host. As of v6.18-rc6, I still see
> the following in tools/perf/util/unwind-libdw.c:
>
> static const Dwfl_Thread_Callbacks callbacks =3D {
>     .next_thread =3D next_thread,
>     .memory_read =3D memory_read,
>     .set_initial_registers =3D libdw__arch_set_initial_registers,
> };
>
> libdw__arch_set_initial_registers is defined for each architecture,
> and the version is chosen at compile time, not for the arch the data
> is collected on. After fixing this issue, I was able to get the call
> chains. Is my analysis correct?

Hi Shimin,

I think your analysis is correct. I've been trying to clean up other
cases of this, such as with dwarf_regs:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/log/tools/perf/util/include/dwarf-regs.h?h=3Dperf-tools-next
Or with syscalltbl:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/commit/tools/perf/util/syscalltbl.c?h=3Dperf-tools-next&id=3D1470eaa57487=
0da3f78942927b15e0b75da3ffbe

My belief is the arch directory is a code smell where we've most
likely broken cross-architecture support. Were you in the process of
putting together a patch series to fix this? My hope is to move away
from the CPUID feature strings for things like this and just use ELF
values like EM_X86_64.

Thanks,
Ian Rogers

> Best,
> Shimin
>
