Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18161D6199
	for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 15:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732633370; cv=none; b=Rpbc3f751KOgDWnbI0VzqjkRMemRztDhzWVm0bcoNKxp8D2DkKxct4ACMQD5jdM9IkwbtyAZXC7jieU+sKiWG+/Dn8TAxbGcoJig2fMdppCh58BZfnXemj8dSNim3IPYJlGHSIkEaHoDjT+tHiB7yLZ7w8xR63ngqkRXaYgZZyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732633370; c=relaxed/simple;
	bh=MsM7037H8f3MhGEX+tCayhMYi04xwCInG4SEqn3F3kE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M19qGiBIkY+KvI5d/LBkyu8uA08OFRON3cFG+plXKeFx4KGAZ16CfLkS2rliYZuNamK3spE1bnu+dy8KzMBaoTIBwB0mEobzzFfa6vh1gtkMOLTj8+FoNmeW3tPPngaE8/mguWns2jl0Z333cAnp0wlsYhodyxg2oWtQ8nfjRi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TmMtzC8G; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TmMtzC8G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732633367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=McdBHhCHVqHtPAqBaY/4MT9hs2HCdAVeD0O/ytMRJW4=;
	b=TmMtzC8GI6CLbGimCLKyU3ZYqif9DQf34kfXvWNMgTJxFdiWyhrF/VuB2xHTEKoYKWlFPx
	WEleMF3hjKxp3mw0neEiEadaMI6PjZPIULAFDvdGptrOmbQQ0fcTWM2NC0QpzIRt2BJtry
	Y1dzXI6y77t/+QloU43TOC7g7pYr7Mw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-nRUvE2ShM0mJsxW9TyeRZA-1; Tue, 26 Nov 2024 10:02:45 -0500
X-MC-Unique: nRUvE2ShM0mJsxW9TyeRZA-1
X-Mimecast-MFC-AGG-ID: nRUvE2ShM0mJsxW9TyeRZA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4349df2d87dso24856145e9.2
        for <linux-perf-users@vger.kernel.org>; Tue, 26 Nov 2024 07:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732633364; x=1733238164;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=McdBHhCHVqHtPAqBaY/4MT9hs2HCdAVeD0O/ytMRJW4=;
        b=ewUoiwMa6KbqjRvrEtWGacfFKlmV4fafmCFzZ5tQQ4liqomziZqEhuGXe+Y2PvSUin
         IGESDC8hev4KIDHR0v4vsmOFAOYdRZsO8QIU8JuTYt6mqxSZHyWzJQAFewv0xb+ACc7X
         6gQnVXYQBxlfdaLAAK/mCiIcY+fxf9Sdm+StcSPV4ciRZIUf9+4qMfpEKjG9JP5c1w4e
         7u93a2bJ1CpfNildhZGZWWjX9bPDH23ybP4GXShFQDwbyq6ngjJ+gnQ0ENmtqUkhXi5A
         /Q9Q9w7TMm551AwCey1RmgMwDM3cfkGkTY38+FFHBR07mViLSfCpYZ4p489lt1VlBG+Y
         rJmg==
X-Forwarded-Encrypted: i=1; AJvYcCViFfsfs1rilOGjOcH/W9tRwTOHBUdqy+WIZ18HUz/EOvmt3AIbKpqSyDAsyn8ABl94/qcII/Q6DCXyizmBoL+j@vger.kernel.org
X-Gm-Message-State: AOJu0YxkAR3a9YN6rIBV5BaJnCbjZPiduOd/gAIUCDoOdWnB5oXYpGso
	7krb0UVzj0i+qC4wk0FtYPzX14GzLQTyfB3qd3u3LalbVpmF1Bwqi+NBCV052uB9Snhlt5j6kR7
	vBtLF7RSKVWLInyCJLS3EtZhNfDfkiMhCafiqKUNArX4uYph21NsXeGCfZWDmtDosX7U=
X-Gm-Gg: ASbGncs4KJWCd62SmCQzDp2VyXiPpikUmtpkLK71wB/E8naxyOdOCwNb7dC/n1I+14+
	epQuprsUAt/gIujagDZdvy8Js+zz/pB9kmnukaaxVhw5erGxEK4Ou+ZdDJPmAqhThrw1QysOgfo
	KvcoCrhj4luQsvi3SmbF3uKeQg26iwGsu2zjMlSLLwEySDt2djGTBylN+/S/g5JE2O3c1FD2LK9
	niFV9wKoP0LhxXPGigGo86Wre7QuPU4wfOd1XuyA1tPusPylC7qAFhIH3SAIj4YLJkX9kgDAe+p
X-Received: by 2002:a05:600c:1c25:b0:434:a5c2:53c1 with SMTP id 5b1f17b1804b1-434a5c2564dmr26597315e9.23.1732633363901;
        Tue, 26 Nov 2024 07:02:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZQ26HyjgLNAll5vKhAXCcNVX5o5F1OTlQoCr3wmcEkVIXCSvR53wgX58ODVJLDbx89XxL6A==
X-Received: by 2002:a05:600c:1c25:b0:434:a5c2:53c1 with SMTP id 5b1f17b1804b1-434a5c2564dmr26592605e9.23.1732633359614;
        Tue, 26 Nov 2024 07:02:39 -0800 (PST)
