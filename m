Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234FB846A
	for <linux-perf-users@vger.kernel.org>; Thu, 15 Oct 2026 00:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792022716; cv=pass; b=YjnqWk3wX39dVPBwi8eHg1uFb8aphsj0gf2JplTER8Rk5JQfMJhNw/yw1cqm3YM0NuLeI+hDkQgIxxvhQaa5pL+GX1q5cfnPSaqQ3Lwn1TB1et5G0eYUMYpx2BWoNH8ApGq/vEcO1YIG7wWULchEXuTGwd2zBgcKbuS+vYtMXVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792022716; c=relaxed/simple;
	bh=IsumSsX68ned4I+XN6qD7vJuuH/AEcDulEb+H0uATVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zj3tTxoKt228+VZc27tdOmDSbEgXHfegmORH8Z9IWPy2cwWwIKTTR+BKbm+kLQuikaIT9NlDFQSfZ2ILZcj8Mqr2QOzX8YdVhsFOPNYREjWubJXWiRMeHUX0vwXceIYOHM2JQ72gqtU3iq2lRB9jmBhvdcUeyUITN2+ip6phOjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mWySo1kZ; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWySo1kZ"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-5339381b46eso47421281cf.1
        for <linux-perf-users@vger.kernel.org>; Wed, 14 Oct 2026 17:05:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792022714; cv=none;
        d=google.com; s=arc-20260327;
        b=Os+BWCBlV24Q+J05GqjgAHpJOu+T8uQ8CGcBmAGdrqO4Ulg1mh6a9mLp7shOJMegIV
         lP9Ja4Y7/1Q/8lk0PhjTp7txWAOp/HbjqskTm6HuAq6+yfij79NgpJ6APB1jVPNoTufM
         EtwWyve8rK1KZR5y2YKeUqfjVyIrV7SoE51H98P9bMZX7/9Ly047j7naD4sQkaXlwW2A
         TRX8eYJcJm9MHOMyQGTCHXc0VoXz7k3ssWOxN/ELXz7ifVim1+cynYfA1EXML4If2Ge+
         OI7NVuG2xLoRTVcpIsWby5ubM1LgokE9Nm1UDknKM4pIBqiJME/Qqiz/yINU56kA7/QH
         5yZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W2i4ePvZhKbDvNIgqM9w1XHeVFGw/Fx59ZBhSBmCD14=;
        fh=U8ZNhETrVsCu68yknX+Jy1ehkpw9LH5OUPXNjJcb4sM=;
        b=fIQiqeexweZti2/sbdbq32D7AksEGk4RoLRNXWsQNkDDeJGGrvWKf30FwqASEWIjVR
         b3ygJeJ7fikvQvtvCx4qzBReb+0cdNX7a30WD9X1zv7jwJhdRomCIZ8enTlTIyLx59aL
         3HRNf9WUOzecMzQH5nAEbN7xgaW66VBs0xIyynrvN0PZ/EbeRPYFSbQUEE8b40C3o0Eb
         XGC+H72qbLpnpr5q7NTATHVI5Ctbuzmq1bbviZeaPw4Fk26iHu8w2lWuKru7GH8o2PUp
         YzzF3rkoypEwWm+ST7ZHgkRKqyOmFIKlRTsYeO3rZ1ZESGVXBXD4ou0MaGudDloYjkM0
         hk2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792022714; x=1792627514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W2i4ePvZhKbDvNIgqM9w1XHeVFGw/Fx59ZBhSBmCD14=;
        b=mWySo1kZJjySESsIerkLouhQvMgeJlOcPLo4kmSTKcmhIlrwBBb/X/pUk1RWYmoGDp
         bBf7WNBQXaDoEJLif/8btOjKVV8ICJb2TNJWKbKMFtdDNen0tkqiOPzSDKtjj6gI1nb1
         MNcjDwUz9+QcU2/51hHUCSBsm025kFiD9+PVy6Qsv4oLaBCUZxW26ytHKIdREF620N8J
         mfk4IBA8SdW9IniQLj3/IswEQlyLb+JLIDDr9kHZPeVnv6tAR5LGbvZbKhD63OZmq0DZ
         y6p8Uumxz94nOBS7nCBSPS6jgZg14nTlH9+PxqqbJgQUrYuaeXOUdw3k2v8ubb5opXj1
         BIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792022714; x=1792627514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W2i4ePvZhKbDvNIgqM9w1XHeVFGw/Fx59ZBhSBmCD14=;
        b=K45fV3uMH0FkR46C/lOPVD08KoTpLIsYGHWkhsguCxg7qqEFI5ZZOriCK3jEHGqRZ6
         3BSKWpq9xIrP2GDSBeMBcrba8otL8WkKeI37zG3FYfIFVN8g+qjDXuxLsFLJIdRLICYQ
         ANX0w4WxPrUZYEWIFx+PkfbCh3KSZyyfOMFWywFYZ/fziS59/1Q5vtTo1/UkaOS3bv4W
         4cGPcuX6ZU0Av53Se2wTcAIOXthoLIMJtE/SqiJugHqqVovbXec0zWA+oA/BjFyBpyX0
         VG6rCRXBy1eZZZGJhrjXp9APjfAfIJG3UQaAN2Yb0txSwTjRZl9HG052P+i2ZgzMczEX
         SHmg==
