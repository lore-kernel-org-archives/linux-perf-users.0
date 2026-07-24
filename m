Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF0943800F
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936099; cv=none; b=dBwgxKjUtgwyNu6G969n9mWcTebqNbwmNoS2USWEuxh7PwGuDLWrOe/RkhHFbnRbc4BdDsPLw1Aa0+DbLnQvMMpY/WaL8EuCHJ1jRwzZyd2AcFvnNARfHdPKzKKRKgQudse0NKqbtbbeQNCXx0tJN33gYjPYPqgZ5wxBbP+4NbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936099; c=relaxed/simple;
	bh=CHOFKpN4PQ499iQVlSuJFWWe52WI91gJWBi9MYe+/Qc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GWTe/9fUjIgDz6zILR3S2BPdVg+1I11SR0dFv6q8GnMlrCz9qnhsgt+CUGqb++SSNnexPjTfDtKhhmLId4l+ayPg1Q+3Gh97a4/tHynyw43DMC9zSWPrUPhw5U00iDYDmGqKvk4ahGaWJytaqpD5A7kmhg4isHXkdWhrsp79FVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFeV7mjH; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFeV7mjH"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so257753f8f.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 16:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784936095; x=1785540895; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hD1qzOwblf2DhkJIDvNTeZ3M9SYqPvy616a9XPVmkaE=;
        b=nFeV7mjHd+7Rhv1n/OAnbesDXZ58fd3U7HbjeD4WYEWL2D1ILbh+TJcBmovaR0ezLg
         lmUnflxzhV0lo+A/bIPImTr6s+vRN54noWwqVfYZuJKe3EOYd4GUoQP0Ji3Wiu/1q3P6
         d6szG7txDspdZRXKgDyWyZJ8RgtXehB+IstJ0RVkpf6cJYbohebDuohaRYnn4d8wD32Y
         6tKNqyzKN4dDBC5pcyt2ojKxLGDvW8m0bU3TO3yflG8fQfIJ6+aU29VsLVJwbnKHtkfY
         o6p+KpwRJjHh/8r8sFfcmKCBB8ntTeVfFYr0dPAx0WGZYghbgk2wtoxUJeI0qS0J9ElB
         hKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784936095; x=1785540895;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hD1qzOwblf2DhkJIDvNTeZ3M9SYqPvy616a9XPVmkaE=;
        b=Ap10/7/0YhasUlbSkgJZzTSONjI8eTQF3P7Gu8NJFKJpJY9MSI0eDegoNf1AHaMzEg
         Dg0WruvycL7fxtAUEQryamLXLfdUHLpsCiguElHUXvQ1UU5zXktE4figAetRNpNsYjEa
         ha+KwC1UNHW77+MqLZCKe0O4IDBezLl8kXORF7sfeXLNs2QekySiSfHI3HoUC550iVAg
         m3qcKtzfe7A5g6sHYML6A9WXwXg1KggF5UzXdrVlLVfTb7xew/jOK9qUjcl8vTTYS5+g
         TRDj7tX8GUNYHMepNqpEqYOoG+k2X1uPrDH/sF62gosf0rsYgL8/xiCC4fCL/dYLPcXI
         r9gg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4LECOn4SIBKPOHrlO1A8vlsmcRTKCNGqh1Olo9xKoJGxAqUviPLU1H2dRr99RnLuNDx7tvA91RUMuu0C4fGXf@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+pIQ+ikcSIghHxvI2oJKj7cvvclrLedTz1m3CnYuEV8T0Bxid
	YPVdwB3Z3+l7Ex6cr36VLLWJw2xEa6B5ZJsot11K1GdPVemypfXFTPDY
X-Gm-Gg: AR+sD12WxlyQX2XtX/zhMvLlZbhCT6Fv5T+zYb36txfr84Q21QNSNYQKOpmsUyNdJ4O
	3Bcq2Mbda/LRWchNRIFFzgZSXg5s6BXNT6THFbhoRLeeKU2lBnfYgmoXufNmEIkaqwrPmSPGJwI
	oamLILgzWCC8i6mRpQ/Yt3tmILZwbt4N4FeeDPUqTkOIe+PYeQYJ6qI2S+UlK/84D3Jjj9TVXQE
	q5XEodWp0yuA7qI31gvIp75BCA5fEc/7XUJts20T4HBCnTskDdYH0u6uDmIHSOAntNrrnHB4lkw
	HTCqs9dFrYSdC6fTQn+pDGmNrdDaXCre5AkS267o6q3FW9sQYNexniVcDJ+lE7lnTMBB7QpBsOT
	6ZGWz3LF3dIKjx24AQ7f5KTh9GdPxzM2A6MdAsJEKJxtnPIUmsv5BlXN0xG6X+dvJSdYrPE2RX9
	/03q8BwdLNYpagRffF5PrYJPeeuDeXsipV7XPvCpVduoT9t3KGC5ElWIZKfxw5+Pyy8xfJcolZL
	5siWGROkVeHITG/J+JKyiDrz62jyU0EKpy/LV+dAhhw
