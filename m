Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EFD347B6
	for <linux-perf-users@vger.kernel.org>; Wed, 20 Mar 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710936887; cv=none; b=eJENrPgk9OC21bQgjbk8Ohub28QUWz+7nnce1M1g9/BwC4TJwMBii914ginMJzVQLGhj2kYbRvhTmrlWMxLedMmnEyLPLYZyy1VcMDD4AG29Aoq9hVnrLdB7dEj7sSvmb+LLM+JZ4GkRYTYUWWyWLoax3CZ61Ji3nw3Q54ShKd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710936887; c=relaxed/simple;
	bh=tWLesDBVepawES8k4HWgGs4LbCby8ApX/XAH00n/B7k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=f+tywg24ItAICTlBCdwW+2kygAHuMOCLDJue9WwinX1qCHakvSKTBb2Ca4uYZm7wNE5rviFb6vpn9T4SWAvdAi5djwiRoAsbL+GKI9vj54Z9ymrNEZIK6qNlctMmiIcRnPy0axOVN/Np3B1pvGBjRMmKMFZLMRKUc5RqllOAPyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eZSQNh+A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eZSQNh+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710936884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rmEjloj0iNkK2SvfSuJ0uwzissIuRcxsweIUQv1XiKM=;
	b=eZSQNh+Adkwp4Q73BNliry1MijDmF8HtcApBFtB0wRnoQ1wGZC8bJUMS7cdh06ycENoTWl
	i86iMIVAr3XVpJWWxSg+fEfO3osubG+ko3H0SasJH/c/hqjexA9YFGD/OIWVBdt4yWGcZF
	xXxA0fqGy8YlDj94/wU4K/2mbaODvWs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-IVLB_UaHNwSdEVzapZAoZw-1; Wed,
 20 Mar 2024 08:14:42 -0400
X-MC-Unique: IVLB_UaHNwSdEVzapZAoZw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46E871C00D01;
	Wed, 20 Mar 2024 12:14:42 +0000 (UTC)
Received: from Diego (unknown [10.39.208.19])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CAE8A492BC7;
	Wed, 20 Mar 2024 12:14:40 +0000 (UTC)
Date: Wed, 20 Mar 2024 13:14:32 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: vmolnaro@redhat.com
cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
In-Reply-To: <20240311081127.7652-1-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2403201310220.4040@Diego>
References: <20240311081127.7652-1-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Hello Arnaldo,
kind reminder, any chance this being merged soon?
Thanks,
Michael

On Mon, 11 Mar 2024, vmolnaro@redhat.com wrote:
> From: Veronika Molnarova <vmolnaro@redhat.com>
> 
> Subtest for system-wide record with '--threads=cpu' option fails due
> to a limit of open file descriptors on systems with 128 or more CPUs
> as the default limit is set to 1024.
> 
> The number of open file descriptors should be slightly above
> nmb_events*nmb_cpus + nmb_cpus(for perf.data.n) + 4*nmb_cpus(for pipes),
> which equals 8*nmb_cpus. Therefore, temporarily raise the limit to
> 16*nmb_cpus for the test.
>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>

Acked-by: Michael Petlan <mpetlan@redhat.com>

> ---
>  tools/perf/tests/shell/record.sh | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 4fbc74805d52..8acd55d09a1c 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -11,6 +11,14 @@ err=0
>  perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
>  testprog="perf test -w thloop"
>  testsym="test_loop"
> +default_fd_limit=$(ulimit -n)
> +# With option --threads=cpu the number of open file descriptors should be
> +# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
> +#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
> +#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
> +# All together it needs 8*nmb_cpus file descriptors plus some are also used 
> +# outside of testing, thus raising the limit to 16*nmb_cpus
> +min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
>  
>  cleanup() {
>    rm -rf "${perfdata}"
> @@ -154,10 +162,18 @@ test_workload() {
>    echo "Basic target workload test [Success]"
>  }
>  
> +# raise the limit of file descriptors to minimum
> +if [[ $default_fd_limit -lt $min_fd_limit ]]; then
> +	ulimit -n $min_fd_limit
> +fi
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
>  
> +# restore the default value
> +ulimit -n $default_fd_limit
> +
>  cleanup
>  exit $err
> -- 
> 2.41.0
> 
> 

