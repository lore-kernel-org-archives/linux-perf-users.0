Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2919D3955CF
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 21:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782251850; cv=none; b=mDNtE7eveCO2AwMWTKxSGd/ln4kygniNqjVw/JsOoHpkss3Y6Jq/mN4BDFTVM6Vw8FR9JVIe5m+pmsMGPAhuZ7a/irCdhHUEf8GC5NWnPNJzwJOOuZfQG+t13uaJ0m0ld1kUbqdh67/L65O33fL5oWChRvf9pvm7EqqLe+GLgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782251850; c=relaxed/simple;
	bh=hJKmK2GucSp1Tx5pMzufZTONbuuV3d6NkqFBZVcia9E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tqf74pSku/tVr0DWsxwUBrC6vVv/rztUbxZ36mHCfwNK5kxBRiuueHROxc4xYdnL0HqlPmJfnnFswgwRkkO5H+GS2+1iO8B1cOYGGJiiRrL7wL2L5DxI6m84a+FhI0Ke07ebvNLRnys+Sgy2cpq/BxiznlxXDx7GGbuw7lCm+to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbuY8iRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbuY8iRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 947A21F000E9;
	Tue, 23 Jun 2026 21:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782251848;
	bh=PC+s7VozN349OFE1YpxUjD+ENcnUVXD6ZpIgxq3YS4M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AbuY8iRVrph3lVDGcHihYoHJMkgB82ZCTVDej+6lsVtctoiWDs1z3QG7M6SdAIRxA
	 1W1MdhKEU1ryC9FWxc62Xz5t5SJW318ASLWTtW/9Pv1iKd1qCIXOn00RBLkt5wUech
	 aF4Spzzbr77qieF2OPHsJ+vt0/BIT11v8eKu4UGC3mnSIMvx8JXCZmKB2peixcjLVw
	 vVUyvkPAhM8ryRoTdn7yRUNVG1jm0fdsar7AGsDS8C2VikMVENm3HNqXZJvem5yVz1
	 kOkSBNtetFZgXXkOl6fdkZ1/aNlm9bXtcZHb1P2wxd9OwV0yBA+sRcwa+JWfKWvoho
	 D/fKBLV+KEGtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] perf test: Simplify perf kvm record/report tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623191439.3621593-7-namhyung@kernel.org>
References: <20260623191439.3621593-1-namhyung@kernel.org>
 <20260623191439.3621593-7-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 21:57:28 +0000
Message-Id: <20260623215728.947A21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Unwrapped command execution in test script with `set -e` causes =
premature exit on failure.
--

commit 3ce1271a163998e293f818fbfbc37ed07914f209
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Simplify perf kvm record/report tests

It can now pass command line arguments to perf kvm record --host.
Let's pass 'sleep 1' directly rather than running it in background.

> diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> index f88e859025c42..4ca10388748de 100755
> --- a/tools/perf/tests/shell/kvm.sh
> +++ b/tools/perf/tests/shell/kvm.sh
> @@ -63,13 +63,7 @@ test_kvm_record_report() {
>  	echo "Recording kvm profile for pid ${qemu_pid}..."
>  	# Use --host to avoid needing guest symbols/mounts for this simple test
>  	# We just want to verify the command runs and produces data
> -	# We run in background and kill it because 'perf kvm record' appends op=
tions
> -	# after the command, which breaks 'sleep' (e.g. it gets '-e cycles').
> -	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" &
> -	rec_pid=3D$!
> -	sleep 1
> -	kill -INT "${rec_pid}"
> -	wait "${rec_pid}" || true
> +	perf kvm --host record -p "${qemu_pid}" -o "${perfdata}" sleep 1

[Severity: Medium]
Since this script runs with set -e, will a failure in perf kvm here cause=20
the script to exit immediately?

The previous backgrounding implementation handled failures gracefully using
wait "${rec_pid}" || true. If this new foreground command fails (for exampl=
e=20
due to restricted perf_event_paranoid settings), it seems the entire test=20
script will abort early and skip the remaining tests instead of accumulatin=
g=20
errors gracefully.=20

Should this be wrapped to catch failures, or append || true to prevent a=20
premature script exit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623191439.3621=
593-1-namhyung@kernel.org?part=3D6
