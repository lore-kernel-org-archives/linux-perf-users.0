Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52F812C7FD
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Apr 2024 11:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713873247; cv=none; b=a2LB/jMxnt3piMuBgy4AhmyoWAy69SJ6Se6jH+LpaFP5ebYXBxBQn2qhW81PFHVfYX/EKdFEaqWed/HZHptIhmAW/eCH8mddvj2u+yu6dnAT1BYUb3CyGmLJTczGkdVXfeRoDGBdCEKthRpvU4A6l/P4fnD7pcXOyC9/yy8W1kE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713873247; c=relaxed/simple;
	bh=IkJimX/EmDbVhr1M+62fmhW3CXg6NJBgGh7mQtDplN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=foHiKE1ur5dJBNDXeSLLr5Ky6Wjzhuq1GK7peyLoBG/9vO1mBVVJxnOBBZAO10IyCYBZqXiQd7Ty7Tk6xVgbynaCUIObU0JHYAF4h+ufiuAJlaOSEQhHXqZnE6vasBnopRQ6ZlFxWPuet7B0IpdvBfoEfHDiZf1aA47MopBZkTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A60C339;
	Tue, 23 Apr 2024 04:54:33 -0700 (PDT)
Received: from [10.163.64.117] (unknown [10.163.64.117])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDBD33F7BD;
	Tue, 23 Apr 2024 04:54:03 -0700 (PDT)
Message-ID: <7d6330bd-5b0a-49d2-83bf-ac1ca11996d0@arm.com>
Date: Tue, 23 Apr 2024 17:23:55 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 8/8] perf test: Check output of the probe ... --funcs
 command
Content-Language: en-US
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-9-ChaitanyaS.Prakash@arm.com>
 <20240409080902.6f2ccd1239c64ca49861d6d6@kernel.org> <ZiAUSxRYTty5uh6m@x1>
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
In-Reply-To: <ZiAUSxRYTty5uh6m@x1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 4/17/24 23:56, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 09, 2024 at 08:09:02AM +0900, Masami Hiramatsu wrote:
>> On Mon,  8 Apr 2024 11:52:30 +0530
>> Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
>>
>>> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>>>
>>> Test "perf probe of function from different CU" only checks if the perf
>>> command has failed and doesn't test the --funcs output. In the issue
>>> reported in the previous commit, the garbage output of the --funcs
>>> command was being ignored by the test when it could have been caught.
>>>
>>> An additional check to grep for "foo" has been added to test the --funcs
>>> output.
>> Looks good to me.
>>
>> Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
>>> @@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
>>>   gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
>>>   gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
>>>   
>>> -perf probe -x ${temp_dir}/testfile --funcs foo
>>> +perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
>>>   perf probe -x ${temp_dir}/testfile foo
> Have you tested this?
>
> Because:
>
> root@x1:~# perf probe -x /lib64/libc.so.6 malloc | grep malloc || echo failure
> Added new event:
>    probe_libc:malloc    (on malloc in /usr/lib64/libc.so.6)
>
> You can now use it in all perf tools, such as:
>
> 	perf record -e probe_libc:malloc -aR sleep 1
>
> failure
> root@x1:~# perf probe -d *:*
> Removed event: probe_libc:malloc
> root@x1:~# perf probe -x /lib64/libc.so.6 malloc |& grep malloc || echo failure
>    probe_libc:malloc    (on malloc in /usr/lib64/libc.so.6)
> 	perf record -e probe_libc:malloc -aR sleep 1
> root@x1:~#
>
>
> that plain '| grep "foo"' isn't enough, will always fail, as the output
> isn't sent to stdout, but to stderr, so, with your patch:
>
> root@x1:~# perf test different
> 121: test perf probe of function from different CU                   : FAILED!
> root@x1:~# set -o vi
> root@x1:~# perf test -v different
> 121: test perf probe of function from different CU:
> --- start ---
> test child forked, pid 938178
> --- Cleaning up ---
> "foo" does not hit any event.
>    Error: Failed to delete events.
> ---- end(-1) ----
> 121: test perf probe of function from different CU                   : FAILED!
> root@x1:~#
>
>
> We need to use '|&' to grep in both stdout and stderr, see how 'perf
> probe' uses stderr:
>
> root@x1:~# perf probe -d *:*
> Removed event: probe_libc:malloc
> root@x1:~# perf probe -x /lib64/libc.so.6 malloc > /dev/null
> Added new event:
>    probe_libc:malloc    (on malloc in /usr/lib64/libc.so.6)
>
> You can now use it in all perf tools, such as:
>
> 	perf record -e probe_libc:malloc -aR sleep 1
>
> root@x1:~
>
>
> Using '|&' to grep:
>
> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> index 82bc774a078a15d5..af8b1fa639f3daa4 100755
> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
> @@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
>   gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
>   gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
>   
> -perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
> +perf probe -x ${temp_dir}/testfile --funcs foo |& grep "foo"
>   perf probe -x ${temp_dir}/testfile foo
>   
>   cleanup
> ⬢[acme@toolbox perf-tools-next]$
>
> root@x1:~# perf test different
> 121: test perf probe of function from different CU                   : Ok
> root@x1:~# set -o vi
> root@x1:~# perf test -v different
> 121: test perf probe of function from different CU                   : Ok
> root@x1:~# perf test -vv different
> 121: test perf probe of function from different CU:
> --- start ---
> test child forked, pid 1048947
> Added new event:
>    probe_testfile:foo   (on foo in /tmp/perf-uprobe-different-cu-sh.5qg9UX2dUJ/testfile)
>
> You can now use it in all perf tools, such as:
>
> 	perf record -e probe_testfile:foo -aR sleep 1
>
> --- Cleaning up ---
> Removed event: probe_testfile:foo
> ---- end(0) ----
> 121: test perf probe of function from different CU                   : Ok
> root@x1:~#
>
> I'm amending the patch with this fix.
>
>
> Thanks,
>
> - Arnaldo

Hi Arnaldo, line 80 of the test makes use of the --funcs option with
perf probe, which redirects the output to stdout itself. So this change
might not be required.

[~/workspace/linux/tools/perf]$ sudo ./perf probe -x 
/lib/x86_64-linux-gnu/libc.so.6 --funcs malloc | grep malloc || echo failure
malloc

Thanks,

- Chaitanya

>
