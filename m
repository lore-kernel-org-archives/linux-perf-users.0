Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741820FAAE
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725285912; cv=none; b=KrL6GAVHY9Y+SKG5JjMlYoWZBL5xz9X8+b2TsMurD+iyuoxWgpT8CEPramXAwEGcMeIg9vfhxr25FmHxFw7XgbPaI5UNNTp2H0GfzgrtHvxwvMPe7JjhUGJFwbWTo4HAnILhWnDnkJuaXr/3fao/gh64lJVXY7P4kB0M1fGO6og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725285912; c=relaxed/simple;
	bh=uZ+7eX5sx3qR/GOlyPmjRvMz0QQ2fg6XrMip8YKjd+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VV5GI5jeMTlrVxIr/EOYzH7rUM41w76w2U21oyk/XC1CicCoTy1CcrZ6/1OWDf+FDjUfe31GeA7vRQ3NRWD/l77yACzUvUYLY3nN7CKjjfg7CGeHn204F5/40iOF1atDFGUc2Wp55/buEui/g+aDvDIU0/IqsJOtY0ccP6oED5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FyEEID4r; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FyEEID4r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725285909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ag65NdpiXqY7ZyOqOH8k8mZ0BpdSeuaBdGHhZnXunR0=;
	b=FyEEID4rdFcEmlXTU801he3ES4uX3+4HNMQBl0QhGG3pniTJrWKZbC3gttpYE0D5mBJ9DJ
	I6UIKHJxoE54j8w06EG/LuWhr87rZ05p2T7bbWoTr4WU02AO86CG/L+Z1PhBC6rpEmgJkw
	4foWo3QQDG5P/sLoTluUSPNcTNxEBa8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-v5b7IqexM4ux27-ujT-VHg-1; Mon, 02 Sep 2024 10:05:08 -0400
X-MC-Unique: v5b7IqexM4ux27-ujT-VHg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-533500041b1so4851849e87.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Sep 2024 07:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725285907; x=1725890707;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ag65NdpiXqY7ZyOqOH8k8mZ0BpdSeuaBdGHhZnXunR0=;
        b=lAB6WAb92Hv7+Cv0Ja/OTJdxqbF2M7WN84lwh8UMMp+MAMStAWqgmchxlDz4Xzbdbv
         mWEXDKZFGEtydRREr0tUubjS/s1Nk5jHZ1N6Qrnrkjnbwfi12X55Ziu3ljJv41tTT7kS
         YOCLAyUB6awryOJzaP5zw5hu/CfadMMEuYwnyCyurLIxrjfgSsJi5CHTpxU34nueI5Iv
         Ky8WCMPaqiLvM3MzIGb1+hFBJb8T/dsPO8AGtBz98yC/k5PhxHIGuCmk89sM4wfkde7A
         ujFWlkmUpTe+TJk8IBhzA7EbWUxkzqlg/CHoTjWBdS7zW8IrFv1D35ZCgm9i1sB2mmbE
         uUwQ==
X-Gm-Message-State: AOJu0YzjQr+ddlCOLBfPznkWNsiRyhWqygv+QPPnRduo6OTttiVJHK3c
	8Y6ao9iQJZIhzBSJcgtp/rtnkp8gx5qJvDpEBwDn1GGQdHiBVkUTgeKFDo2zJP3mE5YhWtB3piB
	jjbUD7pmdq05qEIojiM4Uul31j8Otz4gF6Q9YAhY2xg0wPdKWfdjqWFF1GN29i6Pb7+g=
X-Received: by 2002:a05:6512:31cf:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-53546bfcc07mr9161506e87.51.1725285906641;
        Mon, 02 Sep 2024 07:05:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMWlRxIOBo4L2/20QUZvKeRrcBMnx9nHO7pStFK/AJ7+2VhnVv41MGMVkBTGQDNjjjc3LCdA==
X-Received: by 2002:a05:6512:31cf:b0:52c:e119:7f1 with SMTP id 2adb3069b0e04-53546bfcc07mr9161398e87.51.1725285905465;
        Mon, 02 Sep 2024 07:05:05 -0700 (PDT)
