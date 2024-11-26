Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD2D7E782
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732646183; cv=none; b=j/qQUgbNsm3VZ0ZVHXGdGHJiMHzG5vb2GLZUhA/aK8PW+fykETR9dLtX8wXpzf8N+huUA/xCuPo8POMbIFY7FwHk/FSViBsWBaH6hdAy42ubPI4NqNXz3d4SJ6qL8IjEKYSn/dA5kJvCAn/BXrUhnvp4LXIxagTN/Y2lyQlceto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732646183; c=relaxed/simple;
	bh=5NoTwEvyzM55AxuEzd4NK/mKY+JTjZvjmkBthHN41RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJndnQVv1Fe+s29QeL05X852rU76aIdgcieXwuvtMPgll1huyGImAgoCR0UV6mIv4iwUU0GCAwLe2CH2FTjSvKO2cGkcTd3TUfVh6v9H15aH/ciEEq/Mtn3ODfwKnZtNonQnPOpMYWEHig/XwhYrmXDzYtkuCBO1pSSvJU7/VHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1761153B;
	Tue, 26 Nov 2024 10:28:05 -0800 (PST)
Received: from localhost (e132581.arm.com [10.2.76.71])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C6003F66E;
	Tue, 26 Nov 2024 10:27:35 -0800 (PST)
Date: Tue, 26 Nov 2024 18:27:34 +0000
From: Leo Yan <leo.yan@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>,
	Guilherme Amadio <amadio@gentoo.org>,
	linux-perf-users@vger.kernel.org
Subject: Re: perf test for inet_pton probe fails to match stacktrace
Message-ID: <20241126182734.GB15252@e132581.arm.com>
References: <Z0D5FDu/sErQ0V/2@gentoo.org>
 <20241124105053.GA812108@e132581.arm.com>
 <Z0R3ySrb8iZQd17O@gentoo.org>
 <Z0VXvySyHm4q4r2c@google.com>
 <20241126102705.GA15252@e132581.arm.com>
 <Z0X5y-1ZiE-_FnbY@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0X5y-1ZiE-_FnbY@x1>

Hi Arnaldo,

On Tue, Nov 26, 2024 at 01:39:39PM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> Seems to work:
> 
> Before, on a:
> 
> root@number:~# grep -m1 'model name' /proc/cpuinfo
> model name      : Intel(R) Core(TM) i7-14700K
> root@number:~#
> 
> root@number:~# perf test -vF pton
> --- start ---
> ping 229025 [017] 34027.968348: probe_libc:inet_pton: (7fc4542c10d0)
> 7fc4542c10d0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> 7fc4542d5a55 getaddrinfo+0xcf5 (/usr/lib64/libc.so.6)
> FAIL: expected backtrace entry ".*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$" got "7fc4542d5a55 getaddrinfo+0xcf5 (/usr/lib64/libc.so.6)"
> ---- end ----
>  86: probe libc's inet_pton & backtrace it with ping                 : FAILED!
> root@number:~#
> 
> With your patch:
> 
> root@number:~# perf test -vF pton
> --- start ---
> pattern: ping[][0-9 \.:]+probe_libc:inet_pton: \([[:xdigit:]]+\)
> line: ping  231118 [023] 34089.948542: probe_libc:inet_pton: (7f635297f0d0)
> found=0
> pattern: .*inet_pton\+0x[[:xdigit:]]+[[:space:]]\(/usr/lib64/libc.so.6|inlined\)$
> line: ping  231118 [023] 34089.948542: probe_libc:inet_pton: (7f635297f0d0)
> found=1
> line: 7f635297f0d0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> found=0
> pattern: .*(\+0x[[:xdigit:]]+|\[unknown\])[[:space:]]\(.*/bin/ping.*\)$
> line: ping  231118 [023] 34089.948542: probe_libc:inet_pton: (7f635297f0d0)
> found=1
> line: 7f635297f0d0 __GI___inet_pton+0x0 (/usr/lib64/libc.so.6)
> found=1
> line: 7f6352993a55 getaddrinfo+0xcf5 (/usr/lib64/libc.so.6)
> found=1
> line: 55ae71919969 [unknown] (/usr/bin/ping)
> found=0
> ---- end ----
>  86: probe libc's inet_pton & backtrace it with ping                 : Ok
> root@number:~#
> 
> Replace that "unfound" with "Didn't find the"

Will do.

> And using 'found' as a variable name that when zero means "Ok, found"
> and when 1 (grep failed to find the regexp) means "Didn't find" looks
> confusing.

Indeed.  Will refine this.

> General idea seems to make the test resilient to the differences while
> still testing the backtrace in uprobes events for expected entries.

Will send formal patch.

Thanks a lot for the testing,
Leo