Received: from [10.43.17.72] (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434a0c88a7asm61283945e9.27.2024.11.26.07.02.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 07:02:39 -0800 (PST)
Message-ID: <a9f59e7a-a72a-466b-a583-1669e064b657@redhat.com>
Date: Tue, 26 Nov 2024 16:02:37 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1 perf-tools] perf machine: Initialize machine->env to
 address a segfault
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
 Kan Liang <kan.liang@linux.intel.com>, Michael Petlan <mpetlan@redhat.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-perf-users@vger.kernel.org
References: <Z0XffUgNSv_9OjOi@x1>
Content-Language: en-US
From: Veronika Molnarova <vmolnaro@redhat.com>
In-Reply-To: <Z0XffUgNSv_9OjOi@x1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/26/24 15:47, Arnaldo Carvalho de Melo wrote:
> Its used from trace__run(), for the 'perf trace' live mode, i.e. its
> strace-like, non-perf.data file processing mode, the most common one.
> 
> The trace__run() function will set trace->host using machine__new_host()
> that is supposed to give a machine instance representing the running
> machine, and since we'll use perf_env__arch_strerrno() to get the right
> errno -> string table, we need to use machine->env, so initialize it in
> machine__new_host().
> 
> Before the patch:
> 
>   (gdb) run trace --errno-summary -a sleep 1
>   <SNIP>
>    Summary of events:
> 
>    gvfs-afc-volume (3187), 2 events, 0.0%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      pselect6               1      0     0.000     0.000     0.000     0.000      0.00%
> 
>    GUsbEventThread (3519), 2 events, 0.0%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      poll                   1      0     0.000     0.000     0.000     0.000      0.00%
>   <SNIP>
>   Program received signal SIGSEGV, Segmentation fault.
>   0x00000000005caba0 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:478
>   478		if (env->arch_strerrno == NULL)
>   (gdb) bt
>   #0  0x00000000005caba0 in perf_env__arch_strerrno (env=0x0, err=110) at util/env.c:478
>   #1  0x00000000004b75d2 in thread__dump_stats (ttrace=0x14f58f0, trace=0x7fffffffa5b0, fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>) at builtin-trace.c:4673
>   #2  0x00000000004b78bf in trace__fprintf_thread (fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>, thread=0x10fa0b0, trace=0x7fffffffa5b0) at builtin-trace.c:4708
>   #3  0x00000000004b7ad9 in trace__fprintf_thread_summary (trace=0x7fffffffa5b0, fp=0x7ffff6ff74e0 <_IO_2_1_stderr_>) at builtin-trace.c:4747
>   #4  0x00000000004b656e in trace__run (trace=0x7fffffffa5b0, argc=2, argv=0x7fffffffde60) at builtin-trace.c:4456
>   #5  0x00000000004ba43e in cmd_trace (argc=2, argv=0x7fffffffde60) at builtin-trace.c:5487
>   #6  0x00000000004c0414 in run_builtin (p=0xec3068 <commands+648>, argc=5, argv=0x7fffffffde60) at perf.c:351
>   #7  0x00000000004c06bb in handle_internal_command (argc=5, argv=0x7fffffffde60) at perf.c:404
>   #8  0x00000000004c0814 in run_argv (argcp=0x7fffffffdc4c, argv=0x7fffffffdc40) at perf.c:448
>   #9  0x00000000004c0b5d in main (argc=5, argv=0x7fffffffde60) at perf.c:560
>   (gdb)
> 
> After:
> 
>   root@number:~# perf trace -a --errno-summary sleep 1
>   <SNIP>
>      pw-data-loop (2685), 1410 events, 16.0%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      epoll_wait           188      0   983.428     0.000     5.231    15.595      8.68%
>      ioctl                 94      0     0.811     0.004     0.009     0.016      2.82%
>      read                 188      0     0.322     0.001     0.002     0.006      5.15%
>      write                141      0     0.280     0.001     0.002     0.018      8.39%
>      timerfd_settime       94      0     0.138     0.001     0.001     0.007      6.47%
> 
>    gnome-control-c (179406), 1848 events, 20.9%
> 
>      syscall            calls  errors  total       min       avg       max       stddev
>                                        (msec)    (msec)    (msec)    (msec)        (%)
>      --------------- --------  ------ -------- --------- --------- ---------     ------
>      poll                 222      0   959.577     0.000     4.322    21.414     11.40%
>      recvmsg              150      0     0.539     0.001     0.004     0.013      5.12%
>      write                300      0     0.442     0.001     0.001     0.007      3.29%
>      read                 150      0     0.183     0.001     0.001     0.009      5.53%
>      getpid               102      0     0.101     0.000     0.001     0.008      7.82%
> 
>   root@number:~#
> 
> Fixes: 54373b5d53c1f6aa ("perf env: Introduce perf_env__arch_strerrno()")
> Reported-by: Veronika Molnarova <vmolnaro@redhat.com>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Ian Rogers <irogers@google.com>
> Cc: James Clark <james.clark@linaro.org>
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Kan Liang <kan.liang@linux.intel.com>
> Cc: Michael Petlan <mpetlan@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

Acked-by: Veronika Molnarova <vmolnaro@redhat.com>

Thanks,
Veronika

> ---
>  tools/perf/util/machine.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
> index 4f0ac998b0ccfd7a..27d5345d2b307a97 100644
> --- a/tools/perf/util/machine.c
> +++ b/tools/perf/util/machine.c
> @@ -134,6 +134,8 @@ struct machine *machine__new_host(void)
>  
>  		if (machine__create_kernel_maps(machine) < 0)
>  			goto out_delete;
> +
> +		machine->env = &perf_env;
>  	}
>  
>  	return machine;

