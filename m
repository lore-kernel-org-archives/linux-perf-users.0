Received: from msa.smtpout.orange.fr (out-69.smtpout.orange.fr [193.252.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7E28494;
	Mon,  6 May 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715021869; cv=none; b=o4QnpTNC+WlIxrEUC1lgwCUOUJs/Pk5AqpouOwC2golW1cJ8jLzelVDtIDAtec3tO29DFxdDPGdetiU+b/oLZKeEulQgfxTI+B47ken9V48wQSEexC8x9e1TtF2+R+Je7d7zABSrIB/TJChyM5vSaxySqqq8BaDUiw2YH09abro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715021869; c=relaxed/simple;
	bh=GAhjzktko9OJNax9dYX89eovXWodEDQfe816vqcI7KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ0dZoNv1ACF1F53pDtIEFCXDZ1rtsdZ0ScWzLP4wj5FASNb2iS2P1PXwe7K6QDfqJmIn7RF6amYwopnbDCi6zVOBCLjH0UI/yqTWQyp3k/kflZ53Lb7j0l2JZbd7bm3RXE+aAoK/807MSKTcl54si4wATExYuiO6101y3KVWiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=dGqovjk8; arc=none smtp.client-ip=193.252.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="dGqovjk8"
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 4303s7MviME2z4303s0Gms; Mon, 06 May 2024 20:23:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715019829;
	bh=vwITn4CstTzZtAQHEM9ECl1VAD7MHWLyJIGr0JqDJWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=dGqovjk8SpXn+6fzebG7jnal19Q9YCOe4fQ71SJ2pHcDylCc9zwstLn198z9fAnSc
	 kGLiPW7zOmVLTimp1JWnQC1tfZZEMQzu33s73nO1THQfHx8dDoRKkG5+Cc9CChsFMb
	 dVLXabdsyBl1aq89K9kkXBeV1W3COUGw9yuGrDNLG7l0zrKsY3+bUbrryxjpIw4kVC
	 y/cB9NsqVfHOOBjbqphmRvNggJR0/CwzgC/rWrW169SeQvOL9DX7z9pc71BwJo3EFN
	 klsXlnu3HhSfimK8QjXXheWEkyBwRsHCrKrdQ+sLzOZy9a+mEk4Ly5xI1kxctiuws9
	 BfpUu8Q9rDsWg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 06 May 2024 20:23:49 +0200
X-ME-IP: 86.243.17.157
Message-ID: <b3509a36-1fbc-4311-853b-bb5e6d25f0ad@wanadoo.fr>
Date: Mon, 6 May 2024 20:23:43 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] perf/ring_buffer: Prefer struct_size over open coded
 arithmetic
To: Kees Cook <keescook@chromium.org>, Erick Archer <erick.archer@outlook.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
References: <AS8PR02MB7237569E4FBE0B26F62FDFDB8B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <51a49bae-bd91-428e-b476-f862711453a0@wanadoo.fr>
 <AS8PR02MB7237EF9D1962834BE4D2C5F88B1D2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <202405060856.53AFAE4F22@keescook>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <202405060856.53AFAE4F22@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/05/2024 à 18:23, Kees Cook a écrit :
> On Sun, May 05, 2024 at 07:31:24PM +0200, Erick Archer wrote:
>> On Sun, May 05, 2024 at 05:24:55PM +0200, Christophe JAILLET wrote:
>>> Le 05/05/2024 à 16:15, Erick Archer a écrit :
>>>> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
>>>> index 4013408ce012..080537eff69f 100644
>>>> --- a/kernel/events/ring_buffer.c
>>>> +++ b/kernel/events/ring_buffer.c
>>>> @@ -822,9 +822,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>>>>    	unsigned long size;
>>>
>>> Hi,
>>>
>>> Should size be size_t?
>>
>> I'm sorry, but I don't have enough knowledge to answer this question.
>> The "size" variable is used as a return value by struct_size and as
>> a parameter to the order_base_2() and kzalloc_node() functions.
> 
> For Linux, size_t and unsigned long are the same (currently).
> Pedantically, yes, this should be size_t, but it's the same.
> 
>> [...]
>>> 	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
>>> 	if (!all_buf)
>>> 		goto fail_all_buf;
>>>
>>> 	rb->user_page = all_buf;
>>> 	rb->data_pages[0] = all_buf + PAGE_SIZE;
>>> 	if (nr_pages) {					<--- here
>>> 		rb->nr_pages = 1;			<---
>>> 		rb->page_order = ilog2(nr_pages);
>>> 	}
>> [...]
>> I think that we don't need to deal with the "nr_pages = 0" case
>> since the flex array will always have a length of one.
>>
>> Kees, can you help us with this?
> 
> Agh, this code hurt my head for a while.
> 
> all_buf contains "nr_pages + 1" pages. all_buf gets attached to
> rb->user_page, and then rb->data_pages[0] points to the second page in
> all_buf... which means, I guess, that rb->data_pages does only have 1
> entry.
> 
> However, the nr_pages == 0 case is weird. Currently, data_pages[0] will
> still get set (which points ... off the end of all_buf). If we
> unconditionally set rb->nr_pages to 1, we're changing the behavior. If
> we _don't_ set rb->data_pages[0], we're changing the behavior, but I
> think it's an invalid pointer anyway, so this is the safer change to
> make. I suspect the right replacement is:
> 
> 
> diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
> index 4013408ce012..7d638ce76799 100644
> --- a/kernel/events/ring_buffer.c
> +++ b/kernel/events/ring_buffer.c
> @@ -916,15 +916,11 @@ void rb_free(struct perf_buffer *rb)
>   struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>   {
>   	struct perf_buffer *rb;
> -	unsigned long size;
>   	void *all_buf;
>   	int node;
>   
> -	size = sizeof(struct perf_buffer);
> -	size += sizeof(void *);
> -
>   	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
> -	rb = kzalloc_node(size, GFP_KERNEL, node);
> +	rb = kzalloc_node(struct_size(rb, nr_pages, 1), GFP_KERNEL, node);
>   	if (!rb)
>   		goto fail;
>   
> @@ -935,9 +931,9 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
>   		goto fail_all_buf;
>   
>   	rb->user_page = all_buf;
> -	rb->data_pages[0] = all_buf + PAGE_SIZE;
>   	if (nr_pages) {
>   		rb->nr_pages = 1;
> +		rb->data_pages[0] = all_buf + PAGE_SIZE;
>   		rb->page_order = ilog2(nr_pages);
>   	}

This is also what make the most sense to me.

CJ

>   
> 
> 
> Also, why does rb_alloc() take an "int" nr_pages? The only caller has an
> unsigned long argument for nr_pages. Nothing checks for >INT_MAX that I
> can find.
> 

