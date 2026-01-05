Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEA4C92
	for <linux-perf-users@vger.kernel.org>; Mon,  5 Jan 2026 21:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767649578; cv=none; b=diMBl7iPZCDOkXNHH/DH5AWNX+goNifGBIRypyRF+3ammB0YhlCuCiCPPieh7GanN8x9/IOhK7ugJEKw4W9PCMqbOMhsLbJBqH351dER1Ygl2OLqbAFT8omAWl8zrD68YOK4aNEwHvs8LOZUjVOxtixPiViS3Hd/AgRaUM31t0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767649578; c=relaxed/simple;
	bh=P0KR2gPhm3LpwXEm1qnsW590Ungl6jLb8HdIjDmEz/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jkXXWQZj054XHt6IQ0gsHLVeij5r9K3tB2RFSHA+fjAsilxAGSNGn1sTQf8ti4BxsUNnx5fH0fN1JRyIsDWcc8kDfFMEGjS+J6/t/d7ljJhKA3GrtnR7gu6uxt06DznWUDsCTmwuU6iPobSqzINIbnW82sqQRnvD9QU2aWUpQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC9txbae; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC9txbae"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b804646c718so60675466b.2
        for <linux-perf-users@vger.kernel.org>; Mon, 05 Jan 2026 13:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767649575; x=1768254375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AQgacz8x6LTCWKBQSLIrsMe5Rnqw2MnbZkxJhjnGKo=;
        b=hC9txbaed9Hc1R9TxuAV7Z7rHAs3kolGQD7lXIZZ9e/45YjHaamAX+uB6li3I4ekbb
         9nKaK3ByX1bwNX1rPbCvx2L2gMA6KYsG/CCRmJ7fjGP5I4ruqoKniRYPh4586SacQ8Ey
         UVhmSuqd5kkg7BsDQ/DGh1KAFcOaf/nq624VzWBahyw0SgSHj8U1PImraJxREgH0X7pO
         DOzXOqO9k/RrkV5hQLX5aToqihi/0VSeDmk28BAoJ+DNsk3XhzwFTr7prSx2E5gziez3
         PZvgjwz/MZxZ4Stze2qfA8PXB/IxmZc2DUtm4x1qQY77RSKfW790i30zTS485BT3cZLC
         b7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767649575; x=1768254375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2AQgacz8x6LTCWKBQSLIrsMe5Rnqw2MnbZkxJhjnGKo=;
        b=S5J25H5WoD/tTER9DH6EWGptrKwox5gtejM40aUZPAIUIgezhQ3AP76gGdrWusTui4
         rACcFU6HepXwKDHgARkkF+DKLSDQIHxF5okiseJY3+YEjB6jFS/gPpS+k43o5Eg3kXm8
         WC+BLFlu7bvJhxNGlgjx2XRwgT2SxI4xA7c/+Avt7XTzsfglCGAvVmmSSzm3qncLRgk3
         rr7I1mqtBRlb/l8LFDVFecZonPEKn+ORxUYFISQf3ZRz3DXcDcNdS8EVP/+Ifoe6EqiA
         MV368JmxH3oh0uztOJRDyqvW8U7SA0w6mJz95hFBzzB48HlbUrPEPAQf3pYaGyY0bfOu
         2KsA==
X-Forwarded-Encrypted: i=1; AJvYcCXDediOO/Ag3gcmBU4tzuig9WBCbpIZIJOGondxsYLD9Kmp2nSaaNR7AgWimjlhGJh9ugLmT9M9MA7ggQpmIfQ4@vger.kernel.org
X-Gm-Message-State: AOJu0YwxPiS6/QXHuBjvvptd7NVNAleBDtiWBscC0gKbrx8m8YX0OqH5
	KPpS2VPVuC/Qw9RbrWvc5veyUks3YnJst/axrjiR0c/Nnx3o1UgdmBQ3bE0M+udXUmB99LHiUbE
	CKmAgVcN0UE9znwFVFTGkwf01dXFdZb0=
X-Gm-Gg: AY/fxX7QiIevlWlh4wexUgOfnbR32P6vhRes+5cHNXQe4ZQrPSF1i5gKxyYfu4VVij7
	hmsrwVXGE9MgQnQMstvITzY56t1Q9KcMuM2DJy5sULYqeoFRvFfIYyAEBF74ct0HOh1gUxxHy4G
	MQSWmqyUum66BC86IpXQvt4uuam2rvTHQFizZ0wpjM/5F2E9azJJ1at/OIwjHY6uyHFXchdNDxg
	WrGo3oFOp8XcIOc2P4IXICjIWphOy5TRMeL04PFc+s2O9Yh72NkDQQXiPFOk3uM+xk/wExXZTEN
	TSHsLB2SZqo=
X-Google-Smtp-Source: AGHT+IF1rsCaTWKuHuU/DdNT/WlhCRwDnxcpN2RA6MA+qVhMgphIIIFwK8xfuiaraadBaRIRPf+t5spMfoiLc7jhNv8=
X-Received: by 2002:a17:907:7294:b0:b7a:1bdb:30d9 with SMTP id
 a640c23a62f3a-b8426c263a3mr99860166b.65.1767649574761; Mon, 05 Jan 2026
 13:46:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102214043.1410242-1-puranjay@kernel.org> <CANk7y0j7hAJ7OcH_HgN0cVGnUh=iBz=iuD9sYZmSy-koMjB_cg@mail.gmail.com>
 <20260105212213.GA336318@e132581.arm.com>
In-Reply-To: <20260105212213.GA336318@e132581.arm.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 5 Jan 2026 21:46:01 +0000
X-Gm-Features: AQt7F2r2qkyYhWt9Ro6mLpJTWDlG9bogUxKNqnFN-4AlLZBj7oPXj2gxwhDnz3M
Message-ID: <CANk7y0gb8TM7obqWgaNY3aK_TZLX_nivYEATv2GndN5Ghz1hcQ@mail.gmail.com>
Subject: Re: [RFC PATCH] perf/arm64: Add BRBE support for bpf_get_branch_snapshot()
To: Leo Yan <leo.yan@arm.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Rob Herring <robh+dt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Breno Leitao <leitao@debian.org>, 
	linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 5, 2026 at 9:22=E2=80=AFPM Leo Yan <leo.yan@arm.com> wrote:
>
> Hi,
>
> On Fri, Jan 02, 2026 at 09:51:15PM +0000, Puranjay Mohan wrote:
> > Hi Catalin, Will, Mark, and Rob.
> >
> > I don't have access to BRBE enabled hardware and Qemu doesn't support
> > this as well therefore I just sent the compile tested version.
> >
> > Can you help me with testing this:
> >
> > The relevant bpf self test is:
> >
> > ./test_progs -t get_branch_snapshot
> > #132     get_branch_snapshot:SKIP
> > Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
> >
> > skipped for my setup as it is not supported.
>
> eBPF selftest build is quite heavy (many dependencies), finally I built
> it cleanly.
>
> I did a test on FVP RevC, the test hit NULL pointer deference and kernel
> panic in armv8pmu_sched_task().  See https://termbin.com/peg4, the
> backtrace should can give you hints for the issue.
>
> Thanks,
> Leo
>
> P.s. some logs are duplicate, this might be caused by two cores both hit
> the NULL pointer issue ?

Thanks for running the test, it will help me debug it better. But as
Mark pointer out this has fundamental problems which I will try to fix
first.

P.S. - The test on FVP RevC, does this need special hardware or this
is an emulation platform, in the later case, can I do the test myself
somehow?

Thanks,
Puranjay
