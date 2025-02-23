Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE11FC3;
	Sun, 23 Feb 2025 10:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740306476; cv=none; b=LrsVbajKcSlQIqNecIVDCPmx34YrGjpHcNIfEtYEf4MsrI7S5WKXtajyixiHqsy1zL+OAkfgGZtt3XWPF0pZo3/SmXv2OGfraR8OzR9sHTQr1zwxHSCDW2c/DSMqt9Uzq9sfKOViw/DFYrvJsxFEGgkEsjlVAzO6TNm/EwWbntA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740306476; c=relaxed/simple;
	bh=YCr+PXOAVC+4yizPVskUfSZeUBP52WZFQiOwVxjfWqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ICOS/rrr+Lj1rSTue5HaLr81DmsUGTrU/keOMCREXh6qPfErXBeSr2TKvVBYZquOEbAJnPYuzs04FCZ/JRHROAo0ieuFkOmekjbzIXXdOG6N4xDiNb0yQDslSoNGATv805DJQH5M9aEX33+bDpteMrbqHmJg45s3vhtCu7pmzUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=jCzBDk1A; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="jCzBDk1A"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7550F40E0176;
	Sun, 23 Feb 2025 10:27:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 64ugc_ezh1-Y; Sun, 23 Feb 2025 10:27:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1740306466; bh=Th8uIhRsScOvJKzwoZ4/oH5GbGZwgAt9CDdJXdgol48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCzBDk1ARhr1DOyUebXYGa3AtG6jnVI7Cv1z9tc5iVAMnrJpd/I6WiY84HV6zvDYm
	 Yav0Bw5c4sEdgjsFGJAGUP12ts9vBeUE25C/naHF18TxW59U7BSW3yNEuvAcFvHT2h
	 6fQN/qje5Iej+qxbwMXW4Yrbd7HgN1aAXHtYn6oMp4przYxXmQxnhUbn/7+mrxSA8t
	 aZ4RGyM+C8wjk6LPaSEuPRWf0Z5gPaEGX5sNHHf8Z4wa+SnTNyx1/uktZNNAkERIxn
	 AWhTR/f1P2zXDRTUi5TMfeqnuOZ/8uQGY7V49i/LsPketySS/Ea+p9YTghfVBHl0ah
	 AhlemiRr1DFl7D10V8EMBISuEeqcvF1PHkO0ah3TzWN3NWvYBCt/xZqMyo/fkEOC8p
	 spVjlEkvnh+S1g6hhQMDsgUHzPqM8C0sBVMUpHFNw2Vrq2Y+NIptjlDPDQ9SYGa+mS
	 6EWrOZNoGZR32aKek229v4ks4SrRGX2BP4+MqqZWVFIT2ZTvnxLdZ5vbs6gNdoyGi5
	 2siTBWo5dWHrCo7LJ7Isw4/4JSozvZ71COAxhQCyJR+bgdoOdiUMXN638r9R+o42Ka
	 /KxO0odpA+uIqH/lvmrvLh/3KnbCVMKcBj4wg9MVO5Tmed7e37wOAqrbE8yx+Dhcir
	 qhR+rjXmQK9VqiLjuqFpS1rA=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23E5840E015D;
	Sun, 23 Feb 2025 10:27:29 +0000 (UTC)
Date: Sun, 23 Feb 2025 11:27:23 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Xin Li (Intel)" <xin@zytor.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, will@kernel.org,
	peterz@infradead.org, yury.norov@gmail.com,
	akpm@linux-foundation.org, acme@kernel.org, namhyung@kernel.org,
	brgerst@gmail.com, andrew.cooper3@citrix.com, nik.borisov@suse.com
Subject: Re: [PATCH v5 0/5] x86/cpufeatures: Automatically generate required
 and disabled feature masks
Message-ID: <20250223102723.GAZ7r4C7C6sTUnbe4I@fat_crate.local>
References: <20250106070727.3211006-1-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250106070727.3211006-1-xin@zytor.com>

On Sun, Jan 05, 2025 at 11:07:22PM -0800, Xin Li (Intel) wrote:
>  arch/x86/Kconfig                              |   4 +-
>  arch/x86/Kconfig.cpu                          |  12 +-
>  arch/x86/Kconfig.cpufeatures                  | 197 ++++++++++++++++++
>  arch/x86/Makefile                             |  17 +-
>  arch/x86/boot/cpucheck.c                      |   3 +-
>  arch/x86/boot/cpuflags.c                      |   1 -
>  arch/x86/boot/mkcpustr.c                      |   3 +-
>  arch/x86/include/asm/Kbuild                   |   1 +
>  arch/x86/include/asm/asm-prototypes.h         |   2 +-
>  arch/x86/include/asm/atomic64_32.h            |   2 +-
>  arch/x86/include/asm/bitops.h                 |   4 +-
>  arch/x86/include/asm/cmpxchg_32.h             |   2 +-
>  arch/x86/include/asm/cpufeature.h             |  71 +------
>  arch/x86/include/asm/cpufeatures.h            |  13 +-
>  arch/x86/include/asm/disabled-features.h      | 161 --------------
>  arch/x86/include/asm/required-features.h      | 105 ----------
>  arch/x86/kernel/cpu/common.c                  |   1 +
>  arch/x86/kernel/verify_cpu.S                  |   4 +
>  arch/x86/lib/Makefile                         |   2 +-
>  arch/x86/lib/cmpxchg8b_emu.S                  |   2 +-
>  arch/x86/tools/featuremasks.awk               |  88 ++++++++
>  lib/atomic64_test.c                           |   2 +-
>  tools/arch/x86/include/asm/cpufeatures.h      |   8 -
>  .../arch/x86/include/asm/disabled-features.h  | 161 --------------
>  .../arch/x86/include/asm/required-features.h  | 105 ----------
>  tools/perf/check-headers.sh                   |   2 -
>  26 files changed, 327 insertions(+), 646 deletions(-)
>  create mode 100644 arch/x86/Kconfig.cpufeatures
>  delete mode 100644 arch/x86/include/asm/disabled-features.h
>  delete mode 100644 arch/x86/include/asm/required-features.h
>  create mode 100755 arch/x86/tools/featuremasks.awk
>  delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
>  delete mode 100644 tools/arch/x86/include/asm/required-features.h

