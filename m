Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4527320469E
	for <linux-perf-users@vger.kernel.org>; Thu, 10 Apr 2025 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744295585; cv=none; b=PKKuvslA6DEthP50Ay5mG3gC/jztDxs5fPeiaG3xdoHS2TX/uRhdczc0LxIvDpWKMZ1gqSTwiowqz4q5Btqe9lIHLU4M5n4NJTckC+PLIPT1ot1+dOpWRqDCc6yZmGO5VOFZe/RoH+iAV0ALdprkm2ccyH+Sz9yxdk6PH/MEwKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744295585; c=relaxed/simple;
	bh=96mZD7Hb5Cr/y2Om1FHnmlg+eCGOwFTtldbBBPskmfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TbbjSNz8rkmZc1p5nEX4Jm1OJ0w+wVSuRAscL/y/C6TwrSG//scWboRHfb2094pv3zUvdkVAKsTCm/N8a6fIpq2E3lT5I0oJbPdepN3N2jdPdOhTya3A8kkhwwSnn9HDp9FOLDsTfxsoFcrgpqPfMqbG02qNO6OvajT+tMpBDno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ATbJczOw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATbJczOw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744295583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/A1JjAmWXNOwxvY9+1uvauQoaYmfejNlLeKdPfCV5CU=;
	b=ATbJczOwzDO7vucofwqxKslN7ZjaAyEBqM87rfgHWRg/brNvGjPdcQ88XAwtMDxtxgs3G2
	LIePt4HWa0qmIdK5mo4N5donkR8EEzbAHqVuRFJQ7jOqz9DJ6OUUjYA87RSGGMUzfhyGca
	m8B3ogoYEIsIL9gyfwln87PRbPlnwJY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-PDFYeuplP66MG7qRxIZEow-1; Thu,
 10 Apr 2025 10:32:22 -0400
X-MC-Unique: PDFYeuplP66MG7qRxIZEow-1
X-Mimecast-MFC-AGG-ID: PDFYeuplP66MG7qRxIZEow_1744295540
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 88AD4195605A;
	Thu, 10 Apr 2025 14:32:19 +0000 (UTC)
