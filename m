Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5A81CB500
	for <linux-perf-users@vger.kernel.org>; Mon,  2 Sep 2024 15:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725289855; cv=none; b=J7m+yb+WIMsXYigIiyrsXmPQabH99/sHQMshprpiiplNJCdl/31r5MyKK7Qt7KY8r8xyacNMahcexnIwwqLInmbsoUO0GlHuCBjPrgoLZ3Du8EkfG+d/YtGF+81rrZ7ZJ0VHpxs6y2zNccs5AqEoQK5UgJhMGxYGoItLOXVrjfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725289855; c=relaxed/simple;
	bh=HLQcG9Mmf9CyUowxMqciOJWMpbRfpNaDmyXk0Bjf8j8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2Y8Teprj1CANo7+R3+xPM6q705rCGGge/VmEJQHqZHxGJSw0dqB1d/1iiGpXgE1BWrVT92NIaUlPffot2/v0N0x/FYAP3PfbyuW0aWhhjmF+wA7uTp6QPi2ymtzLF04XDylBfqphd08l2C+0M67Ou46HtMRwDDBkss1A+gNVUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W4vehU6a; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4vehU6a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725289852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cR8htSkt+33PFr3i2qoxTiukFdhXDOOXXrwhfJqgIxs=;
	b=W4vehU6aZq/fLEUKQsPwZ71Myy8oo2yywLiCUeHKgk81bMCjPho+2gXedysrXRknvkn64g
	UvlmMSmLSu7mmra76DInQJ+RIThHndfiqMUCb16/OoOBi3MGXVt8TygxwhMOE/M91mpKv3
	rqQBe1SCCGSDA6WRmFyIFVcReg7f99E=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-bEk1_5DOMV6o4aC8e5Uq7Q-1; Mon, 02 Sep 2024 11:10:51 -0400
X-MC-Unique: bEk1_5DOMV6o4aC8e5Uq7Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-374b35856aeso2071454f8f.3
        for <linux-perf-users@vger.kernel.org>; Mon, 02 Sep 2024 08:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725289850; x=1725894650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cR8htSkt+33PFr3i2qoxTiukFdhXDOOXXrwhfJqgIxs=;
        b=GrS8Yy37yBBYkj4SEBwmGm0g6Al4//v5+nZmH03GqMfeK7AXYypCLkryvFcM6f46NJ
         dyksTp7vnTR4mgS7RopDFD2eUcHyeadt3fqfc+IWtA6F5oTGoxVNSRRq2JH1nBLNEqc6
         z0+DoMo1CnCS8Rtc4Hlu3+L6oPAfu6TR77l5RiXjCu9a4Rf04vhIcumO09tWhcOeBQZ1
         wid0E6dPkvh76Q9BHfVIarIJjvWqMs3EBp/1PKj0v/e1HiO6BoU0L5CFgCns+xK/cR3/
         0/oH8FmkOKuAhXvNcJTWt8TpzS3DRMa2r+XbTN2BlauBIZfqG2Qa9YgJUntAzfrn4gD/
         edxQ==
X-Gm-Message-State: AOJu0Yzkw5YzZbcp1Xk0SUYuOz93kU73f2/r1kCdfcaofGOxlOOzaa5R
	EdYElgiUUARr2h63EuE82514a15X1+jb8AUnveP7/4gQycY85Wg8Qc+Uvq2tbPNBFrdtfezY2el
	Bess87bl8wcBtxUIjPKZmNlkYQVvjcrpZ3fU9KWyVbYFFlRfeL9Yxk1E6i+Zsha0WQvE=
X-Received: by 2002:a5d:66c3:0:b0:374:cb5c:2966 with SMTP id ffacd0b85a97d-374f9e3971amr246119f8f.40.1725289850102;
        Mon, 02 Sep 2024 08:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOyxV7YGXUI4Bc3rldpnrqkZ7ri8vjDZFLCA/Klyh1QQn34YkHnLjtPwhiJtIFeSWNpR0KGw==
X-Received: by 2002:a5d:66c3:0:b0:374:cb5c:2966 with SMTP id ffacd0b85a97d-374f9e3971amr246076f8f.40.1725289849211;
        Mon, 02 Sep 2024 08:10:49 -0700 (PDT)
