Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7716923FC54
	for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 20:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768854361; cv=pass; b=Bmcm8g054OIUatG0KI5c2OnKtYjuXQVyL2LDnsWWL/DxgOQy/LagoUxZPERG4bjtRXZ/zBgq7Md/WQ0ocaYSHp0uKBHMbzt2XqLQ9AUwbQswHPSS+V9ryTSMTeWJI4IprTlkjDuRJTjK+jSNYwuqq2lLK+eQIRqA6JRrl2kY0hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768854361; c=relaxed/simple;
	bh=aWeZf3oIyxUrz6xRTZLJ3zu/FRder3H/ARAjzbiFAzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=abxqIWYaHvkpi8fyBVTb1Oq4lGKtdfwFlZfJkuprc6cqN0Cgpqv5D8UxELM1Azdqd6bpm2QMQbGx4XrHWV0swDhMQT+4hMAdfezcDAPVhFIVUkoLmXfGgwDoyrg8VIa17PDvJKu4zS6pNPvfUjfltDOyX78CaOPyRNKE3QcK6nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUyvNuov; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUyvNuov"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f02651fccso29015ad.0
        for <linux-perf-users@vger.kernel.org>; Mon, 19 Jan 2026 12:26:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768854360; cv=none;
        d=google.com; s=arc-20240605;
        b=Zj74VapsWTPJ15FY3DUwk9bZef0XAgH9K455oZDv9x9MhvtzziG0+2bxEg5jXO51OA
         7i0FvxFUAZJ+SJqJn8yODyb313exP0APB7b9LarGIlrVxXnC99uX7F5KVRQtQxuc30+Y
         06RtYCp34LzbuFzQnt8dpTKKb9hrD2Ka8eSVkw/DHhgUjMSBzmOG1YBMrDFZ6SpLaSIa
         D81btyS6Z9VGw4CVzo9cRY6rvno5iAyTfIUjTIsPrJmF5/SDDvAqmvXHcFh4YfMHY/E4
         wCyiO8bZPlqqGrY+JDkz5tIotc2U6coDRBdHHen/k7uCW9Pv9fBoWMYUUYJwkqfc6c15
         lsFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OrY1HeodPWb34pZP2cp5GI/dTdWTlUDIu0627CmByyU=;
        fh=ebLWjQ4JcLZEJTUaxKLpBNUBpY/DAhDAxxqHyv6LRxA=;
        b=DyABq9T5Qy46jiL3SJzUzpf9il9FI/32zoKJMksVpKmBNxGEwpdL08tyT3LmjqnjKD
         pHsk4KIAHx1fGr89bDWtdMn8okyDdn9qJkFZkDaLrh37zZgz0hFdXHEIy9e93kvSRmlw
         zyTkxFvUB5n1yEFFx7ZkSPjvkOmYDvVFZSFwp0BSkeN1JlxK9WzIcxUnqrUunq0MO0bJ
         dG1LOrr0q3BOBBy9VrXzr1xWxjJlbqag43cXA6+wWatX1Nhh8qeRbKyD8Se9EGPOj/CZ
         6aFw0SsfdqMCMfsM6chLYXkIxXwuL3D41K7ZT5EGTmG4e4061jeIrKX1ekKGETnT74C+
         mdfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768854360; x=1769459160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrY1HeodPWb34pZP2cp5GI/dTdWTlUDIu0627CmByyU=;
        b=bUyvNuovTFqFtp4F0csnG8rqGTtWgPiVAGY+aj/06W4K2AvxRzJ/WCgGQSObrBR9mZ
         ZFu294ZYvdP7qvDCucuwCeTYrvf0BiJDLZQc2YN/p734slQb0pGYdSlTreC+DtD9nmNE
         cEV4foLfXTRwea2RjzoOzLVUwbWnWmxiAk+z4dl4eOG5n1uESg9ycLp8bU3xrLP2UfBg
         FLxjfWv/ATomdEFsVA61kTTfoanKRLbnhAxUVYNt81h05yldRQjnl6eJhVrep0Hqc5Mg
         pU9xTkFSHCILoFTlQeTkHEFVXf6SoHzMXkSjtxDK0sgv04sntvNAJxHkif0O/opGu4l7
         ZwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768854360; x=1769459160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OrY1HeodPWb34pZP2cp5GI/dTdWTlUDIu0627CmByyU=;
        b=NE/g/c5lmQ6V5PhjBxPZQ8xfH2kLdui09BW3KaYvauETqa2S24xm+mAYPDA/EWJkzD
         LimmTAGh0dq5iABZSURRyzMf0atXcJpjeHrtiQwACyxPzbqh3+fM+x2YgVqmiZ+KQWkp
         kRbOgWfZpgKgDOBcqvGmXONuNN0PRM3b3R8qwrGzCzueuvnuILWSUC7eETNyabNKzg1I
         3+V7qwhNv0hwKxcS0ZkhlkdAbOrQHUb6wrCAXYclHHsKS8zCGeYxJTvHz+zyz6inLkHG
         a+ubhM4a8poO0024fp7Hjap1QgT060qJ3CbPAlDV+1ufdW4Upz/X+kF6M1b42YGmC5t1
         jCPg==
