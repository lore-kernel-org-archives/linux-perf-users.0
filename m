Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96D944A71E;
	Wed, 12 Aug 2026 21:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786568880; cv=none; b=CcyVUUG3VriUwwWto5vpc5K50VX3ELjE+kFrjH+mefkFeFKlaz/r9ENgzJ7xagp0rZYydFQJSMd/PDc6T3wvXoQe2jpvaaZ3UpFmEMQVyeyI4uKsYqeOK91FifHDgyxpeb0NIHpMD2tL/AvqW7JS08VqKf9Q5KavcR9ueODm+XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786568880; c=relaxed/simple;
	bh=jkISh4epTP2Jl1ZtZblGXzMLbe2O0ArNNOJumNFLOcM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=frzF8j4AJteIEggHVdIgFNm4kpJeL/N2cKXpS7Q9XZvfl9LlbPTPUWH39nLfBgwnLIamTxW63n1DmTKLSc8OZDp6v5Lk9KoW1gH11pnthiAvREiAN6IcNxmy+rVutW5YC4LoGVletR4AMkQF/SrDQ9nmF8iOYpqeBpO5q3GVuVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h4FZtBu3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h4FZtBu3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02DD31F000E9;
	Wed, 12 Aug 2026 21:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786568879;
	bh=ADdm3h5XUSUwintO19vKtxNZfiL20jawn4vPjKSiuZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=h4FZtBu3j1i+CBOaab3DunB78J39DxTCv4CXZ7FDSCC7ZgRqj/3vf4skOPOmhLWhf
	 JoiFlTxwIDt/sBDjgK1I+RUYwRq89I9G02sQfynO8GWVq4dPpAr3G0PhRGHhzxfjKz
	 aW3XN51tSzKWs/NL0ELKbX8QBbMrCHuD/tFTJF9U2NzxCaqTnTpcQCGLHmNlFTsQTV
	 V4HlQnfIsif9e6r2Yo4uOazLiRwnkmvAw1ai+n1JnuJpJfM6ObM14tfSTpSaDIHz3g
	 GU2zBWLUplWjBtCqe6vs/WxiN6eUG83QoiTuJ10vGWRJGgBnIKazw94EXL7Vuf+6Ck
	 mPD/BYR7YBDOg==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, 
 Michalis Niarchos <michael.niarchos@gmail.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com>
References: <20260807-perf-kvm-leaks-v1-0-7b5e2f97905a@gmail.com>
Subject: Re: [PATCH 0/2] perf kvm: Fix memory leaks
Message-Id: <178656887896.4021779.4825437848306350814.b4-ty@kernel.org>
Date: Wed, 12 Aug 2026 14:07:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Fri, 07 Aug 2026 17:08:34 +0200, Michalis Niarchos wrote:
> Running ./perf kvm stat report with ASan, revealed some memory leaks:
> 
> ==206006==ERROR: LeakSanitizer: detected memory leaks
> 
> Direct leak of 72 byte(s) in 3 object(s) allocated from:
>     #0 0x7ff86bf2bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
>     #1 0x55f42795a0d5 in zalloc ../../lib/zalloc.c:8
>     #2 0x55f42782d7f4 in per_vcpu_record /home/mike/git/linux/tools/perf/builtin-kvm.c:929
>     #3 0x55f42782dab7 in handle_kvm_event /home/mike/git/linux/tools/perf/builtin-kvm.c:950
>     #4 0x55f42782fa80 in process_sample_event /home/mike/git/linux/tools/perf/builtin-kvm.c:1159
>     ...
>     #14 0x55f42783236c in read_events /home/mike/git/linux/tools/perf/builtin-kvm.c:1591
>     #15 0x55f4278326f8 in kvm_events_report_vcpu /home/mike/git/linux/tools/perf/builtin-kvm.c:1636
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


