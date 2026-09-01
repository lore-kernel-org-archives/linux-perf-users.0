Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4C336197C
	for <linux-perf-users@vger.kernel.org>; Tue,  1 Sep 2026 15:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788275668; cv=none; b=oqQ/1ySfH5RxGZryaEipZeGWeZ299iwNX03hyRmBDRrbTYCc2HIYgoWkcxK34iXd3bLyGbo5Ml966/JMf0uSqdMrpxal/w4NsRv/g+r3lMGz2p6FsckowOLoHyjdblFBEYHsEUhYk0Uto3QiZoF+vakAYalIFFTHVvIW5rZ2Kno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788275668; c=relaxed/simple;
	bh=5soE71I4KmzfX+TuYcYo5+6N2a8nHTpJ2/KegaXE+NY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jft4OT4e9K1ZzX/tqMzwMgSyIWEyRKb2EGEFdZNiS+6x3nFlc3xMjL/d/7uCJwJjDy6TuevjkO1KWTH9rthFm7wuuH2XXvq+C4dgyTsqkqBmOhN6zBHCVXqMhPFWM3SJxE/UYtCGiq2fswCv/kpW5N0aL0VeiDeOUXn4QykTlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oiyi3ziM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oiyi3ziM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135441F000E9;
	Tue,  1 Sep 2026 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788275666;
	bh=udP37poZSCPEXV+pnYbgAOYdnR4/Cjb9SP37H2KP1yQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oiyi3ziMKh+hIGsyGx+7B0X9VACgp3MlF5w3eUvjuzIELp7DO1xlO+YD5mjnpMJgk
	 fRiZDa182gjCIesPFd2uyGbt8o+yN9QEacWPA/4ArNUfPguOim513bDIFrEF4HUAnQ
	 y0JBa1dnrqudH9svGA2RkNrYi1zSuQ+gUceFdZmTRJPzSKZ2edIUoG1sAZwl66lzA0
	 8aJx7T5kD1UVcmHN7xGD0SLFCSzsx4RPDdD6aywu5cjduyRRNp/E9CeeTJtRsifRWU
	 Auf2VqRRkBbJaf1RzZZ4Ruas3iOmh+XI0evRkiJ0BMgf47GofhtefPQOPc0PnMK2L+
	 +eABFRlvtwpWw==
Date: Tue, 1 Sep 2026 08:14:15 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: v5 of the perf weight annotation patchkit
Message-ID: <apbrxyGjScGPQTbE@google.com>
References: <20260830193459.2840519-1-ak@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260830193459.2840519-1-ak@linux.intel.com>

On Sun, Aug 30, 2026 at 12:34:36PM -0700, Andi Kleen wrote:
> Fixes the latest sashiko issues
> 

Reviewed-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

