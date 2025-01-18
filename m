Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9B2173
	for <linux-perf-users@vger.kernel.org>; Sat, 18 Jan 2025 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737223168; cv=none; b=PJo7hMYa/gFsVxkwuQhKwLzUDfZsI3PUhykiedM2M1fv1qTWZDGigYguDjAGGR+794UoqbIYncw3qGMWUlT98e+necEQMcObYscVU7jz03Y5ITvNCoWuL+m6yy7m8qxRE9WYxmLQZgD47rffiuu0gE7s8nJdj6Q1yoA6uVivMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737223168; c=relaxed/simple;
	bh=V0FY+gqIgfN4D3E7+TqhT8qsOfNMrmhXpFpfH0hX1HY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EAGsuVW/ikG1O4vpULq5xmOx7+kOmy5/Wfld0SAL+jPhv7RwQS6qXM3kbeK+IvVZmreZOerDNWlgd+TWwd6pgw2tbHVutxqU/w5YArhlwCHHSwMTc/KncKuzYrk48Yzg8ZqRBCvgmeQgK494EyuGTR45u7qSp6c9QQTSgcrdgK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3yW4Pkm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3yW4Pkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0EA1C4CED1;
	Sat, 18 Jan 2025 17:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737223168;
	bh=V0FY+gqIgfN4D3E7+TqhT8qsOfNMrmhXpFpfH0hX1HY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=g3yW4PkmbtYxErVnwIBR78TUPbf9PSOOMLEr6qvGU/71Mzm+e0JlU+xt5f3t/gGin
	 rW3bY2UETp8O/D2DS1AAdmrroG5fL2TCPgagXUo0SmDfAZaVQb77PfXPsy22pY3W2S
	 4/ItnuSCBlynlcvc9ND+Q3caHLzyQis4cRS7Lw7okTzaOONpRHPWrgcDgrG7jCda4g
	 8HagJNonwA+/NZxBarvxXqnVxVORgkBw9PnvhZ5mOI9Bl7cnUYp9yMw6FuPx+IjOkI
	 Dsz5OMaJJM0uF6bEX9x7fm1UlHfYuaLEQgihY4OxTCpkfHf1Lb+1tkKdjQAk6RpINN
	 G8JebkUwXMqCQ==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
 irogers@google.com, Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, 
 hbathini@linux.ibm.com
In-Reply-To: <20250110093730.93610-1-atrajeev@linux.vnet.ibm.com>
References: <20250110093730.93610-1-atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH V2] tools/perf/builtin-lock: Fix return code for
 functions in __cmd_contention
Message-Id: <173722316773.2826057.12496163001807331882.b4-ty@kernel.org>
Date: Sat, 18 Jan 2025 09:59:27 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 10 Jan 2025 15:07:30 +0530, Athira Rajeev wrote:

> perf lock contention returns zero exit value even if the lock contention
> BPF setup failed.
> 
>   # ./perf lock con -b true
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   libbpf: kernel BTF is missing at '/sys/kernel/btf/vmlinux', was CONFIG_DEBUG_INFO_BTF enabled?
>   libbpf: failed to find '.BTF' ELF section in /lib/modules/6.13.0-rc3+/build/vmlinux
>   libbpf: failed to find valid kernel BTF
>   libbpf: Error loading vmlinux BTF: -ESRCH
>   libbpf: failed to load object 'lock_contention_bpf'
>   libbpf: failed to load BPF skeleton 'lock_contention_bpf': -ESRCH
>   Failed to load lock-contention BPF skeleton
>   lock contention BPF setup failed
>   # echo $?
>    0
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

