Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7011BC9ED;
	Thu, 31 Oct 2024 17:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730394730; cv=none; b=tKSg4fZeJII3hwENMWBz2Xsyt9Xcc0N2JLnEVW8ciVqjYMgcbnW5+bf2MZuMoth+LdfwlIjGV/r4cJtxtbjNeicXjGptfVhP7YHRXlwxJo/JPD0H6Wqosw3Rpw0+/x5ikTv0D9vAeWXA4HrNkJ0OeqNE07eMsnva5zgTs3lAHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730394730; c=relaxed/simple;
	bh=wdZjND10ZDR0BKVDfmJVj4J9wRcZcCoyeS77rnzJKd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uvIaN9ppmpLy3+xtbqiGMlCsi6SAkpUFcN9A/kfLN+ianMFfvS0s5idscDi7GJvYrm08vmVBzACOCHd88YLaZEgIXqdhodWZo+Csf+WvyJS1Aqzznd+UXBiUQdNFO5JLnNzoGCabNGEUTCVbCaKOTkuFaDRS+aPpTVn22txbd4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ur8ozKtj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ur8ozKtj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF73EC4CED0;
	Thu, 31 Oct 2024 17:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730394730;
	bh=wdZjND10ZDR0BKVDfmJVj4J9wRcZcCoyeS77rnzJKd4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Ur8ozKtj2ceXFDw5ULGoxUJjRcPor86j7eLO6b/r1h3UkZeEg/5aIy7j2blrpQ+8j
	 yIQkzZPFtKZh6hoD+Y8PGDGgCz65EexPbJtz1yLH8yKZkDgJnk4V3ilKQEzkjRiU28
	 wpbyGccdERTjCdEyq9ZkaAippZS7F3akk1mnjjbPEboaGJW2hbRZyB2KoZuc8a0beg
	 TEmjKXjeaylaKwxAYnDhXAa89N2LCwvI3luB7i9tTBOvMLXzSZ0pyDXn14TKFGk4dM
	 dHkPSMMZI1nETTaloHpqIUAjmtqULnGC3GJQUGK6bf6i1IIUsPz++D1S8vVlySR2h5
	 ADXiOLljTMTQA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@linux.intel.com>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
 linux-perf-users@vger.kernel.org
In-Reply-To: <ZyE3frB-hMXHCnMO@x1>
References: <ZyE3frB-hMXHCnMO@x1>
Subject: Re: [PATCH 1/1 perf-tools-next] perf ftrace latency: Fix unit on
 histogram first entry when using --use-nsec
Message-Id: <173039472974.1704862.14503122898372001335.b4-ty@kernel.org>
Date: Thu, 31 Oct 2024 10:12:09 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 29 Oct 2024 16:29:02 -0300, Arnaldo Carvalho de Melo wrote:

> The use_nsec arg wasn't being taken into account when printing the first
> histogram entry, fix it:
> 
>   root@number:~# perf ftrace latency --use-nsec -T switch_mm_irqs_off -a sleep 2
>   #   DURATION     |      COUNT | GRAPH                                          |
>        0 - 1    us |          0 |                                                |
>        1 - 2    ns |          0 |                                                |
>        2 - 4    ns |          0 |                                                |
>        4 - 8    ns |          0 |                                                |
>        8 - 16   ns |          0 |                                                |
>       16 - 32   ns |          0 |                                                |
>       32 - 64   ns |        125 |                                                |
>       64 - 128  ns |        335 |                                                |
>      128 - 256  ns |       2155 | ####                                           |
>      256 - 512  ns |       9996 | ###################                            |
>      512 - 1024 ns |       4958 | #########                                      |
>        1 - 2    us |       4636 | #########                                      |
>        2 - 4    us |       1053 | ##                                             |
>        4 - 8    us |         15 |                                                |
>        8 - 16   us |          1 |                                                |
>       16 - 32   us |          0 |                                                |
>       32 - 64   us |          0 |                                                |
>       64 - 128  us |          0 |                                                |
>      128 - 256  us |          0 |                                                |
>      256 - 512  us |          0 |                                                |
>      512 - 1024 us |          0 |                                                |
>        1 - ...  ms |          0 |                                                |
>   root@number:~#
> 
> [...]

Applied to perf-tools-next, thanks!

Best regards,
Namhyung

