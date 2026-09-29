Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A2A54248D2
	for <linux-perf-users@vger.kernel.org>; Tue, 29 Sep 2026 06:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790663758; cv=none; b=aHZjh5tGiaMFpjtuPgxJmNlCzxgHvZ4YIigaNhYcMDl9j/1zpJcvRT9MylraL5Hw4o2npahjTzDNQSrFsFo6/JZLzjJkE1VPDPkKINbk85UWuqVKZO5V5Rk5L/sA+6TS5iTHBNZKkvjJ65MHqWTnBsi5+lIcVQQlOKfVJfXu8/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790663758; c=relaxed/simple;
	bh=g2y4Vxo6jYkZTXryjxqKUnTbfmknMzguM221t/Bf5aI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gyu57S1CiAKFycdLaQ/PVMDxLYv8fdaQAPgPGWupeDQp5xFkzIg6ZkoVN9Sr29QoJpk7WBIM1Mm0hH4Ku0Q3fsimt8kfao/7K0Rxh9nkwcL40v6+NQDVU7xlYCGWbos/H5U0hELMdEiUckB+4EM9hYrs6+2XNq2kHuazh/YIlho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7t5uwvk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7t5uwvk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB8F31F00893;
	Tue, 29 Sep 2026 06:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790663757;
	bh=9TObi4OTtWoCVMhpBr00WZS8RnR9B6aMmb4BdKDMrw8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l7t5uwvkDuo8+c2klh0FS9oOMjfbnJQkoCpPXNFv8IBsTM4qW18VQ4HrlPBEGtezC
	 q+Fk+DeIv3PLmiKVo/UKwceSyFH62n4xtEjLPDa4fPepLF/0+8O7yv1xh6POTBOCj2
	 UFt3AZ0o7lLJrjygfXyDWUAyy8UGaYclDsokbxwJrXJ5qjMn+j7E6SUoRZlg6KsNBD
	 2VGS9hEc2U14mFZTHdTJlMTE4Mb+mfynof0dwuKxQX1Q0RZO9EVVnHKtHM11cn+FX6
	 JbRsoNxJbYLZ7jksmM2f8fncKGpVlzeuQZ6TmWTOaUjzEEm9W4/JqJx+UgQQIYtpe1
	 cERcu2ZJM5sbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/9] perf test: Reduce overhead and contention in
 Python shell tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260929062937.374137-7-irogers@google.com>
References: <20260929021913.56010-1-irogers@google.com>
 <20260929062937.374137-1-irogers@google.com>
 <20260929062937.374137-7-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 06:35:56 +0000
Message-Id: <20260929063556.DB8F31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When all Python shell tests run concurrently during 'perf test' under
> heavy load:
> 1. Unfiltered 'perf list' initializes all hardware PMUs and metrics in
>    each test process; use 'perf list tracepoint' when checking for
>    tracepoint events.
> 2. Running 'perf record' without '-B -N --no-bpf-event' synthesizes BPF
>    events across the system and caches build-ids into ~/.debug; add
>    '-B -N --no-bpf-event' to all Python shell test recordings.
> 3. Drop '-a' in test_check_perf_trace_python.sh,
>    test_rw_by_file_python.sh, test_rw_by_pid_python.sh,
>    test_rwtop_python.sh, and test_syscall_counts_by_pid_python.sh where
>    only a single child workload ('dd' or 'sleep') is tested, avoiding
>    system-wide /proc synthesis and ringbuffer contention.
> 4. Add '-W 1' to 'ping -c 1' in test_net_dropmonitor_python.sh and
>    test_netdev_times_python.sh, and narrow 'compaction:*' to
>    'compaction:mm_compaction_begin,compaction:mm_compaction_end' in
>    test_compaction_times_python.sh.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929062937.3741=
37-1-irogers@google.com?part=3D6