Received: from jbrnak-thinkpadx1carbongen9.tpbc.csb (unknown [10.44.34.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4518C1955BC1;
	Thu, 10 Apr 2025 14:32:14 +0000 (UTC)
Date: Thu, 10 Apr 2025 16:32:11 +0200
From: Jakub Brnak <jbrnak@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>, kan.liang@linux.intel.com,
	mpetlan@redhat.com, tglozar@redhat.com,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v3] perf test probe_vfs_getname: Skip if no suitable line
 detected
Message-ID: <Z_fWa093x33Wcwrw@jbrnak-thinkpadx1carbongen9.tpbc.csb>
References: <20250324144523.597557-1-jbrnak@redhat.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250324144523.597557-1-jbrnak@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On Mon, Mar 24, 2025 at 03:45:23PM +0100, Jakub Brnak wrote:
> In some cases when calling function add_probe_vfs_getname, line number
> can't be detected by perf probe -L getname_flags:
> 
>   78         atomic_set(&result->refcnt, 1);
> 
> 	     // one of the following lines should have line number
> 	     // but sometimes it does not because of optimization
> 	     result->uptr = filename;
>              result->aname = NULL;
> 
>   81         audit_getname(result);
> 
> To prevent false failures, skip the affected tests
> if no suitable line numbers can be detected.
> 
> Signed-off-by: Jakub Brnak <jbrnak@redhat.com>
> ---
> v3:
> - ensure POSIX compliance
> 
> v2: 
> https://lore.kernel.org/linux-perf-users/Z9tKat6vvC1XUj0U@google.com/
> - check if return from add_vfs_getname equals to 1
> sice it is only option in case of fail 
> 
> v1:
>  https://lore.kernel.org/linux-perf-users/Z8pAep0GJsMFTyEi@google.com/T/#t
> ---
>  tools/perf/tests/shell/lib/probe_vfs_getname.sh          | 8 +++++++-
>  tools/perf/tests/shell/probe_vfs_getname.sh              | 8 +++++++-
>  .../perf/tests/shell/record+script_probe_vfs_getname.sh  | 8 +++++++-
>  tools/perf/tests/shell/trace+probe_vfs_getname.sh        | 9 +++++++--
>  4 files changed, 28 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/lib/probe_vfs_getname.sh b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> index 5c33ec7a5a63..89f72a4c818c 100644
> --- a/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/lib/probe_vfs_getname.sh
> @@ -19,8 +19,14 @@ add_probe_vfs_getname() {
>  			result_aname_re="[[:space:]]+([[:digit:]]+)[[:space:]]+result->aname = NULL;"
>  			line=$(perf probe -L getname_flags 2>&1 | grep -E "$result_aname_re" | sed -r "s/$result_aname_re/\1/")
>  		fi
> +
> +		if [ -z "$line" ] ; then
> +			echo "Could not find probeable line"
> +			return 2
> +		fi
> +
>  		perf probe -q       "vfs_getname=getname_flags:${line} pathname=result->name:string" || \
> -		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring"
> +		perf probe $add_probe_verbose "vfs_getname=getname_flags:${line} pathname=filename:ustring" || return 1
>  	fi
>  }
>  
> diff --git a/tools/perf/tests/shell/probe_vfs_getname.sh b/tools/perf/tests/shell/probe_vfs_getname.sh
> index c51a32931af6..0f52654c914a 100755
> --- a/tools/perf/tests/shell/probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/probe_vfs_getname.sh
> @@ -13,7 +13,13 @@ skip_if_no_perf_probe || exit 2
>  # shellcheck source=lib/probe_vfs_getname.sh
>  . "$(dirname $0)"/lib/probe_vfs_getname.sh
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [ $err -eq 1 ] ; then
> +	skip_if_no_debuginfo
> +	err=$?
> +fi
> +
>  cleanup_probe_vfs_getname
>  exit $err
> diff --git a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> index fd5b10d46915..1ad252f0d36e 100755
> --- a/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/record+script_probe_vfs_getname.sh
> @@ -35,8 +35,14 @@ perf_script_filenames() {
>  	grep -E " +touch +[0-9]+ +\[[0-9]+\] +[0-9]+\.[0-9]+: +probe:vfs_getname[_0-9]*: +\([[:xdigit:]]+\) +pathname=\"${file}\""
>  }
>  
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [ $err -eq 1 ] ; then
> +        skip_if_no_debuginfo
> +        err=$?
> +fi
> +
>  if [ $err -ne 0 ] ; then
>  	exit $err
>  fi
> diff --git a/tools/perf/tests/shell/trace+probe_vfs_getname.sh b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> index 60fccb62c540..5d5019988d61 100755
> --- a/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> +++ b/tools/perf/tests/shell/trace+probe_vfs_getname.sh
> @@ -25,9 +25,14 @@ trace_open_vfs_getname() {
>  	grep -E " +[0-9]+\.[0-9]+ +\( +[0-9]+\.[0-9]+ ms\): +touch/[0-9]+ open(at)?\((dfd: +CWD, +)?filename: +\"?${file}\"?, +flags: CREAT\|NOCTTY\|NONBLOCK\|WRONLY, +mode: +IRUGO\|IWUGO\) += +[0-9]+$"
>  }
>  
> -
> -add_probe_vfs_getname || skip_if_no_debuginfo
> +add_probe_vfs_getname
>  err=$?
> +
> +if [ $err -eq 1 ] ; then
> +        skip_if_no_debuginfo
> +        err=$?
> +fi
> +
>  if [ $err -ne 0 ] ; then
>  	exit $err
>  fi
> -- 
> 2.48.1
> 

Hi, anyone interested in this patch?

Thanks,
Jakub

