Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538F3DFC88
	for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 17:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784913591; cv=none; b=B9L12n6GKiNCcKCKWtMN8vY9bmRoW8a7KfSp6toVHCOyKyAIKuVtnL2PHUQH9vFo9fuQVl4g4loLRFcBrmf7ZTqr4DgvzhTJf9UaQorkeqz1UR1IZ56FfANIlhlXZeKjBI4jAnsYEBOzOJptBc39dIrF2jK1aZW9L3QP96QeXJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784913591; c=relaxed/simple;
	bh=h43OVubBFOUqhHHcp0LrQGUoL7yyuyHZKEUxyYWHBUE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DrzXl56Iw03SdmdsyDQNWe2mguK0JnN8prQKv0thI79XM8VXW3rNtgVAViE08ZMePYn81TN+9gRbZ/etmzqkUJ6nFjE29pqkM/yaO23n6a+7DpLVbmRL2r833dUF25955in85IBel5qkT+U8yaxd1Gw/0XycwOy2Kj3MuELpSJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYt/tflG; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYt/tflG"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so1772045e9.0
        for <linux-perf-users@vger.kernel.org>; Fri, 24 Jul 2026 10:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784913587; x=1785518387; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KowxSJVmc3vRiPdHyROrkjM4WewCaL2j1J/8LxUkYtk=;
        b=JYt/tflGn11muPpBMVHJnVUocFze63t0VswaCJl0UGmUlc/kw9a7mejzVFHaorrKNW
         tej5WEACR3SkJXb2JZiJp4WQxMRbg5gSJR3m6iEKu2TblmMzXwi3wI7kzZrXBu+ticrs
         MQoRTq5mPuLW106CFbXAusqi9d+8okQc++xo+rcwI2oDfqbcPBhobx9qKYjJgo8rIPKY
         jkaHa56KslGmDtEsiUwkw5JV3PbyLUU8assMCFC0l4WJvcnOu/vS2XFUMuNoYzMBrPNM
         ulCmFOT8j7hK7XUX/HDoubNFMo2UOhO0ksVC9KFls2aCtgo6kL4mA4wjLIALmkUrxcoM
         ekDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784913587; x=1785518387;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KowxSJVmc3vRiPdHyROrkjM4WewCaL2j1J/8LxUkYtk=;
        b=hWJqzTnDW7gWMe3YSZeHkyMG/i5SkwOktvAAJG71y5MgnrPZ3v8zvB7rjwqdFEfCCG
         wYfGMKbScF4/VWcWka4BYuzM9Y87nQiR8WW4yWnffxLBufKgqm5g6mSi3SH1ZkofiJ3R
         ENQrIAG/LhxsnM4cCHXNdolw4KQ51M4qT5Hj3nVJswfZsumfjtMIGQzJWonYwtsTtMEi
         03G8Nk0ZXe/zq+TrAmM5TDOekQDWGO/GS6zpIhdvitLvYHCUBFOBIIlFjKg8FtVfMfAH
         OFRc6WRQY/g+legkMhqedl6AZIi2Dd26QN9JIixSOF6bYfqjX8DLSSPYO7L3sut/XQ9h
         2EyQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq1bsfuY2Xww3r80h7G66IEpZ/HneJ5QrwI1eEmqCIEmu0GyG5i44vEdPeBJQTwwJLKrpoqSCqEMputiNg7eVKo@vger.kernel.org
X-Gm-Message-State: AOJu0YzP6y3+5+6LzNcqzejcs9fvnKjQh5sKLyiG896/rmXRzKvmGYkg
	4UBlNf+jiOOeTUhNn9US1j7bGiWqklnkkDjPwrUQ+glr0PzkO1/3tL6t
X-Gm-Gg: AR+sD13mvAJ7Gz3D4KMwNVxcUJsI2ygwk3YoU/ANGmS0hPfFC59WIWqk6AFbf+WAe8Q
	2m/OS5qCgyZNXukN3RUCg9HkFkO4whC5ilZ/Y/D5KQIlhVjzlXkwuI1XbF+carhFk/mNXwyJ7Yi
	Z7k0AoYxZ5QHHODWunPQEuZB/JTG0neSyaF3Q48f82pPptXcq9mu1IggnvVYSRaZlw1ET7MziJZ
	xrSk7tcSc0be0Oj6zmMb+d9qTKPoVWn1mHqpxbP+RnNAOLfMiwKRIk//EsYct/yd74Bsc9NGAid
	u7ATnxWMVmOWEgtkOPCdX3tTb0vFOUsTrRnviDPXsZ7WuwnWvyhltgtvGa3jahc8zSvPn9R9K+U
	eRIQYMz7eQgKlshwJwIQLL3CWGonJpGWniOpcQHbn6MIpzUb3eHdWXJ/ctXx+dz7Z5ojKPhmXYO
	ymvselHGksnMzrRsEHaMeMQzXi9Za6gJC14/pJQwwqPUIgORZQV+orh3v9ZfBGTAfPhSHwTF8Z6
	hX0sNBeA2m6uSNeMDf75JCVCzzMMz5HcT6TVu0oP0p5
