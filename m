Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A10F3B2FD1;
	Wed,  3 Jun 2026 11:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484785; cv=none; b=e1YJierJXuWbm0ubsGs9DPQ4S7UZHI4x9+vcTiNtHrxRSru1aNghNbCt4T0KLRQV15G0e/4y5IInEm8Mk915iqr/N3kuXMOleDjwconUH0DtbvGq7xbk4oV++MY+StdopOtX4J6Absx+PE2af+JRQi2SiEBD5xK9ghwJC8qrC3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484785; c=relaxed/simple;
	bh=GvgqB2E/Kyddxf977Klr0BYNxizGw/BC0d/bmgsXfbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zqi2n1T5+O2TF1VhA62366YucSBxY+QC3TZnm9WiEodFClAQqv3N8Ec7XJnc2m03TNrNsMtrTJ/uqAbl5mRYav+40/SbRZkkFyPnKy5livhNUnIwJbfIEfpSyEfTbcB5S2X4xEBgbMYSx2vcrG+d20WupgqOmaoOyJ4uQnuWDAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Dh0pgKkY; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Dh0pgKkY"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C775632E4;
	Wed,  3 Jun 2026 04:06:18 -0700 (PDT)
Received: from localhost (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 52B513F86F;
	Wed,  3 Jun 2026 04:06:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1780484783; bh=GvgqB2E/Kyddxf977Klr0BYNxizGw/BC0d/bmgsXfbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dh0pgKkYamrFVE00IdP/ciPJ47rh+RmuKqGjRSeCJ30JkFx5eHMjdNxruDu5l3J9w
	 suWtvZiytH1+GfAPpSyvb5Wzs88uX8N8myXgeHGSyQt4fwA5dsbyUiz93SI2IpYW3r
	 2EslEMMGxCO/8aSakzkDwqCnWEzflopzev0Vy5F0=
Date: Wed, 3 Jun 2026 12:06:21 +0100
From: Leo Yan <leo.yan@arm.com>
To: James Clark <james.clark@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>, Amir Ayupov <aaupov@meta.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paschalis Mpeis <Paschalis.Mpeis@arm.com>,
	coresight@lists.linaro.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 03/18] perf test: Add a workload that forces context
 switches
Message-ID: <20260603110621.GR101133@e132581.arm.com>
References: <20260602-james-cs-context-tracking-fix-v2-0-85b5ce6f55c6@linaro.org>
 <20260602-james-cs-context-tracking-fix-v2-3-85b5ce6f55c6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-james-cs-context-tracking-fix-v2-3-85b5ce6f55c6@linaro.org>

On Tue, Jun 02, 2026 at 03:26:45PM +0100, James Clark wrote:

[...]

> +/* Not static to avoid LTO clobbering the function name */
> +void context_switch_loop_proc1(int in_fd, int out_fd);
> +noinline void context_switch_loop_proc1(int in_fd, int out_fd)
> +{
> +	for (int i = 0; i < loops; i++) {
> +		read_block(in_fd);
> +		context_switch_loop_work += i * 3;
> +		write_block(out_fd);
> +	}
> +}

Rather than struggling with unexpected options, and "noinline" might
not work as it is not a standard compiler option (it is defined in
kernel header as AI reminded me), wouldn't it is reliable to use a
dedicated CFLAG rule same as other programs?

Thanks,
Leo
