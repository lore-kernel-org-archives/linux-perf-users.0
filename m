Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794643585;
	b=zElf0o7hleQZeF2SKsebdfeM5UmkUFOZaSvAbWwA1TAVP1Nx/PaV0/vSq5n30KuQaUG9
	 5yRvbYJfS7UBgButVmmttnF/f4f2vNcvbA/2069mHx8g8J56aXU6hqYu7xNiFD1GtfeG3
	 QXOXlRekTP7y8uUGkOQ/MqMTlImk3upImZzxmHtXKK1+8L5aSqXx/hYTo4x3qun2uh4Wo
	 66kSeWC3G7lq+WfiHSkDZGFDdZ842txUjd3cJVST3lwLsCU60Kqrl9YCbYT7G0XDfKNin
	 Vfz7WRuUkbHGipidGDIV+n+lODsSy7tWopMLeEz/Wy3zZX+SqZqelKx5GebB1EKjHzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643585;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kQrMYFgOdkboa27uqwjg/EzB6crz38YYx5/xmOuh9zc=;
	b=kaSYd2FaMhGFM9cNjkWhqmdtmG1KfZxD+AWiIa45Rr7nARWExcRqJjb/ArwCe8Fx3WlT
	 dLaZjzLAgChZg/RbP6xuU93Xx6nZrHUjyWVQyZnvL5T+N3gYI6O7AG9TePCDqziKJTkKf
	 Y6+Djm+uJZhjGsAdbPpLiiiUBFGMyzX/07vAHlwVC9JQBRMR0QmehnaFjJ2I1iZpj9Tf3
	 YnrjOjcXcnXRpmnx6uK4UwD2uWnUUoK/LzNyfbPy3vwa1G1UVGnh3pWaQnlzvwvIgvUzm
	 Zce2nEYwjs0mthBRVSRvE8AovZsp3APGjFjjwZddidohyucw/q/Vtlw0GusxK7Mvr0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="PrZI/Eby";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECAB8606A332;
	Sat, 14 Nov 2026 08:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PrZI/Eby
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44CE61F000C4;
	Sat, 14 Nov 2026 08:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794643584;
	bh=kQrMYFgOdkboa27uqwjg/EzB6crz38YYx5/xmOuh9zc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PrZI/Ebymlnn+nBCN8KaiL6P57zIS68POn5Z1spbXtftP7/h4ff0uofaKETawkYbJ
	 7m0mmN3lySDigMiWSNZdWSQ4cI6OdE9GwUsC+vueBgkYvlFOcU36F/ZLbWgMfCmx3U
	 3qjBVIE97bpWIU0hSrAa2ccswEDQM3sUZss3030R8vODNoHdPeEhIoom6rlTCwNL2X
	 20207rSPtXZgu6qd3qiBAPzLRWH0skWTqfm615a+IJ7b2jSxgzuU+Q/ZBhL5ntyqu7
	 gOeiKSnufXLblqvUqYd6ElAiP8Sn8Teb+dYEi/0oCpMj2P5tXjMVeV6spacn46QfTR
	 HdgNc6APonoew==
Date: Sat, 14 Nov 2026 00:06:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Letian Jiang <letian.jiang@outlook.com>
Cc: acme@kernel.org, jolsa@kernel.org, irogers@google.com,
	eranian@google.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf docs: Correct JIT_CODE_UNWINDING_INFO
 specification
Message-ID: <avgWfgLO0dY-kDxl@google.com>
References: <CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
 <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CYXPR84MB347640EF284BED04EADB0B4A826C2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM>

Hello,

Sorry for the late reply.

