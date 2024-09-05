Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAC113E028;
	Thu,  5 Sep 2024 04:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725509631; cv=none; b=sBRcFbmgQ4OWzKdOdbHAy2Q6gnwy3yyOKpz29SxfXMV0zpqUJTXHmUhQ99S94G8fD7tA/NXpcJsEoR+q910A6Mp35jGqY33aqCO4+u2Fidtpm/TVluqejEwbSqTCwezh892ESBNCon1x+wxjjsAzkP94wUdBfkuKut60+TRb80A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725509631; c=relaxed/simple;
	bh=emd9sIo4BPIhMlOM5j7wsEuKbAgy+uK8kI//01doxGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwjKP1C6AFGyYsG640PyjEczWpnXjsDEayC48CGIMTlLH8FZ8imncwrCdL20mah6t0kifSPfmYVMJj/0f2AgPdjZ14119iBbHosq836Re16Yu9f56FbgianzgxzaYq40vT2gG4FSiR4pyNAIviGemx+AY/IhcEH20gCtRdU3WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJAX5yUI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJAX5yUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DABC4CEC4;
	Thu,  5 Sep 2024 04:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725509631;
	bh=emd9sIo4BPIhMlOM5j7wsEuKbAgy+uK8kI//01doxGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pJAX5yUINwtRTPy7uuiAw/+v9+v92ZOlUvDFNWFLnXN4sZkb4bxmn7wqw1UqxeRZq
	 85y2gxt8qDRJQnuYTJ3Rzh5pXJUNHv2KemR25Wm1yUJ9XLU4Ku5zQhRnA/mVHkJSw/
	 zQKQKgQ1Q4z4p6w1mAGLJ31iAsvfaZp8lYCfwH0ENBxWXkhOfwg/GcagJYIp3MKnzP
	 s0RA1yVnR+gaFex2+T6MeYPWxpK+ilLB45gqwTrk0Ra33o3IbiclMi8hRkqkQf7m3P
	 6OBCr4lXRoj3pOx4U15s+GX2w/EPXATr6C8vKJBH8S4M7+H2I0zozOgCi1F/a1Xe+K
	 D8aSXcn9weQWw==
Date: Wed, 4 Sep 2024 21:13:49 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	linux-perf-users <linux-perf-users@vger.kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [GSoC] perf trace and BTF: Final Report
Message-ID: <Ztkv_QD758uFckvW@google.com>
References: <CAH0uvohVui=31tMSD=J-qshtsKHg2__4c7XEQWWXa6Ycf0Umaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvohVui=31tMSD=J-qshtsKHg2__4c7XEQWWXa6Ycf0Umaw@mail.gmail.com>

On Wed, Aug 28, 2024 at 01:25:30AM +0800, Howard Chu wrote:
> Hello everyone,
> 
> This is the final report for my project "perf trace and BTF".
> 
> This project aims to enhance perf trace by utilizing BTF (BPF Type
> Format) information from the Linux kernel to collect and pretty-print
> system call arguments more effectively. This includes data collection
> and pretty printing of struct pointers, buffers, strings, and enum
> arguments, which we refer to as syscall augmentation.
> 
> I have completed the goals mentioned above during the GSoC period, and
> test scripts have been created to validate the new features.
> Currently, the patch series for struct, buffer, and string pointers
> augmentation is at v3 and under review.
> 
> One of my mentors, Arnaldo, wants to convert the integer flags to a
> detached BTF object, which is what I’ll be working on after the GSoC
> period. Additionally, I will focus on landing the perf record
> --off-cpu patch series, incorporating feedback from my mentors Ian and
> Namhyung on off-cpu v4.
> 
> I would like to express my thanks to my mentors Arnaldo Carvalho de
> Melo, Ian Rogers, and Namhyung Kim. Their important guidance and
> feedback have been invaluable to my work. I am grateful to acme for
> making excellent revisions to my code, to Ian Rogers for organizing
> weekly meetings and offering professional advice, and to Namhyung Kim
> for his crucial insights into key issues and bugs.
> 
> Thank you,
> Howard

