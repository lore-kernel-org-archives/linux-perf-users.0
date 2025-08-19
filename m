Received: from out198-22.us.a.mail.aliyun.com (out198-22.us.a.mail.aliyun.com [47.90.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476C7353349;
	Wed, 20 Aug 2025 03:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755660369; cv=none; b=raoW4NmyJ+5ZLrZ3IctFaMsoOLuQbyJme73PDeBD3pQ7l66R5/aQEuM9/P393cmSaTeunHRDnN6bIf7ojeSFiTozwc9kWKmZoK6Xe7IPS3gTR9rHky7mLBMZqLT+kOrcMsEsKMDBSZBOigE9ROvW+/KrIMn45m4kuTlXZGwhKPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755660369; c=relaxed/simple;
	bh=FF5mNWnc8QirEA07hOdzn02EtD0ltqNBcOMxKO4o4sk=;
	h=Date:Subject:From:To:CC:Message-ID:References:In-Reply-To:
	 Mime-version:Content-type; b=g/kQ2C5vEmdZ8UIp/NXz7AMID3cpGhgU7xQByJqo1DsvzUyTQyu+jA3pjECtIHFcEFM6M3cEXhqXutUkQjDDM3IexdKNNJtBsgS4rg5Mjwt0NiViBtt08y5F0MbiFlUWD8OLicBJmCleU9atWthjcDDH5F6Z2/kBM/rZRC/EJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=optimatist.com; spf=pass smtp.mailfrom=optimatist.com; arc=none smtp.client-ip=47.90.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=optimatist.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=optimatist.com
Received: from 192.168.0.107(mailfrom:chengdongli@optimatist.com fp:SMTPD_---.eKXugmB_1755660350 cluster:ay29)
          by smtp.aliyun-inc.com;
          Wed, 20 Aug 2025 11:25:51 +0800
User-Agent: Microsoft-MacOutlook/16.99.25072714
Date: Tue, 19 Aug 2025 21:31:46 +0800
Subject: Re: [PATCH] perf/core: Improve arguments checking of inherited
 per-task counters when sampling.
From: "Chengdong Li(=?UTF-8?B?5p2O5oiQ5qCL?=)" <chengdongli@optimatist.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: <peterz@infradead.org>,
	<mingo@redhat.com>,
	<acme@kernel.org>,
	<namhyung@kernel.org>,
	<alexander.shishkin@linux.intel.com>,
	<jolsa@kernel.org>,
	<irogers@google.com>,
	<adrian.hunter@intel.com>,
	<kan.liang@linux.intel.com>,
	<linux-perf-users@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Message-ID: <D1D50EA0-EFC3-4FAB-A898-A61BD081B527@optimatist.com>
Thread-Topic: [PATCH] perf/core: Improve arguments checking of inherited
 per-task counters when sampling.
References: <20250814110625.84622-1-chengdongli@optimatist.com>
 <aKRRSsEJxb1LZDV1@J2N7QTR9R3>
In-Reply-To: <aKRRSsEJxb1LZDV1@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
Mime-version: 1.0
Content-type: text/plain;
	charset="UTF-8"
Content-transfer-encoding: 7bit

Hi Mark,

On 2025/8/19, 18:26, "Mark Rutland" <mark.rutland@arm.com <mailto:mark.rutland@arm.com>> wrote:


>On Thu, Aug 14, 2025 at 07:06:25PM +0800, Chengdong Li wrote:
>> It's not allowed to mmap() of inherited per-task counters with CPU ==
>> -1, this would create a performance issue. But it is not friendly to
>> developers as current implementation postponed the arguments checking to
>> perf_mmap(), developer can get an -EINVAL from mmap() but without
>> any previous error returned from perf_event_open().
>>
>> This patch improves it by moving the arguments checking from perf_mmap()
>> to perf_event_open().
>
>
>Why is that an improvement?
>
>
>IIUC before this patch, it would be possible to read() the event,
>whereas now the event cannot be opened at all.

That's true, could you provide a use case that using sampling mode but without
ring buffer? From my best knowledge, I think counting mode is more suitable
for read() only.

>
>
>AFAICT this is removing functionality people could legitimately use, so
>this doesn't seem like an improvement.

The problem is that using inherit per-task counter with sampling mode would lead
developer hard to debug why mmap() returns -EINVAL. There is not error returned from
perf_event_open(), everything done seems right but failed at mmap(), and there is
no clue in man open_event_open() as well.

Thanks,
Chengdong

>
>
>Mark.
>
>
>>
>> Signed-off-by: Chengdong Li <chengdongli@optimatist.com <mailto:chengdongli@optimatist.com>>
>> ---
>> kernel/events/core.c | 20 ++++++++++++--------
>> 1 file changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 8060c2857bb2..f102adb395ec 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -6941,14 +6941,6 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
>> int ret, flags = 0;
>> mapped_f mapped;
>>
>> - /*
>> - * Don't allow mmap() of inherited per-task counters. This would
>> - * create a performance issue due to all children writing to the
>> - * same rb.
>> - */
>> - if (event->cpu == -1 && event->attr.inherit)
>> - return -EINVAL;
>> -
>> if (!(vma->vm_flags & VM_SHARED))
>> return -EINVAL;
>>
>> @@ -13392,6 +13384,18 @@ SYSCALL_DEFINE5(perf_event_open,
>> return -EACCES;
>> }
>>
>> + /*
>> + * Don't allow perf_event_open() of inherited per-task counters
>> + * with cpu == 1 when sampling. Otherwise, this would create a
>> + * performance issue due to all children writing to the same mmap()
>> + * created ring buffer.
>> + *
>> + * We recommend to call perf_event_open() for all cpus when sampling on
>> + * inherited per-task counters.
>> + */
>> + if (attr.sample_freq && attr.inherit && cpu == -1)
>> + return -EINVAL;
>> +
>> if (attr.freq) {
>> if (attr.sample_freq > sysctl_perf_event_sample_rate)
>> return -EINVAL;
>> --
>> 2.43.0
>>


