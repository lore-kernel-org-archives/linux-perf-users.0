Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FD3240225;
	Mon, 13 Jan 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736783846; cv=none; b=FgvtTK8f0IY9VoRORceLgWO8AQXUAmkFnKv0ytZC1kSOIXfC+cfcT6sA309UDIETyqi/E3XpmOytYUZR4o8GFbYlVmG2ET2KDT5ZXfqwBUmrRRqmLHfqLbzLeYbtie1UyhIPyINyg7qxKoyxCSZaz+ks60wXyhO1h2APcpPLWYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736783846; c=relaxed/simple;
	bh=qt2ooosAU3+t17LW0tjL1W4HlfJ0Lpf9y7jSjh8N1fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/AwbvK8n0FhxSrPo8w+a975WRjWH1tLEzDZR8A9/Ml77SScM51xHuNws1uCIAhiLXW1zisI2PEwQdXqU9QghBIq5fAWvaOXOag4gYxb6V+4Yh/3IOlCapXs99F4ZLVnfZwaDDYa3gf2vSOlJZgkEDQfJQVcbMxDw4zZmvAlUos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHmaHW3C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHmaHW3C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5923C4CEE1;
	Mon, 13 Jan 2025 15:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736783846;
	bh=qt2ooosAU3+t17LW0tjL1W4HlfJ0Lpf9y7jSjh8N1fQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHmaHW3CcqF3fna89xHfpFlgdvdr70jNylkrDcaCQ54SgP1AWBc4VrAk6d/w74fb3
	 PNKw4OOsv3AjSqnxwqg4aKlKJo6zXAtRRZwINd2W2yVOsMqkTkoYBdKufU9Tz/R4HX
	 m0ztSK3PAX/kcQITCUKg4PApVBUlywKG4rRi1wSoIQcjDGEjGoVDqXiG3OBVlh2nIS
	 6D+9x54qr7vUG9ltl+8RxEdsv49L5dY60+QOMc+koQqLokHjLSBnqqUQE/zaLaLUJt
	 kTYj2dF+Sjd7VdoOAzRQkLsHRBzqFi3vuRayxJxzQrMC6m0RCRIn0TBu0dAgGpEb35
	 7cfeLT+gl7dNw==
Date: Mon, 13 Jan 2025 12:57:23 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: Namhyung Kim <namhyung@kernel.org>, mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com, jolsa@kernel.org,
	irogers@google.com, adrian.hunter@intel.com,
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] perf trace: Add more tests for BTF-augmented perf
 trace
Message-ID: <Z4U343yQUDF3H7qs@x1>
References: <20241215190712.787847-1-howardchu95@gmail.com>
 <Z2CGdi5xpJy6C6sv@google.com>
 <Z2mzzytPOpjF0Hxe@x1>
 <Z2m8qzyLdm1BEYuF@x1>
 <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH0uvoga29=0iF69A5uHN+nbB458LeW+WDWHNnoQV4msVm9zDQ@mail.gmail.com>

On Fri, Jan 10, 2025 at 04:52:08PM -0800, Howard Chu wrote:
> Hello Arnaldo,
> 
> On Mon, Dec 23, 2024 at 11:40 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > On Mon, Dec 23, 2024 at 04:02:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > > On Mon, Dec 16, 2024 at 11:58:46AM -0800, Namhyung Kim wrote:
> > > > On Sun, Dec 15, 2024 at 11:07:09AM -0800, Howard Chu wrote:
> > > > > Changes in v4:
> > > > >  - Use if -f to check the existence of vmlinux BTF, and exit if it
> > > > >    doesn't, so trace_test_string will not overwrite $err, and keep
> > > > >    running the test.
> > > > >
> > > > > Changes in v3:
> > > > >  - Add vmlinux BTF check, and skip the tests if it doesn't exist
> > > > >
> > > > > v1, v2:
> > > > >
> > > > > The previous version of the perf trace BTF general augmentation tests
> > > > > didn't pass Shellcheck (thanks to Arnaldo Carvalho de Melo
> > > > > <acme@kernel.org> for pointing this out), this version uses bash instead
> > > > > of POSIX shell to pass Shellcheck.
> > > > >
> > > > > This patch series also adds documentation for the new option
> > > > > --force-btf, which is used in the tests.
> > > > >
> > > > > Link: https://lore.kernel.org/linux-perf-users/Zt9yiQq-n-W6I274@x1/
> > > > >
> > > > > Howard Chu (2):
> > > > >   perf trace: Add tests for BTF general augmentation
> > > > >   perf docs: Add documentation for --force-btf option
> > > >
> > > > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > >
> > > Thanks, applied to perf-tools-next,
> >
> > It fails when running in parallel mode, sometimes:
> >
> > 109: perf trace BTF general tests                                    : FAILED!
> >
> > Then:
> >
> > root@number:~# perf stat --null -r 10 perf test "BTF general"
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : FAILED!
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : FAILED!
> > 109: perf trace BTF general tests                                    : Ok
> > 109: perf trace BTF general tests                                    : Ok
> >
> >  Performance counter stats for 'perf test BTF general' (10 runs):
> >
> >              2.148 +- 0.293 seconds time elapsed  ( +- 13.63% )
> >
> > root@number:~#
> >
> >
> > So its not just when running in paralell, anyway, its merged, we can go
> > on from what we got there.
> 
> It never fails on my machine, I think the reason is my machine is not
> fully-loaded. Can you please run
> ```
> perf stat --null -r 10 perf test -vv "BTF general"
> ```
> And provide the output?

root@number:~# grep -m1 'model name' /proc/cpuinfo 
model name	: Intel(R) Core(TM) i7-14700K
root@number:~#

root@number:~# perf stat --null -r 10 perf test -vv "BTF general"
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47824
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47842
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47860
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47878
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47896
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Buffer augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47917
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Buffer augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47938
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Testing perf trace's struct augmentation
---- end(0) ----
106: perf trace BTF general tests                                    : Ok
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47962
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
String augmentation test failed
---- end(-1) ----
106: perf trace BTF general tests                                    : FAILED!
106: perf trace BTF general tests:
--- start ---
test child forked, pid 47980
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Testing perf trace's struct augmentation
---- end(0) ----
106: perf trace BTF general tests                                    : Ok
106: perf trace BTF general tests:
--- start ---
test child forked, pid 48004
Checking if vmlinux BTF exists
Testing perf trace's string augmentation
Testing perf trace's buffer augmentation
Testing perf trace's struct augmentation
---- end(0) ----
106: perf trace BTF general tests                                    : Ok

 Performance counter stats for 'perf test -vv BTF general' (10 runs):

             1.166 +- 0.272 seconds time elapsed  ( +- 23.34% )

root@number:~#

