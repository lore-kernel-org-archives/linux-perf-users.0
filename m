Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579A20DC5;
	Mon, 27 May 2024 06:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716790346; cv=none; b=Zh/5kLTx9zvD+/ThV58lGppepIh5ojfd0KwITnJflbSqIA0+eB3FjZCB4QukgLqlU1UmYqttuxxYtMLGQvNexrRPCHwLz7wbRjnb0qHhCT5cmA9MRPxmWwJzYI+1EP5EypRGnGdJTQKTESOpjousYKZAveCLd8fUPzA3BWN2ysM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716790346; c=relaxed/simple;
	bh=yf/cQNmggHigjsGThUoVM19am4FVLnwqeQyvC3Ti0zQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f8wW62Y2og4MvVs/xMCK9AD09RmLHQEA1YfdMuTn1P0ux/IecfJcBcHG+7zWXkTHC40zlEOyCxAfcTJgx7B9xritdULepNUJ5BEVcgs0sgj0Hg+tsB1ML3ihRt9Uwnuv0BHdGVXZc5bD62jTmfZTiG8DU2wb2sScZHWwkGGmdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nniJu/Mq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nniJu/Mq"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f850ff30c0so3097730b3a.0;
        Sun, 26 May 2024 23:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716790345; x=1717395145; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3ha3ttuHDRqNnlP/Z8/eQDNBiXRUGr96YwwyOzK4k54=;
        b=nniJu/MqWVeJLnHUTqE/vSBduu3QRzlJG+yMKBu4tmoFvaWjwZKv37agcCJ3F8CPhp
         WwUMxY2RoEVgCNwf0Qfq+sab2n3VFWWvpaY5QiocRVoestu/e0NyZ8P+d7cWbtK6JZtn
         17spJTBGeNy4XVq8MRPM6HDVe5+qNAyvHdp/UbHFyWcQzF3sGPMpuVIr/FzqVF7+7FOe
         Qb/V48AWzucbHsVSb5suP96Bi2gsLNxxPZinDylLwhBcQTWj4zwiedq55RZRRz8v92Je
         238NreNIuelXSLVhvBP7L7vgWh/GEy9EctTkfTzmDzhUF23E/toU00sxYsb/ogCsE9Fc
         RWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716790345; x=1717395145;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3ha3ttuHDRqNnlP/Z8/eQDNBiXRUGr96YwwyOzK4k54=;
        b=E0d2johXmwyzlZxv3HKnX9fo2kRTMaYssZoEpWesPfcTfCn71X7UMklZM7u4KMLnfQ
         W/iLS9fesATvyeUBHIe7WGEsYasC5s4wMrOjhdDKEVsbm+5Ls3deLbLyKDQwJ84svOe0
         Rz2yTlDOR9DA86VnQ8lCwGIFMZ547w65gU7pnKfREKfF8odK84FNLZ8WPw8X5JQ/GOQZ
         TCcnWaxfmqDJ/aLhh+PXG0NSutcFSvaluurRitCWkqdmknBektJCWMHNOLGWh50nz4sz
         NF2aO/+SBAV2674VszrZEh17MgJp9dydRVc3VUBcAyOTdrn/scUny4AmMwPlB34HtMMi
         P+2A==
X-Forwarded-Encrypted: i=1; AJvYcCV7fLjz7utEwp98TJuNpSbK91zliPJCJiMxKY8lbnjIA5rmVVLjZREy4zSIufGAWf56iyR/cBdEwy2QyezrJQjEs3G6ybV9jslOUt/eyB9oQzbOi4yZNa/6LR54lPtHfnJr4wQG51fdYnX5KnEFPA==
X-Gm-Message-State: AOJu0Yw36Zgct1roxYLhH6WfjwC+v7yT3KdbXQ1nKNcssnmIA0eCA9MU
	zeLfmdDmNZ7oflDaZpmkCGjvJ2iWptJaq1yj+AqXdFVhEl/xh7WX
X-Google-Smtp-Source: AGHT+IE8ffxUSRQG9zQZUih6diPm/Qro2Bk9ChCA5Jktl2/w4H3kfZt/0Cw4NAQIsnO/D0x756u9WQ==
X-Received: by 2002:a05:6a20:72a8:b0:1b1:c745:5c66 with SMTP id adf61e73a8af0-1b212e64d95mr10891105637.54.1716790344649;
        Sun, 26 May 2024 23:12:24 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2bdd9f50eddsm6900791a91.42.2024.05.26.23.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 May 2024 23:12:24 -0700 (PDT)
