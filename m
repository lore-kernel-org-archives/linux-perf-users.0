Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A99A1C5F2C;
	Tue, 28 Jan 2025 19:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738091724; cv=none; b=q6ITRAcUj9ReSWGkH5rRUuKAUTwn8yHS5nOjs7+tv0FgG0sA8CEqEifOlNMXHRAM/irP8HYjKqpwMnw49/7e9QwP2I8OGjXaWngWQA/1Zr2eIzJ0em5c1Q7txbGCMzmZtKwk+jXn8D7IFhXGMyNHdacQHZ7CVCRSDSWpUij3bsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738091724; c=relaxed/simple;
	bh=L+SxakJ2qWU22gUosP7eROMrsJwAmmSVjxlnZl37r40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=s5YE7Y+JQ/Fa3no+7sRi8UJPte2N9hjpn1tlXcd/VeI+jF8iBfWzzrAqEm9h85eRjtp6RgObnAjW2YghXBM0lprN2cBSbnj3j0neYN9SymuX4ckeSQa3oNQY5UnxCixY3jYxSuZtDmmPNTq92Q3VyPBVZCK0z0VuKjCuiNSC4jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jegMbnsf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jegMbnsf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA5BC4CED3;
	Tue, 28 Jan 2025 19:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738091723;
	bh=L+SxakJ2qWU22gUosP7eROMrsJwAmmSVjxlnZl37r40=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jegMbnsfeVZpYUZN+4BE4BDNk2ZK6zjt/SHtHJ9EQQXcs/BuXSIvZXvhakCQI12cs
	 xeC2345zdAvluUNxN2JoZ1BloJbyGLmkHubxSgPXHKddELfzfPuHSBH3m6riS3qSFi
	 EOT+iF6Q6jCJgH6QdTPIiw7Wdg0PkCv49KEhkJkEDCF3/5PEGcb9SSuOLV22bGYSOm
	 X5vF65OzYLdjpGBUczqQMUj6CyjqvWFSNplXcgCIz/xZ39nIcq6/cnRDrW3PiYuzRn
	 TNXs0meJq5uD0M/9/fbUdf/746qhTwRva9L267voafK6vJlWem66hpjSdg7VN51vzi
	 rg+nHyYF0YXyg==
From: Namhyung Kim <namhyung@kernel.org>
To: acme@kernel.org, Howard Chu <howardchu95@gmail.com>
Cc: jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250122025519.361873-1-howardchu95@gmail.com>
References: <20250122025519.361873-1-howardchu95@gmail.com>
Subject: Re: [PATCH v1] perf trace: Fix runtime error of index out of
 bounds
Message-Id: <173809172358.948154.8877116739875725727.b4-ty@kernel.org>
Date: Tue, 28 Jan 2025 11:15:23 -0800
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 21 Jan 2025 18:55:19 -0800, Howard Chu wrote:
> libtraceevent parses and returns an array of argument fields, sometimes
> larger than RAW_SYSCALL_ARGS_NUM (6) because it includes "__syscall_nr",
> idx will traverse to index 6 (7th element) whereas sc->fmt->arg holds 6
> elements max, creating an out-of-bounds access. This runtime error is
> found by UBsan. The error message:
> 
> perf $ sudo UBSAN_OPTIONS=print_stacktrace=1 ./perf trace -a --max-events=1
> builtin-trace.c:1966:35: runtime error: index 6 out of bounds for type 'syscall_arg_fmt [6]'
>     #0 0x5c04956be5fe in syscall__alloc_arg_fmts /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:1966
>     #1 0x5c04956c0510 in trace__read_syscall_info /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:2110
>     #2 0x5c04956c372b in trace__syscall_info /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:2436
>     #3 0x5c04956d2f39 in trace__init_syscalls_bpf_prog_array_maps /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:3897
>     #4 0x5c04956d6d25 in trace__run /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:4335
>     #5 0x5c04956e112e in cmd_trace /home/howard/hw/linux-perf/tools/perf/builtin-trace.c:5502
>     #6 0x5c04956eda7d in run_builtin /home/howard/hw/linux-perf/tools/perf/perf.c:351
>     #7 0x5c04956ee0a8 in handle_internal_command /home/howard/hw/linux-perf/tools/perf/perf.c:404
>     #8 0x5c04956ee37f in run_argv /home/howard/hw/linux-perf/tools/perf/perf.c:448
>     #9 0x5c04956ee8e9 in main /home/howard/hw/linux-perf/tools/perf/perf.c:556
>     #10 0x79eb3622a3b7 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>     #11 0x79eb3622a47a in __libc_start_main_impl ../csu/libc-start.c:360
>     #12 0x5c04955422d4 in _start (/home/howard/hw/linux-perf/tools/perf/perf+0x4e02d4) (BuildId: 5b6cab2d59e96a4341741765ad6914a4d784dbc6)
> 
> [...]
Applied to perf-tools, thanks!

Best regards,
Namhyung


