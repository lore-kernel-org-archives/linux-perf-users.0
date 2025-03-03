Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522931F17E5;
	Mon,  3 Mar 2025 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008338; cv=none; b=rdFiivsY+69s+kCSHn3dLRBTW7M+tHdjk8kSK1I4bvWYnT9V9OZUeRGx57QYdn54jL2GNQpTqERFhAc5p0XGWqXAUomJY+e35tnfEOWvuJXnnN2IIT9BoNn/0iTTTAM2c3AvO+E6tL19gMSwKSHYKySqq0S+CrFUOqEoQ+z3g7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008338; c=relaxed/simple;
	bh=gQhExb7nSOYxgg6O2ogjSb5UxFPDluCYS2cxUIokke0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eS9JcyLEJ8WCtqhPe5DNX/OTzldBOCWpqFa8r3mXpKgpSyeTqsZ0DqnagiUfSBjkK4wkQ/MXCx9MBKLS5D6olr+BxPGlVwNBNc47KFfr0MSk+7S0AE9GP2iSLYmF4ddN9ZmMSJVWLa6DYMX3Yir77ahSw19ClNBZ3r33ObKXuXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Su3Ec0RH; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Su3Ec0RH"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0633E40E01D1;
	Mon,  3 Mar 2025 13:25:34 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w17-rpu0EVU8; Mon,  3 Mar 2025 13:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741008330; bh=UX0gSK5mBKm5X8b/mAYIpVQSMFFkqr+fAzk9PmgEfCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Su3Ec0RHE5acSHA/yBxHnLORM19JzIvRT5U8OeUr2GjDhId8ZyB8RoF02h2ow0JCi
	 k8DnGuxPjgLmE9qeqTnkJUR1BKpfJBDk+fivWj+xrBjywntlkpQ/PHVGAAy7BJmGPT
	 JSV/cuptgL6wflljo0CMR1K4IHI1o0OFjz9efxYeGqGoLZRWuAZlpf/ZzSYhQiKr/a
	 P40V1coe5KMQHixPlh8eEMC1GSzpgW32bdqiFkJa2nIQV0Wu3UzkynTJVXM0MqiL8Z
	 lubzyBjCA6E8oqsKwl+7rpE3Zby3o9Y5ym3ChJoLZ7C2m1geuRiLEMaaUKZWf3dGVd
	 5zpT5vaOPIJ9nDvINdVGm7uuFALwkYkLWxW3WVkK/Ejmf0hyt+T6o5ChU56OZW4+Q1
	 i6o8SrcCxK8fg3BrEDeyxsvpfbIsjNEjrKvvSswgsNn4LD2QVovRTi4rgTk6L8wfiC
	 j0VItzrWzi2CY6tw5xMnN0IaCBVDIKViUm6faWyBAyfZ8NaRblDieYaruoSfif3ReP
	 wid6RAKwKcush3fHenupcFItwvfJwiJpMlmi4RWt/jSrKXNA5AvR6R/1ys5X64kBGv
	 pAuzg64jDTCjyaiFSWBqj/O0RGveFlswpk4KF5MbCrSYXWoreTQ8At+ZblPPbGXiF+
	 wzcQ8LU0gNPZCD59u5gdpjkU=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2974A40E01AD;
	Mon,  3 Mar 2025 13:25:12 +0000 (UTC)
Date: Mon, 3 Mar 2025 14:25:05 +0100
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Aithal, Srikanth" <sraithal@amd.com>, "Xin Li (Intel)" <xin@zytor.com>,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, will@kernel.org, peterz@infradead.org,
	yury.norov@gmail.com, akpm@linux-foundation.org, acme@kernel.org,
	namhyung@kernel.org, brgerst@gmail.com, andrew.cooper3@citrix.com,
	nik.borisov@suse.com
Subject: Re: [PATCH v6 3/5] x86/cpufeatures: Generate a feature mask header
 based on build config
Message-ID: <20250303132505.GEZ8WtsXqFpuMOpDjT@fat_crate.local>
References: <20250228082338.73859-1-xin@zytor.com>
 <20250228082338.73859-4-xin@zytor.com>
 <7c3b4623-45ea-4340-ac47-334071c1d15f@amd.com>
 <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D03DAFD2-5EC9-4D16-BA66-FDA4B51F45DD@zytor.com>

On Mon, Mar 03, 2025 at 04:05:54AM -0800, H. Peter Anvin wrote:
> "make headers" on an unconfigured tree should presumably only produce the uapi headers, not kernel-internal ones, one could surmise?

Well, that's kinda a question for you guys:

cfc7686900a87   (H. Peter Anvin (Intel) 2025-02-28 00:23:36 -0800       281)archheaders: $(out)/$(featuremasks_hdr)
1f57d5d85ba7f   (Ingo Molnar    2015-06-03 18:36:41 +0200       282)    $(Q)$(MAKE) $(build)=arch/x86/entry/syscalls all

and the headers target has

headers: $(version_h) scripts_unifdef uapi-asm-generic archheaders archscripts

as its prereq.

Judging by

59b2bd05f5f4 ("kbuild: add 'headers' target to build up uapi headers in usr/include")

it sure looks like "make headers" should be for uapi headers only.

Oh, and it should be documented in "make help" output btw.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
