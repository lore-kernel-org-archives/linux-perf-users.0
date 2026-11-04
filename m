Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804848;
	b=0g0QGCozfRgUhc46X7s3zI3HFOgEcNu4uUMy9xGrWjot2XvC/bXTA6JeexiDINff/NOQ
	 qeY57Ac4IL34q0KsKQzyBMAFTiiVbumoQp9UOfMkyLRsXmJDaZq2oyTpOaJHoHFOBrN8b
	 aIE/OUoQX3WmvyOvvdYpV/zqnYJv3+ft4zkzSYebo0EzksukBH6lw3P8SUzIaeYVhtSKC
	 V/xetGDzxoXXkgGR6aqT32ywZmXqtgzssSCPEtSY7pPzA6+U7LuBt/TOk7sxRQcvo8Fi8
	 6JYQyhBiJi5CoPvkd5VJqaRON0Gfq8NC+DF2WBTNpiDIgqYeU+i3xIzJnyZ9Uv9ozuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=7VYDYvW+CwD5vPnIuKuoUcZjw7zRDhgYDMBwsljH6Ms=;
	b=379t8shoN1OF1zKRldaZT4PjFA0a3wZONiVdDqH016GnOD2Sj12V2mOVUPDftT7ozIP4
	 aXy/033EXAAozxC7Sz7XYEsxqhWn27m3lBh1jUM65V7zXTNFqDoWW4Q7LJGEUHFnmxsg8
	 OFibCJRFL+Ia+ewuQZxwRohpzf3n9c2+gCOXlSl5ryN4FhqX27r2t7gH+gYxKxOzDLBuI
	 KWubSSOcYI90dcJ5qorfeE6JhAKdQ+tSwwyo526W5qlF/DYB23t5ipz8NW5g7hhfW6anb
	 twmLMPevMDBmfKmiGu8FOyJvk7hODge3D0k5SO97ouk3HxceG8cLNqR1w3zNK/3vxZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b="jlxkiNU/";
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3D3606A31B
	for <linux-perf-users@vger.kernel.org>; Wed,  4 Nov 2026 15:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE3D3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=jlxkiNU/
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a35a60499eso6607575e9.0
        for <linux-perf-users@vger.kernel.org>; Wed, 04 Nov 2026 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793804846; x=1794409646; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VYDYvW+CwD5vPnIuKuoUcZjw7zRDhgYDMBwsljH6Ms=;
        b=jlxkiNU/T0Zd5J2F9Ggyrr4UPnXYE2bQTFUXDcXUhkbRHBk9znBH/5ubAJFDrxWULG
         TL/JIVyc5cZWf58ZGwf3rnI6Wyn6anIcXxe7EKpBNXqaFi+klUUGxQnRK8BTs3HG1T5E
         dpXNR+/qIeuZNXP90gWFhiUSXKampHon35hGhkfJJR3DhWig6J6SG4VKqtbx6nzTrJwo
         NJ3mluh5vKukjW6Nt8GICrfn3Pu54LH2gbcptr2RgSkCLLhwJHktxf7APMDAEqtW4TST
         ZxjI+g4e//kzPziFJg8ITlHrRrD7hU5sIRE4+jJ+m7ETh4L2DOEpX04/ppr1q0sl0SNS
         gEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793804846; x=1794409646;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7VYDYvW+CwD5vPnIuKuoUcZjw7zRDhgYDMBwsljH6Ms=;
        b=sPKYrf2q3OMk5Lb8wHnzvLvmd/hD290cnYR+6wPL8UjlB+w11T8wx2lucjYC0QdAr7
         flaUVNe828k7nHFaPtFVFgqeM11NxL8XvxL+8KqhLjWiEswt+8IzBNPvUvMawNvrPsD+
         So61+q2jY5/L9+Ji0gy1pi4Fx4ooIRw5Ti5WSin/EPNM5Q46hubx6SZ0LV8E9mkyhX2R
         /OiDh5Y/XyII4MJ2ee1bm4KZgVFWSu7S6DHyrPOkw7mniouLjmqR3gMyvS98T2KrAPXI
         yTeChZIpSgvBqwukPwjpq6/M6uHbyjwXDtTQpRZ3rAEBL7R8ndh37tvPbYRGSrxGy85M
         wdmA==
X-Forwarded-Encrypted: i=1; AKwUvBz/tb5D04sAGDkRkGtNwAZpz6/nSuUi6MXFqwE6lXMmvi5CxL9flCIgId/wOWgeNjiQylLackPEeSjDzA1wbBoz@vger.kernel.org
X-Gm-Message-State: APuU4Z+atCuEPMKycQcveDh/L7SUOr78ZPEYo0HH0ybk4h/gEeCFjLYO
	9KwMGLmcM4o5lTItuUBG76G2CmufgfKrponNu6DfXcjrWcXRTXaU5hb3F+OAnq2SQdA=
