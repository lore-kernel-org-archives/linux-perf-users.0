Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A603518C05
	for <linux-perf-users@vger.kernel.org>; Mon,  8 Apr 2024 23:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712617881; cv=none; b=Sse80F2szrnINZC2WKtjzon2LOkd8Ns3uTNBQT3SyPHpK+nyAAULmIjbd/2zvFsNPfGfQGKwccUKCfLlLni6WnL79EGVEYEeIlzAAQT96/MiWmEjqVbzr/D6E31rgFPH+To4QMBwP31DgpxxWarI4G++5oV7UsMO+lQTp2wt4Eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712617881; c=relaxed/simple;
	bh=A9aKpADHIwvkPA5NFutDZtWUu/BjpCFUH7OgzxGsRy4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MjFiF+bDFGCaqBA3Q1ZM6jP6ZQBhMG9MhJ1YPtkOO6fgEYH6gYpg8i6iuUKmJzXpksA0HVQeOOO3aud4w5ztH8CTNnX/vi+4/7J+Whd7MMiQdJ4z1GES/XjAlwbfFakRLmcLri7FnI1XkG1M5+nJOP77ef8KiluyBm3mBYPlsh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezvF8vUv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezvF8vUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDF86C433F1;
	Mon,  8 Apr 2024 23:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712617881;
	bh=A9aKpADHIwvkPA5NFutDZtWUu/BjpCFUH7OgzxGsRy4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezvF8vUvfGh6m4E5td3G7Ec9hsxx8k+J9IadWGRQeEINpmiuOUh9ZKtvUJROCiVH1
	 v/NhV+UTWXi40Ycb1iLnCRi7DiLS+2rmExQ7AWXda2MOYWC+EvSYkfciAsPenHMEgb
	 zP69PD4rBy1LXUnjRoiDhxzQQLDe4EdVaH1+Vq5Dbu5iGV0s8U3fT+760BkkrKn2uZ
	 sPsD+oJqafDcoDbfWmIavMQm7qM47o1FmHh1fAyA0kWpLPb/ZwUSCBvALEFUAvD7RM
	 Bh+vylE5Ku6Yq0yoY4HGsEnHVNWZ8KPBRVLAfIWkGIuOKv9r96hF9GYMDJBSFIoa5K
	 7NlcfE5qqVopA==
Date: Tue, 9 Apr 2024 08:11:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com, Chaitanya S Prakash <chaitanyas.prakash@arm.com>
Subject: Re: [PATCH V2 6/8] perf tools: Enable configs required for
 test_uprobe_from_different_cu.sh
Message-Id: <20240409081117.beef0c0e192d647aeeb88235@kernel.org>
In-Reply-To: <20240408062230.1949882-7-ChaitanyaS.Prakash@arm.com>
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
	<20240408062230.1949882-7-ChaitanyaS.Prakash@arm.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:52:28 +0530
Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:

> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> 
> Test "perf probe of function from different CU" fails due to certain
> configs not being enabled. Building the kernel with
> CONFIG_KPROBE_EVENTS=y and CONFIG_UPROBE_EVENTS=y fixes the issue. As
> CONFIG_KPROBE_EVENTS is dependent on CONFIG_KPROBES, enable it as well.
> Some platforms enable these configs as a part of their defconfig, so
> this change is only required for the ones that don't do so.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
> ---
>  tools/perf/tests/config-fragments/config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tools/perf/tests/config-fragments/config b/tools/perf/tests/config-fragments/config
> index c340b3195fca..4fca12851016 100644
> --- a/tools/perf/tests/config-fragments/config
> +++ b/tools/perf/tests/config-fragments/config
> @@ -9,3 +9,6 @@ CONFIG_GENERIC_TRACER=y
>  CONFIG_FTRACE=y
>  CONFIG_FTRACE_SYSCALLS=y
>  CONFIG_BRANCH_PROFILE_NONE=y
> +CONFIG_KPROBES=y
> +CONFIG_KPROBE_EVENTS=y
> +CONFIG_UPROBE_EVENTS=y
> -- 
> 2.30.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
