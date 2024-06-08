Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0600B2D05D
	for <linux-perf-users@vger.kernel.org>; Sat,  8 Jun 2024 20:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717879992; cv=none; b=GMfWTe6NXyA5GIo3wYd20CXWXlaaNGHbB3T4HujgO1nj7SMcalZJ2SoIW38ztJcFJmXGSUwelF2Tk+j2hlj4HS+wWaR5SOO8unw7N5FEkwDPzYYJe7cZeY646QVGEZc2jh88bNWU4Zy32s/r+ZTh1fmKvAe2iZixpc7aczTr8Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717879992; c=relaxed/simple;
	bh=aFXbc/Q1w5TrRkxys/vmMluJbLznZtDSeGgct2+dt34=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rrCOG3fYSwv5+1e8fy8X9EcRKZFAVHjr276UiANA0G3byfxcmVD5nh9Sv4Ft0vtChBIuLtIQbUBMuAbO77cereByQNE+ixIlnmFY+NbN+8cAzYHmT5y7/2fdc3CoFR0iLtNNzN3bg09zmStFJn5CZ8vfSoHB7I/b3HACkBUeJog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1E2211FB;
	Sat,  8 Jun 2024 13:53:27 -0700 (PDT)
Received: from [10.2.76.71] (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C2F423F64C;
	Sat,  8 Jun 2024 13:53:02 -0700 (PDT)
Message-ID: <7923023b-2d8a-4d40-963c-45cf07d49127@arm.com>
Date: Sat, 8 Jun 2024 21:53:01 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] perf build: Use pkg-config for feature check for
 libtrace{event,fs}
To: Guilherme Amadio <amadio@gentoo.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
 Ian Rogers <irogers@google.com>
References: <20240606153625.2255470-1-amadio@gentoo.org>
 <20240606153625.2255470-2-amadio@gentoo.org>
 <b914e8b4-c3b3-4809-8708-69b53c25a294@arm.com> <ZmL3T8wACBQNbAmv@gentoo.org>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <ZmL3T8wACBQNbAmv@gentoo.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Guilherme,

On 6/7/24 13:04, Guilherme Amadio wrote:

[...]

>>> Note that in baa2ca59ec1e31ccbe3f24ff0368152b36f68720 the variable
>>> LIBTRACEEVENT_DIR was introduced, and now the method to compile against
>>> non-standard locations requires PKG_CONFIG_PATH to be set instead, which
>>> works for both libtraceevent and libtracefs.
>>
>> Should we advise users to use PKG_CONFIG_LIBDIR or PKG_CONFIG_PATH?
>>
>> When I wrote the patch set [1], at the beginning I also used the env
>> PKG_CONFIG_PATH, but later I think PKG_CONFIG_LIBDIR is better for users
>> for only lib path setting.
> 
> Thank you for the review. The documentation says:
> 
> - PKG_CONFIG_PATH:        List of secondary directories where `.pc' files are looked up.
> - PKG_CONFIG_LIBDIR:      List of primary directories where `.pc' files are looked up.
> - PKG_CONFIG_SYSROOT_DIR: `sysroot' directory, will be prepended to every path defined in PKG_CONFIG_PATH.  Useful for cross compilation.
> 
> So I think what's best depends on what the user is doing. In my case, I
> was not cross-compiling, just using a non-standard location from where
> to pick up the dependencies in /opt. For cross-compilation, using
> PKG_CONFIG_SYSROOT_DIR might make sense instead of either of the other
> two options. I will update the comment accordingly.

Thanks for the info. Just make clear for two things:

Based on my tested result, we cannot only set the PKG_CONFIG_SYSROOT_DIR 
flag for cross compilation. This env variable adds prefix for paths 
defined in PKG_CONFIG_PATH or PKG_CONFIG_LIBDIR.

Your patch shows a good practice - we do not need to set any variables 
for PKG_CONFIG_PATH / PKG_CONFIG_LIBDIR / PKG_CONFIG_SYSROOT_DIR in 
Linux Perf Makefile. These variables should be left to users or the 
build system (e.g. Yocto, Buildroot, etc) to pass.

Below is an example for using the make command:

   PKG_CONFIG_LIBDIR=/usr/lib/pkgconfigs \
   PKG_CONFIG_SYSROOT_DIR=/buildfarm/sysroot \
   make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
   -C tools/perf VF=1


> The other question I have is about other dependencies that use a similar
> style, like capstone, should we also update them in the same way to rely
> on pkg-config?

I think your proposed approach is doable, as it is more neat than 
current code.

But I am not familiar with capstone, other developers may confirm as 
well. At my side, I did a test with below command for building capstone:

   cmake -DCMAKE_INSTALL_PREFIX=/path/for/install ...

The .pc file can dynamically generated to reflect the package's 
installation. So it has a prerequisite - for self-built package, we also 
need to install libs (e.g. make install) so that the path included in 
.pc can match the libs installation path.

Thanks,
Leo
