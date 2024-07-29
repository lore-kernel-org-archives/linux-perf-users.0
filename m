Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9569257B
	for <linux-perf-users@vger.kernel.org>; Mon, 29 Jul 2024 01:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722216880; cv=none; b=pMurtuOIq2VDBw80Nhb2fy0dLP/NUcdRmu4xsucAF5eJ0CmYgtbOy9RysmmVB8NzBJ+BE1dzB9Tm7L6DBYMPeUtXLRwZucl38KrIrp46jBAFKODuWNufG7pZs0/nSGNqMt6SOZQRSVsUxfxdUKqDch17SlzYmAHjq9ehc2l8uKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722216880; c=relaxed/simple;
	bh=YtYx6bmyhbukYBlsLpqZ28V53O5srHC4878KMVYpJTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQSQgZP4vysXmebBHZJqFaitUTUqAIaXv4SsONU+Tkkx0nhTuhJp8Gq/RwzqlS5O9iyzqrZbgU5wp/IsnFpIDrOumCeAPwrjmx8WbMceXroZiWspV65jKcia8zCkVC4Kd6Bx/tGt340jzvFy8lS9htFPhLb+MfpRIpzxeNq/+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KuAq+5Il; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KuAq+5Il"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C504C116B1;
	Mon, 29 Jul 2024 01:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722216880;
	bh=YtYx6bmyhbukYBlsLpqZ28V53O5srHC4878KMVYpJTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuAq+5Il29hJkZ+iJasWyvyeskwjoUKK93Rc7j7jAovxdjgLFjIKiNL823tWZktsv
	 3qe5I8zqAvYp6UXcmmIVIXqE79c/dv4zuWThf93gXAeqQ4fTmSjO/el/Gd/rtjx1mM
	 3QlUWGclTPCoUnWdtziqRG4jWznB80fU1Wykfj/SVQK6JjefQPoh/YnwJbfe51hKau
	 FjiyB6pDmdamkcUPGMZwlKxdBqgJFXcj9Cx3+X9WNuiKjee8v84ac8pa72NyVcuUdc
	 jIbGsWBuIIUvJ3tBIQlluexQUamPVfrJ6v9Yd5hw9SrIT4ATC1KeivojZcBMPGI/Pc
	 s+ob3z1TWN2gw==
Date: Sun, 28 Jul 2024 18:34:38 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: =?utf-8?B?5rKI6YOR5Lic?= <shenzhengdong23@mails.ucas.ac.cn>
Cc: =?utf-8?B?5ZC06Zuo6JaH?= <wuyuwei221@mails.ucas.ac.cn>,
	linux-perf-users@vger.kernel.org,
	=?utf-8?B?5LqO5L2z6ICV6ICB5biI?= <jiageng08@iscas.ac.cn>,
	yangwang@iscas.ac.cn
Subject: Re: Re: Kernel functions showing only addresses in `perf` output
Message-ID: <Zqbxrpnt_7wZoscu@google.com>
References: <4928374a.92fe.190e4705e87.Coremail.wuyuwei221@mails.ucas.ac.cn>
 <ZqL9wWR20aaSB5vq@google.com>
 <5dfad01b.be01.190ecf305c3.Coremail.shenzhengdong23@mails.ucas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5dfad01b.be01.190ecf305c3.Coremail.shenzhengdong23@mails.ucas.ac.cn>

