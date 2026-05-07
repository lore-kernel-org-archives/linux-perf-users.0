Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF28346A0A
	for <linux-perf-users@vger.kernel.org>; Thu,  7 May 2026 22:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778193334; cv=none; b=bF2+8xCP3JsjAo7LdzC1Ciov5B7hFRjixqjr17oJGc8Emmy+do29GaWSJ86r+ntf5OqkXwscYSfSc7Zy202/xWt88zdMSGek08GscYqrLMZ4J7Giz/uf470fI+SSiJY8kRylp3ITSMQowQgTWhrfNUs/zY1GOgXDgC76LhGvUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778193334; c=relaxed/simple;
	bh=CU12PLYvcdwyTN5wDksFOyJEvYt/YcgZiExIgFch/dc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T9JekK1gSMtkOg6T2H0H9/M1OIRqLkgJkI0K2TdPcHS2qDS4BI+g/uKgv0fArjuSqCYIu9jyO2WerqFRAcgrwndqRqrRGK4t1Mn0jfOFPCs/jdjdmX9wHqNXLbv6euyvGMc9Xh4QgQykGaA1akKxBVjpddLwpioU4y/9u4C4b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjfYL+yG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjfYL+yG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1D38C2BCB2;
	Thu,  7 May 2026 22:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778193334;
	bh=CU12PLYvcdwyTN5wDksFOyJEvYt/YcgZiExIgFch/dc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=MjfYL+yGVp2Y9NkdBhzoF5OrKOxRmnWbPV/JuB6CeL5NdlkfHwXJQAnPHAn7rdNDe
	 o1lPwYxrUUNkFpoI6y+5SGz2NgZ9iiHzPd4vYQTp5wddmtqKLITjEB5VZ767M2g5dw
	 j0IjlOEddo/MffcEAd0RWH0AJ1DC5tcMXlFmokRJzexo9K3imW1nmu7lh0DerqZefj
	 lQHliIvF5EbYiCnVjSDgq2tB/FtC6BN8LKsa2fxr4jnL2ROGt1JhEnvQOOvzQkEkpg
	 kq2McgEEnZa6SFzu1TeoQjVnJVw8FZtQmDOq/rTPcSKgWIpnJOjpS7cniyB5Eh5ums
	 F0k7Sl258NbMQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFT PATCH v2 7/7] perf-iostat: Enable iostat mode for
 HiSilicon PCIe PMU
Reply-To: sashiko@lists.linux.dev
To: "Yushan Wang" <wangyushan12@huawei.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260507063737.3542950-8-wangyushan12@huawei.com>
References: <20260507063737.3542950-8-wangyushan12@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 07 May 2026 22:35:33 +0000
Message-Id: <20260507223533.E1D38C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Use-After-Free and memory leak due to local pointer reassignment o=
f `evlist`.
- [High] Uninitialized variable `ret` returned on specific execution paths.
- [High] Buffer overflow risk due to incorrect size bound `ARG_MAX` in `snp=
rintf`.
- [Medium] Global list duplication and memory leak on repeated parsing.
- [Low] Off-by-one error in `snprintf` truncation check.
--

Note: Due to automated recitation restrictions, this review does not include
inline quotes of the original patch. The findings are summarized below.

commit d8278f9b546336529f0012eecaad3e662cbde173
Author: Yicong Yang <yangyicong@hisilicon.com>

perf-iostat: Enable iostat mode for HiSilicon PCIe PMU

This patch introduces support for the iostat mode on HiSilicon PCIe PMU
devices, allowing measurement of PCIe traffic throughput and latency.
It calculates throughput in MB based on 6 metrics and adds related display
formatting.

In hisi_iostat_prepare(), if the event list already has entries, the code
calls evlist__delete() on it and then allocates a new list with evlist__new=
().
Because the evlist pointer is passed by value, does this reassignment only
modify the local variable? It appears the caller's pointer would not be
updated and would continue to point to the freed memory, causing a
use-after-free, while the newly allocated list is leaked.

In hisi_pcie_root_ports_list_filter(), the local variable ret is declared
without initialization. If the input string is empty or contains only
delimiters, the loop is bypassed. Could this return an uninitialized value?

Similarly, in hisi_iostat_add_events(), if the root ports list is populated
but none of the ports are marked as selected, the list iteration loop skips
execution. Does this also return an uninitialized ret?

In hisi_iostat_add_events(), the iostat_cmd buffer is dynamically allocated
with a size of PATH_MAX. However, the subsequent calls to snprintf use
ARG_MAX - pos - 1 as the maximum length bound. Since ARG_MAX is typically
much larger than PATH_MAX, does this bypass the bounds checking of snprintf
and risk a buffer overflow if the format strings grow?

Looking at hisi_iostat_parse(), it calls hisi_pcie_root_ports_init()
unconditionally, which appends new port structures to the global root ports
list. If the user provides the iostat option multiple times, will this
accumulate duplicate entries in the list, potentially causing memory leaks
and duplicate hardware events?

Finally, in hisi_pcie_root_ports_add(), the length of the formatted sysfs
path is checked to see if it is strictly greater than PATH_MAX. Because
snprintf returns the number of characters that would be written excluding t=
he
null terminator, a return value exactly equal to PATH_MAX means the output
was silently truncated. Should this condition check if the length is greater
than or equal to PATH_MAX to correctly detect truncation?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260507063737.3542=
950-1-wangyushan12@huawei.com?part=3D7
