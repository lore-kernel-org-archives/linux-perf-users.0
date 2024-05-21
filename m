Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F195478B
	for <linux-perf-users@vger.kernel.org>; Tue, 21 May 2024 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716283684; cv=none; b=aJ5p7bXB/q/5Bqyvq39oPLHK3B5nOBJ2OI0JjOetNOuxrXRrmBv3sPxDMEitQaumkAMdT5kq6yCwUrBOyvRPEoFL/TtL1Ts8v2eIq1+Co9mz2cLRJACKlkE6hlTtcDCK2xLk4bYOpqtWXKMTGxYExDRFSzvJ4QtyjRGzhzTuJN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716283684; c=relaxed/simple;
	bh=USKcnZLOxcytg/MCtGzsZTieS8+MdZiRWhTcHT7Cuyc=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RoN9bDaok7XI0vPM0/wwaZVY8O9lWxhOwA/fyKihFd3AkfNPnwykOksJdOpwWKDd95aGQgDrh3DTr6DWYAN3738XRdjhfNB+SE4NbSh7maErJTuykmCxWtjaI2pk5TqA9sxqUUf1i6GhZXflI37uEeZq2IEOv1TWTv9R8MGQGE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Imtruxil; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Imtruxil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716283682;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/1TUV3V1APlMRgiAlmiq79wznJxBVbgbplFYv2EsxHE=;
	b=ImtruxilfHyvU8YgZgD/RUqXTzvY3hdGpFllGhhEcvJFPBKLcgITzMn4wh4rn4F8d/OcFA
	7Zdh5HUWwTCF1x/GvirJ6p2kOR9asBBAX0dd1fshESZ1YRLj/GBrNP2VRBk6L5msi7Q826
	UYiCw4SNk07zvcUMAP1JqAQxYndsmD0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-356-affmYd9UO7mFeeweX6fjpQ-1; Tue,
 21 May 2024 05:28:00 -0400
X-MC-Unique: affmYd9UO7mFeeweX6fjpQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 252981C0514D;
	Tue, 21 May 2024 09:28:00 +0000 (UTC)
Received: from Diego (unknown [10.39.208.27])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id BD976492BC6;
	Tue, 21 May 2024 09:27:58 +0000 (UTC)
Date: Tue, 21 May 2024 11:27:56 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
X-X-Sender: Michael@Diego
To: vmolnaro@redhat.com
cc: linux-perf-users@vger.kernel.org, acme@kernel.org, acme@redhat.com
Subject: Re: [PATCH v2] perf test record.sh: Raise limit of open file
 descriptors
In-Reply-To: <20240429085721.10122-1-vmolnaro@redhat.com>
Message-ID: <alpine.LRH.2.20.2405211127360.4040@Diego>
References: <ZiqoWj3f-P3ChlWa@x1> <20240429085721.10122-1-vmolnaro@redhat.com>
User-Agent: Alpine 2.20 (LRH 67 2015-01-07)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

On Mon, 29 Apr 2024, vmolnaro@redhat.com wrote:
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
> Reworked the patch as the testfile has already changed since the patch
> was sent causing the applying to fail, now applying upstream without
> problems.
>  tools/perf/tests/shell/record.sh | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
> index 3d1a7759a7b2..344c0e40ebe8 100755
> --- a/tools/perf/tests/shell/record.sh
> +++ b/tools/perf/tests/shell/record.sh
> @@ -21,6 +21,15 @@ testprog="perf test -w thloop"
>  cpu_pmu_dir="/sys/bus/event_source/devices/cpu*"
>  br_cntr_file="/caps/branch_counter_nr"
>  br_cntr_output="branch stack counters"
> +default_fd_limit=$(ulimit -n)
> +# With option --threads=cpu the number of open file descriptors should be
> +# equal to sum of:    nmb_cpus * nmb_events (2+dummy),
> +#                     nmb_threads for perf.data.n (equal to nmb_cpus) and
> +#                     2*nmb_cpus of pipes = 4*nmb_cpus (each pipe has 2 ends)
> +# All together it needs 8*nmb_cpus file descriptors plus some are also used
> +# outside of testing, thus raising the limit to 16*nmb_cpus
> +min_fd_limit=$(($(getconf _NPROCESSORS_ONLN) * 16))
> +
>  
>  cleanup() {
>    rm -rf "${perfdata}"
> @@ -190,11 +199,19 @@ test_branch_counter() {
>    echo "Basic branch counter test [Success]"
>  }
>  
> +# raise the limit of file descriptors to minimum
> +if [[ $default_fd_limit -lt $min_fd_limit ]]; then
> +       ulimit -n $min_fd_limit
> +fi
> +
>  test_per_thread
>  test_register_capture
>  test_system_wide
>  test_workload
>  test_branch_counter
>  
> +# restore the default value
> +ulimit -n $default_fd_limit
> +
>  cleanup
>  exit $err
> -- 
> 2.43.0
> 
> 

