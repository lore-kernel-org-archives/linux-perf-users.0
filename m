Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D96837BE78;
	Wed, 10 Jun 2026 19:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121330; cv=none; b=ApRSXAJyWGTQHvonM5R2aC3g2BnK1ZCrm+GK0RSGA7Wo/Ajh8ZZBBoUlFBAO4ZroFq8hf9SFHalVL6+6z44cgoekldSdzNpakmuuLYCGoEkNhehiWjNXkNDAVEzhugmEclt5Q/R7xFLITqp8gLY/+A5w1WuG7JxHB4gxc3AzYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121330; c=relaxed/simple;
	bh=jNqqEh3bF8+bueFpDQaLbDgUQ6Hc78rQzXI335uTMic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4o99sjpJ60n+cTGcNdJuckGexhlLfhfADMo2o+Sp7AFWQcd6zZpdOFZs4V16qP3x8YXKE5dtEIaPXkY4BTPuiKt3f/OSkQwKpmxoaudvesk/WYK8wyRRkvKgfiXkIGJPElS/JPFfL84GBpkmglF0rh1iZgCuqzgOaQbdyspaLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=je4peavy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="je4peavy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 554A71F00893;
	Wed, 10 Jun 2026 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781121329;
	bh=e+Ol4XmgoHN1bk7lUaCxTsxB8W5FSMvH1pGUFf5cHuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=je4peavyf/p6Ir4fS+8WuVm5ZXl8WS7YpuDx/vsVh68apy23OlezIe+e7PoiUtl33
	 XHDnaC042xZ6YKcUD83sn/CynstKlnMpLyGhgGNIevaOy36VqYiGZfhj623V7LvEds
	 Z59tnJy9WDd01auxRS8wGy+BDNdwmkyBizzLCW4EL5U/EMVcM0kOzz9BCoN+uykivW
	 M+MboekVjiJX27XyuJXmd+XE5MLIt6pmBfG6SjG6IhOYoItQB+ox0a/JQbTlP+BDuN
	 BoPhdcOxPg3d6IhfxI6MqTt6P6kON3fNDNrFw4R+2q9ox13O9zzJKBHbW7r/7XehcX
	 Di+FIJM6s/XOQ==
Date: Wed, 10 Jun 2026 16:55:25 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] perf: riscv: fix register name strings
Message-ID: <ainBLXCDcudjqBl2@x1>
References: <20260609081500.743861-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609081500.743861-1-martin@kaiser.cx>

On Tue, Jun 09, 2026 at 10:13:07AM +0200, Martin Kaiser wrote:
> Fix the register name strings for risc-v to match the syntax for kprobes.
> 
> This requires redefining REG_DWARFNUM_NAME. Make sure that different
> definitions for different architectures don't create compiler warnings.

Thanks, applied to perf-tools-next, for v7.2.

- Arnaldo
 
> Martin Kaiser (2):
>   perf: avoid redefinition warnings for REG_DWARFNUM_NAME
>   perf riscv: fix register name strings
> 
>  tools/perf/arch/powerpc/include/dwarf-regs-table.h | 1 +
>  tools/perf/arch/riscv/include/dwarf-regs-table.h   | 3 ++-
>  tools/perf/arch/s390/include/dwarf-regs-table.h    | 1 +
>  3 files changed, 4 insertions(+), 1 deletion(-)
> 
> -- 
> 2.43.7
