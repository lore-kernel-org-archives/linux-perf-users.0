Received: from mail.ptr1337.dev (mail.ptr1337.dev [202.61.224.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AC61AAE38;
	Wed, 20 Nov 2024 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.61.224.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732113030; cv=none; b=tYunhDDlTpOhC3YXm2qbW6oBzy8elrMm9iQ+t5Smob0e0LFNxqUcVaAatOI684qkLGPe5kW/yo63meyF6l7Ae1vSlO9yObjr27oWd0aOEjD2HSs0suaZI2u1Il5R9UQDcd6FW+xYGlTgtRODeJsbiWzg4R4Qqgow26kSGLlQTx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732113030; c=relaxed/simple;
	bh=W7OWA8tVFTiKEF42Oieigl4nxZ6o8b064cist9uE5fg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=poXDhnkIVMbc/K/PMw76e5WjXInjzOfRMGkCYp5p4dy8fsaFAS3NpFHI6Dx/KoIh8OCAO3S2s/nnhm9YD/tmHpacaAGP2jTovHMspihQIYn3yXAy1odun8tKWWhGjTcSgzrlgVKur4a6U051QsbzW6DaJN5AC+ovRabfMPCpiUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org; spf=pass smtp.mailfrom=cachyos.org; dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b=B5ffanFm; arc=none smtp.client-ip=202.61.224.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cachyos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cachyos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cachyos.org header.i=@cachyos.org header.b="B5ffanFm"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CEA4C2805FA;
	Wed, 20 Nov 2024 15:30:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cachyos.org; s=dkim;
	t=1732113024; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=7apzaMS1lO1lrCYhLj60cV0wpNtVOKl6ln57IHdgp6I=;
	b=B5ffanFmWap08QD1Oh+ynGU2/40mw16ZjqA3/1S67ev/gR6Jk+lhIZ4nHmYjYb428KlAti
	Tg/tR51V98cX90+K5MSjFhmL51O87QxrgW+WJ4H+jZ40vjCGhmlfHcr2Tp2fvgahiVWqCP
	qc3mMGKGJne8qaq9XSkdEz5T3QPCClR2lEVYHB7StVz142/hZh34u9Br2IszmJYg3xRbnY
	4fjlsv9Q8numT1L5mhzmscwGX37T/nIUh80YnbeVPVz8Hoh3GssK/UsnAVjIfNxMAB+q7f
	Z+0gvQe0kS+Ur7uLh/atFOYSgD9Jt1VM0ESG9Uk7Q34+zjlvM+DK1/XzU4HN0Q==
Message-ID: <f90ee4f3-704d-4776-99e7-04f30969d93e@cachyos.org>
Date: Wed, 20 Nov 2024 15:30:20 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 10/10] perf/x86/rapl: Add core energy counter support
 for AMD CPUs
To: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>, peterz@infradead.org,
 mingo@redhat.com, rui.zhang@intel.com, irogers@google.com,
 kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.dei,
 gautham.shenoy@amd.com
Cc: kprateek.nayak@amd.com, ravi.bangoria@amd.com, x86@kernel.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241115060805.447565-1-Dhananjay.Ugwekar@amd.com>
 <20241115060805.447565-11-Dhananjay.Ugwekar@amd.com>
 <a7159bad-92a1-47e8-b892-2ae0dd9a94f6@cachyos.org>
 <7eaf557d-7e85-4fd3-abee-f84ac01d92c1@amd.com>
Content-Language: en-US
From: Peter Jung <ptr1337@cachyos.org>
Organization: CachyOS
In-Reply-To: <7eaf557d-7e85-4fd3-abee-f84ac01d92c1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Dhananjay,

On 20.11.24 14:58, Dhananjay Ugwekar wrote:
> Hello Peter Jung,
> 
> Thanks for trying out the patchset,
> 
> On 11/20/2024 1:28 PM, Peter Jung wrote:
>> Hi together,
>>
>> This patch seems to crash the kernel  and results into a not bootable system.
>>
>>
>> The patch has been applied on base 6.12.rc7 - I have not tested it yet on linux-next.
>>
>> I was able to reproduce this issue also on the v6 and the only "good" version was the v4.
>> This has been reproduced on several zen3+ machines and also on my 9950X.
>>
>> Bisect log:
>> ```
>> git bisect start
>> # status: waiting for both good and bad commits
>> # good: [2d5404caa8c7bb5c4e0435f94b28834ae5456623] Linux 6.12-rc7
>> git bisect good 2d5404caa8c7bb5c4e0435f94b28834ae5456623
>> # status: waiting for bad commit, 1 good commit known
>> # bad: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add core energy counter support for AMD CPUs
>> git bisect bad 372e95a40e04ae6ebe69300b76566af6455ba84e
>> # good: [fd3c84b2fc8a50030e8c7d91983f50539035ec3a] perf/x86/rapl: Rename rapl_pmu variables
>> git bisect good fd3c84b2fc8a50030e8c7d91983f50539035ec3a
>> # good: [96673b2c940e71fde50a54311ecdce00ff7a8e0b] perf/x86/rapl: Modify the generic variable names to *_pkg*
>> git bisect good 96673b2c940e71fde50a54311ecdce00ff7a8e0b
>> # good: [68b214c92635f0b24a3f3074873b77f4f1a82b80] perf/x86/rapl: Move the cntr_mask to rapl_pmus struct
>> git bisect good 68b214c92635f0b24a3f3074873b77f4f1a82b80
>> # first bad commit: [372e95a40e04ae6ebe69300b76566af6455ba84e] perf/x86/rapl: Add core energy counter support for AMD CPUs
>> ```
>>
>> Nov 17 12:17:37 varvalian kernel: RIP: 0010:internal_create_group+0x9a/0x4e0
>> Nov 17 12:17:37 varvalian kernel: Code: 7b 20 00 0f 84 cb 00 00 00 48 8d 74 24 1c 48 8d 54 24 18 4c 89 ff e8 15 8a 99 00 48 83 3b 00 74 59 48 8b 43 18 48 85 c0 74 11 <48> 8b 30 48 85 f6 74 09 4c 8b 5b 08 4d 85 db 75 1a 48 8b 43 20 48
>> Nov 17 12:17:37 varvalian kernel: RSP: 0018:ffffaa5281fe7868 EFLAGS: 00010202
>> Nov 17 12:17:37 varvalian kernel: RAX: 796772656e650073 RBX: ffffffffc2a642aa RCX: f781ec27a963db00
>> Nov 17 12:17:37 varvalian kernel: RDX: ffffaa5281fe7880 RSI: ffffaa5281fe7884 RDI: ffff90c611dc8400
>> Nov 17 12:17:37 varvalian kernel: RBP: 000000000000000f R08: 0000000000000000 R09: 0000000000000001
>> Nov 17 12:17:37 varvalian kernel: R10: 0000000002000001 R11: ffffffff8e86ee00 R12: 0000000000000000
>> Nov 17 12:17:37 varvalian kernel: R13: ffff90c6038469c0 R14: ffff90c611dc8400 R15: ffff90c611dc8400
>> Nov 17 12:17:37 varvalian kernel: FS:  00007163efc54880(0000) GS:ffff90c8efe00000(0000) knlGS:0000000000000000
>> Nov 17 12:17:37 varvalian kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Nov 17 12:17:37 varvalian kernel: CR2: 00005c1834b98298 CR3: 0000000121298000 CR4: 0000000000f50ef0
>> Nov 17 12:17:37 varvalian kernel: PKRU: 55555554
>> Nov 17 12:17:47 varvalian kernel: ------------[ cut here ]------------
>> ```
>>
>> Ill do on the weekend some additonal tests based on the latest linux-next snapshot and provide some more logs.
> Can you please try with the below diff once,
> 
> diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
> index e9be1f31163d..d3bb3865c1b1 100644
> --- a/arch/x86/events/rapl.c
> +++ b/arch/x86/events/rapl.c
> @@ -699,6 +699,7 @@ static const struct attribute_group *rapl_attr_update[] = {
> 
>   static const struct attribute_group *rapl_core_attr_update[] = {
>          &rapl_events_core_group,
> +       NULL,
>   };
> 
>   static int __init init_rapl_pmu(struct rapl_pmus *rapl_pmus)
> 
> Regards,
> Dhananjay
> 


Thanks! This patch appears to fix the issue, when the kernel is built 
with clang. Thanks for providing such fast fix! :)

Peter


>> Regards,
>>
>> Peter

