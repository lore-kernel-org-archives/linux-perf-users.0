Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A10262FCB;
	Tue,  4 Nov 2025 03:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225607; cv=none; b=dEqORa8xwJDnwY9vCGHpCjxCejbHveXjOIWDWYX2yf5obsmbnH/JdlTRGZOdsZU1TbFyoqL7S/tsoTE0Mog3gU5+1qJYbCumc6ejLwwpK/GuCHBIw+C38Z0lmzqwRM7m27BycMU/dK33EjcymCAI0mhGkAaxaTc3cvNtRwNPrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225607; c=relaxed/simple;
	bh=+LuC9KSpXQy1P0RD96IHa9heOKammTwc0UseuOyynxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ufgn1mmP2pltz0vbH9LoYLyMHgGo+TV51Tag6p0w/7Blr7rEWuhcDH9dPxqbie+VrYq+e0Ds0spBrDW3QYwWlCBwMciqN1xcOd6WhFtbngwCI2fEdoDgv03+wQU+aQ0korIlETesNNMHtInLwbZeAhRegXkwHsIq7VsxzQYotYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMnD1MQ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMnD1MQ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E51C4CEE7;
	Tue,  4 Nov 2025 03:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762225607;
	bh=+LuC9KSpXQy1P0RD96IHa9heOKammTwc0UseuOyynxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tMnD1MQ25R/Us3XrcxmPNaFPvdfWxiEbYe6gusrOtC0kAqTjvxW9O7g9Pi7YyNZMz
	 HvQ1prUxKFGGbVBWlTQu2SOjvS3MGJMy1Y1trtkjVGyWgWsV2ug4FftXlBD/po0UA5
	 ohxSUbSPvCZ8zGpoCte3uvQumYvKzqtkNY99loi16xlwi/A6JOcKrI0fFHksH6uNTC
	 ZOZlNYJPlG6JPwmlY9T2CjyPoITChY2l5Lgutrm18Na5y5YuJLEj3t+esuWMnxGx2w
	 Eb+m1GAx8FXPQVKk2gFSRRTvMwpJWFI2hLTcMiwGcQZKy7wtB3e9q7iTX/DnB8cXLw
	 3mxusoL1j7GaA==
Date: Mon, 3 Nov 2025 19:06:45 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <lossin@kernel.org>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>,
	Trevor Gross <tmgross@umich.edu>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>,
	James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 1/1] perf symbols: Handle '1' symbols in /proc/kallsyms
Message-ID: <aQltxZIVd6w5VNtI@google.com>
References: <aQjua6zkEHYNVN3X@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQjua6zkEHYNVN3X@x1>

Hi Arnaldo,

On Mon, Nov 03, 2025 at 03:03:23PM -0300, Arnaldo Carvalho de Melo wrote:
> Just FYI, I'm carrying this on the perf tools tree.
> 
> I started seeing this in recent Fedora 42 kernels:
> 
>   root@x1:~# uname -a
>   Linux x1 6.17.4-200.fc42.x86_64 #1 SMP PREEMPT_DYNAMIC Sun Oct 19 18:47:49 UTC 2025 x86_64 GNU/Linux
>   root@x1:~#
> 
>   root@x1:~# perf test 1
>     1: vmlinux symtab matches kallsyms     : FAILED!
>   root@x1:~#
> 
> Related to:
> 
>   root@x1:~# grep ' 1 ' /proc/kallsyms
>   ffffffffb098bc00 1 __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   ffffffffb098bc10 1 _RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   root@x1:~#
> 
> That is found in:
> 
>   root@x1:~# pahole --running_kernel_vmlinux
>   /usr/lib/debug/lib/modules/6.17.4-200.fc42.x86_64/vmlinux
>   root@x1:~#
> 
>   root@x1:~# readelf -sW /usr/lib/debug/lib/modules/6.17.4-200.fc42.x86_64/vmlinux | grep __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   150649: ffffffff81f8bc00    16 FUNC    LOCAL  DEFAULT    1 __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>   root@x1:~#
> 
> But was being filtered out when reading /proc/kallsyms, as the '1'
> symbol type was not being handled, do it, there are just two of them at
> this point.

Do you know what the type '1' means?  It seems they are from Rust.

Thanks,
Namhyung

> 
> Cc: Alex Gaynor <alex.gaynor@gmail.com>
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Andreas Hindborg <a.hindborg@kernel.org>
> Cc: Benno Lossin <lossin@kernel.org>
> Cc: Björn Roy Baron <bjorn3_gh@protonmail.com>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Gary Guo <gary@garyguo.net>
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Trevor Gross <tmgross@umich.edu>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/symbol.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> index cc26b7bf302b29d6..948d3e8ad782bc2a 100644
> --- a/tools/perf/util/symbol.c
> +++ b/tools/perf/util/symbol.c
> @@ -112,9 +112,13 @@ static bool symbol_type__filter(char __symbol_type)
>  	// 'N' first seen in:
>  	// ffffffff9b35d130 N __pfx__RNCINvNtNtNtCsbDUBuN8AbD4_4core4iter8adapters3map12map_try_foldjNtCs6vVzKs5jPr6_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>  	// a seemingly Rust mangled name
> +	// Ditto for '1':
> +	// root@x1:~# grep ' 1 ' /proc/kallsyms
> +	// ffffffffb098bc00 1 __pfx__RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
> +	// ffffffffb098bc10 1 _RNCINvNtNtNtCsfwaGRd4cjqE_4core4iter8adapters3map12map_try_foldjNtCskFudTml27HW_12drm_panic_qr7VersionuINtNtNtBa_3ops12control_flow11ControlFlowB10_ENcB10_0NCINvNvNtNtNtB8_6traits8iterator8Iterator4find5checkB10_NCNvMB12_B10_13from_segments0E0E0B12_
>  	char symbol_type = toupper(__symbol_type);
>  	return symbol_type == 'T' || symbol_type == 'W' || symbol_type == 'D' || symbol_type == 'B' ||
> -	       __symbol_type == 'u' || __symbol_type == 'l' || __symbol_type == 'N';
> +	       __symbol_type == 'u' || __symbol_type == 'l' || __symbol_type == 'N' || __symbol_type == '1';
>  }
>  
>  static int prefix_underscores_count(const char *str)
> -- 
> 2.51.1
> 
