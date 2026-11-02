Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793636446;
	b=319J75mxZ5jipGZl13RE0zB7ngNHDEoLkGQwnhive2tCiJ2qYmj9ysN/bXbL1PmFrjmw
	 fB0yaOPiH05AV2fdIZkhT2Uo6Qi5g+QKeJsgE/eMtpUEa53jA+G0DyrD32ocmIcQv8V+/
	 S6w+AEijnjz5HChvuxNeomWKPp8Hcp8mpJLEo1maL6Y5foLzvrKxdqrtgPLfLsfDYV9+1
	 09KjV25K5z8W4Uhtw4Gt0K76hnkOm+ipmAgHWEwunHh2fbfe0T4pmsY3sQtEelybkZQ2l
	 VufQ15OijN3ktYnPleI/LQLotvEgbuo3faJH2VkS3DgfQGlG20qoHPkF61Lsy74sb2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793636446;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=+JNoTlSwRmyB40Pne6BVDBz4S/O3EIyiOba9uuaE8eg=;
	b=WgNZ62hx6kZeXyW5pcxybht+c4xUqa8r3Nf3stLv/6Fj945TJYxa0Z6uGVvvO9l6pwKE
	 GVvVyRlY/g8qTNzSowQX6w3S/WS1v2wmNUSFvDFyXK6d92mls18dfwIGHQWIwja1RVDkz
	 Wb0XZIvhJFJZQiNAaXMDKHUi4BhIfeUcD2MOLtrI49u5IKKkf7LVPUtmW8ICkUHyP2r8p
	 GjsVvow59jYjZ94NZQa+w9YvKorbJytBYXvCBiYUh9Cazn2ke5e1wuve7ETZsOB0/2pB+
	 w0/pA/XEI4AhqCz+Mc2TmNrQC+3c91khcTUSO5KkS9clDWJgC1DvEDVmRy5zhlv6bsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BuqU/xlQ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB6B6083637;
	Mon,  2 Nov 2026 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BuqU/xlQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BA231F00A1A;
	Mon,  2 Nov 2026 16:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793636445;
	bh=+JNoTlSwRmyB40Pne6BVDBz4S/O3EIyiOba9uuaE8eg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=BuqU/xlQqdjOdE9xy4RoKknDtjJCSLBNlyN7yRFZsW3JrejOCr+6Tam0LF7FDzivQ
	 MT+3IY9FX5W3FF4Gv6oVx5UxLrmqmIH9/sbacwEk6RCrdXUXwA1bBz+iYTDWKmhshv
	 AnjtoBC9S4/e/wBp84/5XlRAWodC1LlKrqqhFwHxtqXs9DQVGyVr0+3to1FpO1u+EO
	 3JJ21l2KS6jiUmgMtxbdkPnxAiVstTHqVU2G7Nk5goJ22/y/fwVV0wWd5FVhnsExm6
	 PXGlU0b9Wl/ysC2IO5zl8P80MqWJmxxo1PvXF1mT6J2Vx+R3CIEia1JIBCsGcWA183
	 0rgiT9B2mpzlQ==
Message-ID: <25216bda-7e36-4bad-ba7c-1984dbb9dfda@kernel.org>
Date: Mon, 2 Nov 2026 17:20:40 +0100
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
Subject: Re: [RFC PATCH v2 3/3] bpftool: Prefer zlib-rs over zlib when
 available
To: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Miguel Ojeda <ojeda@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, bpf@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261030202710.3863806-1-irogers@google.com>
 <20261030202710.3863806-4-irogers@google.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261030202710.3863806-4-irogers@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Ian, thanks for the v2,


2026-10-30 13:27 UTC-0700 ~ Ian Rogers <irogers@google.com>
> Add zlib-rs and zlib to FEATURE_TESTS and FEATURE_DISPLAY in
> tools/bpf/bpftool/Makefile and use feature_rust_lib to configure
> ZLIB_CFLAGS and ZLIB_LIBS when zlib-rs is detected (unless disabled with
> NO_ZLIB_RS=1), falling back to -lz.
> 
> Decompression of kernel configuration (/proc/config.gz) and compressed
> ELF/BTF sections (via libbpf, libelf, and libbfd) processes data that


Is there any mechanism in place that prevents libbpf, libelf, and libbfd
to link to different versions of zlib (zlib vs zlib-rs, I mean)? I
imagine you could have bpftool linking against zlib-rs, but the libs
installed on the system linking against zlib? Also I think the static
build with the LLVM disassembler [0] passes -lz -lzstd in LIBS and I'm
not sure how it would combine with the change, I need to take a closer look.


> benefits from a memory-safe implementation. Preferring zlib-rs over C
> zlib provides memory safety and improved decompression performance while
> keeping bpftool aligned with tools/perf (including sharing libz_rs.a
> when building bootstrap bpftool for perf BPF skeletons).
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Recalling our discussion from v1:

>> Hi Ian, bpftool doesn't make an intensive use of zlib (mostly, it's a
>> requirement from other dependencies; we may also use it to unzip the
>> kernel config on the host if necessary for probing BPF features on the
>> system, but only on some distributions). So I'm struggling to understand
>> the motivation for your proposal, what do we gain by switching to
>> zlib-rs when available? I understand this implementation is in Rust, but
>> I'm not sure the added complexity and feature probing in the build
>> system is worth it.
> 
> Hi Quentin,
> 
> At my workplace, we are transitioning from zlib to zlib-rs for both
> security and performance reasons. I'd like to keep upstream tools
> aligned but they don't have to be, it just seems nice. I agree zlib is
> of a lower priority to users than, say, zstd. For attackers, like with
> brotli, it is probably an area of interest. Knowing the implementation
> is memory safe is at least something in favor of zlib-rs. I sent this
> series out as an RFC because I obviously have no way to mandate what
> upstream should or shouldn't be doing. There are things that can make
> life a little nicer and easier, and this patch series, for me, is one
> of them.
I understand you're transitioning to zlib-rs, but the current patch is
not a full transition, in the sense that it doesn't replace zlib with
zlib-rs but allows any of the two options; and I don't see support for
the standard zlib being removed from bpftool anytime soon, which means
that in practice, we've got to maintain compatibility with the two
versions going forward. Others may want to chime in, but I'm still not
convinced this is worth the burden.

You also mention zstd, do you plan to add support for a zstd alternative
as well in perf and bpftool in the future?

(By the way, if you allow me a short digression, you had a patch related
to the zstd probing for perf and bpftool [0] and I don't see in the
tree, do you know if it was ever merged?)

Best regards,
Quentin


[0]
https://github.com/libbpf/bpftool/blob/main/.github/workflows/static-build.yaml
[1] https://lore.kernel.org/all/20260909204122.1993010-4-irogers@google.com/
