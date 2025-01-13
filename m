Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68CD2045AF
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 10:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736763692; cv=none; b=YHdfEwty4q03oazoY8b5BT+UjTIpvbNoIqN+2K0w0/AbVGIeW/HcMUzfZi1BuNRTYjN3iLR9SwWlluomKSe9pDbQf4kAeMx1zqlH04d3Bp3kRyHmxLajLjXQSb1XhsEqGFXDGOWT8DIMh9q+rvU3sEXFYUTP3927CbxXLRRMcUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736763692; c=relaxed/simple;
	bh=jisdyamQ30kTZyRiEWrE4CpUo8Sw+DHdE17u3d8u6q4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iG9Ir1gLl+u5O90YNlzmfDNg1l1CcuBh3PdJTYP16xGu3nF0tfKlE6sA1MqKkt3cFdQK1Q6yvlWtyIuov/Z3HayKrwVMDCrcYRDSsAdlvGeaJ17+c1SA0TQ6sZ/pH28Sz8YoLPpvygBgt6EZV0CSl3idLCRfDJcA8yYINzO6cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a7MxmY4d; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a7MxmY4d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736763689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xt4e1f0wj8UzOdabGlkr3Uco4bHMbyif3w6wfY2dKJw=;
	b=a7MxmY4dGnh2Zi0ddv8X0Gpo7/a+GV5kV1iSUj3PkBgQQGPHi1Zn/8uK5+SzdaA59HOgXZ
	0udoOKa3MMWkEZyYwSYlMAiEqxvxJn1cNnW5SzGi8bbUyZCJODKTgw6drIsgZhMHXqVtsF
	XMwAFOxkPveIRjKVfkH3HcrFljRWiCM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-3PCF6ZmhOgay-G21Cw8QIA-1; Mon, 13 Jan 2025 05:21:27 -0500
X-MC-Unique: 3PCF6ZmhOgay-G21Cw8QIA-1
X-Mimecast-MFC-AGG-ID: 3PCF6ZmhOgay-G21Cw8QIA
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385e49efd59so1470870f8f.0
        for <linux-perf-users@vger.kernel.org>; Mon, 13 Jan 2025 02:21:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736763686; x=1737368486;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xt4e1f0wj8UzOdabGlkr3Uco4bHMbyif3w6wfY2dKJw=;
        b=s2wQVr4kor3P5LVGEBedTEIE3oTe/w/186nn+yBS7TRIvngL6ZGqOQPDyqwdtHtthq
         BPEPSj1nNYUbMY4Vinu0RsFH0zFm25Z9EPTyiVtDmvi7J8DrAOGgyBE3NFOcEzp666q+
         FSb6uoV5U6uvtbdQfz/vpqISLDcFAwgOL2PlQFCsgzwrZ2qm/z8b+UjAs5QJKz0jimY4
         kyZUtEeifIJkdheB7OlK6+kR5LVWeOeQ3Sc/g/Xzd0qz+n9BRCHd/Aa5vULcWOQq4/Ni
         iukH3CrUU7Jy5FtsEBzMRfZY7EdLcPOwUALEPfU2oWKdVvUfuM+MDo5GqlmrnQWbjO3R
         /Z6Q==
X-Gm-Message-State: AOJu0YyjJx4bFo6gV8Ga0EMsEaOdHs17rj5rN3bl85DuCnNvEhuYC2YT
	PNIkAOSVv9YgNXGPwCR6S3npaxaU+Y+btjCtU2kgY9DzIkTqs2sjNE+OYUCcbGRlP0/zQKdwzpc
	gJgqXqTW29V3cqNKposXCsVpCbeQSswT/rOEVxWPIj/qUmOTbAkNuyFSCRswr6tizPPQ=
X-Gm-Gg: ASbGncuItizSvfGMW/aCJZxsTyn1E20oUTiZQnppn6wWay7IC2bXag9y8KQg6FVObPO
	nz73bVFZsOv8ofhoxyJj99nGgqiJZML7nXIXSchzCmQs1hdapJaNQXjQD7bE2iyGFlbBEhG7GNc
	bVYwHPajl2L0FU0il+Xrt5k1dD1euTlZDV+lu7DbUHeKqa6QpEhWW37u1jKEK0Fk3w4rLN+lR5m
	1frp9lML5rRYlFoBxu6zajx7xuQUlzlylF8f/J2Qf12LCXlTx+sq0qAWzPjhSi69kCmN68JzWP0
	fL4ztEqst0k=
X-Received: by 2002:a5d:6da4:0:b0:385:de67:2269 with SMTP id ffacd0b85a97d-38a8730e04amr16461649f8f.36.1736763686058;
        Mon, 13 Jan 2025 02:21:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbHzwMbQ6/3Fwsroyn0DZ7WCCmNBX7Lhvb0zjmXDUxgqVCaF4BgckjwfprSsRiJLDqnwAntQ==