Received: from [192.168.137.117] (2504330643.kn.vutbr.cz. [147.229.216.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374ce8bbeacsm1938629f8f.92.2024.09.02.08.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 08:10:48 -0700 (PDT)
Message-ID: <b87e2c58-8696-48bc-92ca-93964917bf9a@redhat.com>
Date: Mon, 2 Sep 2024 17:10:48 +0200
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
 <ZtHk6Tj7KioLRd10@x1> <6b8245be-7fbf-41e9-8622-f8990ae7a880@redhat.com>
 <ZtXMRffIGVmjptcf@x1> <ZtXOrJdxvrI7Kk6n@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <ZtXOrJdxvrI7Kk6n@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/2/24 16:41, Arnaldo Carvalho de Melo wrote:
> On Mon, Sep 02, 2024 at 11:31:36AM -0300, Arnaldo Carvalho de Melo wrote:
>> On Mon, Sep 02, 2024 at 04:05:04PM +0200, Veronika Molnarova wrote:
>>> On 8/30/24 17:27, Arnaldo Carvalho de Melo wrote:
>>>> On Wed, Aug 28, 2024 at 05:39:48PM -0300, Arnaldo Carvalho de Melo wrote:
>>>>> On Wed, Aug 28, 2024 at 04:10:55PM +0200, Veronika Molnarova wrote:
>>>> So, is there some other knob to get further output from that FAIL case?
>>>> Like the command that is failing? I'll try to take a look at the
>>>> sources, but are you seeing this problem with what is in
>>>> perf-tools-next/perf-tools-next?
> 
>>> Couldn't reproduce the issue on multiple systems. There is no further way
>>> of getting more logs from the test case. The output of the failure is from
>>> the regex checking when a line wasn't matched to any possible regex.
>>> Looking at the test case "adding blacklisted function warn_thunk_thunk",
>>> the failure is caused by command 'perf probe warn_thunk_thunk', which is
>>> a blacklisted function taken from "/sys/kernel/debug/kprobes/blacklist".
> 
> root@x1:~# grep thunk_thunk /sys/kernel/debug/kprobes/blacklist
> 0xffffffff97004af0-0xffffffff97004b20	warn_thunk_thunk
> root@x1:~#
> 
> <SNIP>
> 
>> /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err:A function DIE doesn't have decl_line. Maybe broken DWARF?
>> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.err
>> A function DIE doesn't have decl_line. Maybe broken DWARF?
>> A function DIE doesn't have decl_line. Maybe broken DWARF?
>> Probe point 'warn_thunk_thunk' not found.
>>   Error: Failed to add events.
>> root@x1:~#
>> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted_list.log 
>> root@x1:~# cat /tmp/perftool-testsuite_probe.RJh/perf_probe/logs/adding_blacklisted.log 
>> root@x1:~#
>>
>> So is it just a matter of adding this output to the expected outputs?
>> In test_adding_blacklisted.sh?
> 
> Did the patch below, now it passes, Ack?
> 
> root@x1:~# export PERFTEST_KEEP_LOGS=y
> root@x1:~# perf test 88
>  88: perftool-testsuite_probe                                        : Ok
> root@x1:~#
> 
> Or am I missing the point? :-)
> 
> - Arnaldo

Yeah, that would fix the test case, the question is whether we should
accept it as a possible output. Found some old patch that should have
fixed the mentioned issue: 
https://lore.kernel.org/all/20230628082337.1857302-3-georgmueller@gmx.net/

> 
> diff --git a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> index b5dc10b2a73810b3..14290d08a4a96eaf 100755
> --- a/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> +++ b/tools/perf/tests/shell/base_probe/test_adding_blacklisted.sh
> @@ -42,7 +42,8 @@ REGEX_ERROR_MESSAGE="Error: Failed to add events."
>  REGEX_INVALID_ARGUMENT="Failed to write event: Invalid argument"
>  REGEX_SYMBOL_FAIL="Failed to find symbol at $RE_ADDRESS"
>  REGEX_OUT_SECTION="$BLACKFUNC is out of \.\w+, skip it"
> -../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" < $LOGS_DIR/adding_blacklisted.err
> +REGEX_MISSING_DECL_LINE="A function DIE doesn't have decl_line. Maybe broken DWARF?"
> +../common/check_all_lines_matched.pl "$REGEX_SKIP_MESSAGE" "$REGEX_NOT_FOUND_MESSAGE" "$REGEX_ERROR_MESSAGE" "$REGEX_SCOPE_FAIL" "$REGEX_INVALID_ARGUMENT" "$REGEX_SYMBOL_FAIL" "$REGEX_OUT_SECTION" "$REGEX_MISSING_DECL_LINE" < $LOGS_DIR/adding_blacklisted.err
>  CHECK_EXIT_CODE=$?
>  
>  print_results $PERF_EXIT_CODE $CHECK_EXIT_CODE "adding blacklisted function $BLACKFUNC"
> 

