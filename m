Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3834848C
	for <linux-perf-users@vger.kernel.org>; Fri, 26 Jul 2024 01:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721957828; cv=none; b=aooXhi6tu8LxggIu9Kd7K+fKOk7n/r8PfoZi/m8MdKm2D+Ov9vZRqC/prZO1r6TTXHHqePeXeGByeB4BOknfnolKuqjcTei7IURN6QGT4ODC25a4iQJTFAj9QDBn/yDjutOSKZWojMlIPHw3yx29TIObKjbZ0pFDWvW5XGIvmao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721957828; c=relaxed/simple;
	bh=HZeRnqI2Oykvkscalx44mKgfPrQPrVekU+bCX9hL5Yg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y9H0KNc9UFMdEGWssW/x80JhX39YZmZbEV4rDvNa8X0FdItoqTaVj9YDglWXV7iXNwd4PuyeruJ4PSWHkJpJ3yhVnx7qRQznJq5Xjzz+v4FLLRzmj8y9umo54Oo9ShBZRsmhxkF5hNXC/FYvotdeUGAXAfgUWUWk5zaL1sTNUD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UD51IBLU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UD51IBLU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63472C116B1;
	Fri, 26 Jul 2024 01:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721957827;
	bh=HZeRnqI2Oykvkscalx44mKgfPrQPrVekU+bCX9hL5Yg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UD51IBLUgUSi0SlQd/gd/7JvswvEUkyslNSavzcnwdIlTPt9k7M0HDTIsspVELRaB
	 vJG381hwGDTTyKfONhK3Zi7dOnlPeEF1wwIUJ3SvCDU2qGs9tr5n+rlQ+kV4h4c2sE
	 MBjJmW3HjSdzmNlaClWjP0SXCxZXEMC/7LWYnkVrnspIf7M8xodhEpSMvDFBhnmVyE
	 jj+DNuJqW8DVaCc3L5AE4qavu2puk3F4VzkuZeJPTEljqtOv0cpETGr3/C6+K8mZLX
	 ym3B44YNps1BEwEwVWi8rMJ1JbJMPVEBGoPBOL8wUdGZd9MgzOkDVUHxFyzkEPuuVi
	 fD456o8XEOKwg==
Date: Thu, 25 Jul 2024 18:37:05 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: =?utf-8?B?5ZC06Zuo6JaH?= <wuyuwei221@mails.ucas.ac.cn>
Cc: linux-perf-users@vger.kernel.org,
	=?utf-8?B?5LqO5L2z6ICV6ICB5biI?= <jiageng08@iscas.ac.cn>,
	shenzhengdong23@mails.ucas.ac.cn
Subject: Re: Kernel functions showing only addresses in `perf` output
Message-ID: <ZqL9wWR20aaSB5vq@google.com>
References: <4928374a.92fe.190e4705e87.Coremail.wuyuwei221@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4928374a.92fe.190e4705e87.Coremail.wuyuwei221@mails.ucas.ac.cn>

Hello,

On Wed, Jul 24, 2024 at 07:11:27PM +0800, 吴雨薇 wrote:
> Kernel functions are only showing addresses and not symbols in the sampling output from the `perf` tool.
> 
> Environment Information
> - Hardware: SG2042
> - OS Version: openEuler 23.09
> - Kernel Version: Linux openeuler-riscv64 6.6.0+ #1 SMP Wed Apr 3 15:53:06 CST 2024 riscv64 riscv64 riscv64 GNU/Linux
> - Perf Version: 6.6.g04f0a6491967
> - Kernel Compilation Options:
> The following kernel configuration options have been enabled:
> CONFIG_PERF_EVENTS
> CONFIG_KALLSYMS
> CONFIG_KALLSYMS_ALL
> CONFIG_FRAME_POINTER
> CONFIG_STACKTRACE
> CONFIG_DEBUG_INFO
> 
> CONFIG_DEBUG_KERNEL
> 
> 
> 
> Steps to Reproduce
> 
> 1. Download Kernel Source Code:
>    Clone the kernel source code repository on the Lichee Pi 4A board
> 
> 2. Install Dependencies:
>    Install all necessary development libraries and tools required by `perf`:
>    sudo yum install elfutils-libelf-devel -y
>    sudo yum install perl-devel -y
>    sudo yum install numactl-devel -y
>    sudo yum install libbabeltrace-devel -y
>    sudo yum install binutils-devel -y
>    sudo yum install genwqe-zlib-static -y
>    sudo yum install elfutils-devel -y
>    sudo yum install slang-devel -y
>    sudo yum install zstd-devel -y
>    sudo yum install xz-devel -y
>    sudo yum install libcap-devel -y
>    sudo yum install audit-devel audit-libs -y
>    sudo yum install openssl-devel -y
>    sudo yum install gtk2-devel -y
>    sudo yum install systemtap-sdt-devel -y
>    sudo yum install libtraceevent-devel -y
>    sudo yum install libpfm -y
>    sudo yum install ncurses-devel -y
>    sudo yum install java-1.8.0-openjdk-devel -y
> 
> 3. Compile `perf`:
>    cd riscv-kernel/tools/perf
>    make ARCH=riscv WERROR=0 -j4
> 
> 4. Install `perf`:
>    sudo cp ./perf /usr/bin/
> 
> 5. Download `hackbench`
> 
> 6. Compile `hackbench`:
>    gcc -static -O0 -g -fno-omit-frame-pointer hackbench.c -o hackbench -lpthread
> 
> 7. Run Tests with `perf`:
>    Record performance data with `perf` and generate the report:
>    sudo perf record -e cpu-cycles -g ./hackbench
>    sudo perf report --no-children -G &gt; perf_hackbench.txt
> 
> 
> Issue
> In the `perf_hackbench.txt` output, you can see that kernel functions show addresses, while user mode functions show function symbol names
> 96.22%  hackbench  [unknown]          [k] 0xffffffff80cfb2ac
> 
> Potential Cause：
> It seems that `perf` might be failing to resolve addresses to symbols because it cannot find the addresses in `/proc/kallsyms`.

Can you please run `perf script --show-mmap-events` ?
I'd like to see if it has proper mappings in the data file.

Thanks,
Namhyung