X-Forwarded-Encrypted: i=1; AJvYcCVIyElH6EqxANniE7ZZQe/HLTb489cCOMSbRkl4BrmwyloPuAqzzCy/B5lvMb3NLtTF7ozcxFeOCHil3+KN6xzb@vger.kernel.org
X-Gm-Message-State: AOJu0YxKF8Wd5HRzJ+DlYGwueTm0m4kOxCppnkp106zWC8ZRjrzCC2Gg
	zPGGJky+Fzrv3bh9EnNVTAaqMHXhRcACpLewh73zwlUmgVp5hbd1yOYWM1IOFLpVsfErujvCyBw
	US0IA348jbwn7eNib/SipFsqEITDWSROujNF/ymWm
X-Gm-Gg: AZuq6aIUDwOZvEPObi71nw1c/nh21RB2Sq0Zss6atg8MwEgIdIpg53RD9XLmW5UR8YS
	YRZhphVnOnNHhr8DoAzWzyET6N02y34Pta3ScYy823eTVz78dr2yVgQYtHlf5YY1R4AikipzB/2
	bTrfAemdI2DyU6rCaHIo2pLeuC57xMfzk8MYoXUHkCnUAoV05UOJX16D3ijnAYWaF49ooXDQQpT
	Lj5XQxxvOfbc4ATWhPmkkQPs2A+sSM5ccwfpu770/gWPQiY4yQNSRxVZ4PzSWRb3X3DI1aG
X-Received: by 2002:a17:903:2b0b:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-2a7286208c1mr5262625ad.4.1768854359307; Mon, 19 Jan 2026
 12:25:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251203065500.2597594-1-dapeng1.mi@linux.intel.com>
 <20251203065500.2597594-19-dapeng1.mi@linux.intel.com> <CAP-5=fVk7+iGn+jhfE3a9iY_G1Gdph9Sh0RNco+745XQMfubLg@mail.gmail.com>
 <9d97e2f4-3971-4486-8689-ab50b06c3810@linux.intel.com> <CAP-5=fU+JeBqCNfKVR9O2cd0zzPO1bsYORtEBzeTeTpMLg4m5Q@mail.gmail.com>
 <0a99aaac-d51c-4c65-addd-5e366408a3f0@linux.intel.com> <CAP-5=fV_dbFzQ8_xHsduFytEq+6H0M0iPof0Krb0dBB+Bsd42g@mail.gmail.com>
 <3d95b037-e1c1-40db-b357-889c62c70221@linux.intel.com> <CAP-5=fW5g-_Owf2wWtXZwpbtTy9uns_pqr=BFumohHxWGU+i0Q@mail.gmail.com>
 <47014c3e-0fca-4248-9f23-09007f9ee95f@linux.intel.com> <CAP-5=fVbWp5bdnxrcA4XQPvFa2iYB3583C4DzOP7wA=oPqvcKQ@mail.gmail.com>
 <8b932ae4-5f65-454e-ae9e-0d9377a92254@linux.intel.com> <54c173b0-55f1-42d2-a43d-d6389d3fbfe3@linux.intel.com>
 <CAP-5=fV0iPapwbKX-rjbF86_WcZPji8opKNgO=r_kDSJB7T8XA@mail.gmail.com> <9f73d1f1-80f5-45ed-946f-6a920ba34980@linux.intel.com>