X-Received: by 2002:a05:600c:1c12:b0:496:b3a0:1cfe with SMTP id 5b1f17b1804b1-496b56f3994mr3482295e9.12.1784936094864;
        Fri, 24 Jul 2026 16:34:54 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfe07e1sm75012115e9.3.2026.07.24.16.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 16:34:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 25 Jul 2026 01:34:54 +0200
Message-Id: <DK771DKIJ0TO.1978GTUX7YMYC@gmail.com>
Cc: "James Clark" <james.clark@linaro.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Arnaldo
 Carvalho de Melo" <acme@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, "Bill Wendling" <morbo@google.com>,
 "Justin Stitt" <justinstitt@google.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Peter Zijlstra"
 <peterz@infradead.org>, "Ingo Molnar" <mingo@redhat.com>, "Mark Rutland"
 <mark.rutland@arm.com>, "Alexander Shishkin"
 <alexander.shishkin@linux.intel.com>, "Ian Rogers" <irogers@google.com>,
 "Adrian Hunter" <adrian.hunter@intel.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
 <bpf@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v4 0/4] tools/build: Allow versioning of all LLVM tools
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Namhyung Kim" <namhyung@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
 <algbxQAAmurxms8X@google.com> <DK6Z25AV02BM.3KXO0EMCMP2W9@gmail.com>
 <amP16I_cn58hhupT@google.com>
In-Reply-To: <amP16I_cn58hhupT@google.com>

On Sat Jul 25, 2026 at 1:31 AM CEST, Namhyung Kim wrote:
> On Fri, Jul 24, 2026 at 07:19:45PM +0200, Kumar Kartikeya Dwivedi wrote:
>> On Thu Jul 16, 2026 at 1:46 AM CEST, Namhyung Kim wrote:
>> > Hello BPF folks,
>> >
>> > On Wed, Jul 15, 2026 at 03:53:47PM +0100, James Clark wrote:
>> >> I ran into the build issue mentioned in the first commit, because usi=
ng
>> >> an option like LLVM=3D-15 is a documented way to build [1], but only
>> >> some of the LLVM tools defined in tools/ support this.
>> >>
>> >> After fixing that, a lot of other tidyups fell out. I didn't go too f=
ar,
>> >> for example some selftests include tools/testing/selftests/lib.mk whi=
ch
>> >> reimplements some of the LLVM_SUFFIX stuff, but other selftests inclu=
de
>> >> tools/scripts/Makefile.include and I stopped before touching the form=
er.
>> >> Some other non build scripts hard code toolchains and I didn't touch
>> >> those either, this change is only focused on things that already
>> >> include Makefile.include.
>> >>
>> >> [1]: Documentation/kbuild/llvm.rst
>> >>
>> >> Signed-off-by: James Clark <james.clark@linaro.org>
>> >> ---
>> >> Changes in v4:
>> >> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
>> >>   already picks the correct sibling lld version. (Sashiko)
>> >> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-vers=
ion-v3-0-8854bfe5af7e@linaro.org
>> >>
>> >> Changes in v3:
>> >> - Add warning for empty $USE_LD
>> >> - Use $HOSTREADELF in bpf Makefile
>> >> - Rebase on v7.2-rc3
>> >> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-vers=
ion-v2-0-f12cc4f031d8@linaro.org
>> >>
>> >> Changes in v2:
>> >> - Fix selftests/bpf build. LLD needs to take the full path to be used
>> >>   with -fuse-ld=3D
>> >> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-vers=
ion-v1-0-6cac1a9a4c8d@linaro.org
>> >>
>> >> ---
>> >> James Clark (4):
>> >>       tools/build: Allow versioning of all LLVM tools defined in Make=
file.include
>> >>       tools/build: Indent if else blocks
>> >>       tools/build: Allow versioning LLVM readelf
>> >>       tools/build: selftests: Remove some duplicate toolchain definit=
ions
>> >>
>> >>  tools/bpf/resolve_btfids/Makefile    |  3 --
>> >>  tools/lib/api/Makefile               |  4 --
>> >>  tools/lib/bpf/Makefile               |  8 ++--
>> >>  tools/lib/subcmd/Makefile            |  4 --
>> >>  tools/lib/symbol/Makefile            |  4 --
>> >>  tools/perf/Makefile.perf             |  7 ----
>> >>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++------=
----------
>> >>  tools/testing/selftests/bpf/Makefile |  1 -
>> >>  8 files changed, 46 insertions(+), 62 deletions(-)
>> >
>> > Are you ok with this change and going through perf tree?
>> >
>>
>> Sorry for the delay, yes, feel free to take it through your tree.
>
> Thanks, can I take it as your Acked-by?
>

Sure.

Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

> Namhyung