make --no-print-directory -C /home/kernel/linux \
-f /home/kernel/linux/Makefile 
# GEN     arch/x86/include/generated/asm/orc_hash.h
  mkdir -p arch/x86/include/generated/asm/; sh ./scripts/orc_hash.sh < arch/x86/include/asm/orc_types.h > arch/x86/include/generated/asm/orc_hash.h
make -f ./scripts/Makefile.build obj=scripts/basic
set -e; mkdir -p include/config/; trap "rm -f include/config/.tmp_kernel.release" EXIT; { ./scripts/setlocalversion .; } > include/config/.tmp_kernel.release; if [ ! -r include/config/kernel.release ] || ! cmp -s include/config/kernel.release include/config/.tmp_kernel.release; then : '  UPD     include/config/kernel.release'; mv -f include/config/.tmp_kernel.release include/config/kernel.release; fi
# GEN     arch/x86/include/generated/asm/featuremasks.h
  awk -f ./arch/x86/tools/featuremasks.awk ./arch/x86/include/asm/cpufeatures.h .config > arch/x86/include/generated/asm/featuremasks.h
make -f ./scripts/Makefile.asm-headers obj=arch/x86/include/generated/uapi/asm \
generic=include/uapi/asm-generic
awk: ./arch/x86/tools/featuremasks.awk: line 16: syntax error at or near {
awk: ./arch/x86/tools/featuremasks.awk: line 20: syntax error at or near :
awk: ./arch/x86/tools/featuremasks.awk: line 24: syntax error at or near }
make[1]: *** [arch/x86/Makefile:285: arch/x86/include/generated/asm/featuremasks.h] Error 2
make[1]: *** Deleting file 'arch/x86/include/generated/asm/featuremasks.h'
make[1]: *** Waiting for unfinished jobs....
# WRAP    arch/x86/include/generated/uapi/asm/bpf_perf_event.h
  echo "#include <asm-generic/bpf_perf_event.h>" > arch/x86/include/generated/uapi/asm/bpf_perf_event.h
# WRAP    arch/x86/include/generated/uapi/asm/fcntl.h
  echo "#include <asm-generic/fcntl.h>" > arch/x86/include/generated/uapi/asm/fcntl.h
# WRAP    arch/x86/include/generated/uapi/asm/errno.h
  echo "#include <asm-generic/errno.h>" > arch/x86/include/generated/uapi/asm/errno.h
# WRAP    arch/x86/include/generated/uapi/asm/ioctl.h
  echo "#include <asm-generic/ioctl.h>" > arch/x86/include/generated/uapi/asm/ioctl.h
# WRAP    arch/x86/include/generated/uapi/asm/ioctls.h
  echo "#include <asm-generic/ioctls.h>" > arch/x86/include/generated/uapi/asm/ioctls.h
# WRAP    arch/x86/include/generated/uapi/asm/ipcbuf.h
  echo "#include <asm-generic/ipcbuf.h>" > arch/x86/include/generated/uapi/asm/ipcbuf.h
# WRAP    arch/x86/include/generated/uapi/asm/param.h
  echo "#include <asm-generic/param.h>" > arch/x86/include/generated/uapi/asm/param.h
# WRAP    arch/x86/include/generated/uapi/asm/poll.h
  echo "#include <asm-generic/poll.h>" > arch/x86/include/generated/uapi/asm/poll.h
# WRAP    arch/x86/include/generated/uapi/asm/resource.h
  echo "#include <asm-generic/resource.h>" > arch/x86/include/generated/uapi/asm/resource.h
# WRAP    arch/x86/include/generated/uapi/asm/socket.h
  echo "#include <asm-generic/socket.h>" > arch/x86/include/generated/uapi/asm/socket.h
# WRAP    arch/x86/include/generated/uapi/asm/sockios.h
  echo "#include <asm-generic/sockios.h>" > arch/x86/include/generated/uapi/asm/sockios.h
# WRAP    arch/x86/include/generated/uapi/asm/termbits.h
  echo "#include <asm-generic/termbits.h>" > arch/x86/include/generated/uapi/asm/termbits.h
# WRAP    arch/x86/include/generated/uapi/asm/termios.h
  echo "#include <asm-generic/termios.h>" > arch/x86/include/generated/uapi/asm/termios.h
# WRAP    arch/x86/include/generated/uapi/asm/types.h
  echo "#include <asm-generic/types.h>" > arch/x86/include/generated/uapi/asm/types.h
make: *** [Makefile:251: __sub-make] Error 2

Probably due to:

$ awk --version
mawk 1.3.4 20250131
Copyright 2008-2024,2025, Thomas E. Dickey
Copyright 1991-1996,2014, Michael D. Brennan

random-funcs:       srandom/random
regex-funcs:        internal

compiled limits:
sprintf buffer      8192
maximum-integer     9223372036854775808

while the other box has GNU awk where it obviously works.

HTH.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
