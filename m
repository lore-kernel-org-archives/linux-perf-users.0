Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413FA41754;
	Sat,  8 Aug 2026 00:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786149998; cv=none; b=m2woLULdeRo8SO/Gk6tXNfFbUjsmGli4GDkctuzBgbiAMKNmRAZMpxewEBzg/OL8AM0fxxpZEnkZRsFjuEbqfM5J2A1UBSfR2x8JXOOF4EM/WCO9u82Pgk0njhEsgNF09lBz2CK9i0D1Z7zdGRKszdHRlgx0XEzTyUZ33IOkE8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786149998; c=relaxed/simple;
	bh=CVo75wucHIhfl8MaScUUyY4muMVgZ3uBkZOP1L+m/ck=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Ym8DwZs67BwPGlaxqo82obcaYccv1hJhagE9Xjwr0AEICgToIa8At5zD8U+rmKQgpf/DgRGm1ZXnYmrKC56hlKq67Vc6FsuIhPNc3MBxTHhUlywhuBw4KFSatmQPyP3gtrddVnMEHO6+lWFpFYGg7bb5xJ7sICpvZyiVZoQBCfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YngxjQG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YngxjQG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C361F000E9;
	Sat,  8 Aug 2026 00:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786149996;
	bh=4pcb26i57LeuHt5V4Rj0cM3d7zYiF7kFZXLg6nSj+tc=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=YngxjQG174bqolPSd5VVVJKFuUnSq7lbjttW3PnYUotyy41tHwIwYHfkuI4GfwBJP
	 kpAaJYx87lgDgvDEF4VNSzCkBVv7LuHDGMeR/4txCMDM6d+PZZbO5eWWgkQYqHlxg8
	 cyPY8aZO3PPh810eLM3NGgHGkYEj8poI7SKqe3gkOvDHRYti/x6c7vu54XPxLLtPxo
	 fZSZg0WWEROxF6hz1i72hYT13yjumpZt2JTJwT8EMT7RcABsQyDXSVKwxAuAq64AmY
	 XKjbQ8F5qd3NqfiHFBnc7PxXMc1ib3+5pXxJm+RWHsE2AOksarItgWOk0InUT6HB/8
	 5WkS8QDRLGTuw==
Date: Fri, 7 Aug 2026 18:46:35 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Xixin Liu <liuxixin@kylinos.cn>
cc: linux-riscv@lists.infradead.org, atish.patra@linux.dev, 
    anup@brainfault.org, will@kernel.org, mark.rutland@arm.com, pjw@kernel.org, 
    palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
    linux-arm-kernel@lists.infradead.org, linux-perf-users@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf: RISC-V: use BIT_ULL for u64 overflow
 masks
In-Reply-To: <prpmask01bitul.1786092600.git.liuxixin@kylinos.cn>
Message-ID: <45bd4156-0209-6aee-e957-24797b4ef115@kernel.org>
References: <cover.1786092600.git.liuxixin@kylinos.cn> <prpmask01bitul.1786092600.git.liuxixin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Fri, 7 Aug 2026, Xixin Liu wrote:

> Overflow status and restart masks are u64, but bits were built with
> BIT(). On RV32 that is an unsigned long shift, so indices >= 32 truncate
> or wrap and corrupt the mask.
> 
> Use BIT_ULL() for those u64 bitops.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>

Thanks for the patch, but, same comments as on

  https://lore.kernel.org/linux-riscv/9109b689-1145-c714-ebe0-ec368f242a78@kernel.org/T/#m6fa97e46bde0d100fa0ec2854d47a57bd271c0b3


- Paul