Message-ID: <bb87c165-679b-413c-a62c-93b4772e3107@gmail.com>
Date: Mon, 27 May 2024 15:12:18 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] buitin-kvm: Update cmd_kvm() to check perf_host value
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, skhan@linuxfoundation.org,
 Austin Kim <austindh.kim@gmail.com>, shjy180909@gmail.com,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
References: <20240515195252.75909-1-yskelg@gmail.com>
 <CAM9d7ciFpGhQat3esWLBUDNc1pzAqVw+8d+oX-WJeN+KJfW8Ew@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CAM9d7ciFpGhQat3esWLBUDNc1pzAqVw+8d+oX-WJeN+KJfW8Ew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 5/23/24 1:23 오후, Namhyung Kim wrote:
> Hello,
> 
> On Wed, May 15, 2024 at 12:54 PM <yskelg@gmail.com> wrote:
>>
>> From: Yunseong Kim <yskelg@gmail.com>
>>
>> According to perf-kvm.txt, the default operation is --guest, meaning
>> perf_host should be set to false and perf_guest to true. Currently,
>> the incorrect usage of --no-host and --no-guest still results in
>> the default --guest operation.
> 
> Hmm, right.. This is not good.
> 
>>
>> This patch updates the usage messages to include the --no-guest option
>> for those who only want host data, as well as the --no-host and
>> --no-guest case.
> 
> I'm not sure if it's worth mentioning the host-only use case which is
> not expected for this command.  I think it's enough to warn the
> no-host and no-guest use cases.

Thank you Namhyung for the code review!

I wasn't sure if it was necessary to mention that either.

I should have asked in the patch mail first.

>> Signed-off-by: Yunseong Kim <yskelg@gmail.com>
>> ---
>>  tools/perf/builtin-kvm.c | 19 +++++++++++++------
>>  1 file changed, 13 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/perf/builtin-kvm.c b/tools/perf/builtin-kvm.c
>> index 71165036e4ca..654a07658cdd 100644
>> --- a/tools/perf/builtin-kvm.c
>> +++ b/tools/perf/builtin-kvm.c
>> @@ -2129,7 +2129,7 @@ int cmd_kvm(int argc, const char **argv)
>>                 OPT_BOOLEAN(0, "guest", &perf_guest,
>>                             "Collect guest os data"),
>>                 OPT_BOOLEAN(0, "host", &perf_host,
>> -                           "Collect host os data"),
>> +                          "Collect host os data. Host only with --host --no-guest"),
>>                 OPT_STRING(0, "guestmount", &symbol_conf.guestmount, "directory",
>>                            "guest mount directory under which every guest os"
>>                            " instance has a subdir"),
>> @@ -2150,16 +2150,23 @@ int cmd_kvm(int argc, const char **argv)
>>                                                 "buildid-list", "stat", NULL };
>>         const char *kvm_usage[] = { NULL, NULL };
>>
>> -       perf_host  = 0;
>> -       perf_guest = 1;
>> +       /*
>> +        * tools/perf/Documentation/perf-kvm.txt
>> +        *
>> +        *    Default('')         ->  perf.data.guest
>> +        *    --host              ->  perf.data.kvm
>> +        *    --guest             ->  perf.data.guest
>> +        *    --host --guest      ->  perf.data.kvm
>> +        *    --host --no-guest   ->  perf.data.host
>> +        */
>> +       perf_host = false;
>> +       perf_guest = true;
> 
> Probably not needed.

I agree.

>>
>>         argc = parse_options_subcommand(argc, argv, kvm_options, kvm_subcommands, kvm_usage,
>>                                         PARSE_OPT_STOP_AT_NON_OPTION);
>> -       if (!argc)
>> +       if (!argc || (!perf_host && !perf_guest))
>>                 usage_with_options(kvm_usage, kvm_options);
>>
>> -       if (!perf_host)
>> -               perf_guest = 1;
> 
> Instead of showing the whole usage, I think it's better to
> print a specific message for this case.
> 
> Oh, I've realized that we have 'h' modifier for hypervisors
> (on ARM64?)  Then maybe no-host + no-guest is a valid
> combination.  Probably we need to add --hypervisor option
> then.
> 
> Thanks,
> Namhyung

Yes, I have a native Arm64 devlopment environment.

So I'll implement and test it and send the patch.


Thank you so much for the detailed review!


Warm Regards,

Yunseong Kim

>>
>>         if (!file_name) {
>>                 file_name = get_filename_for_perf_kvm();
>> --
>> 2.34.1
>>
