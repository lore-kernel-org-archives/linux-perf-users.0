Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19F3448D1E;
	Mon, 21 Sep 2026 20:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023589; cv=none; b=kZBzrZZ01oUhDIB/ZLnD8cQ7+kHsULzS1jo4/5x5yZjjrVHWwsNmYqLajNi/G1/UtIUdXaUVC5mID6n5QTlgJjXBPMPBw88To4WO2nZOPzA/nAelFcQauA5Ql3U0WNKOMCUc0p2+yvdz4xvvuWjcv/XadRpzPxT0+Wjjwamm2fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023589; c=relaxed/simple;
	bh=4qnq7pZh3Imu6iaz5MTTwAbKcy3vI+SrJcD0d4XlfZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnICWfjsMhopSZ8FL5wIy0e1XuY6LZ39m8LYkYLyMr9kDNTrP2jDdHgmI1DlOHG/LdnFhDVHsiR/6ttF9MBV++auXe0XWPmkB8wLgqxILyQ/w7E6SuFpZ0GX+5+6dDYcPyMGnxdTANMB5yeIHzvrqDqzYDUNxFd3B2xe9zQpB3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cnv1BtIG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cnv1BtIG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 297A11F000FF;
	Mon, 21 Sep 2026 20:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790023587;
	bh=Tt94phXEc1gWWvfL7pRtm66wb6ZqO67Y6lVb5lC2UK0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cnv1BtIGZYTz4Bo1iRv3YB3BIFk01N4DY13U2MB+u4cJ9SJHxLls/7AdUQMo7Sxtw
	 EFzKkF0t0YvR9wSlTf13sDvzkXMnxGweN8LpfwF5xW1lPTFk7wNIxFk9uXqZ4GsiaO
	 7YzkIhm02+I51uUGmiP3CXekdt+rGwI82HYr3HQYEbuD09AjXrl8BfMIiydro8qBIC
	 P8JAnOoRpXDO1HltD4qCk9ay9haQnSFIsm6asd5lv3yT6O6UoLOk1je668u0tgXulT
	 jmjFPJpoB0WHbQVMH4mJnelps9GWijvKgekrUqo5g3SDgCVyJw6UAWnPQuG9eM1pAW
	 3i85ZLTZfOQ9A==
Date: Mon, 21 Sep 2026 13:46:25 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: James Clark <james.clark@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] perf test: Improve shellcheck source directives
Message-ID: <arGXoU4idVCKb2cC@google.com>
References: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921-james-perf-shellcheck-source-v1-0-adcfc107c997@linaro.org>

On Mon, Sep 21, 2026 at 04:47:27PM +0100, James Clark wrote:
> I was hacking away when I got blocked by a shellcheck warning about an
> unassigned variable, despite that variable being assigned in a sourced
> file and having visibly correct source= directive.
> 
> Confusingly two things turned out to be relevant to this. One is that -a
> doesn't make shellcheck follow "external" paths, which these are treated
> as. You need -x for that. Secondly, the source= directives don't cause
> it to follow the path either, they just suppress a warning message about
> dynamic paths in versions of shellcheck before 0.7.2. This warning can
> be silenced with "source=/dev/null" and doesn't require any particular
> path to be provided if -x isn't used.
> 
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
> James Clark (2):
>       perf test: Remove redundant shellcheck source paths
>       perf build: Follow sourced files when running shellcheck

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

> 
>  tools/perf/Makefile.perf                                  | 2 +-
>  tools/perf/tests/shell/annotate.sh                        | 1 -
>  tools/perf/tests/shell/base_probe/test_adding_kernel.sh   | 1 -
>  tools/perf/tests/shell/diff.sh                            | 1 -
>  tools/perf/tests/shell/inject_aslr.sh                     | 1 -
>  tools/perf/tests/shell/jitdump-python.sh                  | 1 -
>  tools/perf/tests/shell/list.sh                            | 1 -
>  tools/perf/tests/shell/pipe_test.sh                       | 1 -
>  tools/perf/tests/shell/probe_vfs_getname.sh               | 2 --
>  tools/perf/tests/shell/python-use.sh                      | 1 -
>  tools/perf/tests/shell/record+probe_libc_inet_pton.sh     | 2 --
>  tools/perf/tests/shell/record+script_probe_vfs_getname.sh | 2 --
>  tools/perf/tests/shell/record.sh                          | 2 --
>  tools/perf/tests/shell/record_weak_term.sh                | 1 -
>  tools/perf/tests/shell/script_dlfilter.sh                 | 1 -
>  tools/perf/tests/shell/stat+csv_output.sh                 | 1 -
>  tools/perf/tests/shell/stat+json_output.sh                | 1 -
>  tools/perf/tests/shell/stat+std_output.sh                 | 1 -
>  tools/perf/tests/shell/stat_metrics_values.sh             | 1 -
>  tools/perf/tests/shell/test_arm_callgraph_fp.sh           | 1 -
>  tools/perf/tests/shell/test_brstack.sh                    | 1 -
>  tools/perf/tests/shell/test_data_symbol.sh                | 1 -
>  tools/perf/tests/shell/test_intel_pt.sh                   | 1 -
>  tools/perf/tests/shell/test_perf_data_converter_json.sh   | 1 -
>  tools/perf/tests/shell/test_test_junit_output.sh          | 1 -
>  tools/perf/tests/shell/test_uprobe_from_different_cu.sh   | 1 -
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh         | 1 -
>  tools/perf/tests/shell/trace_btf_enum.sh                  | 1 -
>  tools/perf/tests/shell/trace_btf_general.sh               | 1 -
>  tools/perf/tests/shell/trace_exit_race.sh                 | 1 -
>  tools/perf/tests/shell/trace_record_replay.sh             | 2 --
>  tools/perf/tests/shell/trace_summary.sh                   | 1 -
>  32 files changed, 1 insertion(+), 37 deletions(-)
> ---
> base-commit: 9453bc6a69ef43755f1c28d5688cacdd69fa16bd
> change-id: 20260921-james-perf-shellcheck-source-f48df891cd4f
> 
> Best regards,
> --  
> James Clark <james.clark@linaro.org>
> 
