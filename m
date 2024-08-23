Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E36184544;
	Fri, 23 Aug 2024 13:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724418920; cv=none; b=m5yAWdBMQjZzBBfbQjKHOU/mr31/Ur01yMxMY6TRgYcSnfOwfVq6a6wLbsPIxnsed7G/aSOyUNwWD7jtNYt2fDFt8uUvFbNo8kN+GyDCBsAnZAmnT98+c+pj6FEPmrqHiQrLt2btnyo1wkIXojReYFqTH+xyEJ0VDCRoyeh9+Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724418920; c=relaxed/simple;
	bh=OsnZhEozgd8AMRsm0tfJjU7ndQ6UcudKoDyQM0UzRCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daJYf8mvTV91zN0CnUgSPmaoZnQPe5H8oq1QJqIffLIwewPYBRt4stGf7cd35ehZd6ksj78Y7w4DwRSSAFC908AVsSvg99AHjD9m4oHnI8JKyGKmg68UecbrfgrVUQBu7Zy/UXJi3zIDBenAgyneH3StXJJsP0dNPK6Kim9Majw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LcnOjdvJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LcnOjdvJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22725C32786;
	Fri, 23 Aug 2024 13:15:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724418919;
	bh=OsnZhEozgd8AMRsm0tfJjU7ndQ6UcudKoDyQM0UzRCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LcnOjdvJ915qgQQPN3X1UBwBXjA8HWeE5McQzHvZJ1EO14ZrCSh17wRppX1tB1voU
	 yvmUjyfOeuK/MXKKig1UQoEbR4rLMIYcRmjYQPkok8hYkP5D5uht/SXFNKJBox5FHp
	 jKA4LJbOl8fJKu/Tks1y6M29239a0LnmxgEjWdH/0RqDwObH7k6zXYDEOEB7PDNdFO
	 g1BCqwWRVHXN5Ysdhn82OLj5cBLfA2FRli7hP3I4drm3pATkz7OgHe4jw4S+PvMHSn
	 +cO4DpqfssJEzKCrDsrUIZj7kPh65T0ajMvcRhc/FlkN8YIR5Onwixlm9Y6wF2+7oj
	 i2oWrWIYN6aag==
Date: Fri, 23 Aug 2024 10:15:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Howard Chu <howardchu95@gmail.com>
Cc: adrian.hunter@intel.com, irogers@google.com, jolsa@kernel.org,
	kan.liang@linux.intel.com, namhyung@kernel.org,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] perf trace: Pretty print struct data
Message-ID: <ZsiLZCo4vfER18t3@x1>
References: <20240815013626.935097-1-howardchu95@gmail.com>
 <20240815013626.935097-7-howardchu95@gmail.com>
 <ZsiDhSPs4XYX4VP9@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZsiDhSPs4XYX4VP9@x1>

On Fri, Aug 23, 2024 at 09:41:41AM -0300, Arnaldo Carvalho de Melo wrote:
> One other thing I think that the skel patch should come before these,
> so that at this point in the series I could _test_ struct printing.

So I did that, need more polishing I have now:

⬢[acme@toolbox perf-tools-next]$ git log --oneline -10
78bb4b917b942f7d (HEAD -> perf-tools-next) perf trace: Pretty print struct data
027ae076fa7bc068 perf trace: Pass the richer 'struct syscall_arg' pointer to trace__btf_scnprintf()
4f2ac4e8a8d9488a perf trace: Add trace__bpf_sys_enter_beauty_map() to prepare for fetching data in BPF
545008dcff9e06f6 perf trace: Collect augmented data using BPF
0b5a34a3cf98843a perf trace: Fix perf trace -p <PID>
23da4ec3640538fa perf evlist: Introduce method to find if there is a bpf-output event
00dc514612fe98cf perf python: Disable -Wno-cast-function-type-mismatch if present on clang
b81162302001f411 perf python: Allow checking for the existence of warning options in clang
1cfd01eb602d73b9 perf annotate-data: Copy back variable types after move
895891dad7353d60 perf annotate-data: Update stack slot for the store
⬢[acme@toolbox perf-tools-next]$

And the comment on the struct pretty printer, added to the patch where
it is introduced.

Committer testing:

After moving the changes to the BPF skel to _before_ this patch, we're
able to test this patch at this point in the series:

  root@number:~# perf trace -e connect ssh localhost
       0.000 ( 0.008 ms): ssh/762249 connect(fd: 3, uservaddr: {2,}, addrlen: 16)                          = 0
       0.014 ( 0.005 ms): ssh/762249 connect(fd: 3, uservaddr: {10,}, addrlen: 28)                         = 0
       0.030 ( 0.032 ms): ssh/762249 connect(fd: 3, uservaddr: {10,}, addrlen: 28)                         = 0
  root@localhost's password:     63.031 ( 0.035 ms): ssh/762249 connect(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) = 0
      64.037 ( 0.024 ms): ssh/762249 connect(fd: 4, uservaddr: {1,{['/','v','a','r','/','r','u','n','/','.','h','e','i','m',],},}, addrlen: 110) = 0
 
  root@number:~# strace -e connect ssh localhost
  connect(3, {sa_family=AF_INET, sin_port=htons(22), sin_addr=inet_addr("127.0.0.1")}, 16) = 0
  connect(3, {sa_family=AF_INET6, sin6_port=htons(22), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
  connect(3, {sa_family=AF_INET6, sin6_port=htons(22), sin6_flowinfo=htonl(0), inet_pton(AF_INET6, "::1", &sin6_addr), sin6_scope_id=0}, 28) = 0
  connect(4, {sa_family=AF_UNIX, sun_path="/var/run/.heim_org.h5l.kcm-socket"}, 110) = 0
  connect(4, {sa_family=AF_UNIX, sun_path="/var/run/.heim_org.h5l.kcm-socket"}, 110) = 0
  root@localhost's password:

Which while getting the struct contents produces an end result that 
conveys less info than the specilized connect BPF program we have, so we
need to only use this generic BTF dumper approach when we _don't_ have
an specialized one, at least at this point.

In the future we really should get the BTF dumper to use the more
specialized pretty printers that knows about how to pretty print network
specific addresses based on the network family, etc.
