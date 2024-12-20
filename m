Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1976FC5
	for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734730202; cv=none; b=iAskPaJIs+FnJJVchyF0Jq02/z7qOY0VIg2y2zbZatcXU1SozlRPgTiK6tTy1wxKSNY2h1P0oXPjy6iFXfg/y+b0cxUmhjYNXNMAeIhxW7sk9F+Sa5J/kqG15BpV2oXkjJCfjt0bcyTZ7jgiDU96+tP4BfIxwFRQOLMw7GG+d9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734730202; c=relaxed/simple;
	bh=Gtc4lIbuLuLHuCn9Xws0Z6toxKY6Szn+LaREXmUz0uQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mstbYkPy/wKFX1mMcWqKA8aA5kVWG1u+oUbRuWUehW/6V5CIrIpNhy1CS2fhod5za5z2bHHSIfSsevnUWkWXWIDOAXmuX2dp3bLn9HJBNsM2TkEkAjTvkB5MYFe4B4bHbG7wfTsRXUErQyWGkwzMrFikBgpXJIZMTA7gfip4EDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F3scr1N3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F3scr1N3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734730199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tOqE6OJVrI2bYkbIgkcsidyGm7PTCqWTP1YSUB9oIEQ=;
	b=F3scr1N3TNEmcpFgBESLELHufyTPiIxwci2k7qe+1E1SHOwgAP3fTPR59NOXy7kNsoQQs+
	ytDqkzlBC/OSOSlgn1yzMkNOoGY46n9FewaTiSCmeWWQ1dRwvzYgr4XvdQ8JfkXUfoezbH
	Eg8IFv7sPdrxO7i7elrwoNGND9Y0q7Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-8EmJCkU4NbudqwT6P615FQ-1; Fri, 20 Dec 2024 16:29:58 -0500
X-MC-Unique: 8EmJCkU4NbudqwT6P615FQ-1
X-Mimecast-MFC-AGG-ID: 8EmJCkU4NbudqwT6P615FQ
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43582d49dacso17695845e9.2
        for <linux-perf-users@vger.kernel.org>; Fri, 20 Dec 2024 13:29:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734730197; x=1735334997;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tOqE6OJVrI2bYkbIgkcsidyGm7PTCqWTP1YSUB9oIEQ=;
        b=TCpxxMZcrOSoRMBzuVb7V7+nqZtAh0TxauPP2OZdoGWNFAkZ1oFyCEtotzaoRxVB9R
         B/cTaoFTsL9VlEHg9jrMmqNWOh0nWu4UMTBce0+efZfaU8gQhuJ38til7EoG/DA+xDH0
         gh31+lXeX7ApImFIHXKTGICQhwcIsdMCvJdmNPI4mm1myawj9L6GaxLcVuiTCktV/wIz
         sPUlqlnHlPLeWDDTlrt540iVE3VTr7jmzSTNGQ9DTTkH1mSEYt9RAPbb5uxXzYuwLwqI
         5KPYZrLxCwDYDk9qwdNOAVBU1/O1lOb6KpYBVpkq4sIuH/vB7mKLq8ODJelDANWSVU8W
         qJHA==
X-Forwarded-Encrypted: i=1; AJvYcCUBr94EvFfCZJWsPy7JnI8Zm7l4oId5zHOw3E/s+BUIYFJ+JcxoRL+C+3jLgtLsf3C6LAOHcUW6kcGzwKFqWgXU@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ4ufEjdXzs2dsIJvGWaI2nTfZNXNqReAGVv91W3o2H3WSRU4x
	O6FU2rvKwqfv4Q9tFd8Ivy1AiCQB447KY9L/xH2YpQTTgHDEdP2YeN/fF+XuBl5DtA/O+oq793L
	rnkjJJ5RxTGeN4qRRpwDgV2Zjcu10Nuyvpqw15PNdJBZoFIOjLnH1eHfLwgfftOjHiF8=
