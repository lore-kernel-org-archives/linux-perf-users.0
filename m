Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBC420DC4
	for <linux-perf-users@vger.kernel.org>; Sun,  7 Jul 2024 14:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720362303; cv=none; b=OXMOAjId2wO31dPZcXqiJW5n06HfQOvk01nsBBubXQlT+GfY9eLLN/U4Spw7oHfYiaxBh46NLfj440ddqDhR+j8EdXqIFhiBCLjXJFbVG04+7o0425odbEnwht9JOSo7X47SNhfXTVH2bNnaXjIgfDI9/5GJEuqdyqVHl4yfx34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720362303; c=relaxed/simple;
	bh=9FDhsGaSZ1lFb7+5wIr5geiWiJcX6cCeWg0XIkWKwKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQp2CCocZIVnilmFG3RpzKZ5Tl4YMxEPA+n6/WtAhtoqSzYeqEs4wbAYA+t0OrQvBfg+NFjrGVE/yFJxbZ7OfqRKe0lcZJkdQokqCgGtOM9tZT8ShqtJ3fnMU7so+aSCBQ88TPPngkxs7Ga41ygQnSY4YMp0CCNvk4MWcU3CsYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9ECF9DA7;
	Sun,  7 Jul 2024 07:25:24 -0700 (PDT)
Received: from [10.57.87.50] (unknown [10.57.87.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 753A23F641;
	Sun,  7 Jul 2024 07:24:55 -0700 (PDT)
Message-ID: <6fb1197f-f2bd-4d80-a14c-526a1fad09a7@arm.com>
Date: Sun, 7 Jul 2024 15:24:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Performance of 'perf'
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
References: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
Content-Language: en-US
From: Leo Yan <leo.yan@arm.com>
In-Reply-To: <CAHk-=wjT_zSfzFVMyhv=Y4c94o2GDed253dV=TLyBbSuPdGzLw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

On 7/6/2024 8:55 PM, Linus Torvalds wrote:

[...]

> I'm sure there's tons of other things going on in between the system
> calls, but I have no idea what. Doing ltrace() shows it doing an
> endless stream of "strcmp()", and attaching to it with gdb says that
> it's in
> 
> #14 0x0000fffebf319d08 in qsort_r () from /lib64/libc.so.6
> #15 0x0000000000534720 in comm_strs.findnew.part ()
> #16 0x0000000000534844 in comm.new ()
> #17 0x0000000000534e14 in thread.new ()
> #18 0x0000000000536234 in threads.findnew ()
> #19 0x000000000052092c in __machine__findnew_thread ()
> #20 0x0000000000524404 in machine.process_fork_event ()
> #21 0x000000000052da44 in perf_session.deliver_event ()
> #22 0x0000000000532750 in __ordered_events__flush ()
> #23 0x000000000052c98c in perf_session.process_user_event ()
> #24 0x000000000052dff8 in reader.read_event ()
> #25 0x000000000052f784 in perf_session.process_events ()
> #26 0x0000000000422470 in record.finish_output.constprop ()
> #27 0x00000000004256b8 in __cmd_record.constprop.0 ()
> #28 0x0000000000427b54 in cmd_record ()
> #29 0x00000000004c492c in run_builtin ()
> #30 0x00000000004c4c10 in handle_internal_command ()

I did a quick testing at my side on x86_64 machine (56 cores) with latest perf
and did not see long duration for perf record - though I cannot ensure the
perf tool has no issue.

Given the '-a' option (system wide tracing) is used in the perf command, it is
good to firstly rule out if anything is wild in system. In your second email,
the sample amount (40467904 samples) is huge. If you still keep the perf data
file, could you do a statistics for the perf events?

  perf script -D | grep PERF_RECORD | awk '{print $5 " " $6}' \
     | sort | uniq -c | sort -nr | head -50

I expect the statistics will give hints. If any event other than the
PERF_RECORD_SAMPLE event happened for huge times, it will be something we
should look into.

Thanks,
Leo