X-Received: by 2002:a05:600c:5942:b0:495:6397:14b1 with SMTP id 5b1f17b1804b1-49573cf0ec2mr67839245e9.34.1784913586592;
        Fri, 24 Jul 2026 10:19:46 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957f5665f0sm49342725e9.0.2026.07.24.10.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 10:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Jul 2026 19:19:45 +0200
Message-Id: <DK6Z25AV02BM.3KXO0EMCMP2W9@gmail.com>
Cc: "Arnaldo Carvalho de Melo" <acme@kernel.org>, "Ihor Solodrai"
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
To: "Namhyung Kim" <namhyung@kernel.org>, "James Clark"
 <james.clark@linaro.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260715-james-perf-llvm-version-v4-0-6dfdf984b435@linaro.org>
 <algbxQAAmurxms8X@google.com>
In-Reply-To: <algbxQAAmurxms8X@google.com>

On Thu Jul 16, 2026 at 1:46 AM CEST, Namhyung Kim wrote:
> Hello BPF folks,
>
> On Wed, Jul 15, 2026 at 03:53:47PM +0100, James Clark wrote:
>> I ran into the build issue mentioned in the first commit, because using
>> an option like LLVM=3D-15 is a documented way to build [1], but only
>> some of the LLVM tools defined in tools/ support this.
>>
>> After fixing that, a lot of other tidyups fell out. I didn't go too far,
>> for example some selftests include tools/testing/selftests/lib.mk which
>> reimplements some of the LLVM_SUFFIX stuff, but other selftests include
>> tools/scripts/Makefile.include and I stopped before touching the former.
>> Some other non build scripts hard code toolchains and I didn't touch
>> those either, this change is only focused on things that already
>> include Makefile.include.
>>
>> [1]: Documentation/kbuild/llvm.rst
>>
>> Signed-off-by: James Clark <james.clark@linaro.org>
>> ---
>> Changes in v4:
>> - Drop "tools/build: selftests: Allow versioning LLVM lld", clang
>>   already picks the correct sibling lld version. (Sashiko)
>> - Link to v3: https://lore.kernel.org/r/20260715-james-perf-llvm-version=
-v3-0-8854bfe5af7e@linaro.org
>>
>> Changes in v3:
>> - Add warning for empty $USE_LD
>> - Use $HOSTREADELF in bpf Makefile
>> - Rebase on v7.2-rc3
>> - Link to v2: https://lore.kernel.org/r/20260518-james-perf-llvm-version=
-v2-0-f12cc4f031d8@linaro.org
>>
>> Changes in v2:
>> - Fix selftests/bpf build. LLD needs to take the full path to be used
>>   with -fuse-ld=3D
>> - Link to v1: https://lore.kernel.org/r/20260514-james-perf-llvm-version=
-v1-0-6cac1a9a4c8d@linaro.org
>>
>> ---
>> James Clark (4):
>>       tools/build: Allow versioning of all LLVM tools defined in Makefil=
e.include
>>       tools/build: Indent if else blocks
>>       tools/build: Allow versioning LLVM readelf
>>       tools/build: selftests: Remove some duplicate toolchain definition=
s
>>
>>  tools/bpf/resolve_btfids/Makefile    |  3 --
>>  tools/lib/api/Makefile               |  4 --
>>  tools/lib/bpf/Makefile               |  8 ++--
>>  tools/lib/subcmd/Makefile            |  4 --
>>  tools/lib/symbol/Makefile            |  4 --
>>  tools/perf/Makefile.perf             |  7 ----
>>  tools/scripts/Makefile.include       | 77 ++++++++++++++++++++---------=
-------
>>  tools/testing/selftests/bpf/Makefile |  1 -
>>  8 files changed, 46 insertions(+), 62 deletions(-)
>
> Are you ok with this change and going through perf tree?
>

Sorry for the delay, yes, feel free to take it through your tree.

> Thanks,
> Namhyung
>
>> ---
>> base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
>> change-id: 20260511-james-perf-llvm-version-43ab1cb5bc7d
>>
>> Best regards,
>> --
>> James Clark <james.clark@linaro.org>
>>