Thanks for your great work, Howard!  I'm looking forward to working
with you even after GSoC!

Thanks,
Namhyung

> ---
> 
> Patches sent:
> [PATCH v1 0/2] perf trace: Better -p support
> [PATCH v1 1/2] perf trace: Collect data only for certain pids
> [PATCH v1 2/2] perf trace: Use pid to index perf_event in BPF
> Link: https://lore.kernel.org/linux-perf-users/20240827092013.1596-1-howardchu95@gmail.com/
> 
> perf trace: Enhanced augmentation for pointer arguments
> [PATCH v3 1/8] perf trace: Fix perf trace -p <PID>
> [PATCH v3 2/8] perf trace: Add trace__bpf_sys_enter_beauty_map() to
> prepare for fetching data in BPF
> [PATCH v3 3/8] perf trace: Pass the richer 'struct syscall_arg'
> pointer to trace__btf_scnprintf()
> [PATCH v3 4/8] perf trace: Pretty print struct data
> [PATCH v3 5/8] perf trace: Pretty print buffer data
> [PATCH v3 6/8] perf trace: Collect augmented data using BPF
> [PATCH v3 7/8] perf trace: Add --force-btf for debugging
> [PATCH v3 8/8] perf trace: Add general tests for augmented syscalls
> Link: https://lore.kernel.org/linux-perf-users/20240824163322.60796-1-howardchu95@gmail.com/
> 
> perf record --off-cpu: Dump off-cpu samples directly
> [PATCH v4 1/9] perf evsel: Set BPF output to system-wide
> [PATCH v4 2/9] perf record --off-cpu: Add --off-cpu-thresh
> [PATCH v4 3/9] perf record --off-cpu: Parse offcpu-time event
> [PATCH v4 4/9] perf record off-cpu: Dump direct off-cpu samples in BPF
> [PATCH v4 5/9] perf record --off-cpu: Dump total off-cpu time at the end
> [PATCH v4 6/9] perf evsel: Delete unnecessary = 0
> [PATCH v4 7/9] perf record --off-cpu: Parse BPF output embedded data
> [PATCH v4 8/9] perf header: Add field 'embed'
> [PATCH v4 9/9] perf test: Add direct off-cpu dumping test
> Link: https://lore.kernel.org/linux-perf-users/20240807153843.3231451-1-howardchu95@gmail.com/
> 
> Patches merged:
> [PATCH v5 0/8] perf trace: Augment enum arguments with BTF
> [PATCH v5 1/8] perf trace: Fix iteration of syscall ids in syscalltbl->entries
> [PATCH v5 2/8] perf trace: BTF-based enum pretty printing for syscall args
> [PATCH v5 3/8] perf trace: Augment non-syscall tracepoints with enum
> arguments with BTF
> [PATCH v5 4/8] perf trace: Filter enum arguments with enum names
> [PATCH v5 5/8] perf test: Add landlock workload
> [PATCH v5 6/8] perf test trace_btf_enum: Add regression test for the
> BTF augmentation of enums in 'perf trace'
> [PATCH v5 7/8] perf trace: Introduce trace__btf_scnprintf()
> [PATCH v5 8/8] perf trace: Remove arg_fmt->is_enum, we can get that
> from the BTF type
> Link: https://lore.kernel.org/linux-perf-users/20240705132059.853205-1-howardchu95@gmail.com/
> 
> [PATCH] perf record: Fix comment misspellings
> Link: https://lore.kernel.org/linux-perf-users/20240425060427.1800663-1-howardchu95@gmail.com/
> 
> Blog posts:
> perf trace: Add support for enum arguments
> Link: https://sberm.cn/blog/perf-trace-enum
> 
> How to contribute to perf
> Link: https://sberm.cn/blog/how-to-contrib-perf
