Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B6F288C2D
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Jul 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695453; cv=none; b=YxQRiajgyDYbCr1XOQfXM2ylC5g7st7iXtAY6jTKi9bd9AMIizFHS6qz0XKVrtB5vRh+QjRY/ycdQFgaPJ5hxmFFlH0+A+oti3A3KpVB7b3Jm4C4CarPdt9dfj2JNoKbH4gGDgS7Qr2oRdw5hTc96TRa8nnHv+8WIwuvyuauNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695453; c=relaxed/simple;
	bh=31e8gb9TO33bGHxGoA9Hhsgm/0TsTxjbZY1hpcYUQ5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBa+RtsYoZjN+Nf4Wm6eaGWJ11T0d2mxKf/dEEwS3rsb5E+5tLJNLuviTU0j4H9sUieMk0tnDmUZh1SeAuaEsk7oUu/ZsWebT+ZDPcagNF0RrpIpIQDqvn4ZW7stQE+W41n7ur2xwke1K3C7cTvwdicrc0TmRVgFEWNg0+Rnxpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPPXAAcS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPPXAAcS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0EDC4CEE7;
	Wed, 16 Jul 2025 19:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752695453;
	bh=31e8gb9TO33bGHxGoA9Hhsgm/0TsTxjbZY1hpcYUQ5s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kPPXAAcSVsmTwoyC1bRGGIX6T7tF1ooQTaVMUl47FT/6bOlI326T5DI3rZ3ppcJdN
	 0dla3I220/EUJ4kFPp7DaE6GyQHfvUTxx8mj8bRvvn9pPGns6s2VGVIeGcYyHTNt3L
	 5FQY3F1ypiDp7sLVZmI25STW7hmbH8GnJHSiFqjtFswuCced2GyHGuo6PgFEApMkND
	 sGTPGZwZvjaMFyufhG3MyultKXyC59FuZ+eb1hu4Ts7sM5Go3PD1S6hHcH4QlVSNlo
	 DcHCl6dvHyEHkcMgVgVgJhabumXJ0AEfIoXKhp01UHKfzKLLZajISh0Hn8e3D9hEim
	 KHK7doj7L6srA==
Date: Wed, 16 Jul 2025 12:50:51 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: Jan Polensky <japo@linux.ibm.com>
Cc: adrian.hunter@intel.com, irogers@google.com,
	linux-perf-users@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/1] perf test: Increase load in lock contention
 test on low-activity systems
Message-ID: <aHgCmxEZ_bcNeki-@google.com>
References: <20250709203809.3211178-1-japo@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709203809.3211178-1-japo@linux.ibm.com>

Hello,

On Wed, Jul 09, 2025 at 10:38:09PM +0200, Jan Polensky wrote:
> On low-activity systems, the 'kernel lock contention analysis test'
> often fails due to insufficient system load. To address this, the test
> now increases load by using multiple groups and threads in 'perf bench
> sched messaging', scaled to the number of available CPUs.
> 
> Signed-off-by: Jan Polensky <japo@linux.ibm.com>
> ---
>  tools/perf/tests/shell/lock_contention.sh | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/tests/shell/lock_contention.sh b/tools/perf/tests/shell/lock_contention.sh
> index 30d195d4c62f..e859e1503b5c 100755
> --- a/tools/perf/tests/shell/lock_contention.sh
> +++ b/tools/perf/tests/shell/lock_contention.sh
> @@ -44,7 +44,8 @@ check() {
>  test_record()
>  {
>  	echo "Testing perf lock record and perf lock contention"
> -	perf lock record -o ${perfdata} -- perf bench sched messaging > /dev/null 2>&1
> +	perf lock record -o ${perfdata} -- perf bench sched messaging \
> +		--group "$(nproc)" --thread "$(nproc)" > /dev/null 2>&1

  $ perf bench sched messaging -h
  # Running 'sched/messaging' benchmark:
  
   Usage: perf bench sched messaging <options>
  
      -g, --group <n>       Specify number of groups
      -l, --nr_loops <n>    Specify the number of loops to run (default: 100)
      -p, --pipe            Use pipe() instead of socketpair()
      -t, --thread          Be multi thread instead of multi process

The default value of --group option is 10 so it can be smaller on tiny
systems.  Note that it'd create 20 tasks for each group (I don't think
we have an option to control this).

Also --thread option doesn't take an argument so the number will be
ignored.

More importantly, there are several instances of this workload.
Probably we want to change all of them by introducing a shell variable.
But I'm a bit afraid how much overhead it'd bring up.

Thanks,
Namhyung


>  	# the output goes to the stderr and we expect only 1 output (-E 1)
>  	perf lock contention -i ${perfdata} -E 1 -q 2> ${result}
>  	if [ "$(cat "${result}" | wc -l)" != "1" ]; then
> --
> 2.48.1
> 