In-Reply-To: <9f73d1f1-80f5-45ed-946f-6a920ba34980@linux.intel.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 19 Jan 2026 12:25:48 -0800
X-Gm-Features: AZwV_QgIYL5QrwGwgWg5FjKoLZfgoewe771-bIXfA2V4LrbyIhCphyZaPymJWyc
Message-ID: <CAP-5=fUNeJpj-rdi+552-o9xhCiT41q-Q8Zhg8U7ev0Wbiyhog@mail.gmail.com>
Subject: Re: [Patch v5 18/19] perf parse-regs: Support new SIMD sampling format
To: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Andi Kleen <ak@linux.intel.com>, 
	Eranian Stephane <eranian@google.com>, Mark Rutland <mark.rutland@arm.com>, broonie@kernel.org, 
	Ravi Bangoria <ravi.bangoria@amd.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Zide Chen <zide.chen@intel.com>, 
	Falcon Thomas <thomas.falcon@intel.com>, Dapeng Mi <dapeng1.mi@intel.com>, 
	Xudong Hao <xudong.hao@intel.com>, Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 18, 2026 at 10:55=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.intel=
.com> wrote:
>
>
> On 1/17/2026 1:50 PM, Ian Rogers wrote:
> > On Mon, Jan 5, 2026 at 11:27=E2=80=AFPM Mi, Dapeng <dapeng1.mi@linux.in=
tel.com> wrote:
> >> Ian,
> >>
> >> I looked at these perf regs __weak helpers again, like
> >> arch__intr_reg_mask()/arch__user_reg_mask(). It could be really hard t=
o
> >> eliminate these __weak helpers and convert them into a generic functio=
n
> >> like perf_reg_name(). All these __weak helpers are arch-dependent and
> >> usually need to call perf_event_open sysctrl to get the required regis=
ters
> >> mask. So even we convert them into a generic function, we still have n=
o way
> >> to get the registers mask of a different arch, like get x86 registers =
mask
> >> on arm machine. Another reason is that these __weak helpers may contai=
n
> >> some arch-specific instructions. If we want to convert them into a gen=
eral
> >> perf function like perf_reg_name(). It may cause building error since =
these
> >> arch-specific instructions may not exist on the building machine.
> > Hi Dapeng,
> >
> > There was already a patch to better support cross architecture
> > libdw-unwind-ing and I've just sent out a series to clean this up so
> > that this is achieved by having mapping functions between perf and
> > dwarf register names. The functions use the e_machine of the binary to
> > determine how to map, etc. The series is here:
> > https://lore.kernel.org/lkml/20260117052849.2205545-1-irogers@google.co=
m/
> > and I think it can be the foundation for avoiding the weak functions.
>
> Hi Ian,
>
> Thanks for the reference patch. But they are different. The reference
> patches mainly parse the regs from perf.data and the __weak functions can
> be eliminated in the parsing phase since the registers bitmap is fixed fo=
r
> a fixed arch. While these __weak functions
> arch__intr_reg_mask()/arch__user_reg_mask() are used to obtain the suppor=
t
> sampling registers on a specific platform.
>
> We know different platforms even for same arch may support different
> registers, e.g., some x86 platforms may only support XMM registers, but
> some others may support XMM/YMM/ZMM registers, then all these arch-specif=
ic
> arch__intr_reg_mask()/arch__user_reg_mask() functions have to depend on t=
he
> perf_event_open() syscall to retrieve the supported registers mask from k=
ernel.
>
> Thus, it becomes impossible to retrieve the supported registers mask for =
a
> x86 specific platform from running on a arm platform.
>
> Even we don't consider this limitation and forcibly convert the
> __weak arch__intr_reg_mask() function to some kind of below function, jus=
t
> like currently what perf_reg_name() does.
>
> uint64_t perf_intr_reg_mask(const char *arch)
> {
>     uint64_t mask =3D 0;
>
>     if (!strcmp(arch, "csky"))
>         mask =3D perf_intr_reg_mask_csky(id);
>     else if (!strcmp(arch, "loongarch"))
>         mask =3D perf_intr_reg_mask_loongarch(id);
>     else if (!strcmp(arch, "mips"))
>         mask =3D perf_intr_reg_mask_mips(id);
>     else if (!strcmp(arch, "powerpc"))
>         mask =3D perf_intr_reg_mask_powerpc(id);
>     else if (!strcmp(arch, "riscv"))
>         mask =3D perf_intr_reg_mask_riscv(id);
>     else if (!strcmp(arch, "s390"))
>         mask =3D perf_intr_reg_mask_s390(id);
>     else if (!strcmp(arch, "x86"))
>         mask =3D perf_intr_reg_mask_x86(id);
>     else if (!strcmp(arch, "arm"))
>         mask =3D perf_intr_reg_mask_arm(id);
>     else if (!strcmp(arch, "arm64"))
>         mask =3D perf_intr_reg_mask_arm64(id);
>
>     return mask;
> }
>
> But currently there are some arch-dependent instructions in these
> arch-specific instructions, like the below code in powerpc specific
> arch__intr_reg_mask().
>
>     version =3D (((mfspr(SPRN_PVR)) >>  16) & 0xFFFF);
>
> mfspr is a powerpc specific instruction, building this converted
> perf_intr_reg_mask on non-powerpc platform would lead to building error.

