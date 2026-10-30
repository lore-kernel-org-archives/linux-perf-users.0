Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793319302;
	b=fdL8OLPi45bJ0Z38qWLvMXdPjy97HJa3WLNzYVSG4uyPbOhyWdXbeei8V6Q8NCMOUAId
	 ncit7GZs9Sfkld8nATefl1z2Opzu62aK+kBhcVhPVIuiD1yFb5IovSRv8TIXUXNcnhHPn
	 2wn2MjCBDpRD3ocqp1SLqzzOCBiFrhlniO3jdo66Q6nBohJqTJO9XwqyGpO3OKotVcTbf
	 4+jhU7R9SHFBPZ8miOh1JxHYen5IVFQPHXHHqMbjg43sd2Vy08SJ+TYTP098FA/oSzvTe
	 YzFA5S0b/ruLPcsKweZc2g0cM2k46np+l8p2ptFqwXHuM9IIp8UETnItRbBWwO7IV6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793319302;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vqGnoJV4fIgbZtaKIk8jZS2Hfj3hWTfvQ+zjY/yWwmw=;
	b=KBPKOqbn1qEDKo2S/xBvRAgdieTJJYBLYOh0xsLSMSzs2HH0a9ktSHvBA+Tg7bDFDrdE
	 apNJkQivjWo33R/hFZuqvbM/rRuxEPNcE3Vtc3tmSoSPmmYQd9EH6PLDd34k5OxmX2MOV
	 I/xHaTAl5SJfaTJ7DzgjfGzAIRLOEnktkRxdpg2btX8szfeOlntCjihqGGgMRIVrnmGAs
	 zNjX68xIfmFOsnSZN2tSp3WDAO/17QAhDPriDRw1vGzItqrnWlupxVzeEWr0lJr8Nd9Re
	 Gyhhf+Q19yuUHlbJ3DhoejjwnhFdNOwiQKOJvr4gy4dBGStC5lDG8aMiA/H0le0UZDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="YxNO/Jua";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBDA606A321;
	Fri, 30 Oct 2026 00:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YxNO/Jua
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F253E1F000C1;
	Fri, 30 Oct 2026 00:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793319301;
	bh=vqGnoJV4fIgbZtaKIk8jZS2Hfj3hWTfvQ+zjY/yWwmw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YxNO/Juac/DOmudo+trQ/spyJrXNnIR5b/xtycCcoDfZ/v194fmiqGaI2FuqMffnZ
	 LNKtiXq2RyABZ+oLWseoAaQxNKNg/p071Wj3099jPOVR0Pl2lT0BoPMUl9qgDNkwvD
	 0Vip+uYve+lcpb5qKTv+PWRocDaVz9A47G02tl9XrYwUmd5DpeokWiCT2V7rRkSnNl
	 HoSi5dl9jB5dBnsYUbFWoPHGfqLChW5wL+LU86xRS+q3reladcWCkAHW9lZUmXwHQA
	 w1SKnXYH9OGV7xuAHHghcReF3G9soUH84l1Kh5Dp3oqgoJoOBq9YqkH0isOdYtJMsr
	 5tfbIpD+If6Rw==
Message-ID: <d1267d81-0ed8-4b3f-a535-88ddba51af88@kernel.org>
Date: Fri, 30 Oct 2026 01:14:56 +0100
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/3] bpftool: Prefer zlib-rs over zlib when
 available
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261029162958.3224280-1-irogers@google.com>
 <20261029162958.3224280-4-irogers@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261029162958.3224280-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-10-29 09:29 UTC-0700 ~ Ian Rogers <irogers@google.com>
> Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected, falling back to -lz.


Hi Ian, bpftool doesn't make an intensive use of zlib (mostly, it's a
requirement from other dependencies; we may also use it to unzip the
kernel config on the host if necessary for probing BPF features on the
system, but only on some distributions). So I'm struggling to understand
the motivation for your proposal, what do we gain by switching to
zlib-rs when available? I understand this implementation is in Rust, but
I'm not sure the added complexity and feature probing in the build
system is worth it.


> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/bpf/bpftool/.gitignore |  1 +
>  tools/bpf/bpftool/Makefile   | 56 ++++++++++++++++++++++++++++++++----
>  2 files changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/.gitignore b/tools/bpf/bpftool/.gitignore
> index a736f64dc5dc..ea2222373634 100644
> --- a/tools/bpf/bpftool/.gitignore
> +++ b/tools/bpf/bpftool/.gitignore
> @@ -6,5 +6,6 @@ bpftool*.8
>  FEATURE-DUMP.bpftool
>  feature
>  libbpf
> +libz_rs
>  /*.skel.h
>  /vmlinux.h
> diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
> index b0f7168e7943..a193cf89a034 100644
> --- a/tools/bpf/bpftool/Makefile
> +++ b/tools/bpf/bpftool/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>  include ../../scripts/Makefile.include
> +include ../../scripts/Makefile.arch


Looking at the GitHub mirror repository for bpftool, I'd avoid including
this additional Makefile if I could.

Thanks,
Quentin
