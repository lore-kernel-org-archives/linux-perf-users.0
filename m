Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6E314D712
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Jun 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719319259; cv=none; b=J/vU6xPDgZc2XCCNXw/F1wW8/VGJrkL2aX0d74ESBPhpHFtL2iiV0p46PJ5xURalR9zvZKYGTwDPn518lhx1dqqSHkakPwZjhHSeR2wLz8AqhDulV4guT3RYnK4Z4bsuiH03jBrPUPEh/iRZkF9rxKpuGtrbwzFXGOaQ8O27By4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719319259; c=relaxed/simple;
	bh=y4DfyU8CjQk1dcMFWliU7yzkdSz94jlrVm5FXAG9ZZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auzrlm14GiI9gR3mMg2qmXjHvuvicy55FSO/dz8h0FsjoSKnVUohmx3k784x+NWF4i5gcBkoubPDgo+bLhip/m0O6jw7npi9E3Iv8/+kUZ3TpEiyXJBKD9mSmlgHE7H6X4COJI/B87qqdi+1h9QiQ9FVGLW6gu4Fgf3Vf3pAKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B20D339;
	Tue, 25 Jun 2024 05:41:21 -0700 (PDT)
Received: from [192.168.1.100] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 35A8E3F766;
	Tue, 25 Jun 2024 05:40:56 -0700 (PDT)
Message-ID: <0b0fc9b5-9e64-49c1-8631-74aa79fcf01b@arm.com>
Date: Tue, 25 Jun 2024 13:40:57 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 10/10] perf test: Check output of the probe ... --funcs
 command
To: Namhyung Kim <namhyung@kernel.org>,
 Chaitanya S Prakash <ChaitanyaS.Prakash@arm.com>
Cc: linux-perf-users@vger.kernel.org, anshuman.khandual@arm.com
References: <20240601125946.1741414-1-ChaitanyaS.Prakash@arm.com>
 <20240601125946.1741414-11-ChaitanyaS.Prakash@arm.com>
 <ZnoBpxbuZ1shXBR7@google.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <ZnoBpxbuZ1shXBR7@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 25/06/2024 00:30, Namhyung Kim wrote:
> On Sat, Jun 01, 2024 at 06:29:46PM +0530, Chaitanya S Prakash wrote:
>> From: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>>
>> Test "perf probe of function from different CU" only checks if the perf
>> command has failed and doesn't test the --funcs output. In the issue
>> reported in the previous commit, the garbage output of the --funcs
>> command was being ignored by the test when it could have been caught.
>>
>> The script first makes use of --funcs option with the perf probe command
>> to check if the function "foo" exists in the testfile before adding a
>> probe to it in the next command. The output of probe...--funcs command
>> is redirected to stdout, therefore, add '| grep "foo"' to validate the
>> result.
> 
> Ok, I think this can be applied separately.
> 

Yeah I think it can. There was a question from Arnaldo about this one on
a previous version, but Chaitanya clarified about the stderr vs stdout
thing:

https://lore.kernel.org/linux-perf-users/7d6330bd-5b0a-49d2-83bf-ac1ca11996d0@arm.com/#t

> Thanks,
> Namhyung
> 
>>
>> Signed-off-by: Chaitanya S Prakash <chaitanyas.prakash@arm.com>
>> ---
>>  tools/perf/tests/shell/test_uprobe_from_different_cu.sh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
>> index 319f36ebb9a4..82bc774a078a 100755
>> --- a/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
>> +++ b/tools/perf/tests/shell/test_uprobe_from_different_cu.sh
>> @@ -77,7 +77,7 @@ gcc -g -Og -flto -c ${temp_dir}/testfile-foo.c -o ${temp_dir}/testfile-foo.o
>>  gcc -g -Og -c ${temp_dir}/testfile-main.c -o ${temp_dir}/testfile-main.o
>>  gcc -g -Og -o ${temp_dir}/testfile ${temp_dir}/testfile-foo.o ${temp_dir}/testfile-main.o
>>  
>> -perf probe -x ${temp_dir}/testfile --funcs foo
>> +perf probe -x ${temp_dir}/testfile --funcs foo | grep "foo"
>>  perf probe -x ${temp_dir}/testfile foo
>>  
>>  cleanup
>> -- 
>> 2.34.1
>>
