Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371A21803A
	for <linux-perf-users@vger.kernel.org>; Wed, 30 Oct 2024 00:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248486; cv=none; b=FE7A904le4vbeZsh2jw2KV5zhr7UmLh+6A7yLcS3qvuYu2qIZyBuV8sAFmcBAMfzCQ8obADcYk4YGP9mgEpzYMuriMZJACvdp24wnbNc+3EVmfGvt+ae6RMmsrjMYolndPFE9PPBoSf5SmO4ESBYT1RDnKzUBafycb06LYKN1tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248486; c=relaxed/simple;
	bh=VhZGgTuLSG5s5oNJVv4OLLVW4ghFMjZgHpQauMNgTJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GbNp05pLcc78dLbQeiW3Zb1IcxThnvbXrItiuat5feQpIede+kgDTGhnLEQWCRVWgZLP/dCNUihUBSpRFyQaslk+sMp/WmUnNmrB3YE25Fq6RqT1ezsAGK/qY/oAyHJ2rdEJUMrBLOlOlSFFGX1GP/l2nx7cu5xevmcxVahlMSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHiURzD2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHiURzD2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE96C4CEE3;
	Wed, 30 Oct 2024 00:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248485;
	bh=VhZGgTuLSG5s5oNJVv4OLLVW4ghFMjZgHpQauMNgTJQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iHiURzD2mdeh3mXlhYkoP54dH/eIagUjRruLokdwqsM6P2dYUFumNbUccpL0vDaw2
	 onv18zbrErvvXjwOoSEIPgK8NQInvQ3BjAJ4yXNPU+0fzxfFVvuqG7H402o/BwTUdb
	 mbqgv8vzGdDhFAuvgXY0LNnSqCS4WEkl5AUaF3lb3eRnF091G57iZo26KOdhQUnoZv
	 je9OfivGcsBIBoqB5+t9lBxilQnhlSRhwgzh4I7w1+2kuxQt0QW9C+2qA90DhIZ4Vb
	 zqygEj/eHKUIJiEU6Y9Qctxnt59/psXQ1YCrlFEQBRWR4rAdc8NuGcoY868S1C6dq/
	 CV5HPDMZNkpUg==
Date: Tue, 29 Oct 2024 17:34:44 -0700
From: Namhyung Kim <namhyung@kernel.org>
To: vmolnaro@redhat.com
Cc: linux-perf-users@vger.kernel.org, mpetlan@redhat.com,
	kan.liang@linux.intel.com, irogers@google.com, acme@redhat.com,
	ak@linux.intel.com, alexander.shishkin@linux.intel.com
Subject: Re: perf sched timehist --state vs perf script
Message-ID: <ZyF_JDYF4wgEmbrW@google.com>
References: <20241024163630.24882-1-vmolnaro@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241024163630.24882-1-vmolnaro@redhat.com>

On Thu, Oct 24, 2024 at 06:36:30PM +0200, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Hello!
> 
> We encountered an issue with 'perf sched timehist --state' when
> we expected for a test case that the process of a workload would 
> eventually end in the dead state(marked by 'X') and be switched
> out. This can be seen also by using 'perf script':
> 
>     # perf sched record -a sleep 1
>     [ perf record: Woken up 1 times to write data ]
>     [ perf record: Captured and wrote 0.167 MB perf.data (166 samples) ]
>     # perf script | grep sleep
>            sleep  151541 [000] 193461.410617: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=3132275 [ns]
>            sleep  151541 [000] 193461.410624:       sched:sched_switch: sleep:151541 [120] S ==> swapper/0:0 [120]
>          swapper       0 [000] 193462.410688:       sched:sched_waking: comm=sleep pid=151541 prio=120 target_cpu=000
>          swapper       0 [000] 193462.410698:       sched:sched_switch: swapper/0:0 [120] R ==> sleep:151541 [120]
>          :151541  151541 [000] 193462.411100: sched:sched_stat_runtime: comm=sleep pid=151541 runtime=407210 [ns]
>          :151541  151541 [000] 193462.411107:       sched:sched_switch: sleep:151541 [120] X ==> swapper/0:0 [120]
> 
> But for the 'perf sched timehist --state' the process is shown
> in the zombie state when it is being switched out:
> 
>     # perf sched timehist --state | grep 151541
>     Samples do not have callchains.
>       193461.410624 [0000]  sleep[151541]                       0.000      0.054      3.129      S 
>       193462.411107 [0000]  :151541[151541]                     0.000      0.000      0.408      Z 
> 
> Shouldn't both commands report the same result, or is there a reason
> why 'perf script' uses the dead state while 'perf sched' uses dead?

I remember there was a discussion related to this.

https://lore.kernel.org/all/20240122070859.1394479-2-zegao@tencent.com/

And it seems it's fixed both in perf and libtraceevent.  Maybe your
libtraceevent is somewhat outdated and doesn't have the update.

> It also seems that the 'perf sched' cannot read the name of the zombie
> process, but that can be a different issue.

Hmm.. right.  It should update thread->comm using the sched_switch event.

Thanks,
Namhyung

