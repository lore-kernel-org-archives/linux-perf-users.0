Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECE314A618
	for <linux-perf-users@vger.kernel.org>; Thu, 11 Apr 2024 12:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837733; cv=none; b=mFkbiQ9YPR/5KyyUU6R2mfqZuums14SV8qhU/offS+avZDawPrPISXqm5rYB8ziUkcCxsPOGinPIiRlt2Z77kt8RdvyFmlkELPp6ucIX1F4ajsJ+m2UYZwcOIKlTGvkJ3ZUOIxOu09oyE1wC2XY1le2cQbeuGk+gaex17HtwxQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837733; c=relaxed/simple;
	bh=J9RiViyYGezwDVJFh9GiCk6gdsW+555gdGdzL6+E3mE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYnFOOkfgG+6nZRbMf1Aq1G1BD+Z9lHcQEIGOp77zPx93HW4njdHAKrzE2L3vRvMKVxAgp4/CbtoyfHk5jRK0fY6F4IH4MLE14RmTkdpAv2PZbTI3MHqEr+Qw9myplG7LJ/yLBcGE+Z8h5YUMuVhwSypIGf9WmUeO0rXB2oOwpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78535113E;
	Thu, 11 Apr 2024 05:15:59 -0700 (PDT)
Received: from [10.163.57.160] (unknown [10.163.57.160])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 806853F64C;
	Thu, 11 Apr 2024 05:15:28 -0700 (PDT)
Message-ID: <40b33222-45cc-4aea-9e08-1813b2268db9@arm.com>
Date: Thu, 11 Apr 2024 17:45:25 +0530
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/8] tools lib: adopt str_has_suffix() from
 bpftool/gen.c
Content-Language: en-US
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com,
 james.clark@arm.com
References: <20240408062230.1949882-1-ChaitanyaS.Prakash@arm.com>
 <20240408062230.1949882-2-ChaitanyaS.Prakash@arm.com>
 <20240409083209.f56351bcc8726439324a8d72@kernel.org>
From: Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
In-Reply-To: <20240409083209.f56351bcc8726439324a8d72@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 4/9/24 05:02, Masami Hiramatsu (Google) wrote:
> On Mon,  8 Apr 2024 11:52:23 +0530
> Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com> wrote:
>
>> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>>
>> Adopt the definition of str_has_suffix() from tools/bpf/bpftool/gen.c
>> and add it to tools/lib/string.c The function is modified to return
>> strlen(suffix) on success and 0 on failure.
>>
>> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>> ---
>>   tools/include/linux/string.h |  2 ++
>>   tools/lib/string.c           | 26 ++++++++++++++++++++++++++
>>   2 files changed, 28 insertions(+)
>>
>> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
>> index db5c99318c79..e43c8f78d63c 100644
>> --- a/tools/include/linux/string.h
>> +++ b/tools/include/linux/string.h
>> @@ -42,6 +42,8 @@ static inline bool strstarts(const char *str, const char *prefix)
>>   	return strncmp(str, prefix, strlen(prefix)) == 0;
>>   }
>>   
>> +size_t str_has_suffix(const char *str, const char *suffix);
>> +
>>   extern char * __must_check skip_spaces(const char *);
>>   
>>   extern char *strim(char *);
>> diff --git a/tools/lib/string.c b/tools/lib/string.c
>> index 8b6892f959ab..9cb515048239 100644
>> --- a/tools/lib/string.c
>> +++ b/tools/lib/string.c
>> @@ -226,3 +226,29 @@ void *memchr_inv(const void *start, int c, size_t bytes)
>>   
>>   	return check_bytes8(start, value, bytes % 8);
>>   }
>> +
>> +/**
>> + * str_has_suffix - Test is a string has a given suffix
>> + * @str: The string to be tested
>> + * @suffix: The string to see if @str ends with
>> + *
>> + * Returns:
>> + * * strlen(@suffix) if @str ends with @suffix
>> + * * 0 if @str does not end with @suffix
> I think this should return boolean, because user will never check the
> return value is strlen(@suffix). (and user always use the return value
> as a boolean)
>
> Thank you,

This is in accordance with Arnaldo's comments on V1 of the patch series.
Please find the link for the same below.

https://lore.kernel.org/all/ZdYPf3wMl35VemsL@x1/

>> + */
>> +size_t str_has_suffix(const char *str, const char *suffix)
>> +{
>> +	size_t i;
>> +	size_t str_len = strlen(str);
>> +	size_t suffix_len = strlen(suffix);
>> +
>> +	if (str_len < suffix_len)
>> +		return 0;
>> +
>> +	for (i = 0; i < suffix_len ; i++) {
>> +		if (str[str_len  - i - 1] != suffix[suffix_len - i - 1])
>> +			return 0;
>> +	}
>> +
>> +	return suffix_len;
>> +}
>> -- 
>> 2.30.2
>>
>>
>
