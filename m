Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1381B19E806;
	Mon, 14 Oct 2024 13:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911167; cv=none; b=H+/lz/kIqoxpysJv+Wu132TdscDYJQlZfQ56PAnnD6BRtqLaf0yAvrlXc0lHnzL4clc+dJVxGnyoJQsIAgMR4691qQzcEnjXTSGfvwGZG5qd8Uik3yxResPJlJj2vLekkXnbBr7d8WW5GAlTeOa7I+EfJJjEK9jE0gXoXAe2s9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911167; c=relaxed/simple;
	bh=5yIE1AXTBtccQw+b33agkVNO7ZB538iyS504JjLMXcY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lK2+yjqi5+S8i2PfzfsymyrYPTfoBxef+5cCQaLiX1+A0PRT/X0XbZq8Xh3+1Qz0+kCfq/ACfx4wi3GBEQ1PRladYRpBjLm4e2NoopO0uiD7IkE+By9MVSFSlX+8AbVDaq1KTvWzr6GbZsbrNyOA9xma4sGwH8WBXNMYVr6OYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so3343124f8f.3;
        Mon, 14 Oct 2024 06:06:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728911164; x=1729515964;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arN2EaeGbfyQzTtje2PaOTjOburdceclvq3hXPjtlHw=;
        b=kzVLSJOlH7byGvjrHI06MVCebsBp2Rb1bs2pGH+Xm1gVL4UCuLLFB5rImdeCwcA00U
         P27ai4q2z1tldkxWP5Z3x1hwaNmyCBGFn6T8+jiweaA7idf4kR1Dz3BPZ9pYoCOwt85A
         X9t2W5nBL0JWJoJRVTVSaV5pkcr49Zg83sTUrjcfSWquxZeMW6GpElbxNxVJE8KbWViE
         8rP4NgUr2zDbgHbDAjelP11Eiz6HuA8HrANzhYMZn21lO510jxro4Ee5oUE5dVkC4gn/
         3+SNlxDrBWYbwgPiTSGnnmzjpO4D+ApDb7/FY8VkYjPlTHQkEaQDJJZDpG5y4IwS7qMr
         yo8g==
X-Forwarded-Encrypted: i=1; AJvYcCVMu1fS/UZN8iVGLaq2fXfGZ7B1LrOq5UXXsfIvdIqW5P3c4PB+cADfNP6/+cpcSCFDnF1KHd5SgVhpWdzBohLbYw==@vger.kernel.org, AJvYcCW+YmqGx9WmKKsn23beoZLJzsaPGAn3qDMq7PtS5A9+YaiDFvtuVxcgzgZZ6aoAjgaRPpVwcwDfc74EoK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXaZ6K03OrjHkDE7BUc6NUGf0RZikf9PbGMMe2+q9MFc1Oz8IJ
	VoMVHT0PzxE7I5Mv+mDP7+h1zJKfXXIOxzMVHVU0Pwky08zRViF5
X-Google-Smtp-Source: AGHT+IFslGH1lFnLmbVAguvq3NPJ2Hq/naL7JW5Qulsjtxs4o1vYcbMFGHXyrS8up5WDYkXYYuvR7w==
X-Received: by 2002:adf:f483:0:b0:37c:d2e3:1298 with SMTP id ffacd0b85a97d-37d601eea06mr6796782f8f.55.1728911164250;
        Mon, 14 Oct 2024 06:06:04 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:69? ([2a0b:e7c0:0:107::aaaa:69])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6a8911sm11289688f8f.14.2024.10.14.06.06.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 06:06:03 -0700 (PDT)
Message-ID: <1b96ef59-3b25-4c16-b3ee-cb4c7432afc0@kernel.org>
Date: Mon, 14 Oct 2024 15:06:02 +0200
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFT] Re: [PATCH v5 1/8] perf trace: Fix iteration of
 syscall ids in syscalltbl->entries
From: Jiri Slaby <jirislaby@kernel.org>
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Howard Chu <howardchu95@gmail.com>,
 Adrian Hunter <adrian.hunter@intel.com>, Ian Rogers <irogers@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Kan Liang <kan.liang@intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
References: <0f841525-e02a-4e11-b5f8-1acc61979ccf@kernel.org>
 <ZtYJ0z8f-1jwYSbV@x1> <c279ad02-2543-4a95-9404-9304e1e704da@kernel.org>
 <ffc2eb09-ac78-4594-a376-3fff9918c2a7@kernel.org>
 <ZwYbQswnGHSstClc@google.com>
 <CAH0uvoi622J7gZ9BoTik7niNH3axVJR0kPNovUQnMjUB6GWLNg@mail.gmail.com>
 <CAH0uvojw5EKqxqETq_H3-5zmjXiK=ew2hBQiPDpCtZmO7=mrKA@mail.gmail.com>
 <3a592835-a14f-40be-8961-c0cee7720a94@kernel.org>
 <ZwgAzde-jVyo4cSu@google.com> <ZwgBenahw7EImQLk@google.com>
 <ZwhA1SL706f60ynd@x1> <2a91f9d0-8950-4936-9776-7ba59ab1d42a@kernel.org>
 <CA+JHD937angqu=48-kPC7LvtMMQPgUGp+2x5b+JKVNoFa3+9HQ@mail.gmail.com>
 <5c2151fc-d7ed-4677-9456-4589f67d5f51@kernel.org>
Content-Language: en-US
Autocrypt: addr=jirislaby@kernel.org; keydata=
 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
In-Reply-To: <5c2151fc-d7ed-4677-9456-4589f67d5f51@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 14. 10. 24, 15:04, Jiri Slaby wrote:
> On 14. 10. 24, 14:43, Arnaldo Carvalho de Melo wrote:
>> And works? :-)
> 
> I cannot tell :P.
> 
>> I need to get access to a 32-bit arm distro that I can use with qemu 
>> or with one of the libre computer arm64 boards I have, can you point 
>> me to one? :-)
> 
> The former might be openSUSE. I have just booted:
> https://download.opensuse.org/ports/armv7hl/tumbleweed/appliances/openSUSE-Tumbleweed-ARM-JeOS-efi.armv7l.raw.xz
> 
> with (when unpacked and aavmf-aarch32-vars.bin copied to /tmp/arm.bin):
> qemu-system-arm -cpu cortex-a15 -M virt -hda 
> /tmp/openSUSE-Tumbleweed-ARM-JeOS-efi.armv7l.raw -nographic -drive 
> if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/qemu/aavmf-aarch32-code.bin -drive if=pflash,format=raw,unit=1,file=/tmp/arm.bin -m 2000

FWIW

login: root
pass: linux

in all openSUSE images.

> thanks,-- 
-- 
js
suse labs

