Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3684013A27D;
	Wed,  5 Jun 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717609184; cv=none; b=sgYVvvOXUbe4bUQTuUUbLg/wjmUqVlC0zQClVFhOcwfV3TTweNoWt5GlWaHHVyeiUvGOFKedlzJ3iNRLilcDDjnKwoeg2tlezG8cSJZcS4vUvVh6Flc7Z5NUAhpr18FK5yXMLaFC7Yp8km5EXhZ1q01K85fTRMs4vH2I0UJCH2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717609184; c=relaxed/simple;
	bh=fuBA1Y0rsKEgp27r29OV1H/+ChmvQlgNMqku0b2LcDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOpF3ZaRVLJk4Sv3JYkysbgnHmJWXXpKHgVrm6hKc0t9Sl3Ta8IsP1NMhmXPW6jD6N7WmVCd+Yse1rDQQf/Y+7Kit58bfjLkeTc8tnZyJAyKZ0pfig47uNT2hTK6bRYBE+l57kFGC96bygUHucO8DBS8VmL2OmcTOYnGSw4bcnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xdnf64pj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xdnf64pj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CB1C2BD11;
	Wed,  5 Jun 2024 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717609183;
	bh=fuBA1Y0rsKEgp27r29OV1H/+ChmvQlgNMqku0b2LcDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xdnf64pjhxtSWNkb/vJK/QYT6Br0BKxQMIHffq53vbZ6mUpZ6fAP9O7+ofjSy3reT
	 QY+0xr5D2SZTPWGy+10Myb9aMRzyQIwschEbybjv2BRIF0M4DSv4yL+0LRvTNhACPg
	 32k2FgKzDRDJM1l+NFzwffEeZhvxEofopeHZzATSXw4nKmAiiSjYfYegBDj7VIDuRQ
	 EHcmjVChCQtuU7FIEvowvdt5NuIEag9rF42QJCshuTw07rFkL/c3uYzmGxux+a9/YM
	 ZXxWiJllmRu8hUfyhUiGFzlQogF3b/ANXe7wHWkB8rnNfGiSbcL6+Ad/BmvpfGdQik
	 GtXVjrsgtLICw==
Date: Wed, 5 Jun 2024 10:39:41 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: "Steinar H. Gunderson" <sesse@google.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v8 1/3] perf report: Support LLVM for addr2line()
Message-ID: <ZmCi3Z940zDxF487@google.com>
References: <20240602204208.735793-1-sesse@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240602204208.735793-1-sesse@google.com>

On Sun, Jun 02, 2024 at 10:42:06PM +0200, Steinar H. Gunderson wrote:
> In addition to the existing support for libbfd and calling out to
> an external addr2line command, add support for using libllvm directly.
> This is both faster than libbfd, and can be enabled in distro builds
> (the LLVM license has an explicit provision for GPLv2 compatibility).
> Thus, it is set as the primary choice if available.
> 
> As an example, running perf report on a medium-size profile with
> DWARF-based backtraces took 58 seconds with LLVM, 78 seconds with
> libbfd, 153 seconds with external llvm-addr2line, and I got tired
> and aborted the test after waiting for 55 minutes with external
> bfd addr2line (which is the default for perf as compiled by distributions
> today). Evidently, for this case, the bfd addr2line process needs
> 18 seconds (on a 5.2 GHz Zen 3) to load the .debug ELF in question,
> hits the 1-second timeout and gets killed during initialization,
> getting restarted anew every time. Having an in-process addr2line
> makes this much more robust.
> 
> As future extensions, libllvm can be used in many other places where
> we currently use libbfd or other libraries:
> 
>  - Symbol enumeration (in particular, for PE binaries).
>  - Demangling (including non-Itanium demangling, e.g. Microsoft
>    or Rust).
>  - Disassembling (perf annotate).
> 
> However, these are much less pressing; most people don't profile
> PE binaries, and perf has non-bfd paths for ELF. The same with
> demangling; the default _cxa_demangle path works fine for most
> users, and while bfd objdump can be slow on large binaries,
> it is possible to use --objdump=llvm-objdump to get the speed benefits.
> (It appears LLVM-based demangling is very simple, should we want
> that.)
> 
> Tested with LLVM 14, 15, 16, 18 and 19. For some reason, LLVM 12 was not
> correctly detected using feature_check, and thus was not tested.
> 
> Signed-off-by: Steinar H. Gunderson <sesse@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
[SNIP]
> +static int addr2line(const char *dso_name, u64 addr,
> +		     char **file, unsigned int *line, struct dso *dso,
> +		     bool unwind_inlines, struct inline_node *node,
> +		     struct symbol *sym)
> +{
> +	struct llvm_a2l_frame *inline_frames = NULL;
> +	int num_frames = llvm_addr2line(dso_name, addr, file, line,
> +					node && unwind_inlines, &inline_frames);
> +
> +	if (num_frames == 0 || !inline_frames) {
> +		/* Error, or we didn't want inlines. */
> +		return num_frames;
> +	}
> +
> +	for (int i = 0; i < num_frames; ++i) {
> +		struct symbol *inline_sym =
> +			new_inline_sym(dso, sym, inline_frames[i].funcname);
> +		char *srcline = NULL;
> +
> +		if (inline_frames[i].filename)
> +			srcline = srcline_from_fileline(
> +				inline_frames[i].filename,
> +				inline_frames[i].line);

Please fix the coding style.  Also you may add a pair of brackets to
multi-line code even if it's a single statement.

Thanks,
Namhyung


> +		if (inline_list__append(inline_sym, srcline, node) != 0) {
> +			free_llvm_inline_frames(inline_frames, num_frames);
> +			return 0;
> +		}
> +	}
> +	free_llvm_inline_frames(inline_frames, num_frames);
> +
> +	return num_frames;
> +}
> +
> +void dso__free_a2l(struct dso *)
> +{
> +	/* Nothing to free. */
> +}
> +
> +#elif defined(HAVE_LIBBFD_SUPPORT)
>  
>  /*
>   * Implement addr2line using libbfd.
> -- 
> 2.45.1
> 