X-Forwarded-Encrypted: i=1; AKwUvBxSW2NgSDtjrHAonlSH1ey/Bv+H/zSekQNe+T5lwlIVz0p6TOkIogxwQF/VdbZoNbMySNd3KXxH93vm1ayUGfzQ@vger.kernel.org
X-Gm-Message-State: AFq9FYL/BW6LNrWj9w/Lf5f34UCOsH0zdZ92VWSvwGQaJ5+RMG50yn53
	kMQpPjOPa3HqlBJNEU8k+cIuFWtBd7xW5xM6ghKVFE4oh90KaamVyNxOFpcc76V70mFJXgRg0Tj
	IBka//7XhH0rQxuOC7+Lhz0Zgft4vRrQ=
X-Gm-Gg: AYBFou3p0K2dYpxKCCzDWTeu31i8k+gk1PsY1zeYGSIhX3EONpFLxS7sXCfk+vcgRr+
	bILivSHMaOaq4IvP4NN+ECm6/BjhcyDY8dPoa7tVI6/AcwZmPLdApVO2LmBk4zvHNo6ojwmdFHk
	24V2x22xPsUCE/SURNjs2hRs6+7sD37M9qfYkozClUYttMESrBgG0CH+XDLM/m/d1qT+f5a0M7N
	GvCSErL3HK9HUf+uq4w5S+YU92o8BKv+6a54lcyeuXDxFk9L1eRkJmvKc8SRgP4vI3xJytkJDTd
	HLhtdUfXANCDsqNcHjGYgoqv+FGj0+MdhM4bDSb9xuZ1aUbjgZd+C4hceFOd1l/6Bo40aqs=
X-Received: by 2002:a05:622a:1a81:b0:535:a5fb:6454 with SMTP id
 d75a77b69052e-535a5fb6988mr279210731cf.63.1792022713852; Wed, 14 Oct 2026
 17:05:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014151326.4142140-1-thepacketgeek@gmail.com> <CAP-5=fXtuEX9zJ0U-a62REgfAXG2z05XCi1f6HB4hhUEfT969w@mail.gmail.com>
In-Reply-To: <CAP-5=fXtuEX9zJ0U-a62REgfAXG2z05XCi1f6HB4hhUEfT969w@mail.gmail.com>
From: Matthew Wood <thepacketgeek@gmail.com>
Date: Wed, 14 Oct 2026 17:05:00 -0700
X-Gm-Features: AclHuK9tPEGCU4rCb0cbubedkPvYOaYtyB9MSzjYpq1TtLkAodyqOy6iHOW3PAQ
Message-ID: <CADvopvbhQL3VAza4jybWq90fOm4n3QjGm_=MXruzxxXZPODgAA@mail.gmail.com>
Subject: Re: [PATCH v1] perf machine: Don't unwind the arm64 leaf frame caller
 without symbols
