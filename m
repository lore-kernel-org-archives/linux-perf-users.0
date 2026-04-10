Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5EE32ED34;
	Fri, 10 Apr 2026 04:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775795306; cv=none; b=Wqw+k0y/nNVxJcFxNdS7p6XRQtxUn5+VdxMHPOLs+GkQjDioYYbvtYSfyHtpHOztzlWnZ+0ZYvwmvs3atecondC7qcch0Jf+Q5kzolfIYNpWaV6fH0fHGzTvjozM39TKrZknSpZxvWh3ON0NvdR540dT/WRtZ7uGCXMBIFugzhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775795306; c=relaxed/simple;
	bh=Q6U7E3EJPQ+lalVF0+spSK5bBYBw7XpGaDstGNSnOYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g0WlnzSrXV/mPau1nqwqJI295JLc5LnaEjr+FueeAzdAZyeNuAiDbJQZN0cXBpNQAGixB9juh2poN8KinhmRaAP5Q3ZOQ5UvhVWHI8ISWFnA5ekeLbKCL5T8RKm0JNB9Lx7OQ57JNrQy2xKpec25OCVo1j2+aWUFkgOwU1tyHWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kDosoVYo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kDosoVYo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8F11C19421;
	Fri, 10 Apr 2026 04:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775795306;
	bh=Q6U7E3EJPQ+lalVF0+spSK5bBYBw7XpGaDstGNSnOYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kDosoVYoGcriwnL3BDMDOGoj80crAlFHXJe8AvdOIKmy0RfhBVvyC354nwqU1DPVO
	 Qk4hOty1lzEI+8Z8rJlBd5gYgnzkNbcopUNNdcTeNqu6mmyGmpn9OdKSRLx77n/ZwU
	 M14pAMfeoMkHTvQAYN/HKHC5kRBph2kVOnI0LGb3G7yeEuKgqzovhWJsgiNOeFVOeq
	 q72j618yJBCOwOZmDejzDW6YmHbQctQZMhH1QSfJngYBnM1A6yVIRyhbraM9CbkfVW
	 de+VdPIddM+TLFGzUDE2VdaQKh3MJv/VqiriATJ/Cu7rlBvtjR4shW6bLljTaO9M5J
	 qZcpDbAoUZ4PQ==
Date: Thu, 9 Apr 2026 21:28:24 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: sashiko@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 2/2] perf build: Add -Wno-missing-declarations for
 GEN_VMLINUX_H=1
Message-ID: <adh8aFYVspZmrLpZ@google.com>
References: <20260408055259.374744-2-namhyung@kernel.org>
 <20260408060017.9F21DC19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408060017.9F21DC19424@smtp.kernel.org>

Hi Sashiko! ;-)

On Wed, Apr 08, 2026 at 06:00:17AM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 1 potential issue(s):
> - [Medium] Suppressing the missing-declarations warning instead of enabling Microsoft extensions causes Clang to silently drop anonymous fields from structures in `vmlinux.h`.
> --
> 
> commit 93aff8b1d8d6d53f0451d4c78852fef0b06314df
> Author: Namhyung Kim <namhyung@kernel.org>
> 
> perf build: Add -Wno-missing-declarations for GEN_VMLINUX_H=1
> 
> This commit suppresses the missing-declarations warning by adding
> -Wno-missing-declarations when compiling BPF skeletons in perf.
> 
> > diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> > --- a/tools/perf/Makefile.perf
> > +++ b/tools/perf/Makefile.perf
> > @@ -1249,7 +1249,7 @@ $(SKEL_TMP_OUT)/%.bpf.o: util/bpf_skel/%.bpf.c $(LIBBPF) $(SKEL_OUT)/vmlinux.h
> >  	$(QUIET_CLANG)$(CLANG) -g -O2 -fno-stack-protector --target=bpf \
> >  	  $(CLANG_OPTIONS) $(EXTRA_BPF_FLAGS) $(BPF_INCLUDE) $(TOOLS_UAPI_INCLUDE) \
> >  	  -include $(OUTPUT)PERF-VERSION-FILE -include util/bpf_skel/perf_version.h \
> > -	  -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> > +	  -Wno-missing-declarations -c $(filter util/bpf_skel/%.bpf.c,$^) -o $@
> 
> Does suppressing this warning instead of enabling Microsoft extensions cause
> Clang to silently drop anonymous fields from structures in vmlinux.h?
> 
> bpftool generates anonymous structs in vmlinux.h using a Microsoft extension.
> Without -fms-extensions, standard C treats these as empty forward declarations.
> Clang ignores them, effectively removing them from the struct layout and
> altering the structure's size and offsets.
> 
> By passing -Wno-missing-declarations instead of enabling the extension, could
> this hide the layout corruption? Any perf BPF programs relying on the size of
> such structs or performing non-CO-RE offset calculations might compute
> incorrect values, leading to verifier rejections or incorrect tracing
> statistics.
> 
> Would it be better to pass -fms-extensions and -Wno-microsoft-anon-tag to
> properly support this in Clang, mirroring the fix applied to BPF selftests in
> commit 835a50753579a?

Oh, it's good to know that there is a fix for that.  For some reason, I
cannot reproduce it anynmore.  But it'd be fine to have this fix anyway.

Thanhks,
Namhyung

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260408055259.374744-1-namhyung@kernel.org?part=2
