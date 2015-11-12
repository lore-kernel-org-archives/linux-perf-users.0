From: Brendan Gregg <brendan.d.gregg@gmail.com>
Subject: Re: /tmp/perf-PID.map ownership
Date: Thu, 12 Nov 2015 10:59:36 -0800
Message-ID: <CAE40pdcfdBV_xwJtuBvVe3Fjqxa69W7XT_LN6r9UH94wcfEQeQ@mail.gmail.com>
References: <CAE40pdctG6CUcmangzqSKmd7GkSv1oz7jP5hR-=GFSTTeQ-2sQ@mail.gmail.com>
 <20151112185205.GA7160@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35889 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbbKLTAH (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Thu, 12 Nov 2015 14:00:07 -0500
Received: by iofh3 with SMTP id h3so74811494iof.3
        for <linux-perf-users@vger.kernel.org>; Thu, 12 Nov 2015 11:00:06 -0800 (PST)
In-Reply-To: <20151112185205.GA7160@kernel.org>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: "linux-perf-use." <linux-perf-users@vger.kernel.org>

On Thu, Nov 12, 2015 at 10:52 AM, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
> Em Thu, Nov 12, 2015 at 10:27:26AM -0800, Brendan Gregg escreveu:
>> G'Day,
>>
>> # perf record -F 99 -a -g -- sleep 30
>> [...]
>> # perf report -n --stdio
>> File /tmp/perf-25958.map not owned by current user or root, ignoring it.
>>
>> Can root bypass this test? I'm root, and profiling apps from different
>
> In other places such tests are overridable via '-f' (force), this one
> should too, I think.
>
> # perf report
> File perf.data not owned by current user or root (use -f to override)
> [root@zoo linux]# ls -la perf.data
> -rw-------. 1 acme acme 20032 Nov 12 15:50 perf.data

Yes, a -f option would work too...

Brendan

>
> - Arnaldo
>
>> user-IDs, and the current workaround is to "chown root
>> /tmp/perf*.map". Shouldn't root be able to read these map files? Could
>> we:
>>
>> --- linux-perf/tools/perf/util/symbol.c    2015-11-03 20:08:40.829320940 +0000
>> +++ linux-perf-edited/tools/perf/util/symbol.c    2015-11-12
>> 18:21:35.487077872 +0000
>> @@ -1433,14 +1433,17 @@
>>      dso->adjust_symbols = 0;
>>
>>      if (strncmp(dso->name, "/tmp/perf-", 10) == 0) {
>> +        uint_t euid;
>>          struct stat st;
>>
>>          if (lstat(dso->name, &st) < 0)
>>              goto out;
>>
>> -        if (st.st_uid && (st.st_uid != geteuid())) {
>> -            pr_warning("File %s not owned by current user or root, "
>> -                "ignoring it.\n", dso->name);
>> +        euid = geteuid();
>> +        if (euid && st.st_uid && (st.st_uid != euid)) {
>> +            pr_warning("File %s not owned by current user, and "
>> +                "current user is not root. Ignoring it.\n",
>> +                dso->name);
>>              goto out;
>>          }
>>
>> Brendan
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-perf-users" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
