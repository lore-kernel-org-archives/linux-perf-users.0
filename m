Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4E1135A60
	for <linux-perf-users@vger.kernel.org>; Wed, 24 Jan 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106705; cv=none; b=ANYCOJC/+F21Ppr3yLWhpgl1bjajrxz8B7SY89OTEEujIqRmZGsmUJraTC0qCzhkzoijSDIAsEDFQZMEjhzm/L9FXJuwDnp7aWiG4nPh5+1T9yOAM7AS2922Xzg1T6J68vaqOKHrKClztpB54SrtQBHsUBIeORKNp1i+m3Oy1AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106705; c=relaxed/simple;
	bh=3UkJLW0wqWNnKou8/QXneFMSSlGdlBCU4tDGrRTuJTc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uRKmj7MmzzP6WaUHT7LqXdA3E6q1sVtDmzNdGHhGxgWv+musH3r6/N3pK64Zb80WVxrVk3R/r3Me53yPrxSFWaFy0mQFG3+QqnF+8+Y89Z+HvymhlbmEYkolYFCAVVbV7B88kT4YWV4M8gl3Qw7CTPBVm6xB7kI55MEx5KN6XcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WyPrO5uG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WyPrO5uG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706106703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J3If7mQmYCw/gzUu8HoZEhRMRu3CpEsEnLk2fXE3rig=;
	b=WyPrO5uGp7Y0n6Fc3w8xi3QoeKLSveaVObzQIInzHZmBpp6bwa03Guu+LEI690NlbRK6qP
	y+lAuq6mm/SA6Oa+LzQJHEQgqayZtxTg+9dSp93IrSJGTOgoJun8t7aJVO6lTv8FOrJgby
	o4zXI9LKQttcBFTl+ROQa7+A3eNMQhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-CxLui7aAP0mHlC4fS5DY_g-1; Wed, 24 Jan 2024 09:31:41 -0500
X-MC-Unique: CxLui7aAP0mHlC4fS5DY_g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2EA0784A294;
	Wed, 24 Jan 2024 14:31:41 +0000 (UTC)
Received: from Diego (unknown [10.39.208.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F97D492BC6;
	Wed, 24 Jan 2024 14:31:39 +0000 (UTC)
Date: Wed, 24 Jan 2024 15:31:38 +0100 (CET)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: vmolnaro@redhat.com
cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
In-Reply-To: <20231130214236.9051-1-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2401241530530.11297@Diego>
References: <20231130214236.9051-1-vmolnaro@redhat.com>
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
what do you think about the v2?
Thanks.
Michael

On Thu, 30 Nov 2023, vmolnaro@redhat.com wrote:
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
> 