To: Ian Rogers <irogers@google.com>
Cc: James Clark <james.clark@linaro.org>, Leo Yan <leo.yan@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Breno Leitao <leitao@debian.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 2:03=E2=80=AFPM Ian Rogers <irogers@google.com> wro=
te:
>
> Hi Matthew, I'm not sure if this is a serious patch or a bug report
> about the slowness of DSO marking. Broadly DSO marking is known to be
> slow and many perf tests run with -B and -N for this reason. I believe
> the intent behind DSO marking as a default is to ensure that perf
> provides the best profiling experience. This comes at a cost, but this
> fix looks like it will break things because IPs will be lost.
>

Hi Ian,

Thanks for looking. It is definitely meant as an attempted fix. On a
128-CPU arm64 host, 'perf record -a -e cycles:u --call-graph fp -- sleep 2'
never finishes writing perf.data, and I'm trying to save some unnecessary w=
ork
to solve that. perf sits in __cxa_demangle() on one C++ symbol, with heap
growing by over 1GB every 5 seconds.

You're right about the lost IPs, thanks for mentioning. v1 drops the leaf
frame caller for symbols=3Dfalse so a DSO that is only reached through that
frame wouldn't be marked.

> Trying to look a little more at the ARM64 performance problem, I see
> that we're trying to unwind 2 frames:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/arm64-frame-pointer-unwind-support.c?h=3Dperf-tool=
s-next#n70
> but often just 1 is read. For libunwind the 1 frame case has a special ca=
se:
> https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.=
git/tree/tools/perf/util/unwind-libunwind.c?h=3Dperf-tools-next#n671
> I wonder if we could replicate the 1 frame case with libdw to avoid
> processing the DSO, and update the caller to be:
> ```
> ret =3D unwind__get_entries(add_entry, &entries, thread, sample,
> callchain_param.order =3D=3D ORDER_CALLER ? 1 : 2, true);
> ```

I looked at this but I don't think it would avoid the hang, unless I'm
misreading the code:

- The cost is in loading symbols, not in the DWARF unwind itself.
  libunwind's 1 frame case still goes through entry(), which calls
  thread__find_symbol(). libdw's __report_module() does the same for
  every frame. Either way, the DSO's symbol table gets loaded and every
  name in it demangled.

- callchain_param.order defaults to ORDER_CALLEE so process_buildids()
  would still ask for 2 frames.

- The 1 frame case returns only the sample PC. That's the IP we already
  have, not its caller, and get_leaf_frame_caller_aarch64() needs
  entries.length =3D=3D 2. So in caller order I think it would stop
  recovering the leaf frame caller altogether.

I'm working on and testing a v2 that instead keeps the unwind and frames
as they are, but passes a symbols flag down to unwind__get_entries().
When it's false, libdw and libunwind look up only the map of each frame.
The leaf frame code only uses the addresses, so it never asks for symbols,
and thread__resolve_callchain_unwind() passes its symbols argument through.
That also removes the "Not resolving symbols with an unwinder isn't
currently supported" limitation for 'perf inject' with DWARF
callchains.

On the arm64 host, the 'perf record -a' command above now finishes. To
check that no IPs are lost, I used a small program where one DSO can
only be reached through the leaf frame caller:

  app -> libmid.so:mid() -> libleaf.so:leaf_spin()

leaf_spin() has no frame record, so the kernel's frame pointer chain
goes straight from leaf_spin() to main(). No samples land in mid()
itself, so libmid.so is only marked hit if the leaf frame caller is
kept. Running 'perf record --call-graph fp' without -N and checking
which DSOs end up in the build-id cache:

  unpatched: libmid.so cached
  v1:        libmid.so missing
  v2:        libmid.so cached

'perf script' output is identical between the unpatched perf and v2,
with mid() recovered in the same 2053 samples.

On x86 with libdw, 'perf inject -b' on a --call-graph dwarf profile goes
from 0.24s and 58.5MB max RSS to 0.04s and 15.5MB, with the same
build-ids injected. 'perf report' output and the dwarf unwind test are
unchanged.

I'll send v2 shortly.

Thanks,
Matthew
