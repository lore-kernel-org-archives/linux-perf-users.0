Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3C3AEF47;
	Mon,  3 Aug 2026 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778405; cv=none; b=VM6Spk9Bqbo8TBEVSmA9vwHmdWGBliqVg+shdpLcxIa7y+/Dj9aVH2SF4nynKsUM83l7SZ669mkrqMUtNGl+4cJaD5MxiMnz7HW/LkzYqcMnBscHLLEzZTF1SMKqzFLgY5Wmc/n+062P7T8gMjHY6a5P8xEXD+zM53oaxNxBMPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778405; c=relaxed/simple;
	bh=Kf57ReoBVeiH7gkmUh1nG+5VgvA2cTLslzbBfY9gq5A=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LJMvvShhiTPs5NIHo+CrSyUtmX47jd2YvcspyAbfJ8IQZNvTzz0K6UAtmtso/0Gkc084UATdwH1s9SdW4oJLoo1tDZrtTpXClUOh55w3uOUhWErv7cZGvRFPN78hlmdrv6ILHhiOYiVYH9pIAB5PwmFwiyxeT2AoAtug/7XAlh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QiXLM44F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QiXLM44F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B6D1F00A3A;
	Mon,  3 Aug 2026 17:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785778403;
	bh=8Fm/jxpd4lxY2QmPOtJ1LkynhVMHF14h/QM4gxzLIbU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=QiXLM44F5j8VszqsPAiE9yuSCwd6NvklLNTcZ3wmmqoJ1QT1NIHnUVmKUr4+Wpt7m
	 pF/XmHeH/6aP3HmyLBWB/miKON6dEy0a5q0lOfL0RQ2vUiQ3VdO6CVR6eoq3F/lbeq
	 rBoJQH8a0sMYkSVJABCmE9VQij70tQZ76XCWvbMlJ1IecQj5rUAM3RYootT8/23nIe
	 Haxa6gh2dS6hcGrg5cTNoQHZzDjEvwBTO8lATKhYHdNOu0A85FWc4Ly3MEaGnMlkPK
	 kjr1xik6KzTxhWqiUlWAIo5EuWgEgIXcyC/x6xvMK+ZlL/0Mnml/+QUnq3LhtSSfh5
	 ezGAQNAzBJzlw==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com, 
 alexander.shishkin@linux.intel.com, jolsa@kernel.org, irogers@google.com, 
 adrian.hunter@intel.com, james.clark@linaro.org, pjw@kernel.org, 
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, cuiyunhui@bytedance.com, 
 yuanzhu@bytedance.com
In-Reply-To: <20260728033559.90302-1-zhangzhanpeng.jasper@bytedance.com>
References: <20260728033559.90302-1-zhangzhanpeng.jasper@bytedance.com>
Subject: Re: [PATCH] perf symbols: Skip dynamic symbols with invalid
 section indexes
Message-Id: <178577840310.2174330.11305121301334536964.b4-ty@kernel.org>
Date: Mon, 03 Aug 2026 10:33:23 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 28 Jul 2026 11:35:53 +0800, Zhanpeng Zhang wrote:
> RISC-V post-link processing can remove relocation sections from the final
> vmlinux while some .dynsym entries retain stale section indexes. perf
> aborts the whole ELF symbol load when elf_getscn() rejects one of them,
> discarding otherwise valid .symtab symbols.
> 
> Skip only dynamic symbols whose normal section index is outside the final
> section table. Keep the existing error path for .symtab, reserved indexes,
> and other libelf failures.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