X-Gm-Gg: ASbGncv0Ji6r5gs4wl6wGiHZbPRY0D0TrsB6YXsOXblC9Om1jhWjb23nMBNmUHr81Ni
	iXG3j/VdD8nwbxzsSLBhh0+TTKyvahsv8j57pEEQ4KOWC4H1dwA8R2o8FXD6hbdGLEkVMhWskDA
	S+FNLf+IjpFVO8R1xj9Cv8TJ9QH4NepU2+Z+qiNdUthvvI7BTk3TkmMIh+OzopaNDMnMAmHOQXP
	p4WF2Lr2l5Sg8turu5olzcpTc4HRJalSLf4CTYwHbCfEFv4YWQa5Ea3DD+0WpjII8Fuq9t1IjxW
	KN+KiiMMxXEwjbbtBtlSo4R6SBTx6oyjZzNewLSXo96k+Xghh5r6kpD0Gu6Eu9X8yc3JYSb0vjq
	glnvJwqSh
X-Received: by 2002:a05:600c:3505:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-43668643c0bmr39804415e9.8.1734730196816;
        Fri, 20 Dec 2024 13:29:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3cu1LhhlJBfA/+g7XT1+YNXFBaPRUSzANepQB8qbzFCPF+5u7m/7N07IedlCO9XZ3XHRkfQ==
