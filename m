Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA793BB9FD
	for <linux-perf-users@vger.kernel.org>; Mon,  6 Jul 2026 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783334576; cv=none; b=Vrtj7K605A4fHseE1s9gNWt9HDW77nlymk5AGoz6PReGEfYy3Px6IMo5cDSvO1Ko1HAz0NqHRIN4s9qW2dMd1ZJbhAY6Rx/hosgUj3tdzZ989vWpo2yUu85jf3gY70uqe1HLTwrj28H71EJOHzQIH0dxaehZRCGihMb0io/2NGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783334576; c=relaxed/simple;
	bh=7jGrrKhau039KGF+D/EhnXv4Eeo8yneBAlwyXwKMYVU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfJCQzmSrEci/fWgkdPbV8aw6Mz5g9lLJntiadXStZgHr5Xc1wktpwJ9HSCmNEIum9792Ahx5iuJTqXjtOfpDIHBfEeExxlkapUR5dlxGSmSTFJDc/1RpaL/FLwkknCLaxbcTEc98vcyg/LScURFRNvyXkMkZO8TD9FU37/RwUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+Tp0AMx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5mkAZTZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+Tp0AMx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5mkAZTZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783334574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCoz5Iovrxw6v/kl19PuthITHE4VsqmzpdZPCtUSOQE=;
	b=J+Tp0AMx6a8MtYJ1BVllD7d989FFICkbv+kjFcI8rffXQ3FXjYyFJ+s2L70gyuyVvOOBEy
	lhQQIqMVe0hF0XyWCG4rsXuADqwEwTkzKPaIDyrriic63M34Zp76LWTNVi1WjSf9WTewNQ
	wpOgOPJ7d86qSv+t9ylgC4ToZxzHm18=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-Yn8Pg2klNTORoEijYprVjQ-1; Mon, 06 Jul 2026 06:42:52 -0400
X-MC-Unique: Yn8Pg2klNTORoEijYprVjQ-1
X-Mimecast-MFC-AGG-ID: Yn8Pg2klNTORoEijYprVjQ_1783334571
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-47d81cf0c4cso673289f8f.2
        for <linux-perf-users@vger.kernel.org>; Mon, 06 Jul 2026 03:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783334571; x=1783939371; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCoz5Iovrxw6v/kl19PuthITHE4VsqmzpdZPCtUSOQE=;
        b=G5mkAZTZm2R8DBlbWa5xlu1veM/scctR62eUxr5rSR0tVoUH90JiOqppEbN0txWlYY
         BL3G8dC4OrHyGgGXZa2YF3BCNJxM/BYJMBUS24w8A+nWVXxfXLttd+sKHTTxIlYP+Jed
         eDS0VZJ1s10VO4Hasi8gkrr9FV1qCpq1DBPh/hezAv29qFgeFpKOOcKwe7xtstsCpr/s
         IGbCMKO1n4Sxl8dZrKO2W/rwxrMZX/iPeGgs5DKnmOC05jaYAbasbfXPxQjJ61BcNAvJ
         lrSHABqlt8Qq1wrhJz8Zui+FGYu7k0iK4sfByBIpTUWMyiiXjhkwie9DjJ8q5xemWXxr
         3f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783334571; x=1783939371;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qCoz5Iovrxw6v/kl19PuthITHE4VsqmzpdZPCtUSOQE=;
        b=iOfkVpLH8WUCzcJjcN6k3XWBFNOwsK6ukZ6VSIj4SmxWxatvUrI8qPbTA9Ud0WJeCf
         7BI4pNs8+OLU82o+8gcg9uPP1a9V7czZIyo+5/HrU6HL//wX/pNzdp2MTUoavjBJEpFM
         874Xulxyv1PY19UCVG5OSY2oG9ClTWJKiEBybpsv3yJjXHjiMP5zL5p3VFVA2B9kRsIK
         APeEZFNGz3J8GdUU5wWTsQtefuysUjE1Bj7xy8U2Fcz3tRdvT9QLrVIOkOmeRqGyHaG0
         EH/w5eGtLe5Eqi+hbFAYjhpHsun5RzDm6j2cXCRt6BKSUkFrYKkqY8e70Vol7glV8sm5
         Km4g==
X-Gm-Message-State: AOJu0YyCqEp9x5HSzy3kWAfJYgDktOVkm6Upfa9kYe/oc+7om9LQetF+
	O+60rmES6a1yikLP9Nka9kMSvtl0fCebzhndgistk+1f/RqzLyejtQs8dtcuWyfjcxuCe+wbnxg
	r/4Z0Gcf8jdHaLss42sXZjHycVt86Wp7mqUG4agTnqLtpg55gea1DVhNZsVlNUNY50g/v/A==
