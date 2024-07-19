Received: from mx-8.mail.web4u.cz (smtp7.web4u.cz [81.91.87.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2B11B86D2;
	Fri, 19 Jul 2024 10:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.91.87.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721386476; cv=none; b=ibx0MW52/oQSXRU7G4MSqz28bUaJmIvq37ASGl7WQwk5NHbYCSFdiAonOtL4cvrJWjmH2uEnLMubG5hkSATMTySdjqaIZZTtN34QOr1JMz8DuVvQ38AliW6DlE16CZWB5dstyLmxQ27hW5lo5FjygtVef/VLuOzHnBYjcs6a14I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721386476; c=relaxed/simple;
	bh=drEMb5cS/FjoRPEpXGcOulJuhOeMsLSphwKQjWNihA0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtNG6DQuIv6mlR60WQr1yAlklaN+HJjT4Jz8wBf5I5cpuvd97TrFgJlMx0pz0OVusr2/oNpPscEzyucOfKiOiQsqaMRVPf2w9a9UlLFqAfCCQA8ezEQncb9j+EwfwZQURhWIrlizyAqi+9GUQ6yCpd+97gCPtwEio1F/8WWxLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz; spf=pass smtp.mailfrom=foxlink.cz; arc=none smtp.client-ip=81.91.87.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=foxlink.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxlink.cz
Received: from mx-8.mail.web4u.cz (localhost [IPv6:::1])
	by mx-8.mail.web4u.cz (Postfix) with ESMTP id C7BA91FFCC2;
	Fri, 19 Jul 2024 12:54:25 +0200 (CEST)
Received: from [192.168.0.36] (unknown [193.86.188.206])
	(Authenticated sender: m.liska@foxlink.cz)
	by mx-8.mail.web4u.cz (Postfix) with ESMTPA id A2B8B1FFCC1;
	Fri, 19 Jul 2024 12:54:25 +0200 (CEST)
Message-ID: <0aea2437-3ea1-4cc6-8f5e-cb4aded87fd8@foxlink.cz>
Date: Fri, 19 Jul 2024 12:54:25 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf script: add --addr2line option
To: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 acme@kernel.org, Martin Liska <martin.liska@hey.com>
References: <20240718143009.197851-1-m.liska@foxlink.cz>
 <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Martin_Li=C5=A1ka?= <m.liska@foxlink.cz>
In-Reply-To: <CAP-5=fXPC+pXmJCpvkr5x2Ae1hdKeL7Cd6Uak+7mn+uG+R8yVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-W4U-Auth: 16c9075e93a55c8c196905bf67e054af40a92703



On 7/18/24 17:44, Ian Rogers wrote:
> On Thu, Jul 18, 2024 at 7:30 AM <m.liska@foxlink.cz> wrote:
>>
>> From: Martin Liska <martin.liska@hey.com>
>>
>> Similarly to other subcommands (like report, top), it would be handy to
>> provide a path for addr2line command.
> 
> Thanks Martin, lgtm but you did put a Signed-off-by tag in your commit

Hello.

You likely meant "did not", right? I'm going to fix it in V2.

> message. There is an option in git commit and git format-patch to add
> this for you.
> 
>> ---
>>  tools/perf/Documentation/perf-script.txt |  3 +++
>>  tools/perf/builtin-script.c              | 10 +++++++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
>> index ff086ef05a0c..5abb960c4960 100644
>> --- a/tools/perf/Documentation/perf-script.txt
>> +++ b/tools/perf/Documentation/perf-script.txt
>> @@ -369,6 +369,9 @@ OPTIONS
>>  --demangle-kernel::
>>         Demangle kernel symbol names to human readable form (for C++ kernels).
>>
>> +--addr2line=<path>::
>> +       Path to addr2line binary.
>> +
>>  --header
>>         Show perf.data header.
>>
>> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
>> index c16224b1fef3..301ea1c98e36 100644
>> --- a/tools/perf/builtin-script.c
>> +++ b/tools/perf/builtin-script.c
>> @@ -3897,7 +3897,7 @@ int cmd_script(int argc, const char **argv)
>>         };
>>         struct utsname uts;
>>         char *script_path = NULL;
>> -       const char *dlfilter_file = NULL;
>> +       const char *dlfilter_file = NULL, *addr2line_path = NULL;
>>         const char **__argv;
>>         int i, j, err = 0;
>>         struct perf_script script = {
>> @@ -4052,6 +4052,8 @@ int cmd_script(int argc, const char **argv)
>>                         "Enable symbol demangling"),
>>         OPT_BOOLEAN(0, "demangle-kernel", &symbol_conf.demangle_kernel,
>>                         "Enable kernel symbol demangling"),
>> +       OPT_STRING(0, "addr2line", &addr2line_path, "path",
> 
> Thinking out loud. I'm kind of wondering why we use a local variable
> and not just &symbol_conf.addr2line_path here. I see you've used the
> same logic that is elsewhere like builtin-top.c, so I think it is
> okay.

Yeah, you are right, we can simplify the code as suggested!

Martin

> 
> Thanks,
> Ian
> 
>> +                       "addr2line binary to use for line numbers"),
>>         OPT_STRING(0, "time", &script.time_str, "str",
>>                    "Time span of interest (start,stop)"),
>>         OPT_BOOLEAN(0, "inline", &symbol_conf.inline_name,
>> @@ -4138,6 +4140,12 @@ int cmd_script(int argc, const char **argv)
>>             itrace_synth_opts.callchain_sz > scripting_max_stack)
>>                 scripting_max_stack = itrace_synth_opts.callchain_sz;
>>
>> +       if (addr2line_path) {
>> +               symbol_conf.addr2line_path = strdup(addr2line_path);
>> +               if (!symbol_conf.addr2line_path)
>> +                       return -ENOMEM;
>> +       }
>> +
>>         /* make sure PERF_EXEC_PATH is set for scripts */
>>         set_argv_exec_path(get_argv_exec_path());
>>
>> --
>> 2.45.2
>>
