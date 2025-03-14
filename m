Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEAE1F957;
	Fri, 14 Mar 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972733; cv=none; b=glxzpyBiQdNpUBANa72jpe8rG/LIwcQZSQaPh/3C//pl3ex7049zl1wO/+KIhDbKebdZC0/lUJyaH5qhRWNX8GPezNzx60ZkUkzpITHqckzdzrwffa+tVwmiTUs4mfjVh5fg23CmncXxtwmXZwN8CXfgnPmCXfr8clDYbNLp5WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972733; c=relaxed/simple;
	bh=jwQ64MtOlfFBI+IjDiKt86Qngy4C9Fb/Ty8mzXTGGQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNOVjnRdnGE376SE2x21v+oZN0uzaJOYotqZsOKomphuGMGTH/j2p9cqax69hEj96KXmI0gem77/EdqUa0HOyX73xnaDevSIXOw2V3NP9t7onudvBjrBOSI0G5PlJDw2ckVFSmkrreIXh345hcZOeuR078r6233PIjFwaczsyT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ug36oap8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ug36oap8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118D8C4CEE3;
	Fri, 14 Mar 2025 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741972732;
	bh=jwQ64MtOlfFBI+IjDiKt86Qngy4C9Fb/Ty8mzXTGGQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ug36oap8ubQfJ1sGvi+JdyPFDXeHZykDoiXdoZ60VmVEYs4r0XIATWkgIjzI5olIO
	 Y/4+g+4kLqUPb2BDrsvcQKLyhBUMM8qi5KF0pDLcAS7mWz7fd5+INlySDsfni6cW18
	 /Dw2o8FQDnEiAhFh8Wbp3x23JoXAzj5p6O5bYHnUetNJg4W1GFwas3F2t/NRuO4Vpt
	 yFflMQbkZY7ju2gnQR1CXJaOlBYaHvD3qJACwQc2iGa8Tlm0bCvANPcplAvH7RmN58
	 WC0HnYrzmi2LM4rub6xLgcmrqKdW/valTcn8tI4/E+ao04eZxYTQH2/fgioyhSuz4r
	 +02t5soX7BzPg==
Date: Fri, 14 Mar 2025 14:18:49 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	James Clark <james.clark@linaro.org>,
	Yicong Yang <yangyicong@hisilicon.com>,
	Howard Chu <howardchu95@gmail.com>, Andi Kleen <ak@linux.intel.com>,
	Michael Petlan <mpetlan@redhat.com>,
	Anne Macedo <retpolanne@posteo.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf machine: Factor creating a "live" machine
 out of dwarf-unwind
Message-ID: <Z9Rk-YdoK-fK_62d@x1>
References: <20250313052952.871958-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052952.871958-1-irogers@google.com>

On Wed, Mar 12, 2025 at 10:29:51PM -0700, Ian Rogers wrote:
> Factor out for use in places other than the dwarf unwinding tests for
> libunwind.

Testing with another patchset being reviewed/tested, seems to work, if
it showed the line number would be even better!

I'll continue working on that other case with this applied just before
that series and finally will give my Tested-by.

- Arnaldo

root@number:~# perf trace -e landlock_add_rule perf test -w landlock
perf: Segmentation fault
    #0 0x5be81d in dump_stack perf[5be81d]
    #1 0x5be879 in sighandler_dump_stack perf[5be879]
    #2 0x7f313d24efd0 in __restore_rt libc.so.6[40fd0]
    #3 0x491bc1 in cmd_trace perf[491bc1]
    #4 0x497090 in run_builtin perf.c:0
    #5 0x4973ab in handle_internal_command perf.c:0
    #6 0x413483 in main perf[413483]
    #7 0x7f313d238088 in __libc_start_call_main libc.so.6[2a088]
    #8 0x7f313d23814b in __libc_start_main@@GLIBC_2.34 libc.so.6[2a14b]
    #9 0x413ad5 in _start perf[413ad5]
Segmentation fault (core dumped)
root@number:~#
