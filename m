Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232442;
	b=AP57Cov6PRFHuIFIAZF8FNOvVl8SRpBtqqhgKg7MojxINk/oCWGeIAS50hxm0SrAko0y
	 nNHiL0ct5zuEAZWEyZR0Py4t6VIj6TH+zw+t0C+YZ4kOyaRM1UMrBpFqnixgyCmdlSS6+
	 iU7dv8EaTLIQuLL/e0jqYS1/fLRp5D12YQpYq1egG3unMj3qkir+nT6HxBqsTg6va3bNQ
	 Z/LjHkP9yd5NBKh1ombN2+xD56RGG625iNT/iDX5x0371gkOGvC7iPMRB85ts6P6FCXhU
	 jvG0vdBHo5XKjfKYWTCwDOOR5+d8UzbDwNs7usBIufQUco1Z1+xRR+lth/wKlTerNyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232442;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=QIJuKh/pVRkEldQZgeIECza+9+tYpV4QUya8PztyHNg=;
	b=t06CFUHBQRTDt7/viuSb0BNXjqPj+QEE84oirFGf/TIZFUveMQAeCMK1rJKwm1HjdqNG
	 DCGkOejPE0zxE/bAtwoVLOrwBOaHj3Y+7U7sDpmkwff7ENFxnA9b4OTS3meqB6lDeb7wt
	 4t2vNF8+Gk8HAb8e2ISinmCU2gD0OhxGqhdoKkIP8Bbnns0r4hV5LCpEanguXdvfPqR3G
	 JWMFqIIRVk/cd9/NNe8eiJaY4BS/2RvdkvsKuVO05pprHT8dLkl0t3cgStehTXKz/m4E4
	 z+1/HXmMb5EV3alV0s/bHRdrkjfw6n4tJWABXAPZjXeVk+ON60lqS3K3n8JOVMuUL5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imjbHRFS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA65606A321
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Nov 2026 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=imjbHRFS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F631F0089F;
	Mon,  9 Nov 2026 13:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232441;
	bh=QIJuKh/pVRkEldQZgeIECza+9+tYpV4QUya8PztyHNg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=imjbHRFSetgt/C4zVToDx/b716nC61lOAcExcF4TDqTeWC3JvQs6ffzp4HXmfZmOV
	 QgwCVwGIlNc3YXhR5PDLcm6KUzREm65euqdUPMEfk9i8elMLSNzk2L2GmLb8zEXtdC
	 fBT3oskvZ48khpS2bi91JKy5DBVI+PUNgQZvAM29AzOtVWTuR3zjxlqkUO4BrFR4Ny
	 2MFsoJutkKHS/SyjB6nkY4+fbe9+5mJqhsTV28ePtePRaLkt5wr02akZWGQPEuRU5G
	 MlcFvOsW38443v5hRDAlC8JxsQFYJ6sPk+TuKrInTn85vIt2Q3oyOIRXso9xMIE1FL
	 WsedrJl3Qkx8g==
Message-ID: <sashiko-outbox-205038@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/4] perf dwarf-aux: Support DW_OP_addrx locations
 for global variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261109-james-perf-test-fixes-v4-2-355ee6b81917@linaro.org>
References: <20261109-james-perf-test-fixes-v4-0-355ee6b81917@linaro.org>
 <20261109-james-perf-test-fixes-v4-2-355ee6b81917@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 13:54:00 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> die_find_variable_by_addr() and die_collect_global_vars() only accept
> global variables with a DW_OP_addr location. DWARF 5 producers like
> clang use DW_OP_addrx instead, which is an index into .debug_addr, so
> global variables are never found when Perf is built with LLVM=3D1.
>=20
> Add a helper that also resolves DW_OP_addrx and DW_OP_GNU_addr_index
> through dwarf_getlocation_attr() and dwarf_formaddr(), and use it in
> both places. This fixes the "perf data type profiling tests" test:
>=20
>   $ perf test -vvv "perf data type profiling tests"
>   ...
>   Basic C perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe C perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ...
>   Basic FS perf annotate test
>   Basic annotate [Failed: missing target data type]
>   ...
>   Pipe FS perf annotate test
>   Pipe annotate [Failed: missing target data type]
>   ---- end(-1) ----
>    88: perf data type profiling tests : FAILED!
>=20
> Fixes: d60469d7c0e5 ("perf dwarf-aux: Add die_find_variable_by_addr()")
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261109-james-perf=
-test-fixes-v4-0-355ee6b81917@linaro.org?part=3D2

