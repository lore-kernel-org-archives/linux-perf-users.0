Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88869399001
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jun 2026 07:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782198556; cv=none; b=afPxOppy5ywg1hDYaQm9XLghuM2ULzjpUuzHiu15M5gPhgI2N1SPlrWpJ35EqPHw2mqAh0fyC1hDj4mMvi0LFcmUfy3ncJ6QkRD9xs9hrIU31eEBj4LYMs7/MTPd6rK6mkPKWzzPEyhF6dTKitNGE6oy55NcSDASw45snMgF1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782198556; c=relaxed/simple;
	bh=+6mI9SRA1q3U8czgc4vlThTKXVFRwsevUkHo2gMqAHQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UcajhHgFQkNypz/sAqe1KvjpEDcH3kv8DeMmTHjXNTq3oAhq/dPpztZ1lVVITA59L0nmoA/a0qHFoB4QvZ9hFziwS0RuvIfD+EHtlOareVhdjSl3HXQvWtFY67gplvBothzn/TM4F+j3+dvh53hyDT9TJjkvGeel4/jgS0RdeG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NFBJqOem; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NFBJqOem"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B291F000E9;
	Tue, 23 Jun 2026 07:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782198555;
	bh=exRNx4K1NYP6xPLpT9U98VQWSMxGWu/ISaf6MwRpZZs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NFBJqOemLwU38d7jLCrMM1m8QWR0OH8fu6+0Eb3W+5gomPStXxtrcSnLQ+Mi6ZeBk
	 rFbTLlgyc5alsxRgiuYd6U2nNcppI4r/3Sp503Zd2/keldqb1wSvSLZ/R9xH5t3kdc
	 pWWomvXm5C6nwTaa0IbSasSltxa9/BATlQjPpzMorMxAkWhKe0/MbdBFDFjI0acNI8
	 pUMxczhaPU74girhM0Q92WRGfj5WbaW0RbJWofR2xCLMGRThZQ0MA2bwQR6e6nwwlc
	 UhiVRb1CaHQjQ7pEMIr4XuOzK8lZoa8gzkHW4xniT6NBABIcn47lwat1qM75ZIWcrW
	 OXnQAXlFP+P0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] perf test: Simplify perf kvm record/report tests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Namhyung Kim" <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260623070313.55225-5-namhyung@kernel.org>
References: <20260623070313.55225-1-namhyung@kernel.org>
 <20260623070313.55225-5-namhyung@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 07:09:14 +0000
Message-Id: <20260623070915.16B291F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The synchronous `perf kvm record` command is not wrapped in an e=
rror-checking conditional, causing the script to unexpectedly abort via `se=
t -e` upon failure.
--

commit a940fab65237cd8e4c37035fe66af932fcd3f955
Author: Namhyung Kim <namhyung@kernel.org>

perf test: Simplify perf kvm record/report tests

This commit simplifies the perf kvm tests by passing sleep directly as a
command line argument to perf kvm record, rather than running it in the
background and manually killing it.

> diff --git a/tools/perf/tests/shell/kvm.sh b/tools/perf/tests/shell/kvm.sh
> index f88e859025c42..4ca10388748de 100755
> --- a/tools/perf/tests/shell/kvm.sh
> +++ b/tools/perf/tests/shell/kvm.sh
[ ... ]
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
If this command fails, will the script abort immediately due to set -e being
enabled globally?

The previous implementation guarded against non-zero exit codes by using
wait "${rec_pid}" || true. Without an error-checking conditional or an
appended || true, a failure during this synchronous execution could cause t=
he
script to instantly terminate.

Would this bypass the test's intended logic of recording the failure (err=
=3D1)
and accidentally skip subsequent tests like test_kvm_buildid_list?

> =20
>  	echo "Reporting kvm profile..."
>  	# Check for some standard output from report

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623070313.5522=
5-1-namhyung@kernel.org?part=3D4