X-Received: by 2002:a05:600c:3505:b0:431:5df7:b310 with SMTP id 5b1f17b1804b1-43668643c0bmr39804345e9.8.1734730196409;
        Fri, 20 Dec 2024 13:29:56 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:9d00:edd9:835b:4bfb:2ce3? (p200300cbc7089d00edd9835b4bfb2ce3.dip0.t-ipconnect.de. [2003:cb:c708:9d00:edd9:835b:4bfb:2ce3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b119d7sm89515865e9.20.2024.12.20.13.29.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 13:29:55 -0800 (PST)
Message-ID: <ebaa9d2e-c5f3-4a93-9def-caadae92acc6@redhat.com>
Date: Fri, 20 Dec 2024 22:29:53 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] perf: map pages in advance
To: "Chen, Zide" <zide.chen@intel.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Matthew Wilcox <willy@infradead.org>, Yi Lai <yi1.lai@linux.intel.com>
References: <20241205082948.56212-1-lorenzo.stoakes@oracle.com>
 <65a04f0d-668b-47b6-a532-d1e11ef4835a@intel.com>
 <4ded2d63-03dd-498e-9810-690a9eff0c22@lucifer.local>
 <860a1ef0-678d-414d-8511-9695b90c3ca0@redhat.com>
 <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <74fd8a75-66c6-40a8-9ec3-d7aa74469755@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.12.24 20:36, Chen, Zide wrote:
> 
> 
> On 12/20/2024 1:56 AM, David Hildenbrand wrote:
>> On 20.12.24 10:31, Lorenzo Stoakes wrote:
>>> On Thu, Dec 19, 2024 at 01:17:44PM -0800, Chen, Zide wrote:
>>>
>>>> With this patch, it seems perf tool has some problems in capturing the
>>>> kernel data with Intel PT.
>>>>
>>>> Running the following commands, the size of perf.data is very small, and
>>>> perf script can't find any valid records.
>>>>
>>>> perf record -e intel_pt//u -- /bin/ls
>>>> perf script --insn-trace
>>>>
>>>>
>>>
>>> Hi,
>>>
>>> I'm on leave (and should really go back to relaxing :>), returning on 2nd
>>> Jan so can't really dig into this.
>>>
>>> But I tried it on my intel box and it 'works on my machine' with and
>>> without patch with commands provided, so I'm not sure this is actually a
>>> product of this change (which shouldn't impact this).
>>
>> Zide Chen, can you try with and without this patch to see if it
>> introduces the issue?
> 
> Yes, I re-did the test on a SPR server, and the result is same. Without
> the patch, it went well; But with it, "perf script --insn-trace" doesn't
> show valid records.
> 
> This time I tested it on the clean 6.13-rc1 tag, base commit
> 40384c840ea1944d7c5a392e8975ed088ecf0b37
> 
> Also, with this patch, running tools/perf/tests/shell/test_intel_pt.sh:
> 
> Error:
> The - data has no samples!

I just tested it on 6.13-rc1  vs. 6.13-rc1  with this patch.

Indeed, there is quite difference. Below are the main parts that changed, only.

We seem to be recording data, but maybe what we record gets corrupted somehow?


Looks like


Before:

--- Test tracing self-modifying code that uses jitdump ---
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/tmp-perf.data ]
/root/linux/tools/perf/tests/shell
OK
--- Test with MTC and TSC disabled ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.050 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
OK
--- Test with branches disabled ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.012 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
OK
--- Test with/without CYC ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.095 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
OK
--- Test recording with sample mode ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.077 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
Linux
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.006 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
OK
--- Test with kernel trace ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.060 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
OK
--- Test virtual LBR ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.053 MB /tmp/perf-test-intel-pt-sh.pSYRjy9UUy/test-perf.data ]
OK
--- Test power events ---
SKIP: power_event_trace is not supported
--- Test with TNT packets disabled  ---
SKIP: tnt_disable is not supported
--- Test with event_trace ---
SKIP: event_trace is not supported
--- Test with pipe mode ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.075 MB - ]
     14.20%  uname    libc.so.6             [.] _int_malloc
     10.39%  uname    ld-linux-x86-64.so.2  [.] _dl_relocate_object
      9.68%  uname    libc.so.6             [.] __strcmp_evex
      8.04%  uname    libc.so.6             [.] __stpcpy_evex
      7.89%  uname    libc.so.6             [.] __memmove_chk_evex_unaligned_erms
      5.71%  uname    libc.so.6             [.] __memmove_evex_unaligned_erms
      5.68%  uname    ld-linux-x86-64.so.2  [.] __GI___tunables_init
      5.46%  uname    ld-linux-x86-64.so.2  [.] _dl_lookup_symbol_x
      4.95%  uname    libc.so.6             [.] getenv
      4.37%  uname    ld-linux-x86-64.so.2  [.] do_lookup_x
      4.21%  uname    libc.so.6             [.] __strchr_evex
      3.56%  uname    libc.so.6             [.] strlen@plt
      2.71%  uname    libc.so.6             [.] _nl_make_l10nflist.localalias
      2.34%  uname    ld-linux-x86-64.so.2  [.] mprotect
      2.22%  uname    libc.so.6             [.] memchr
      1.82%  uname    libc.so.6             [.] find_module_idx
      1.61%  uname    libc.so.6             [.] _nl_intern_locale_data
      1.55%  uname    ld-linux-x86-64.so.2  [.] __minimal_malloc
      0.98%  uname    ld-linux-x86-64.so.2  [.] _dl_start_user
      0.96%  uname    ld-linux-x86-64.so.2  [.] intel_check_word.constprop.0
      0.61%  uname    ld-linux-x86-64.so.2  [.] check_match
      0.57%  uname    ld-linux-x86-64.so.2  [.] update_active.constprop.0
      0.50%  uname    ld-linux-x86-64.so.2  [.] get_common_cache_info.constprop.0


Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.074 MB - ]
OK
--- Cleaning up ---
--- Done ---



After:

--- Test tracing self-modifying code that uses jitdump ---
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.019 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/tmp-perf.data ]
/root/linux/tools/perf/tests/shell
Decode failed, only 0 branches
--- Test with MTC and TSC disabled ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.051 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
Failed to filter with tsc=0
--- Test with branches disabled ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.013 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
Failed to disable branches
--- Test with/without CYC ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.097 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
Still get CYC packet without cyc
--- Test recording with sample mode ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.076 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
Linux
[ perf record: Woken up 3 times to write data ]
[ perf record: Captured and wrote 0.006 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
OK
--- Test with kernel trace ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.061 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
OK
--- Test virtual LBR ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.054 MB /tmp/perf-test-intel-pt-sh.SvCUtQzSAe/test-perf.data ]
OK
--- Test power events ---
SKIP: power_event_trace is not supported
--- Test with TNT packets disabled  ---
SKIP: tnt_disable is not supported
--- Test with event_trace ---
SKIP: event_trace is not supported
--- Test with pipe mode ---
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.073 MB - ]
Error:
The - data has no samples!
Linux
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.077 MB - ]
OK
--- Cleaning up ---
--- Done ---


-- 
Cheers,

David / dhildenb

