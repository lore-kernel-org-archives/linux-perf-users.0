Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793275249;
	b=DFNKgB/2Y6FxwyBaj+MUkehNiDh3cHqMevXMUg2IOvycI+4Kv3S4pHEiuPx8tuWXp4dK
	 U/J+qmDnITA8LfQxeKVnHrofAEyv3W4Z2FR8v6SJacP9bWERfN+G4q6/+Ek0Nkd2C7QW0
	 GsVGvVFZDK+tS++SIHiV8P0gRwT858U0FRRCs1xPhuuq1wxcvCe4Sj9tAJBbRgcfee3Bq
	 2bDYhAEpfR2yFz0N2gy56oPJDn7uHbUuXhBwrcFA/vsyReeNDNxEYaU9HtgOvNaiFAo6K
	 XsLxQ1Ho5+x4ephR0mvbRBF+ntu9uzLDfs3ATDK602l0GXgVEWcuHL8lk+hOEIzRCgg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793275249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Mime-Version:X-Original-From:User-Agent:From:In-Reply-To:
	 References:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=Kfh6T58QwTFlNX2tJxJJ8wG1iXiSG5Qq4FI151fPHEk=;
	b=I4jcV2YGetHpUmZ73z3vCQK67m4Sy5XoQIvWiAMLxNB/bkDCOvJNBiHCXrC5YopGs8t2
	 ZI8dN7QFDNP5IneKdRaK+IjLoPoH2MMTlb+X+NUPM3Xm5KpwUfxe6KnheBnyDf5h1ExvA
	 B+4XYYDKDa7FWzrGchBiq9PTW6PWFq+AEVEMXd7j1Fwsp4IJzPmRTpyXZOWUHhbM8LK+y
	 BMDMmyTZGNeMsyn8GYVJYSwVREeL3ACv8JIkfHcmvbdwHOD8906wY267ZhPpcHCAOLlFN
	 sVkYFsjv/g+ZWjGaH3fK+0foOHIdRNKPdPD1T4M2RmQ9CnyVFAQ+11xSbJ3KW+08iTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DPz8UE+T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.53
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A695606A31E
	for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 12:00:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A695606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=DPz8UE+T
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5be4b61fd3dso1681391e87.3
        for <linux-perf-users@vger.kernel.org>; Thu, 29 Oct 2026 05:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793275246; cv=none;
        d=google.com; s=arc-20260327;
        b=DTPZtwC+OMLfNAKsKzYT5JmQNFL4165c41Nt/XXyJivtNWL2yDnfVTwkJH5sIpeFsS
         38NqSR74IFm0P5j6Dt8rMOR7HN7tePKdR/Tx/drapttT+yxJo8zUungKko8Scd0Wpuzw
         3jb4QtkNH/gtm/WcrAB9cYcIgumawc5RjAc6L3E2A8ZS/xQOeHG09+ltmFvNfnQtKA+F
         c5+w0uCaE1u7MvdsV4Giv/wzoeA1fLVq6Yu0WGFEVQihsk4+Ou+g18YzGWj0HnsCwCGx
         OLjwliRxd/T3tQdf0s0YmzMAisyqRQ09CmnvQB2vEQCFtC92nns2N/KipMUEYaHaWtDl
         9kmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:user-agent:mime-version:dkim-signature;
        bh=Kfh6T58QwTFlNX2tJxJJ8wG1iXiSG5Qq4FI151fPHEk=;
        fh=9TazwZoAt5A3HnS5xc/FSXtn8V7NiObEF5TkIC0pPQs=;
        b=VxOAwKIXc99GwbT54sWsARpcYrOA/yucCbiyKI+RF3Ukz6sk0ez4JNgcUQKuGZENUK
         AR5oPXhwsbhSQUdFJvus7ROcS1pBowE4GcJTRTyvgZZpWqft97gw+JjWwKkIlQ/qaPAc
         J2CqgQoy5zbZAXpjGH2L+iR1gCMeEhur05TSTZ1i9QkmgAMYLXO9xP408uLkr2PznHJg
         ejuvc5qlld0I/SoL0RMsEMaEUYtSWSldU0NxzOq3leowaX9pho+aOIrtHxTqesIjR7uJ
         +JrvfOCjyWCCtmhiXMOW7cjZFUOfoBONFVHPeR4cnf1hP1ft+p8LALz01paGTJwC7g7N
         1hFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1793275246; x=1793880046; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:user-agent:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Kfh6T58QwTFlNX2tJxJJ8wG1iXiSG5Qq4FI151fPHEk=;
        b=DPz8UE+Tyq/cYPEl4w9kY6RF8oUPSIePH2cHsTWTsyIww8cgzD+L4D6RUw7K7cWW8o
         5bT6/92MEzA94ZSo9BosrD4q/8jYMsNjrBbEJbcait+RXDxiIjBHhTsmvsq8563TjuoW
         v1ABBvVvDyu9Gu32MGKQvkCCIy5rvYW/syrlIQuko6y/kiNEMf+iNoL28ME+J/WphOGq
         yZbm9hNqjWElPQXS2RMtV9pPlxKbl14jwd/SAR7ig0ALG3rhefYwqE+XXPLp9xRw6ZJO
         S20d4XV4bJLSlIKAqfLFe9CMRHcOH7RmLI/OjGvEGB8AqZUUPG9kp+rQGEEtoQPZGtlR
         IMkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793275246; x=1793880046;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:user-agent:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Kfh6T58QwTFlNX2tJxJJ8wG1iXiSG5Qq4FI151fPHEk=;
        b=c60Z80U33ZW+443jCACOK/QuenSCUDzQzMjT6dj0UhSMpuKYV5lnZtRvPQnWiZLUK3
         j0vnKSpEuJI4rEWEouj9rgEuddWzBH3XXH/4G+BoqRaQ/JWLYo7a9Zh7HQOkxTa7BF3s
         fL9chL3oDzCB8PeM4hmzIKlr6siJD9mOzlR69aaETHYgfZfavj+kuYknk5luMO4XjVGn
         N/7nM1Ycj7wsixvT96GxOJbOfk48m4zDlqSM/8H5tKKugrdMijd3ttzBmm1cvEFfX4h6
         VdrWwRx399piYKU8N0U3Dhlvuz+hMfBGXQ12liwD2GnLtHJ/hvTfX1sL+L397iUI2VfX
         U7Xg==