X-Gm-Gg: AfdE7clAcd22JkRWSgmy86sWuzmimQdG9I0eNqsiwGWYfhsn0QjBLfmZAZGmQCQV4GV
	EPW1RTQsNvh4kQGoo9LkpRF8Te9aN3g4N+O8POfRLlWqW//NDtz9m8pTL8IfUc4xkbQGoOieRdl
	P7yq4ZKLf2EDLtp7462CTUAaVkfGOW121z1utu/Exfzob1qnVsZmxxJPAdju5Ir51MpTCUwln1I
	7yGy1nSZx7DFrViypaR+aLXJXAIVk16jEHE884EqoZt3g0eT2U+MYjt5CLj0keD2fNR5QrSOIMH
	NBfTWKtEfIP03qQcWZVyVHbbo1pJUwgUEJkXbTT9GInKsD89hwbZDlfichPYeSDYUEEsQQpF6NU
	zamWCO7/YCtv857LGgl9FEdnjwxEl1MJPpnSmIxdiHSZs7w==
X-Received: by 2002:a05:6000:29d4:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47aac4ecba2mr7434551f8f.16.1783334571394;
        Mon, 06 Jul 2026 03:42:51 -0700 (PDT)
X-Received: by 2002:a05:6000:29d4:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47aac4ecba2mr7434389f8f.16.1783334569341;
        Mon, 06 Jul 2026 03:42:49 -0700 (PDT)
Received: from [192.168.0.135] (185-219-167-205-static.vivo.cz. [185.219.167.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa0960634sm25043705f8f.26.2026.07.06.03.42.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jul 2026 03:42:48 -0700 (PDT)
Message-ID: <e7166e48-ecc1-4dca-af30-07db75199a4c@redhat.com>
Date: Mon, 6 Jul 2026 12:42:47 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] perf trace: Factor out BPF loop body
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>, James Clark
 <james.clark@linaro.org>, Howard Chu <howardchu95@gmail.com>,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Michael Petlan <mpetlan@redhat.com>, stable@vger.kernel.org
References: <cover.1783070132.git.vmalik@redhat.com>
 <20fc67aa2550ca5aff52b3a9a207f2e07f8e0b1d.1783070132.git.vmalik@redhat.com>
 <akhKbOtiracJKkBU@google.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <akhKbOtiracJKkBU@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/4/26 01:49, Namhyung Kim wrote:
> Hello,
> 
> On Fri, Jul 03, 2026 at 12:32:14PM +0200, Viktor Malik wrote:
>> The BPF program in augmented_raw_syscalls uses a for loop to iterate all
>> syscall arguments. The loop body is quite complex and often poses
>> problems for the BPF verifier. As a preparation step for addressing this
>> issue, factor out the loop body into a separate function.
>>
>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>> Cc: stable@vger.kernel.org
>> ---
>>  .../bpf_skel/augmented_raw_syscalls.bpf.c     | 127 ++++++++++--------
>>  1 file changed, 72 insertions(+), 55 deletions(-)
>>
>> diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> index 2a6e61864ee0..cbdd5ce19a2f 100644
>> --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
>> @@ -429,15 +429,79 @@ static bool pid_filter__has(struct pids_filtered *pids, pid_t pid)
>>  	return bpf_map_lookup_elem(pids, &pid) != NULL;
>>  }
>>  
>> +/*
>> + * Determine what type of argument and how many bytes to read from user space, using the
>> + * value in the beauty_map. This is the relation of parameter type and its corresponding
>> + * value in the beauty map, and how many bytes we read eventually:
>> + *
>> + * string: 1			      -> size of string
>> + * struct: size of struct	      -> size of struct
>> + * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>> + */
>> +static inline int augment_arg(struct syscall_enter_args *args, int i,
>> +			      unsigned int *beauty_map, void *payload_offset)
> 
> Can we make it 'struct augmented_arg *payload_offset' instead?

Sure, good idea, that will allow to drop a few casts from the function
body.

Viktor

