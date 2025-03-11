Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647C22B5B1
	for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 09:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686887; cv=none; b=b8opLo4yx5ojtR9ZOlZAshSXvwORj91NoYHUcTixVYxhT9/XoBs1q6mcz/DdcsKAuq5A9qAo/FNUUl2kGJyQmbKNC4Bd5LGe9GM6D218waRH7MoIhKcPuwKvlXmPM8XqGjed/Ra8H37dXcBskOBofhG13idYOEGSVa02VyRExL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686887; c=relaxed/simple;
	bh=YJ8aN/wvJALxLucsLU6pRlaFqpDABklnil0F7VecPHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tuw4aAxMFFD7K2nMafbrby9PwddEQS9lBJ/kiiJdGn8emrrhj+Lc61mXsGP4VBRSeuGIKdBUdnQ3Eg5RJxNenLjjLW22u8yKW1xxP51DyBMstt+pVnmG7Bs44jbsXJWWzJpR5098eEAv5fFlLY4aEiUMkvpDpqT5lMXTJZ0/VPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LtFRpUjO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LtFRpUjO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741686885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=bn7ocXts0Kxe+IQiLbHVIiui5+EmHdYjljF85vWvYgI=;
	b=LtFRpUjOTBDlvCk+kxtTccypU+t1XNI73TnhXQlpSJVdkF3M4l5aYkk6Jijno8tvzA3B8o
	ST9LxgmLqEpCAb6FpxXWHIYn5z2X/qGg9oYg8ZHpFzLQTjw3+0TB2Vd2RPBly1c/5xap3q
	DapfSvqyeC6yEPLln8JA9FIgESO784Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-IDp8AwyqPZe_Fid1W7w_Tg-1; Tue, 11 Mar 2025 05:54:43 -0400
X-MC-Unique: IDp8AwyqPZe_Fid1W7w_Tg-1
X-Mimecast-MFC-AGG-ID: IDp8AwyqPZe_Fid1W7w_Tg_1741686882
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913aaf1e32so2104803f8f.0
        for <linux-perf-users@vger.kernel.org>; Tue, 11 Mar 2025 02:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741686882; x=1742291682;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bn7ocXts0Kxe+IQiLbHVIiui5+EmHdYjljF85vWvYgI=;
        b=kcOinO7mGSSNNtJdyO+7TS24MGAkfQzfh5wzLCuyt9A2iox8R9ZBjxSCG7+K9JUDzI
         0T343j+q8YHwfo6B4KWzdabl1A2u8F+3LjlTK81lr1lnpQmVEahgx7M1PpZ+bmnzG+M+
         NJ3xpw3Xx77Uy5bOeOUi1pGsMbbnlyDiiMYsUuV1BYpGIjInZlfr9zGpOpB5PWQkHAH0
         iAYMraozywcXJR+J1lpDtO1tTg5cv3LW2DoVBAA1F/d8vlMa+4JgyZeKkeSyFPpALvH/
         XbTqaM2dseNAeakQTPMl/xF4j0KfHH9n3IQoZgBLHyCuo1rLrEtjG2oZI8lY+DGQK1C/
         WGdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX5D+nOp++ZMT7k9ZynhfgCewOeR2yt9G+rN3VVZj8RTDH1Es+r6X4rz1g13YIj75KWloqJ0fdkt8O0nZjUXHOm@vger.kernel.org
X-Gm-Message-State: AOJu0YyvqxRHeXFbrnql9EoUw0PPcZCX8XO2nscELNGVzB2igbGq0QiO
	tWeo6kwve8giaFXYhhPYe+7wsTjRyfnbLIBHj8vMUcagEqvbp17t1Ei8VMZ5P3YaXWi7h6z6kb2
	SYV/s69d3b/kCK/VKqBR9l0phkaNAaSFpbgaUn1VjcUiqHGIZL7S/heSfE6l++7GlbQw=
X-Gm-Gg: ASbGnctcRqTohzk11AX/gyh0rKk1ADJYH3jtKxOM56ii/XwycUo1UPMZlwvpmwPG9mX
	8XbRZbawPkaSk8J00LC/qmoDciR6/BI34JAAPt1lKw8Fej/6w6l5ePmZEIoK9CbU1BRFH9KZPf3
	KxXoGLr9XVatVNR75kze0oPwarUPWMc68RCbicYNM+dqPHffJ8JmHYgjkihZBYPLDbcxkQXsB8U
	2I2AdOID87w1Y5SD64NY7px98/6tx/8yrbK4vP0NzJqDbiM7osVFiOrkxha3IqLkUlAOHKbpSbL
	EcA+2EFEpezAcH2BJNTb38hzKB6jsfvtMvbcRbZZByy9nUyDhSfrRGsqMMkTcW9zgSnZXr8X1YM
	xRsdDgeax6B/0sI4obWuu3C/alq5LV/pPHXU3MrOOM9M=