On Sat, Oct 31, 2026 at 02:12:22PM +0800, Letian Jiang wrote:
> The JIT_CODE_UNWINDING_INFO description places the EH Frame Header before
> the EH Frame. However, jit_add_eh_frame_info() uses the beginning of the
> unwinding data for .eh_frame and the trailing eh_frame_hdr_size bytes for
> .eh_frame_hdr.
> 
> Correct the unwinding_data description and the eh_frame_hdr_size field
> description to match the layout consumed by perf.
> 
> Also document that an unwinding record precedes and applies to the next
> JIT_CODE_LOAD record. perf caches the unwinding data and uses it when
> processing that load record.
> 
> Revise the mapped_size note to describe frame-pointer-based unwinding as
> a possibility depending on the backend and valid frame pointers in the
> generated code.
> 
> The libunwind-specific use case still matters: its EH Frame Header fields
> through fde_count are read directly from the ELF file, while lookup-table
> and EH Frame accesses require a mapping covering those addresses. An
> empty lookup table can trigger frame-pointer-based unwinding fallback
> without mapping the unwinding data. This does not impose the same access
> requirements on other unwinding backends.

Thanks for working on this.  It's been a while since I took a look at it
last time.  I don't remember why it has EH Frame Header at the end.
It'd be simplier if we have it before.

> 
> Signed-off-by: Letian Jiang <letian.jiang@outlook.com>
> ---
> Changes in v2:
> - Revise rather than remove the mapped_size note's frame-pointer use
>   case, making it conditional on backend support and valid frame pointers.
> - Explain the libunwind empty lookup table use case in the commit
>   description while keeping the specification backend-neutral.
> - Keep the record-ordering paragraph on one line to match the existing
>   specification style.
> 
> v1: https://lore.kernel.org/linux-perf-users/CYXPR84MB347620A9EC3D829B4279F138826D2@CYXPR84MB3476.NAMPRD84.PROD.OUTLOOK.COM/
> 
>  tools/perf/Documentation/jitdump-specification.txt | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Documentation/jitdump-specification.txt b/tools/perf/Documentation/jitdump-specification.txt
> index 7993635..ab43aa8 100644
> --- a/tools/perf/Documentation/jitdump-specification.txt
> +++ b/tools/perf/Documentation/jitdump-specification.txt
> @@ -153,12 +153,14 @@ The record type is optional.
>  
>  The record is used to describe the unwinding information for a jitted function.
>  
> +The record must precede the corresponding JIT_CODE_LOAD record. It applies to the next JIT_CODE_LOAD record in the file.
> +
>  The record has the following fields following the fixed-size record header in order:
>  
>  uint64_t unwind_data_size   : the size in bytes of the unwinding data table at the end of the record

Does this mean the size of EH Frames only or including the header?  I
think it's better to clarify it here.

Thanks,
Namhyung


> -uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the start of the unwinding data table at the end of the record
> +uint64_t eh_frame_hdr_size  : the size in bytes of the DWARF EH Frame Header at the end of the unwinding data table
>  uint64_t mapped_size        : the size of the unwinding data mapped in memory
> -const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame Header, followed by the actual EH Frame
> +const char unwinding_data[n]: an array of unwinding data, consisting of the EH Frame, followed by the EH Frame Header
>  
>  
>  The EH Frame header follows the Linux Standard Base (LSB) specification as described in the document at https://refspecs.linuxfoundation.org/LSB_1.3.0/gLSB/gLSB/ehframehdr.html
> @@ -167,4 +169,4 @@ The EH Frame header follows the Linux Standard Base (LSB) specification as descr
>  The EH Frame follows the LSB specification as described in the document at https://refspecs.linuxbase.org/LSB_3.0.0/LSB-PDA/LSB-PDA/ehframechpt.html
>  
>  
> -NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, then only the EH Frame Header will be read, which can be used to specify FP based unwinding for a function which does not have unwinding information.
> +NOTE: The mapped_size is generally either the same as unwind_data_size (if the unwinding data was mapped in memory by the running process) or zero (if the unwinding data is not mapped by the process). If the unwinding data was not mapped, frame-pointer-based unwinding may still be possible, depending on the unwinding backend and whether the generated code maintains valid frame pointers.
