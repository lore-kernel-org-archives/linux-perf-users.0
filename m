Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9101838AC8C
	for <linux-perf-users@vger.kernel.org>; Sat,  3 Oct 2026 01:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790991261; cv=none; b=J8/lPx+JJRFLHix+TVjalh6gsc5mCgQSUaWdSxLf1H37DeQ0C/ehhufrcrQrN34yXTtt+sG6goT8CKhuMZAMDeYO7smnA64nvlzqyl6z4S89UyuzFhGvW6E4tKSqsAfLQ92bknzFrgyLe2meeG7Ziwmg6kFcBuPvqqFHJgOydxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790991261; c=relaxed/simple;
	bh=1ccOS2F/VXDXwJuilVPv/YQaM+C5x1IG5tkOGzzA53I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bqfsBDm5ca8svYf+Zhfysd93O2HGT/iv0StikfuVDe7mU46cLtPwtFRl+spzluFIfF7VkGPiUE1aCoFVGzng6MUFDm1S10Gej4I5rYrGcIk4lhBQYgXICQS0ThKlYDx2cRrtcmDyn07gZGPTQxoK3M3l0YXB91ySE+5Q1fL+O2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5UWhAYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5UWhAYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 572481F00898;
	Sat,  3 Oct 2026 01:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790991259;
	bh=1ccOS2F/VXDXwJuilVPv/YQaM+C5x1IG5tkOGzzA53I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j5UWhAYmRO3uY6js4ymKdb9RImXxcn3cbnyCdEULWtdgZuyUiX9Q/qjuxpTokGe1H
	 dmb8JwKAOCF75JY/C+DvjuAdzfxQxOYMdVunGxlFKajJ/SMmpDPfZxxRLvXqyWmXvQ
	 36dgOMmxi5RQyKQl7ZLiFWqGAr7jlKWyetHdgCs5Ugj8cUqrEhVK6evYRstTobM2Fy
	 nAwgPvzruZnpWtYeRiGGzlqeQUxSwCACCwa+mFFYaWN7B1D7iwpdW4/uywN9CW+JSy
	 Nq3gyqjqXzIR2WmFSS3DxRyqvakO87FFH8Yg+FbQUmqKCitheyHwrfx6M28EQ6Uohn
	 8CeSqujF/7qOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] perf dwarf-aux: Check .eh_frame section for CFA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261002224242.396135-1-namhyung@kernel.org>
References: <20261002224242.396135-1-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 01:34:18 +0000
Message-Id: <20261003013419.572481F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] perf: memory leak of Dwarf_CFI handle in die_get_cfa()
- [Medium] perf: severe performance degradation from repeatedly parsing .eh=
_frame
--

commit 63cd38e63157cedd873e0aa6adbf63746489d27e
Author: Namhyung Kim <namhyung@kernel.org>

perf dwarf-aux: Check .eh_frame section for CFA

This commit modifies die_get_cfa() to first attempt to retrieve the
.eh_frame section using dwarf_getcfi_elf() before falling back to the
.debug_frame section.

[Severity: Medium]
Does this code leak the dynamically allocated Dwarf_CFI object?

In tools/perf/util/dwarf-aux.c within die_get_cfa(), dwarf_getcfi_elf() is
called to get the .eh_frame section. Unlike dwarf_getcfi(), which returns a
structure owned by the Dwarf context, dwarf_getcfi_elf() allocates a new
Dwarf_CFI object that the caller must free using dwarf_cfi_end().

However, die_get_cfa() returns without freeing the cfi pointer on both the
success path and the error path. Since this function is called repeatedly
during data annotation, could this lead to rapid memory consumption?

[Severity: Medium]
Is there a risk of severe performance degradation here?

Calling dwarf_getcfi_elf() reads and parses the .eh_frame section to
dynamically build a search index for the module. Because die_get_cfa() is a
heavily utilized helper function often called repeatedly, rebuilding this
index and allocating the structures from scratch on every single invocation
could cause massive CPU overhead.

Would it be possible to cache the .eh_frame Dwarf_CFI object to avoid
rebuilding it on every call?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002224242.3961=
35-1-namhyung@kernel.org?part=3D1