On Fri, Jul 26, 2024 at 10:51:08AM +0800, 沈郑东 wrote:
> 
> 
> 
> &gt; -----原始邮件-----
> &gt; 发件人: "Namhyung Kim" <namhyung@kernel.org>
> &gt; 发送时间: 2024-07-26 09:37:05 (星期五)
> &gt; 收件人: 吴雨薇 <wuyuwei221@mails.ucas.ac.cn>
> &gt; 抄送: linux-perf-users@vger.kernel.org, 于佳耕老师 <jiageng08@iscas.ac.cn>, shenzhengdong23@mails.ucas.ac.cn
> &gt; 主题: Re: Kernel functions showing only addresses in `perf` output
> &gt; 
> &gt; Hello,
> &gt; 
> &gt; On Wed, Jul 24, 2024 at 07:11:27PM +0800, 吴雨薇 wrote:
> &gt; &gt; Kernel functions are only showing addresses and not symbols in the sampling output from the `perf` tool.
> &gt; &gt; 
> &gt; &gt; Environment Information
> &gt; &gt; - Hardware: SG2042
> &gt; &gt; - OS Version: openEuler 23.09
> &gt; &gt; - Kernel Version: Linux openeuler-riscv64 6.6.0+ #1 SMP Wed Apr 3 15:53:06 CST 2024 riscv64 riscv64 riscv64 GNU/Linux
> &gt; &gt; - Perf Version: 6.6.g04f0a6491967
> &gt; &gt; - Kernel Compilation Options:
> &gt; &gt; The following kernel configuration options have been enabled:
> &gt; &gt; CONFIG_PERF_EVENTS
> &gt; &gt; CONFIG_KALLSYMS
> &gt; &gt; CONFIG_KALLSYMS_ALL
> &gt; &gt; CONFIG_FRAME_POINTER
> &gt; &gt; CONFIG_STACKTRACE
> &gt; &gt; CONFIG_DEBUG_INFO
> &gt; &gt; 
> &gt; &gt; CONFIG_DEBUG_KERNEL
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; Steps to Reproduce
> &gt; &gt; 
> &gt; &gt; 1. Download Kernel Source Code:
> &gt; &gt;    Clone the kernel source code repository on the Lichee Pi 4A board
> &gt; &gt; 
> &gt; &gt; 2. Install Dependencies:
> &gt; &gt;    Install all necessary development libraries and tools required by `perf`:
> &gt; &gt;    sudo yum install elfutils-libelf-devel -y
> &gt; &gt;    sudo yum install perl-devel -y
> &gt; &gt;    sudo yum install numactl-devel -y
> &gt; &gt;    sudo yum install libbabeltrace-devel -y
> &gt; &gt;    sudo yum install binutils-devel -y
> &gt; &gt;    sudo yum install genwqe-zlib-static -y
> &gt; &gt;    sudo yum install elfutils-devel -y
> &gt; &gt;    sudo yum install slang-devel -y
> &gt; &gt;    sudo yum install zstd-devel -y
> &gt; &gt;    sudo yum install xz-devel -y
> &gt; &gt;    sudo yum install libcap-devel -y
> &gt; &gt;    sudo yum install audit-devel audit-libs -y
> &gt; &gt;    sudo yum install openssl-devel -y
> &gt; &gt;    sudo yum install gtk2-devel -y
> &gt; &gt;    sudo yum install systemtap-sdt-devel -y
> &gt; &gt;    sudo yum install libtraceevent-devel -y
> &gt; &gt;    sudo yum install libpfm -y
> &gt; &gt;    sudo yum install ncurses-devel -y
> &gt; &gt;    sudo yum install java-1.8.0-openjdk-devel -y
> &gt; &gt; 
> &gt; &gt; 3. Compile `perf`:
> &gt; &gt;    cd riscv-kernel/tools/perf
> &gt; &gt;    make ARCH=riscv WERROR=0 -j4
> &gt; &gt; 
> &gt; &gt; 4. Install `perf`:
> &gt; &gt;    sudo cp ./perf /usr/bin/
> &gt; &gt; 
> &gt; &gt; 5. Download `hackbench`
> &gt; &gt; 
> &gt; &gt; 6. Compile `hackbench`:
> &gt; &gt;    gcc -static -O0 -g -fno-omit-frame-pointer hackbench.c -o hackbench -lpthread
> &gt; &gt; 
> &gt; &gt; 7. Run Tests with `perf`:
> &gt; &gt;    Record performance data with `perf` and generate the report:
> &gt; &gt;    sudo perf record -e cpu-cycles -g ./hackbench
> &gt; &gt;    sudo perf report --no-children -G &gt; perf_hackbench.txt
> &gt; &gt; 
> &gt; &gt; 
> &gt; &gt; Issue
> &gt; &gt; In the `perf_hackbench.txt` output, you can see that kernel functions show addresses, while user mode functions show function symbol names
> &gt; &gt; 96.22%  hackbench  [unknown]          [k] 0xffffffff80cfb2ac
> &gt; &gt; 
> &gt; &gt; Potential Cause：
> &gt; &gt; It seems that `perf` might be failing to resolve addresses to symbols because it cannot find the addresses in `/proc/kallsyms`.
> &gt; 
> &gt; Can you please run `perf script --show-mmap-events` ?
> &gt; I'd like to see if it has proper mappings in the data file.
> &gt; 
> &gt; Thanks,
> &gt; Namhyung
> Hello, I have run 'perf script --show-mmap-eventd' again. The results are attached.

Thanks, I saw the first few lines are like below:

swapper       0     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffff80002000(0x2570600) @ 0xffffffff80002000]: x [kernel.kallsyms]_text
swapper       0     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffff029d7000(0x1e000) @ 0]: x /lib/modules/6.6.0-27.0.0.31.oe2403.riscv64/kernel/net/netfilter/nfnetlink.ko.xz
swapper       0     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffff029f8000(0x185000) @ 0]: x /lib/modules/6.6.0-27.0.0.31.oe2403.riscv64/kernel/fs/fuse/fuse.ko.xz
swapper       0     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffff02b81000(0x18000) @ 0]: x /lib/modules/6.6.0-27.0.0.31.oe2403.riscv64/kernel/drivers/uio/uio.ko.xz
swapper       0     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffff02b99000(0x9000) @ 0]: x /lib/modules/6.6.0-27.0.0.31.oe2403.riscv64/kernel/drivers/uio/uio_pdrv_genirq.ko.xz
swapper       0     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffff02b9e000(0x25000) @ 0]: x /lib/modules/6.6.0-27.0.0.31.oe2403.riscv64/kernel/drivers/rtc/rtc-ds1307.ko.xz
...

It looks good, so lines like below should find the [kernel.kallsyms]
mapping.

     0.29%  hackbench  [unknown]          [k] 0xffffffff800555c0
     0.07%  hackbench  [unknown]          [k] 0xffffffff80cfc74c
     0.06%  hackbench  [unknown]          [k] 0xffffffff802afde8
     0.06%  hackbench  [unknown]          [k] 0xffffffff80cfafbe
     0.05%  hackbench  [unknown]          [k] 0xffffffff802d8a36

Maybe it's because the module addresses are below the kernel mapping and
IIRC ARM had a similar issue and we have the fix now.  Have you tried
the latest version of perf tool?  I guess you just used v6.6..

Thanks,
Namhyung

