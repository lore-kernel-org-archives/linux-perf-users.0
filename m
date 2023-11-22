Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B746D45;
	Tue, 21 Nov 2023 17:02:12 -0800 (PST)
Received: from kwepemm000003.china.huawei.com (unknown [172.30.72.56])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SZjXL2q7qzRjYV;
	Wed, 22 Nov 2023 08:57:54 +0800 (CST)
Received: from [10.67.111.205] (10.67.111.205) by
 kwepemm000003.china.huawei.com (7.193.23.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 22 Nov 2023 09:02:09 +0800
Subject: Re: [PATCH 3/3] perf bench sched-seccomp-notify: Fix __NR_seccomp
 undeclared build error on i386
To: Namhyung Kim <namhyung@kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>, <irogers@google.com>, <adrian.hunter@intel.com>,
	<avagin@google.com>, <daniel.diaz@linaro.org>,
	<linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231118024858.1567039-1-yangjihong1@huawei.com>
 <20231118024858.1567039-4-yangjihong1@huawei.com>
 <CAM9d7ciAcjjncBEbA0zAoyThQUwJbeNHXuTX9mEWzUcS4FbLew@mail.gmail.com>
From: Yang Jihong <yangjihong1@huawei.com>
Message-ID: <1ca5d8ed-c0ad-af21-fc84-eb64b02dc20f@huawei.com>
Date: Wed, 22 Nov 2023 09:02:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAM9d7ciAcjjncBEbA0zAoyThQUwJbeNHXuTX9mEWzUcS4FbLew@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000003.china.huawei.com (7.193.23.66)
X-CFilter-Loop: Reflected

Hello,

On 2023/11/22 2:57, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Nov 17, 2023 at 6:51 PM Yang Jihong <yangjihong1@huawei.com> wrote:
>>
>> Fix a build error on i386 system:
>>
>> bench/sched-seccomp-notify.c: In function 'seccomp':
>> bench/sched-seccomp-notify.c:46:17: error: '__NR_seccomp' undeclared (first use in this function); did you mean 'seccomp'?
>>    return syscall(__NR_seccomp, op, flags, args);
>>                   ^~~~~~~~~~~~
>>                   seccomp
>> bench/sched-seccomp-notify.c:46:17: note: each undeclared identifier is reported only once for each function it appears in
>> bench/sched-seccomp-notify.c:47:1: error: control reaches end of non-void function [-Werror=return-type]
>>   }
>>   ^
>> cc1: all warnings being treated as errors
>>
>> Fixes: 7d5cb68af638 ("perf/benchmark: add a new benchmark for seccom_unotify")
>> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> This is already fixed by:
>    https://lore.kernel.org/all/20231017083019.31733-1-jirislaby@kernel.org/
> 

I didn't notice this patch... okay, please ignore it.

Thanks,
Yang
