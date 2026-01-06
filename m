Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48323334C3E
	for <linux-perf-users@vger.kernel.org>; Tue,  6 Jan 2026 10:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767696897; cv=none; b=WQ+wpL3Lgs2O2+r5r4swgClKmv+QYoGfvMotQcecZSDDQ7acnoDUjPQtsJmBIBNR2IHOHJFBLiqRCv3y+GsIbgUeaM9CNHKcj1bYh6Vb9ky0mlkOSsk3LC+PqDugplL1G/5lI1Vtmx0e5/xdbXOq1gyEcMjYE/en4XXR5bHi9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767696897; c=relaxed/simple;
	bh=aYdFjfxG9nXDOtsLw7U2bKSS7+mqAjt6FhfEdykLhqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEhOk0aOwqQm8cXybmoDE0sPwJg9OypH6Ez+JKezqTHK2ovOf59IVFJxeQn65LU8llM+Cb5Eg266CA6F3+O/pzoiJiwpqYHimbKjNup17kSzKdOYchLJaKcJgIdUkxXx1gnsNhuSZ+rKa7opnh6tovAS1XKi8O+9OPAympa49iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573B5497;
	Tue,  6 Jan 2026 02:54:47 -0800 (PST)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B632D3F5A1;
	Tue,  6 Jan 2026 02:54:53 -0800 (PST)
Date: Tue, 6 Jan 2026 10:54:51 +0000
From: Leo Yan <leo.yan@arm.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, kernel-team@meta.com
Subject: Re: [RFC PATCH] perf/arm64: Add BRBE support for
 bpf_get_branch_snapshot()
Message-ID: <20260106105451.GB336318@e132581.arm.com>
References: <20260102214043.1410242-1-puranjay@kernel.org>
 <CANk7y0j7hAJ7OcH_HgN0cVGnUh=iBz=iuD9sYZmSy-koMjB_cg@mail.gmail.com>
 <20260105212213.GA336318@e132581.arm.com>
 <CANk7y0gb8TM7obqWgaNY3aK_TZLX_nivYEATv2GndN5Ghz1hcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk7y0gb8TM7obqWgaNY3aK_TZLX_nivYEATv2GndN5Ghz1hcQ@mail.gmail.com>

On Mon, Jan 05, 2026 at 09:46:01PM +0000, Puranjay Mohan wrote:

[...]

> Thanks for running the test, it will help me debug it better. But as
> Mark pointer out this has fundamental problems which I will try to fix
> first.

I saw the discussion.  Maybe we can refer to other architecture for
how to resolve the issues.

> P.S. - The test on FVP RevC, does this need special hardware or this
> is an emulation platform, in the later case, can I do the test myself
> somehow?

FVP is an emulation platform, and the best chance is to download
Shrinkwrap tool [1] for access it.  Below are some notes:

- For a FVP with BRBE enabled, I created a addition.yaml:

---8<---

layers:
     - arch/v9.5.yaml

run:
   params:
      -C bp.hostbridge.userNetworking: 1
      -C bp.hostbridge.userNetPorts: 8022=22
      -C cluster0.has_brbe: 1
      -C cluster0.has_brbe_v1p1: 1
      -C cluster1.has_brbe: 1
      -C cluster1.has_brbe_v1p1: 1
   rtvars:
      CMDLINE:
         type: string
         value: console=ttyAMA0 earlycon=pl011,0x1c090000 root=/dev/vda rw ip=dhcp kpti=off

--->8---

- Build firmware for FVP:

  export PATH=/path/to/shrinkwrap:$PATH
  shrinkwrap build --overlay=addition.yaml ns-edk2.yaml

- Build Linux kernel:

  ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make Image arm/fvp-base-revc.dtb

- Run FVP:

  shrinkwrap run -o addition.yaml \
        --rtvar=KERNEL=$KERNEL_PATH/arch/arm64/boot/Image \
        --rtvar=DTB=$KERNEL_PATH/arch/arm64/boot/dts/arm/fvp-base-revc.dtb \
        --rtvar=ROOTFS=debian.img ns-edk2.yaml

You can download a root file system image from [2].  Just note, FVP is
slow so you might need to cross build kernel and eBPF selftest on your
host machine and then mount your host folder onto FVP's /mnt folder,
something like:

  sshfs -o allow_other,default_permissions,reconnect \
      username@host_ip:/path/to/build/folder /mnt

Thanks,
Leo

[1] https://shrinkwrap.docs.arm.com/en/latest/userguide/quickstart.html#
[2] https://releases.linaro.org/debian/images/developer-arm64/debian12/debian.img
