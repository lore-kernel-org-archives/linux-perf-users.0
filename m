Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793381262;
	b=W9HwbSNRWLmm+TGehkMZbzYQ06E12d2jXjp1ZP5JPYw6z0lmSCUjfjiiBSlBiYUeKLdb
	 Xn15w8Hu5kmS4yYQhgNlsFsrr4nrH24gZYa+Lc+fXIbssIIJptQdFb4E+6aliciJpnlM/
	 nS2gMurgEfy0TnBTRmvNJjJMzfHsBc4stmJ1KaQ4E7goFajR1OA2tNdgdpkraF3nYz59y
	 xnI2hz2MKr3bPuQgzAh4SZgNEoLlEIVoptuen6AHtmomZQqvN9We7FBEB/hlmUGElX+k+
	 +k6L+8vZJHk9AYuZ6Ku8f2Zsat0EbjylyhtEoAjr8lq8xo1sEE7BRxg9RgYXZHhrrJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793381262;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=nF+Ovb1DaVGHZAK78t1+T+vvQXvmw97Ih5mhvZvtfOQ=;
	b=BeCngoeCeFCNyeZuwB8D/H0JCWpMOH5Px4nPILeS3DXCf6DiLMUI2sC6xYeg/V2GX24Y
	 7upj/B8tfS/A++6RDkIQYOoUIMu4JLMyJuiIzJdcs8mGQEABb2qlyUa65+mfbfhyhfWYB
	 ZdnTvOi7Z74G61Gr7FGEOqtbKlm11k0pWSCaaX9Xsnc+RL108Nb81ZpvDI4IxVFC/JiOG
	 DNZTqp5PIyUlL39RhtS555GN6LWUUlGbGseRghUg5bYzQvuqJ0YN1qflnrLvcDRlV2yhf
	 rHMmlhEQ6O974CZEs3TNxYi4oNM4Yq/F5B+8BVF+tKeeGOtt80A0769AvPMtW6+gjpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SSZic7En;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116C606A31C
	for <linux-perf-users@vger.kernel.org>; Fri, 30 Oct 2026 17:27:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7116C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=SSZic7En
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 839C61682;
	Fri, 30 Oct 2026 10:27:32 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DECA3F59E;
	Fri, 30 Oct 2026 10:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793381255; bh=nF+Ovb1DaVGHZAK78t1+T+vvQXvmw97Ih5mhvZvtfOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSZic7EniiYh1wLv2mllab378dzok0A7Y6dAyNcct1O40S5T5Lez5xujSFU7yX1oC
	 0GknB7o9jxxYmpe18wzEQkYuLBCL33Ak3rfiWG5HTwLaAqwWDypFCXXJLuOeQdvoEa
	 G8Je3VllMn3eYaPn1Po63+Ny7abDcOCL607zCZyA=
Date: Fri, 30 Oct 2026 17:27:33 +0000
From: Leo Yan <leo.yan@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v3 10/14] perf cs-etm: Synthesize exception entries
 separately from branches
Message-ID: <20261030172733.GF9176@e132581.arm.com>
References: <20261030-perf_cs_etm_fix_non_taken-v3-0-7629b52ab047@arm.com>
 <20261030-perf_cs_etm_fix_non_taken-v3-10-7629b52ab047@arm.com>
 <sashiko-outbox-191183@kernel.org>
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-191183@kernel.org>

On Fri, Oct 30, 2026 at 03:40:53PM +0000, sashiko-bot@kernel.org wrote:

[...]

> [Severity: Medium]
> As reported by Sashiko on v2 [1], does cs_etm_decoder__buffer_exception()
> misinterpret exception_number when decoding ETMv3 traces in A32 state?

As I mentioned in my reply to the same comment on v2, I would prefer to
leave this out to avoid unnecessary code complexity.