Hi Dapeng,

So my main point is the arch directory and ifdefs, how do they differ
from writing code that uses the ELF machine? For example, your code
uses the arch/x86 directory and has ifdefs on
HAVE_ARCH_X86_64_SUPPORT. How is that different from:
```
switch(e_machine) {
case EM_X86_64:
...
case EM_I386:
...
default:
return 0;
}
```
If we need to determine for the current running machine then e_machine
can equal EM_HOST that is set up for this purpose.

I agree that determining features needs calls that may not be
supported on other architectures. That should yield EOPNOTSUPP and we
can use information like that to populate generic information like the
PMU missing features:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/pmu.h?h=3Dperf-tools-next#n190
we also probe API support with:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/perf_api_probe.h?h=3Dperf-tools-next

The current code doing lots of string comparisons is unnecessary
overhead and imprecise (x86 is used for both 32-bit and 64-bit x86).
It is removed in the series I linked to, I think we can eventually get
rid of the whole arch string for similar reasons of trying to minimize
the use of the arch directory. I'm curious what happens with APX, will
the e_machine change? We may need to pass in the sample regs_dump's
abi field for cases like this.

My point on the unwinding is that the sample register mask appears to
be set up the same regardless, whereas for stack samples
(--call-graph=3Ddwarf) maybe just sample IP and SP suffices. So perhaps
there should be additional registers to set up the sample mask.

By avoiding the arch functions we can avoid the problem of broken
cross architecture support, we can also lay the groundwork for support
on different architectures that may want to do similar things. I agree
that doesn't matter until >1 architecture is trying to have more
register masks, my concern is trying to keep the code generic and
trying to make sure cross architecture is working. New weak functions
is going in the opposite direction to that.

Thanks,
Ian

> -Dapeng Mi
>
> >
> > I also noticed that I think we're sampling the XMM registers for dwarf
> > unwinding, but it seems unlikely the XMM registers will hold stack
> > frame information - so this is probably an x86 inefficiency.
> >
> > Thanks,
> > Ian
> >
