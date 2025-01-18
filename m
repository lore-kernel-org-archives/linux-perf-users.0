Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E9A95C;
	Sat, 18 Jan 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737224896; cv=none; b=cpVlBuqDCuywqAuFii/p6LBJ3t1wOtGnoQ5lCAXXH4i0XxUZv8o/VyiFCYL7f8/Rh1Dfi+r/lrZa57BFVnCZTgv9A6iJAYtEMuz+vDqBkWwz3BoHKkC5/D5zqag6LTRSOIBly6PysQgh/HjVKo0iaOrST7SUZN3UP7x5zpdsN6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737224896; c=relaxed/simple;
	bh=svPl/Ttx8vJvoE4C60GxVN68GmfNZxRbKQnR8oUbaaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6ECo0GwzUkl0TK+mxC07ABDdKbSflJfJraTmajYlSdS4lBqY9nn2N/MFcwvEWitK4jy/wE+r+InzM5QE3c78LyQYiPI+hMJjVJVa3SufpHNWqzbx8Ih4I/KZWHLnw83x/EyYAeqqSH++RM7VpLz1os9lqtz03VGRsOX+dkYdNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aHz69tJ3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHz69tJ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E98C4CED1;
	Sat, 18 Jan 2025 18:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737224893;
	bh=svPl/Ttx8vJvoE4C60GxVN68GmfNZxRbKQnR8oUbaaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aHz69tJ3r3nj6hkkZmExRS6Ge+qQP+66tpsiPD5S629dYZpbDa1sJfwRjA/EFin8Z
	 UGZ36i06PF+SfQr3An9I8cT1KS/DBUusk/RJWXH2JmzxghSw0DxtHWhNd5xCrSo/+3
	 bb1o9e3QtXKAdNUV82VgkBLhUsAGEYlY9ynDlmC23xA6e8EABpshdWcI+YRqEAW03h
	 7zZLh1jOWWlZLea/y6Upcs9LWdfkoux+vyGcl37C5pdMqdrVbslumGojPJ/tC0DiRB
	 chboeuleKVloyP2hEzu6XV6pqPLvvVy8cflpxzc3P/dup+FpIQo7T4t/3FqsQ9EZPu
	 Xczx6ciJiZ7MA==
Date: Sat, 18 Jan 2025 10:28:12 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Howard Chu <howardchu95@gmail.com>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z4vyvNChyXZx33xf@google.com>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com>
 <Z2mzzytPOpjF0Hxe@x1>
 <Z2m8qzyLdm1BEYuF@x1>
 <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>
 <Z4U343yQUDF3H7qs@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4U343yQUDF3H7qs@x1>

On Mon, Jan 13, 2025 at 12:57:23PM -0300, Arnaldo Carvalho de Melo wrote:
> On Fri, Jan 10, 2025 at 04:52:08PM -0800, Howard Chu wrote:
> > Hello Arnaldo,
> > 
> > On Mon, Dec 23, 2024 at 11:40 AM Arnaldo Carvalho de Melo
> > <acme@kernel.org> wrote:
> > >
> > > On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > > On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > > > > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > > > > Changes in v4:
> > > > > >  - Use if -f to check the existence of vmlinux BTF, and exit if it
> > > > > >    doesn't, so trace_test_string will not overwrite $err, and keep
> > > > > >    running the test.
> > > > > >
> > > > > > Changes in v3:
> > > > > >  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> > > > > >
> > > > > > v1, v2:
> > > > > >
> > > > > > The previous version of the perf trace BTF general augmentation tests
> > > > > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > > > > > <acme@kernel.org> for pointing this out), this version uses bash instead
> > > > > > of POSIX shell to pass Shellcheck.
> > > > > >
> > > > > > This patch series also adds documentation for the new option
> > > > > > --force-btf, which is used in the tests.
> > > > > >
> > > > > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> > > > > >
> > > > > > Howard Chu (2):
> > > > > >   perf trace: Add tests for BTF general augmentation
> > > > > >   perf docs: Add documentation for --force-btf option
> > > > >
> > > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > > >
> > > > Thanks, applied to perf-tools-next,
> > >
> > > It fails when running in parallel mode, sometimes:
> > >
> > > 109: perf trace BTF general tests                                    : FAILED!
> > >
> > > Then:
> > >
> > > root@number:~# perf stat --null -r 10 perf test "BTF general"
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : FAILED!
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : FAILED!
> > > 109: perf trace BTF general tests                                    : Ok
> > > 109: perf trace BTF general tests                                    : Ok
> > >
> > >  Performance counter stats for 'perf test BTF general' (10 runs):
> > >
> > >              2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )
> > >
> > > root@number:~#
> > >
> > >
> > > So its not just when running in paralell, anyway, its merged, we can go
> > > on from what we got there.
> > 
> > It never fails on my machine, I think the reason is my machine is not
> > fully-loaded. Can you please run
> > ```
> > perf stat --null -r 10 perf test -vv "BTF general"
> > ```
> > And provide the output?
> 
> root@number:~# grep -m1 'model name' /proc/cpuinfo 
> model name	: Intel(R) Core(TM) i7-14700K
> root@number:~#
> 
> root@number:~# perf stat --null -r 10 perf test -vv "BTF general"
> 106: perf trace BTF general tests:
> --- start ---
> test child forked, pid 47824
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> String augmentation test failed
> ---- end(-1) ----
> 106: perf trace BTF general tests                                    : FAILED!
> 106: perf trace BTF general tests:
> --- start ---
> test child forked, pid 47842
> Checking if vmlinux BTF exists
> Testing perf trace's string augmentation
> String augmentation test failed
> ---- end(-1) ----
> 106: perf trace BTF general tests                                    : FAILED!
> ...

I also see the failure on not fully-loaded machines (both Intel and
AMD).

  $ sudo ./perf test -v BTF
  --- start ---
  test child forked, pid 525025
  Checking if vmlinux BTF exists
  Testing perf trace's string augmentation
  String augmentation test failed
  ---- end(-1) ----
  106: perf trace BTF general tests                                    : FAILED!

Thanks,
Namhyung

