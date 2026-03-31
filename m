Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0F38B7C1;
	Tue, 31 Mar 2026 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774984558; cv=none; b=QDRIhwEjsYGy0Q8EHafmH/Af0QoBnqIYN0kR5IeKYoD0vzMnO9y+DBZ3pNVtRtzHX5/sbR3qD+N7aDbmOROIaSmdbZ6MW2u3dE11ICPw6Ui9POFbPEaaF/Zq78hyqa+oeL4JWti2zOZ3nfSqJAhiNJUlYVcehleBjklyEpUQBLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774984558; c=relaxed/simple;
	bh=9keiT+wYloGWb7H0KxQ4pKhd0iX5gNDdO0LEvOhGciw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C07dA1XQepCTfZ3RiYMfmTQMY7fS6et9QrONHVMeffXSvx0kep/7GDLvmKK3EzM48y7O/JSim/fzLbsI68M/ov8YrXZC31pdqYm2UqxrhRjysye4TUeKhOwAqNly6mc9QoTObZZXfMcQgy42umXohC5pIm7vc4zWzA1qQsa2fO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uelw3ott; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uelw3ott"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D5EC19423;
	Tue, 31 Mar 2026 19:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774984558;
	bh=9keiT+wYloGWb7H0KxQ4pKhd0iX5gNDdO0LEvOhGciw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uelw3ottu+R4treAclICSa98yDyr44Tsx7GBLEHir5CBu1zDIzMpDgZAOkEqoIjgs
	 n6XXjqfrlr4+v1u3+JjY+De3cxSbLdPrb9p9pF90t+9EknnbN+mG/J3t/AvVRn2O2l
	 1Dmo4O0g8HT2ian2FLYi6mDSmXoLywzZX08zOfkl3rDsv/6/M6vHf2VQOc0oumo2Sc
	 WMDtKfkg/+B13BWXZEazqHc0zxR41ZcAnghBEdmw8SqKzxBwCg4Fcq0cwl4pxwz5vN
	 AnQyIws1ZcgUS7eI6ytGuTt3QHjhzeHjetPMf3ow1YAY93ca8UFyuNyv8OiZS0Pswd
	 8E1bVkn2zB89w==
Date: Tue, 31 Mar 2026 16:15:54 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: [perf-tools-next:tmp.perf-tools-next 9/10] grep:
 tools/include/uapi/linux/fadvise.h: No such file or directory
Message-ID: <acwdajLKBcDiuk_I@x1>
References: <acu3Qeoy3pRcCrpl@rli9-mobl>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acu3Qeoy3pRcCrpl@rli9-mobl>

On Tue, Mar 31, 2026 at 08:00:01PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.git tmp.perf-tools-next
> head:   02288074fcf09dec98dcb3fefdada4ebb4a91d33
> commit: 7eb9876f1d9fdb6f6a8ed5737452178ca2169205 [9/10] perf beauty: Move copy of fadvise.h from tools/include/ to tools/perf/trace/beauty/include/
> config: arm64-allnoconfig-bpf (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/config)
> compiler: aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260331/202603311011.IoMYrQLJ-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/r/202603311011.IoMYrQLJ-lkp@intel.com/

Since this hasn't touched a non-tmp branch, I'll not add it, i.e. its a
v2.

Thanks anyway, I found and fixed the issue,

- Arnaldo
 
> All errors (new ones prefixed by >>):
> 
>    Makefile.config:576: No elfutils/debuginfod.h found, no debuginfo server support, please install libdebuginfod-dev/elfutils-debuginfod-client-devel or equivalent
>    Makefile.config:963: No libllvm 13+ found, slower source file resolution, please install llvm-devel/llvm-dev
>    Makefile.config:1159: Rust is not found. Test workloads with rust are disabled.
> >> grep: tools/include/uapi/linux/fadvise.h: No such file or directory
>      PERF_VERSION = 7.0.rc4.g7eb9876f1d9f
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