> 
> Thanks,
> Namhyung
> 
> 
>> +{
>> +	int index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +	s64 aug_size, size;
>> +	bool augmented;
>> +	void *arg;
>> +
>> +	arg = (void *)args->args[i];
>> +	augmented = false;
>> +	size = beauty_map[i];
>> +	aug_size = size; /* size of the augmented data read from user space */
>> +
>> +	if (size == 0 || arg == NULL)
>> +		return 0;
>> +
>> +	if (size == 1) { /* string */
>> +		aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>> +		/* minimum of 0 to pass the verifier */
>> +		if (aug_size < 0)
>> +			aug_size = 0;
>> +
>> +		augmented = true;
>> +	} else if (size > 0 && size <= value_size) { /* struct */
>> +		if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>> +			augmented = true;
>> +	} else if ((int)size < 0 && size >= -6) { /* buffer */
>> +		index = -(size + 1);
>> +		barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>> +		index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> +		aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> +
>> +		if (aug_size > 0) {
>> +			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>> +				augmented = true;
>> +		}
>> +	}
>> +
>> +	/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>> +	if (aug_size > value_size)
>> +		aug_size = value_size;
>> +
>> +	/* write data to payload */
>> +	if (augmented) {
>> +		int written = offsetof(struct augmented_arg, value) + aug_size;
>> +
>> +		if (written < 0 || written > sizeof(struct augmented_arg))
>> +			return -1;
>> +
>> +		((struct augmented_arg *)payload_offset)->size = aug_size;
>> +		return written;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>>  static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  {
>> -	bool augmented, do_output = false;
>> -	int zero = 0, index, value_size = sizeof(struct augmented_arg) - offsetof(struct augmented_arg, value);
>> +	bool do_output = false;
>> +	int zero = 0, written;
>>  	u64 output = 0; /* has to be u64, otherwise it won't pass the verifier */
>> -	s64 aug_size, size;
>>  	unsigned int nr, *beauty_map;
>>  	struct beauty_payload_enter *payload;
>> -	void *arg, *payload_offset;
>> +	void *payload_offset;
>>  
>>  	/* fall back to do predefined tail call */
>>  	if (args == NULL)
>> @@ -457,58 +521,11 @@ static int augment_sys_enter(void *ctx, struct syscall_enter_args *args)
>>  	/* copy the sys_enter header, which has the syscall_nr */
>>  	__builtin_memcpy(&payload->args, args, sizeof(struct syscall_enter_args));
>>  
>> -	/*
>> -	 * Determine what type of argument and how many bytes to read from user space, using the
>> -	 * value in the beauty_map. This is the relation of parameter type and its corresponding
>> -	 * value in the beauty map, and how many bytes we read eventually:
>> -	 *
>> -	 * string: 1			      -> size of string
>> -	 * struct: size of struct	      -> size of struct
>> -	 * buffer: -1 * (index of paired len) -> value of paired len (maximum: TRACE_AUG_MAX_BUF)
>> -	 */
>>  	for (int i = 0; i < 6; i++) {
>> -		arg = (void *)args->args[i];
>> -		augmented = false;
>> -		size = beauty_map[i];
>> -		aug_size = size; /* size of the augmented data read from user space */
>> -
>> -		if (size == 0 || arg == NULL)
>> -			continue;
>> -
>> -		if (size == 1) { /* string */
>> -			aug_size = bpf_probe_read_user_str(((struct augmented_arg *)payload_offset)->value, value_size, arg);
>> -			/* minimum of 0 to pass the verifier */
>> -			if (aug_size < 0)
>> -				aug_size = 0;
>> -
>> -			augmented = true;
>> -		} else if (size > 0 && size <= value_size) { /* struct */
>> -			if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, size, arg))
>> -				augmented = true;
>> -		} else if ((int)size < 0 && size >= -6) { /* buffer */
>> -			index = -(size + 1);
>> -			barrier_var(index); // Prevent clang (noticed with v18) from removing the &= 7 trick.
>> -			index &= 7;	    // Satisfy the bounds checking with the verifier in some kernels.
>> -			aug_size = args->args[index] > TRACE_AUG_MAX_BUF ? TRACE_AUG_MAX_BUF : args->args[index];
>> -
>> -			if (aug_size > 0) {
>> -				if (!bpf_probe_read_user(((struct augmented_arg *)payload_offset)->value, aug_size, arg))
>> -					augmented = true;
>> -			}
>> -		}
>> -
>> -		/* Augmented data size is limited to sizeof(augmented_arg->unnamed union with value field) */
>> -		if (aug_size > value_size)
>> -			aug_size = value_size;
>> -
>> -		/* write data to payload */
>> -		if (augmented) {
>> -			int written = offsetof(struct augmented_arg, value) + aug_size;
>> -
>> -			if (written < 0 || written > sizeof(struct augmented_arg))
>> -				return 1;
>> -
>> -			((struct augmented_arg *)payload_offset)->size = aug_size;
>> +		written = augment_arg(args, i, beauty_map, payload_offset);
>> +		if (written < 0)
>> +			return 1;
>> +		if (written > 0) {
>>  			output += written;
>>  			payload_offset += written;
>>  			do_output = true;
>> -- 
>> 2.54.0
>>
> 