X-Received: by 2002:a5d:6da4:0:b0:385:de67:2269 with SMTP id ffacd0b85a97d-38a8730e04amr16461612f8f.36.1736763685695;
        Mon, 13 Jan 2025 02:21:25 -0800 (PST)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b81e4sm11963222f8f.64.2025.01.13.02.21.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 02:21:25 -0800 (PST)
Message-ID: <07be4391-4a28-4761-9171-26580aea6312@redhat.com>
Date: Mon, 13 Jan 2025 11:21:24 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] tools/perf/tests/base_probe: Fix check for the count
 of existing probes in test_adding_kernel
To: Athira Rajeev <atrajeev@linux.vnet.ibm.com>, acme@kernel.org,
 jolsa@kernel.org, adrian.hunter@intel.com, irogers@google.com,
 namhyung@kernel.org, mpetlan@redhat.com
Cc: linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 maddy@linux.ibm.com, kjain@linux.ibm.com, disgoel@linux.vnet.ibm.com,
 hbathini@linux.ibm.com
References: <20250110094324.94604-1-atrajeev@linux.vnet.ibm.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <20250110094324.94604-1-atrajeev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 1/10/25 10:43, Athira Rajeev wrote:
> perftool-testsuite_probe fails in test_adding_kernel as below:
> 	Regexp not found: "probe:inode_permission_11"
> 	-- [ FAIL ] -- perf_probe :: test_adding_kernel :: force-adding probes ::
> 	second probe adding (with force) (output regexp parsing)
> 	event syntax error: 'probe:inode_permission_11'
> 	  \___ unknown tracepoint
> 
> 	Error:  File /sys/kernel/tracing//events/probe/inode_permission_11
> 	not found.
> 	Hint:   Perhaps this kernel misses some CONFIG_ setting to
> 	enable this feature?.
> 
> The test does the following:
> 1) Adds a probe point first using :
>     $CMD_PERF probe --add $TEST_PROBE
> 2) Then tries to add same probe again without —force
> and expects it to fail. Next tries to add same probe again
> with —force. In this case, perf probe succeeds and adds
> the probe with a suffix number. Example:
> 
>  ./perf probe --add inode_permission
>  Added new event:
>   probe:inode_permission (on inode_permission)
> 
>  ./perf probe --add inode_permission --force
>  Added new event:
>   probe:inode_permission_1 (on inode_permission)
> 
>   ./perf probe --add inode_permission --force
>  Added new event:
>   probe:inode_permission_2 (on inode_permission)
> 
> Each time, suffix is added to existing probe name.
> To get the suffix number, test cases uses :
> NO_OF_PROBES=`$CMD_PERF probe -l | wc -l`
> 
> This will work if there is no other probe existing
> in the system. If there are any other probes other than
> kernel probes or inode_permission, ( example: any probe),
> "perf probe -l" will include count for other probes too.
> 
> Example, in the system where this failed, already some
> probes were default added. So count became 10
>   ./perf probe -l | wc -l
>   10
> 
> So to be specific for "inode_permission", restrict the
> probe count check to that probe point alone using :
> NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
> 
> Similarly while removing the probe using "probe --del *",
> ( removing all probes ), check uses:
> 
>  ../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE"
> 
> But if there are other probes in the system, the log will
> contain reference to other existing probe too. Hence change
> usage of check_all_lines_matched.pl to check_all_patterns_found.pl
> This will make sure expecting string comes in the result
> 
> Signed-off-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Acked-by: Veronika Molnarova <vmolnaro@redhat.com>

Thanks,
Veronika

> ---
> Changelog:
>  v1 -> v2:
>  No code changes. After being reviewed by Michael Petlan, since
>  initial patch was posted in 2024-10-14, rebased on top of latest
>  perf-tools-next
> 
>  tools/perf/tests/shell/base_probe/test_adding_kernel.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> index d541ffd44a93..f8b5f096d0d7 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_kernel.sh
> @@ -169,7 +169,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "force-adding probes :: second pr
>  (( TEST_RESULT += $? ))
>  
>  # adding existing probe with '--force' should pass
> -NO_OF_PROBES=`$CMD_PERF probe -l | wc -l`
> +NO_OF_PROBES=`$CMD_PERF probe -l $TEST_PROBE| wc -l`
>  $CMD_PERF probe --force --add $TEST_PROBE 2> $LOGS_DIR/adding_kernel_forceadd_03.err
>  PERF_EXIT_CODE=$?
>  
> @@ -205,7 +205,7 @@ print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "using doubled probe"
>  $CMD_PERF probe --del \* 2> $LOGS_DIR/adding_kernel_removing_wildcard.err
>  PERF_EXIT_CODE=$?
>  
> -../common/check_all_lines_matched.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
> +../common/check_all_patterns_found.pl "Removed event: probe:$TEST_PROBE" "Removed event: probe:${TEST_PROBE}_1" < $LOGS_DIR/adding_kernel_removing_wildcard.err
>  CHECK_EXIT_CODE=$?
>  
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "removing multiple probes"