Received: from [192.168.137.117] (2504330643.kn.vutbr.cz. [147.229.216.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8988ff289fsm563123966b.2.2024.09.02.07.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 07:05:05 -0700 (PDT)
Message-ID: <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
Date: Mon, 2 Sep 2024 16:05:04 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] perftool-testsuite 2nd batch
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org, acme@redhat.com, namhyung@kernel.org,
 mpetlan@redhat.com, irogers@google.com, atrajeev@linux.vnet.ibm.com,
 masami.hiramatsu.pt@hitachi.com
References: <Zn3n0JwfdfFdjbzj@google.com>
 <20240702110849.31904-1-vmolnaro@redhat.com>
 <66bed21e-1ea6-4676-b202-dd7c2f2f847c@redhat.com> <Zs-LEEutfp0hkjh5@x1>
 <ZtHk6Tj7KioLRd10@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZtHk6Tj7KioLRd10@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
> On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
>> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
>>> Ping
>>
> So, is there some other knob to get further output from that FAIL case?
> Like the command that is failing? I'll try to take a look at the
> sources, but are you seeing this problem with what is in
> perf-tools-next/perf-tools-next?
> 
> - Arnaldo

Couldn't reproduce the issue on multiple systems. There is no further way
of getting more logs from the test case. The output of the failure is from
the regex checking when a line wasn't matched to any possible regex.
Looking at the test case "adding blacklisted function warn_thunk_thunk",
the failure is caused by command 'perf probe warn_thunk_thunk', which is
a blacklisted function taken from "/sys/kernel/debug/kprobes/blacklist".

If the variable "PERFTEST_KEEP_LOGS=y" is set to keep debug logs located in
"/tmp/perftool-testsuite_probe.XXX", those could provide some more info.

Would it be possible to get system specification for the possible issue
reproduction?

Thanks,
Veronika
> 
> root@x1:~# perf test -vvvvv 88
> capget syscall failed (No such file or directory - 2) fall back on root check
>  88: perftool-testsuite_probe:
> --- start ---
> test child forked, pid 2780578
> Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
> Line did not match any pattern: "A function DIE doesn't have decl_line. Maybe broken DWARF?"
> -- [ FAIL ] -- perf_probe :: test_adding_blacklisted :: adding blacklisted function warn_thunk_thunk (output regexp parsing)
> -- [ PASS ] -- perf_probe :: test_adding_blacklisted :: listing blacklisted probe (should NOT be listed)
> ## [ FAIL ] ## perf_probe :: test_adding_blacklisted SUMMARY :: 1 failures found
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: 
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: -a
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: adding probe inode_permission :: --add
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf list
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing added probe :: perf probe -l
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: using added probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: deleting added probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: listing removed probe (should NOT be listed)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: dry run :: adding probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: first probe adding
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (without force)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: force-adding probes :: second probe adding (with force)
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: using doubled probe
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: removing multiple probes
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: wildcard adding support
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: non-existing variable
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: add
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: function with retval :: record
> -- [ PASS ] -- perf_probe :: test_adding_kernel :: function argument probing :: script
> ## [ PASS ] ## perf_probe :: test_adding_kernel SUMMARY
> -- [ SKIP ] -- perf_probe :: test_basic :: help message :: testcase skipped
> -- [ PASS ] -- perf_probe :: test_basic :: usage message
> -- [ PASS ] -- perf_probe :: test_basic :: quiet switch
> ## [ PASS ] ## perf_probe :: test_basic SUMMARY
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -a
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -d
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -L
> -- [ PASS ] -- perf_probe :: test_invalid_options :: missing argument for -V
> -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: unnecessary argument for -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -d xxx
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -L foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -V foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -a xxx -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -L foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -V foo
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -d xxx -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -V bar
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -L foo -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -l
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -V foo -F
> -- [ PASS ] -- perf_probe :: test_invalid_options :: mutually exclusive options :: -l -F
> ## [ PASS ] ## perf_probe :: test_invalid_options SUMMARY
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:0-10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func:2+10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: func@source.c:1
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1+1
> -- [ PASS ] -- perf_probe :: test_line_semantics :: acceptable descriptions :: source.c:1-10
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:foo
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1-foo
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func:1+foo
> -- [ PASS ] -- perf_probe :: test_line_semantics :: unacceptable descriptions :: func;lazy\*pattern
> ## [ PASS ] ## perf_probe :: test_line_semantics SUMMARY
> ---- end(-1) ----
>  88: perftool-testsuite_probe                                        : FAILED!
> root@x1:~# 
> 
> 
> 

