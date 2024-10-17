Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E079FD
	for <linux-perf-users@vger.kernel.org>; Thu, 17 Oct 2024 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729160561; cv=none; b=Kyf2yl6WGKvgiHI9xrXDanPVF+5RacsuE9I+qdNJsFpm+x58sSYg4tTiNslppj97rQ/toYbDweDeI0/Zn3IF2ClGymWv/JqnPj02GfaJp2rAhb3oTi48LfIdkOmL6ueM4NeFf84dzuaFFwroRsA9xWHskjdJ7sNdFjOsJffkp0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729160561; c=relaxed/simple;
	bh=QEepCMTCzBNcxE76MsFO/M3IKsDCfujNaoWuyNWJ1bU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=R2mWXQyT1Stj8YZPdIiMStRmtItldFygDbMvtangv3tEvRU0sDoYQHc8/gcDuK5A4hRJuks2mM1cO7AUEyPaKMXD2zOrVm2hQFh7fgoCXzDPC/2KJSS5zhOFzKmNuHqE1b9HL7MdFUvdjXe/31qIGVj7iKDvf/yLDFmM9yjP7y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M3DHSCGi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M3DHSCGi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729160556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeCnWl19vc+4E0BG770O0FIIXbyDF4QWNdeyt9jEPmQ=;
	b=M3DHSCGibcUhGrnLnBGUV2v5veIZcXDqGuwiTNJkFfLDlDpNpuY/cKRrecu1eNTBchZomH
	wPjbMvw2qa5tzxKw9P5RqcfcZJfUDM6RnzKW+XYVueLfy6EFtyHKmLxSlgOiijGqisOf/8
	186Bg+Xk7fxMaKKzOupxxXeZqdUktVc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-50-tUDJYfdmNweuPub9n2KkFw-1; Thu,
 17 Oct 2024 06:22:29 -0400
X-MC-Unique: tUDJYfdmNweuPub9n2KkFw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0D5421955F07;
	Thu, 17 Oct 2024 10:22:27 +0000 (UTC)
Received: from Carbon (unknown [10.60.6.32])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3CAC219560A3;
	Thu, 17 Oct 2024 10:22:22 +0000 (UTC)
Date: Thu, 17 Oct 2024 12:22:19 +0200 (CEST)
From: Michael Petlan <mpetlan@redhat.com>
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
cc: acme@kernel.org, jolsa@kernel.org, adrian.hunter@intel.com, 
    irogers@google.com, namhyung@kernel.org, linux-perf-users@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, akanksha@linux.ibm.com, maddy@linux.ibm.com, 
    kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com, hbathini@linux.ibm.com
Subject: Re: [PATCH] tools/perf/tests/shell/base_probe: Enhance print_overall_results
 to print summary information
In-Reply-To: <20241014154025.85564-1-atrajeev@linux.vnet.ibm.com>
Message-ID: <d7c34f4f-692e-4c1b-c268-582c645a6c33@redhat.com>
References: <20241014154025.85564-1-atrajeev@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

On Mon, 14 Oct 2024, Athira Rajeev wrote:
> Currently print_overall_results prints the number of
> fails in the summary, example from base_probe tests in
> testsuite_probe:
> 
>  ## [ FAIL ] ## perf_probe :: test_invalid_options SUMMARY ::
> 	11 failures found
> 
> test_invalid_options contains multiple tests and out
> of that 11 failed. Sometimes it could happen that it
> is due to missing dependency in the build or environment
> dependency.
> 
> Example, perf probe -L requires DWARF enabled. otherwise
> it fails as below:
>  ./perf probe -L
>   Error: switch `L' is not available because NO_DWARF=1
> 
> "-L" is tested as one of the option in :
>    for opt in '-a' '-d' '-L' '-V'; do
>    <<perf probe test>>
>    print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "missing argument
> 	for $opt"
> 
> Here -a and -d doesn't require DWARF. Similarly there
> are few other tests requiring DWARF. To hint the user that
> missing dwarf could be one issue, update print_overall_results
> to print a comment string along with summary hinting the possible
> cause. Update test_invalid_options.sh and test_line_semantics.sh
> to pass the info about dwarf requirement since these tests
> failed when perf is built without DWARF.
> 
> With the change:
>  ## [ FAIL ] ## perf_probe :: test_invalid_options SUMMARY ::
>  11 failures found :: Some of the tests need DWARF to run

Hello Athira,

I admit that the idea of some hint why the test failed
might be useful, however a static hint that might or
might not be related to the particular failure seems to
be rather misleading to me. If the test fails for any
other reason, the user is still told about DWARF which
might not be true.

I think that such hints would need some test result post-
processing to determine the actual reason.

Michael

> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>
> ---
>  tools/perf/tests/shell/base_probe/test_invalid_options.sh | 2 +-
>  tools/perf/tests/shell/base_probe/test_line_semantics.sh  | 2 +-
>  tools/perf/tests/shell/common/init.sh                     | 3 ++-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_invalid_options.sh b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> index 1fedfd8b0d0d..e133bb0aa949 100755
> --- a/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> +++ b/tools/perf/tests/shell/base_probe/test_invalid_options.sh
> @@ -75,5 +75,5 @@ done
>  
>  
>  # print overall results
> -print_overall_results "$TEST_RESULT"
> +print_overall_results "$TEST_RESULT" "Some of the tests need DWARF to run"
>  exit $?
> diff --git a/tools/perf/tests/shell/base_probe/test_line_semantics.sh b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> index d8f4bde0f585..99f4f56a3292 100755
> --- a/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> +++ b/tools/perf/tests/shell/base_probe/test_line_semantics.sh
> @@ -51,5 +51,5 @@ done
>  
>  
>  # print overall results
> -print_overall_results "$TEST_RESULT"
> +print_overall_results "$TEST_RESULT" "Some of the tests need DWARF to run"
>  exit $?
> diff --git a/tools/perf/tests/shell/common/init.sh b/tools/perf/tests/shell/common/init.sh
> index 075f17623c8e..0862cbc1c6f7 100644
> --- a/tools/perf/tests/shell/common/init.sh
> +++ b/tools/perf/tests/shell/common/init.sh
> @@ -46,10 +46,11 @@ print_results()
>  print_overall_results()
>  {
>  	RETVAL="$1"; shift
> +	TASK_COMMENT="$*"
>  	if [ $RETVAL -eq 0 ]; then
>  		_echo "$MALLPASS## [ PASS ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY"
>  	else
> -		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found"
> +		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found :: $TASK_COMMENT"
>  	fi
>  	return $RETVAL
>  }
> -- 
> 2.43.5
> 
> 
> 

