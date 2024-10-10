Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BE61C9DFD;
	Thu, 10 Oct 2024 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548537; cv=none; b=ESe/s+IDSUVIxNYhK3zwd9tlGPdjVJBzKe15KyaL8r0DEqd1C2OCWjHtq6xYik6smvVzKXQC3W/fgm7iIfn7+7dgNE6863hS5F7PPUefTmgwBQ8+EtU0D/+NJVT9ik2zdlG4FDWvUybFsKq67bXxEHvnbdeMZyOUgJvaNHDbtH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548537; c=relaxed/simple;
	bh=tizj/2ON0s8hivUUQyCrgL1oJjcxmvgQm6TBf2uFKgg=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=CS+RLspYmkEKHLDwT6YP/PSHB1XYHSIBnEseu7ED9oEhC9QiXSafypG3qVgQa5VlspxS7ZQ7Y745f2JSDn4/oROiOfIZZQy/mvjvJVmL1TgGZgqnjh8y3hKyHZAqpdXy7bHsTywIr1wK//jtlEQAJJTa2FYW3BgsICtxlmfcqiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a997736106fso82585266b.3;
        Thu, 10 Oct 2024 01:22:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728548534; x=1729153334;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvlJr187G3JHxibK82yYw/9HPt95/oKgkf6mzoCItII=;
        b=SQmGsrjGlebx7YjnVNYCwgklQUzIMISnSHTOGWdJQzop9X1p5hhENu5lZ1YKQCkJYS
         Laxcqydf7WglNF6cAGgZJLz2ChCbGeqEaVh2PjNASHjFjxfseQgdBqzLtaFf2tC+wzrt
         xZsPCO1BullqV6S+fMEoq100X6/jZ5K/TVDDeLYbmxz36H9TjnTbPbuBUmpnOTBFLW1L
         ph4wRa013aEEXEKM+G2lKJilFCpp4PMiHX+IvT6mYIea3jfPfu42YlighVEwRfo87WgM
         uin/vjNDGB9Xu5NV/LSUsLiNTSG0z0I2cZ1pKzC9BM9d81ZG1s1dIsXtz+C6IJ+/U/gi
         V4yA==
X-Forwarded-Encrypted: i=1; AJvYcCWYWdFAb7sjTSsn90XV4rdiPQFp5FPbkO4LHU9EE5QFgNvdJgik776Tdjff+p7tXVcK7x4xLISQ7Pafn9RE2d8JTw==@vger.kernel.org, AJvYcCWpsIGfuyLiaQX6BBiqn+zb/r9tebvZrhgT+c4UkePAKo7uljsaFCnuemFdgVihLGrbN5PElHSPWr9r8f4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWZuylN9o6yX67BqsQ9ACxNdx69iU6cfCbHtVt2iraacMH00/E
	Mo5ajo4tgs/iLpROvuzARN5cPaAxAS3waRuPiI7VS8HlNoRDjXpg
X-Google-Smtp-Source: AGHT+IHiN3Gv42KEmUmKtHPqHQ5zgyczqeId97dSe11yacg9/6ze108x42KbMIGZ1hck+90SND4WlA==
X-Received: by 2002:a17:907:3e23:b0:a8d:2faf:d33d with SMTP id a640c23a62f3a-a998d10b6bcmr508633266b.9.1728548533917;
        Thu, 10 Oct 2024 01:22:13 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99a80f73acsm52270266b.224.2024.10.10.01.22.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 01:22:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------AXkDSbexvJUHvnO4YYt3tSde"
Message-ID: <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
Date: Thu, 10 Oct 2024 10:22:12 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
To: Howard Chu <howardchu95@gmail.com>, Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <20240705132059.853205-1-howardchu95@gmail.com>
 <20240705132059.853205-2-howardchu95@gmail.com>
 <6fe63fa3-6c63-4b75-ac09-884d26f6fb95@kernel.org> <ZtJWEVn8-w07Wm0q@x1>
 <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org> <ZtYJ0z8f-1jwYSbV@x1>
 <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
Content-Language: en-US
From: Jiri Slaby <jirislaby@kernel.org>
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>

This is a multi-part message in MIME format.
--------------AXkDSbexvJUHvnO4YYt3tSde
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09. 10. 24, 8:58, Howard Chu wrote:
> If Namhyung's fix alone does not solve the problem please try this:

Hi,

it obviously did not. But this one indeed does.

> --- a/tools/perf/util/syscalltbl.c
> +++ b/tools/perf/util/syscalltbl.c
> @@ -46,6 +46,11 @@ static const char *const *syscalltbl_native =
> syscalltbl_mips_n64;
>   #include <asm/syscalls.c>
>   const int syscalltbl_native_max_id = SYSCALLTBL_LOONGARCH_MAX_ID;
>   static const char *const *syscalltbl_native = syscalltbl_loongarch;
> +#else
> +const int syscalltbl_native_max_id = 1;

This ^^^ should be 0 IMO. Look:
         for (i = 0; i <= syscalltbl_native_max_id; ++i)
                 if (syscalltbl_native[i])
                         ++nr_entries;

