Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C660331EA4
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jun 2026 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781072117; cv=none; b=CjBpugLz3BbagdSJ8WFmdTbsGTogtbaDI4ZlPespD//WJX4Bg2fN8SUdhuKYdZkcUHDpiTXbJDkK5mK+cDBA22zCkKPycb7A4GDuWwPBNuvr+znYJts6JDADLgGSMPFKcQXIzNOBXPqBRNPwtPEp3xtOqvSG2MO9L/qEe3akidk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781072117; c=relaxed/simple;
	bh=kaiUqXlDno9VP1YuTlaDnq+T2MOoMyDtOlYA7WJcLvE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CsfyqudFbo3EQrdNXOvesnj4G8mAGUuc217YWq/+vwjYWE4pOvYqMtASBuDBw6Ddldk+ssGNlodsfhhh9NjSJ1V0dz4qX4BWjDTBjrsf3Y9s1SCvwRXNKap5q6Adc8iP6riaRZM/sntxg2XLNEzD+E4XRkfJ66k6DW7HNeT+ZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XgcqAs6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XgcqAs6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7CC1F00893;
	Wed, 10 Jun 2026 06:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781072116;
	bh=lX4mZSrBSaAXhBEPBSvIinY+c8biIFRceGwklWkd+0A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XgcqAs6DCi7KLfrv61nLzipGBsWOXhrHCRIqIMNNHTJRsnPTymg84o1eCcEJB9jLG
	 Liwqkoon3qFUgb68JZTpPbRtb59IwhhHOI0YgJPBZG8bTW/YvLVd/o061ktmdAXD+S
	 5vPXz/cNFeHvjH9/bLQDIepftduxedDiJhGWwLZsiGL0eIQwAtgIBzjexumSRpO+rc
	 bedAogG7YOsvRnBHLd4vDPgt4JKPK6CX2O3HvtQCosEKZd9EFqAmoCfPMdhUt+2xH1
	 /Uul9x4Xq8r6+UGRssP2XrhIN7DuuG/lYf+HaIulpt/EcOMkBZ+27Gyx+7brwmZaIp
	 GxGwZyV493inw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf: arm64: Replace symlink with actual file for
 syscall_64.tbl
Reply-To: sashiko-reviews@lists.linux.dev
To: john.song <john.song@ucloud.cn>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <AHMAuwBaMCb7DmUcFDGOhqrg.1.1781071552750.Hmail.john.song@ucloud.cn>
References: <AHMAuwBaMCb7DmUcFDGOhqrg.1.1781071552750.Hmail.john.song@ucloud.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 06:15:15 +0000
Message-Id: <20260610061516.0F7CC1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch replaces a symlink with a static copy of the arm64 sysca=
ll table, but the provided file is already outdated and disconnected from f=
uture updates. It stops at syscall 469, whereas the kernel's master table (=
`scripts/syscall.tbl`) already contains syscalls 470 (`listns`) and 471 (`r=
seq_slice_yield`). This breaks syscall resolution in `perf trace` for arm64=
. Additionally, this drift will never be reported by `tools/perf/check-head=
ers.sh` because the script incorrectly targets `arch/arm64/entry/syscalls/s=
yscall_64.tbl` for the comparison (a file that does not exist in the upstre=
am kernel). Because the script skips missing files silently, the static tab=
le is completely unmonitored for drift.
--

commit 69ef3e76744219b93b8388736329d8ad87757a55
Author: john.song <john.song@ucloud.cn>

perf: arm64: Replace symlink with actual file for syscall_64.tbl

This patch replaces the symlink to scripts/syscall.tbl with a static copy
of the file for the arm64 architecture. This is intended to fix build
failures in environments where relative symlinks become invalid due to
copying.

> diff --git a/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl b/tools/=
perf/arch/arm64/entry/syscalls/syscall_64.tbl
> deleted file mode 120000
> index 4fdd58f10c155..0000000000000
> --- a/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl
> +++ /dev/null
> @@ -1 +0,0 @@
> -../../../../../scripts/syscall.tbl
> \ No newline at end of file
> diff --git a/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl b/tools/=
perf/arch/arm64/entry/syscalls/syscall_64.tbl
> new file mode 100644
> index 0000000000000..d1ae5e92c615b
> --- /dev/null
> +++ b/tools/perf/arch/arm64/entry/syscalls/syscall_64.tbl
> @@ -0,0 +1,412 @@
[ ... ]
> +466	common	removexattrat			sys_removexattrat
> +467	common	open_tree_attr			sys_open_tree_attr
> +468	common	file_getattr			sys_file_getattr
> +469	common	file_setattr			sys_file_setattr

[Severity: High]
Does replacing the symlink with this static file cause us to silently drop
support for newer syscalls in perf trace?

The static file provided here stops at syscall 469, but the kernel's
master table (scripts/syscall.tbl) already contains syscalls 470 and 471.

Will this drift also go undetected by tools/perf/check-headers.sh? It
appears the sync check currently targets
arch/arm64/entry/syscalls/syscall_64.tbl, which is a nonexistent kernel
path. Since the script silently bypasses missing files, this static table
will remain unmonitored for future drift.

To avoid symlinks without introducing unmonitored drift, should we instead
configure tools/perf/trace/beauty/syscalltbl.sh to read
scripts/syscall.tbl directly for arm64, similar to what is done for
RISC-V?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/AHMAuwBaMCb7DmUcFDG=
Ohqrg.1.1781071552750.Hmail.john.song@ucloud.cn?part=3D1
