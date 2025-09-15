Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA91F2FB62C;
	Mon, 15 Sep 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757931983; cv=none; b=pOX/YfGpjhb6IS++k8MOA7lwAg/veYbuHzG7hLXSoq8fwv6cNFgbjyAbb7h1woBlgqYlB9oUTFJVg97sPBj7Vb7wLtiyv7AOAf8R8tHR+FYG1lcwnhgCjUVI5epyh4wrAC/8ewHZWanh4HkG+UBx3DioCKb0q/WXQJk6WR7v5s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757931983; c=relaxed/simple;
	bh=/GA8So/quCuLTr9QEGQoMQkvU9cZpTBXsq2hU/dRsAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B0Ccnzw4PLMVbi7rMyb+2/77Os567nuFz+xRQRjAMHParJoFNRIh4wbNRTUGBwIzgQcCc73Xq+y/BwznPIMF0RFb+M1ZCKdkT1a03q5khA6IbC465THyMCJcabMUja0lDjr6NR7ClTYE0FnTifO30lb05HhTh525b8IjJFwiSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNyFUUmx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNyFUUmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E93C4CEF1;
	Mon, 15 Sep 2025 10:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757931981;
	bh=/GA8So/quCuLTr9QEGQoMQkvU9cZpTBXsq2hU/dRsAA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SNyFUUmxsay8Xe80G3PwmO50o8SPg6bcgSXGyjEpoPB6nPxzzYITcaAfUyr1UIaP6
	 NJXhjswDhHZr28LOg6OFFZQPHoqCsvwyZc+n/s8hq0cnxjrYG7VUGwdz1kpvCgcZ+A
	 wZjuW5Qj+3o39n1mxADRBkx/58mJHHO/TvLEGUriCQGUrNEK3FUzDGh7nVi8ABvhvS
	 ewNHqRp6wu91cadk4bPAO3pvVcsaLKJEe9/k9EZ3OBcjz0RM0bgZ21dgADQQ4WPNTf
	 lUX0QXAgnc0KoAm7b9etN61a2K3lMQGaMS5Bil50i5ju5pPGmdGDs6vsqdzlAW1rut
	 toNe1DHOAV1dQ==
Date: Mon, 15 Sep 2025 11:26:09 +0100
From: Will Deacon <will@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: akpm@linux-foundation.org, catalin.marinas@arm.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, kees@kernel.org, masahiroy@kernel.org,
	aliceryhl@google.com, ojeda@kernel.org,
	thomas.weissschuh@linutronix.de, xur@google.com,
	ruanjinjie@huawei.com, gshan@redhat.com, maz@kernel.org,
	suzuki.poulose@arm.com, zhanjie9@hisilicon.com,
	yangyicong@hisilicon.com, dianders@chromium.org,
	gautam@linux.ibm.com, arnd@arndb.de, zhao.xichao@vivo.com,
	rppt@kernel.org, lihuafei1@huawei.com, coxu@redhat.com,
	jpoimboe@kernel.org, yaozhenguo1@gmail.com,
	luogengkun@huaweicloud.com, max.kellermann@ionos.com, tj@kernel.org,
	wangjinchao600@gmail.com, yury.norov@gmail.com,
	thorsten.blum@linux.dev, x86@kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] watchdog: remove HARDLOCKUP_DETECTOR_PERF
Message-ID: <aMfpwYPX6_i6ROOY@willie-the-truck>
References: <20250915035355.10846-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915035355.10846-1-cuiyunhui@bytedance.com>

On Mon, Sep 15, 2025 at 11:53:55AM +0800, Yunhui Cui wrote:
> There are currently two hard lockup detector implementations:
> HARDLOCKUP_DETECTOR_PERF (perf-based) and HARDLOCKUP_DETECTOR_BUDDY
> (buddy-based). When enabling the hardlockup feature on new arch
> (e.g., RISC-V), ambiguity arises regarding which detector to choose.
> 
> From the community discussion (see link below [1]), the buddy approach is
> preferred. So remove the HARDLOCKUP_DETECTOR_PERF implementation.
> 
> Link: https://lore.kernel.org/all/CAD=FV=WWUiCi6bZCs_gseFpDDWNkuJMoL6XCftEo6W7q6jRCkg@mail.gmail.com/ [1]

This is a link to a thread containing two messages, so I think it's a
little premature to say whether one driver is preferred over the other.

> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/Kconfig                     |  14 --
>  arch/arm64/Kconfig               |   3 -
>  arch/arm64/kernel/Makefile       |   1 -
>  arch/arm64/kernel/watchdog_hld.c |  94 ----------

The main reason we used HARDLOCKUP_DETECTOR_PERF on arm64 is because we
can use interrupt priorities to treat the PMU overflow interrupt like
an NMI, meaning that even if CPUs get wedged with irqs disabled then
we're still able to trigger the watchdog reset.

How does HARDLOCKUP_DETECTOR_BUDDY achieve that? From my cursory glance
at the code, it just looks to be using an hrtimer.

/me looks back at the "discussion" cited in the commit message:

  | If all CPUs are hard locked up at the same time the buddy system
  | can't detect it.

Ok, so why is that limitation acceptable? It looks to me like you're
removing useful functionality.

Will