X-Forwarded-Encrypted: i=1; AKwUvBwGUgY4V5bAERbxZ0kwwa7Bt10STn9Nq8F8jq5y/sS7R7UeN9yQIuz5EZmNzzNJbq7PI/heCNwog9y3JkH/E+8r@vger.kernel.org
X-Gm-Message-State: AFq9FYIJh5gImmBCPwCAIeNGMOLUq7RaVZmbZYthZMQnghP3Rzt3h2CA
	DTV06Spkeo0vLOVazf2fL/kKlKkxeiFAlD5SKnpj3Q8Qof0tnANcyTmui2ZZYI+la5lnQB9Lsj4
	b5lFysbkoPl6B8lVoAWgTkZIKDQdxJMPR8uHpO7WU4Q==
X-Gm-Gg: AYBFou0JwZZj/lOepkjAl5cGAguc00N0tueqKVuj0FmLeNVYTH7+aIYf9Huh8yl4Obq
	vnf9W/8JRTtZrpzndcCYaIBaBxIhrLs9J4F17VQ3pfkfhXnxzzEPRSEKcWG1XCejKnjd6PBgTbr
	P0r/q5lF820bsHn5h8WUKInNI6Kus+JpfiRpOdq6QqpOaackFPV2z1IGegI74xpBXOCGfcinLUo
	UcJQAhTTHx6amYdheCMrtCdVcwcuOtYKshVaxSOZXK952gwaYi02OG8XHXaZ+mJfNOmSqfq7ueQ
	ik9lq5atxatEKmohsaEM/0GVeR7GZR/dgzSSGzoDBNiFiNGPlbsx3fn3sh90rMB5N8ClbBItKX/
	toKsoGm8wl/5nAItum10rqrsahMNpUv4opByIew==
X-Received: by 2002:a05:6512:340d:b0:5bf:d653:ff01 with SMTP id
 2adb3069b0e04-5bfd6540187mr229252e87.34.1793275246438; Thu, 29 Oct 2026
 05:00:46 -0700 (PDT)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 07:00:45 -0500
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 29 Oct 2026 07:00:45 -0500
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
User-Agent: Mozilla Thunderbird
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <auMyx7dAPbl_1I5_@hu-himchau-blr.qualcomm.com>
References: <20261029074853.35467-1-zhangzhanpeng.jasper@bytedance.com>
 <20261029074853.35467-4-zhangzhanpeng.jasper@bytedance.com> <auMyx7dAPbl_1I5_@hu-himchau-blr.qualcomm.com>
