Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008715F3F9
	for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727687273; cv=none; b=L4qAEy+2qbKErHd7ZzfT4Np64ovcxVmLByk/vCNiRPEtsJokaL9MwgD4sZtc/8iIFTKsChKgwKgNvHTG7pqs/5pQH9GNXE7z59RSFnL4AN4bMxzXS5F08FRXwnU1gJtH8zGKI513KiiyQpW8HzRGqKvUiMJxYLyOi4TCsJrqFPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727687273; c=relaxed/simple;
	bh=+Om91mkQUsNePuR3MhqSUag1znVDLM7nwu1GCsMReWk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHWepkZoa8tNczpXj9kI9NJToMxIaPKPt7MLQB+SsePmFDsdDoWGZeJFUdoWoXvB5t7smdK7phdp7jddXromkEglPXgW5iqdumZOLEgmc12f4V4qsZzvSqxhqYizXjNAhiH+NZ0mwYBee8LcjwJRKSeb8zLYLr06FOFBcRtKiXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MEjiBvFy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MEjiBvFy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727687270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XwrGQuFIUhjPl+HUFddpblMJN3nQSRNzEU4gxyZ8rRE=;
	b=MEjiBvFyxDdpEkzwrbrUMddhdey1Zc543QLl9NzDdMrDmA7h0TbYKzanYT4ED8oD54ot9K
	KIkf5kkQBNRh/qnml64PmQw0qwpwnirhVUNLK5W76gG2YVSY3lSugmd200O+oo8+0QR68P
	AiiJAPTrd9aqGum5Io+LCsJ6VhTphP8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-Y4m-KAkkPlypFgP8TkSvkA-1; Mon, 30 Sep 2024 05:07:48 -0400
X-MC-Unique: Y4m-KAkkPlypFgP8TkSvkA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37ccd40aad4so1883661f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 30 Sep 2024 02:07:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727687267; x=1728292067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XwrGQuFIUhjPl+HUFddpblMJN3nQSRNzEU4gxyZ8rRE=;
        b=WXiTlb3fvD3jiIjyy/gL85Y6Bj5LfjPtJxFExynYtJ+Ix/4kTXj2VtzR0GMImDyiEu
         9awmNzYnshd7NWvUNvWFkOoIN8UsF7zKIH+w7e45sgh6pMpf12ceQgQc6agYUTC6+WN5
         me0jPFAx+sGJnmoW+RZGMR5SULi5HZDXcf/yx/cy4ihBAAbov0warTYJGLeex7QkyWQ1
         A/IyxAZyZ8PXFpyWXdKn2sqrBk6U7316WMxW1ZNo8rYHpgYLT1EohU2T5+wBmSbABIDX
         MThuyBk853c6KdTTG88sS/NSpwhaHxB8yrrVLqFujVOx7yio2w+1xH2DDeWjdqSQYllP
         DlbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKyA3nfrRhuiFhSuTrD1ONjLiZVwtbTPwAymHLOIuoswAZWD8EhyaPZbUgFWcBk3QHe23O9dzgOGFDEWpqu8ji@vger.kernel.org
X-Gm-Message-State: AOJu0YwM5MhVvtBcFcYJrL7FxZ6+Lug9/PXVq+0m+XeHg5/Q97MiSPX5
	zf4pR2FsRqzVKQAQOisiFCbOUe73p+/In6S7dauUUsXHXiryKwx0llByFhdnhGDdxKJyBRU+jVF
	Q1in+dGfi7Xvzxn8zQYPbB9hsmdFc1Uo900HiljSBS8CCLYcT1SnRDzt4rNOzgaecgiE=
X-Received: by 2002:adf:e589:0:b0:37c:d183:abd6 with SMTP id ffacd0b85a97d-37cd5a9a255mr5408863f8f.32.1727687267502;
        Mon, 30 Sep 2024 02:07:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERsQinhFyBpAWA0rg/qe1osA80CSM0+d6f/PTAVjQTuhSFAVVqUoaMsmadejv3vQRaM9LXYQ==
X-Received: by 2002:adf:e589:0:b0:37c:d183:abd6 with SMTP id ffacd0b85a97d-37cd5a9a255mr5408848f8f.32.1727687267116;
        Mon, 30 Sep 2024 02:07:47 -0700 (PDT)