X-Received: by 2002:a5d:6482:0:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-39132d2affemr11212128f8f.7.1741686882510;
        Tue, 11 Mar 2025 02:54:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZsoCOeCpGWewJyrTb/pLcsLHd5HyuNZ3aD7JZcjRg8ADFwmVZNT4u9IuiZpVVAYSVvnmFrA==
X-Received: by 2002:a5d:6482:0:b0:385:fc70:7f6 with SMTP id ffacd0b85a97d-39132d2affemr11212099f8f.7.1741686882020;
        Tue, 11 Mar 2025 02:54:42 -0700 (PDT)
Received: from ?IPV6:2003:cb:c720:ed00:a9b3:5954:823e:3427? (p200300cbc720ed00a9b35954823e3427.dip0.t-ipconnect.de. [2003:cb:c720:ed00:a9b3:5954:823e:3427])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e4065sm17854719f8f.62.2025.03.11.02.54.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 02:54:41 -0700 (PDT)
Message-ID: <79ec5aa9-1937-436e-8cf4-436746142f7b@redhat.com>
Date: Tue, 11 Mar 2025 10:54:40 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v1 3/3] kernel/events/uprobes: uprobe_write_opcode()
 rewrite
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Russell King <linux@armlinux.org.uk>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Liang, Kan" <kan.liang@linux.intel.com>,
 Tong Tiangen <tongtiangen@huawei.com>
References: <20250304154846.1937958-1-david@redhat.com>
 <20250304154846.1937958-4-david@redhat.com>
 <20250310170320.GC26382@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250310170320.GC26382@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.03.25 18:03, Oleg Nesterov wrote:
> On 03/04, David Hildenbrand wrote:
>>
>> uprobe_write_opcode() does some pretty low-level things that really, it
>> shouldn't be doing:
> 
> Agreed. Thanks again for doing this.
> 
> David, as I said, I can't review. I don't understand this mm/folio magic
> with or without your changes.
> 

No worries! Thanks for taking a look!

> However. With your changes the code looks "better" and more understandable
> to me. So I'd vote for your patches even if I can't ack them.
> 
> But I'd like to ask some stupid (no, really) questions.
> __uprobe_write_opcode() does:
> 
> 	/* We're done if we don't find an anonymous folio when unregistering. */
> 	if (!folio_test_anon(folio))
> 		return is_register ? -EFAULT : 0;
> 
> Yes, but we do not expect !folio_test_anon() if register == true, right?
 > See also below.>
> 	/* Verify that the page content is still as expected. */
> 	if (verify_opcode(fw->page, opcode_vaddr, &opcode) <= 0) {
> 		set_pte_at(vma->vm_mm, vaddr, fw->ptep, fw->pte);
> 		return -EAGAIN;
> 	}
> 
> The caller, uprobe_write_opcode(), has already called verify_opcode(),
> why do we need to re-check?

Regarding both questions, the code is fairly racy. Nothing would stop 
user space from (a) modifying that memory (b) zapping the anon page 
using MADV_DONTNEED (if we don't hold the mmap lock in write mode).

Regarding the latter, uprobe_write_opcode() is documented to: "Called 
with mm->mmap_lock held for read or write.".

Note that both checks are fairly cheap.

> 
> But whatever reason we have. Can we change uprobe_write_opcode() to
> "delay" put_page() and instead of

I was debating with myself whether we should do that and went back and 
forth a couple of times.

> 
> 	/* Walk the page tables again, to perform the actual update. */
> 	folio = folio_walk_start(&fw, vma, vaddr, 0);
> 	if (folio) {
> 		ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr,
> 					    opcode);
> 		folio_walk_end(&fw, vma);
> 	} else {
> 		ret = -EAGAIN;
> 	}
> 
> do something like
> 
> 	/* Walk the page tables again, to perform the actual update. */
> 	ret = -EAGAIN;
> 	folio = folio_walk_start(&fw, vma, vaddr, 0);
> 	if (folio) {
> 		if (fw.page == page) {
> 			WARN_ON(is_register && !folio_test_anon(folio));

Yes, that would work (we could leave the WARN_ON in 
__uprobe_write_opcode), but I am not sure if the end result is better 
better. No strong opinion on the details though.

> 			ret = __uprobe_write_opcode(vma, &fw, folio, opcode_vaddr,
> 					            opcode);
> 		}
> 		folio_walk_end(&fw, vma);
> 	}
> 
> ?
> 
> Once again, I am not trying to review. I am trying to understand the
> basics of your code.

Any feedback is welcome, thanks!

-- 
Cheers,

David / dhildenb

