Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12A38645A;
	Tue, 14 Apr 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186719; cv=none; b=c/jfHffLlps/Y3fG2EDyrvR2vNfwliloBj2PNFLyM69tr2MSB3T/0kzdeNKo8AgzyFK+TQo0ZdQ2pvuSGxK7dyCWcn7uFh1QZyOm1KVkg/WsSBOHbsIBxGTL79pz2We6yo5ApHfnvtkzIw5Iq3T66DQpVBOtARBGmxu55RdL1XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186719; c=relaxed/simple;
	bh=Ar7RX6JFgB8rBeEnJk9e5+X0DDbGIR5D3AOMEqFlWz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WkFElztjX6Qhl32RE2SEgzb5EMCW4uIzjUnXjJ+qHkx2FCVlTl+D0o2dRf0ALjobxkxIeJl/rgD9JM3EJoof2g0K7exM8m2HGwM+CgT2TcbdXulvsp4FRx8z1rO+zBPK+nLqgh7qgZvmEn1qPRtWhcwk2cuIUiQi+IS1dDLtilM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4dA2s2a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4dA2s2a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CA6C2BCB4;
	Tue, 14 Apr 2026 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776186719;
	bh=Ar7RX6JFgB8rBeEnJk9e5+X0DDbGIR5D3AOMEqFlWz0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A4dA2s2aLoJoB8IdgYXwd4BOtK9B4HMTnTSOVJVMfRpGxKLuY7nv4AitS30L6bw6G
	 7UqCpCsLwm+RPZguSCpAXiHHbo3FfRv5KeV5uMHSPDKJik36d4ngmyyJzfH38lqBUP
	 mtKj7JWj3ELjsZixnAHoIxR0wuFaROlgcc5htVORWd59bq3bHrSiKrfdQxP8LCSw4j
	 /4K0Z5WaUtHIXxMoy4/WZfNNofmOsDw1+7MXrnQvC6mW92KKpmaj9c9SAMQHG3WihK
	 b2ZyHxzJ4sbnyKQdZ2olMhtf2g9NcSjV30MHjQJZPCQtpfZv5ZsTqzPc+kpJiB3A5l
	 /r++033ovvP1A==
From: Namhyung Kim <namhyung@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Markus Mayer <mmayer@broadcom.com>
Cc: Perf Mailing List <linux-perf-users@vger.kernel.org>, 
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20260409221418.185343-2-mmayer@broadcom.com>
References: <20260409221418.185343-1-mmayer@broadcom.com>
 <20260409221418.185343-2-mmayer@broadcom.com>
Subject: Re: [PATCH 1/1] perf build: fix "argument list too long" in second
 location
Message-Id: <177618671857.1519819.1753860642898915391.b4-ty@kernel.org>
Date: Tue, 14 Apr 2026 10:11:58 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Thu, 09 Apr 2026 15:14:17 -0700, Markus Mayer wrote:
> Turns out that displaying "RM $^" via quiet_cmd_rm can also upset the
> shell and cause it to display "argument list too long".
> 
> Trying to quote $^ doesn't help.
> 
> In the end, *not* displaying the (potentially long) list of files is
> probably the right thing to do for a "quiet" message, anyway. Instead,
> let's display a count of how many files were removed. There is always
> V=1 if more detail is required.
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