Date: Thu, 29 Oct 2026 07:00:45 -0500
X-Gm-Features: AclHuK_sbU548xic3ZPbWuif9uJX5ACTcms_1cHQ__pmhhaKq4RoduWrhke4WpA
Message-ID: <CACnXVnc0jFcNn0bmU5MSm81QTm6Ht+deSRED=91dViZnq1dNmQ@mail.gmail.com>
Subject: Re: [PATCH v12 03/11] riscv: sse: mask events during shutdown and kexec
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Conor Dooley <conor@kernel.org>, 
	Anup Patel <anup.patel@oss.qualcomm.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>, 
	Yunhui Cui <cuiyunhui@bytedance.com>, Atish Patra <atish.patra@linux.dev>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Will Deacon <will@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	Shuah Khan <shuah@kernel.org>, yuanzhu@bytedance.com, yang.yicong@picoheart.com, 
	yang.susheng@zte.com.cn, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Himanshu,

On 10/29/26 7:49 PM, Himanshu Chauhan wrote:
> On Thu, Oct 29, 2026 at 03:48:45PM +0800, Zhanpeng Zhang wrote:
>> SSE delivery is independent of normal S-mode interrupts. Firmware may al=
so
>> retain an event registration until Linux explicitly unregisters it. A ha=
rt
>> must therefore stop accepting SSE events before Linux stops servicing th=
e
>> registered handler.
>>
>> Mask SSE on the local hart before panic stop, CPU stop, restart, powerof=
f,
>> and crash shutdown paths. This prevents firmware from entering Linux-own=
ed
>> handler state after the corresponding CPU or kernel context is no longer
>> valid.
>>
>> A crash kernel cannot identify or take ownership of registrations
>> inherited from the crashed kernel. Reject a later normal kexec while suc=
h
>> SSE state may still exist, rather than transferring unknown firmware sta=
te
>> to another kernel.
>>
>> The restriction is deliberately based on firmware SSE availability, not
>> CONFIG_RISCV_SBI_SSE or registrations made by the crash kernel. Disablin=
g
>> SSE in the crash kernel does not establish that registrations left by th=
e
>> crashed kernel are absent. Consequently, normal kexec from a crash kerne=
l
>> is also rejected when firmware advertises SSE but no registrations were
>> actually left behind. This conservative restriction remains until a safe
>> way to establish or clear inherited firmware state is available.
>>
>> Link: https://lore.kernel.org/r/as7-3PbWDxygadnJ@hu-himchau-blr.qualcomm=
.com/
>> Reviewed-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
>> Signed-off-by: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
>> ---
>>   arch/riscv/kernel/machine_kexec.c | 11 +++++++++++
>>   arch/riscv/kernel/reset.c         | 18 ++++++++++++++++++
>>   arch/riscv/kernel/smp.c           | 17 +++++++++++++++++
>>   3 files changed, 46 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/machine_kexec.c b/arch/riscv/kernel/machi=
ne_kexec.c
>> index 738df176ff6..24e7affae70 100644
>> --- a/arch/riscv/kernel/machine_kexec.c
>> +++ b/arch/riscv/kernel/machine_kexec.c
>> @@ -14,10 +14,13 @@
>>   #include <asm/set_memory.h>	/* For set_memory_x() */
>>   #include <linux/compiler.h>	/* For unreachable() */
>>   #include <linux/cpu.h>		/* For cpu_down() */
>> +#include <linux/crash_dump.h>
>>   #include <linux/reboot.h>
>>   #include <linux/interrupt.h>
>>   #include <linux/irq.h>
>>
>> +#include <asm/sse.h>
>> +
>>   /*
>>    * machine_kexec_prepare - Initialize kexec
>>    *
>> @@ -36,6 +39,13 @@ machine_kexec_prepare(struct kimage *image)
>>   	unsigned int control_code_buffer_sz =3D 0;
>>   	int i =3D 0;
>>
>> +	/* A crash kernel cannot tear down registrations inherited from firmwa=
re. */
>> +	if (is_kdump_kernel() && image->type !=3D KEXEC_TYPE_CRASH &&
>> +	    riscv_sse_available()) {
>> +		pr_err("Normal kexec from a crash kernel is unsupported with SSE\n");
>> +		return -EOPNOTSUPP;
>
> I think I had pointed this out in v10 also. This rejects a normal kexec f=
rom any kdump kernel whenever firmware merely advertises SSE, regardless of=
 CONFIG_RISCV_SBI_SSE or whether anything is registered. Can you check if i=
ts breaking kexec() with SSE just being advertised?
>
> Regards
> Himanshu

Thanks for following up. Yes, the current check rejects that case based
on firmware advertising SSE alone. I noted this restriction in the
commit message, but it still needs to be narrowed.

With the merge window closing, I kept that change out of v12 and will
address it in a separate follow-up patch like we discussed.

Thanks,
Zhanpeng
