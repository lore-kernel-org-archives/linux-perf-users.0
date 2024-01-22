Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB95E3A1A1
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jan 2024 09:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705917592; cv=none; b=I1btS+f8Y6s9/zCF76JjEkgqph340uH5pcsfLclKnK1z2Cs7FYGM/r5BmWIgl3qSc7SHOS54vs5QHS4Eh9O7ld1WdLFZvSLELTinNrFwLG1IY9tqhk0w3LOhFe9rH9TM58C0JbqXwPKCiI44DnkV6KaiKJGnKjWi3OGPrwc6i0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705917592; c=relaxed/simple;
	bh=ONXQ1npX869Rt4V5Pi121fyqvKBG/+2Bw49tl5QdZ/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=unR0gQVxSXZ8rOVwuGkj2qGFCrVrTYKttb7ogbxESc0GDvDo3DDt3Vihg6XzjBuWmR3V59A3fk4oTuCppdWrQLFjIpI+30l3uLOWJtobmLkU9L96tAkjktD9xeFBsuLzP4xZbBeG42vjCCMezS+EziFYwIigzTIPxRpNm0ewmL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73C292F4;
	Mon, 22 Jan 2024 02:00:29 -0800 (PST)
Received: from [192.168.1.100] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 086153F5A1;
	Mon, 22 Jan 2024 01:59:42 -0800 (PST)
Message-ID: <fdeec5b3-693c-61ce-e8b0-94ff72188317@arm.com>
Date: Mon, 22 Jan 2024 09:59:43 +0000
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Issues with Linux perf tool on Raspberry Pi 5
To: Ian Rogers <irogers@google.com>,
 linux-perf-users <linux-perf-users@vger.kernel.org>,
 ChaitanyaS.Prakash@arm.com
References: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
Content-Language: en-US
From: James Clark <james.clark@arm.com>
In-Reply-To: <CAP-5=fUMrS+fiewxm3y4j=z4GucBVbOyDGcXNg8uDF3K+yPZ2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/01/2024 23:39, Ian Rogers wrote:
> Hi,
> 
> I thought I'd report the state of Linux perf tests on Raspberry Pi 5
> and so I opened a bug because of the number of failures. I'm happy for
> help resolving the issues. The bug is:
> https://bugzilla.kernel.org/show_bug.cgi?id=218401
> 
> Thanks,
> Ian
> 

Hi Ian,

For "test perf probe of function from different CU", Chaitanya has a fix
that she should be sending soon. I already planned to look at "Check
Arm64 callgraphs are complete in fp mode" as I see that failing here so
it's not related to Rpi5.

The others as you mentioned do look to be config related. IMO that's
usually the issue, or it's a build issue where Perf is missing a dependency.

Although those should be a skip so technically there are still bugs.

Thanks
James