X-Gm-Gg: AYBFou17ECXh7bg/Ojg+zadiwX+vlTnCSmmJWBTDEUz3zoiS7GbzEaI6qLsLTiiemIW
	hL9SZg3vMbxc9I6q0/CO/bcaCGOZ4hu76IlY44u2IQoyZYf92iJbaWOx672+VMpSdd57YtoFt4A
	eIUrThF7T1wXksDlIGojdQ1cBWzBydsp904wIFtwP88OeMjh6hiEAdqiiUIqmGQnzO6uaMIP6Ir
	cxsGd4qKn8tIDv5X1URm2OcewxVkaNpd/nOxJTWhMGs6nDA11DmZQXb315LXOV+w2YkwJLGYRLu
	bjBfA3QpoDyEUZUUH0t4a835am6X+V6KBcb+yzlaCrbuGk0X5GR4InVZWv2v6wWpnD1zOffgtie
	HXOj8RyNhioKbTqKQtiMZDKODPTgr4Qe4nH67/zNGW1XAOTvSV03VBxYMJD7PwjL3k9TFUedJUo
	B0DMDnI/Qg3Hnd9Ez3GKPLkl9LR/xKEYkP6+L6WWpJHOgeZMXqXhwK42G2FrVuXsJF+v4OzkT8E
	dIMokn0XXfNcqaNjxQF8HxKJfIvMRfS5Hb5zUgDoEg1C+/zp7Z3oj1HMrMZ5sDIrJR4AFoXVkuE
	GMBMqdf21XglHghWeQhAHmqmHuBJOhSmNXO/kG67iU1mV/avT0qqh1c=
X-Received: by 2002:a05:600c:4e14:b0:4a5:a5ca:de1d with SMTP id 5b1f17b1804b1-4ac187a80bfmr378940895e9.30.1793804846351;
        Wed, 04 Nov 2026 07:07:26 -0800 (PST)
Received: from [192.168.1.3] ([37.18.141.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8648sm4578795f8f.9.2026.11.04.07.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 07:07:25 -0800 (PST)
Message-ID: <54182c51-8dfe-46fa-9369-5e4e31a63796@linaro.org>
Date: Wed, 4 Nov 2026 15:07:24 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/18] perf cs-etm: Use per-CPU queues for per-thread
 mode
To: Leo Yan <leo.yan@arm.com>
Cc: Leo Yan <leo.yan@linux.dev>, Adrian Hunter <adrian.hunter@intel.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach <mike.leach@arm.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Suyash Mahar <smahar@meta.com>, Amir Ayupov <aaupov@fb.com>,
 linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>, linux-doc@vger.kernel.org,
 John Garry <john.garry@linux.dev>
References: <20261102-james-cs-unformatted-per-thread-fix-v3-0-dbcb0c281b9b@linaro.org>
 <20261102-james-cs-unformatted-per-thread-fix-v3-4-dbcb0c281b9b@linaro.org>
 <20261104142412.GI9176@e132581.arm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20261104142412.GI9176@e132581.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/11/2026 14:24, Leo Yan wrote:
> On Mon, Nov 02, 2026 at 12:15:18PM +0000, James Clark wrote:
> 
> [...]
> 
>> @@ -2215,6 +2209,29 @@ static int cs_etm__get_data_block(struct cs_etm_queue *etmq)
>>   	 */
>>   	cs_etm__flush_all_stack(etmq);
>>   
>> +	/*
>> +	 * Per-thread mode still uses a queue for each CPU, but that CPU can run
>> +	 * different threads. When the TID from the AUX record on a CPU changes,
>> +	 * re-initialize the thread using the AUX record/buffer fragment TID so
>> +	 * we can start decoding even if the context ID packet was cropped or
>> +	 * they're disabled.
>> +	 */
>> +	if (etm->per_thread_decoding) {
>> +		struct cs_etm_traceid_queue *tidq = cs_etm__etmq_get_traceid_queue(etmq,
>> +							CS_ETM_PER_THREAD_TRACEID);
>> +
>> +		if (thread__tid(tidq->decode_thread) != etmq->buffer->tid) {
>> +			thread__zput(tidq->frontend_thread);
>> +			thread__zput(tidq->decode_thread);
>> +			tidq->frontend_thread = machine__findnew_thread(
>> +				&etm->session->machines.host, -1,
>> +				etmq->buffer->tid);
>> +			tidq->decode_thread = machine__findnew_thread(
>> +				&etm->session->machines.host, -1,
>> +				etmq->buffer->tid);
>> +		}
>> +	}
> 
> Why not use PERF_RECORD_AUX events as an opportunity to update threads,
> similar to how we handle PERF_RECORD_SWITCH_CPU_WIDE?
> 

In cs_etm__queue_aux_fragment() we check if the TID from the AUX record 
is the same as the one on the buffer, so it doesn't make a difference. 
They're always the same:

		if (auxtrace_event->tid != sample->tid)
			return 1;

We can't use it directly in cs_etm__process_event() because we're not 
decoding in order with Perf events yet. In my WIP JIT patches we do, but 
it still makes sense to continue to use the TID from the buffer because 
you don't always have timestamps available to update threads when the 
AUX event comes.

>> +
>>   	return 1;
>>   }
>>   
>> @@ -3288,7 +3305,9 @@ static int cs_etm__queue_aux_fragment(struct perf_session *session, off_t file_o
>>   
>>   	if (aux_offset >= auxtrace_event->offset &&
>>   	    aux_offset + aux_size <= auxtrace_event->offset + auxtrace_event->size) {
>> -		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, auxtrace_event->cpu);
>> +		/* Old per-thread files have no CPU (before v6.4) */
>> +		int queue_idx = sample->cpu == (u32)-1 ? 0 : sample->cpu;
>> +		struct cs_etm_queue *etmq = cs_etm__get_queue(etm, queue_idx);
> 
> For per-thread mode, auxtrace_event->cpu is -1. So this is why we
> resort sample->cpu to retrieve CPU ID. This makes sense to me.

Yes, and it's only set on AUX records since we started always doing this:

   evsel__set_sample_bit(cs_etm_evsel, CPU);

Otherwise it was -1 there too, hence the condition for old files.

