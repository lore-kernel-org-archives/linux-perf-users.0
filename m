Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D667F7E2
	for <linux-perf-users@vger.kernel.org>; Tue, 23 Jan 2024 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706028014; cv=none; b=fQcBKsN/qurR8+8LUB5W/wCwoMv8r8KIN9GqsJ1UqT8HGXLDUyL4UgoZ2tWbPdoCuowfo7C4tdvoc9pqu9r+nIbUYRQPt1Osa2HzItsVRf0JIwI66+ZjEVbLLxg3Y8MDyiKnek6F0r6NFQSncuHNtjK7JInQFsl3t14I3SsnM6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706028014; c=relaxed/simple;
	bh=i2G/fL0Dfpxv/B/WuNUE14Slgs+4DSXgREwz8oOax00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ayKoPtvW+NqVJR9lktl2jJ3N62oRbF6Lzh/hq6yjdCNGX+igTyS3CfafYny0eWU4hQ0glFH4UMi28TPtW+WaPqatzS21j4i33ZtUqJ9Fp4ERSNLCJB471pCpRoiyDM5YlsLbq1OCr+g44pWQA29ytoUxNOxeOtYFFzdjkqwtaCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5E321FB;
	Tue, 23 Jan 2024 08:40:57 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B6B43F5A1;
	Tue, 23 Jan 2024 08:40:11 -0800 (PST)
Message-ID: <c395aa13-c658-a807-bcb4-a6b31401ef4f@arm.com>
Date: Tue, 23 Jan 2024 16:40:12 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Issues with Linux perf tool on Raspberry Pi 5
Content-Language: en-US
To: Ian Rogers <irogers@google.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>,
 ChaitanyaS.Prakash@arm.com
References: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
 <fdeec5b3-693c-61ce-e8b0-94ff72188317@arm.com>
 <CAP-5=fXuduT--u5WThgi5RO1d8G5DuAUfn_AVjWTr6=VtZAUWQ@mail.gmail.com>
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fXuduT--u5WThgi5RO1d8G5DuAUfn_AVjWTr6=VtZAUWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 22/01/2024 22:39, Ian Rogers wrote:
> On Mon, Jan 22, 2024 at 1:59 AM James Clark <james.clark@arm.com> wrote:
>>
>> On 19/01/2024 23:39, Ian Rogers wrote:
>>> Hi,
>>>
>>> I thought I'd report the state of Linux perf tests on Raspberry Pi 5
>>> and so I opened a bug because of the number of failures. I'm happy for
>>> help resolving the issues. The bug is:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=218401
>>>
>>> Thanks,
>>> Ian
>>>
>>
>> Hi Ian,
>>
>> For "test perf probe of function from different CU", Chaitanya has a fix
>> that she should be sending soon. I already planned to look at "Check
>> Arm64 callgraphs are complete in fp mode" as I see that failing here so
>> it's not related to Rpi5.
>>

I see that "test dwarf unwind" is completely missing in your output, not
even skipped. This suggests that libdwarf isn't linked in:

#ifdef HAVE_DWARF_UNWIND_SUPPORT
	&suite__dwarf_unwind,
#endif

"Check Arm64 callgraphs are complete in fp mode" relies on a Dwarf
unwinder so I sent a patch to skip this test if one isn't linked in.