Received: from [10.202.147.124] (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575dfd2sm8482188f8f.117.2024.09.30.02.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 02:07:46 -0700 (PDT)
Message-ID: <2ac467a9-065f-4da2-858c-04e72ce70b55@redhat.com>
Date: Mon, 30 Sep 2024 11:07:45 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf trace: Keep exited threads for summary
To: Michael Petlan <mpetlan@redhat.com>, linux-perf-users@vger.kernel.org,
 irogers@google.com
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
 namhyung@kernel.org, mark.rutland@arm.com,
 alexander.shishkin@linux.intel.com, jolsa@kernel.org,
 adrian.hunter@intel.com, kan.liang@linux.intel.com
References: <20240927151926.399474-1-mpetlan@redhat.com>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <20240927151926.399474-1-mpetlan@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/24 17:19, Michael Petlan wrote:
> Since 9ffa6c7512ca ("perf machine thread: Remove exited threads by
> default") perf cleans exited threads up, but as said, sometimes they
> are necessary to be kept. The mentioned commit does not cover all the
> cases, we also need the information to construct the summary table in
> perf-trace.
> 
> Before:
>     # perf trace -s true
> 
>      Summary of events:
> 
> After:
>     # perf trace -s -- true
> 
>      Summary of events:
> 
>      true (383382), 64 events, 91.4%
> 
>        syscall            calls  errors  total       min       avg       max       stddev
>                                          (msec)    (msec)    (msec)    (msec)        (%)
>        --------------- --------  ------ -------- --------- --------- ---------     ------
>        mmap                   8      0     0.150     0.013     0.019     0.031     11.90%
>        mprotect               3      0     0.045     0.014     0.015     0.017      6.47%
>        openat                 2      0     0.014     0.006     0.007     0.007      9.73%
>        munmap                 1      0     0.009     0.009     0.009     0.009      0.00%
>        access                 1      1     0.009     0.009     0.009     0.009      0.00%
>        pread64                4      0     0.006     0.001     0.001     0.002      4.53%
>        fstat                  2      0     0.005     0.001     0.002     0.003     37.59%
>        arch_prctl             2      1     0.003     0.001     0.002     0.002     25.91%
>        read                   1      0     0.003     0.003     0.003     0.003      0.00%
>        close                  2      0     0.003     0.001     0.001     0.001      3.86%
>        brk                    1      0     0.002     0.002     0.002     0.002      0.00%
>        rseq                   1      0     0.001     0.001     0.001     0.001      0.00%
>        prlimit64              1      0     0.001     0.001     0.001     0.001      0.00%
>        set_robust_list        1      0     0.001     0.001     0.001     0.001      0.00%
>        set_tid_address        1      0     0.001     0.001     0.001     0.001      0.00%
>        execve                 1      0     0.000     0.000     0.000     0.000      0.00%
> 
> Fixes: 9ffa6c7512ca ("perf machine thread: Remove exited threads by default")
> 
> Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>

The -S and -s option works after this patch, but --errno-summary ends with
segfault for some reason.

Before:
	# perf trace --errno-summary -- true


 	Summary of events:

After:
	# perf trace --errno-summary -- true

	 Summary of events:
	
	 true (11386), 60 events, 90.9%
	
   	   syscall            calls  errors  total       min       avg       max       stddev
        	                             (msec)    (msec)    (msec)    (msec)        (%)
 	   --------------- --------  ------ -------- --------- --------- ---------     ------
   	   mmap                   8      0     0.044     0.003     0.006     0.010     15.17%
   	   mprotect               3      0     0.014     0.004     0.005     0.005      4.56%
   	   openat                 2      0     0.009     0.004     0.004     0.005      5.14%
   	   munmap                 1      0     0.007     0.007     0.007     0.007      0.00%
  	   access                 1      1     0.004     0.004     0.004     0.004      0.00%
	perf: Segmentation fault
	Obtained 12 stack frames.
	./perf() [0x5ae123]
	./perf() [0x5ae1cb]
	/lib64/libc.so.6(+0x3dbb0) [0x7f633845fbb0]
	./perf() [0x56e2fb]
	./perf() [0x4850b3]
	./perf() [0x48ee89]
	./perf() [0x493042]
	./perf() [0x49334b]
	./perf() [0x40ee8c]
	/lib64/libc.so.6(+0x27b8a) [0x7f6338449b8a]
	/lib64/libc.so.6(__libc_start_main+0x8b) [0x7f6338449c4b]
	./perf() [0x40f4b5]
	Segmentation fault

Will try to check what is causing this issue.

Thanks,
Veronika

> ---
>  tools/perf/builtin-trace.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> index f6e847529073..1a12ed71c809 100644
> --- a/tools/perf/builtin-trace.c
> +++ b/tools/perf/builtin-trace.c
> @@ -5449,6 +5449,10 @@ int cmd_trace(int argc, const char **argv)
>  	if (trace.summary_only)
>  		trace.summary = trace.summary_only;
>  
> +	/* Keep exited threads, otherwise information might be lost for summary */
> +	if (trace.summary || trace.summary_only)
> +		symbol_conf.keep_exited_threads = true;
> +
>  	if (output_name != NULL) {
>  		err = trace__open_output(&trace, output_name);
>  		if (err < 0) {

