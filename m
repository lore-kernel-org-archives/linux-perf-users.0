Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0D322F1C
	for <linux-perf-users@vger.kernel.org>; Tue,  5 Nov 2024 02:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730772408; cv=none; b=AsQIJE9ALwMbKsmIZw/ydTY9hRzBXvaVAmEhCv6g2rbPmFZFDNQ7dPieT7iDqJVuY6U6JvR1M53gSVzIG0KUIvYkT6LqFkWLOBqFEEssibUhDLHku2EniOc+BWA7SbMcecAnIcvPurBBkRN3/T0ik+kCaxBFngrYPb0meBQupCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730772408; c=relaxed/simple;
	bh=W3Yzy9X0vFDuxGWrw2cdGJBtpshunwvFJbMXaGPCHO4=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=I8y3TRIe0qmaA/5Fit4pJ2w8FqWh4IpuC7ae1/HxaplWxX2UO5B8CCxjcjgrTr9JC8jtlZzzJuV2dFB57KpTZuyy8O7dv5X9YrXgxfFil+loKrP5dwoCo5kafXV5+bBmeeHhaeiOF1z4/8m1B0MxXHEtYZ90l40mGTX2pVX+VEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XjBVK2ndGzpY33;
	Tue,  5 Nov 2024 10:04:41 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id C6D3814022D;
	Tue,  5 Nov 2024 10:06:35 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 5 Nov 2024 10:06:35 +0800
CC: <yangyicong@hisilicon.com>, <acme@kernel.org>, <peterz@infradead.org>,
	<mingo@redhat.com>, <linux-perf-users@vger.kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <linuxarm@huawei.com>, Guilherme
 Amadio <amadio@gentoo.org>, Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH] perf build: Add missing cflags when building with custom
 libtraceevent
To: Namhyung Kim <namhyung@kernel.org>
References: <20241024133236.31016-1-yangyicong@huawei.com>
 <ZyF5_Hf1iL01kldE@google.com>
 <a8143fa2-d7e2-48d7-5c9b-2c00e2adbe9c@huawei.com>
 <20241030110458.GD24446@e132581.arm.com> <ZyXFX-8SnakeuZrl@google.com>
 <20241104104741.GA14610@e132581.arm.com> <ZyjDatxYxoIg0R5J@gentoo.org>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <260274f8-3188-cc77-4783-ee04d98eeb44@huawei.com>
Date: Tue, 5 Nov 2024 10:06:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZyjDatxYxoIg0R5J@gentoo.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemd200014.china.huawei.com (7.221.188.8)

On 2024/11/4 20:51, Guilherme Amadio wrote:
> Hi Namhyung,
> 
> On Mon, Nov 04, 2024 at 10:47:41AM +0000, Leo Yan wrote:
>> On Fri, Nov 01, 2024 at 11:23:27PM -0700, Namhyung Kim wrote:
>>
>> [...]
>>
>>>>> Checked how we handle with libtracefs currently:
>>>>>  ifeq ($(feature-libtracefs), 1)
>>>>>     CFLAGS +=  $(shell $(PKG_CONFIG) --cflags libtracefs) # we've added the cflags from pkg-config
>>>>>     LDFLAGS += $(shell $(PKG_CONFIG) --libs-only-L libtracefs)
>>>>
>>>> The libtracefs.pc file claims requesting libtraceevent, as a result, it
>>>> returns the header paths for both libtraceevent and libtracefs:
>>>>
>>>>   $ pkg-config --cflags libtracefs
>>>>   -I/usr/local/include/tracefs -I/usr/local/include/traceevent
>>>>
>>>> I checked the packages libtraceevent-dev and libtracefs-dev and either
>>>> can be installed independently. Therefore, it seems to me that this
>>>> patch is correct for finding the traceevent header path, with no
>>>> dependency on tracefs.
>>>
>>> I'm ok with the patch itself.  Can I get your Acked-by, Leo?
>>
>> Yes.
>>
>> Reviewed-by: Leo Yan <leo.yan@arm.com>
> 
> I agree that this was a mistake I made in my patch. I added the cflags
> to the feature check in tools/build/Makefile.feature, but in Makefile.config
> I added it only for libtracefs and missed it for libtraceevent. The fixes tag
> is correct. This patch fixes my mistake.
> 
> Reviewed-by: Guilherme Amadio <amadio@gentoo.org>
> 

Thanks for the review by Leo and Guilherme!

Hi Namhyung,

As you noticed we should use the include path from pkg-config [1]. Would you like
to post a patch yourself or want me to post this as well? It's correct and we also
need this. (I didn't found this may because I changed my custom libtraceevent.pc when
debugging and currently approach is ok if libtraceevent's installed system wide).

[1] https://lore.kernel.org/linux-perf-users/ZyF5_Hf1iL01kldE@google.com/

Thanks.