> +static const char *const syscalltbl_native[] = {
> +       [0] = "unknown",
> +};
>   #endif
> 
>   struct syscall {
> @@ -182,6 +187,11 @@ int syscalltbl__id(struct syscalltbl *tbl, const
> char *name)
>           return audit_name_to_syscall(name, tbl->audit_machine);
>   }
> 
> +int syscalltbl__id_at_idx(struct syscalltbl *tbl __maybe_unused, int idx)
> +{
> +        return idx;
> +}

This looks somewhat familiar :):
https://lore.kernel.org/all/739001a4-4df1-4dec-a141-926c78c5c07e@kernel.org/

I am attaching an updated patch.

thanks,
-- 
js
suse labs

--------------AXkDSbexvJUHvnO4YYt3tSde
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-perf-fix-non-listed-archs.patch"
Content-Disposition: attachment;
 filename="0001-perf-fix-non-listed-archs.patch"
Content-Transfer-Encoding: base64

RnJvbSAzZDRmMDZkNzljOTQ5YThmMTU1YzIwNjUyYjRmNjg1NTQwODk5YWQ0IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBKaXJpIFNsYWJ5IDxqc2xhYnlAc3VzZS5jej4KRGF0
ZTogVGh1LCAxMCBPY3QgMjAyNCAwOTo1NzowNyArMDIwMApTdWJqZWN0OiBbUEFUQ0hdIHBl
cmY6IGZpeCBub24tbGlzdGVkIGFyY2hzCgpTdWdnZXN0ZWQtYnk6IEhvd2FyZCBDaHUgPGhv
d2FyZGNodTk1QGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogSmlyaSBTbGFieSA8anNsYWJ5
QHN1c2UuY3o+Ci0tLQogdG9vbHMvcGVyZi91dGlsL3N5c2NhbGx0YmwuYyB8IDEwICsrKysr
KysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEv
dG9vbHMvcGVyZi91dGlsL3N5c2NhbGx0YmwuYyBiL3Rvb2xzL3BlcmYvdXRpbC9zeXNjYWxs
dGJsLmMKaW5kZXggN2MxNWRlYzY5MDBkLi42YzQ1ZGVkOTIyYjYgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3BlcmYvdXRpbC9zeXNjYWxsdGJsLmMKKysrIGIvdG9vbHMvcGVyZi91dGlsL3N5c2Nh
bGx0YmwuYwpAQCAtNDYsNiArNDYsMTEgQEAgc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0ICpz
eXNjYWxsdGJsX25hdGl2ZSA9IHN5c2NhbGx0YmxfbWlwc19uNjQ7CiAjaW5jbHVkZSA8YXNt
L3N5c2NhbGxzLmM+CiBjb25zdCBpbnQgc3lzY2FsbHRibF9uYXRpdmVfbWF4X2lkID0gU1lT
Q0FMTFRCTF9MT09OR0FSQ0hfTUFYX0lEOwogc3RhdGljIGNvbnN0IGNoYXIgKmNvbnN0ICpz
eXNjYWxsdGJsX25hdGl2ZSA9IHN5c2NhbGx0YmxfbG9vbmdhcmNoOworI2Vsc2UKK2NvbnN0
IGludCBzeXNjYWxsdGJsX25hdGl2ZV9tYXhfaWQgPSAwOworc3RhdGljIGNvbnN0IGNoYXIg
KmNvbnN0IHN5c2NhbGx0YmxfbmF0aXZlW10gPSB7CisJWzBdID0gInVua25vd24iLAorfTsK
ICNlbmRpZgogCiBzdHJ1Y3Qgc3lzY2FsbCB7CkBAIC0xODIsNiArMTg3LDExIEBAIGludCBz
eXNjYWxsdGJsX19pZChzdHJ1Y3Qgc3lzY2FsbHRibCAqdGJsLCBjb25zdCBjaGFyICpuYW1l
KQogCXJldHVybiBhdWRpdF9uYW1lX3RvX3N5c2NhbGwobmFtZSwgdGJsLT5hdWRpdF9tYWNo
aW5lKTsKIH0KIAoraW50IHN5c2NhbGx0YmxfX2lkX2F0X2lkeChzdHJ1Y3Qgc3lzY2FsbHRi
bCAqdGJsIF9fbWF5YmVfdW51c2VkLCBpbnQgaWR4KQoreworCXJldHVybiBpZHg7Cit9CisK
IGludCBzeXNjYWxsdGJsX19zdHJnbG9ibWF0Y2hfbmV4dChzdHJ1Y3Qgc3lzY2FsbHRibCAq
dGJsIF9fbWF5YmVfdW51c2VkLAogCQkJCSAgY29uc3QgY2hhciAqc3lzY2FsbF9nbG9iIF9f
bWF5YmVfdW51c2VkLCBpbnQgKmlkeCBfX21heWJlX3VudXNlZCkKIHsKLS0gCjIuNDYuMQoK


--------------AXkDSbexvJUHvnO4YYt3tSde--
